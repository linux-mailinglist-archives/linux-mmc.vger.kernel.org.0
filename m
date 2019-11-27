Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0D10ABAA
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0IZb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Nov 2019 03:25:31 -0500
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:12683
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfK0IZa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Nov 2019 03:25:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYM4MvwSyu6lgN6ZjAc+B9jHvQKlFPrqifYXaXig80iLZEeUemCKnDgORSGqtCtF5+x3I8D3C1l6GRbr1FDsjG1OqtSxjwVzlNGeJ8b/UAfvZ3UNqcYcv3Meqa5yLUoSNP/NfFEwIRUIEkKQeKXKxyWFTli4XBMsNTAXJ/5Za7tbO4H5QOtZAaxxfV1Suh+JBzIjcnn4tf9JOkf4Ugnuo6FmqK59Z/4NXuTIaU6Pm9kQVxpc1Pq9bL7uQFj9mW1eVgQ7TeHHrFADBMCou9rU8qbWAXWPIPN5Ofjv0bM3aKuf12rWL9gpUVR74VvhLbef+rqGBrIsS+aFpPDk6t65sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzhDoalB627JQOHkCuHktKc5BUaU4cyCYLCeySF20hI=;
 b=Vaxma37nUqpobPOVB8d5Irvv1frrMp18b6QMF36dc7GKOKfgViDhi6BXtB24r0lJw90wfJHhZ8h4x2RGrGsaV/6RzekYeWZJ3dM1iiOT69T5/cgLutJLQo2dF9VeoGea3IkcSE1pbdYlTEwg/Xx84l+3YSdA4y43TvXHP8y5gyhZdiBap/2mttfgSvFjJC1FC5QhY4QwzrqdFkYzn2AWeyTtUZLjuIwI8C9UdKUOzZXP4fXzr36Yia3Ge2o+2670ghHUeDFpzSREWcL6Xf/hXnBmyHSy3+aYK6R/iSR3wvjetUZ30h5sg9nsAD/ZP0GCn45TNam/pVVzf4SrXQcOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzhDoalB627JQOHkCuHktKc5BUaU4cyCYLCeySF20hI=;
 b=DPQw2TllKq4lMnRejf1eJQEH4Q+h4mC9kqXlnAIr1ykwqhc1pp6m3smsWaQ+YLQtvXEF2q/6aI82PoL1omLsfLdueEIKGiLhpQb6hcusxO7XLkgL3gRNnjUkSYMy2oVYDoDWOakI4Vn7UAOMPPk35otNZrF1tq3kB1QgZzSZ6/s=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB4112.eurprd04.prod.outlook.com (52.133.14.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 08:25:26 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 08:25:26 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 03/14] mmc: sdhci: correct the DMA setting for IOMMU
Thread-Topic: [PATCH 03/14] mmc: sdhci: correct the DMA setting for IOMMU
Thread-Index: AQHVm6VF8J7uBkRSrEe9uz/a0rpHgKedZriAgAFYSdA=
Date:   Wed, 27 Nov 2019 08:25:26 +0000
Message-ID: <VI1PR04MB5040E0936672CBAA882A8AF390440@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
 <1573816075-26390-3-git-send-email-haibo.chen@nxp.com>
 <620dc251-4411-1306-c9db-267a96a091d2@intel.com>
In-Reply-To: <620dc251-4411-1306-c9db-267a96a091d2@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc8ea75a-a16f-45b8-ec19-08d773135b4a
x-ms-traffictypediagnostic: VI1PR04MB4112:|VI1PR04MB4112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4112A90091B68BF46325DF2890440@VI1PR04MB4112.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(13464003)(81166006)(229853002)(9686003)(316002)(102836004)(6246003)(26005)(53546011)(6506007)(7696005)(55016002)(86362001)(54906003)(33656002)(2501003)(76176011)(6116002)(3846002)(99286004)(110136005)(6436002)(14454004)(66066001)(2906002)(25786009)(14444005)(186003)(4326008)(256004)(71200400001)(71190400001)(446003)(11346002)(478600001)(52536014)(76116006)(66946007)(66476007)(66556008)(64756008)(8936002)(305945005)(81156014)(8676002)(74316002)(66446008)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4112;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/xNi7DuwnDx0UiJ4hdPcOw8M6LVlOo1LjA9nMy5UFkaFNX7d8OwGEQIAANbU4KL6zGAp4Hf8nKTyyq1ZD4D1hMRPYNhzxZHX0VQ9ZTbNWEx4H5wnaFW4xBEKAgRgC9CUGZcXskFo43hNa72c2CFPmbrDpiMo17HNNDwPj2xEYAPtvS3xEwlntC+NMXtbC5rYAmh7ENeMkSd9i0MMmdSYDG7Z4VbiXEHqlpGoA8h4y1jeJurUUrDEMO3r8mi3qL584CGvlw4CNDrwdYzgUYuzjS3Dw/WsTeEAtOXoubI5+J23R/ZiuvfYN/G8zBmSKxLrSvFE9G6YfTOAcW+FVOmdvTx+QteG0jmsVzkL5kA4vnN0xtOVIah84zselsNZzZhDQa0btNhVdPcBnLOxWw1tVOi312htArlt7P4oYa5bbN2WCzEKilqR6MGzY1RxQMR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8ea75a-a16f-45b8-ec19-08d773135b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 08:25:26.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSxqUTXxMK9UtO+9or1WdA8nEGByKQgm5K1vqcomrxHONm/BW/dWn2XTJAvDOW9SC2PrEyZf9rO6bv3mJWCokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4112
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LW1tYy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBBZHJpYW4gSHVudGVyDQo+IFNlbnQ6IDIwMTnlubQxMeaciDI25pelIDE5OjQ2DQo+
IFRvOiBCT1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnDQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzE0XSBtbWM6IHNkaGNpOiBj
b3JyZWN0IHRoZSBETUEgc2V0dGluZyBmb3IgSU9NTVUNCj4gDQo+IE9uIDE1LzExLzE5IDE6MDcg
UE0sIGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBUaGUgZGVmYXVsdCBtYXggc2VnbWVudCBzaXplIG9m
IElPTU1VIGlzIDY0S0IsIHdoaWNoIGV4Y2VlZCB0aGUgQURNQQ0KPiA+IGxpbWl0YXRpb24gaWYg
QURNQSBvbmx5IHN1cHBvcnQgbWF4IHRvIDY1NTM1LCA2NEtCIC0gMUJ5dGUuIElPTU1VIHdpbGwN
Cj4gPiBvcHRpbWl6ZSB0aGUgc2VnbWVudHMgaXQgcmVjZWl2ZWQsIG1lcmdlIHRoZSBsaXR0bGUg
c2VnbWVudCBpbnRvIG9uZQ0KPiA+IGJpZyBzZWdtZW50LiBJZiB3ZSB1c2UgdGhlIGRlZmF1bHQg
SU9NTVUgY29uZmlnLCB0aGVuIEFETUEgd2lsbCBnZXQNCj4gPiBzb21lIHNlZ21lbnRzIHdoaWNo
IGl0J3Mgc2l6ZSBpcyA2NEtCLiBUaGVuIEFETUEgZXJyb3Igd2lsbCBzaG93cyB1cC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgMTYgKysrKysrKysrKysrKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmMgaW5kZXgNCj4gPiAxNDM2Y2M5YzVmODIuLjNhODA5M2RlMjZjNyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4gPiArKysgYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLmMNCj4gPiBAQCAtMzc0Myw2ICszNzQzLDcgQEAgc3RhdGljIGlubGlu
ZSBib29sIHNkaGNpX2Nhbl82NGJpdF9kbWEoc3RydWN0DQo+ID4gc2RoY2lfaG9zdCAqaG9zdCkg
IGludCBzZGhjaV9zZXR1cF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KSAgew0KPiA+ICAJ
c3RydWN0IG1tY19ob3N0ICptbWM7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gIAl1
MzIgbWF4X2N1cnJlbnRfY2FwczsNCj4gPiAgCXVuc2lnbmVkIGludCBvY3JfYXZhaWw7DQo+ID4g
IAl1bnNpZ25lZCBpbnQgb3ZlcnJpZGVfdGltZW91dF9jbGs7DQo+ID4gQEAgLTM3NTQsNiArMzc1
NSw3IEBAIGludCBzZGhjaV9zZXR1cF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPiA+
ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gIAltbWMgPSBob3N0LT5tbWM7DQo+ID4gKwlk
ZXYgPSBtbWNfZGV2KG1tYyk7DQo+ID4NCj4gPiAgCS8qDQo+ID4gIAkgKiBJZiB0aGVyZSBhcmUg
ZXh0ZXJuYWwgcmVndWxhdG9ycywgZ2V0IHRoZW0uIE5vdGUgdGhpcyBtdXN0IGJlDQo+ID4gZG9u
ZSBAQCAtNDIyNCwxMCArNDIyNiwyMCBAQCBpbnQgc2RoY2lfc2V0dXBfaG9zdChzdHJ1Y3Qgc2Ro
Y2lfaG9zdA0KPiAqaG9zdCkNCj4gPiAgCSAqIGJlIGxhcmdlciB0aGFuIDY0IEtpQiB0aG91Z2gu
DQo+ID4gIAkgKi8NCj4gPiAgCWlmIChob3N0LT5mbGFncyAmIFNESENJX1VTRV9BRE1BKSB7DQo+
ID4gLQkJaWYgKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJLX0JST0tFTl9BRE1BX1pFUk9MRU5f
REVTQykNCj4gPiArCQlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfQlJPS0VOX0FETUFf
WkVST0xFTl9ERVNDKSB7DQo+ID4gIAkJCW1tYy0+bWF4X3NlZ19zaXplID0gNjU1MzU7DQo+ID4g
LQkJZWxzZQ0KPiA+ICsNCj4gPiArCQkJLyoNCj4gPiArCQkJICogc2VuZCB0aGUgQURNQSBsaW1p
dGF0aW9uIHRvIElPTU1VLiBJbiBkZWZhdWx0LA0KPiA+ICsJCQkgKiB0aGUgbWF4IHNlZ21lbnQg
c2l6ZSBvZiBJT01NVSBpcyA2NEtCLCB0aGlzIGV4Y2VlZA0KPiA+ICsJCQkgKiB0aGUgQURNQSBt
YXggc2VnbWVudCBsaW1pdGF0aW9uLCB3aGljaCBpcyA2NTUzNS4NCj4gPiArCQkJICovDQo+ID4g
KwkJCWRldi0+ZG1hX3Bhcm1zID0gZGV2bV9remFsbG9jKGRldiwNCj4gPiArCQkJCQlzaXplb2Yo
KmRldi0+ZG1hX3Bhcm1zKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwkJCWRtYV9zZXRfbWF4X3NlZ19z
aXplKGRldiwgU1pfNjRLIC0gMSk7DQo+IA0KPiBEb2Vzbid0IG1tY19zZXR1cF9xdWV1ZSgpIGFs
cmVhZHkgZG8gdGhpcz8NCg0KbW1jX3NldHVwX3F1ZXVlIGRvIGNhbGwgdGhlIGZ1bmN0aW9uIGRt
YV9zZXRfbWF4X3NlZ19zaXplKCksIGJ1dCBpdCBkbyBub3QgZ2l2ZSB2YWx1ZSB0byBkZXYtPmRt
YV9wYXJtcy4NClNvIGluIGRtYV9zZXRfbWF4X3NlZ19zaXplKCksIGl0IGRvIG5vdGhpbmcsIGp1
c3QgcmV0dXJuIC1FSU8uIA0KU2hvdWxkIEkgZml4IHRoaXMgaW4gbW1jX3NldHVwX3F1ZXVlKCk/
IA0KDQo3MjUgc3RhdGljIGlubGluZSBpbnQgZG1hX3NldF9tYXhfc2VnX3NpemUoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgc2l6ZSkNCjcyNiB7DQo3MjcgICAgICAgICBpZiAoZGV2
LT5kbWFfcGFybXMpIHsNCjcyOCAgICAgICAgICAgICAgICAgZGV2LT5kbWFfcGFybXMtPm1heF9z
ZWdtZW50X3NpemUgPSBzaXplOw0KNzI5ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCjczMCAg
ICAgICAgIH0NCjczMSAgICAgICAgIHJldHVybiAtRUlPOw0KNzMyIH0gDQoNCj4gDQo+ID4gKwkJ
fSBlbHNlIHsNCj4gPiAgCQkJbW1jLT5tYXhfc2VnX3NpemUgPSA2NTUzNjsNCj4gPiArCQl9DQo+
ID4gIAl9IGVsc2Ugew0KPiA+ICAJCW1tYy0+bWF4X3NlZ19zaXplID0gbW1jLT5tYXhfcmVxX3Np
emU7DQo+ID4gIAl9DQo+ID4NCg0K
