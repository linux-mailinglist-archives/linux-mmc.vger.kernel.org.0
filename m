Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC554DE7D
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfD2Izb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 04:55:31 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:63808
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfD2Izb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZzW2Q76vsPSOu4uK3Gmk8Pq8UaaZYl2gRdxV5J8Ido=;
 b=ZX3AckyTfwDqkY7/HCdRXKyRn1rX0lJYAehNRGLeMqtsaIV17cn9BeZUFQcZZlN+FKSZwtRjSu2dmM04sPs6g8pNz5dpiCye2S8rc6sc0qleRO1JQ/5cgmHAyiT02heEWQGDv6CQZ0f+cK5DANlBfUGaeTqvOBt5a7baY93IrQY=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4991.eurprd04.prod.outlook.com (20.177.49.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 08:55:27 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:55:27 +0000
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
Subject: [PATCH v2 0/3] Add struct esdhc_soc_data for i.MX7ULP
Thread-Topic: [PATCH v2 0/3] Add struct esdhc_soc_data for i.MX7ULP
Thread-Index: AQHU/mlKF2J+KKyqY0ud1tbHDO+Psw==
Date:   Mon, 29 Apr 2019 08:55:27 +0000
Message-ID: <20190429090310.25484-1-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 051220d0-7bc0-403a-9685-08d6cc806c62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4991;
x-ms-traffictypediagnostic: VI1PR04MB4991:
x-microsoft-antispam-prvs: <VI1PR04MB499132353A3E883C07D8C5B190390@VI1PR04MB4991.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(316002)(53936002)(99286004)(6436002)(110136005)(54906003)(36756003)(4744005)(81156014)(81166006)(2501003)(6512007)(6486002)(8676002)(97736004)(14454004)(50226002)(25786009)(478600001)(4326008)(6116002)(66556008)(3846002)(66476007)(64756008)(7736002)(66946007)(305945005)(71200400001)(71190400001)(66446008)(5660300002)(68736007)(73956011)(66066001)(52116002)(2906002)(14444005)(86362001)(256004)(102836004)(6506007)(386003)(8936002)(26005)(186003)(2616005)(476003)(53346004)(486006)(1076003)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4991;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mldd02kkbemUBFOWa9jpT9TvxYLXHPJdhHf99GUqMph0jU6AiTJxZ72f9AnuOFltfXTqiusw9kqtWWV95GhMIOl6FBqShOLDoGgLJnSyjY68VyxW5HLA0qsksx6u3oWN1YX/aTGaFYi68IPxpDkD77l4hjVRxRxMXHO5GOcYUB9agYsTx8L97NKCDQscatk4BCARNBps0VDmqA+R4ybHdWazquDng3ilR68Yipo20fAUrLOkC/VYDtp4661KonbQy54xmNlB+O/vWxxUYiDt8p1UO21kRgKKkQFF++Pr3ZLW9ReTbvqRxikanG4J4VbIbG+9EMuSa7BwzZufKyIOcy3f/S6D/dsOKYpgyAnQ71pKlNQYZXyJQkCtOJZZXgzcSIqRQFJWcUI5aqoYWN3LaHeOUhsko30BvAaNgvrKOf0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051220d0-7bc0-403a-9685-08d6cc806c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:55:27.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4991
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

LS0tDQpDaGFuZ2VzIGZvciBWMjoNCi1yZW1vdmUgdGhlIHJlcXVlc3Qgb24gdGhlIHN1YnNlcXVl
bnQgZXJyb3IgcGF0aHMgaW4gcG1fcnVudGltZV9yZXN1bWUNCg0KSGFpYm8gQ2hlbiAoMyk6DQog
IGR0LWJpbmRpbmdzOiBtbWM6IGZzbC1pbXgtZXNkaGM6IGFkZCBpbXg3dWxwIGNvbXBhdGlibGUg
c3RyaW5nDQogIG1tYzogc2RoY2ktZXNkaGMtaW14OiBhZGQgcG1fcW9zIHRvIGludGVyYWN0IHdp
dGggY3B1aWRsZQ0KICBtbWM6IGFkZCBIUzQwMCBzdXBwb3J0IGZvciBpTVg3VUxQDQoNCiAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy50eHQgfCAgMSArDQogZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyAgICAgICAgICAgIHwgNDEgKysrKysrKysrKysr
KysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjE3LjENCg0K
