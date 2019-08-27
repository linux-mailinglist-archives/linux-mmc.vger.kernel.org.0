Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35FD9E147
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfH0IK6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 04:10:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42240 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbfH0IK6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 04:10:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so17573992ljj.9
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3qJR3eEbPiVz2FmPYzrydbvTqAWbk/i6kmfbf4e8EHY=;
        b=H+4s7dvOeTvfYb55PRAH5Y5ZCJygQG/+kqSWkCuD033l49fUNYRFbCDQpudfRST/kq
         3MHjCMIkI4SFayn4WqxvDP9zZ2RN0ND5N62qYl9ZhLpb8LHQGVRUvw5RzKlnMbnedFe3
         PZUBEWOrebrs7Y+Hgl3c8GOD+wPorNsxtKA1fvgaq5CAPexwHdNddc/brDaA3k4Lh9j/
         HSvxbP5ZbDa9s7S+9w26ifrBZZioCaas1MwzR/knXIBBwjTTjsTgFq0Wkc6vCxeK6aH9
         Q/ohGfy0alTHZpjHpBLBuYoe1ZBLTLQYv+eG2JvIwkj4yJ1j4SN418JQtWRPLYyNmuH0
         xIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3qJR3eEbPiVz2FmPYzrydbvTqAWbk/i6kmfbf4e8EHY=;
        b=sbkLLkvhJV9HoQxRXRetISENOawQqjP2Lal/leDs6ID4HDd8D3AfvHElxX4TlgE6It
         VzC/gHYxAaK/e8NECK625IDUDRmpfPTxzPaEbv97KCHSfWWSRwa091yCMz9RqCUYVsww
         XY3Ll0K+qDtaIO8wXm557H+/1C97sCvbZt/ACkS//CtZJOHdjSrwS9LeF/qWpBAUBs/c
         6F1LEpeBj7iKP02CTVFlJdEdF6EiuryiTBrhYnSzbj2gFCROac7NpaDnQnjsJNsy3YzW
         S0LmCU37ZqUHoN+WkH2868jlY0lN8LjSq/YXgE+NliE3+OzX0J+mTLGrmmlywqUHBdZk
         nosQ==
X-Gm-Message-State: APjAAAWLm7A+5kxzoy/klZjRUbzf5FmdgaJ6dWGthi0JYBY0Kvt8KTHk
        bM+RSCAxBykjEJkXx0s37qmJFRDumjA=
X-Google-Smtp-Source: APXvYqwyKOIvWgGr3RxKI7Y+eCD9AFakDDHYYy4/gF1Ke3Idl9WgYlkpcfYEjNsDxF4x2MBARyow2g==
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr13031829ljd.152.1566893455891;
        Tue, 27 Aug 2019 01:10:55 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id o20sm2373942ljg.31.2019.08.27.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:10:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Philip Langdale <philipl@overt.org>
Cc:     stable@vger.kernel.org
Subject: [PATCH] mmc: core: Fix init of SD cards reporting an invalid VDD range
Date:   Tue, 27 Aug 2019 10:10:43 +0200
Message-Id: <20190827081043.15443-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The OCR register defines the supported range of VDD voltages for SD cards.
However, it has turned out that some SD cards reports an invalid voltage
range, for example having bit7 set.

When a host supports MMC_CAP2_FULL_PWR_CYCLE and some of the voltages from
the invalid VDD range, this triggers the core to run a power cycle of the
card to try to initialize it at the lowest common supported voltage.
Obviously this fails, since the card can't support it.

Let's fix this problem, by clearing invalid bits from the read OCR register
for SD cards, before proceeding with the VDD voltage negotiation.

Cc: stable@vger.kernel.org
Reported-by: Philip Langdale <philipl@overt.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d681e8aaca83..fe914ff5f5d6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1292,6 +1292,12 @@ int mmc_attach_sd(struct mmc_host *host)
 			goto err;
 	}
 
+	/*
+	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
+	 * these bits as being in-valid and especially also bit7.
+	 */
+	ocr &= ~0x7FFF;
+
 	rocr = mmc_select_voltage(host, ocr);
 
 	/*
-- 
2.17.1

