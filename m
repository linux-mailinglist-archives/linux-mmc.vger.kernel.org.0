Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB11323E8
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Jan 2020 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGKk1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Jan 2020 05:40:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50226 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgAGKk1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2020 05:40:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 007AeDDY083271;
        Tue, 7 Jan 2020 04:40:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578393613;
        bh=zvIW8/BtCQ5x8IHunoGoJlqB0iUARRig1KyivGH+pl8=;
        h=From:To:CC:Subject:Date;
        b=sgrUNFm+HFtu/0WLloZ6J1rLTAV5L3JDioCr933elKSaMrlRtRKw+7c5XjElhOn45
         DAD2DoaZ8bbnE32ekkkGGnnU3G6O1SC8Y7g07OXg/any2ItmU99pjFqjNHSR8eR+al
         mY8GFQsCbvzQE5NYFxcWrV4VEJxK23NQ3Kw+m55Y=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 007AeDEC012098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 04:40:13 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 04:40:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 04:40:12 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007Ae96n032006;
        Tue, 7 Jan 2020 04:40:09 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <f.fainelli@gmail.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <nsaenzjulienne@suse.de>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 7 Jan 2020 12:40:40 +0200
Message-ID: <20200107104040.14500-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- jump to err: instead of returning in case of EPROBE_DEFER

Regards,
Peter

 drivers/mmc/host/bcm2835.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 99f61fd2a658..c3d949847cbd 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1393,7 +1393,17 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->dma_chan = NULL;
 	host->dma_desc = NULL;
 
-	host->dma_chan_rxtx = dma_request_slave_channel(dev, "rx-tx");
+	host->dma_chan_rxtx = dma_request_chan(dev, "rx-tx");
+	if (IS_ERR(host->dma_chan_rxtx)) {
+		ret = PTR_ERR(host->dma_chan_rxtx);
+		host->dma_chan_rxtx = NULL;
+
+		if (ret == -EPROBE_DEFER)
+			goto err;
+
+		/* Ignore errors to fall back to PIO mode */
+	}
+
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

