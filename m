Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687701C2623
	for <lists+linux-mmc@lfdr.de>; Sat,  2 May 2020 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgEBO2x (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 2 May 2020 10:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO2x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 2 May 2020 10:28:53 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9044921835;
        Sat,  2 May 2020 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429733;
        bh=9olk3ObhMc8cOTIoo8nHKZ/Lo7GxdgtnpnH2oy+jl7I=;
        h=From:To:Cc:Subject:Date:From;
        b=ns+xFL5zDRX0vlHJhz2dyHwRrHC8GMgRNmOEIiPqJ731Id6UbEQeTUPf5SOGht+KM
         e9ZexSW1/so64yMQmgeQdoL8UdltnOYaDWvmYViZwJhHzBGD1Va72VqOToAyXVBmzj
         qXN9Ujk8gUDEomXMj4iU8GE3zRZ9xZ/GCMZP6OCo=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc: update contact email
Date:   Sat,  2 May 2020 16:28:25 +0200
Message-Id: <20200502142840.19418-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc.h              | 2 +-
 include/linux/platform_data/mmc-esdhc-imx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 947212f16bc6..a30796e79b1c 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -5,7 +5,7 @@
  * Copyright (c) 2007 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
- *   Author: Wolfram Sang <w.sang@pengutronix.de>
+ *   Author: Wolfram Sang <kernel@pengutronix.de>
  */
 
 #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 0434f68eda86..cba1184b364c 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright 2010 Wolfram Sang <w.sang@pengutronix.de>
+ * Copyright 2010 Wolfram Sang <kernel@pengutronix.de>
  */
 
 #ifndef __ASM_ARCH_IMX_ESDHC_H
-- 
2.20.1

