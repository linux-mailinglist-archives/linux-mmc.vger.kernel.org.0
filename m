Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D8DE81
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfD2Izm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 04:55:42 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:32067
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbfD2Izm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 04:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brocor5i2lKMVeTwIMzdtnRRbysoHhqcP6Gukge4qUY=;
 b=KtS4xg6R4VinfBrtuo209z1N9TzFWDhb0KBRqBGYjpHzM8cVP4pNtv/gyb/nQFoAQkmH3ynxpIANh8h3IngHItzepcrSvMCdPdej6bICr6gOKvuYley3PhzvbZ8XYrVkAYHNEGr45/NyvJe6pwt6/DsJfVYa5cuYnLhcB+JSi4E=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4991.eurprd04.prod.outlook.com (20.177.49.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 08:55:37 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:55:37 +0000
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
Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
Thread-Topic: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
Thread-Index: AQHU/mlQ28WGFzYOYke0knyOZOpwCw==
Date:   Mon, 29 Apr 2019 08:55:37 +0000
Message-ID: <20190429090310.25484-3-haibo.chen@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6e303765-5b02-4ebc-6344-08d6cc8072b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4991;
x-ms-traffictypediagnostic: VI1PR04MB4991:
x-microsoft-antispam-prvs: <VI1PR04MB4991084678D33A002F3991A590390@VI1PR04MB4991.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(316002)(53936002)(99286004)(6436002)(110136005)(54906003)(36756003)(81156014)(81166006)(2501003)(6512007)(6486002)(8676002)(97736004)(14454004)(50226002)(25786009)(478600001)(4326008)(6116002)(66556008)(3846002)(66476007)(64756008)(7736002)(66946007)(305945005)(71200400001)(71190400001)(66446008)(5660300002)(68736007)(73956011)(66066001)(52116002)(2906002)(14444005)(86362001)(11346002)(256004)(102836004)(6506007)(386003)(8936002)(26005)(186003)(2616005)(476003)(53346004)(446003)(486006)(76176011)(1076003)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4991;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: itHJrXznokIzE09kb4UN1r0xMuxPObKC2LrVn6N8sQ2IDv98THLY0qzollAly76kwhK9ogWPwlE+h0+F9YS3HrfxbiWLdjAQOFo9K9lFWwxx4x2LdZWD5oR0HZ1448LkeZVvAu066m7co8oYKjUVbxxsqy0HH7b7UlT+yXIYkdUu+EbDqQBz4oahfoWhBeJRXYWz6YKO0K62Ni0jJ3aGfM02dWgHU3fuWE8JM71DiSXbv0J0ztpgZlvjB00P4lFhD5Mef30X7aNRRLf0ucUgpottxvCOpKIu5K3YGaMGOvJvX6p/pnRkEUrU78w4onR30t5cHtnbb1B3vM6QEMlHCOjeOI983Fo/GZh1bhXXDgao/LeILPnBJHwr8EiHrkSyt2fHEuLcrl3P3hWWFglglGJGh9FgiZTV8lG0vaQ8plw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e303765-5b02-4ebc-6344-08d6cc8072b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:55:37.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4991
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gc29tZSBTb0NzIHN1Y2ggYXMgaS5NWDdVTFAsIHRoZXJlIGlzIG5vIGJ1c2ZyZXENCmRyaXZl
ciwgYnV0IGNwdWlkbGUgaGFzIHNvbWUgbGV2ZWxzIHdoaWNoIG1heSBkaXNhYmxlDQpzeXN0ZW0v
YnVzIGNsb2Nrcywgc28gbmVlZCB0byBhZGQgcG1fcW9zIHRvIHByZXZlbnQNCmNwdWlkbGUgZnJv
bSBlbnRlcmluZyBsb3cgbGV2ZWwgaWRsZXMgYW5kIG1ha2Ugc3VyZQ0Kc3lzdGVtL2J1cyBjbG9j
a3MgYXJlIGVuYWJsZWQgd2hlbiB1c2RoYyBpcyBhY3RpdmUuDQoNClNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KLS0tDQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy1pbXguYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KaW5kZXggOGRiYmMxZjYyYjcwLi4wNTNlODU4NmQ1NTcgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQorKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jDQpAQCAtMTQsNiArMTQsNyBAQA0KICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCisjaW5jbHVkZSA8bGludXgvcG1fcW9zLmg+DQogI2luY2x1ZGUgPGxpbnV4L21tYy9o
b3N0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L21tYy9tbWMuaD4NCiAjaW5jbHVkZSA8bGludXgvbW1j
L3NkaW8uaD4NCkBAIC0xNTYsNiArMTU3LDggQEANCiAjZGVmaW5lIEVTREhDX0ZMQUdfSFM0MDBf
RVMJCUJJVCgxMSkNCiAvKiBUaGUgSVAgaGFzIEhvc3QgQ29udHJvbGxlciBJbnRlcmZhY2UgZm9y
IENvbW1hbmQgUXVldWluZyAqLw0KICNkZWZpbmUgRVNESENfRkxBR19DUUhDSQkJQklUKDEyKQ0K
Ky8qIG5lZWQgcmVxdWVzdCBwbXFvcyBkdXJpbmcgbG93IHBvd2VyICovDQorI2RlZmluZSBFU0RI
Q19GTEFHX1BNUU9TCQlCSVQoMTMpDQogDQogc3RydWN0IGVzZGhjX3NvY19kYXRhIHsNCiAJdTMy
IGZsYWdzOw0KQEAgLTIwNCw2ICsyMDcsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBlc2RoY19z
b2NfZGF0YSB1c2RoY19pbXg3ZF9kYXRhID0gew0KIAkJCXwgRVNESENfRkxBR19IUzQwMCwNCiB9
Ow0KIA0KK3N0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14N3VscF9kYXRhID0g
ew0KKwkuZmxhZ3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNESENfRkxBR19TVERfVFVOSU5HDQor
CQkJfCBFU0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDANCisJCQl8IEVTREhD
X0ZMQUdfUE1RT1MsDQorfTsNCisNCiBzdGF0aWMgc3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhj
X2lteDhxeHBfZGF0YSA9IHsNCiAJLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZM
QUdfU1REX1RVTklORw0KIAkJCXwgRVNESENfRkxBR19IQVZFX0NBUDEgfCBFU0RIQ19GTEFHX0hT
MjAwDQpAQCAtMjI5LDYgKzIzOCw3IEBAIHN0cnVjdCBwbHRmbV9pbXhfZGF0YSB7DQogCQlXQUlU
X0ZPUl9JTlQsICAgICAgICAvKiBzZW50IENNRDEyLCB3YWl0aW5nIGZvciByZXNwb25zZSBJTlQg
Ki8NCiAJfSBtdWx0aWJsb2NrX3N0YXR1czsNCiAJdTMyIGlzX2RkcjsNCisJc3RydWN0IHBtX3Fv
c19yZXF1ZXN0IHBtX3Fvc19yZXE7DQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRm
b3JtX2RldmljZV9pZCBpbXhfZXNkaGNfZGV2dHlwZVtdID0gew0KQEAgLTI1Nyw2ICsyNjcsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhfZXNkaGNfZHRfaWRzW10gPSB7
DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZxLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14
NnFfZGF0YSwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnVsbC11c2RoYyIsIC5kYXRh
ID0gJnVzZGhjX2lteDZ1bGxfZGF0YSwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N2Qt
dXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg3ZF9kYXRhLCB9LA0KKwl7IC5jb21wYXRpYmxlID0g
ImZzbCxpbXg3dWxwLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14N3VscF9kYXRhLCB9LA0KIAl7
IC5jb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14OHF4
cF9kYXRhLCB9LA0KIAl7IC8qIHNlbnRpbmVsICovIH0NCiB9Ow0KQEAgLTE0MzYsNiArMTQ0Nywx
MCBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAlpbXhfZGF0YS0+c29jZGF0YSA9IG9mX2lkID8gb2ZfaWQtPmRhdGEgOiAo
c3RydWN0IGVzZGhjX3NvY19kYXRhICopDQogCQkJCQkJICBwZGV2LT5pZF9lbnRyeS0+ZHJpdmVy
X2RhdGE7DQogDQorCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX1BN
UU9TKQ0KKwkJcG1fcW9zX2FkZF9yZXF1ZXN0KCZpbXhfZGF0YS0+cG1fcW9zX3JlcSwNCisJCQlQ
TV9RT1NfQ1BVX0RNQV9MQVRFTkNZLCAwKTsNCisNCiAJaW14X2RhdGEtPmNsa19pcGcgPSBkZXZt
X2Nsa19nZXQoJnBkZXYtPmRldiwgImlwZyIpOw0KIAlpZiAoSVNfRVJSKGlteF9kYXRhLT5jbGtf
aXBnKSkgew0KIAkJZXJyID0gUFRSX0VSUihpbXhfZGF0YS0+Y2xrX2lwZyk7DQpAQCAtMTU1Nyw2
ICsxNTcyLDggQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCiBkaXNhYmxlX3Blcl9jbGs6DQogCWNsa19kaXNhYmxlX3VucHJl
cGFyZShpbXhfZGF0YS0+Y2xrX3Blcik7DQogZnJlZV9zZGhjaToNCisJaWYgKGlteF9kYXRhLT5z
b2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfUE1RT1MpDQorCQlwbV9xb3NfcmVtb3ZlX3JlcXVl
c3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCiAJc2RoY2lfcGx0Zm1fZnJlZShwZGV2KTsNCiAJ
cmV0dXJuIGVycjsNCiB9DQpAQCAtMTU3OCw2ICsxNTk1LDkgQEAgc3RhdGljIGludCBzZGhjaV9l
c2RoY19pbXhfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWNsa19kaXNh
YmxlX3VucHJlcGFyZShpbXhfZGF0YS0+Y2xrX2lwZyk7DQogCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShpbXhfZGF0YS0+Y2xrX2FoYik7DQogDQorCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3Mg
JiBFU0RIQ19GTEFHX1BNUU9TKQ0KKwkJcG1fcW9zX3JlbW92ZV9yZXF1ZXN0KCZpbXhfZGF0YS0+
cG1fcW9zX3JlcSk7DQorDQogCXNkaGNpX3BsdGZtX2ZyZWUocGRldik7DQogDQogCXJldHVybiAw
Ow0KQEAgLTE2NDksNiArMTY2OSw5IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfcnVudGltZV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJfQ0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUo
aW14X2RhdGEtPmNsa19haGIpOw0KIA0KKwlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYg
RVNESENfRkxBR19QTVFPUykNCisJCXBtX3Fvc19yZW1vdmVfcmVxdWVzdCgmaW14X2RhdGEtPnBt
X3Fvc19yZXEpOw0KKw0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCkBAIC0xNjU5LDkgKzE2ODIsMTMg
QEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQogCXN0cnVjdCBwbHRmbV9pbXhfZGF0YSAqaW14X2RhdGEgPSBzZGhjaV9wbHRmbV9wcml2
KHBsdGZtX2hvc3QpOw0KIAlpbnQgZXJyOw0KIA0KKwlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZs
YWdzICYgRVNESENfRkxBR19QTVFPUykNCisJCXBtX3Fvc19hZGRfcmVxdWVzdCgmaW14X2RhdGEt
PnBtX3Fvc19yZXEsDQorCQkJUE1fUU9TX0NQVV9ETUFfTEFURU5DWSwgMCk7DQorDQogCWVyciA9
IGNsa19wcmVwYXJlX2VuYWJsZShpbXhfZGF0YS0+Y2xrX2FoYik7DQogCWlmIChlcnIpDQotCQly
ZXR1cm4gZXJyOw0KKwkJZ290byByZW1vdmVfcG1fcW9zX3JlcXVlc3Q7DQogDQogCWlmICghc2Ro
Y2lfc2Rpb19pcnFfZW5hYmxlZChob3N0KSkgew0KIAkJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxl
KGlteF9kYXRhLT5jbGtfcGVyKTsNCkBAIC0xNjkwLDYgKzE3MTcsOSBAQCBzdGF0aWMgaW50IHNk
aGNpX2VzZGhjX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJCWNsa19kaXNh
YmxlX3VucHJlcGFyZShpbXhfZGF0YS0+Y2xrX3Blcik7DQogZGlzYWJsZV9haGJfY2xrOg0KIAlj
bGtfZGlzYWJsZV91bnByZXBhcmUoaW14X2RhdGEtPmNsa19haGIpOw0KK3JlbW92ZV9wbV9xb3Nf
cmVxdWVzdDoNCisJaWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfUE1R
T1MpDQorCQlwbV9xb3NfcmVtb3ZlX3JlcXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCiAJ
cmV0dXJuIGVycjsNCiB9DQogI2VuZGlmDQotLSANCjIuMTcuMQ0KDQo=
