Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1768EDE7F
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfD2Izh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 04:55:37 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:23426
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfD2Izg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00pd9Pw1wwOsGCarAqLBqo51u9OMPM8N3Zf2ovbFfl0=;
 b=ArmuvJ5DTWdiK4wz5CYGluIcdayzpFgpW41alwVQZRbIvDWv78kUwDsNqJeX2eCwkkgpu9AE6k78CQN/vPO/Lr6uos2qDeTx3ebw/WoA+Xpw+vnxw/HqWNED7uQD6HfCwpGtCJVoxmSKAd9fPJtIQwnOAbM3m+46mNE1noRu+5I=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Mon, 29 Apr 2019 08:55:33 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:55:32 +0000
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
Subject: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp
 compatible string
Thread-Topic: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp
 compatible string
Thread-Index: AQHU/mlNY1RAJx0knE+hyQTJtJwtXA==
Date:   Mon, 29 Apr 2019 08:55:32 +0000
Message-ID: <20190429090310.25484-2-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: c2f899ae-b70d-4354-4185-08d6cc806fdd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6270;
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-microsoft-antispam-prvs: <VI1PR04MB62705D789A555CF58C97407790390@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(4744005)(53936002)(68736007)(66946007)(66476007)(86362001)(2201001)(66066001)(305945005)(53346004)(97736004)(99286004)(2501003)(66446008)(2906002)(73956011)(66556008)(316002)(54906003)(110136005)(6116002)(64756008)(6486002)(6436002)(6512007)(256004)(36756003)(1076003)(8936002)(81156014)(81166006)(71200400001)(71190400001)(26005)(8676002)(5660300002)(50226002)(478600001)(25786009)(52116002)(3846002)(186003)(446003)(102836004)(11346002)(2616005)(14454004)(486006)(476003)(4326008)(7736002)(76176011)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6270;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ozWdpPAucsA3ku6ZVCZz48IMlj71rP1gP19QqzukUodfbbHqSeIMbA1YNkjP+oLvlOzrsCGg1ww0+CMl/tQpiq3/nnVPboj9U0RdTEKHsx1gWDUsusavqIavGrQxzDfKnShLMkCZHvrYoidSdEdjnsIAxP7KwWv/xYnY4E1yF0srq0i1J8wLPDhB3dRhObQi7UiiOzC8MGC1O34qDkAufa39hL/kz4PZvjvNGhNjhy0BrWIwcIhV5+AK2oYuAjxTtVnC+tT/rdjcPqzjK9Qnwd+ynCJrro+ybh6ziQBRRYvpwFfYyIADtHFUUIpCQNqclpd6xo6ONvS2wGJoNpcaMloadud1PNK7V53NKjBaXpUTElQJMWePjz4Fm1rGvdpaCyYr17SnwtwumrYhI0spFl05BFz0jFuOAFYQVLmQ2uc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f899ae-b70d-4354-4185-08d6cc806fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:55:32.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIGlteDd1bHAgY29tcGF0aWJsZSBzdHJpbmcuDQoNClNpZ25lZC1vZmYtYnk6IEhhaWJvIENo
ZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9mc2wtaW14LWVzZGhjLnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21t
Yy9mc2wtaW14LWVzZGhjLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvZnNsLWlteC1lc2RoYy50eHQNCmluZGV4IDU0MGM2NWVkOWNiYS4uZjcwN2I4YmVlMzA0IDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14
LWVzZGhjLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9m
c2wtaW14LWVzZGhjLnR4dA0KQEAgLTE3LDYgKzE3LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
CiAJICAgICAgICJmc2wsaW14NnN4LXVzZGhjIg0KIAkgICAgICAgImZzbCxpbXg2dWxsLXVzZGhj
Ig0KIAkgICAgICAgImZzbCxpbXg3ZC11c2RoYyINCisJICAgICAgICJmc2wsaW14N3VscC11c2Ro
YyINCiAJICAgICAgICJmc2wsaW14OHF4cC11c2RoYyINCiANCiBPcHRpb25hbCBwcm9wZXJ0aWVz
Og0KLS0gDQoyLjE3LjENCg0K
