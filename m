Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5F686C2
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfGOKA3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 06:00:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKA3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2019 06:00:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so7170242pfb.13
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2019 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5aSldgrUNSK5XytyDzCE2r6IPKJFqEPbYobzHqmxrgk=;
        b=i86wsPp+N/DWz7EWLy/hkz5gmE1W4UcwoI41T3KH2E2Eduip2LoEakJk2Euy51rqBh
         VcUrlKtSjyMOa5didb9kkNmMPQedYna2CXJILoC6U2QmO/cJhOgda2uuqaO2DvRyQjWX
         K3XeZeq/tCKRD/kQf/bloKELfHr8dcbuYAb32ur5F8HhGF1SXs0Hi0MgLF5XsgCVWcSL
         uKfRbztPVzufskCkwhGjpN3VIVdav6jc/HCizJpR0QKdsgwSanKpHDYd/p8/M4Q7mNOE
         z43phdtSQndFFgwt5646aW5jw/+WaMVKdjtWI8aAJ9sx51pxmW+EFFKB1cBLk0nXoTxT
         okdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5aSldgrUNSK5XytyDzCE2r6IPKJFqEPbYobzHqmxrgk=;
        b=Bkv6GdcVcoCeiXtntTnsQvbPRXCGp0wb/RRm0vNmeO2Ubb28GHuaALf/SHA4Xrt3sW
         e29DDwSb1y6nOO+1yBhfN6I3V/cAX5HBJJ+bxIegYSFdtl9+gA0fM5WWGhpdyKA9R+VK
         KaIN1BeBaA/EEADtk2dw4VydK4qV0h4TDUA6+ExAM0bWFKg/SPJUf9eEEfjnO3RSlNjR
         PEbybxjp7PApPcn0H4Ui1IoPIK2q7RGRFPD4+OGD7Sz0R17JUa4xmYalEL14zjoI+jQZ
         4ZfwVy0WgTUfmCDzXJAaEuf7sUqM7t+m9QeRCfCKhlbjYR7xKEEbN+cidi97SooPWfbJ
         GE/w==
X-Gm-Message-State: APjAAAWvJ7AwfnNL90Uo+XmkaagLt6R3ATR6e2/EUxoABQvmf9n/oszW
        pZdrI1vJ/jJx2FyamqjgYSESyw==
X-Google-Smtp-Source: APXvYqyjjljxwukQaF3urZseJzTy1AsnzMnYzJjfnyDdNrG7pSlanlxu4i8SlqG9v66BGSqdS8sWQQ==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr28866035pjb.14.1563184828689;
        Mon, 15 Jul 2019 03:00:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e13sm21971842pff.45.2019.07.15.03.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jul 2019 03:00:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()
Date:   Mon, 15 Jul 2019 18:00:14 +0800
Message-Id: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When the SD host controller tries to probe again due to the derferred
probe mechanism, it will always keep the SD host device as runtime
resume state due to missing the runtime put operation in error path
last time.

Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
counter balance, which can make the SD host device's PM runtime work well.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a..603a5d9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sdhci_cleanup_host(host);
 
 pm_runtime_disable:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-- 
1.7.9.5

