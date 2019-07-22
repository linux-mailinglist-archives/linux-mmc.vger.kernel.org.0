Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB2700A0
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfGVNKX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:10:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46010 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfGVNKW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:10:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so17628721pgp.12
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mpV9sMLf9/xjtpErFC1dOCeG+Wr6jt6mRJVLIFsCwso=;
        b=Jcb8f4kbGdWtCM+71SbE8WVDGhwE0iqJkaDP/FPTfohqgORzLGvFzTWAB2KVkr0gH8
         fVaStVpD6w4OWcHQvsXI6ju4Nr1SaF7thQHaacKDdkmLI9jOILeOci4K+vhY57cToh+R
         nfh/dUfh1k9NUxsLvYwpG+KlyoEJmCvVIUuBAchnpzxisLw+xtHkFseMkiaCRVEsNNN4
         IkUkO1kAh6k/d2qsCAAWI9v3pkFO+wVCj2Mo1Uql3alLP9vvuVmtPy9OSmPo+AFGN0w6
         ZDqg6lepl5oWl+wdGZwk16EPGA7Or2aVMuh9OfQn23tYjYJ+Bty14K5PaEhMCGdHurgz
         T/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mpV9sMLf9/xjtpErFC1dOCeG+Wr6jt6mRJVLIFsCwso=;
        b=nKi5OXAaOsgQ4LWHYa5lq4Ho2bus8Kk00Paw7V5EXoilBIqv9D7SZa44AzF/PGsN+8
         +QLRejxzD2ZXU/nOHFssUO2Xcng7Xi3NGyGbtXoR6cP/l/JzwemXeCMJwP4SY3F2g007
         GFZ8qPepGHBu5ITl6JI9kLeC3SwFk8vlJyqfJlJM5n0X2rRr5vSx/v9sAdmDMRsmxrh+
         Q3+9/InpfZvAHUWIWVv30o1/7g1IV6nvcMQP+6AiNTOcN6WsvyXm2r7DbiXjpM16GQBW
         6NU+VxyhDWz12KizzzkDIVjauoNKZ4bq9Q0p9ocCR+3EMkwIcx6dJsf11/GIvRemL6Hp
         kTlA==
X-Gm-Message-State: APjAAAUb4tjxQ+umRWQ95slHCjJjRDhHi6yxrqQHyg5prvTUHjeu6x5Z
        5hADnWoej4M7Yjd6B3Bbq7JUYg==
X-Google-Smtp-Source: APXvYqzTrjk/lkHexHJCp1CEZbs0dzPdQ3rwVQKoH4tMSuMsFtbRikyrgk3QdukUYKjQ9F7Qzt9dcw==
X-Received: by 2002:a63:5402:: with SMTP id i2mr44468946pgb.414.1563801021977;
        Mon, 22 Jul 2019 06:10:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 4/7] mmc: host: sdhci: Factor out the command configuration
Date:   Mon, 22 Jul 2019 21:09:39 +0800
Message-Id: <63fb32f58cb11aafdd12c84126b191090af3a31a.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move the SD command configuration into one separate function to simplify
the sdhci_send_command(). Moreover this function can be used to support
ADMA3 transfer mode in following patches.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   65 +++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e57a5b7..5760b7c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1339,9 +1339,43 @@ static void sdhci_finish_data(struct sdhci_host *host)
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
 
@@ -1391,32 +1425,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
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
@@ -1427,7 +1438,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, command, SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
-- 
1.7.9.5

