Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6D95086
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Aug 2019 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfHSWLo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Aug 2019 18:11:44 -0400
Received: from mail-eopbgr800118.outbound.protection.outlook.com ([40.107.80.118]:28672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728136AbfHSWLo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Aug 2019 18:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpb7fTK3RJdy2Vnb9fpuknVZNefKmK6F844/M9Yn04QRmo0Lr4EgehoEsRqsx/H+xKpBHr+DDYIUrctfdrQU4vbXfk6o+fqMzaAaWOFMeE4rXjyyexb9I8OZuY/IIv1GmpLbF7H5tvYzE0ZUUmr3lk4ZBmPJy3xNrPiRgcJ7CGj70l97iDmTn1Qt/pm7uMMqWDSbX+dibtnSQKUfkg9jbN7QyLSxW0LxCdsjaPh1p3w2p3LN1+b3wYHSvV601oBwdT0SX5vPY1buxR53cRCBJbGmGGpGvXNdhECxRRkdVlddS0wJbQEL0iyhu7CldiKRWw8hpC6IrBLBmNMvR/BusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yJVnVk7ssY/XCh/dEZFa9MlqdKvPOo7J9oz+V/iS6U=;
 b=QDexTq119C/M4K6c2W65f6gnwUf0Ef/pR3359LgIjxx+2Mjbwzaq7kkmBVYqRfu7+1nkpL5t8y4Iiu5iUjmZl2TW2cER5dUgEohZLOhXci8dateAr8ZAPmytYe8j+AdvwUWEtNCFkKXUvcLCxkrwKuRz9bK1JgRBnEqa0GZlhVMaCvLEyklTFLhUTs7ydw7zUF2X//WwcYRi/C7MIjvHHcbBicC8nhzlUFJ6iO9KFiv68ctyeaCG9dWJsi5C+Zff/dKJyyoCLdXfyrBFAk8ezR0inIpD1A9xakCXD9shlRRoGYSFVAURqYgnp5DHnW8FieqDfZzJn9n8dW26q8WaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yJVnVk7ssY/XCh/dEZFa9MlqdKvPOo7J9oz+V/iS6U=;
 b=iFvKlaxldvDrfJL0A2L1e2CwBXkizjZRV/gEzSOkkxjNOsEz7ftuKWK/1eVWwqs1N07ANaoQgka9uRyhFDusYKLIN0dY40FdKNlz1zhGAXdGC4w+4tte52s5EDHUxCFvCfmu0OuSF2VXv9zBh52IKndqa8IWEPwEmIRW4kXy+bo=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB0029.namprd16.prod.outlook.com (10.172.101.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 22:11:39 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 22:11:39 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: Subject: [PATCH V7 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock Phase shift issue
Thread-Topic: Subject: [PATCH V7 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock Phase shift issue
Thread-Index: AQHVVtsSwnakzAws5k2c+wsSqh485w==
Date:   Mon, 19 Aug 2019 22:11:39 +0000
Message-ID: <1566252696-5206-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To MWHPR16MB1455.namprd16.prod.outlook.com
 (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156fb58b-38dd-459a-99e5-08d724f2353d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR16MB0029;
x-ms-traffictypediagnostic: MWHPR16MB0029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB00297B734138A47B25BC4A8D8BA80@MWHPR16MB0029.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39840400004)(366004)(136003)(189003)(199004)(5660300002)(2616005)(476003)(6436002)(107886003)(86362001)(486006)(26005)(71190400001)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(66066001)(2201001)(7736002)(102836004)(36756003)(256004)(53936002)(8676002)(6486002)(6512007)(14454004)(81156014)(8936002)(186003)(6506007)(386003)(2501003)(4326008)(25786009)(14444005)(50226002)(316002)(3846002)(305945005)(2906002)(6116002)(110136005)(54906003)(81166006)(52116002)(508600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB0029;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qBJo47wvaZowH+wOzIIx4tbSeI+X1CkXN1KUrA5omGJR4vibaXfALMfGBDo1qLaRJphVt8SGBV+M5abTuE1bTKDNIFCh2DZbIZt6YYZ6nGE/68RZXr7UBaDslQRkZ84Yg3Q/Izg72i1vSGS/tI/vyojLkIilPMawRSEd6ba6eX5MMLyUnvJAj78xRuD+nohKZXDRHzqYZ7otf6Cf76M66t8sIr7PTrfs0W5chy56/iR+VSoXVRIdzRSjzhAcTpNJgzRyPzr7olGXqScgOP/YSdmjS6n9AWJzhiinE95ecykO4T+U+opDKm1cM9tcENjNZ+INunelWeyF195ESJxDwksZ46aswiQylMiXiI14xgxxflY9tejb4G0Ga098LRGbFQASEzGOR6ZNnwCVYOtR0s8uysbgaMUReWVvrc3yCTY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156fb58b-38dd-459a-99e5-08d724f2353d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 22:11:39.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bKWu58XnaOBajaJvMZUqzHhjWsLRfWya4F+hK+fUb1Fu1vp4wSE3G1vXZidStKF8ONxyrxJO8TmiGb9LUgw61e+3A2JCK9kaQktit8/RBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0029
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in V7:
 1. change subject
 2. change the sdhci_o2_wait_dll_detect_lock function
 3. add suitable usleep_range() to detect dll lock status

chagne in V6:
 1. define constant by using array size
 2. add more explanation for the code
 3. fix loop forever code error

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
 drivers/mmc/host/sdhci-pci-o2micro.c | 125 +++++++++++++++++++++++++++++++=
+++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 021e481..f0b3d93 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -11,6 +11,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
=20
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -55,9 +56,18 @@
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[] =3D {0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+#define DMDN_SZ ARRAY_SIZE(dmdn_table)
+
+struct o2_host {
+	u8 dll_adjust_count;
+};
+
 static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
 {
 	ktime_t timeout;
@@ -133,7 +143,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
=20
-	sdhci_o2_enable_internal_clock(host);
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
=20
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
@@ -141,6 +152,7 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
 	u32 scratch_32;
+
 	pci_read_config_dword(chip->pdev,
 			      O2_SD_PLL_SETTING, &scratch_32);
=20
@@ -151,6 +163,25 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *=
chip, u32 value)
 			       O2_SD_PLL_SETTING, scratch_32);
 }
=20
+static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host)
+{
+	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+}
+
+/*
+ * This function is used to detect dll lock status.
+ * Since the dll lock status bit will toggle randomly
+ * with very short interval which needs to be polled
+ * as fast as possible. Set sleep_us as 1 microsecond.
+ */
+static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
+{
+	u32	scratch32 =3D 0;
+
+	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
+		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 1, 1000000);
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -188,6 +219,83 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
t *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+/*
+ * This function is used to fix o2 dll shift issue.
+ * It isn't necessary to detect card present before recovery.
+ * Firstly, it is used by bht emmc card, which is embedded.
+ * Second, before call recovery card present will be detected
+ * outside of the execute tuning function.
+ */
+static int sdhci_o2_dll_recovery(struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
+	struct sdhci_pci_chip *chip =3D slot->chip;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev,
+			O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &=3D 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	while (o2_host->dll_adjust_count < DMDN_SZ && !ret) {
+		/* Disable clock */
+		sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+		/* PLL software reset */
+		scratch_32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		scratch_32 |=3D O2_PLL_SOFT_RESET;
+		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
+
+		pci_read_config_dword(chip->pdev,
+					    O2_SD_FUNC_REG4,
+					    &scratch_32);
+		/* Enable Base Clk setting change */
+		scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SET;
+		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
+		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
+
+		/* Enable internal clock */
+		scratch_8 =3D SDHCI_CLOCK_INT_EN;
+		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+		if (sdhci_o2_get_cd(host->mmc)) {
+			/*
+			 * need wait at least 5ms for dll status stable,
+			 * after enable internal clock
+			 */
+			usleep_range(5000, 6000);
+			if (sdhci_o2_wait_dll_detect_lock(host)) {
+				scratch_8 |=3D SDHCI_CLOCK_CARD_EN;
+				sdhci_writeb(host, scratch_8,
+					SDHCI_CLOCK_CONTROL);
+				ret =3D 1;
+			} else {
+				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
+					mmc_hostname(host->mmc),
+					o2_host->dll_adjust_count);
+			}
+		} else {
+			pr_err("%s: card present detect failed.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+
+		o2_host->dll_adjust_count++;
+	}
+	if (!ret && o2_host->dll_adjust_count =3D=3D DMDN_SZ)
+		pr_err("%s: DLL adjust over max times\n",
+		mmc_hostname(host->mmc));
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev,
+				   O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 |=3D 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	return ret;
+}
+
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
@@ -202,7 +310,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mm=
c, u32 opcode)
=20
 	if (WARN_ON(opcode !=3D MMC_SEND_TUNING_BLOCK_HS200))
 		return -EINVAL;
-
+	/*
+	 * Judge the tuning reason, whether caused by dll shift
+	 * If cause by dll shift, should call sdhci_o2_dll_recovery
+	 */
+	if (!sdhci_o2_wait_dll_detect_lock(host))
+		if (!sdhci_o2_dll_recovery(host)) {
+			pr_err("%s: o2 dll recovery failed\n",
+				mmc_hostname(host->mmc));
+			return -EINVAL;
+		}
 	/*
 	 * o2 sdhci host didn't support 8bit emmc tuning
 	 */
@@ -370,6 +487,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
=20
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -395,12 +513,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *sl=
ot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
 	u32 reg, caps;
 	int ret;
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
=20
+	o2_host->dll_adjust_count =3D 0;=09
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
@@ -687,4 +807,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.resume =3D sdhci_pci_o2_resume,
 #endif
 	.ops =3D &sdhci_pci_o2_ops,
+	.priv_size =3D sizeof(struct o2_host),
 };
--=20
2.7.4

