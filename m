Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA6982D7
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHUScH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 14:32:07 -0400
Received: from mail-eopbgr700112.outbound.protection.outlook.com ([40.107.70.112]:7776
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729111AbfHUScG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGcLPYUj3PcZAh3aODTACIM1SM+tz8qhxKWsrzJf9Gy5YutTfK0MGPnhoMhMtBkJC+RME34vaKKq658yl40XlQqm4voTxfK7AOcR7mQYLVUzdQwQL31ELpCG+GTQz17uxdcanki1VY5LS3e0MoAHPjKcSpiYL9Eh4M9XARYEiOZIm/jtnAlNM7iWCU8gFp2+VBagrIe1ZMGe+bF0GDaw1Tb1wDKe2TNMGHeDyBVYaJB7W3H9CbP6tjJLb4xhwYcWctyLOL8t6SEyy1+lNqjZzVxIVJd/UzKwXCzGMKrCvJixXx+WMnLQPo3y/cljoloUl0J96lqnGzaH8Y34KW7qkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q+4ec9Q98lPMYFZ16r58O1zIwiI1eWKyBoHlAqbbUU=;
 b=SofSRucMBIi+2J5v015YRBVJFdndFEIR9H6i2XRkn/1S1QH4/0ECGnwYfHu/jrq5yi1ZLnm30wVW/arVgLgUajfRnYD3Omk8oGircZz8UmVpnX4FB0mOHjK6yZ/r7gSlrblwc55Wmaota95vtgV6YJ0Ze6WRkAW9L4av1dOml4P7mltffm2G+P0voydxGVCVmw0IX4O2jZMjnf5y/ad8Fggr9PgETTOVSbbBl2cUQiVS4wr3r5AxtJjn72Z7n9i9+c2bQz0domMrAD2DQZIDrNDwTXfXmGR8dALZmQumCye1YL1ooHRmv2UuUuhO8avw44Uwr7mXYkbDeuRdZB+iHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q+4ec9Q98lPMYFZ16r58O1zIwiI1eWKyBoHlAqbbUU=;
 b=Gwq7/MqU43D+oDZR0Oua/7DFcM0HCsdvO3MJ2oTWQeWkZgjHQk3NmiszrsFq7Y0kf5GK/CF067edpV33BJGaeW3BiQCQj66xZ+hoIse+33DIRacP8011MrTEf5R86bwqC8TdtxD3ybT7MQMHyeYa6JbRvawCi63Ps7GX8OgGVnA=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1407.namprd16.prod.outlook.com (10.175.3.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 18:31:57 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 18:31:57 +0000
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
Subject: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL
 register name
Thread-Topic: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and
 DLL register name
Thread-Index: AQHVWE62T0ecVtGIpkCRDigrDBfTMQ==
Date:   Wed, 21 Aug 2019 18:31:57 +0000
Message-ID: <1566412313-5967-1-git-send-email-shirley.her@bayhubtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To MWHPR16MB1455.namprd16.prod.outlook.com (2603:10b6:320:28::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [209.36.105.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9148353-a776-44ac-5480-08d72665d8e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1407;
x-ms-traffictypediagnostic: MWHPR16MB1407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB140796721171E2CB5EDEADED8BAA0@MWHPR16MB1407.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39830400003)(366004)(199004)(189003)(476003)(14454004)(508600001)(5660300002)(8676002)(53936002)(7736002)(52116002)(110136005)(25786009)(486006)(2501003)(256004)(6116002)(14444005)(107886003)(81156014)(81166006)(8936002)(71190400001)(71200400001)(2906002)(36756003)(6486002)(386003)(66946007)(2201001)(6512007)(66446008)(66476007)(66556008)(64756008)(3846002)(4326008)(102836004)(6436002)(316002)(54906003)(66066001)(305945005)(99286004)(186003)(2616005)(26005)(6506007)(50226002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1407;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G3WRLaxDQZTrYwudyRLXR+reU38rlHKcklxjh8SVentZoUEn826XbE3MZCyr8bXAgQ5dc0+uxgwmEDG/cy25vWv7+C0UCMVs44KxyNJg/quNexln2BnZxUzsBXe1HzxAID2A5I9quBJ+a+57upS+RCCBdaXLo3l9nnsLTukxqwUn84OGsOq96EL5NDHPft0NBULN+ia+CgTQ4Im8ZVPoe8vlSpJKzXyUzEYBjzRZu4eDYA8XylYsVdp8TCaVuVpdydLP7qE7SeluAm64u8P2bLqrUvGTtz8+V4VSBJUJoN9XyRpy5RHbpvWbRVthz/hBECVYEzwVtiSZmwKfe1mFwa8efj8O0b5uuA9CVd30/FJXZdwYMtAdug6hk7jzOL0uWQQdqxS11Abe8XUAtLB9R2Frnk/OBhISw/JHCRyfcsw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9148353-a776-44ac-5480-08d72665d8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 18:31:57.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klVkSVBd0NwvO3J2kTxKFRjmZC6urhHZ6Kn9Y+D56MQkXFMl0PcrC4JiTbCagGszckIqOPCzc1GyipgcsyFnulosaconhTUaB0LEu3Yp0CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1407
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change O2 Host PLL and DLL register name

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V8:
 1. fix patch format error

change in V7:
 1. change subject

change in V6:
 1. change subject and commit message to match the patch
 2. change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1

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
 drivers/mmc/host/sdhci-pci-o2micro.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..b3a33d9 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,7 +51,7 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
@@ -316,23 +316,23 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
ci_host *host)
 	u32 scratch32;
=20
 	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 	udelay(1);
 	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* PLL force active */
 	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* Wait max 20 ms */
 	timeout =3D ktime_add_ms(ktime_get(), 20);
 	while (1) {
 		bool timedout =3D ktime_after(ktime_get(), timeout);
=20
-		scratch =3D sdhci_readw(host, O2_PLL_WDT_CONTROL1);
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
 		if (scratch & O2_PLL_LOCK_STATUS)
 			break;
 		if (timedout) {
@@ -350,9 +350,9 @@ static void sdhci_o2_enable_internal_clock(struct sdhci=
_host *host)
=20
 out:
 	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 }
=20
 static int sdhci_o2_get_cd(struct mmc_host *mmc)
--=20
2.7.4

