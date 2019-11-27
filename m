Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5610AE38
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 11:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0Kv6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Nov 2019 05:51:58 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:20678
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfK0Kv5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Nov 2019 05:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjZJoEpfbzWY/SDL4ipSQtMd7J9nSvg2rzFXNoNKihdBX4artdeadHuxXF/rmZuLNZ0C/ztRVU1Oe5qIi8oFerGETeIVbNb7M1BMCT74BCWu/ipllmZG/BZXF30G66An9uVrIxDZdCaaHrdKakQi/Juf65xYouwqoZ/VHt1AW3VI9jtJtnGOKx2/tv/j0Gp5L2RxcJMLzYNmASCBjbQbQdWd4iYpxfkxjD9jk3/XiiaNqTglYNsXb1xUxnCvdZohnlFFw7a/BgiEHEzrituGxLIudavKZbsKGSTzJaIwkGM86udKfXHW7AKf9WRR5GoLqyLwq2+u+LalRCFurEwlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JCOFkhbxZnAuE3M3arU/pZ1hXC8NhhRrfEuxYd9siI=;
 b=h6MB/gBf8S2duDx+1QEKWqBnyTMRbwKTjxuPxPpZ77mghPV482cirtbt05OncXq5gFDfM2ROdXKlO5rvBwmBtj9qmsd8U6OzbRb9APFGo+PLY3crtH2o/Ed7yKs4eurIy2t372yetOWom2VdDKiCaZwfqt15XrVtExGCwko5kDTEtL7Glmj6epw/MFo7pxWsZLfc2LzAu5u4C5VT7G+HdeZXbkP0qBEtoUaRAK27A9EfxnE0C7xQcas6/Km1MxcPoQ+y3Dr9PM1KAE7Y7IrdJue+KHaGrSo33EnmQ4R9ZHPxE+wj410PJNvR8aD4OWl/KQAeEOsqvA/HREX2X5drrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JCOFkhbxZnAuE3M3arU/pZ1hXC8NhhRrfEuxYd9siI=;
 b=hEP+XsNmxMdckJmLCqmoESrQtvTjQA9pnUYxGSNZw02GrzM8Q6xJf1B5Zh5ObCZr5Qw8Uoqug863U+VEHWflAYx/srahew7j6Hq7eDzdyidyCy+3DqGQPRvH9TNNJNclJ/FouXS9V3hxeX725Q9WYfh9LusmDCwnyMt6phn4Dec=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6333.eurprd04.prod.outlook.com (20.179.27.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 10:51:51 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 10:51:51 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 13/14] mmc: sdhci-esdhc-imx: handle 'auto-cmd23-broken'
 from devicetree
Thread-Topic: [PATCH 13/14] mmc: sdhci-esdhc-imx: handle 'auto-cmd23-broken'
 from devicetree
Thread-Index: AQHVm6azWMh/EPQHIE6XuY3w7bWT9Kedh6aAgAFiLUA=
Date:   Wed, 27 Nov 2019 10:51:51 +0000
Message-ID: <VI1PR04MB504093A653B7DBF9C5C7601D90440@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
 <1573816712-26841-4-git-send-email-haibo.chen@nxp.com>
 <901f6f1c-b5a8-c5e2-cd22-140c2818bcde@intel.com>
In-Reply-To: <901f6f1c-b5a8-c5e2-cd22-140c2818bcde@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d76e1ee7-63d0-441e-516c-08d77327cf71
x-ms-traffictypediagnostic: VI1PR04MB6333:|VI1PR04MB6333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB63330E5CA7F2984A9EA488BA90440@VI1PR04MB6333.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(189003)(199004)(13464003)(8936002)(66946007)(6246003)(102836004)(66066001)(25786009)(14454004)(478600001)(55016002)(6436002)(7696005)(71200400001)(186003)(26005)(4326008)(229853002)(9686003)(76176011)(2501003)(71190400001)(6506007)(53546011)(86362001)(54906003)(316002)(305945005)(7736002)(256004)(14444005)(11346002)(446003)(2906002)(99286004)(33656002)(2201001)(6116002)(3846002)(66446008)(64756008)(66556008)(66476007)(76116006)(5660300002)(8676002)(52536014)(81166006)(110136005)(81156014)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6333;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NrDzy3Bqq7uxttgmXinJBJwVnHUwQAgR9OxZJjAFN0VdLBhWO3J96tl7waYanK6SlnzhMseYMr8SnxEvTOsLNUCoKWPtraWUqFQiRLCuwbDzU4ISigKR23+p1TxVyZgbL52d+88CxKVDJ6AlrP+jysKQ5URdnlQzIdBnSa2/X6ewqNia6ULQkyMkxyP+2ke0N2ObEz6egEdcT0j7w8giZ+6ZgJZi64SrVFtgGzf5RJVzw9dwScIqfc7NY3poOBXdzWFTsdkw3+1ke37nqD2pNiegrxd5MKglevMx65DjFDe0AlPfF4iaelKMj0yRD8Nn01e+iYQsE12oZgPfn/1KKGBW15hEI7yjIlg9OajLVSj3jNq/ICBG3O2nalIq7TfjwsI7jqpQrNAlepUvLUGdHL2QHyBPLSKJx7ddnMguFZPpDuQG1W6JIkFkfoYay50
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76e1ee7-63d0-441e-516c-08d77327cf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 10:51:51.6165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWAuRfs9ru4wxwxCMF0yNe00dRPaSy7SWMrZe9bk1KXukNHiT3WXBGMKoLhTIfKVmgf0/f1wxIFFrMH84yMNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiAyMDE55bm0MTHmnIgyNuaXpSAyMTo0Mw0K
PiBUbzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlDQo+IENjOiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMTMvMTRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiBoYW5kbGUgJ2F1
dG8tY21kMjMtYnJva2VuJw0KPiBmcm9tIGRldmljZXRyZWUNCj4gDQo+IE9uIDE1LzExLzE5IDE6
MTggUE0sIGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBTaW5jZSBMNC4xNSwgY29tbXVuaXR5IGludm9s
dmUgdGhlIGNvbW1pdCAxMDU4MTljOGE1NDUgKCJtbWM6IGNvcmU6DQo+ID4gdXNlIG1ycS0+c2Jj
IHdoZW4gc2VuZGluZyBDTUQyMyBmb3IgUlBNQiIpLCBsZXQgdGhlIHVzZGhjIHRvIGRlY2lkZQ0K
PiA+IHdoZXRoZXIgdG8gdXNlIEFDTUQyMyBmb3IgUlBNQi4gVGhpcyBDTUQyMyBmb3IgUlBNQiBu
ZWVkIHRvIHNldCB0aGUNCj4gPiBiaXQgMzEgdG8gaXRzIGFyZ3VtZW50LCBpZiBub3QsIHRoZSBS
UE1CIHdyaXRlIG9wZXJhdGlvbiB3aWxsIHJldHVybiBnZW5lcmFsDQo+IGZhaWwuDQo+ID4NCj4g
PiBBY2NvcmRpbmcgdG8gdGhlIHNkaGNpIGxvZ2ljLCBTRE1BIG1vZGUgd2lsbCBkaXNhYmxlIHRo
ZSBBQ01EMjMsIGFuZA0KPiA+IG9ubHkgaW4gQURNQSBtb2RlLCBpdCB3aWxsIGNob3NlIHRvIHVz
ZSBBQ01EMjMgaWYgdGhlIGhvc3Qgc3VwcG9ydC4NCj4gPiBCdXQgYWNjb3JkaW5nIHRvIGRlYnVn
LCBhbmQgY29uZmlybSB3aXRoIElDLCB0aGUNCj4gPiBpbXg2cXBkbC9pbXg2c3gvaW14NnNsL2lt
eDdkIGRvIG5vdCBzdXBwb3J0IHRoZSBBQ01EMjMgZmVhdHVyZQ0KPiA+IGNvbXBsZXRlbHkuIFRo
ZXNlIFNvQ3Mgb25seSB1c2UgdGhlIDE2IGJpdCBibG9jayBjb3VudCBvZiB0aGUgcmVnaXN0ZXIN
Cj4gPiAweDQgKEJMT0NLX0FUVCkgYXMgdGhlIENNRDIzJ3MgYXJndW1lbnQgaW4gQUNNRDIzIG1v
ZGUsIHdoaWNoIG1lYW5zDQo+IGl0DQo+ID4gd2lsbCBpZ25vcmUgdGhlIHVwcGVyIDE2IGJpdCBv
ZiB0aGUgQ01EMjMncyBhcmd1bWVudC4gVGhpcyB3aWxsIGJsb2NrDQo+ID4gdGhlIHJlbGlhYmxl
IHdyaXRlIG9wZXJhdGlvbiBpbiBSUE1CLCBiZWNhdXNlIFJQTUIgcmVsaWFibGUgd3JpdGUgbmVl
ZA0KPiA+IHRvIHNldCB0aGUgYml0MzEgb2YgdGhlIENNRDIzJ3MgYXJndW1lbnQuIFRoaXMgaXMg
dGhlIGhhcmR3YXJlDQo+ID4gbGltaXRhdGlvbi4gRHVlIHRvIGlteDZzbCB1c2UgU0RNQSwgc28g
Zm9yIGlteDZxcGRsL2lteDZzeC9pbXg3ZCwgaXQNCj4gPiBuZWVkIHRvIGJyb2tlIHRoZSBBQ01E
MjMgZm9yIGVNTUMsIFNEIGNhcmQgZG8gbm90IGhhcyB0aGlzIGxpbWl0YXRpb24sDQo+IGJlY2F1
c2UgU0QgY2FyZCBkbyBub3Qgc3VwcG9ydCByZWxpYWJsZSB3cml0ZS4NCj4gPg0KPiA+IEZvciBp
bXg2dWwvaW14NnVsbC9pbXg2c2xsL2lteDd1bHAvaW14OCwgaXQgc3VwcG9ydCB0aGUgQUNNRDIz
DQo+ID4gY29tcGxldGVseSwgaXQgY2hhbmdlIHRvIHVzZSB0aGUgMHgwIHJlZ2lzdGVyIChEU19B
RERSKSB0byBwdXQgdGhlIENNRDIzJ3MNCj4gYXJndW1lbnQgaW4gQURNQSBtb2RlLg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBoYW5kbGUgJ2ZzbCxhdXRvLWNtZDIzLWJyb2tlbicgZnJvbSBkZXZpY2V0
cmVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwg
MyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleCA4MGExNDhmODAwOWUuLjgz
YjQxNTZiMmNmNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+
IEBAIC0xMzc0LDYgKzEzNzQsOSBAQCBzZGhjaV9lc2RoY19pbXhfcHJvYmVfZHQoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiAgCWlmIChvZl9maW5kX3Byb3BlcnR5KG5wLCAi
bm8tMS04LXYiLCBOVUxMKSkNCj4gPiAgCQlob3N0LT5xdWlya3MyIHw9IFNESENJX1FVSVJLMl9O
T18xXzhfVjsNCj4gPg0KPiA+ICsJaWYgKG9mX2ZpbmRfcHJvcGVydHkobnAsICJmc2wsYXV0by1j
bWQyMy1icm9rZW4iLCBOVUxMKSkNCj4gPiArCQlob3N0LT5xdWlya3MyIHw9IFNESENJX1FVSVJL
Ml9BQ01EMjNfQlJPS0VOOw0KPiANCj4gSSBndWVzcyBpdCBjb3VsZCBiZSAic2RoY2ksYXV0by1j
bWQyMy1icm9rZW4iIGFuZCB5b3UgY291bGQgcHV0IGl0IGluDQo+IHNkaGNpX2dldF9wcm9wZXJ0
eSgpIGFuZCB1c2UgdGhhdC4NCj4gDQoNCk9rYXksIHdpbGwgZG8gdGhhdCBpbiBuZXh0IHZlcnNp
b24gcGF0Y2guDQoNCj4gPiArDQo+ID4gIAlpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJm
c2wsZGVsYXktbGluZSIsICZib2FyZGRhdGEtPmRlbGF5X2xpbmUpKQ0KPiA+ICAJCWJvYXJkZGF0
YS0+ZGVsYXlfbGluZSA9IDA7DQo+ID4NCj4gPg0KDQo=
