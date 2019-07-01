Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CBC112CE
	for <lists+linux-mmc@lfdr.de>; Thu,  2 May 2019 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfEBF7C (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 2 May 2019 01:59:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfEBF7C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 May 2019 01:59:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so563617pgs.8;
        Wed, 01 May 2019 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fjf9nhJBcqZ8B6mrMqqWtSz1KEpRRLO4OhmQLK8r9Fo=;
        b=VVS9OT9Gl168GooO8G1YV2yDDDU69i1DGvnmnppBWf6kT/QTiB7Q9k7IiM9h1HfY97
         3GKOHmq0Vo1N5SnIWjIWpYqXUl4owsjacAtxwrEm54jyK5Y9cQ1UtQAyLlrAaBye02Wo
         9echQTYPvWEampTNh+Y131M3p9kxIkDlcysI72zFQxiv0EyeZwL1rjnOMO6bZZkdkgt7
         5fwXUyvBjPRp3eRLYWQbBI5WocbjNT70hNKq7l5zHsEcUNIMsvxn5lsezsi+fvMrf9dY
         asvT1nPHdK6syQ1sLaByCc+jQiNel6d6y/CYh6wWriSq1m/r2VCUILC4pBRWxQS9s6fX
         G25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fjf9nhJBcqZ8B6mrMqqWtSz1KEpRRLO4OhmQLK8r9Fo=;
        b=jc+Suyob/I3+j9IFXG5dmxeUNh6OUXuUCiiVwBFHKk3pXV0o81+SUMheJ6xQbRUzyn
         22//95QGS/T57lXyLk/qclFJjfVAtkMU8UIZmAnu1SgW7vg0Yjkfm74QCIeLIoE+WayJ
         NqTEhQ08cY1jl5/3knNzOgLUCB5Hyzmlpa1LA3eqiDj+q2y5XhYJWEl2G2/8LMOur1Co
         gOgV8dDQQQJGIZ0Njjfy0fO736ZIxxc4NN2TT4wVx2WXflTjc1tO2ohm/2RtwHtBLyzQ
         9tRl3UdGO2+cth5psGjRcEGE1ZT4VAhnwx4WfVFodMGnov4wXckmbNlAYHhgqVvKWytl
         JufQ==
X-Gm-Message-State: APjAAAXvr8TJm+EhlY+zzFSTdoB7hlFLIsCDWDja1JCYRisqRWOPCwtZ
        qBRiDsi1UnXWqhdEK/eR8IpkoHoaVP0=
X-Google-Smtp-Source: APXvYqy5OdcpcbxQM43mzzrncDvr4V2dVIfeC5lvfoIpjxeJqBOw1VO9Tby/Ce5hNoQRr/n+ScDP9A==
X-Received: by 2002:a63:6196:: with SMTP id v144mr2101927pgb.235.1556776741486;
        Wed, 01 May 2019 22:59:01 -0700 (PDT)
Received: from localhost.localdomain ([203.192.210.144])
        by smtp.gmail.com with ESMTPSA id g32sm7851013pgl.16.2019.05.01.22.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 22:59:00 -0700 (PDT)
From:   Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Lukas Wunner <lukas@wunner.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kamlesh.gurudasani@gmail.com
Subject: [PATCH] mmc: alcor: Drop pointer to mmc_host from alcor_sdmmc_host
Date:   Thu,  2 May 2019 11:28:16 +0530
Message-Id: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver for Alcor Micro AU6601 and AU6621 controllers uses a pointer to
get from the private alcor_sdmmc_host structure to the generic mmc_host
structure. However the latter is always immediately preceding the former in
memory, so compute its address with a subtraction (which is cheaper than a
dereference) and drop the superfluous pointer.

No functional change intended.

Signed-off-by: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
---
 drivers/mmc/host/alcor.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 7c8f203..5bba6ee 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -43,7 +43,6 @@ struct alcor_sdmmc_host {
 	struct  device *dev;
 	struct alcor_pci_priv *alcor_pci;
 
-	struct mmc_host *mmc;
 	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
@@ -276,7 +275,7 @@ static void alcor_send_cmd(struct alcor_sdmmc_host *host,
 		break;
 	default:
 		dev_err(host->dev, "%s: cmd->flag (0x%02x) is not valid\n",
-			mmc_hostname(host->mmc), mmc_resp_type(cmd));
+			mmc_hostname(mmc_from_priv(host)), mmc_resp_type(cmd));
 		break;
 	}
 
@@ -317,7 +316,7 @@ static void alcor_request_complete(struct alcor_sdmmc_host *host,
 	host->data = NULL;
 	host->dma_on = 0;
 
-	mmc_request_done(host->mmc, mrq);
+	mmc_request_done(mmc_from_priv(host), mrq);
 }
 
 static void alcor_finish_data(struct alcor_sdmmc_host *host)
@@ -547,7 +546,7 @@ static void alcor_cd_irq(struct alcor_sdmmc_host *host, u32 intmask)
 		alcor_request_complete(host, 1);
 	}
 
-	mmc_detect_change(host->mmc, msecs_to_jiffies(1));
+	mmc_detect_change(mmc_from_priv(host), msecs_to_jiffies(1));
 }
 
 static irqreturn_t alcor_irq_thread(int irq, void *d)
@@ -1025,7 +1024,7 @@ static void alcor_hw_uninit(struct alcor_sdmmc_host *host)
 
 static void alcor_init_mmc(struct alcor_sdmmc_host *host)
 {
-	struct mmc_host *mmc = host->mmc;
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	mmc->f_min = AU6601_MIN_CLOCK;
 	mmc->f_max = AU6601_MAX_CLOCK;
@@ -1073,7 +1072,6 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	}
 
 	host = mmc_priv(mmc);
-	host->mmc = mmc;
 	host->dev = &pdev->dev;
 	host->cur_power_mode = MMC_POWER_UNDEFINED;
 	host->alcor_pci = priv;
@@ -1105,13 +1103,14 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 {
 	struct alcor_sdmmc_host *host = dev_get_drvdata(&pdev->dev);
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	if (cancel_delayed_work_sync(&host->timeout_work))
 		alcor_request_complete(host, 0);
 
 	alcor_hw_uninit(host);
-	mmc_remove_host(host->mmc);
-	mmc_free_host(host->mmc);
+	mmc_remove_host(mmc);
+	mmc_free_host(mmc);
 
 	return 0;
 }
-- 
2.7.4

