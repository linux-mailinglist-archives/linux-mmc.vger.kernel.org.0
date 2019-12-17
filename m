Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD1122A53
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Dec 2019 12:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLQLkp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Dec 2019 06:40:45 -0500
Received: from sauhun.de ([88.99.104.3]:52178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfLQLko (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 06:40:44 -0500
Received: from localhost (p54B330AA.dip0.t-ipconnect.de [84.179.48.170])
        by pokefinder.org (Postfix) with ESMTPSA id EB4742C2D6D;
        Tue, 17 Dec 2019 12:40:42 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 1/5] mmc: renesas_sdhi: remove double clear of automatic correction
Date:   Tue, 17 Dec 2019 12:40:30 +0100
Message-Id: <20191217114034.13290-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
References: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hw_reset() clears the automatic correction bit twice. I couldn't find
anything in the docs recommending that. Removing one of them didn't
cause any regressions here, so keep it simple.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 35cb24cd45b4..519d91ae3373 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -531,10 +531,6 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
 		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
-		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
-		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
-
 	if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 		sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
 					     TMIO_MASK_INIT_RCAR2);
-- 
2.20.1

