Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824ABEDD8F
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfKDLQm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 06:16:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32934 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKDLQm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 06:16:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so17152581ljk.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2019 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=EeTFOOYKrSClkOwik36tTLvKJAVQNTgceAjoI/9c9oY=;
        b=SZDb18lKPJI6fBj4upNX9diNR6/sW+AGGRX/n/E/cQpqxOdORJbMEM3ZBKxf2BIomv
         si6atCFY/bZ4W3bslIgfLm3VzT0wj4EAcdHP339LHGns+AWsZsuFzRQyRvy1z9piSOB1
         bH2iZXXerLCB/91t1nIdO5Z6otAo2xd64qKMrXewu+Z71JMjQ/iP+/uqjgsNPhtYmz/t
         PUknveHsBy5J9pRbbC7CXYwAqeEr0a5huVXdzQK14H/dDbJxn//aC1d0+D1ThTtfTcIS
         TZe/r0QMCxqIKB0XFQ8NBVTLapHkQFrgrjHFgz/MLlC0sJF4awp9nlpY7NWCl5+bGmFT
         Jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=EeTFOOYKrSClkOwik36tTLvKJAVQNTgceAjoI/9c9oY=;
        b=TDKCZQZU4IGhEoIoxG/ejPcUgVuP5t48pw9EneqeYioAVfy8B2UaLCUMyXe1fsbNEY
         +/CvD6rIhxxFAfpCiBnYZl1lnMPOZn2MSxFUYEVBqX6ToKNdSQkD4Pj+C22NrQ71BLzU
         +waAx8l1Xo/Vb+TH2EoJ3L+hg5L94M6dgwiGh2qHeqgTrHtTODb+j0k3oEzZ4DnY+JNV
         IrjLFG8acs2vUdHR8vNGzXDdyt4uziwqpfnt/mOo3W3MtKuPEuHOXt8FUEWIkBc4vO3v
         saALdtk3V6sBLsg1RSr3wUqErB0HrUYa2Ke2nkMAnmyf7nPrZQWn2umKxw1XXpNekaWv
         NSnw==
X-Gm-Message-State: APjAAAWbojKp1Uj2yxQ0BOSO3oVSNlarG2wkzGZIRVICrdel/Wt+royh
        qW4KA1yXcAyJAB8NMCxX5PLSVg82UtQ=
X-Google-Smtp-Source: APXvYqzaDs6ZVMi6zFpR/sN5Xw0857V58+YTvxR+N6fs0cG4i+ptEjKi+Nh2goa/J1SYAirf1dEMcg==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr18690634ljg.212.1572866198567;
        Mon, 04 Nov 2019 03:16:38 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d27sm8099348lfb.3.2019.11.04.03.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 03:16:37 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Olech <tony.olech@elandigitalsystems.com>
Subject: [PATCH] mmc: vub300: Drop redundant host ops ->init_card()
Date:   Mon,  4 Nov 2019 12:16:32 +0100
Message-Id: <20191104111632.31354-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ->init_card() host ops is printing message to the log, without actually
doing something useful. Let's just drop this code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/vub300.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index a3680c900689..6ced1b7f642f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2070,18 +2070,11 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	kref_put(&vub300->kref, vub300_delete);
 }
 
-static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
-{				/* NOT irq */
-	struct vub300_mmc_host *vub300 = mmc_priv(mmc);
-	dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");
-}
-
 static const struct mmc_host_ops vub300_mmc_ops = {
 	.request = vub300_mmc_request,
 	.set_ios = vub300_mmc_set_ios,
 	.get_ro = vub300_mmc_get_ro,
 	.enable_sdio_irq = vub300_enable_sdio_irq,
-	.init_card = vub300_init_card,
 };
 
 static int vub300_probe(struct usb_interface *interface,
-- 
2.17.1

