Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4910488B
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Nov 2019 03:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUCae (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 21:30:34 -0500
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:55922
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfKUCae (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Nov 2019 21:30:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLAR1YAfUZZmfG/YexteQzWqAqpLwQGyrL1IV6ehrTVZ8WiLDS9XNHDlVih56WrhGnpupI75wk6zTXUo8IUKAQcCcMu7Ye3BwI1EEwK8EoHLTcEtkHNm4WCsm0M/V8STadclYlMAWVAu3U7/A2ShS4IpTyjpzmnRtuDqH057e9z7r34MBlQESYzwN/aZzWnt0ZZYhym7WoSlopFgdTlw7ah+uz5+e5imMhUonc7JXcwmEzdwWsCggM5RSlHdiZGF9zfKTKESgNJYcp4x5/06rAqsUSzw9z+MgmzuKDHF4SnNJYCWJOpyOhv+JuzzhPF1eJ3/CgrlvGFOQ1vE3FP4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVwVov5IlToU8ME+ujGWAWY8VM0syPbLUgpNMraIVuM=;
 b=ZbAu1cp3WX09jle4QX0cf5Bo9B+UWjrFA/WbMNLxBscQiXaXJn/RXuvNnyi+CZ4bqItXudEtXbQM9Kad1ds+NFY0JMSTGNBqtkC2k4PZUv3BKWtcxJKS77oo2LgaD4aqsDo1aGMijSFnUVyGNAsWDR3YdoPH4WjS/BfDXV8iUuB3LUP4htiENJoNUF3EsL1jBmOJnFGTOuFCkTIL7riaGtm4Kk8ixGNpeqxmNlMvRRa2sdIaMx4tNaC3rp6pnH6qrOhU99pWAD3nNKCgl11YSJNne7wKwpy0KXJJkFVlFR/ZgqbG4RPE7a+IGw0o7uC/dvPFFyTjNSjOg8B2/xU1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVwVov5IlToU8ME+ujGWAWY8VM0syPbLUgpNMraIVuM=;
 b=dzboLeuX1IREk2Hth+zsGdr/6onhFwFpMo3Rr9MncvxCqxZ9GO2qYqsw+cCBxokH8CTT4zZ7FVCuLqCyAUxvxc3Mvpw+gSr0qm5jVdbR/FwZ53v/71xVOWaqVD4hXYuVR1FW4hPnQH0iqVwZn8liNghyAOVLtXWI8D0NbuKQBPs=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2335.eurprd04.prod.outlook.com (10.169.136.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Thu, 21 Nov 2019 02:21:21 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 02:21:20 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Topic: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Index: AQHVmt010K5vWAAIEUqaLh2zVaVaTaeKsE+AgAo8BHA=
Date:   Thu, 21 Nov 2019 02:21:20 +0000
Message-ID: <VI1PR0401MB22374449D6FEC683E08BDF99F84E0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
 <CAPDyKFo16PZHd-0vAvBg6FCbGvrgsarPe5h=EcR3rCtRi27SWA@mail.gmail.com>
In-Reply-To: <CAPDyKFo16PZHd-0vAvBg6FCbGvrgsarPe5h=EcR3rCtRi27SWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da55628f-306c-40bb-0859-08d76e297f82
x-ms-traffictypediagnostic: VI1PR0401MB2335:
x-microsoft-antispam-prvs: <VI1PR0401MB23351FB03E859C157174B8A5F84E0@VI1PR0401MB2335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(13464003)(189003)(199004)(102836004)(8936002)(6506007)(256004)(71190400001)(7696005)(11346002)(5660300002)(478600001)(14454004)(110136005)(316002)(14444005)(86362001)(76176011)(6116002)(25786009)(81166006)(6246003)(71200400001)(74316002)(4326008)(229853002)(52536014)(66066001)(81156014)(33656002)(305945005)(66446008)(64756008)(66476007)(486006)(66556008)(476003)(446003)(8676002)(2906002)(186003)(76116006)(66946007)(9686003)(55016002)(6436002)(26005)(3846002)(53546011)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2335;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJwpTjrtWZjNICHG4ymM6cGk8PRJF81K7e5aOSUejw2vfLEiorUlKDUUWJ/WIn6MgXsBHuN+xB0AV79c+EJIKlKVWDSnjGA8uPHQxQMsyRHjB4/xybGI3XyR+7qWXjgHcRhVxiYH5UGnmcn11kc/mQX2Ob4iq3eYxoIZo63893D0GG3Az6Kpbc5PzWlcLzk/bKcUsxP/DwOB46yzR5/eFTY7s5KVpsTtHczpmDIixHTpuKjqkXM9gCBTWZyFRJR97wK+HWe3RoFBQobMmngz7/B8dtCMflyRfM3TzRLao5I1EJszziKRtiXWmqahkV3G/fPzySe+qMtEpSuhKlfnkl4PWbVnLxOw1qJQLwO8ZXL13YJdKclRCTOf3+o3FJnE3XBUBezn18/xzwy/6w8BcSG+KsZ46WcjTZaLqYZoh3oMN8uOk2VH1Q3YY31Ezeel
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55628f-306c-40bb-0859-08d76e297f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 02:21:20.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axKAFhLOgU+Jw3asSMpDSo7OkP/tUc3sCs5CbymAScdWoTMpAEu2KB/0YtWNczYOKuazc4PdtMPXoBikOQDsLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2335
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTQs
IDIwMTkgOTo1NCBQTQ0KPiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+DQo+IENjOiBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBzZGhjaTogZml4IHVwIENNRDEy
IHNlbmRpbmcNCj4gDQo+IE9uIFRodSwgMTQgTm92IDIwMTkgYXQgMTI6MTgsIFlhbmdibyBMdSA8
eWFuZ2JvLmx1QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIFNUT1AgY29tbWFuZCBpcyBk
aXNhYmxlZCBmb3IgbXVsdGlwbGUgYmxvY2tzIHIvdyBjb21tYW5kcyB3aXRoDQo+ID4gYXV0byBD
TUQxMiwgd2hlbiBzdGFydCB0byBzZW5kLiBIb3dldmVyLCBpZiB0aGVyZSBpcyBkYXRhIGVycm9y
LA0KPiA+IHNvZnR3YXJlIHN0aWxsIG5lZWRzIHRvIHNlbmQgQ01EMTIgYWNjb3JkaW5nIHRvIFNE
IHNwZWMuDQo+ID4gVGhpcyBwYXRjaCBpcyB0byBhbGxvdyBzb2Z0d2FyZSBDTUQxMiBzZW5kaW5n
IGZvciB0aGlzIGNhc2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8gTHUgPHlhbmdi
by5sdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgfCAx
NyArKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgaW5kZXgNCj4gPiAwOWNkYmU4Li4z
MDQxYzM5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+IEBAIC0xMzI2LDEyICsxMzI2LDEyIEBA
IHN0YXRpYyB2b2lkIHNkaGNpX2ZpbmlzaF9kYXRhKHN0cnVjdA0KPiA+IHNkaGNpX2hvc3QgKmhv
c3QpDQo+ID4NCj4gPiAgICAgICAgIC8qDQo+ID4gICAgICAgICAgKiBOZWVkIHRvIHNlbmQgQ01E
MTIgaWYgLQ0KPiA+IC0gICAgICAgICogYSkgb3Blbi1lbmRlZCBtdWx0aWJsb2NrIHRyYW5zZmVy
IChubyBDTUQyMykNCj4gPiArICAgICAgICAqIGEpIG9wZW4tZW5kZWQgbXVsdGlibG9jayB0cmFu
c2ZlciBub3QgdXNpbmcgYXV0byBDTUQxMiAobm8NCj4gPiArIENNRDIzKQ0KPiA+ICAgICAgICAg
ICogYikgZXJyb3IgaW4gbXVsdGlibG9jayB0cmFuc2Zlcg0KPiA+ICAgICAgICAgICovDQo+ID4g
ICAgICAgICBpZiAoZGF0YS0+c3RvcCAmJg0KPiA+IC0gICAgICAgICAgIChkYXRhLT5lcnJvciB8
fA0KPiA+IC0gICAgICAgICAgICAhZGF0YS0+bXJxLT5zYmMpKSB7DQo+ID4gKyAgICAgICAgICAg
KCghZGF0YS0+bXJxLT5zYmMgJiYgIXNkaGNpX2F1dG9fY21kMTIoaG9zdCwgZGF0YS0+bXJxKSkg
fHwNCj4gPiArICAgICAgICAgICAgZGF0YS0+ZXJyb3IpKSB7DQo+IA0KPiBQZXIgeW91ciBvdGhl
ciByZXBseSB0byB0aGlzIHRocmVhZCwgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkgaGFybSBp
biBhbHdheXMNCj4gc2VuZGluZyBhIENNRDEyIGlmIHRoZXJlIGlzIGFuIGVycm9yLCBhdCBsZWFz
dCBmcm9tIHRoZSBjYXJkJ3MgcG9pbnQgb2Ygdmlldy4NCj4gDQo+IFRoZSB3b3JzdCB0aGluZyB0
aGF0IGNhbiBoYXBwZW4gaXMgdGhhdCB0aGVyZSBhcmUgdHdvIENNRDEyIHNlbnQgdG8gdGhlIGNh
cmQNCj4gYW5kIEkgZG9uJ3QgdGhpbmsgdGhhdCBpcyBhIHByb2JsZW0gZm9yIHRoZSBlcnJvciBw
YXRoLg0KPiANCj4gTXkgb25seSBjb25jZXJuLCBpcyB0byB1bmRlcnN0YW5kIGlmICRzdWJqZWN0
IHBhdGNoIGNhdXNlcyBvdGhlciBjaGFuZ2VzIGluDQo+IGJlaGF2aW91cnMgZm9yIHRoZSBTREhD
SSBkcml2ZXIuIExldCdzIHNlZSB3aGF0IEFkcmlhbiB0aGlua3MuDQoNCltZLmIuIEx1XSBZZXMu
IFRoZSBwdXJwb3NlIGlzIHRvIGF2b2lkIG5vIENNRDEyIHNlbnQgaWYgZ2V0IGRhdGEgZXJyb3Iu
IFRoYXQgd2lsbCBtYWtlcyBibG9jayBkcml2ZXIgZmFpbGVkIGF0IGJsb2NrIHIvdyByZWNvdmVy
eSB3aGVuIHNlbmRpbmcgQ01EMTMgdG8gZ2V0IHN0YXR1cy4NCk91ciBwbGF0Zm9ybSBvbiBzb21l
IGJvYXJkcyBhdCBvbGQga2VybmVsIDQuMTQgc2VlbXMgdG8gaGl0IHRoaXMgY2FzZS4NCg0KSGkg
QWRyaWFuLA0KQ291bGQgeW91IGhlbHAgdG8gcmV2aWV3IHRoZSBjaGFuZ2VzPw0KVGhhbmtzLg0K
DQo+IA0KPiA+ICAgICAgICAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAgICAgICAgKiAnY2Fw
X2NtZF9kdXJpbmdfdGZyJyByZXF1ZXN0IG11c3Qgbm90IHVzZSB0aGUNCj4gY29tbWFuZCBsaW5l
DQo+ID4gICAgICAgICAgICAgICAgICAqIGFmdGVyIG1tY19jb21tYW5kX2RvbmUoKSBoYXMgYmVl
biBjYWxsZWQuIEl0IGlzDQo+ID4gdXBwZXIgbGF5ZXIncyBAQCAtMTgyNSwxNyArMTgyNSw2IEBA
IHZvaWQgc2RoY2lfcmVxdWVzdChzdHJ1Y3QNCj4gPiBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1j
X3JlcXVlc3QgKm1ycSkNCj4gPg0KPiA+ICAgICAgICAgc2RoY2lfbGVkX2FjdGl2YXRlKGhvc3Qp
Ow0KPiA+DQo+ID4gLSAgICAgICAvKg0KPiA+IC0gICAgICAgICogRW5zdXJlIHdlIGRvbid0IHNl
bmQgdGhlIFNUT1AgZm9yIG5vbi1TRVRfQkxPQ0tfQ09VTlRFRA0KPiA+IC0gICAgICAgICogcmVx
dWVzdHMgaWYgQXV0by1DTUQxMiBpcyBlbmFibGVkLg0KPiA+IC0gICAgICAgICovDQo+ID4gLSAg
ICAgICBpZiAoc2RoY2lfYXV0b19jbWQxMihob3N0LCBtcnEpKSB7DQo+ID4gLSAgICAgICAgICAg
ICAgIGlmIChtcnEtPnN0b3ApIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBtcnEtPmRh
dGEtPnN0b3AgPSBOVUxMOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIG1ycS0+c3RvcCA9
IE5VTEw7DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgIH0NCj4gDQo+IEluIGdl
bmVyYWwsIEkgYW0gbm90IHZlcnkgZm9uZCBvZiB3aGVuIGhvc3QgZHJpdmVycyBjaGFuZ2UgdGhl
c2Ugc3RydWN0dXJlcw0KPiB1bmRlciB0aGUgaG9vZCBvZiB0aGUgY29yZSwgd2hpY2ggbWVhbnMg
SSBsaWtlIHRoaXMgcGFydC4NCj4gDQo+ID4gLQ0KPiA+ICAgICAgICAgaWYgKCFwcmVzZW50IHx8
IGhvc3QtPmZsYWdzICYgU0RIQ0lfREVWSUNFX0RFQUQpIHsNCj4gPiAgICAgICAgICAgICAgICAg
bXJxLT5jbWQtPmVycm9yID0gLUVOT01FRElVTTsNCj4gPiAgICAgICAgICAgICAgICAgc2RoY2lf
ZmluaXNoX21ycShob3N0LCBtcnEpOw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiANCj4gS2lu
ZCByZWdhcmRzDQo+IFVmZmUNCg==
