Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30B867BE
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Aug 2019 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404098AbfHHROG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 13:14:06 -0400
Received: from gateway20.websitewelcome.com ([192.185.64.36]:45254 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbfHHROG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 13:14:06 -0400
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 13:14:05 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 18D69400D0A68
        for <linux-mmc@vger.kernel.org>; Thu,  8 Aug 2019 10:49:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vlf0hFBpZiQervlf0hcOj0; Thu, 08 Aug 2019 11:53:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y3YgOHS6bY8+iBEodkrq3S2tL1ugedHa5kZcaV5LOVE=; b=pm2/lEJh9Ul5SL9snCGYSz6+T/
        vNV/CQJj4NXeMcXcf7QOz3xPz0vj/RvFtkGrjDadQq0E37YT+ydD1QBx/9odbiJn+KkGEeeCWD2fO
        dqqqkZoGgt5A/fbDSA2o8gGiztYvFjtOXMBU8O+AhXD0DGEE/4vpXfFiMAOGhZ+aRvT31VVvRCOUX
        IZuS7L4cmD+o75kIHpo4jjzXynYDrlywhoz+/zlGu0YnGWKcOZYPtzApBFurDIQqSMYQeGpEMP4V8
        BXe6DVClkYXxCplZwcSNGWwgGirjL4zMBLBkhCPa9IA4KKs7HYxx4VIJAFCELEKfyYMR44jI9UNuN
        iowGchKQ==;
Received: from [187.192.11.120] (port=49892 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvley-000Ebr-O5; Thu, 08 Aug 2019 11:53:04 -0500
Date:   Thu, 8 Aug 2019 11:53:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-cadence: use struct_size() helper
Message-ID: <20190808165301.GA30877@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hvley-000Ebr-O5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:49892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct sdhci_cdns_priv {
	...
        struct sdhci_cdns_phy_param phy_params[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params

with:

struct_size(priv, phy_params, nr_phy_params)

Also, notice that, in this case, variable priv_size is not necessary,
hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-cadence.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 163d1cf4367e..1768a13f89be 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -337,7 +337,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	size_t priv_size;
 	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
@@ -351,8 +350,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 		return ret;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
-	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
+	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
+				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
-- 
2.22.0

