Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A520210A91B
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 04:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0DeZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 22:34:25 -0500
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:21831
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbfK0DeZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 22:34:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCOA5+6jrsqsVhKS1l/uiMZ0eRuw2nmyeebHFYK73heXHDmfdC0WZl32hhrS+pNeSwJbFXuWSPBQzRKCMrcuuXdAEw6mfB9bKuCyZfJo3YimYlDrCh3z4Fj0MeJL5lJvIjx7snOtnbltd48h4zPfyi8lB31bM2OwimvNtVCnq0H5qz9qXKYbwFMGcjtnZntNvLJCpGe0hTAmrZA4E4u22gBt/c5R4th5cu20TGvAH/e/4A2T0iZUl2GX17T/WXhksQGVJQC0fog0xKTz64fnGbw1OMmg+NHXPe7knmNTv+ymuFtTIcGrATtUhGxQO5g1x0oRuac3hW3YhRaVXpgeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK/8SOb8pYWddTbug/5tc6w+K0vAAXNh7ahhVZKiCrs=;
 b=Dc1aO8Dzv2ih8p5gLGpvYiSBuJVcSRwCCDGzBgRN3RJF41CH1DESISP4IdfE9ua87qG26MUA9PKIxKDsJ4NTcEzMy17rAltKc2opLHQdRlZclEe9vd+NVK4y2rGjg4Z1+85X+vOMzwdgi8je8sorru6HDaYu/6rssTF3RfsVJMf7lp4A5PAQpRFSi2wi6Irl57QAxj4IeYp7r73U43mG3spvfEJhRoUwxWpP0K4kpIPsWqrMyKfZwXqHkvpGjqwlSrSGNd0Kl1SK727RK5bMT/XOLwWKVvxUDD9Oqq3fIPovCPICbxdq18ByjbX9H4iSbxVVvrsZKONlBpopBJUfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK/8SOb8pYWddTbug/5tc6w+K0vAAXNh7ahhVZKiCrs=;
 b=s3i6x52ZWhVlVnJQxUtl2iSzGsTMkkcqY5cSDZlJYcw5hOcmmCogOpysloNuUBcdtGrj+HMIM0LA/jxez7JI8SAPe3atEjlyVWfLBu4pZhEONO7LZp6OmFsgv1ID7WmpxGREWjHTIlfGreMvpso8kJfj7JqIw4Twuu6kwpttayA=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6880.eurprd04.prod.outlook.com (52.133.244.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 03:33:41 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 03:33:41 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 02/14] mmc: sdhci: clear DMA_SEL before sending tuning
 command for Standard tuning
Thread-Topic: [PATCH 02/14] mmc: sdhci: clear DMA_SEL before sending tuning
 command for Standard tuning
Thread-Index: AQHVm6VDfO4nxXCd8ESl3h3o+2qsn6edajOAgAEEjfA=
Date:   Wed, 27 Nov 2019 03:33:41 +0000
Message-ID: <VI1PR04MB504017A4108A3C994B29C43390440@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
 <1573816075-26390-2-git-send-email-haibo.chen@nxp.com>
 <4cc20a77-24c9-1425-3059-32839113b62a@intel.com>
In-Reply-To: <4cc20a77-24c9-1425-3059-32839113b62a@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5da2b3b-904a-41ea-682f-08d772ea9946
x-ms-traffictypediagnostic: VI1PR04MB6880:|VI1PR04MB6880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB688095A8C668DBDF4A98B7A290440@VI1PR04MB6880.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(13464003)(189003)(199004)(478600001)(66066001)(102836004)(8936002)(99286004)(66556008)(76116006)(66946007)(7696005)(76176011)(66476007)(71200400001)(229853002)(2501003)(6506007)(5660300002)(71190400001)(6116002)(3846002)(53546011)(256004)(14444005)(11346002)(52536014)(446003)(81156014)(8676002)(186003)(9686003)(81166006)(14454004)(33656002)(64756008)(305945005)(54906003)(110136005)(55016002)(74316002)(2906002)(7736002)(86362001)(6246003)(66446008)(25786009)(4326008)(6436002)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6880;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrJUf2Uw5m+WgMNdhc0zOLRtCzs1FsPY/TXv2fzI5FOLa7DsbVga0abh/5aqtXgkmYqBN31IgE5sC3d5B1ZwGWnG9A8wU3ywN7Z3Vw//+XgrONiXYYpv5SKnYBjDzzvdP2zGWtRRUft1wvwnuPt/ud3rf5VURK5E+2TFP6wJvEZt1herARxddg6hUbIzPEAY8V6Nd9NV0HXPGnMST3yfvMts6Hb1qfogyMO0xIJZadl+5nnhTOHVW67RYSJTdKV2iozKH1BtyzlxD1NXRMK5g7pInX8n2hOZdzdsR9fB+iITPDc2LuLnBpDNqhK2Y3xP6fUMVlzSB/bTUZGTzqwvoCjtQpT7xRC89Nh2YGru+AE3mWwNw88g49JoOYQfuseetC1BZ2500GSZmy3fzCflD2G7iXqAISTxXLV1e7v1A3sbEqGK3F1IwJ1GYAc0t7Rw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5da2b3b-904a-41ea-682f-08d772ea9946
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 03:33:41.4483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wms9X8PaPAfQr8NoLM+iVKzc/8Ye/tDPcoAbo05jluHp2Qj11G0jftyAcuManDbUfmd9GFh36/dkBquNpPWmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6880
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiAyMDE55bm0MTHmnIgyNuaXpSAxOTo1OA0K
PiBUbzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZw0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMi8xNF0gbW1jOiBzZGhjaTog
Y2xlYXIgRE1BX1NFTCBiZWZvcmUgc2VuZGluZyB0dW5pbmcNCj4gY29tbWFuZCBmb3IgU3RhbmRh
cmQgdHVuaW5nDQo+IA0KPiBPbiAxNS8xMS8xOSAxOjA3IFBNLCBoYWliby5jaGVuQG54cC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+
ID4gQ3VycmVudGx5LCB3aGVuIHVzZSBzdGFuZGFyZCB0dW5pbmcsIGRyaXZlciBkZWZhdWx0IGRp
c2FibGUgRE1BIGp1c3QNCj4gPiBiZWZvcmUgc2VuZCB0dW5pbmcgY29tbWFuZC4gQnV0IG9uIGku
TVg4IHVzZGhjLCB0aGlzIGlzIG5vdCBlbm91Z2guDQo+ID4gTmVlZCBhbHNvIGNsZWFyIERNQV9T
RUwuIElmIG5vdCwgb25jZSB0aGUgRE1BX1NFTCBzZWxlY3QgQU1EQTIgYmVmb3JlLA0KPiA+IGV2
ZW4gZG1hIGFscmVhZHkgZGlzYWJsZWQsIHdoZW4gc2VuZCB0dW5pbmcgY29tbWFuZCwgdXNkaGMg
d2lsbCBzdGlsbA0KPiA+IHByZWZldGNoIHRoZSBBRE1BIHNjcmlwdCBmcm9tIHdyb25nIERNQSBh
ZGRyZXNzLCB0aGVuIHdlIHdpbGwgc2VlDQo+ID4gSU9NTVUgcmVwb3J0IHNvbWUgZXJyb3Igd2hp
Y2ggc2hvdyBsYWNrIG9mIFRMQiBtYXBwaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLmMgfCAxMiArKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgaW5kZXgNCj4gPiA2OGRiODZjMWI0YzkuLjE0
MzZjYzljNWY4MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4g
PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMNCj4gPiBAQCAtMjM2MSw2ICsyMzYxLDcg
QEAgdm9pZCBzZGhjaV9zZW5kX3R1bmluZyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwNCj4gdTMy
IG9wY29kZSkNCj4gPiAgCXN0cnVjdCBtbWNfcmVxdWVzdCBtcnEgPSB7fTsNCj4gPiAgCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQo+ID4gIAl1MzIgYiA9IGhvc3QtPnNkbWFfYm91bmRhcnk7DQo+ID4g
Kwl1OCBjdHJsOw0KPiA+DQo+ID4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmaG9zdC0+bG9jaywgZmxh
Z3MpOw0KPiA+DQo+ID4gQEAgLTIzODgsNiArMjM4OSwxNyBAQCB2b2lkIHNkaGNpX3NlbmRfdHVu
aW5nKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1MzIgb3Bjb2RlKQ0KPiA+ICAJICovDQo+
ID4gIAlzZGhjaV93cml0ZXcoaG9zdCwgU0RIQ0lfVFJOU19SRUFELCBTREhDSV9UUkFOU0ZFUl9N
T0RFKTsNCj4gPg0KPiA+ICsNCj4gPiArCS8qIERNQSBhbHJlYWR5IGRpc2FibGVkLCBzbyBjbGVh
ciB0aGUgRE1BIFNlbGVjdCBoZXJlLg0KPiA+ICsJICogT3RoZXJ3aXNlLCBpZiB1c2UgQURNQTIs
IGV2ZW4gZGlzYWJsZSBETUEsIHNvbWUNCj4gPiArCSAqIGNvbnRyb2xsZXJzIGxpa2UgaS5NWCB1
c2RoYyB3aWxsIHN0aWxsIHByZWZldGNoIHRoZQ0KPiA+ICsJICogQURNQSBzY3JpcHQgd2hlbiBz
ZW5kIHR1bmluZyBjb21tYW5kLCB3aGljaCB3aWxsIGNhdXNlDQo+ID4gKwkgKiBJT01NVSByZXBv
cnQgbGFjayBvZiBUTEIgbWFwcGluZyBlcnJvcg0KPiA+ICsJICovDQo+ID4gKwljdHJsID0gc2Ro
Y2lfcmVhZGIoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MKTsNCj4gPiArCWN0cmwgJj0gflNESENJ
X0NUUkxfRE1BX01BU0s7DQo+IA0KPiBWYWx1ZSB6ZXJvIGlzIFNETUEsIHNvIHRoaXMgZG9lcyBu
b3QgbG9vayBsaWtlIGEgZ2VuZXJpYyBzZGhjaSBjaGFuZ2UuICBXaGF0DQo+IGFib3V0IGRvaW5n
IGl0IGluIHNkaGNpLWVzZGhjLWlteC5jIGJlZm9yZSBleGVjdXRpbmcgdHVuaW5nPw0KPiANCk9r
YXksIHRoZSB2YWx1ZSB6ZXJvIGZvciBpLm14IHVzZGhjIG1lYW5zICJObyBETUEgb3IgU2ltcGxl
IERNQSBpcyBzZWxlY3RlZCIsIGEgbGl0dGxlIGJpdCBkaWZmZXJlbnQgd2l0aCBnZW5lcmljIHNk
aGNpIGRlZmluaXRpb24uDQpJIHdpbGwgYWRkIHRoaXMgY2hhbmdlIGluIHNkaGNpLWVzZGhjLWlt
eC5jIGluIFYyIHBhdGNoLiANClRoYW5rcyENCg0KSGFpYm8gQ2hlbg0KDQoNCj4gPiArCXNkaGNp
X3dyaXRlYihob3N0LCBjdHJsLCBTREhDSV9IT1NUX0NPTlRST0wpOw0KPiA+ICsNCj4gPiAgCXNk
aGNpX3NlbmRfY29tbWFuZChob3N0LCAmY21kKTsNCj4gPg0KPiA+ICAJaG9zdC0+Y21kID0gTlVM
TDsNCj4gPg0KDQo=
