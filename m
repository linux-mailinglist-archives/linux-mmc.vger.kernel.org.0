Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D082C3C2
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 11:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfE1J7S (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 05:59:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59322 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1J7S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 05:59:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4S9xG8h017220;
        Tue, 28 May 2019 04:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559037556;
        bh=VjKOOtW10mzctVoIWOr7BmThGBR0KwEOMigw77Jwk/o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tjac80I9t5/He5VwUJZpwNHghtMi0Tn4Pi6ZHk2rnGaJ/niY+msS9v36Q9Brl0W1u
         H2m0TvjkROFIBJMiSP4/EEBvRo6/d7sIIRate3OeMJ0b140pjdKm42EYZgkh8k8XE7
         BV13Ap4Ix9R1Fl0RmHPdqoPdC03I5T47+hUobFnY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4S9xGxe019776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 04:59:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 04:59:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 04:59:15 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4S9x7uA117581;
        Tue, 28 May 2019 04:59:14 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v3 3/3] mmc: sdhci_am654: Print error message if the DLL fails to lock
Date:   Tue, 28 May 2019 15:29:28 +0530
Message-ID: <20190528095928.26452-4-faiz_abbas@ti.com>
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

Print an error message and return if DLL fails to lock.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3c32d9fb6e1e..d0b20780dd0f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -137,6 +137,11 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
 					       val, val & DLLRDY_MASK, 1000,
 					       1000000);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
+			return;
+		}
+
 		sdhci_am654->dll_on = true;
 	}
 }
-- 
2.19.2

