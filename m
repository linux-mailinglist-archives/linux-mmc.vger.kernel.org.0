Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5B63A99A
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Nov 2022 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiK1Ndh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Nov 2022 08:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiK1Ndg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 08:33:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC622DD0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669642415; x=1701178415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+fihb1vyqHig+GbCUNck5ZdIIYMDhBhc7L4g7a+QTI=;
  b=Vo6ddbNIGECJZbSkkh3TzzLCQiAKlS/0k12sFJHTUdQbi4Yz8agPiF92
   c2lmy+Q927Ur9rqf1C+Y5w1k94tXtoEUhWPSf/2Mcjy2NXKYQClSbCS0k
   7YIjdiyVR/yuQG8i8c3wA0SLW0dYlJlQt8C8+W7iyJaDza9wQGv3gKdqh
   HGbcfYgtpAsN46f2bgFhQYD0iDtHq2SVo9SzqCGUYJd/EJmLFjicDcNyz
   WnkefpZuiFBdaBZrQV3dipHfPF2cS6f72T71ZCC45lnTG26nDvuO4Tz0b
   ujSxIzsKNvH/j8+gtNDtT+wo00MWpSdXsEChU2mRUb3Sy+uhHw9JrOQSF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401121850"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401121850"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676044572"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="676044572"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH V2 3/4] mmc: sdhci: Avoid unnecessary ->set_clock()
Date:   Mon, 28 Nov 2022 15:32:58 +0200
Message-Id: <20221128133259.38305-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128133259.38305-1-adrian.hunter@intel.com>
References: <20221128133259.38305-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To avoid glitches on the clock line, the card clock is disabled when making
timing changes. Do not do that separately for HISPD and UHS settings.

Tested-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 17e5ccf9a855..beb1fe643634 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2400,8 +2400,21 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
 
+		/*
+		 * According to SDHCI Spec v3.00, if the Preset Value
+		 * Enable in the Host Control 2 register is set, we
+		 * need to reset SD Clock Enable before changing High
+		 * Speed Enable to avoid generating clock glitches.
+		 */
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_CARD_EN) {
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		}
+
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
 		if (!host->preset_enabled) {
-			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 			/*
 			 * We only need to set Driver Strength if the
 			 * preset value enable is not set.
@@ -2424,30 +2437,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 			host->drv_type = ios->drv_type;
-		} else {
-			/*
-			 * According to SDHC Spec v3.00, if the Preset Value
-			 * Enable in the Host Control 2 register is set, we
-			 * need to reset SD Clock Enable before changing High
-			 * Speed Enable to avoid generating clock gliches.
-			 */
-
-			/* Reset SD Clock Enable */
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-			clk &= ~SDHCI_CLOCK_CARD_EN;
-			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-			/* Re-enable SD Clock */
-			host->ops->set_clock(host, host->clock);
 		}
 
-		/* Reset SD Clock Enable */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
 		host->ops->set_uhs_signaling(host, ios->timing);
 		host->timing = ios->timing;
 
-- 
2.34.1

