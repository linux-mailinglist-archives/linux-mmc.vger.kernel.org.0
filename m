Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15800157134
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Feb 2020 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJIw6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Feb 2020 03:52:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:33074 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJIw6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Feb 2020 03:52:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F9DD1A6E78;
        Mon, 10 Feb 2020 09:52:56 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A18041A707B;
        Mon, 10 Feb 2020 09:52:52 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26301402CF;
        Mon, 10 Feb 2020 16:52:48 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v3 00/14] few fix for sdhci-esdhc-imx
Date:   Mon, 10 Feb 2020 16:47:10 +0800
Message-Id: <1581324434-30903-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

---
Changes for v3:
Add Linus Walleij's ack for patch 2
for patch 9, drop the use of 'sdhci,auto-cmd23-broken' from dts, change to add flag ESDHC_FLAG_BROKEN_AUTO_CMD23 in the related esdhc_soc_data.
for patch 10, add a new esdhc_soc_data for i.MX8MM

Changes for v2:
Add Adrian's ack for patch 1~8
Patch 9~10, change to use 'sdhci,auto-cmd23-broken' instead of 'fsl,auto-cmd23-broken'
Patch 11, clear cqhci irq status and halt cqhci, move this change to sdhci_esdhc_imx_hwinit()
and add some comment to explain the reason.
Patch 12, add error return check for pinctrl_pm_select_sleep_state()
Patch 13, clear the DMA_SEL in sdhci-esdhc-imx.c instead of sdhci.c
Patch 14, add the dev->dma_parms in core/queue.c, instead of host/sdhci.c.

Haibo Chen (14):
  mmc: sdhci: do not enable card detect interrupt for gpio cd type
  mmc: sdhci-esdhc-imx: no fail when no pinctrl available
  mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
  mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
  doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target binding
  mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
  mmc: sdhci-esdhc-imx: optimize the clock setting
  mmc: sdhci-esdhc-imx: optimize the strobe dll setting
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_BROKEN_AUTO_CMD23
  mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data for i.MX8MM
  mmc: sdhci-esdhc-imx: clear pending interrupt and halt cqhci
  mmc: sdhci-esdhc-imx: restore pin state when resume back
  mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
  mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt |   5 +
 drivers/mmc/core/queue.c                      |   9 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            | 169 +++++++++++++++---
 drivers/mmc/host/sdhci-esdhc.h                |   1 +
 drivers/mmc/host/sdhci.c                      |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h   |   1 +
 6 files changed, 161 insertions(+), 26 deletions(-)

-- 
2.17.1

