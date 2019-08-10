Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4C88B41
	for <lists+linux-mmc@lfdr.de>; Sat, 10 Aug 2019 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfHJMQ2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 10 Aug 2019 08:16:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38556 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMQ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Aug 2019 08:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565439384; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=YL9REanpshHiQGVAOtq8+VNk67aJvWqlrOh2zu4VPHU=;
        b=FMK7V/izxsb10EWVN4YHBEeXeZ5U9mc30TqAbdMc138ioT8EGcejKidWj1sa7AuNlcBhwy
        dva52MvlnEilgTdWzZRC9xudfHMLdD4zga5qn86Y1VKp0byCD0RPloiP+AQf+NIOY9rVk/
        wJNUgOaObYsdI0ki8vspBK9F624R59I=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] mmc: jz4740: Code cleanup
Date:   Sat, 10 Aug 2019 14:16:07 +0200
Message-Id: <20190810121608.24145-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix wrong code indentation which made the code hard to read, and fix
return with value in void function.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index ffdbfaadd3f2..59f81e8afcce 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -186,9 +186,9 @@ static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
 				     uint32_t val)
 {
 	if (host->version >= JZ_MMC_JZ4780)
-		return writel(val, host->base + JZ_REG_MMC_IREG);
+		writel(val, host->base + JZ_REG_MMC_IREG);
 	else
-		return writew(val, host->base + JZ_REG_MMC_IREG);
+		writew(val, host->base + JZ_REG_MMC_IREG);
 }
 
 static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
@@ -820,14 +820,14 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 			del_timer(&host->timeout_timer);
 
 			if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
-					cmd->error = -ETIMEDOUT;
+				cmd->error = -ETIMEDOUT;
 			} else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
-					cmd->error = -EIO;
+				cmd->error = -EIO;
 			} else if (status & (JZ_MMC_STATUS_CRC_READ_ERROR |
 				    JZ_MMC_STATUS_CRC_WRITE_ERROR)) {
-					if (cmd->data)
-							cmd->data->error = -EIO;
-					cmd->error = -EIO;
+				if (cmd->data)
+					cmd->data->error = -EIO;
+				cmd->error = -EIO;
 			}
 
 			jz4740_mmc_set_irq_enabled(host, irq_reg, false);
-- 
2.21.0.593.g511ec345e18

