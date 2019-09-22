Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD96CBA1C2
	for <lists+linux-mmc@lfdr.de>; Sun, 22 Sep 2019 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfIVKYP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 06:24:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35130 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfIVKYO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Sep 2019 06:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xLiXZz7ulDDbMepjtUEDk/czdplbAPrLVsiUAga50wQ=; b=n+DGehhQ0RbNTVJJuJ0+13oRC
        DHFvF3/9U17e5nVkuqL3nFLPMrqQoctaZ4ailL1SnuHK/GeA7ku+b0QtTjNb+uvv1UL1BGaJnQGe7
        I/r6j0M4laB44+NXa7tqpke55v3XrDyk/I+p04uK60s2L7tLSQi+YPwXM/LJm6orSmMW/0tjEWR37
        qDiM72wn84jyAlcpuSSDuOJEAlerhGeeiM+ScxV//+8flhv3GexfoqNyxA3za5V5jO2Xei8KXB5fV
        9FwtXCQzpMLdl0x+EhVafyo/m8Mh96SyqXnzKgCkiJKDqY6Mphl+pbHdYbA5y2nmzSz/C8ST43Ob+
        ZwjeKJgLA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:35104)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iBz20-0006RF-Dv; Sun, 22 Sep 2019 11:23:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iBz1p-0007e5-Px; Sun, 22 Sep 2019 11:23:41 +0100
Date:   Sun, 22 Sep 2019 11:23:41 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] Fix sdhci-of-esdhc DMA coherency
Message-ID: <20190922102341.GO25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

The following patch set is a result of looking at the ADMA errors
observed on SolidRun's LX2160A board, caused by coherency mismatch
between DT and hardware.

The first patch improves the debugging by dumping the ADMA table
using the DMA address, which can be compared with the DMA address
reported in the register dump.  It also prints the interrupt status
that we read, whereas the register dump contains the _cleared_
interrupt status.

The second patch modifies sdhci-of-esdhc to set the DMA snoop bit
depending on whether DT marks the device as coherent or not.  With
this patch applied, driver will now set the hardware to match the
contents of DT, rather than always DMA snooping.  As explained by
Robin, if the hardware snoops the CPU caches, but the DMA API layer
does not expect this, the hardware can read stale data.  The hardware
state and the DMA API must always agree wrt this, for the sake of
data integrity.  Mismatch risks substantial filesystem corruption.

The third patch marks the LX2160A esdhc devices as dma-coherent.
Other users of the driver are not touched; I do not have the
information to know whether DMA snooping (coherency) is available
on other SoCs using this driver.  However, given the risk of
filesystem corruption, it is important no matter what that the
DMA API layer and the hardware agree - even if it means defaulting
to being non-coherent.

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c              |  7 ++++++-
 drivers/mmc/host/sdhci.c                       | 15 ++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
