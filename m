Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669A61A5DA2
	for <lists+linux-mmc@lfdr.de>; Sun, 12 Apr 2020 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLJEl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 12 Apr 2020 05:04:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:20973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLJEl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Apr 2020 05:04:41 -0400
IronPort-SDR: 7j1pYkWxitOyJhllMaqgVwtar4KYT9dbQb5UqVX3/xcymDzDygVroCzMPx2flwWUq4CFiUvE7t
 iZq3NE4M0BcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 02:04:41 -0700
IronPort-SDR: 0Zj3ogToVenb45U/72QjFNW5dN1Wxk9rmWInloPQfkARyTY36oF75ZwGAUArYt6N6jICHlV8jS
 HsC1e7slfZYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="362835159"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 02:04:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 2/5] mmc: sdhci: Stop exporting sdhci_send_command()
Date:   Sun, 12 Apr 2020 12:03:46 +0300
Message-Id: <20200412090349.1607-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
References: <20200412090349.1607-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sdhci_send_command() has not been used outside of sdhci.c for many
years. Stop exporting it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07548e5efd1f..429e5b80f2fb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -52,6 +52,8 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
+static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
+
 void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
@@ -1558,7 +1560,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
 	u32 mask;
@@ -1658,7 +1660,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
-EXPORT_SYMBOL_GPL(sdhci_send_command);
 
 static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..47324feeba86 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -757,7 +757,6 @@ void sdhci_cleanup_host(struct sdhci_host *host);
 int __sdhci_add_host(struct sdhci_host *host);
 int sdhci_add_host(struct sdhci_host *host);
 void sdhci_remove_host(struct sdhci_host *host, int dead);
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 static inline void sdhci_read_caps(struct sdhci_host *host)
 {
-- 
2.17.1

