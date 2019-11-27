Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE210AE34
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfK0Ku2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Nov 2019 05:50:28 -0500
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:60163
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbfK0Ku2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Nov 2019 05:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxY2OfCubUHcaFXz3tAPSJH1f4aX+g+nHtiM5zz5qas01XkR8rZZGa42d2qwesMemJ/4tG/SyYOKZne7vKSZsrCR+ui9T2l8MI/IYxP83dWUqEUT/JgoywsxDByTaQgcI8L+f5tplpKLNdfZu0swfhqPR8cQh3L2ffrbCGQ3a1eVwSVXMVFmkxee0QhIjRmJTO0gKpzfGYMy6ahcj0klii/BXrbY7jIXbKD5rRgj0/L9LQJVovC+BiK9u0/10zzXBRZBhoVYt+NpA0/DkARQhplcGKqzNhEACtNui6J5737pShGb0OrYEBwgUdc8sU7VUlTEjZ8OCP+k5DCVTd7vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9NHtM85DyLljRb+x/NOrWgDg8DWsNOCCdLVOyxa+d8=;
 b=OPJuQKBrLGWvslVzGH6jvksu5uRaS3zNBuaMlqaBPgpQ20z8kwKth90GA7FOkY9CzgtTFK063wnzDrrlNjOAqt3BAunM2Iq8fvPeRuXAI+CfLv2m8jXGo/o9tSXYm2Hic6eSU+kAFnNzHaaHC5FVV1h4msGbsBEEJDkLefrD7oKDe9ruQlfYj/cYzdzM0NJBqEPQczWHcCDFuDRQ3ye2bppP2O9bbY0Q5q/XLOaT7Ef1OTlCZZXoWXA1lrB8vtTvSGqWWJdIjGruylrLR7m5hwV/f4NwVuPhktV19S6Kswor7oUWXw+Cpel5FfjcEU2V1YL942LpEavr6pvz7ZdzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9NHtM85DyLljRb+x/NOrWgDg8DWsNOCCdLVOyxa+d8=;
 b=OLIYDa1E69fE3KYQov5PEHdaqLmcgDS0L6b9zJqKfj3Bx9Nx0e+bvh68iBHPiJ9TiXfus/XuZvA3HsbfFh/elxOrMac9TqSgvUMLuUrSKsqjul2DnidCWXEols6jnm/6LabH3Gh8S9571sIZI1I9zndMQEMCL2Yn5BCmlSWjFnY=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6333.eurprd04.prod.outlook.com (20.179.27.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 10:49:45 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::c5f3:ba8e:2b17:1f28%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 10:49:45 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 04/14] mmc: sdhci-esdhc-imx: restore pin state when resume
 back
Thread-Topic: [PATCH 04/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
Thread-Index: AQHVm6XiUD7Xov/jJEi5uBZUBIs+daedeO8AgAFKhCA=
Date:   Wed, 27 Nov 2019 10:49:45 +0000
Message-ID: <VI1PR04MB504044A15DB5BA610D32DFAA90440@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <1573816361-26535-1-git-send-email-haibo.chen@nxp.com>
 <d0651314-cf79-1063-5ce6-5b80fc816b77@intel.com>
In-Reply-To: <d0651314-cf79-1063-5ce6-5b80fc816b77@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3411dc99-afbd-44b7-9c52-08d773278409
x-ms-traffictypediagnostic: VI1PR04MB6333:|VI1PR04MB6333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6333731863DB47C8F2AE28AE90440@VI1PR04MB6333.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(189003)(199004)(13464003)(8936002)(66946007)(6246003)(102836004)(66066001)(25786009)(14454004)(478600001)(55016002)(6436002)(7696005)(71200400001)(186003)(26005)(4326008)(229853002)(9686003)(76176011)(2501003)(71190400001)(6506007)(53546011)(86362001)(54906003)(316002)(305945005)(7736002)(256004)(14444005)(11346002)(446003)(2906002)(99286004)(33656002)(2201001)(6116002)(3846002)(66446008)(64756008)(66556008)(66476007)(76116006)(5660300002)(8676002)(52536014)(81166006)(110136005)(81156014)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6333;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cRkzSv41b40LwT/qqstIIVlygvDksFEAUMxFXRYRWABgwfP1h3212JgHpHrSXtlGp4mheLd5CycxJTnqxEHOuaBjHsJH3CNaZvIq92OIUeeefcb0+39Ihtz0eouvf6EKIcwVZA6RluTQF6Dk7jxu3+pnAaMmm646s7HKOwjkF4FRc/X7EDi64PF77NJG2n6NJmc0vFwHfzSb54uvfMJn6GTKbYCG5J74QQc1bfzy31ibgEB4z8f0omSkQEx3wjdel1nr6sd3yCK5242iY5MD+503cpITS15hh9RLOi7umoDViFsi0twrf6ZTjS6Bfdfix1/VqLRvPCplpEZsvZV4QQP28jkcjbSKvJv4STqjyhTz9o7j2lyVYEdosUITGxMZfrfDoaOH1ZZf/FfdGNL+fLT7yo7lyS8qnHXA0Z3cGtbmxqUDQNaGLj0rq8sevb+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3411dc99-afbd-44b7-9c52-08d773278409
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 10:49:45.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chI4isf4e5pMkzJDdlFodcm5RUYEZnJKU/h5djn6N+no6NmWJaTx2SvdHgae6nUjCFKFbnVByNvh/0EGBpmkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiAyMDE55bm0MTHmnIgyNuaXpSAyMDo1MQ0K
PiBUbzogQk9VR0ggQ0hFTiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlDQo+IENjOiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMDQvMTRdIG1tYzogc2RoY2ktZXNkaGMtaW14OiByZXN0b3JlIHBp
biBzdGF0ZSB3aGVuDQo+IHJlc3VtZSBiYWNrDQo+IA0KPiBPbiAxNS8xMS8xOSAxOjEyIFBNLCBo
YWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hl
bkBueHAuY29tPg0KPiA+DQo+ID4gSW4gc29tZSBsb3cgcG93ZXIgbW9kZSwgU29DIHdpbGwgbG9z
ZSB0aGUgcGluIHN0YXRlLCBzbyBuZWVkIHRvDQo+ID4gcmVzdG9yZSB0aGUgcGluIHN0YXRlIHdo
ZW4gcmVzdW1lIGJhY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWli
by5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMgfCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlt
eC5jDQo+ID4gaW5kZXggMWM5ODhkNmEyNDMzLi4yNWIwMWYwNTlhY2EgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBAQCAtMTYyMyw3ICsxNjIzLDExIEBAIHN0
YXRpYyBpbnQgc2RoY2lfZXNkaGNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4g
IAlpZiAoaG9zdC0+dHVuaW5nX21vZGUgIT0gU0RIQ0lfVFVOSU5HX01PREVfMykNCj4gPiAgCQlt
bWNfcmV0dW5lX25lZWRlZChob3N0LT5tbWMpOw0KPiA+DQo+ID4gLQlyZXR1cm4gc2RoY2lfc3Vz
cGVuZF9ob3N0KGhvc3QpOw0KPiA+ICsJcmV0ID0gc2RoY2lfc3VzcGVuZF9ob3N0KGhvc3QpOw0K
PiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2
KTsNCj4gDQo+IEVycm9yIHJldHVybj8NCg0KVGhhbmtzIGZvciBwb2ludCBvdXQgdGhhdCwgSSB3
aWxsIGNoZWNrIHRoZSByZXR1cm4gb2YgcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2
KS4NCg0KPiANCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3Rh
dGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSBAQCAtMTYzMSw2
ICsxNjM1LDgNCj4gPiBAQCBzdGF0aWMgaW50IHNkaGNpX2VzZGhjX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gIAlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+ICsJcGluY3RybF9wbV9zZWxlY3RfZGVm
YXVsdF9zdGF0ZShkZXYpOw0KPiANCj4gRXJyb3IgcmV0dXJuPw0KPiANCj4gPiArDQo+ID4gIAkv
KiByZS1pbml0aWFsaXplIGh3IHN0YXRlIGluIGNhc2UgaXQncyBsb3N0IGluIGxvdyBwb3dlciBt
b2RlICovDQo+ID4gIAlzZGhjaV9lc2RoY19pbXhfaHdpbml0KGhvc3QpOw0KPiA+DQo+ID4NCg0K
