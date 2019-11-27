Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891010AE4C
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfK0K4D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Nov 2019 05:56:03 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:36359
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfK0K4D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Nov 2019 05:56:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpuleMr4uJxzOHNuai2M2+53VWxODJ7RXT1RteGRHZzQ3Dmc+fSx9epplX151D6cuduBx6vu6sIeX/khNVnY3JiVlomGNKRrt5qhd5izJ921bUJTQ32hQz3svkIwEU7tLVyQA9qne1On003v9uMiHPFaYjHl6pokAZ3txx3DA/o62Ogy5Vw0IrGKU4l54yKv6DuSB+Lb3E3hpRxBaiOH5ulCJ/750yI+s7pouBxG4ZA5egkdy8U+qNygKrGlv2pfTfD+RNRDKuck21Ae+u+bqMaqMvgL7PRKTaUbVf11NZm/AzYexwJEEa5O4RkBY4OIB+6riKk6H14x7jTYarb70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMU5oq4PRLUI0Vgdip2BBaQvy1zpc5VUG6+tzcM+BFA=;
 b=M/7DNmkdJkaNDGm46eZ5+y+6YFcm5Bzo3O2KMvouioua5dZKE8CqD2wFJoHZscF+ELBJvqq5JxFq6eQ7Me7eryZQLGDLD3owqPTD46dns2Fp91aDHRd2sOZH7e4p3bdA2jy7EIk4KtsPPK0wqegie/IdiFaCS+X6CPSFFC65l6YhDBUx5sah+6xrgYSkPpmCoB7J7l6RO8OvhYd3H+4jBiQo8v7gJS4rp/NeyVfYWF0L6Cg5A0o9hcX4+xVhyP4WtAuZ7K0y5dSfXEYF9mkUcN7+cXhuhYVnCLDA90Gj1mk4SvSH4qNr5kg65GDG6Db+IqAUpFgGQVdjIcJxzIfspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMU5oq4PRLUI0Vgdip2BBaQvy1zpc5VUG6+tzcM+BFA=;
 b=dAqvsRKb4J7KywBxUaBqjduyexGvx4rJXac2unCKFGJY77VDKMPr8Shsn4xxS1ojNf1KFsR3A+x5cu0xK00GD+Lo3o2ra/sAVYhceHIquTf38ZIcrt7e9JcJil5QD2iKTEwoRZxo0kM0HqDIkUXFxVfB/JYyYVM+xEE41/6747g=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6333.eurprd04.prod.outlook.com (20.179.27.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 10:54:12 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 10:54:12 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 14/14] mmc: cqhci: clear pending interrupt and halt
Thread-Topic: [PATCH 14/14] mmc: cqhci: clear pending interrupt and halt
Thread-Index: AQHVm6b+5QqbJBFBuUutoskuw/XOpKedfNiAgAFtW3A=
Date:   Wed, 27 Nov 2019 10:54:12 +0000
Message-ID: <VI1PR04MB5040DF8674071CB3F666E0E690440@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1573816835-26884-1-git-send-email-haibo.chen@nxp.com>
 <b7ed8bf9-305d-f106-3c28-446a0cda176d@intel.com>
In-Reply-To: <b7ed8bf9-305d-f106-3c28-446a0cda176d@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79674f93-7563-48db-77b6-08d773282385
x-ms-traffictypediagnostic: VI1PR04MB6333:|VI1PR04MB6333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB63331B109B6ECDE3EBEEC5C090440@VI1PR04MB6333.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(13464003)(8936002)(66946007)(6246003)(102836004)(66066001)(25786009)(14454004)(55016002)(498600001)(6436002)(7696005)(71200400001)(186003)(26005)(4326008)(229853002)(9686003)(76176011)(2501003)(71190400001)(6506007)(53546011)(86362001)(54906003)(305945005)(7736002)(256004)(14444005)(11346002)(446003)(2906002)(99286004)(33656002)(2201001)(6116002)(3846002)(66446008)(64756008)(66556008)(66476007)(76116006)(5660300002)(8676002)(52536014)(81166006)(110136005)(81156014)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6333;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wt8hcfWCJe1JQtrqNTfWAyYf3Rup/NEyvCSfqTwlJJ+POi+6nW2P/wyLAi7eIun9OosKoSxb7yZm1Nzr9SL2vH5MGDDND9YKogT0dA1Tzb5UNWxaqsCRT0tGUrKu1gIM2c6Es5yFRXw5bnSVARBxGM22I8lts8xtaiuLOxTtzAcFYMlAXwAe2U1Mg2qDSEVMRXHqwzEGmD73LD+6xl/huixs5V5rMfWU97Ty26+MkTVQJ7cR/1wzHLkwGv9c+5AQFUphcmIiVZPFCgqUuhfLAX/Wvtjrpx9zB61ewnFgJY2UWoIIB3YGH5D90Ke9ydzo7G0T/dAnWQJLPi/hzK4UcpkYxWTZUH6ZMYRlK2c2m+gUxMRPbY/OKniJ+E9wDO7tx93OxPwki2Dd1qK0NFIFTlD3DsOzBs4C3gfaqqrudkysA7pTcEJ9qQF6XwsoIuz2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79674f93-7563-48db-77b6-08d773282385
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 10:54:12.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlWR2BrsgZAPYfCIeoVIsP6ImilEcGAL/iraP5PYmYYgLBETGtJKGBC5FjZ5ZbNPPkKM+qhDCpOyCM7omd6xrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiAyMDE55bm0MTHmnIgyNuaXpSAyMTowNQ0K
PiBUbzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlDQo+IENjOiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMTQvMTRdIG1tYzogY3FoY2k6IGNsZWFyIHBlbmRpbmcgaW50ZXJy
dXB0IGFuZCBoYWx0DQo+IA0KPiBPbiAxNS8xMS8xOSAxOjIwIFBNLCBoYWliby5jaGVuQG54cC5j
b20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+
DQo+ID4gT24gaS5NWDhNTSwgd2UgYXJlIHJ1bm5pbmcgRHVhbCBMaW51eCBPUywgd2l0aCAxc3Qg
TGludXggdXNpbmcgU0QgQ2FyZA0KPiA+IGFzIHJvb3RmcyBzdG9yYWdlLCAybmQgTGludXggdXNp
bmcgZU1NQyBhcyByb290ZnMgc3RvcmFnZS4gV2UgbGV0IHRoZQ0KPiA+IHRoZSAxc3QgbGludXgg
Y29uZmlndXJlIHBvd2VyL2Nsb2NrIGZvciB0aGUgMm5kIExpbnV4Lg0KPiA+DQo+ID4gV2hlbiB0
aGUgMm5kIExpbnV4IGlzIGJvb3RpbmcgaW50byByb290ZnMgc3RhZ2UsIHdlIGxldCB0aGUgMXN0
IExpbnV4DQo+ID4gdG8gZGVzdHJveSB0aGUgMm5kIGxpbnV4LCB0aGVuIHJlc3RhcnQgdGhlIDFz
dCBsaW51eCwgd2UgbWV0IFNESENJDQo+ID4gZHVtcCBhcyBmb2xsb3dpbmcsIGFmdGVyIHdlIGNs
ZWFyIHRoZSBwZW5kaW5nIGludGVycnVwdCBhbmQgaGFsdA0KPiA+IENRQ1RMLCBpc3N1ZSBnb25l
Lg0KPiA+DQo+ID4gWyAxLjMzNDU5NF0gbW1jMjogR290IGNvbW1hbmQgaW50ZXJydXB0IDB4MDAw
MDAwMDEgZXZlbiB0aG91Z2ggbm8NCj4gY29tbWFuZCBvcGVyYXRpb24gd2FzIGluIHByb2dyZXNz
Lg0KPiA+IFsgMS4zMzQ1OTVdIG1tYzI6IHNkaGNpOiA9PT09PT09PT09PT0gU0RIQ0kgUkVHSVNU
RVIgRFVNUA0KPiA9PT09PT09PT09PQ0KPiA+IFsgMS4zMzQ1OTldIG1tYzI6IHNkaGNpOiBTeXMg
YWRkcjogMHhhMDVkY2MwMCB8IFZlcnNpb246IDB4MDAwMDAwMDIgWw0KPiA+IDEuMzQwODE5XSBs
aWI4MDIxMTogY29tbW9uIHJvdXRpbmVzIGZvciBJRUVFODAyLjExIGRyaXZlcnMgWyAxLjM0NTUz
OF0NCj4gPiBtbWMyOiBzZGhjaTogQmxrIHNpemU6IDB4MDAwMDAyMDAgfCBCbGsgY250OiAweDAw
MDAwMDAwIFsgMS4zNDU1NDFdDQo+ID4gbW1jMjogc2RoY2k6IEFyZ3VtZW50OiAweDAwMDE4MDAw
IHwgVHJuIG1vZGU6IDB4MDAwMDAwMzMgWyAxLjM0NTU0M10NCj4gPiBtbWMyOiBzZGhjaTogUHJl
c2VudDogMHgwMWY4ODAwOCB8IEhvc3QgY3RsOiAweDAwMDAwMDMxIFsgMS4zNDU1NDddDQo+ID4g
bW1jMjogc2RoY2k6IFBvd2VyOiAweDAwMDAwMDAyIHwgQmxrIGdhcDogMHgwMDAwMDA4MCBbIDEu
MzU3OTAzXSBtbWMyOg0KPiA+IHNkaGNpOiBXYWtlLXVwOiAweDAwMDAwMDA4IHwgQ2xvY2s6IDB4
MDAwMDAwM2YgWyAxLjM1NzkwNV0gbW1jMjoNCj4gPiBzZGhjaTogVGltZW91dDogMHgwMDAwMDA4
ZiB8IEludCBzdGF0OiAweDAwMDAwMDAwIFsgMS4zNTc5MDhdIG1tYzI6DQo+ID4gc2RoY2k6IElu
dCBlbmFiOiAweDEwN2YxMDBiIHwgU2lnIGVuYWI6IDB4MTA3ZjEwMGIgWyAxLjM1NzkxMV0gbW1j
MjoNCj4gPiBzZGhjaTogQUMxMiBlcnI6IDB4MDAwMDAwMDAgfCBTbG90IGludDogMHgwMDAwMDUw
MiBbIDEuMzcwMjY4XSBtbWMyOg0KPiA+IHNkaGNpOiBDYXBzOiAweDA3ZWIwMDAwIHwgQ2Fwc18x
OiAweDAwMDBiNDAwIFsgMS4zNzAyNzBdIG1tYzI6IHNkaGNpOg0KPiA+IENtZDogMHgwMDAwMGQx
YSB8IE1heCBjdXJyOiAweDAwZmZmZmZmIFsgMS4zNzAyNzNdIG1tYzI6IHNkaGNpOg0KPiA+IFJl
c3BbMF06IDB4MDAwMDBiMDAgfCBSZXNwWzFdOiAweGZmZmZmZmZmIFsgMS4zNzAyNzZdIG1tYzI6
IHNkaGNpOg0KPiA+IFJlc3BbMl06IDB4MzI4ZjU5MDMgfCBSZXNwWzNdOiAweDAwZDAwZjAwIFsg
MS4zODIxMzJdIG1tYzI6IHNkaGNpOg0KPiA+IEhvc3QgY3RsMjogMHgwMDAwMDAwMCBbIDEuMzgy
MTM1XSBtbWMyOiBzZGhjaTogQURNQSBFcnI6IDB4MDAwMDAwMDAgfA0KPiA+IEFETUEgUHRyOiAw
eGEyMDQwMjA4DQo+ID4NCj4gPiBbIDIuMDYwOTMyXSBtbWMyOiBVbmV4cGVjdGVkIGludGVycnVw
dCAweDAwMDA0MDAwLg0KPiA+IFsgMi4wNjU1MzhdIG1tYzI6IHNkaGNpOiA9PT09PT09PT09PT0g
U0RIQ0kgUkVHSVNURVIgRFVNUA0KPiA9PT09PT09PT09PQ0KPiA+IFsgMi4wNzE3MjBdIG1tYzI6
IHNkaGNpOiBTeXMgYWRkcjogMHgwMDAwMDAwMCB8IFZlcnNpb246IDB4MDAwMDAwMDIgWw0KPiA+
IDIuMDc3OTAyXSBtbWMyOiBzZGhjaTogQmxrIHNpemU6IDB4MDAwMDAyMDAgfCBCbGsgY250OiAw
eDAwMDAwMDAxIFsNCj4gPiAyLjA4NDA4M10gbW1jMjogc2RoY2k6IEFyZ3VtZW50OiAweDAwMDAw
MDAwIHwgVHJuIG1vZGU6IDB4MDAwMDAwMDAgWw0KPiA+IDIuMDkwMjY0XSBtbWMyOiBzZGhjaTog
UHJlc2VudDogMHgwMWY4ODAwOSB8IEhvc3QgY3RsOiAweDAwMDAwMDExIFsNCj4gPiAyLjA5NjQ0
Nl0gbW1jMjogc2RoY2k6IFBvd2VyOiAweDAwMDAwMDAyIHwgQmxrIGdhcDogMHgwMDAwMDA4MCBb
DQo+ID4gMi4xMDI2MjddIG1tYzI6IHNkaGNpOiBXYWtlLXVwOiAweDAwMDAwMDA4IHwgQ2xvY2s6
IDB4MDAwMDEwZmYgWw0KPiA+IDIuMTA4ODA5XSBtbWMyOiBzZGhjaTogVGltZW91dDogMHgwMDAw
MDA4ZiB8IEludCBzdGF0OiAweDAwMDA0MDAwIFsNCj4gPiAyLjExNDk5MF0gbW1jMjogc2RoY2k6
IEludCBlbmFiOiAweDAwN2YxMDAzIHwgU2lnIGVuYWI6IDB4MDA3ZjEwMDMgWw0KPiA+IDIuMTIx
MTcxXSBtbWMyOiBzZGhjaTogQUMxMiBlcnI6IDB4MDAwMDAwMDAgfCBTbG90IGludDogMHgwMDAw
MDUwMiBbDQo+ID4gMi4xMjczNTNdIG1tYzI6IHNkaGNpOiBDYXBzOiAweDA3ZWIwMDAwIHwgQ2Fw
c18xOiAweDAwMDBiNDAwIFsNCj4gPiAyLjEzMzUzNF0gbW1jMjogc2RoY2k6IENtZDogMHgwMDAw
MzcxYSB8IE1heCBjdXJyOiAweDAwZmZmZmZmIFsNCj4gPiAyLjEzOTcxNV0gbW1jMjogc2RoY2k6
IFJlc3BbMF06IDB4MDAwMDA5MDAgfCBSZXNwWzFdOiAweGZmZmZmZmZmIFsNCj4gPiAyLjE0NTg5
Nl0gbW1jMjogc2RoY2k6IFJlc3BbMl06IDB4MzI4ZjU5MDMgfCBSZXNwWzNdOiAweDAwZDAwZjAw
IFsNCj4gPiAyLjE1MjA3N10gbW1jMjogc2RoY2k6IEhvc3QgY3RsMjogMHgwMDAwMDAwMCBbIDIu
MTU2MzQyXSBtbWMyOiBzZGhjaToNCj4gPiBBRE1BIEVycjogMHgwMDAwMDAwMCB8IEFETUEgUHRy
OiAweDAwMDAwMDAwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMgfCA1ICsrKysrDQo+IA0KPiBTdWJqZWN0IHNob3VsZCBzdGFydCAibW1jOiBzZGhjaS1l
c2RoYy1pbXg6IiBub3QgIm1tYzogY3FoY2k6IiBiZWNhdXNlDQo+IHNkaGNpLWVzZGhjLWlteCBp
cyBiZWluZyBjaGFuZ2VkLg0KDQpZZXMsIHdpbGwgY2hhbmdlZCBpbiBuZXh0IHZlcnNpb24gcGF0
Y2guDQoNCj4gDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gaW5kZXggODNiNDE1NmIyY2Y0
Li43Y2Q1MDQ2ZjMzY2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMN
Cj4gPiBAQCAtMTQ4Myw2ICsxNDgzLDcgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXN0cnVjdCBjcWhjaV9o
b3N0ICpjcV9ob3N0Ow0KPiA+ICAJaW50IGVycjsNCj4gPiAgCXN0cnVjdCBwbHRmbV9pbXhfZGF0
YSAqaW14X2RhdGE7DQo+ID4gKwl1MzIgc3RhdHVzOw0KPiA+DQo+ID4gIAlob3N0ID0gc2RoY2lf
cGx0Zm1faW5pdChwZGV2LCAmc2RoY2lfZXNkaGNfaW14X3BkYXRhLA0KPiA+ICAJCQkJc2l6ZW9m
KCppbXhfZGF0YSkpOw0KPiA+IEBAIC0xNTkwLDYgKzE1OTEsMTAgQEAgc3RhdGljIGludCBzZGhj
aV9lc2RoY19pbXhfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
CQllcnIgPSBjcWhjaV9pbml0KGNxX2hvc3QsIGhvc3QtPm1tYywgZmFsc2UpOw0KPiA+ICAJCWlm
IChlcnIpDQo+ID4gIAkJCWdvdG8gZGlzYWJsZV9haGJfY2xrOw0KPiA+ICsNCj4gDQo+IENvdWxk
IHVzZSBhIGNvbW1lbnQgaGVyZSBleHBsYWluaW5nIHdoeSB0aGlzIGlzIG5lZWRlZC4NCg0KT2th
eSwgd2lsbCBhZGQuDQoNCj4gDQo+ID4gKwkJc3RhdHVzID0gY3FoY2lfcmVhZGwoY3FfaG9zdCwg
Q1FIQ0lfSVMpOw0KPiA+ICsJCWNxaGNpX3dyaXRlbChjcV9ob3N0LCBzdGF0dXMsIENRSENJX0lT
KTsNCj4gPiArCQljcWhjaV93cml0ZWwoY3FfaG9zdCwgQ1FIQ0lfSEFMVCwgQ1FIQ0lfQ1RMKTsN
Cj4gPiAgCX0NCj4gPg0KPiA+ICAJaWYgKG9mX2lkKQ0KPiA+DQoNCg==
