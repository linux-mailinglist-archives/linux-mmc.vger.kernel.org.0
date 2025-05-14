Return-Path: <linux-mmc+bounces-6495-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F3AB601E
	for <lists+linux-mmc@lfdr.de>; Wed, 14 May 2025 02:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA22863898
	for <lists+linux-mmc@lfdr.de>; Wed, 14 May 2025 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7BC20DF4;
	Wed, 14 May 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tIZ+4Gt2"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F331CD0C;
	Wed, 14 May 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182328; cv=none; b=NWwuxUYyD19rDX4tR9p/oL1tZlP2ilcYDuoLPSW7lmS2uaZnu6eIgXpVgp08Q7nViN3LXx2+JuhFzVY3KonkMqv8rc+9kh9VAixmfewMNTzfyJ8soNfI+IKXZzf+O7aF95O+NI5jxSQSLXf62s5mQGUm5vsYfg9IkQWaqSdqU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182328; c=relaxed/simple;
	bh=dgjJ844r8BgnZ2mWaTMe1zHaDX+mRVRhsLIQvxqYhzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBBs4TbgdDtVmhNfu4vilb92d4gmUCNIuxE+/WKe0uI1WqNiw26mH4i34CpcpgMPyIe4zFCUWE20PrgoBIgKh25Bvw+QpAutRFyvMoS6CszAHTECTzouObNmT0PWraCnbS6otec+GCZUKE+Zli5GtDhd5Z93vZIKGVFEf8QKCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tIZ+4Gt2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54E0PEES2457992
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 19:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747182314;
	bh=XXR+h3GqlCTeX8EJC/ptbJ1T3qhG9N1tHc2h+giQv+k=;
	h=From:To:CC:Subject:Date;
	b=tIZ+4Gt23xS2gjY7gfDula52QWbp2gP7P+GvPKivsqTqpAVZPV2wAsJN/41infqR+
	 0qrU0UMJZUpykKyl1Cb4HsmWbR3SjvUBRYvjI+8gmd779CdfMpvALqMgyv0Cj/wDdc
	 VZu+i8BF8fh8cZPJOzs8wDeNc+pzhtEBEffh2WkA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54E0PEZ9115900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 19:25:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 19:25:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 19:25:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54E0PDeM015693;
	Tue, 13 May 2025 19:25:13 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>
Subject: [PATCH v5] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA quirk to am62 compatible
Date: Tue, 13 May 2025 19:25:13 -0500
Message-ID: <20250514002513.1179186-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add a new struct for platform data for the ti,am62-sdhci compatible to
apply additional quirks, namely "SDHCI_QUIRK2_SUPPRESS_V1P8_ENA", to
host controllers with am62 compatible.

This fixes MMC init failures seen across am62x boards.

Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
Cc: stable@vger.kernel.org
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- Drop support for quirk in sdhci.c
- Add quirk member to driver data struct that shall be per compatible quirks

Tested on am62x SK, am64x EVM and am64x SK. Tested-bys are welcome

Link to v4:
https://lore.kernel.org/linux-mmc/20250424180036.1541568-1-jm@ti.com/
Link to v3 RESEND:
https://lore.kernel.org/linux-mmc/8678d284-db12-451a-b789-2b75f9932f9f@ti.com
Link to v2:
https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/
---
 drivers/mmc/host/sdhci_am654.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f75c31815ab0..c2bea228a67a 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -166,6 +167,7 @@ struct window {
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
+	u32 quirks;
 #define IOMUX_PRESENT	(1 << 0)
 #define FREQSEL_2_BIT	(1 << 1)
 #define STRBSEL_4_BIT	(1 << 2)
@@ -356,6 +358,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
+static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
+	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
+			if (ret < 0) {
+				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
+				       mmc_hostname(mmc));
+				return -EIO;
+			}
+		}
+		return 0;
+	}
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
 {
 	writeb(val, host->ioaddr + reg);
@@ -650,6 +675,18 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
+static const struct sdhci_pltfm_data sdhci_am62_4bit_pdata = {
+	.ops = &sdhci_j721e_4bit_ops,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
+	.pdata = &sdhci_am62_4bit_pdata,
+	.flags = IOMUX_PRESENT,
+	.quirks = SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA,
+};
+
 static const struct soc_device_attribute sdhci_am654_devices[] = {
 	{ .family = "AM65X",
 	  .revision = "SR1.0",
@@ -872,7 +909,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 	},
 	{
 		.compatible = "ti,am62-sdhci",
-		.data = &sdhci_j721e_4bit_drvdata,
+		.data = &sdhci_am62_4bit_drvdata,
 	},
 	{ /* sentinel */ }
 };
@@ -906,6 +943,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	sdhci_am654->flags = drvdata->flags;
+	sdhci_am654->quirks = drvdata->quirks;
 
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
@@ -940,6 +978,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

base-commit: aa94665adc28f3fdc3de2979ac1e98bae961d6ca
-- 
2.49.0


