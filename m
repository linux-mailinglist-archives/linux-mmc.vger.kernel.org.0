Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA27DD6C
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfD2IJq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 04:09:46 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:45173
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbfD2IJq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Apr 2019 04:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjWnTUGFydSCHvtvAYHUaiRSSW14Pe9Khki69fF6F38=;
 b=aNyhnL9SHeXfcBC4tWEnMCnpq611flfcY9jibow6IIH9vJ5Yc1Srsup6T11kjuprJ0XDKKFstLnwpFp6jLwGeJk+66IROUiZqDn0IYzT4flP3pqdcUyU5M8uQQuhF+wa8r4zLOeV+w6Hm6M6I0x+ztsYVFuQd6+QIK1MBPvMgno=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB3150.eurprd04.prod.outlook.com (10.170.229.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 08:09:41 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::4d83:33f7:38e7:70ec%4]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 08:09:41 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
Thread-Topic: [PATCH 2/3] mmc: sdhci-esdhc-imx: add pm_qos to interact with
 cpuidle
Thread-Index: AQHU/ZskXnLSY/7UoEG8JMTSQ/scVqZSvC6AgAAOASA=
Date:   Mon, 29 Apr 2019 08:09:41 +0000
Message-ID: <VI1PR04MB504079D46F1A3902C7142D1E90390@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <20190428082727.3419-1-haibo.chen@nxp.com>
 <20190428082727.3419-2-haibo.chen@nxp.com>
 <21be463d-38bd-b568-fa9d-7170290cf364@intel.com>
In-Reply-To: <21be463d-38bd-b568-fa9d-7170290cf364@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa089c4-65ed-455a-ee81-08d6cc7a080d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3150;
x-ms-traffictypediagnostic: VI1PR04MB3150:
x-microsoft-antispam-prvs: <VI1PR04MB31503170C43A7FE59199F19F90390@VI1PR04MB3150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(13464003)(2906002)(68736007)(53546011)(102836004)(53936002)(8936002)(26005)(476003)(86362001)(81166006)(73956011)(33656002)(4326008)(66946007)(14444005)(81156014)(256004)(486006)(66066001)(55016002)(6506007)(7696005)(186003)(2201001)(9686003)(11346002)(446003)(7736002)(8676002)(71190400001)(71200400001)(52536014)(99286004)(229853002)(305945005)(76176011)(53346004)(74316002)(316002)(14454004)(76116006)(110136005)(478600001)(5660300002)(64756008)(66556008)(3846002)(66446008)(6436002)(66476007)(97736004)(54906003)(6246003)(25786009)(6116002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3150;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b5bUuvoqImdBUlhMdzwMSLM7KVdScY0cK1+i2/MbKK25uNx9x/B41sul5b+LiB7aoXBVme1ZP0kazocwIoMr6zcRPlf2TMnLaAiGt5Na43yx7gWtZ97y8Y1yzEd+NPzC5YqH6VzzR4yXcj5BSGRr9rd0cix8pugexHVLRpNExqPvx1b+sPY0N+tATTJvivzoPD3N701G++62BHOMZ+vL8quGYw3f0EkDckhhHS70/Essi251PCtCoixY5VzcLQRYKpSM7/ARvXpe77IlUSpQtgE2WY2e9+qpxfBLvkAfWSeZxVh+2GNDaOtuwpnvWyOsFf0OZiwLZECqZ97Co4lw32AQI+CM40DPKLNFHaI8LvO6QqkkGHbdSPU4miCA/uzMyzZSAcpmAVXNqzffnS+FBn+sDqFEmf6bvOQLQxE9SZ4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa089c4-65ed-455a-ee81-08d6cc7a080d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 08:09:41.2010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3150
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1tbWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnDQo+IFttYWlsdG86bGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ10g
T24gQmVoYWxmIE9mIEFkcmlhbiBIdW50ZXINCj4gU2VudDogMjAxOeW5tDTmnIgyOeaXpSAxNTox
OA0KPiBUbzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hh
d25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gbW1jOiBzZGhj
aS1lc2RoYy1pbXg6IGFkZCBwbV9xb3MgdG8gaW50ZXJhY3Qgd2l0aA0KPiBjcHVpZGxlDQo+IA0K
PiBPbiAyOC8wNC8xOSAxMToxOSBBTSwgQk9VR0ggQ0hFTiB3cm90ZToNCj4gPiBPbiBzb21lIFNv
Q3Mgc3VjaCBhcyBpLk1YN1VMUCwgdGhlcmUgaXMgbm8gYnVzZnJlcSBkcml2ZXIsIGJ1dCBjcHVp
ZGxlDQo+ID4gaGFzIHNvbWUgbGV2ZWxzIHdoaWNoIG1heSBkaXNhYmxlIHN5c3RlbS9idXMgY2xv
Y2tzLCBzbyBuZWVkIHRvIGFkZA0KPiA+IHBtX3FvcyB0byBwcmV2ZW50IGNwdWlkbGUgZnJvbSBl
bnRlcmluZyBsb3cgbGV2ZWwgaWRsZXMgYW5kIG1ha2Ugc3VyZQ0KPiA+IHN5c3RlbS9idXMgY2xv
Y2tzIGFyZSBlbmFibGVkIHdoZW4gdXNkaGMgaXMgYWN0aXZlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IGIvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IGluZGV4IDhkYmJjMWY2MmI3MC4uNmEw
MmU4YjUwZGM3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4g
QEAgLTE0LDYgKzE0LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9wbV9xb3MuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21tYy9ob3N0
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tbWMvbW1jLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9tbWMvc2Rpby5oPg0KPiA+IEBAIC0xNTYsNiArMTU3LDggQEANCj4gPiAgI2RlZmluZSBFU0RI
Q19GTEFHX0hTNDAwX0VTCQlCSVQoMTEpDQo+ID4gIC8qIFRoZSBJUCBoYXMgSG9zdCBDb250cm9s
bGVyIEludGVyZmFjZSBmb3IgQ29tbWFuZCBRdWV1aW5nICovDQo+ID4gICNkZWZpbmUgRVNESENf
RkxBR19DUUhDSQkJQklUKDEyKQ0KPiA+ICsvKiBuZWVkIHJlcXVlc3QgcG1xb3MgZHVyaW5nIGxv
dyBwb3dlciAqLw0KPiA+ICsjZGVmaW5lIEVTREhDX0ZMQUdfUE1RT1MJCUJJVCgxMykNCj4gPg0K
PiA+ICBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgew0KPiA+ICAJdTMyIGZsYWdzOw0KPiA+IEBAIC0y
MDQsNiArMjA3LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfc29jX2RhdGENCj4gdXNk
aGNfaW14N2RfZGF0YSA9IHsNCj4gPiAgCQkJfCBFU0RIQ19GTEFHX0hTNDAwLA0KPiA+ICB9Ow0K
PiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgdXNkaGNfaW14N3VscF9kYXRh
ID0gew0KPiA+ICsJLmZsYWdzID0gRVNESENfRkxBR19VU0RIQyB8IEVTREhDX0ZMQUdfU1REX1RV
TklORw0KPiA+ICsJCQl8IEVTREhDX0ZMQUdfSEFWRV9DQVAxIHwgRVNESENfRkxBR19IUzIwMA0K
PiA+ICsJCQl8IEVTREhDX0ZMQUdfUE1RT1MsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMg
c3RydWN0IGVzZGhjX3NvY19kYXRhIHVzZGhjX2lteDhxeHBfZGF0YSA9IHsNCj4gPiAgCS5mbGFn
cyA9IEVTREhDX0ZMQUdfVVNESEMgfCBFU0RIQ19GTEFHX1NURF9UVU5JTkcNCj4gPiAgCQkJfCBF
U0RIQ19GTEFHX0hBVkVfQ0FQMSB8IEVTREhDX0ZMQUdfSFMyMDAgQEAgLTIyOSw2DQo+ICsyMzgs
NyBAQA0KPiA+IHN0cnVjdCBwbHRmbV9pbXhfZGF0YSB7DQo+ID4gIAkJV0FJVF9GT1JfSU5ULCAg
ICAgICAgLyogc2VudCBDTUQxMiwgd2FpdGluZyBmb3IgcmVzcG9uc2UgSU5UDQo+ICovDQo+ID4g
IAl9IG11bHRpYmxvY2tfc3RhdHVzOw0KPiA+ICAJdTMyIGlzX2RkcjsNCj4gPiArCXN0cnVjdCBw
bV9xb3NfcmVxdWVzdCBwbV9xb3NfcmVxOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIGlteF9lc2RoY19kZXZ0eXBlW10gPSB7IEBADQo+
ID4gLTI1Nyw2ICsyNjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhf
ZXNkaGNfZHRfaWRzW10gPSB7DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg2cS11c2Ro
YyIsIC5kYXRhID0gJnVzZGhjX2lteDZxX2RhdGEsIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0g
ImZzbCxpbXg2dWxsLXVzZGhjIiwgLmRhdGEgPSAmdXNkaGNfaW14NnVsbF9kYXRhLCB9LA0KPiA+
ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N2QtdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg3
ZF9kYXRhLCB9LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC11c2RoYyIsIC5k
YXRhID0gJnVzZGhjX2lteDd1bHBfZGF0YSwgfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNs
LGlteDhxeHAtdXNkaGMiLCAuZGF0YSA9ICZ1c2RoY19pbXg4cXhwX2RhdGEsIH0sDQo+ID4gIAl7
IC8qIHNlbnRpbmVsICovIH0NCj4gPiAgfTsNCj4gPiBAQCAtMTQzNiw2ICsxNDQ3LDEwIEBAIHN0
YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gIAlpbXhfZGF0YS0+c29jZGF0YSA9IG9mX2lkID8gb2ZfaWQtPmRhdGEgOiAo
c3RydWN0IGVzZGhjX3NvY19kYXRhICopDQo+ID4gIAkJCQkJCSAgcGRldi0+aWRfZW50cnktPmRy
aXZlcl9kYXRhOw0KPiA+DQo+ID4gKwlpZiAoaW14X2RhdGEtPnNvY2RhdGEtPmZsYWdzICYgRVNE
SENfRkxBR19QTVFPUykNCj4gPiArCQlwbV9xb3NfYWRkX3JlcXVlc3QoJmlteF9kYXRhLT5wbV9x
b3NfcmVxLA0KPiA+ICsJCQlQTV9RT1NfQ1BVX0RNQV9MQVRFTkNZLCAwKTsNCj4gPiArDQo+ID4g
IAlpbXhfZGF0YS0+Y2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaXBnIik7DQo+
ID4gIAlpZiAoSVNfRVJSKGlteF9kYXRhLT5jbGtfaXBnKSkgew0KPiA+ICAJCWVyciA9IFBUUl9F
UlIoaW14X2RhdGEtPmNsa19pcGcpOw0KPiA+IEBAIC0xNTU3LDYgKzE1NzIsOCBAQCBzdGF0aWMg
aW50IHNkaGNpX2VzZGhjX2lteF9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIGRpc2FibGVfcGVyX2NsazoNCj4gPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShp
bXhfZGF0YS0+Y2xrX3Blcik7DQo+ID4gIGZyZWVfc2RoY2k6DQo+ID4gKwlpZiAoaW14X2RhdGEt
PnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19QTVFPUykNCj4gPiArCQlwbV9xb3NfcmVtb3Zl
X3JlcXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4gPiAgCXNkaGNpX3BsdGZtX2ZyZWUo
cGRldik7DQo+ID4gIAlyZXR1cm4gZXJyOw0KPiA+ICB9DQo+ID4gQEAgLTE1NzgsNiArMTU5NSw5
IEBAIHN0YXRpYyBpbnQgc2RoY2lfZXNkaGNfaW14X3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteF9kYXRhLT5jbGtf
aXBnKTsNCj4gPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXhfZGF0YS0+Y2xrX2FoYik7DQo+
ID4NCj4gPiArCWlmIChpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX1BNUU9T
KQ0KPiA+ICsJCXBtX3Fvc19yZW1vdmVfcmVxdWVzdCgmaW14X2RhdGEtPnBtX3Fvc19yZXEpOw0K
PiA+ICsNCj4gPiAgCXNkaGNpX3BsdGZtX2ZyZWUocGRldik7DQo+ID4NCj4gPiAgCXJldHVybiAw
Ow0KPiA+IEBAIC0xNjQ5LDYgKzE2NjksOSBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3J1bnRp
bWVfc3VzcGVuZChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ID4gIAl9DQo+ID4gIAljbGtfZGlz
YWJsZV91bnByZXBhcmUoaW14X2RhdGEtPmNsa19haGIpOw0KPiA+DQo+ID4gKwlpZiAoaW14X2Rh
dGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19QTVFPUykNCj4gPiArCQlwbV9xb3NfcmVt
b3ZlX3JlcXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4g
cmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMTY1OSw2ICsxNjgyLDEwIEBAIHN0YXRpYyBpbnQg
c2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUoc3RydWN0DQo+IGRldmljZSAqZGV2KQ0KPiA+ICAJ
c3RydWN0IHBsdGZtX2lteF9kYXRhICppbXhfZGF0YSA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1f
aG9zdCk7DQo+ID4gIAlpbnQgZXJyOw0KPiA+DQo+ID4gKwlpZiAoaW14X2RhdGEtPnNvY2RhdGEt
PmZsYWdzICYgRVNESENfRkxBR19QTVFPUykNCj4gPiArCQlwbV9xb3NfYWRkX3JlcXVlc3QoJmlt
eF9kYXRhLT5wbV9xb3NfcmVxLA0KPiA+ICsJCQlQTV9RT1NfQ1BVX0RNQV9MQVRFTkNZLCAwKTsN
Cj4gDQo+IFNob3VsZG4ndCB5b3UgdGhlbiByZW1vdmUgdGhlIHJlcXVlc3Qgb24gdGhlIHN1YnNl
cXVlbnQgZXJyb3IgcGF0aHM/DQo+IA0KW0JvdWdoIENoZW5dIFllcywgdGhhdCBhIGdvb2QgY2F0
Y2gsIEkgd2lsbCBhZGQgdGhpcywgYW5kIHNlbmQgYSBWMiBwYXRjaC4gVGhhbmtzIQ0KDQo+ID4g
Kw0KPiA+ICAJZXJyID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlteF9kYXRhLT5jbGtfYWhiKTsNCj4g
PiAgCWlmIChlcnIpDQo+ID4gIAkJcmV0dXJuIGVycjsNCj4gPg0KDQo=
