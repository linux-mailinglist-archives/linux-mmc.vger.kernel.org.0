Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37F982F7
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfHUScM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 14:32:12 -0400
Received: from mail-eopbgr700113.outbound.protection.outlook.com ([40.107.70.113]:58720
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbfHUScM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHjZCP8EwF6vh/k+eOFr/+jVGOE4ts/2q8A8wi7d43IFM3ebeE0CxUB9RrMwH7D63DyNeRJHxgedCJ6Rfiy3/NmujTqvu1JZMYbGBkzv0HvUYYaGrPXZ+kPdDn4gcXKk/iU6owQ1VN4iQAQZokwWJ7ZM+PNtlh/7MxlhTKtTWdUDLtzS+QFKcQnbbDmPbHcPUrN313tW4jnNxVZn6WwM1AxGf23zJSIz4pug056hZvd3PZId51ljtO9Ia7Ay3CD/vNm/BdBrJFFtk9fTPUDyhCAnRgMofrIMXzSi/e7WcORJ2VCyUUehTbyGTCXvaQh1d28DlsR2zgp+/U74XUtNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN3J9XQsCKODmoKEnJnFtJzBwsNukXdglfYpBoWEg2c=;
 b=J0nRY/A9p3FWHhG+eYpbW7Dqm5fL6Zy7uotSDnLETA8r8zDaJfu3lLBN9/PPsaxiQKi4Uz82Vk4wziTDboKlvh4/CE/V4EQjijUrJCH/4jbL7h82HucgRYK1ITGUeOfNmVcULIVkIXG7kavk/LS/JZaVjWbd4/GAnNmR2lQ5Q/bUky/Oj8GKYB5/ZtH3IT3reaj3hFouIFcSNux49Z/cneU3dM05P/CAmpNJPN0Khq+zDEINYlFrhkN4l61QxY9OZao4wBH5niwEDn6cXMBlt/qXGSNZaQnHFKp4CiX/1sSGdhbUOTVY8xyN7D5XGj4SZ1dJNWZROND+KM2ZBD3piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN3J9XQsCKODmoKEnJnFtJzBwsNukXdglfYpBoWEg2c=;
 b=gO7zkr3OcfzWpPt4kZxfPX1NsOuru0GCcUoWxxNttJB2JFknbw+FVkQGNKu0odbukOlWX1KpvxZgO39WTv47RTVigiCf9+dz9AR4ghAWkRh9IcX32rSRsMZD+FBOrFxi3uku13S2/MbAhlAA00avJXgEcXcsy5txMD/WwpbDxO8=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1407.namprd16.prod.outlook.com (10.175.3.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 18:32:10 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 18:32:09 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux.kernel@vger.kernel.org" <linux.kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V8 2/3] mmc: sdhci-pci-o2micro: Modify get CD status function
Thread-Topic: [PATCH V8 2/3] mmc: sdhci-pci-o2micro: Modify get CD status
 function
Thread-Index: AQHVWE6+AhZXyrKGWUqlHWdkvW200w==
Date:   Wed, 21 Aug 2019 18:32:09 +0000
Message-ID: <1566412327-6018-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b08a3bb6-ded4-4c72-645c-08d72665e077
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1407;
x-ms-traffictypediagnostic: MWHPR16MB1407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB14075640AC4998EAECE0D2E38BAA0@MWHPR16MB1407.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39830400003)(366004)(199004)(189003)(476003)(14454004)(508600001)(5660300002)(8676002)(53936002)(7736002)(52116002)(110136005)(25786009)(486006)(2501003)(256004)(6116002)(14444005)(107886003)(81156014)(81166006)(8936002)(71190400001)(71200400001)(2906002)(36756003)(6486002)(386003)(66946007)(2201001)(6512007)(66446008)(66476007)(66556008)(64756008)(3846002)(4326008)(102836004)(6436002)(316002)(54906003)(66066001)(305945005)(99286004)(186003)(2616005)(26005)(6506007)(50226002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1407;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9oACzZMBn7L/xZRH2SRaZ7t4U7UU2UfjyKWwNUAxkqwQDzOOy8qT2F/MES+86J3hSaIPOVwyn8KY4CLTWpm8J+brKoQOrCCeVC/OI/IzbBGdw54du7+NKl+KRHucQm6hrsrQcapKU3pIJLuiUE780wC+koaOo/AqSkOKB+KGwVtAzjkCJcbUh5RwwN4mGTnoYQXNQx+a8vtijRNb6cDFsgmoBjjz/qKzreLw3MgH/GJnp3VbJM7U8VImc3YOxeX3JVdVYv7yuX0vZLSg66snTWULMKms+tpsIvlO9yWJoIp9L8mcA5BbR3e2gkS1nmi4CtQfZiS/hyAPwYhWPw6BffyTJbGsUy+dcZeTUhMBYFv7Hp/o2zrOzxG/b2aSTEDdhS8Xzz3i95x2FQqbIRo11EzUW8QyYZ4bgid4mevzFy8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08a3bb6-ded4-4c72-645c-08d72665e077
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 18:32:09.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ad+mUVmdVnTa7IhBnTphFEJv3M8EKl6REJPGZ9rZmc9/PU/mmprD2ANJ0W0rOwmAnxEfUdT6Cb+cvz7zxldBOHcbXo8PN7AJcsNt8RKyaNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1407
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Modify get CD status function

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V8:
 1. fix patch format error

change in V7:
 1. change subject to match the patch
 2. move functions in preparation to fix DLL lock phase shift issue

change in V6:
 1. change subjec and commit message to match the patch
 2. modify the get CD status function
 3. re-arrange the order of some functions

change in V5:
 1. split 2 patches into 3 patches
 2. make dll_adjust_count start from 0
 3. fix ret overwritten issue
 4. use break instead of goto

change in V4:
 1. add a bug fix for V3

change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count to O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count to sdhci-pci-o2micro.c

chagne in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retuning HS200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 187 ++++++++++++++++++-------------=
----
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index b3a33d9..57c8b83 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -58,6 +58,100 @@
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	/* Wait max 50 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 50);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
+		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
+			break;
+
+		if (timedout) {
+			pr_err("%s: Card Detect debounce never finished.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
+static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u16 scratch;
+	u32 scratch32;
+
+	/* PLL software reset */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+	udelay(1);
+	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* PLL force active */
+	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* Wait max 20 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (scratch & O2_PLL_LOCK_STATUS)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			goto out;
+		}
+		udelay(10);
+	}
+
+	/* Wait for card detect finish */
+	udelay(1);
+	sdhci_o2_wait_card_detect_stable(host);
+
+out:
+	/* Cancel PLL force active */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+}
+
+static int sdhci_o2_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+
+	sdhci_o2_enable_internal_clock(host);
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
+{
+	u32 scratch_32;
+
+	pci_read_config_dword(chip->pdev,
+			      O2_SD_PLL_SETTING, &scratch_32);
+
+	scratch_32 &=3D 0x0000FFFF;
+	scratch_32 |=3D value;
+
+	pci_write_config_dword(chip->pdev,
+			       O2_SD_PLL_SETTING, scratch_32);
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -136,19 +230,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
c, u32 opcode)
 	return 0;
 }
=20
-static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
-{
-	u32 scratch_32;
-	pci_read_config_dword(chip->pdev,
-			      O2_SD_PLL_SETTING, &scratch_32);
-
-	scratch_32 &=3D 0x0000FFFF;
-	scratch_32 |=3D value;
-
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
-}
-
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
 	int ret;
@@ -284,86 +365,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_c=
hip *chip,
 	host->irq =3D pci_irq_vector(chip->pdev, 0);
 }
=20
-static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u32 scratch32;
-
-	/* Wait max 50 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 50);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
-		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
-		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
-			break;
-
-		if (timedout) {
-			pr_err("%s: Card Detect debounce never finished.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			return;
-		}
-		udelay(10);
-	}
-}
-
-static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u16 scratch;
-	u32 scratch32;
-
-	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
-	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-	udelay(1);
-	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-
-	/* PLL force active */
-	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-
-	/* Wait max 20 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 20);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
-		if (scratch & O2_PLL_LOCK_STATUS)
-			break;
-		if (timedout) {
-			pr_err("%s: Internal clock never stabilised.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			goto out;
-		}
-		udelay(10);
-	}
-
-	/* Wait for card detect finish */
-	udelay(1);
-	sdhci_o2_wait_card_detect_stable(host);
-
-out:
-	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
-	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
-}
-
-static int sdhci_o2_get_cd(struct mmc_host *mmc)
-{
-	struct sdhci_host *host =3D mmc_priv(mmc);
-
-	sdhci_o2_enable_internal_clock(host);
-
-	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-}
-
 static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 {
 	/* Enable internal clock */
--=20
2.7.4

