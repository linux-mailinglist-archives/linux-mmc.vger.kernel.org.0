Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931D0DE83
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfD2I4A (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 04:56:00 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:14252
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727584AbfD2I4A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 04:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw4JsQTAR3VN33f1rpui0rIdicbiNvvdzHorELd0lzI=;
 b=KDI8n9nq6tCTw8jDB40fZK9pjIbDFqQhK1PmBaUIGRbo8Q9XYiLxGivaC2nHaHvJZC++RTJqiswta+Vxc4SFCLr/1F+V02jgl6MSxKpnSmyb3Dp+oS+zIJ9D1ApM23m+bazhi3vyjF1SttdC/gT+75QmvbIOt2VrkqfhwC/ta1c=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4991.eurprd04.prod.outlook.com (20.177.49.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 08:55:43 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:55:43 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] mmc: add HS400 support for iMX7ULP
Thread-Topic: [PATCH v2 3/3] mmc: add HS400 support for iMX7ULP
Thread-Index: AQHU/mlTU1dJiR50vEGY9vRlWd2jgA==
Date:   Mon, 29 Apr 2019 08:55:43 +0000
Message-ID: <20190429090310.25484-4-haibo.chen@nxp.com>
References: <20190429090310.25484-1-haibo.chen@nxp.com>
In-Reply-To: <20190429090310.25484-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK0PR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:2e::35) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 733e4963-8733-4362-a918-08d6cc80763a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4991;
x-ms-traffictypediagnostic: VI1PR04MB4991:
x-microsoft-antispam-prvs: <VI1PR04MB49913649B07A4EF872A7C70490390@VI1PR04MB4991.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(316002)(53936002)(99286004)(6436002)(110136005)(54906003)(36756003)(81156014)(81166006)(2501003)(6512007)(6486002)(8676002)(97736004)(14454004)(50226002)(25786009)(478600001)(4326008)(6116002)(66556008)(3846002)(66476007)(64756008)(7736002)(66946007)(305945005)(71200400001)(71190400001)(66446008)(5660300002)(68736007)(73956011)(66066001)(52116002)(2906002)(14444005)(86362001)(11346002)(256004)(102836004)(6506007)(386003)(8936002)(26005)(186003)(2616005)(476003)(53346004)(446003)(486006)(76176011)(1076003)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4991;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xFJmiDveOnuz26W6OUYm1TMhIeSgzShDkpjVoAUxKQbUmg5J4/jxKqdsoxRAhqH/SZwZDXMW4bN3OwJywo0iuHNqAxj34txoq+3J+fd9uqd60Fi5UB258+kuLD7oO+LABCDcSXZ+I0+lagP68wllFA9esQZSiVwgCFZkl8+PzxjRr9EYyNYRc1DoC0CEPENMdhNUtumyNBEJ97xZLoIbFsiW4X0BOCZh+WiCgHioguvSh3UR2cm6n2E3hhy7G8UFSGeQ0/bYdYVlirRwfbSM/ziYreSvNRF5ysV5HgNhL/L9iT+McEVZ24RJk/QWShbnRwQyRv/DvZZAzomzOiPCpcBp4XlQNa1p8+7r1PwvJ5DQ5JqGM972vUg7mXGUUGpCBWD+VhAAOjPjH9Su/R/cZB0HgaBvJGZTpUB6A31Z6Zw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733e4963-8733-4362-a918-08d6cc80763a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:55:43.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4991
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIEhTNDAwIHN1cHBvcnQgZm9yIGlNWDdVTFAgQjAuDQoNCkFjY29yZGluZyB0byBJQyBzdWdn
ZXN0LCBuZWVkIHRvIGNsZWFyIHRoZSBTVFJPQkVfRExMX0NUUkxfUkVTRVQNCmJlZm9yZSBhbnkg
c2V0dGluZyBvZiBTVFJPQkVfRExMX0NUUkwgcmVnaXN0ZXIuDQoNClVTREhDIGhhcyByZWdpc3Rl
ciBiaXRzKGJpdFsyN34yMF0gb2YgcmVnaXN0ZXIgU1RST0JFX0RMTF9DVFJMKQ0KZm9yIHNsYXZl
IHNlbCB2YWx1ZS4gSWYgdGhpcyByZWdpc3RlciBiaXRzIHZhbHVlIGlzIDAsICBpdCBuZWVkcw0K
MjU2IHJlZl9jbGsgY3ljbGVzIHRvIHVwZGF0ZSBzbGF2ZSBzZWwgdmFsdWUuIElDIHN1Z2dlc3Qg
dG8gc2V0DQpiaXRbMjd+MjBdIHRvIDB4NCwgaXQgb25seSBuZWVkIDQgcmVmX2NsayBjeWNsZSB0
byB1cGRhdGUgc2xhdmUNCnNlbCB2YWx1ZS4gVGhpcyB3aWxsIHNob3J0IHRoZSBsb2NrIHRpbWUg
b2Ygc2xhdmUuDQoNCmkuTVg3VUxQIEIwIHdpbGwgbmVlZCBtb3JlIHRpbWUgdG8gbG9jayB0aGUg
UkVGIGFuZCBTTFYsIHNvIGNoYW5nZQ0KdG8gYWRkIDV1cyBkZWxheS4NCg0KU2lnbmVkLW9mZi1i
eTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KLS0tDQogZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1lc2RoYy1pbXguYyB8IDExICsrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jDQppbmRleCAwNTNlODU4NmQ1NTcuLmMzOTE1MTBlOWVmNCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMNCkBAIC03NCw2ICs3NCw3IEBADQogI2RlZmluZSBFU0RIQ19TVFJPQkVf
RExMX0NUUkxfRU5BQkxFCSgxIDw8IDApDQogI2RlZmluZSBFU0RIQ19TVFJPQkVfRExMX0NUUkxf
UkVTRVQJKDEgPDwgMSkNCiAjZGVmaW5lIEVTREhDX1NUUk9CRV9ETExfQ1RSTF9TTFZfRExZX1RB
UkdFVF9TSElGVAkzDQorI2RlZmluZSBFU0RIQ19TVFJPQkVfRExMX0NUUkxfU0xWX1VQREFURV9J
TlRfREVGQVVMVAkoNCA8PCAyMCkNCiANCiAjZGVmaW5lIEVTREhDX1NUUk9CRV9ETExfU1RBVFVT
CQkweDc0DQogI2RlZmluZSBFU0RIQ19TVFJPQkVfRExMX1NUU19SRUZfTE9DSwkoMSA8PCAxKQ0K
QEAgLTIxMCw3ICsyMTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVz
ZGhjX2lteDdkX2RhdGEgPSB7DQogc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19p
bXg3dWxwX2RhdGEgPSB7DQogCS5mbGFncyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RIQ19GTEFH
X1NURF9UVU5JTkcNCiAJCQl8IEVTREhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIw
MA0KLQkJCXwgRVNESENfRkxBR19QTVFPUywNCisJCQl8IEVTREhDX0ZMQUdfUE1RT1MgfCBFU0RI
Q19GTEFHX0hTNDAwLA0KIH07DQogDQogc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2Ro
Y19pbXg4cXhwX2RhdGEgPSB7DQpAQCAtOTk0LDE1ICs5OTUsMTkgQEAgc3RhdGljIHZvaWQgZXNk
aGNfc2V0X3N0cm9iZV9kbGwoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQogCS8qIGZvcmNlIGEg
cmVzZXQgb24gc3Ryb2JlIGRsbCAqLw0KIAl3cml0ZWwoRVNESENfU1RST0JFX0RMTF9DVFJMX1JF
U0VULA0KIAkJaG9zdC0+aW9hZGRyICsgRVNESENfU1RST0JFX0RMTF9DVFJMKTsNCisJLyogY2xl
YXIgdGhlIHJlc2V0IGJpdCBvbiBzdHJvYmUgZGxsIGJlZm9yZSBhbnkgc2V0dGluZyAqLw0KKwl3
cml0ZWwoMCwgaG9zdC0+aW9hZGRyICsgRVNESENfU1RST0JFX0RMTF9DVFJMKTsNCisNCiAJLyoN
CiAJICogZW5hYmxlIHN0cm9iZSBkbGwgY3RybCBhbmQgYWRqdXN0IHRoZSBkZWxheSB0YXJnZXQN
CiAJICogZm9yIHRoZSB1U0RIQyBsb29wYmFjayByZWFkIGNsb2NrDQogCSAqLw0KIAl2ID0gRVNE
SENfU1RST0JFX0RMTF9DVFJMX0VOQUJMRSB8DQorCQlFU0RIQ19TVFJPQkVfRExMX0NUUkxfU0xW
X1VQREFURV9JTlRfREVGQVVMVCB8DQogCQkoNyA8PCBFU0RIQ19TVFJPQkVfRExMX0NUUkxfU0xW
X0RMWV9UQVJHRVRfU0hJRlQpOw0KIAl3cml0ZWwodiwgaG9zdC0+aW9hZGRyICsgRVNESENfU1RS
T0JFX0RMTF9DVFJMKTsNCi0JLyogd2FpdCAxdXMgdG8gbWFrZSBzdXJlIHN0cm9iZSBkbGwgc3Rh
dHVzIHJlZ2lzdGVyIHN0YWJsZSAqLw0KLQl1ZGVsYXkoMSk7DQorCS8qIHdhaXQgNXVzIHRvIG1h
a2Ugc3VyZSBzdHJvYmUgZGxsIHN0YXR1cyByZWdpc3RlciBzdGFibGUgKi8NCisJdWRlbGF5KDUp
Ow0KIAl2ID0gcmVhZGwoaG9zdC0+aW9hZGRyICsgRVNESENfU1RST0JFX0RMTF9TVEFUVVMpOw0K
IAlpZiAoISh2ICYgRVNESENfU1RST0JFX0RMTF9TVFNfUkVGX0xPQ0spKQ0KIAkJZGV2X3dhcm4o
bW1jX2Rldihob3N0LT5tbWMpLA0KLS0gDQoyLjE3LjENCg0K
