Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ABD37977A
	for <lists+linux-mmc@lfdr.de>; Mon, 10 May 2021 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhEJTMu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 May 2021 15:12:50 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:56432 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231499AbhEJTMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 May 2021 15:12:50 -0400
Received: by lynxeye.de (Postfix, from userid 501)
        id 6F7BBE7426B; Mon, 10 May 2021 21:04:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on lynxeye.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham version=3.3.1
Received: from astat.fritz.box (a89-183-115-43.net-htp.de [89.183.115.43])
        by lynxeye.de (Postfix) with ESMTPA id A22E9E7426A;
        Mon, 10 May 2021 21:04:04 +0200 (CEST)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] mmc: core: add support for disabling HS400 mode via DT
Date:   Mon, 10 May 2021 21:04:00 +0200
Message-Id: <20210510190400.105162-3-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510190400.105162-1-l.stach@pengutronix.de>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Lucas Stach <dev@lynxeye.de>

On some boards the data strobe line isn't wired up, rendering HS400
support broken, even if both the controller and the eMMC claim to
support it. Allow to disable HS400 mode via DT.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
v2:
- move to core
- actually disable all HS400 modes
---
 drivers/mmc/core/host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9b89a91b6b47..0e066c5f5243 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -351,6 +351,9 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_SD;
 	if (device_property_read_bool(dev, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
+	if (device_property_read_bool(dev, "no-mmc-hs400"))
+		host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
+				 MMC_CAP2_HS400_ES);
 
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
-- 
2.31.1

