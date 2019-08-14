Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818E38CCA0
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2019 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfHNHYn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Aug 2019 03:24:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39520 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHNHYi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Aug 2019 03:24:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC57D1A00E8;
        Wed, 14 Aug 2019 09:24:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C53A91A0075;
        Wed, 14 Aug 2019 09:24:26 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 00DE5402F1;
        Wed, 14 Aug 2019 15:24:13 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/4] mmc: sdhci-of-esdhc: add erratum A011334 support in ls1028a 1.0 SoC
Date:   Wed, 14 Aug 2019 15:26:49 +0800
Message-Id: <20190814072649.8237-4-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is to add erratum A011334 support in ls1028a 1.0 SoC

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b16f7d440f78..eb2b290447fc 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1006,6 +1006,7 @@ static struct soc_device_attribute soc_incorrect_hostver[] = {
 static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
 	{ .family = "QorIQ LX2160A", .revision = "1.0", },
 	{ .family = "QorIQ LX2160A", .revision = "2.0", },
+	{ .family = "QorIQ LS1028A", .revision = "1.0", },
 	{ },
 };
 
-- 
2.17.1

