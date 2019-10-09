Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08BD08A0
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfJIHnA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 03:43:00 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:40506
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJIHnA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Oct 2019 03:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX1iihfh67LT/C49vAADNtO5FyrqKx8SK5d3vr/z8fgHaavoQO386GpiiWal8C/eDdzVIU8/K5LIUDIH3wSVrt3SOYlI3GxxCw7hqWTp9VDvFOYMvsX1I7d+k18URnndvcgpb+l0Tf/0NcNLZ3WA4vI35XIs1SwSX1kupN0LwXTOi4rqZLqhDR9XU2DTDxDxgu+Epeg6xQv/mqyuRfuYiJj1H6kwQgu93ld5iqFFbmRk/QhGKr4qI+1aBN/ls81rJHiYw5sSPJRatogpBvrgdA9OpJ7aHXMiMQTFIJYff3x3o5+m6DmYgp8HAo3ajd0GB6tBTMl5a2EIrwJWTBipHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OA+rbPG1ZnMkRdJ0DAu8+CZdDHRhOXJCQM6VnDw85Q=;
 b=IyrAdRZTrtrM47P8X5X8hR77RRrTolGI0ow13QUx1j39TqXDYAT2tu3/QvPLiY6JAlAKZGSRypTeVHiDEedYINWluEQyG2SUuuhNpbK1RIMQD7FhukqQrr47RA14iQZG/+B/oX9U2YoZ59nGtnJP0f4xx/LBKEGnzQ/lUCeosVrg6+tGf9QpEKO4hx3Tm8cV2zn4S1Ql1ARBBPlHl0x/pAkaqXusokxR2ev4HRdAwQRwC1YKLiVi1R+6w0qNDFtA5UvVHSCMMLZWsoyE5CAURlbGl6TRGT/2pXL+Sp3uVB09Rb9FkzIVSjy3Kz3KSaBzYH+ms8S0GziKNTtY5iTIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OA+rbPG1ZnMkRdJ0DAu8+CZdDHRhOXJCQM6VnDw85Q=;
 b=LN3SrbKYXHSQ4aA24K7udrEILXKf6CKtNVdZHg7K6n0xVLU9fziwYlqjlZBXOGo4O6cn5AWVIJkRMnDCI0WiAH4J7GZSP7G2+SM1OV4u4AXOIBLnjloEel2oort1HgtN2Jkdw+PqDuli1YSeZoOEBlIi+0Hsqd8KNsJAXUv0qlo=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2447.eurprd04.prod.outlook.com (10.168.63.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 07:42:55 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::dd4c:8b3a:db0a:a483%8]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 07:42:55 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [v2, 1/2] mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit
 until completion
Thread-Topic: [v2, 1/2] mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit
 until completion
Thread-Index: AQHVcrqrrjsBC2NPCEu+U8rbbQbENqdQpqAAgAFd48A=
Date:   Wed, 9 Oct 2019 07:42:55 +0000
Message-ID: <VI1PR0401MB22371A704C36AA08CA6C32A7F8950@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190924093131.17471-1-yangbo.lu@nxp.com>
 <20190924093131.17471-2-yangbo.lu@nxp.com>
 <2d4e8bb6-f58a-06dd-9de5-40c8083ecee5@intel.com>
In-Reply-To: <2d4e8bb6-f58a-06dd-9de5-40c8083ecee5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 904be293-1769-4609-96f2-08d74c8c4c1d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0401MB2447:
x-microsoft-antispam-prvs: <VI1PR0401MB2447F1E45126BE1D923FBD17F8950@VI1PR0401MB2447.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(13464003)(2501003)(256004)(8936002)(55016002)(9686003)(6436002)(486006)(476003)(76116006)(446003)(8676002)(11346002)(186003)(81156014)(81166006)(26005)(7696005)(66946007)(33656002)(229853002)(305945005)(316002)(53546011)(110136005)(74316002)(5660300002)(6246003)(64756008)(99286004)(66556008)(66446008)(86362001)(102836004)(66476007)(76176011)(71200400001)(71190400001)(6506007)(6116002)(478600001)(25786009)(14454004)(3846002)(7736002)(2906002)(52536014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2447;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMfy2xnd0wu4dKVZ1eBw4HMcQZvFLS1tull3+j37bhXwcQhFNCGa3QntE3sgRDKkrwAs/NoC7JUNar8S1Yn9G7rIka8vqhKfImmGo6r3bylOVqJTxcpdXWgMKf1Lohf1Sr6nQk7ZjWj5Nme3QiXMVlZWPYjQvx6sWmZQZVbkFXmGylh+ZBBXUlXilCdLEb0kKbvBdgggkorwwz6n/QTiYLeAZagphZnVfNIssW5AYurNvZkBP+vkthFU7W+D7mSN31PUULmVBob+vDXipBVOIhi63c91qEjic+FtSC4PYiIk4ku+iCrB+YOzZB/TMDlKfp2L0KjhbVyVPlhesYTZ/1ZTVXt2PKRqzrYO/juKMr8Z9c8UfA70bTISWKeFXScig0tm+y1CS01zVGV4+zfzRPcRZzPe/eZ1VL8kp647fAU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904be293-1769-4609-96f2-08d74c8c4c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 07:42:55.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fuk6OqZTvPzLOvz/0Flz+drVm2wOVAqQcRzqCRDsUAaFD8ckWqtia+qdlWnTnpCjGIxv73hNtB8tV7nFHq6IrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2447
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3Rv
YmVyIDgsIDIwMTkgNjo0OSBQTQ0KPiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+OyBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGlu
YXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFt2MiwgMS8yXSBtbWM6IHNkaGNpLW9mLWVzZGhjOiBw
b2xsIEVTREhDX0ZMVVNIX0FTWU5DX0ZJRk8NCj4gYml0IHVudGlsIGNvbXBsZXRpb24NCj4gDQo+
IE9uIDI0LzA5LzE5IDEyOjMxIFBNLCBZYW5nYm8gTHUgd3JvdGU6DQo+ID4gVGhlIEVTREhDX0ZM
VVNIX0FTWU5DX0ZJRk8gYml0IHdoaWNoIGlzIHNldCB0byBmbHVzaCBhc3luY2hyb25vdXMgRklG
Tw0KPiA+IHNob3VsZCBiZSBwb2xsZWQgdW50aWwgaXQncyBhdXRvIGNsZWFyZWQgYnkgaGFyZHdh
cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHYyOg0KPiA+IAktIE5vbmUuDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYyB8IDMyDQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVz
ZGhjLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYw0KPiA+IGluZGV4
IDFkMTk1M2QuLmJlMGJhNmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1lc2RoYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5j
DQo+ID4gQEAgLTY1NSw2ICs2NTUsMjEgQEAgc3RhdGljIHZvaWQgZXNkaGNfb2Zfc2V0X2Nsb2Nr
KHN0cnVjdCBzZGhjaV9ob3N0DQo+ICpob3N0LCB1bnNpZ25lZCBpbnQgY2xvY2spDQo+ID4gIAkJ
dGVtcCA9IHNkaGNpX3JlYWRsKGhvc3QsIEVTREhDX0RNQV9TWVNDVEwpOw0KPiA+ICAJCXRlbXAg
fD0gRVNESENfRkxVU0hfQVNZTkNfRklGTzsNCj4gPiAgCQlzZGhjaV93cml0ZWwoaG9zdCwgdGVt
cCwgRVNESENfRE1BX1NZU0NUTCk7DQo+ID4gKwkJLyogV2FpdCBtYXggMjAgbXMgKi8NCj4gPiAr
CQl0aW1lb3V0ID0ga3RpbWVfYWRkX21zKGt0aW1lX2dldCgpLCAyMCk7DQo+ID4gKwkJd2hpbGUg
KDEpIHsNCj4gPiArCQkJYm9vbCB0aW1lZG91dCA9IGt0aW1lX2FmdGVyKGt0aW1lX2dldCgpLCB0
aW1lb3V0KTsNCj4gPiArDQo+ID4gKwkJCWlmICghKHNkaGNpX3JlYWRsKGhvc3QsIEVTREhDX0RN
QV9TWVNDVEwpICYNCj4gPiArCQkJICAgICAgRVNESENfRkxVU0hfQVNZTkNfRklGTykpDQo+ID4g
KwkJCQlicmVhazsNCj4gPiArCQkJaWYgKHRpbWVkb3V0KSB7DQo+ID4gKwkJCQlwcl9lcnIoIiVz
OiB0dW5pbmcgYmxvY2sgcG9sbGluZyBGTFVTSF9BU1lOQ19GSUZPDQo+IHRpbWVvdXQuXG4iLA0K
PiA+ICsJCQkJCW1tY19ob3N0bmFtZShob3N0LT5tbWMpKTsNCj4gPiArCQkJCWJyZWFrOw0KPiA+
ICsJCQl9DQo+ID4gKwkJCXVkZWxheSgxMCk7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0KPiA+DQo+ID4g
IAkvKiBXYWl0IG1heCAyMCBtcyAqLw0KPiA+IEBAIC04MTEsNiArODI2LDcgQEAgc3RhdGljIHN0
cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZQ0KPiA+IHNvY19maXh1cF90dW5pbmdbXSA9IHsNCj4g
Pg0KPiA+ICBzdGF0aWMgdm9pZCBlc2RoY190dW5pbmdfYmxvY2tfZW5hYmxlKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0LCBib29sDQo+ID4gZW5hYmxlKSAgew0KPiA+ICsJa3RpbWVfdCB0aW1lb3V0
Ow0KPiA+ICAJdTMyIHZhbDsNCj4gPg0KPiA+ICAJZXNkaGNfY2xvY2tfZW5hYmxlKGhvc3QsIGZh
bHNlKTsNCj4gPiBAQCAtODE5LDYgKzgzNSwyMiBAQCBzdGF0aWMgdm9pZCBlc2RoY190dW5pbmdf
YmxvY2tfZW5hYmxlKHN0cnVjdA0KPiBzZGhjaV9ob3N0ICpob3N0LCBib29sIGVuYWJsZSkNCj4g
PiAgCXZhbCB8PSBFU0RIQ19GTFVTSF9BU1lOQ19GSUZPOw0KPiA+ICAJc2RoY2lfd3JpdGVsKGhv
c3QsIHZhbCwgRVNESENfRE1BX1NZU0NUTCk7DQo+ID4NCj4gPiArCS8qIFdhaXQgbWF4IDIwIG1z
ICovDQo+ID4gKwl0aW1lb3V0ID0ga3RpbWVfYWRkX21zKGt0aW1lX2dldCgpLCAyMCk7DQo+ID4g
Kwl3aGlsZSAoMSkgew0KPiA+ICsJCWJvb2wgdGltZWRvdXQgPSBrdGltZV9hZnRlcihrdGltZV9n
ZXQoKSwgdGltZW91dCk7DQo+ID4gKw0KPiA+ICsJCWlmICghKHNkaGNpX3JlYWRsKGhvc3QsIEVT
REhDX0RNQV9TWVNDVEwpICYNCj4gPiArCQkgICAgICBFU0RIQ19GTFVTSF9BU1lOQ19GSUZPKSkN
Cj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJaWYgKHRpbWVkb3V0KSB7DQo+ID4gKwkJCXByX2Vycigi
JXM6IHR1bmluZyBibG9jayBwb2xsaW5nIEZMVVNIX0FTWU5DX0ZJRk8NCj4gdGltZW91dC5cbiIs
DQo+ID4gKwkJCQltbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7DQo+ID4gKwkJCWJyZWFrOw0KPiA+
ICsJCX0NCj4gPiArCQl1ZGVsYXkoMTApOw0KPiA+ICsJfQ0KPiANCj4gVGhhdCBjb2RlIGlzIHRo
ZSBzYW1lIGFzIHRoZSBibG9jayBhYm92ZSwgc28gaXQgY291bGQgYmUgYSBzZXBhcmF0ZSBmdW5j
dGlvbi4NCj4gQWxzbyB5b3UgZG9uJ3QgdXNlIFNESENJX1FVSVJLX0NMT0NLX0JFRk9SRV9SRVNF
VCBzbyB1c2luZw0KPiB1c2xlZXBfcmFuZ2Ugd291bGQgYmUgb2sgaW5zdGVhZCBvZiB1ZGVsYXku
DQoNCltZLmIuIEx1XSBTZW50IG91dCB2My4gQ29udmVydGVkIHRvIHVzZSBlc2RoY19mbHVzaF9h
c3luY19maWZvKCksIGFuZCB1c2VkIHVzbGVlcF9yYW5nZSgpIGluc3RlYWQgb2YgdWRlbGF5KCku
DQpUaGFua3MhDQoNCj4gDQo+ID4gKw0KPiA+ICAJdmFsID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNE
SENfVEJDVEwpOw0KPiA+ICAJaWYgKGVuYWJsZSkNCj4gPiAgCQl2YWwgfD0gRVNESENfVEJfRU47
DQo+ID4NCg0K
