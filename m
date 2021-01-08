Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965992EFA0E
	for <lists+linux-mmc@lfdr.de>; Fri,  8 Jan 2021 22:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbhAHVOg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 8 Jan 2021 16:14:36 -0500
Received: from foss.arm.com ([217.140.110.172]:57018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbhAHVOg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Jan 2021 16:14:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2A21063;
        Fri,  8 Jan 2021 13:13:50 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 459843F66E;
        Fri,  8 Jan 2021 13:13:50 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] mmc: sdhci-iproc: Add ACPI bindings for the rpi4
Date:   Fri,  8 Jan 2021 15:13:39 -0600
Message-Id: <20210108211339.1724769-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The rpi4 has a Arasan controller it carries over
from the rpi3, and a newer eMMC2 controller.
Because of a couple "quirks" it seems wiser to bind
these controllers to the same driver that DT is using
on this platform rather than the generic sdhci_acpi
driver with PNP0D40.

So, we use BCM2847 for the older Arasan and BRCME88C
for the newer eMMC2.

With this change linux is capable of utilizing the
SD card slot, and the wifi on this platform
with linux.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/mmc/host/sdhci-iproc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index c9434b461aab..f79d97b41805 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -250,6 +250,14 @@ static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
 	.ops = &sdhci_iproc_32only_ops,
 };
 
+static const struct sdhci_pltfm_data sdhci_bcm_arasan_data = {
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops = &sdhci_iproc_32only_ops,
+};
+
 static const struct sdhci_iproc_data bcm2835_data = {
 	.pdata = &sdhci_bcm2835_pltfm_data,
 	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
@@ -261,6 +269,10 @@ static const struct sdhci_iproc_data bcm2835_data = {
 	.mmc_caps = 0x00000000,
 };
 
+static const struct sdhci_iproc_data bcm_arasan_data = {
+	.pdata = &sdhci_bcm_arasan_data,
+};
+
 static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
 	.read_l = sdhci_iproc_readl,
 	.read_w = sdhci_iproc_readw,
@@ -299,6 +311,8 @@ MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
 	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
 	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
+	{ .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
+	{ .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
-- 
2.26.2

