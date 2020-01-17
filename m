Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27723140380
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Jan 2020 06:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgAQFZd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Jan 2020 00:25:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55989 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgAQFZb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2020 00:25:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so2629139pjz.5;
        Thu, 16 Jan 2020 21:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nxaLy9F6yE2CecepgHfL+z5cQMSlQrayHjxpSI6bCwI=;
        b=hvYxXIn0tdSfCKR32UMVyUwVIAzSQtbnsUQpvvqwhuWpsLLnDF+XXOmFTIV864g6BL
         CSLX7lJeC/1KAEbUB6xTjFUNBlgkm3Q/v53Z+vcq8cyhwQtLZ+N2WUaaxcFqb0Xv6gU8
         DEoLFk3D5LPK7yro5VgeB8+sVJOZco9K3A94a/qQmB3HIAsbQlqmeCjGpztncyogCwkc
         V2ENT6lnBicFjrqzYrasrC6jHzBfmPk/PB/GVozchwVYzviD1s0wFF0sZzFyoF7hYiM6
         71hyk8fCiaCNaLvxOLE0xFZ8Kh+wHpoIcitziS13112Cd71iUiNfZJ9apkD3nDZw5ukr
         Z7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nxaLy9F6yE2CecepgHfL+z5cQMSlQrayHjxpSI6bCwI=;
        b=Vz83whDeE6J4MjIbu3X9QshBndVInLJ/BWjHHwAeIbkjJS5y0NJd5u1mAq+z6UUsnC
         IoVVYVlqpTHPqC25j2hVxVoS93q82uf3xVOaYjNoAg8B/T2wNSqkuoTpPN5kua8yJbYu
         AWYMt9bd/nsclmg5mnX9uUYvVDIlmz4dLVKQj3i0aeQo/FHgDmR0ybLTtNGikaa7MfMo
         1qRH501vkDH6dFNgxHX0W/xujIOQKxLodMQcoUbgw9gEzV0MwxlxVNHjuJY2v0NvGj/G
         4EIeEjCPTjHM2jOV1XtgLc9HO59Pay0tSLct74PXC86+JPsCq+P1qNi40fM7K5z2gBNU
         zplQ==
X-Gm-Message-State: APjAAAUW0AT/gAX2GpRDG/n5U+ZmXICfBztNnzBtfgm7BYJOTFWOkLD7
        fr0JVEpGlZLtQHS5idFmuO8=
X-Google-Smtp-Source: APXvYqz05UCb1S5G9rNU+MhgC5WiZHFPMWCPRi3Z2lwqjuMLGHgq7B5AM7Qo8cir8gPMBgmTINFHDg==
X-Received: by 2002:a17:902:be06:: with SMTP id r6mr23548273pls.99.1579238730834;
        Thu, 16 Jan 2020 21:25:30 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:30 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 5/8] mmc: host: sdhci: Factor out the command configuration
Date:   Fri, 17 Jan 2020 13:24:24 +0800
Message-Id: <47c4217fd274b77e2fb5c86812cce883c8ed9bd2.1579164456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move the SD command configuration into one separate function to simplify
the sdhci_send_command(). Moreover this function can be used to support
ADMA3 transfer mode in following patches.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |   65 +++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 907a35e..f517121 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1350,9 +1350,43 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static int sdhci_get_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		pr_err("%s: Unsupported response type!\n",
+			mmc_hostname(host->mmc));
+		cmd->error = -EINVAL;
+		sdhci_finish_mrq(host, cmd->mrq);
+		return -EINVAL;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	/* CMD19 is special in that the Data Present Select should be set */
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+		flags |= SDHCI_CMD_DATA;
+
+	return SDHCI_MAKE_CMD(cmd->opcode, flags);
+}
+
+void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int command;
 	u32 mask;
 	unsigned long timeout;
 
@@ -1402,32 +1436,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_mode(host, cmd);
 
-	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		pr_err("%s: Unsupported response type!\n",
-			mmc_hostname(host->mmc));
-		cmd->error = -EINVAL;
-		sdhci_finish_mrq(host, cmd->mrq);
+	command = sdhci_get_command(host, cmd);
+	if (command < 0)
 		return;
-	}
-
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		flags = SDHCI_CMD_RESP_NONE;
-	else if (cmd->flags & MMC_RSP_136)
-		flags = SDHCI_CMD_RESP_LONG;
-	else if (cmd->flags & MMC_RSP_BUSY)
-		flags = SDHCI_CMD_RESP_SHORT_BUSY;
-	else
-		flags = SDHCI_CMD_RESP_SHORT;
-
-	if (cmd->flags & MMC_RSP_CRC)
-		flags |= SDHCI_CMD_CRC;
-	if (cmd->flags & MMC_RSP_OPCODE)
-		flags |= SDHCI_CMD_INDEX;
-
-	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
-		flags |= SDHCI_CMD_DATA;
 
 	timeout = jiffies;
 	if (host->data_timeout)
@@ -1438,7 +1449,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, command, SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
-- 
1.7.9.5

