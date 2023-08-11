Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5280779062
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Aug 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjHKNIF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 11 Aug 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKNHq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2023 09:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60830CA;
        Fri, 11 Aug 2023 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759241; x=1723295241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ckVZspebDlBIvx+fK25/shZbYaEVR+Q2R9lm4tMDkc=;
  b=AjpdotpHT6tkoYirXmgIJyAVy9pUsKAtuOYCpIDtv+Oy7pJoKAGHChq1
   CcqGlmhskIolE6NaWow60Fq5Q//oYVcp44FO7tihu3TTLFKb+aVB7JKXB
   zibX9BuCePDZa/hxcy+p6pPq+8bC7e2d3vTYPoWg61RAbF5eEA91dhdhJ
   gc4qjH67CHpF4zZ8AvLjEKfMyUVgXuwOLZs1F0frQd3AAME/uRbzOALI9
   Q8oRo0dIctNYm3qWesOEyxHyIJdU0Azq+K45FY6wVaCfWi480GWf//CuH
   Idqhtw+PKg2/GAvZhE1XNk0BwowHY8mh6/ZuV/kQguEqdaveD1BjrHilX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812843"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535514"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535514"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:06:19 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/16] mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
Date:   Fri, 11 Aug 2023 16:03:50 +0300
Message-Id: <20230811130351.7038-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
References: <20230811130351.7038-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Now that sdhci_pltfm_unregister() is unused, remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 12 ------------
 drivers/mmc/host/sdhci-pltfm.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 5a63c8818987..894f3bbe2b0f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -187,18 +187,6 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
 
-void sdhci_pltfm_unregister(struct platform_device *pdev)
-{
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
-
-	sdhci_remove_host(host, dead);
-	clk_disable_unprepare(pltfm_host->clk);
-	sdhci_pltfm_free(pdev);
-}
-EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
-
 void sdhci_pltfm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 402f4edc6ca5..bebc450d5098 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -102,7 +102,6 @@ extern void sdhci_pltfm_free(struct platform_device *pdev);
 extern int sdhci_pltfm_register(struct platform_device *pdev,
 				const struct sdhci_pltfm_data *pdata,
 				size_t priv_size);
-extern void sdhci_pltfm_unregister(struct platform_device *pdev);
 extern void sdhci_pltfm_remove(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
-- 
2.34.1

