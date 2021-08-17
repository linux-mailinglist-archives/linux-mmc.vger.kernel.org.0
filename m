Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50443EEC6F
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Aug 2021 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhHQMaA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Aug 2021 08:30:00 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:37940
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234866AbhHQM37 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Aug 2021 08:29:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l29WoQV/+JKEfTrSG95ZJj9eDHb/m/PXPlSsLXDCJSMsBBybfxCQo7+rpi1wS1kRzRe6jnQ0iou2VWBeC4AOFI9HreIK7Fqwxm2gmUo5jXQr8lejHYniGbrMkfVFQ9iNzmv+Gb34ldkvhQx8GM5NZFNsE+VcWkwtVT3OScQedCvHeYudiMkIzN4HQSVXaJADO9I/vQ6GSvNLER6I673t14DKHEFEk3+Q2t8BkFiOMGNuWMdYWAM50I/FqTWs+DeugIq/r6TVQFegciThwKYkEakK9gFCk+BvqWNN4tGww6DoeIEJvgH7THOLDsFtO7n4ElN51TfzKF7kkW/ofPk/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWHudUI7v1R4woCGpSmB4FrR45tbnHKgzFS0az9GOkw=;
 b=JQj2gX8LqvCrindioDaSN6Pgjy7CClmXXCzCuuYonOte5J249cZi7OPMYePsEUzZAT3oQxsKEjLBPXAy7pxhokeLofInW8Yv3eT9shtVucIRdcZIGzqef2pgMvSaqQNiP1eYGq3fKQg7Ht9a+L59kpzptEB+YpyCT7NqZplUwqpDCMuJ3Kok5ArytvbnxiumtnEqZZZ9toXdpuI4dwe1/1MfGw+0oSTp37OnenKdXFJVh8ZZfZZnxxuMz0197Bxa0i3VmGmfqGFjj/+JgciYssqrwWHTVn40O30vUy04Z0vmKzLckjQJ0G6dTMx88DpLaKQfhhfaA5oIrUHwX21qXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWHudUI7v1R4woCGpSmB4FrR45tbnHKgzFS0az9GOkw=;
 b=QfpKI1lt5ocwHzHzeGbBTbgXXnpNwurPwTwol2tMpbcZHeBAatL3+Y5wNMqnbWDuZUfgAIowboKm3OOrhEfeokoYCKiHnnmqAp0Cem0pX1PAOKOcLHcEN8F3YoHrZ/uebh9K7LwHHrZGLqPAt+VwqnENBh/JA9iHP0WTNktSZbI=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 12:29:23 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 12:29:23 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto-tuning
 setting for sdio device
Thread-Topic: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the
 auto-tuning setting for sdio device
Thread-Index: AQHXkp6uvB2rKL05R0+WHD27Jc/Wc6t2JtyAgAEZ60CAABX/AIAASBJQ
Date:   Tue, 17 Aug 2021 12:29:23 +0000
Message-ID: <VI1PR04MB5294E39FDC07CD642315481A90FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <1629117508-4886-4-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFpqTdKxFytQWo+TLJf+D=JYJo6B2aZDqOQc4+9_mbH40Q@mail.gmail.com>
 <VI1PR04MB52948F36F428AA3476A1F9D590FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <CAPDyKFpr9E6xxe2egiRGGWhUSY5aVr29rj1Hb_TwCzrY5bcvpg@mail.gmail.com>
In-Reply-To: <CAPDyKFpr9E6xxe2egiRGGWhUSY5aVr29rj1Hb_TwCzrY5bcvpg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fa52008-8e0c-4f7d-f237-08d9617aa4fe
x-ms-traffictypediagnostic: VE1PR04MB7471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB74715BB23F69D71CB905542190FE9@VE1PR04MB7471.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiIpd+qY15JJtaS9oSO/S4uDXF+UszYMUKdKW/5HzyQC/iOjyRhgJ1f3ilqRMX79rkd/8I2a/5njl0Ud7+NbDy9CPh6uOHzLcDya9cOd8YGwJcI6lyRWTvCvDQKqacRd+moOW8i72DIA+EaKgYOiDON+ft/L1p8GPNlYFRYv+R6sxlF+fTViVgnx+GhBaxVHjisFdT9h78pxF45Fr0VXR59A6LvY0HTPP7BywYNtjwXIRh/+Th+M5Rmuwpp5Ibb9EtElEP0P9h9tX9gkaE+v5qN4ytQVvQ2axgQRjjzgEOUhGMURtHPk2UTQ+V6RbCwJ/HIHZGOUAlmyQxULOXhU4nIrd+xYrkuSiN3/L54kEWACUbcEqitiePtKbGySpTJVNjcKFIsAj8TJ2jCUz0AyImLRliWJIlRZI7/nvw37CcrkR8BUJ6DHO2X4S8XZrCXmOg5qgqKi7aunvMjN4I5mh6deIcGafoR2m1DtrCuDfc0EURZYDG95uWzrilhGTrWL/6kmoBKnueZE7G3qy0hdPftx0kOyBWld344yqmTFKaGsGNfrFekKoMvJJJk57TX9A0CNXAIa1wVZ2uq6R5G/3mBfXZReEhSkHVyNYO+CdfyD99Q8mt7GXyxHWaW8b4X/vT/vXWY6zy7O2hjgnkWpZoPH73PeEUB8IHkG7vSh0bGQfAuXCDLhILby9VWqJGoldhdwE8M15G7124wqkLS6zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39850400004)(376002)(346002)(26005)(76116006)(8676002)(83380400001)(186003)(71200400001)(54906003)(86362001)(8936002)(7696005)(53546011)(6506007)(4326008)(6916009)(2906002)(64756008)(66556008)(66476007)(66446008)(9686003)(33656002)(316002)(7416002)(55016002)(478600001)(122000001)(38100700002)(52536014)(66946007)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmRBS2d6K05pSnI1RlI1TDNjU3hZdWpmeVdUOTdHK1ZNUU9tODdycS8wd0Rh?=
 =?utf-8?B?NTRqTXBvYmtsV3ZEbTZFdHFzZmdVcVNmOVlxNjZBbE1qbVEvOFlqN1RQMkVD?=
 =?utf-8?B?V0ZVZFJUQkNZKzF1dnAyR0RENjFIUm9FV2toSjJhOHFjL3B6dUdsN3dGN0ZY?=
 =?utf-8?B?UmxCTXN6ZlFTVE5GOGszZmJFcFZYWjkvS0dRWXlQbHNub1N5bElMVjFidzBH?=
 =?utf-8?B?VUdmS3lqOGNMYzJic3VCTUF6dEtWUnFESjRJdlpaZEpCQWhhaGhTTkViUUU3?=
 =?utf-8?B?bEp0ajY0MkdlTmRua01GR3FHRGQ4ZWZ5ZUhodXBlSDlSdE9jV1JDR2htMlJS?=
 =?utf-8?B?Z1lOampnN01oejFxNTE0cDZkcGZmOUd6dVUycTBya0F2WEFtcXc5dHlKN2Jw?=
 =?utf-8?B?Q1ZFYzdDa2tiY00vZGYwUW12RENjR2ZDSXFNUHRsMzlwU2trbUxPamtROHA3?=
 =?utf-8?B?c3M1Z2VaenVKTDd5VFNUSjJvb2R2c1I1bDgxOGw2bGtrQWp0dFpDWXlFL1Fv?=
 =?utf-8?B?UXRMUHNHN2pCTG91UmlUaHFmM0xWUGJVRlNRdVdJekdlS3RzS0hQbndjSE1m?=
 =?utf-8?B?RHFaSHlVSVNXVUpDbWprSHp2U2pqdEdwL3JDSjEvNzNlajZaQ1NDaDZ4VmxJ?=
 =?utf-8?B?TnpScUE2SFVnYkxsOVMvbEJaODRDRnh1L2xGQ3N6Uytwa05JT05ER0lIUld3?=
 =?utf-8?B?N09rdnhHcWZjekFYbDdiYzBvMmhoaklORFdSZkJ0djN2d1lQR2crSE43MkRB?=
 =?utf-8?B?aGVEYlFWQXdjZnFxTFpqNFk2VGdVYnNQc0JxaTdwR1hVR1RkazZGUTUyRXh4?=
 =?utf-8?B?VUM0cUU1ZWVvRFcxNTFpS1hJSXRWNG5QSUgreGlUSlYwT3Q2QWZYR0VDb09x?=
 =?utf-8?B?NDdDeXhtci9majg0ejdCQjdtM3F0MkkvRnBhUVdjZWFIRFBGc0NiQUVPTDZv?=
 =?utf-8?B?WCt5N2crUTZxQk1CUGRFN2liaDQ2YWNyWERlVzR4bVV6cnVDdGRSRFRjUWJU?=
 =?utf-8?B?UGk0bWtLWnROZUwrWldmMTl1RytwejNLeEhQdHMvcGVJS0pxbWlCSGdQSUlP?=
 =?utf-8?B?d0hXZkUwRnBoNDhBZjladUh6WWFyUFpVN0JqcTBMa3p5NTdZODZxTHZXejM0?=
 =?utf-8?B?TjZWSmh6MXluS0QxMXdvREdlek9MZDZUaWhLb2VjU1l2SFBUR1NheVE1ei9W?=
 =?utf-8?B?eDNoajhhbmEwM2lmMW9WSDNNZkloWlgzdm9JeTF4Ukl2Tkp4MExHWHE3SFh4?=
 =?utf-8?B?NTVBQmdwbHRtanpnT1pBMGg4TWNVUjFRcjJmR1ovZ2FCVVNYdFR5N2pJQ2hB?=
 =?utf-8?B?dTB3T0hSYjZMbW0rK1NTNk8xQ2NpUHNTcTd3MWJWbGJObm90QlJWYzJJUmRv?=
 =?utf-8?B?c3g5Z3RnUFFjbnFCamZNcGRwV3hiR2tLNk9Mb01oZjJOdDdCTEpWRllqeUk4?=
 =?utf-8?B?K2E5aUdTSHdBR2RkeU83MFJDY3dtVndCVC80WEEzNnNRdHFHR3pBanc5dmI0?=
 =?utf-8?B?RzJHN0tuMjJzOUlSbXlLME1pYkR0T0g2Y09BZlBYTUJ2dGljWEhKUDdYL3N4?=
 =?utf-8?B?cnZLTzBka3djaUtsUE14ajJpTVRyWlk0WWpLNUo5Z0hKdlRKQTFOZnY2eFZi?=
 =?utf-8?B?dGdMcFpjaVFFbHZyTDEvQmJPci9ac2xkUURGeXJRclFvcWk3Rll1YTZyeUZF?=
 =?utf-8?B?MUxrd2hWSjROVTNRU2VHZndib09iTjZJRE1lVi9GSzVZWUhpN2lCbUQ3QTV1?=
 =?utf-8?Q?wrdozMLDx4yxOBXrLZabBvVTTCVXVUORnZ9CYXC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa52008-8e0c-4f7d-f237-08d9617aa4fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 12:29:23.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L1OdlPrMS9IUwxG+WufqFKd0TScp3UA79pchPgN9PC4hSvA4c9gy3pvI3dxlAyvGeg/8C1AApO47vvBk15Wrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IDIwMjHlubQ45pyIMTfml6UgMTY6MDEN
Cj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0K
PiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgbGludXgtbW1j
IDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IERUTUwgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gQVJN
IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggNC82XSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlteC5jOiBjb3JyZWN0IHRoZSBhdXRv
LXR1bmluZw0KPiBzZXR0aW5nIGZvciBzZGlvIGRldmljZQ0KPiANCj4gT24gVHVlLCAxNyBBdWcg
MjAyMSBhdCAwODo1NywgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFVsZiBIYW5z
c29uIFttYWlsdG86dWxmLmhhbnNzb25AbGluYXJvLm9yZ10NCj4gPiA+IFNlbnQ6IDIwMjHlubQ4
5pyIMTbml6UgMjE6NTMNCj4gPiA+IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+
DQo+ID4gPiBDYzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBTaGF3
biBHdW8NCj4gPiA+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IFNhc2NoYQ0KPiA+ID4gSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBTYXNjaGEgSGF1ZXINCj4gPiA+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3Rl
dmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiA+ID4gbGludXgtbW1jIDxsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnPjsgZGwtbGludXgtaW14DQo+ID4gPiA8bGludXgtaW14QG54cC5jb20+OyBE
VE1MIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEFSTQ0KPiA+ID4gPGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggNC82XSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlteC5jOiBjb3JyZWN0IHRoZQ0KPiA+ID4g
YXV0by10dW5pbmcgc2V0dGluZyBmb3Igc2RpbyBkZXZpY2UNCj4gPiA+DQo+ID4gPiBPbiBNb24s
IDE2IEF1ZyAyMDIxIGF0IDE1OjAwLCA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gPiA+
ID4NCj4gPiA+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+ID4g
Pg0KPiA+ID4gPiBVU0RIQyBjb250YWluIGF1dG8gdHVuaW5nIGNpcmN1aXQsIHRoaXMgY2lyY3Vp
dCB3aWxsIHdvcmsNCj4gPiA+ID4gYXV0b21hdGljYWxseSBhZnRlciB0aGUgdHVuaW5nIHByb2Nl
ZHVyYWUsIGl0IGNhbg0KPiA+ID4gPiBpbmNyZWFzZS9kZWNyZWFzZSB0aGUgZGVsYXkgY2VsbCBh
Y2NvcmRpbmcgdG8gdGhlIG91dHNpZGUNCj4gPiA+ID4gZW52aXJvbm1lbnQgY2hhbmdlIChsaWtl
DQo+ID4gPiB0ZW1wZXJhdHVyZSkuDQo+ID4gPiA+DQo+ID4gPiA+IFVuZm9ydHVuYXRlbHksIHRo
aXMgYXV0byB0dW5pbmcgY2lyY3VpdCBjYW4gbm90IGhhbmRsZSB0aGUgYXN5bmMNCj4gPiA+ID4g
c2RpbyBkZXZpY2UgaW50ZXJydXB0IGNvcnJlY3RseS4gV2hlbiBzZGlvIGRldmljZSB1c2UgNCBk
YXRhIGxpbmUsDQo+ID4gPiA+IGFzeW5jIHNkaW8gaW50ZXJydXB0IHdpbGwgdXNlIERBVFsxXSwg
aWYgd2UgZW5hYmxlIGF1dG8gdHVuaW5nDQo+ID4gPiA+IGNpcmN1aXQgY2hlY2sNCj4gPiA+ID4g
NCBkYXRhIGxpbmVzLCBpbmNsdWRlIHRoZSBEQVRbMV0sIHRoaXMgY2lyY3VpdCB3aWxsIGRldGVj
dCB0aGlzDQo+ID4gPiA+IGludGVycnVwdCwgdGFrZSB0aGlzIGFzIGEgZGF0YSBvbiBEQVRbMV0s
IGFuZCBhZGp1c3QgdGhlIGRlbGF5IGNlbGwgd3JvbmdseS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhp
cyBpcyB0aGUgaGFyZHdhcmUgZGVzaWduIGxpbWl0YXRpb24sIHRvIGF2b2lkIHRoaXMsIHdoZW4g
c2Rpbw0KPiA+ID4gPiBkZXZpY2UgZW5hYmxlIGFzeW5jIGludGVycnVwdCwgYXV0byB0dW5pbmcg
Y2lyY3VpdCBvbmx5IGNoZWNrDQo+ID4gPiA+IERBVFswXSBhbmQgQ01EDQo+ID4gPiBsaW5lcy4N
Cj4gPiA+DQo+ID4gPiBTRElPIGlycXMgYXJlIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQgZHluYW1p
Y2FsbHkgaW4gcnVudGltZSBieSB0aGUNCj4gPiA+IG1tYyBjb3JlIHZpYSB0aGUgaG9zdCBvcHMg
LT5lbmFibGVfc2Rpb19pcnEoKS4NCj4gPiA+DQo+ID4gPiBSYXRoZXIgdGhhbiBmb3JjaW5nIHRo
ZSBhdXRvdHVuaW5nIGNpcmN1aXQgdG8gc3RheSB1bnVzZWQNCj4gPiA+IHN0YXRpY2FsbHksIHBl
cmhhcHMgYW4gb3B0aW9uIHdvdWxkIGJlIHRvIGRpc2FibGUgaXQgd2hlbiB0aGUgU0RJTw0KPiA+
ID4gaXJxcyBiZWNvbWVzIGVuYWJsZWQ/IE9yIG1heWJlIHRoYXQgYmVjb21lcyB0b28gY29tcGxp
Y2F0ZWQ/DQo+ID4NCj4gPiBGb3IgaW50ZXJydXB0IGluIDQtYml0IG1vZGUsIHRoZXJlIGlzIGEg
ZGVmaW5pdGlvbiBvZiBpbnRlcnJ1cHQNCj4gPiBwZXJpb2QsIG9ubHkgaW4gdGhpcyBwZXJpb2Qg
Y2FuIHRoZSBpbnRlcnJ1cHQgYmUgZGV0ZWN0IGFuZCByZWNvZ25pemUuIFRoZQ0KPiBpbnRlcnJ1
cHQgcGVyaW9kIGNhbiBleGlzdCBkdXJpbmcgZGF0YSB0cmFuc2Zlci4NCj4gPg0KPiA+IFNvIHRv
IGZpeCB0aGlzIGlzc3VlLCBvbmUgbWV0aG9kIGlzIHRvIGRpc2FibGUgYXV0byB0dW5pbmcgY2ly
Y3VpdC4NCj4gPiBBbm90aGVyIGlzIG15IGN1cnJlbnQgbWV0aG9kLCBqdXN0IGRldGVjdCBDTUQg
YW5kIERBVDAsIGJ1dCBhdCBsZWFzdCBhdXRvDQo+IHR1bmluZyBzdGlsbCBjYW4gd29yayAodGhp
cyBtZXRob2QgbmVlZCBib2FyZCBkZXNpZ24ga2VlcCBhbGlnbiBhbGwgZGF0YSBsaW5lcykuDQo+
IA0KPiBUbyBhbGxvdyBEQVQxIGJlaW5nIHVzZWQgZm9yIFNESU8gaXJxcyAoYXN5bmMgb3Igbm90
KSwgdGhlIGlycXMgbmVlZHMgdG8gYmUNCj4gZW5hYmxlZCBpbnRlcm5hbGx5IGluIHRoZSBTRElP
IGNhcmQgZmlyc3QuIFRoaXMgaXMgZG9uZSBieSB3cml0aW5nIHRvIHRoZSBDQ0NSDQo+IHJlZ2lz
dGVyLCB3aGljaCBoYXBwZW5zIGluIHNkaW9fY2xhaW1faXJxKCkuIEF0IHRoaXMgcG9pbnQgaW4g
c2Rpb19jbGFpbV9pcnEoKSB0aGUNCj4gY29yZSBhbHNvIGludm9rZXMgdGhlDQo+IC0+ZW5hYmxl
X3NkaW9faXJxKCkgaG9zdCBvcHMsIHRvIGFsbG93IHRoZSBob3N0IHRvIHByZXBhcmUgaXRzZWxm
IHRvDQo+IGFjY2VwdCBTRElPIGlycXMuDQo+IA0KPiBJdCBzb3VuZHMgdG8gbWUgdGhhdCB5b3Ug
c2hvdWxkIGJlIGFibGUgdG8gdXNlIHRoZSAtPmVuYWJsZV9zZGlvX2lycSBvcHMsIGFzIGENCj4g
d2F5IG9mIHVuZGVyc3RhbmRpbmcgdGhhdCB0aGUgYXV0by10dW5pbmcgZmVhdHVyZSBhbHNvIG5l
ZWRzIHRvIGJlIHR1cm5lZCBvZmYsDQo+IGJlY2F1c2UgaXQncyBub3QgY29tcGF0aWJsZSB3aXRo
IFNESU8gaXJxcy4NCj4gDQoNClllcywgZm9yIGN1cnJlbnQgYXV0by10dW5pbmcgZGVzaWduLCBp
dCBuZWVkIHRvIGJlIHR1cm5lZCBvZmYgZm9yIHNkaW8gaW50ZXJydXB0Lg0KDQpJJ20ganVzdCBh
IGJpdCBncmVlZHksIHdhbnQgdG8gZmluZCBhIG1ldGhvZCB0byBzdXBwb3J0IGF1dG8tdHVuaW5n
IGZvciBzZGlvIGludGVycnVwdC4g8J+Yig0KSSB3aWxsIHVzZSBhIG5ldyBwcm9wZXJ0eSBsaWtl
ICJmc2wsYnJva2VuLWF1dG8tdHVuaW5nIiBmb3IgdGhpcyBXaUZJIGRldmljZSBpbiBWMiBwYXRj
aC4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuLg0KDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZl
DQo+IA0KPiA+DQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMNCj4gPiBIYWlibyBjaGVuDQo+ID4NCj4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNp
LWVzZGhjLWlteC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+ID4gPiBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiA+ID4gaW5kZXggZjE4ZDE2OWJjOGZmLi5hYjg0YzI5
Nzc3ZTUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMt
aW14LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0K
PiA+ID4gPiBAQCAtMjI2LDYgKzIyNiw3IEBAIHN0cnVjdCBlc2RoY19wbGF0Zm9ybV9kYXRhIHsN
Cj4gPiA+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgdHVuaW5nX3N0ZXA7ICAgICAgIC8qIFRoZSBk
ZWxheSBjZWxsIHN0ZXBzIGluDQo+IHR1bmluZw0KPiA+ID4gcHJvY2VkdXJlICovDQo+ID4gPiA+
ICAgICAgICAgdW5zaWduZWQgaW50IHR1bmluZ19zdGFydF90YXA7ICAvKiBUaGUgc3RhcnQgZGVs
YXkgY2VsbA0KPiA+ID4gPiBwb2ludCBpbg0KPiA+ID4gdHVuaW5nIHByb2NlZHVyZSAqLw0KPiA+
ID4gPiAgICAgICAgIHVuc2lnbmVkIGludCBzdHJvYmVfZGxsX2RlbGF5X3RhcmdldDsgICAvKiBU
aGUgZGVsYXkgY2VsbCBmb3INCj4gPiA+IHN0cm9iZSBwYWQgKHJlYWQgY2xvY2spICovDQo+ID4g
PiA+ICsgICAgICAgYm9vbCBzZGlvX2FzeW5jX2ludGVycnVwdF9lbmFibGVkOyAgICAgIC8qIHNk
aW8gZGV2aWNlIGVuYWJsZQ0KPiA+ID4gdGhlIGFzeW5jIGludGVycnVwdCAqLw0KPiA+ID4gPiAg
fTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB7DQo+ID4gPiA+IEBA
IC00MTYsNiArNDE3LDggQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gPiA+IGVzZGhjX3dhaXRf
Zm9yX2NhcmRfY2xvY2tfZ2F0ZV9vZmYoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gPiA+
ICAvKiBFbmFibGUgdGhlIGF1dG8gdHVuaW5nIGNpcmN1aXQgdG8gY2hlY2sgdGhlIENNRCBsaW5l
IGFuZCBCVVMNCj4gPiA+ID4gbGluZSAqLyAgc3RhdGljIGlubGluZSB2b2lkIHVzZGhjX2F1dG9f
dHVuaW5nX21vZGVfc2VsKHN0cnVjdA0KPiA+ID4gPiBzZGhjaV9ob3N0DQo+ID4gPiA+ICpob3N0
KSAgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0ICpwbHRmbV9ob3N0
ID0gc2RoY2lfcHJpdihob3N0KTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGx0Zm1faW14X2Rh
dGEgKmlteF9kYXRhID0NCj4gPiA+ID4gKyBzZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0K
PiA+ID4gPiAgICAgICAgIHUzMiBidXN3aWR0aCwgYXV0b190dW5lX2J1c3dpZHRoOw0KPiA+ID4g
Pg0KPiA+ID4gPiAgICAgICAgIGJ1c3dpZHRoID0gVVNESENfR0VUX0JVU1dJRFRIKHJlYWRsKGhv
c3QtPmlvYWRkciArDQo+ID4gPiA+IFNESENJX0hPU1RfQ09OVFJPTCkpOyBAQCAtNDMyLDYgKzQz
NSwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gPiA+IHVzZGhjX2F1dG9fdHVuaW5nX21vZGVf
c2VsKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIC8qDQo+ID4g
PiA+ICsgICAgICAgICogSWYgc2RpbyBkZXZpY2UgdXNlIGFzeW5jIGludGVycnVwdCwgaXQgd2ls
bCB1c2UgREFUWzFdIHRvIHNpZ25hbA0KPiA+ID4gPiArICAgICAgICAqIHRoZSBkZXZpY2UncyBp
bnRlcnJ1cHQgYXN5bmNocm9ub3VzIHdoZW4gdXNlIDQgZGF0YSBsaW5lcy4NCj4gPiA+ID4gKyAg
ICAgICAgKiBUaGVuIGhhcmR3YXJlIGF1dG8gdHVuaW5nIGNpcmN1aXQgTVVTVCBOT1QgY2hlY2sg
dGhlDQo+ID4gPiA+ICsgREFUWzFdDQo+ID4gPiBsaW5lLA0KPiA+ID4gPiArICAgICAgICAqIG90
aGVyd2lzZSBhdXRvIHR1bmluZyB3aWxsIGJlIGltcGFjdGVkIGJ5IHRoaXMgYXN5bmMNCj4gaW50
ZXJydXB0LA0KPiA+ID4gPiArICAgICAgICAqIGFuZCBjaGFuZ2UgdGhlIGRlbGF5IGNlbGwgaW5j
b3JyZWN0bHksIHdoaWNoIHRoZW4gY2F1c2UNCj4gPiA+IGRhdGEvY21kDQo+ID4gPiA+ICsgICAg
ICAgICogZXJyb3JzLg0KPiA+ID4gPiArICAgICAgICAqIFRoaXMgaXMgdGhlIGhhcmR3YXJlIGF1
dG8gdHVuaW5nIGNpcmN1aXQgbGltaXRhdGlvbi4NCj4gPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+
ID4gKyAgICAgICBpZiAoaW14X2RhdGEtPmJvYXJkZGF0YS5zZGlvX2FzeW5jX2ludGVycnVwdF9l
bmFibGVkKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgYXV0b190dW5lX2J1c3dpZHRoID0NCj4g
PiA+ID4gKyBFU0RIQ19WRU5EX1NQRUMyX0FVVE9fVFVORV8xQklUX0VOOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICAgICAgICAgZXNkaGNfY2xyc2V0X2xlKGhvc3QsDQo+ID4gPiBFU0RIQ19WRU5EX1NQ
RUMyX0FVVE9fVFVORV9NT0RFX01BU0ssDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGF1dG9fdHVuZV9idXN3aWR0aCB8DQo+ID4gPiBFU0RIQ19WRU5EX1NQRUMyX0FVVE9fVFVORV9D
TURfRU4sDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEVTREhDX1ZFTkRfU1BFQzIp
OyBAQCAtMTUzMSw2DQo+ICsxNTQ2LDkNCj4gPiA+IEBADQo+ID4gPiA+IHNkaGNpX2VzZGhjX2lt
eF9wcm9iZV9kdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ID4gPiAgICAgICAg
IGlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgImZzbCxkZWxheS1saW5lIiwNCj4gPiA+ICZi
b2FyZGRhdGEtPmRlbGF5X2xpbmUpKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgYm9hcmRkYXRh
LT5kZWxheV9saW5lID0gMDsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICBpZiAob2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5wLA0KPiA+ID4gPiArICJmc2wsc2Rpby1hc3luYy1pbnRlcnJ1cHQtZW5h
YmxlZCIpKQ0KPiA+ID4NCj4gPiA+IEFzIHN0YXRlZCBvbiB0aGUgRFQgcGF0Y2gsIEkgdGhpbmsg
eW91IGNhbiB1c2UgdGhlICJjYXAtc2Rpby1pcnEiIGluc3RlYWQuDQo+ID4gPg0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgYm9hcmRkYXRhLT5zZGlvX2FzeW5jX2ludGVycnVwdF9lbmFibGVkID0g
dHJ1ZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICAgIG1tY19vZl9wYXJzZV92b2x0YWdlKGhv
c3QtPm1tYywgJmhvc3QtPm9jcl9tYXNrKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBpZiAo
ZXNkaGNfaXNfdXNkaGMoaW14X2RhdGEpICYmDQo+ID4gPiA+ICFJU19FUlIoaW14X2RhdGEtPnBp
bmN0cmwpKSB7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMTcuMQ0KPiA+ID4gPg0KPiA+ID4NCj4g
PiA+IEtpbmQgcmVnYXJkcw0KPiA+ID4gVWZmZQ0K
