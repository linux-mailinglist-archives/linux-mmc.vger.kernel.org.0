Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21D108C5C
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Nov 2019 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKYK5J (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 25 Nov 2019 05:57:09 -0500
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:41567
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfKYK5J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Nov 2019 05:57:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyFQOxYV3aCz9nEtfo4iWUc2jY+n9L3HfzHy3g37cVnZbcce80hu4+9mB8xgspIiV6R4M4hENjqRk4CxibrhhDGFm0pfv/E1a3pg1ZzwWJfBaxmK1Rn98RqOXW3XWxWSRQnb60YpD1VexUzOM8ErhtBB2xjxGlH9/3LkXTzk9PDZgdMq/NtHU05zJz3RinGp8YqWe+EmHg2waws7VjI/bH/UtDD6aN8z0S+dQfBzs3qvm08vMLf1gTFDcpZ/I07K8rAICqvupYz9WoDKM1D9NWOm38JRJmJ2cGNUR1/Ta2YrCIIHVyzkTjT3TdhWptMev7anvBq62QIx/3gnElrQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkMRRQoNySwIj9SmllfkCytE3eGDAyWsz5tV8TdqSrE=;
 b=bQo2tmbE/6cbIBLY1rQldci6KdR+nZWJyEb2D92J+qRrz/K+coPKnvdQh4WMQUa7nh0ieLc4oqiX2BC38if4K2ODylaZ/tp/+vp2PinwPNZCejKNFGk5Tpf/GQemglghEdbhub36YhL4agus6uYJRl08+SgWorUrY8V4XoL6ZEMU+kGYScI029kz+guwJTrsUERpiPIs9qPlW2RVvBAxoDxrITTVha6hkug7OaBwJGSyQgiOfaPLOBiKPF+oWHUqOtLWzpC7SECAeZ244XkiX9F8coHh4aV77YIOR2sBK//74U+AxC1gRp6LaSCXigEL4B6wIzdfgrVgiIgnhJq7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkMRRQoNySwIj9SmllfkCytE3eGDAyWsz5tV8TdqSrE=;
 b=Z+MuTU8KUQeRrrKL8elMC7XaFOZ9E5tfJxd5g0QsvPdSnrLjUEE3SCCngC7/BCJuCgNTvg+wdOgpzTst0IqYmSiVOsnE4VfxPphjAo6M+eTiet04mmpg5mZ96MAhrky1KCDfGZK9clXcpOipdxCQ/XqzT7eg2m9q+wSAgJFo82c=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2637.eurprd04.prod.outlook.com (10.168.61.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Mon, 25 Nov 2019 10:57:03 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::2d81:2d60:747c:d0ad%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 10:57:03 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Topic: [PATCH] mmc: sdhci: fix up CMD12 sending
Thread-Index: AQHVmt010K5vWAAIEUqaLh2zVaVaTaeKsE+AgAo8BHCAAJ2iAIAGOBow
Date:   Mon, 25 Nov 2019 10:57:03 +0000
Message-ID: <VI1PR0401MB223777071D4FDC6657B3A7FBF84A0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
 <CAPDyKFo16PZHd-0vAvBg6FCbGvrgsarPe5h=EcR3rCtRi27SWA@mail.gmail.com>
 <VI1PR0401MB22374449D6FEC683E08BDF99F84E0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <9e692f0b-6bac-6be8-bc82-5d47930dd4e2@intel.com>
In-Reply-To: <9e692f0b-6bac-6be8-bc82-5d47930dd4e2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c139847-7114-4bc5-e119-08d77196348d
x-ms-traffictypediagnostic: VI1PR0401MB2637:
x-microsoft-antispam-prvs: <VI1PR0401MB2637D62B86DDD8ECBF158CD0F84A0@VI1PR0401MB2637.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(13464003)(199004)(189003)(76116006)(66556008)(64756008)(66446008)(66476007)(66946007)(52536014)(5660300002)(6246003)(478600001)(229853002)(6506007)(11346002)(81166006)(8936002)(6436002)(53546011)(446003)(7696005)(74316002)(99286004)(102836004)(14444005)(86362001)(14454004)(186003)(33656002)(256004)(81156014)(8676002)(76176011)(305945005)(316002)(2906002)(26005)(7736002)(9686003)(110136005)(25786009)(4326008)(71200400001)(66066001)(3846002)(71190400001)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2637;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PV3jWdIPEJbtaTx1eROyuPJPcwV1576lvFBk7LRep1Kx2Un4sDDUTrVU15ZCf/hERwamkpC29vWqFBbiyjKAQHIoU+YPXOsKTQWsX0X8ttKov1pSKqyJei6KapnYpiiWJz46sUSO4Es/mRxuRlqM4Kp5Ne1ASJuMApOPbHOPIRXbGmZGjIHxv7Vo2WjvO9Gmf5s244+kFXQNNWEzctQJ+ic1iPX9+q0wT+VKUFJm/a/weOcBkM7M7PpZCufOzp+U1Y72021zvSq5iffWuxAt938U61+Od1PeNP3NPEee2RNLd2MeCHn/5yfpWXdZV7nEnTW2D8vXOvMXsj8w7l4GqAUH6lxxxhdTPtClOyYymtqjjwx7Oyp6MAL8bbzSWVtE4gFDTvTUsnI1BrOGM3sScWa0kS5/x/XKskkapmDHZopWSw4f0TdWDnCQWEIoZC1Y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c139847-7114-4bc5-e119-08d77196348d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 10:57:03.5941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cySQg01FrnRDdx3sHZj9wnP9lhPdxU5gBYKtPw2Bg2aMWBzGVLPwaJWJ0CCMvJk59oKoM1KibN8YfYEqTtm+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2637
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtbW1jLW93bmVy
QHZnZXIua2VybmVsLm9yZyA8bGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZz4NCj4gT24g
QmVoYWxmIE9mIEFkcmlhbiBIdW50ZXINCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDIxLCAy
MDE5IDc6MzYgUE0NCj4gVG86IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPjsgVWxmIEhhbnNz
b24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2k6IGZpeCB1cCBDTUQxMiBzZW5k
aW5nDQo+IA0KPiBPbiAyMS8xMS8xOSA0OjIxIEFNLCBZLmIuIEx1IHdyb3RlOg0KPiA+IEhpLA0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFVsZiBIYW5z
c29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1i
ZXIgMTQsIDIwMTkgOTo1NCBQTQ0KPiA+PiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+
DQo+ID4+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBBZHJpYW4gSHVudGVyDQo+ID4+
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1j
OiBzZGhjaTogZml4IHVwIENNRDEyIHNlbmRpbmcNCj4gPj4NCj4gPj4gT24gVGh1LCAxNCBOb3Yg
MjAxOSBhdCAxMjoxOCwgWWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4gd3JvdGU6DQo+ID4+
Pg0KPiA+Pj4gVGhlIFNUT1AgY29tbWFuZCBpcyBkaXNhYmxlZCBmb3IgbXVsdGlwbGUgYmxvY2tz
IHIvdyBjb21tYW5kcyB3aXRoDQo+ID4+PiBhdXRvIENNRDEyLCB3aGVuIHN0YXJ0IHRvIHNlbmQu
IEhvd2V2ZXIsIGlmIHRoZXJlIGlzIGRhdGEgZXJyb3IsDQo+ID4+PiBzb2Z0d2FyZSBzdGlsbCBu
ZWVkcyB0byBzZW5kIENNRDEyIGFjY29yZGluZyB0byBTRCBzcGVjLg0KPiA+Pj4gVGhpcyBwYXRj
aCBpcyB0byBhbGxvdyBzb2Z0d2FyZSBDTUQxMiBzZW5kaW5nIGZvciB0aGlzIGNhc2UuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWWFuZ2JvIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDE3ICsrKy0tLS0tLS0t
LS0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRp
b25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
YyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+Pj4gaW5kZXgNCj4gPj4+IDA5Y2RiZTgu
LjMwNDFjMzkgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4g
Pj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+Pj4gQEAgLTEzMjYsMTIgKzEz
MjYsMTIgQEAgc3RhdGljIHZvaWQgc2RoY2lfZmluaXNoX2RhdGEoc3RydWN0DQo+ID4+PiBzZGhj
aV9ob3N0ICpob3N0KQ0KPiA+Pj4NCj4gPj4+ICAgICAgICAgLyoNCj4gPj4+ICAgICAgICAgICog
TmVlZCB0byBzZW5kIENNRDEyIGlmIC0NCj4gPj4+IC0gICAgICAgICogYSkgb3Blbi1lbmRlZCBt
dWx0aWJsb2NrIHRyYW5zZmVyIChubyBDTUQyMykNCj4gPj4+ICsgICAgICAgICogYSkgb3Blbi1l
bmRlZCBtdWx0aWJsb2NrIHRyYW5zZmVyIG5vdCB1c2luZyBhdXRvIENNRDEyDQo+ID4+PiArIChu
bw0KPiA+Pj4gKyBDTUQyMykNCj4gPj4+ICAgICAgICAgICogYikgZXJyb3IgaW4gbXVsdGlibG9j
ayB0cmFuc2Zlcg0KPiA+Pj4gICAgICAgICAgKi8NCj4gPj4+ICAgICAgICAgaWYgKGRhdGEtPnN0
b3AgJiYNCj4gPj4+IC0gICAgICAgICAgIChkYXRhLT5lcnJvciB8fA0KPiA+Pj4gLSAgICAgICAg
ICAgICFkYXRhLT5tcnEtPnNiYykpIHsNCj4gPj4+ICsgICAgICAgICAgICgoIWRhdGEtPm1ycS0+
c2JjICYmICFzZGhjaV9hdXRvX2NtZDEyKGhvc3QsIGRhdGEtPm1ycSkpDQo+IHx8DQo+ID4+PiAr
ICAgICAgICAgICAgZGF0YS0+ZXJyb3IpKSB7DQo+ID4+DQo+ID4+IFBlciB5b3VyIG90aGVyIHJl
cGx5IHRvIHRoaXMgdGhyZWFkLCBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBoYXJtDQo+ID4+
IGluIGFsd2F5cyBzZW5kaW5nIGEgQ01EMTIgaWYgdGhlcmUgaXMgYW4gZXJyb3IsIGF0IGxlYXN0
IGZyb20gdGhlIGNhcmQncyBwb2ludA0KPiBvZiB2aWV3Lg0KPiA+Pg0KPiA+PiBUaGUgd29yc3Qg
dGhpbmcgdGhhdCBjYW4gaGFwcGVuIGlzIHRoYXQgdGhlcmUgYXJlIHR3byBDTUQxMiBzZW50IHRv
DQo+ID4+IHRoZSBjYXJkIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgYSBwcm9ibGVtIGZvciB0
aGUgZXJyb3IgcGF0aC4NCj4gPj4NCj4gPj4gTXkgb25seSBjb25jZXJuLCBpcyB0byB1bmRlcnN0
YW5kIGlmICRzdWJqZWN0IHBhdGNoIGNhdXNlcyBvdGhlcg0KPiA+PiBjaGFuZ2VzIGluIGJlaGF2
aW91cnMgZm9yIHRoZSBTREhDSSBkcml2ZXIuIExldCdzIHNlZSB3aGF0IEFkcmlhbiB0aGlua3Mu
DQo+ID4NCj4gPiBbWS5iLiBMdV0gWWVzLiBUaGUgcHVycG9zZSBpcyB0byBhdm9pZCBubyBDTUQx
MiBzZW50IGlmIGdldCBkYXRhIGVycm9yLiBUaGF0DQo+IHdpbGwgbWFrZXMgYmxvY2sgZHJpdmVy
IGZhaWxlZCBhdCBibG9jayByL3cgcmVjb3Zlcnkgd2hlbiBzZW5kaW5nIENNRDEzIHRvDQo+IGdl
dCBzdGF0dXMuDQo+ID4gT3VyIHBsYXRmb3JtIG9uIHNvbWUgYm9hcmRzIGF0IG9sZCBrZXJuZWwg
NC4xNCBzZWVtcyB0byBoaXQgdGhpcyBjYXNlLg0KPiA+DQo+ID4gSGkgQWRyaWFuLA0KPiA+IENv
dWxkIHlvdSBoZWxwIHRvIHJldmlldyB0aGUgY2hhbmdlcz8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsg
dGhlIGF1dG8tY21kMTIgZXJyb3IgaGFuZGxpbmcgd2FzIGV2ZXIgZG9uZSBwcm9wZXJseSwgc28g
aXQgd2lsbA0KPiB0YWtlIHdlIGEgd2hpbGUgdG8gcmV2aWV3IGl0Lg0KDQpbWS5iLiBMdV0gVGhh
bmtzIEFkcmlhbi4NCkkgYW0gY29uZnVzZWQgd2hlcmUgdGhlIGluaXRpYWwgZXJyb3IgcmVjb3Zl
cnkgc2hvdWxkIHN0YXJ0IGZvciBtdWx0aS1ibG9jayByL3cgKHdpdGggQVVUTyBDTUQxMikgZXJy
b3IuDQpJIGNhbiBzZWUgdHdvIHBsYWNlcyB3aGljaCBtYXkgc2VuZCBDTUQxMi4NCjEuIEluIHNk
aGNpX2ZpbmlzaF9kYXRhKCksIGFzIG15IHBhdGNoIGNoYW5nZXMsIEkgdGhpbmsgZm9yIGRhdGEt
PmVycm9yLCB0aGUgQ01EMTIgc2hvdWxkIGJlIHNlbnQuDQoyLiBJbiBtbWNfYmxrX21xX3J3X3Jl
Y292ZXJ5KCkgaW4gYmxvY2suYywgQ01EMTMgd2lsbCBiZSBzZW50IHdpdGggb25lIG1vcmUgcmV0
cnkgKHJldHVuaW5nIG1heSBoYXBwZW4pLCBiZWZvcmUgQ01EMTIuDQoNCkFuZCBJIGRvdWJ0IHRo
ZSByZWNvdmVyeSAxIGlmIHdlIGNhbiBzdGlsbCB1c2UgQ0MvVEMvRFRPRSBpbnRlcnJ1cHRzIHRv
IGNoZWNrIENNRDEyIHN1Y2Nlc3Mgb3Igbm90IChvciB3ZSBzaG91bGQganVzdCBwb2xsIERBVDAp
LCBmb3IgZGF0YSBlcnJvciBpbiB0dW5pbmcgbW9kZS4NClRoYW5rcy4NCg0K
