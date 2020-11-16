Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815992B44A3
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Nov 2020 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgKPNWY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Nov 2020 08:22:24 -0500
Received: from www.zeus03.de ([194.117.254.33]:34554 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgKPNWX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 08:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=vLpvxKqC/mjW2yF+OXWN+gKM3ka
        R9yo/K/K50v90Zpk=; b=s2QER4g0pzxiyoI45OIlHlR5HXLL8xelGOiQDgFLRyZ
        u0JxReOMZ3IkTtR4SD/ZLypTxL8A63fGKlyry63Y2jiSDVG7Z3LR1JgJWfGRB6oJ
        JOBaYFHedeFMQOm2jt48H0HA1TOUKoxS8P1ph3TV9whVHYWj1rqTQlYCfz8qrzZk
        =
Received: (qmail 4124328 invoked from network); 16 Nov 2020 14:22:20 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2020 14:22:20 +0100
X-UD-Smtp-Session: l3s3148p1@fiubRDm03sEgAwDPXxaWAHZio88zPEfF
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
Date:   Mon, 16 Nov 2020 14:22:06 +0100
Message-Id: <20201116132206.23518-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'busy_timeout' is in msecs, not in jiffies. Use the correct factor.

Fixes: 5e958e4aacf4 ("sdhci: tegra: Implement Tegra specific set_timeout callback")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---

Changes since RFC:

* added acks
* fixed typo causing build failure ("MSECS" instead of "MSEC")

 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ed12aacb1c73..41d193fa77bb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1272,7 +1272,7 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
 	 * busy wait mode.
 	 */
 	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
-	if (cmd && cmd->busy_timeout >= 11 * HZ)
+	if (cmd && cmd->busy_timeout >= 11 * MSEC_PER_SEC)
 		val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
 	else
 		val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
-- 
2.28.0

