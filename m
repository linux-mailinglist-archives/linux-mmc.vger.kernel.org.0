Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8631AE03
	for <lists+linux-mmc@lfdr.de>; Sun, 12 May 2019 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfELTsQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 12 May 2019 15:48:16 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:35054
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfELTsQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 May 2019 15:48:16 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 May 2019 15:48:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id D0FD23FE88;
        Sun, 12 May 2019 21:41:32 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q8IJCYCJ668b; Sun, 12 May 2019 21:41:32 +0200 (CEST)
Received: from jerusalem.timesys.com (host87-8-dynamic.4-87-r.retail.telecomitalia.it [87.4.8.87])
        by sysam.it (Postfix) with ESMTPSA id 682A83FE86;
        Sun, 12 May 2019 21:41:32 +0200 (CEST)
From:   Angelo Dureghello <angelo@sysam.it>
To:     adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH 3/3] mmc: enabling ColdFire esdhc controller support
Date:   Sun, 12 May 2019 21:41:25 +0200
Message-Id: <20190512194125.7091-3-angelo@sysam.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512194125.7091-1-angelo@sysam.it>
References: <20190512194125.7091-1-angelo@sysam.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
---
 drivers/mmc/host/Kconfig  | 13 +++++++++++++
 drivers/mmc/host/Makefile |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0e86340536b6..91007572a097 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -220,6 +220,19 @@ config MMC_SDHCI_CNS3XXX
 
 	  If unsure, say N.
 
+config MMC_SDHCI_ESDHC_MCF
+	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
+	depends on M5441x
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale eSDHC/uSDHC controller support
+	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
 	depends on ARCH_MXC
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 73578718f119..17c3826dfe81 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)	+= rtsx_usb_sdmmc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_CADENCE)		+= sdhci-cadence.o
 obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
 obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
 obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
@@ -104,3 +105,5 @@ endif
 
 obj-$(CONFIG_MMC_SDHCI_XENON)	+= sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+= sdhci-xenon.o sdhci-xenon-phy.o
+
+CFLAGS_sdhci-esdhc-mcf.o := -DDEBUG
-- 
2.20.1

