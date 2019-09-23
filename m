Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6261FBACC3
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 04:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392182AbfIWCvV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Sep 2019 22:51:21 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:17892
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392157AbfIWCvV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Sep 2019 22:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in7WPRXpoubTI+EJKdnYznEv27tPW/lJyzUC5txs8uSiXP5T1c0tDM8fTdnlsxf065eDOVrNVhkm8EIu23nXe2m3B3Tee4zq0QKfXIxaxF1TqTPNrZziDSRj3hc1hXiiOh5ZewiWx8TslcCildxxLl0lJfNjF1HmoDCwRqUqD7hxWDWlswnSxYs1XXeAbzGvF0pQjtw9nkJqEHygpeo1ZLsfv0n/yuBmHaFJF7n9u434j3TD5Ia7+rbE6fIcygw01pWmBvMHL+n4HKBk99y+rUcOfa3oMEW5mtCFTJC9en4j+41e1+3+FrHq8d59KxX7r1MZ7YUqr9PiiyIMC9cFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SpQaAfRPj84vBFNVgoUXKokNABAySHyAovDKGMClJ8=;
 b=kbGVV+pYnkXwgFl0nQ/6uuTWp8q0gNWkrIlX9TX/RYnyTnPwUsGbewPTg2FhVdhOKfwKrdPn/s8z32zVuIBHf8Ron3lw8FcmefBzz6SvGs+01l5y63cOo3UqOMca+6S4Kaxey1rXfUnXWCcZBATU6xItXKmT+5RxMTh5HxzoZGDO0TMHsmWiNI9+goprmoijX4wWxK3lesZcNhVlJ5Dn++/sAQzp4SCDTNuGMKg2BE0mbYrsTtEWJqTZFVVqMA5bwVx53A+R8rNjG9IlOQR3k7JEVsLUg9L6DeoMJMARU2vNOLOysPkQf+42y4JDPiWKCZnub07KpHGlOGt7iIm73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SpQaAfRPj84vBFNVgoUXKokNABAySHyAovDKGMClJ8=;
 b=hfPMA58gkEMN/+H1aqvdSpO8kgAZ9/V537GQqkAOo5flhehB0c3qNDx8UetfgnmuOMlP0YeGhbjhWM4ICDaesc/pb8H6bZXoS0wU/r3G6garkxeJZgLS3t+SOJ9ZHMxyOwPHLr50qNUecJX11I/puMvIdFQ5Q+uy9PMI//AXh3M=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2414.eurprd04.prod.outlook.com (10.169.133.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 02:51:15 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::40fb:b35c:722a:101f%10]) with mapi id 15.20.2284.023; Mon, 23 Sep
 2019 02:51:15 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Index: AQHVcTBOpWluYDvmwES2/jOGUAGSvac4kCfg
Date:   Mon, 23 Sep 2019 02:51:15 +0000
Message-ID: <VI1PR0401MB223771C40FEC48E770088CBDF8850@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e55bf3a-30fc-4281-0a88-08d73fd0e6e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0401MB2414;
x-ms-traffictypediagnostic: VI1PR0401MB2414:|VI1PR0401MB2414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2414A523AA5DEA820CDDF906F8850@VI1PR0401MB2414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(13464003)(199004)(5660300002)(66476007)(110136005)(8676002)(52536014)(86362001)(76176011)(486006)(66446008)(4326008)(26005)(8936002)(3846002)(81156014)(102836004)(6436002)(99286004)(55016002)(256004)(6246003)(14454004)(6636002)(229853002)(25786009)(2906002)(186003)(33656002)(53546011)(54906003)(6116002)(81166006)(14444005)(66066001)(71200400001)(305945005)(71190400001)(6506007)(316002)(7736002)(476003)(11346002)(7696005)(76116006)(66946007)(66556008)(64756008)(74316002)(9686003)(478600001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2414;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dbStZhx57dLZlIZXGzn95HGrOJF7CQT31xyx5iIBlLgh1bF0QrNosV5WXEIFkpxpmGci2+BDFwm8b8E8RuT6u5miwlx3SPU3e24nJ0QLFzMm25mymeWgK06tY4lAlH0AVjbu5cfNCi/9CzzOL19Ov2lFeb1OVD7FsjeH0CHpvMtLT9jKqyArl0s4OnCkWKjk3RPUQGUI/qmWgv4WtkzFsNBoTDUqAoOA4EMnV089I7vbY6lWtRZdbqk7Ff9ObhebWeeF4ewK13wPemgZMbsJqHEi59VYqfk7a95ELI72L9lf8gfS5ew3Rbb3BPPLVVG0ydaS+ajSuDIrcfX2lrXNAgk1UdaO0O3StrDThIiPQMWIh68GS/DmFy8t3ywbrhxyySbeYqGcCNydNFKsUj+0JQx/P/Uj1iNFM3dK99jq1oQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e55bf3a-30fc-4281-0a88-08d73fd0e6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 02:51:15.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdIfB0+XO5+nl80DxU698nudRX7GU2rJXeZHLYXO43PvR3L7WyOd4p6fCVePrRtGTSjd8i1y0QNKtHdOhrqY4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2414
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNz
ZWxsIEtpbmcgPHJta0Bhcm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcN
Cj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMTkgNjoyNyBQTQ0KPiBUbzogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IGRhbm4gZnJhemllcg0KPiA8ZGFubi5mcmF6
aWVyQGNhbm9uaWNhbC5jb20+OyBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT47IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNvbT47IFkuYi4gTHUgPHlhbmdiby5s
dUBueHAuY29tPjsgQ2hyaXN0b3BoDQo+IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBBZHJp
YW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IFVsZiBIYW5zc29uDQo+IDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0ggMi8zXSBtbWM6IHNkaGNpLW9mLWVzZGhjOiBzZXQgRE1BIHNub29waW5nIGJhc2Vk
IG9uIERNQQ0KPiBjb2hlcmVuY2UNCj4gDQo+IFdlIG11c3Qgbm90IHVuY29uZGl0aW9uYWxseSBz
ZXQgdGhlIERNQSBzbm9vcCBiaXQ7IGlmIHRoZSBETUEgQVBJIGlzDQo+IGFzc3VtaW5nIHRoYXQg
dGhlIGRldmljZSBpcyBub3QgRE1BIGNvaGVyZW50LCBhbmQgdGhlIGRldmljZSBzbm9vcHMgdGhl
IENQVQ0KPiBjYWNoZXMsIHRoZSBkZXZpY2UgY2FuIHNlZSBzdGFsZSBjYWNoZSBsaW5lcyBicm91
Z2h0IGluIGJ5IHNwZWN1bGF0aXZlIHByZWZldGNoLg0KPiANCj4gVGhpcyBsZWFkcyB0byB0aGUg
ZGV2aWNlIHNlZWluZyBzdGFsZSBkYXRhLCBwb3RlbnRpYWxseSByZXN1bHRpbmcgaW4gY29ycnVw
dGVkDQo+IGRhdGEgdHJhbnNmZXJzLiAgQ29tbW9ubHksIHRoaXMgcmVzdWx0cyBpbiBhIGRlc2Ny
aXB0b3IgZmV0Y2ggZXJyb3Igc3VjaCBhczoNCj4gDQo+IG1tYzA6IEFETUEgZXJyb3INCj4gbW1j
MDogc2RoY2k6ID09PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQo+
IG1tYzA6IHNkaGNpOiBTeXMgYWRkcjogIDB4MDAwMDAwMDAgfCBWZXJzaW9uOiAgMHgwMDAwMjIw
Mg0KPiBtbWMwOiBzZGhjaTogQmxrIHNpemU6ICAweDAwMDAwMDA4IHwgQmxrIGNudDogIDB4MDAw
MDAwMDENCj4gbW1jMDogc2RoY2k6IEFyZ3VtZW50OiAgMHgwMDAwMDAwMCB8IFRybiBtb2RlOiAw
eDAwMDAwMDEzDQo+IG1tYzA6IHNkaGNpOiBQcmVzZW50OiAgIDB4MDFmNTAwMDggfCBIb3N0IGN0
bDogMHgwMDAwMDAzOA0KPiBtbWMwOiBzZGhjaTogUG93ZXI6ICAgICAweDAwMDAwMDAzIHwgQmxr
IGdhcDogIDB4MDAwMDAwMDANCj4gbW1jMDogc2RoY2k6IFdha2UtdXA6ICAgMHgwMDAwMDAwMCB8
IENsb2NrOiAgICAweDAwMDA0MGQ4DQo+IG1tYzA6IHNkaGNpOiBUaW1lb3V0OiAgIDB4MDAwMDAw
MDMgfCBJbnQgc3RhdDogMHgwMDAwMDAwMQ0KPiBtbWMwOiBzZGhjaTogSW50IGVuYWI6ICAweDAz
N2YxMDhmIHwgU2lnIGVuYWI6IDB4MDM3ZjEwOGINCj4gbW1jMDogc2RoY2k6IEFDbWQgc3RhdDog
MHgwMDAwMDAwMCB8IFNsb3QgaW50OiAweDAwMDAyMjAyDQo+IG1tYzA6IHNkaGNpOiBDYXBzOiAg
ICAgIDB4MzVmYTAwMDAgfCBDYXBzXzE6ICAgMHgwMDAwYWYwMA0KPiBtbWMwOiBzZGhjaTogQ21k
OiAgICAgICAweDAwMDAzMzNhIHwgTWF4IGN1cnI6IDB4MDAwMDAwMDANCj4gbW1jMDogc2RoY2k6
IFJlc3BbMF06ICAgMHgwMDAwMDkyMCB8IFJlc3BbMV06ICAweDAwMWQ4YTMzDQo+IG1tYzA6IHNk
aGNpOiBSZXNwWzJdOiAgIDB4MzI1YjU5MDAgfCBSZXNwWzNdOiAgMHgzZjQwMGUwMA0KPiBtbWMw
OiBzZGhjaTogSG9zdCBjdGwyOiAweDAwMDAwMDAwDQo+IG1tYzA6IHNkaGNpOiBBRE1BIEVycjog
IDB4MDAwMDAwMDkgfCBBRE1BIFB0cjogMHgwMDAwMDAyMzZkNDM4MjBjDQo+IG1tYzA6IHNkaGNp
OiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBtbWMwOiBl
cnJvciAtNSB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQNCj4gDQo+IGJ1dCBjYW4gbGVhZCB0
byBvdGhlciBlcnJvcnMsIGFuZCBwb3RlbnRpYWxseSBkaXJlY3QgdGhlIFNESENJIGNvbnRyb2xs
ZXIgdG8NCj4gcmVhZC93cml0ZSBkYXRhIHRvIG90aGVyIG1lbW9yeSBsb2NhdGlvbnMgKGUuZy4g
aWYgYSB2YWxpZCBkZXNjcmlwdG9yIGlzIHZpc2libGUNCj4gdG8gdGhlIGRldmljZSBpbiBhIHN0
YWxlIGNhY2hlIGxpbmUuKQ0KPiANCj4gRml4IHRoaXMgYnkgZW5zdXJpbmcgdGhhdCB0aGUgRE1B
IHNub29wIGJpdCBjb3JyZXNwb25kcyB3aXRoIHRoZSBiZWhhdmlvdXIgb2YNCj4gdGhlIERNQSBB
UEkuICBTaW5jZSB0aGUgZHJpdmVyIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRzIERULCB1c2UNCj4g
b2ZfZG1hX2lzX2NvaGVyZW50KCkuICBOb3RlIHRoYXQgZGV2aWNlX2dldF9kbWFfYXR0cigpIGNh
biBub3QgYmUgdXNlZCBhcw0KPiB0aGF0IHJpc2tzIHJlLWludHJvZHVjaW5nIHRoaXMgYnVnIGlm
L3doZW4gdGhlIGRyaXZlciBpcyBjb252ZXJ0ZWQgdG8gQUNQSS4NCg0KW1kuYi4gTHVdIE1heSBJ
IGhhdmUgeW91ciBzdWdnZXN0aW9uIGhvdyB0byBjaGVjayB0aGlzIGNvbmRpdGlvbiB3aXRoIEFD
UEk/DQpBbHRob3VnaCB3ZSBkaWRu4oCZdCBzdXBwb3J0IEFQQ0kgb24gdXBzdHJlYW0gZm9yIHRo
aXMgZHJpdmVyIG5vdywgYXMgSSBrbm93IHdlIGhhZCBhbHJlYWR5IGhhZCBBQ1BJIHVzZWQgaW50
ZXJuYWxseSBhbmQgd291bGQgYmUgdXBzdHJlYW1lZC4NClRoYW5rcy4NCg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gLS0t
DQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMgfCA3ICsrKysrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gaW5kZXggNGRkNDNiMWFkZjJjLi43NGRlNWU4YzQ1
YzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYw0KPiAr
KysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gQEAgLTQ5NSw3ICs0OTUs
MTIgQEAgc3RhdGljIGludCBlc2RoY19vZl9lbmFibGVfZG1hKHN0cnVjdCBzZGhjaV9ob3N0DQo+
ICpob3N0KQ0KPiAgCQlkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1BX0JJVF9NQVNL
KDQwKSk7DQo+IA0KPiAgCXZhbHVlID0gc2RoY2lfcmVhZGwoaG9zdCwgRVNESENfRE1BX1NZU0NU
TCk7DQo+IC0JdmFsdWUgfD0gRVNESENfRE1BX1NOT09QOw0KPiArDQo+ICsJaWYgKG9mX2RtYV9p
c19jb2hlcmVudChkZXYtPm9mX25vZGUpKQ0KPiArCQl2YWx1ZSB8PSBFU0RIQ19ETUFfU05PT1A7
DQo+ICsJZWxzZQ0KPiArCQl2YWx1ZSAmPSB+RVNESENfRE1BX1NOT09QOw0KPiArDQo+ICAJc2Ro
Y2lfd3JpdGVsKGhvc3QsIHZhbHVlLCBFU0RIQ19ETUFfU1lTQ1RMKTsNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gLS0NCj4gMi43LjQNCg0K
