Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5E2C3C5
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE1J7Z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 05:59:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37452 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfE1J7R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 05:59:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S9xCj8059886;
        Tue, 28 May 2019 04:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559037552;
        bh=0qBRqX2XMtfSxCuz8/c7XjoZrHWlmLEUfZ3Cw72jWdA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eq57DgCP8w9+l5KwrA2SV0MEoscaZwb2uorHz78Pm3r4t4QJBO9++Xw0v6HAdghB+
         BNju/nYoVhUruIoY/mh/FceZ8IwknQRiF1lY5Fd2J5k3Q6PVgBnhFnhJFFmPW2n5YE
         cXOVAYf1ZY5O7k+HlSGEsgyFmShKwhS4uhHVeQic=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S9xCdB019673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 04:59:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 04:59:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 04:59:11 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S9x7u8117581;
        Tue, 28 May 2019 04:59:10 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v3 1/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date:   Tue, 28 May 2019 15:29:26 +0530
Message-ID: <20190528095928.26452-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
References: <20190528095928.26452-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index a91c0b45c48d..3222ea4d584d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -231,7 +231,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
-			   ctl_cfg_2, SLOTTYPE_MASK);
+			   SLOTTYPE_MASK, ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2

