Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF296AB62
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfGPPHe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 11:07:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:19977 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPHe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 11:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563289652;
        s=strato-dkim-0002; d=fpond.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=imbz7BdBKL+eONzyyt38SkoblfiMxaQY/kENBBY+wnw=;
        b=QiDexpK8nSMeUg4XTVOKtGn8ydgTQsg9xLFEgzpc0QfiPN48f3wa1lQ5A8jKuV4Luo
        AlCaPJC9cYFsX5Is5TH/Rzioh3KbYAoNYb67t0lY6zY5DYfQNy64h4B7iK3FsEobfddT
        bYuemtKhstpS+t1sfyQ8KF4mBLnp8pmeQvMrJcMAv5qElTQvrukhUMXN4o1FmI6bzo0h
        2BskfzX8Rzn0dvn+Om4IO1eoODhzghoSYVKZtF+06TkcvGZVNRFDcWSRUmX7wVhzOrg2
        QPul5HagVIJP4EvOjV2YI7KOjBPnYHUwCs8aabGZaRq92bINcpkyvSOdoZgLZm1kpCGs
        GJXQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA67Ot4fvR82dYd7rJSdw="
X-RZG-CLASS-ID: mo00
Received: from groucho.site
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v6GF1Dd5H
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 16 Jul 2019 17:01:13 +0200 (CEST)
From:   Ulrich Hecht <uli+renesas@fpond.eu>
To:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     niklas.soderlund@ragnatech.se, wsa@the-dreams.de,
        yamada.masahiro@socionext.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, magnus.damm@gmail.com,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 1/2] mmc: tmio: leave clock handling to PM if enabled
Date:   Tue, 16 Jul 2019 17:01:03 +0200
Message-Id: <1563289264-26432-2-git-send-email-uli+renesas@fpond.eu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
References: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This fixes a clock imbalance that occurs because the SD clock is handled
by both PM and the hardware driver.
See https://www.spinics.net/lists/linux-mmc/msg44431.html for details.

This patch removes the clock handling from the driver's PM callbacks and
turns the clock off after probing.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
---
 drivers/mmc/host/tmio_mmc_core.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 31ffcc3..26dcbba 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1260,9 +1260,14 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	pm_runtime_set_active(&pdev->dev);
+#ifdef CONFIG_PM
+	/* PM handles the clock; disable it so it won't be enabled twice. */
+	if (_host->clk_disable)
+		_host->clk_disable(_host);
+	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
+#endif
 
 	ret = mmc_add_host(mmc);
 	if (ret)
@@ -1302,20 +1307,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
 #ifdef CONFIG_PM
-static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
-{
-	if (!host->clk_enable)
-		return -ENOTSUPP;
-
-	return host->clk_enable(host);
-}
-
-static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
-{
-	if (host->clk_disable)
-		host->clk_disable(host);
-}
-
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
@@ -1325,8 +1316,6 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	if (host->clk_cache)
 		host->set_clock(host, 0);
 
-	tmio_mmc_clk_disable(host);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_suspend);
@@ -1340,7 +1329,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	tmio_mmc_clk_enable(host);
 	tmio_mmc_hw_reset(host->mmc);
 
 	if (host->clk_cache)
-- 
2.7.4

