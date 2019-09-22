Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D2BA1D3
	for <lists+linux-mmc@lfdr.de>; Sun, 22 Sep 2019 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfIVK1S (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 06:27:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35216 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVK1S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Sep 2019 06:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tl0C5dZUzPLXCTQ3qK7Ms2fApH/5QPPJjH2pMLbTTUM=; b=fvgGm1esxOmA7y8zBCuNTjOA8k
        VZX263CZ/5GSiDxU7NUvhQEqQVc5pxGoA76UIOV0s4qJ7wmjmTSx0nuzKuIVtNPQrDod7zfV479tt
        Dra9ZCMFtwOIJAtvj61v0tjH5rl8pEBulAxUzG/rj1KvH2ICPcSPe4VfCFC1HAJNbxPpY8b4jET0S
        4NUprcwF+7JYG5js/H8QO5lhXO0EeCaT7XWtQDoLpEHdM0djwMjy9N9hkWvaXeJbhV8N2IeLWhfH2
        wCiXRAr1IOxrU4HcTCkeLEKUviP5C3+A+pPXGOOjl+SOVc1soTUcFHculNj2pnmSXEvWOBJN51xDP
        Xt4DCPBg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33944 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iBz51-0006SS-Sl; Sun, 22 Sep 2019 11:26:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1iBz50-0008Mc-8K; Sun, 22 Sep 2019 11:26:58 +0100
In-Reply-To: <20190922102341.GO25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
Date:   Sun, 22 Sep 2019 11:26:58 +0100
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We must not unconditionally set the DMA snoop bit; if the DMA API is
assuming that the device is not DMA coherent, and the device snoops the
CPU caches, the device can see stale cache lines brought in by
speculative prefetch.

This leads to the device seeing stale data, potentially resulting in
corrupted data transfers.  Commonly, this results in a descriptor fetch
error such as:

mmc0: ADMA error
mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
mmc0: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000001
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
mmc0: sdhci: Present:   0x01f50008 | Host ctl: 0x00000038
mmc0: sdhci: Power:     0x00000003 | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x000040d8
mmc0: sdhci: Timeout:   0x00000003 | Int stat: 0x00000001
mmc0: sdhci: Int enab:  0x037f108f | Sig enab: 0x037f108b
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
mmc0: sdhci: Caps:      0x35fa0000 | Caps_1:   0x0000af00
mmc0: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x001d8a33
mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x3f400e00
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x000000236d43820c
mmc0: sdhci: ============================================
mmc0: error -5 whilst initialising SD card

but can lead to other errors, and potentially direct the SDHCI
controller to read/write data to other memory locations (e.g. if a valid
descriptor is visible to the device in a stale cache line.)

Fix this by ensuring that the DMA snoop bit corresponds with the
behaviour of the DMA API.  Since the driver currently only supports DT,
use of_dma_is_coherent().  Note that device_get_dma_attr() can not be
used as that risks re-introducing this bug if/when the driver is
converted to ACPI.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4dd43b1adf2c..74de5e8c45c8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -495,7 +495,12 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
-	value |= ESDHC_DMA_SNOOP;
+
+	if (of_dma_is_coherent(dev->of_node))
+		value |= ESDHC_DMA_SNOOP;
+	else
+		value &= ~ESDHC_DMA_SNOOP;
+
 	sdhci_writel(host, value, ESDHC_DMA_SYSCTL);
 	return 0;
 }
-- 
2.7.4

