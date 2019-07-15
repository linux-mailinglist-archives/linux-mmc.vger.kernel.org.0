Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140936993A
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfGOQm1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 12:42:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfGOQm1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2019 12:42:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so16947490ljg.8
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2019 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SvtIV/tcFCzqjGvQoWAOgEFc/3jodWDp36stdT3v0DM=;
        b=ZkttRZHXnWYK+dg6eqMWB6kba/LUdEL10AUe4S+FRr6cDRHK4V/3oQHGRS8aqAQLrO
         bCPdSwtZowZ/r4TJnbirgz5QlZSeLfPH/IAHdb+HBUppwIhAABc0gCi1sW91V+jEPAWF
         hZycY3GFOiMWqye01ss1gF7N8oOdACMvpCu7CXteezl+M9SItbGtxRJIIMWXHITdBsdx
         2zrVj+EU6uB2GbAuwO6lgYHSQaT4WF7h7+hSxjHZaq+/Y+NCCNwCrFrhV4XaBbmnTB8t
         fQRvl5abEJhyNOgV8MwsAHJfGFMRG01t2/PqxhlZ4yYyTTZ9xflCnRtjd2iAwz9smWcH
         YNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SvtIV/tcFCzqjGvQoWAOgEFc/3jodWDp36stdT3v0DM=;
        b=iRBoeNaWSCsAQ3D0VAU92DjrsYM1FXoXSdPJ+YjRi+knemf1unQtl98cEDFwd5o47C
         8QSRPMZpVlnUGSBkuks4yRIkKv+SKumnlIRXHREil2LLTwJWU2essM2/YmKIIlWXuy8k
         ofDOUC3zOOu/MxjvCsOd4rq7ODTBhtvG+Rzs1D9QzsOdXMY0k8JDFh2SX37KdHqsbs2U
         dmtzv5/XXA/+XEf/m8OSwK2vj6OzTp9Z9pxBcbxYUQ1A1Xg0I4+UoV+P6lEV7UfYPQCe
         nUkfh3sU1vLuUGU3uNYmjv+uQ7Pr5m9aT4mcb3cL56cEEoFxV43Cb2M+x6Mb6VkqvL3f
         N0uQ==
X-Gm-Message-State: APjAAAURQlcxb/EmIzdBJCpWRq1XVkojrjyBlbkJ/eCRjaAufwcjk2YD
        RWpIj8kroI5J73DnRDv9KT1jyqc0sXo=
X-Google-Smtp-Source: APXvYqw7W4B9mR/OO+8nRc2tr8H7hfCum3oz0c/2jGi+Py3NC7e/7rhRe5luX2PSZY2c2X9usUxIvg==
X-Received: by 2002:a2e:968e:: with SMTP id q14mr13744737lji.195.1563208944944;
        Mon, 15 Jul 2019 09:42:24 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id m25sm2388622lfc.83.2019.07.15.09.42.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 09:42:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
Date:   Mon, 15 Jul 2019 18:42:17 +0200
Message-Id: <20190715164217.27297-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMCISTATUS register is read from the IRQ handler, mmci_irq(). For
processing, its value is then passed as an in-parameter to mmci_cmd_irq().

When dealing with busy detection, the MMCISTATUS register is being re-read,
as to retrieve an updated value. However, this operation is likely costing
more than it benefits, as the value was read only a few cycles ago. For
this reason, let's simply drop the re-read and use the value from the
in-parameter instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 356833a606d5..5f35afc4dbf9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1233,14 +1233,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 			return;
 
 		/*
-		 * We were not busy, but we now got a busy response on
-		 * something that was not an error, and we double-check
-		 * that the special busy status bit is still set before
-		 * proceeding.
+		 * Before unmasking for the busy end IRQ, confirm that the
+		 * command was sent successfully.
 		 */
 		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		    (status & host->variant->busy_detect_flag)) {
 
 			/* Clear the busy start IRQ */
 			writel(host->variant->busy_detect_mask,
-- 
2.17.1

