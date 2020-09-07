Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04F725FAD3
	for <lists+linux-mmc@lfdr.de>; Mon,  7 Sep 2020 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgIGM5X (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 7 Sep 2020 08:57:23 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:15066 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729368AbgIGM5S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2020 08:57:18 -0400
X-Greylist: delayed 7568 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 08:57:17 EDT
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
        by m0048300.ppops.net-00176a03. (8.16.0.42/8.16.0.42) with SMTP id 087AkF96004423
        for <linux-mmc@vger.kernel.org>; Mon, 7 Sep 2020 06:50:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiZVFo2ghKwrtBypfXUVUYGpPOLISWd+ytnq5nsjPIYtoPaOgQ49/ZKOeO9ySzd9/NDFVJGVL17Bsy8GCsC6+S/8rGoe8vyOYP6ngJPNl3ocMJrY8yt0x+79E6wS8k1SWdJGzuvLV0bfo6RV+TX7zlWKOXNbk2xTrguCJ0aksTowRBVSHaDKqhMRTjz+/XFGhX5SPWAGXviESHMfhzUOMofOXDt0dMd+kE0JlXj58RhbGz9ipkzCiLdxOoTNLqF4XG7tKEqcLNEiOE39HZC9TLqbkpqTusvtUagTibx78lvIYeEG14NmbucVDFwT9icb5OkhnRJSqaFYUxVib8gQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whSNaiX6clQn7lJBy8zzUiKcWGPceQQoI3TnRuUWyVA=;
 b=WSbpprgPv0Q/vT45gEO/BH0eYIpdYzgDBrX9zezUfxXOF0aK2hfF9LHVMfw+RpqLCLJpEgCUY73I/nLYbXUL3EDMHo08Ao0WMel89nOazvP+3PvtfUE8Pcg8WLQiysYTZOhFHzrNUT+nrhVWSncg8KOugfltD9bYFnonn2OWwd5FEzCPtLvi/ZVgXh+xvjtD2FuQp31AyM+aRrCtPal8lxDbGqkFlW9mXMGB9LIbMKSgZ02a7pTXOcUdvLVMAFJh8K7+SG6CDaMwDNF+VUmn7/S3GrRh2dz2hduMvj3yRTTZruIWc8V75ZaMffBZoyEnABOKMIq7tKDh6/aHSRaBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=med.ge.com; dmarc=pass action=none header.from=med.ge.com;
 dkim=pass header.d=med.ge.com; arc=none
From:   "Baumgartner, Claus (GE Healthcare)" <claus.baumgartner@med.ge.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bough Chen <haibo.chen@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: RE: EXT: Re: mmc0: Timeout waiting for hardware cmd interrupt on
 i.MX535
Thread-Topic: EXT: Re: mmc0: Timeout waiting for hardware cmd interrupt on
 i.MX535
Thread-Index: AdaAMoFCTyezERBOQE2GwxP9opqVdwBw8mJJAMHFEaA=
Date:   Mon, 7 Sep 2020 10:50:45 +0000
Message-ID: <AM0P101MB02897EE0CD459B0027C985AFD1280@AM0P101MB0289.NAMP101.PROD.OUTLOOK.COM>
References: <AM0P101MB03060DFCABC4A82C2D40F180D12E0@AM0P101MB0306.NAMP101.PROD.OUTLOOK.COM>
 <20200901114642.vhivtsfrarua6ce4@earth.universe>
 <VI1PR04MB5294C1AE26EA2D0DA163F307902F0@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <20200902134906.uqyoejyv4atljm46@earth.universe>
 <AM0PR04MB52835B3EF15DA576F6E46F8E902C0@AM0PR04MB5283.eurprd04.prod.outlook.com>
 <20200903132926.yc2lx25k2xbzglzc@earth.universe>
In-Reply-To: <20200903132926.yc2lx25k2xbzglzc@earth.universe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=med.ge.com;
x-originating-ip: [205.173.89.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 629d8e77-3ae3-4e61-2757-08d8531bdfeb
x-ms-traffictypediagnostic: AM0P101MB0322:
x-microsoft-antispam-prvs: <AM0P101MB0322EDD241513FF4DCB2E07FD1280@AM0P101MB0322.NAMP101.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDut66WAX375icXPGLvbEm570HOD1g1FVHAwqqi944ZmBc0IVOvXcVE2H14uv3FnidcAyQ/XPshNjh3vWMiD8xgy9bedHBuOHC+2oCjZjPbC1+Vo2+DGZsKI4CX7ViSLS3Hv57zECnVFc7VV05jLuaAbtPk5Nw/EEbhNkrcKKMRg3J6hju4F16nlwD7CysLH4jNy99P9feSx4BICKLHTMDCOwY7ZAE/RB7vkALY2528tzpZYPIlxnJifdgByolRalq4XKuqTsbKbhsCcu/HkzLXKJU5qm6H3M7QniOVCy7pZRcQUjWTmCDWbhJNV5KxiUzKDHVJyFraTJED0uU9e3HDEJnun4TH6ADrRArWgUzOOMs5N97Vx1/e+DFh2f+er+BZohFCCUxC4UBOWihS/3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P101MB0289.NAMP101.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(66556008)(66476007)(66946007)(76116006)(64756008)(316002)(8936002)(4326008)(9686003)(55016002)(110136005)(54906003)(33656002)(26005)(186003)(966005)(8676002)(7696005)(53546011)(6506007)(2906002)(478600001)(52536014)(5660300002)(71200400001)(83380400001)(30864003)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PAhfjQpvoRL4O7Boe5BgPcX3UwWhlw4MOHXIcS+0I2Spl3Rta3Yhlt8kV7+FOXRq9t6r6JkT5XcsBA9WGp+leIJE8AFDKa9TLIrAIY5ObL7BJr9zVhHaAXuhM7kJObQdLUQQ305kykIFJK4v3qKx3PHFWp479eIsJmoxnzW9fHMljqaUZKGjAfc3RE9ArjNvIn51AaIgi2OLEQhlZDCfIp8uaa/wo4PWpdgfaDKJ9gX8y/hQGWj8xKARU3L5EH9xfy0neWu4Wo77kNOjGk4caO2vj0xyIZu/L38zD1I6ZjMARGtLTCOA0JQyU/7MSn0GJEeOjTUAYUhCrPnwRNmDR33ikcTJuCDMv+TVpAm67gwRV0SkutLqbkfpCLlgcunrlbEnxGiGMcKLouLbpm0jF+HLTsS7K8hUwaTHmZjbLLarMaCa4rYAxQdkVQJfeJfyywFaE00nsCv7itBTl7JlFKTMTtW5ayhpRI3ke9wXy2AI7mMTqM7dq7fXLLtnHSJvWBIlMDLFrgCXdw7ajLEFkfAoaCXp2lDJJ7GN+IhKglGHJvfhAnUhM40cxmfPnu3x8MURqQzYsqpXqvi7j1C1KpXVsUVisRV7SLOuRYDZDbRYMSaJXYmTcis8ezsOkNda6L1nWOkw0MDIG/KEh71OeQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P101MB0289.NAMP101.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d8e77-3ae3-4e61-2757-08d8531bdfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 10:50:45.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ccb6d1-d335-4996-b6f9-7b6925f08121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fahanc5/Iasyr7ODPL9QZP6P4jsjGvvhog1iv/QHp0mdrvmnetzlNrtnGylwwOT59VkydpQ50JP5MOlh1dclhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P101MB0322
X-OriginatorOrg: med.ge.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_04:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070105
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIFJl
aWNoZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+DQo+IFNlbnQ6IDMuIHN5eXNr
dXV0YXRhIDIwMjAgMTY6MjkNCj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4N
Cj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBTaGF3bg0KPiBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1
ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwu
Y29tPjsgQmF1bWdhcnRuZXIsIENsYXVzIChHRSBIZWFsdGhjYXJlKQ0KPiA8Y2xhdXMuYmF1bWdh
cnRuZXJAbWVkLmdlLmNvbT4NCj4gU3ViamVjdDogRVhUOiBSZTogbW1jMDogVGltZW91dCB3YWl0
aW5nIGZvciBoYXJkd2FyZSBjbWQgaW50ZXJydXB0IG9uDQo+IGkuTVg1MzUNCj4gDQo+IEhpLA0K
PiANCj4gT24gVGh1LCBTZXAgMDMsIDIwMjAgYXQgMDI6MTA6NDNBTSArMDAwMCwgQm91Z2ggQ2hl
biB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBT
ZWJhc3RpYW4gUmVpY2hlbCBbbWFpbHRvOnNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb21d
DQo+ID4gPiBTZW50OiAyMDIw5bm0OeaciDLml6UgMjE6NDkNCj4gPiA+IFRvOiBCb3VnaCBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPiA+IDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPiA+IDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiA+ID4gQmF1bWdh
cnRuZXIsIENsYXVzIChHRSBIZWFsdGhjYXJlKSA8Y2xhdXMuYmF1bWdhcnRuZXJAbWVkLmdlLmNv
bT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBtbWMwOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJl
IGNtZCBpbnRlcnJ1cHQgb24NCj4gPiA+IGkuTVg1MzUNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIFNl
cCAwMiwgMjAyMCBhdCAxMToyNDo1MkFNICswMDAwLCBCb3VnaCBDaGVuIHdyb3RlOg0KPiA+ID4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogU2ViYXN0aWFu
IFJlaWNoZWwgW21haWx0bzpzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tXQ0KPiA+ID4g
PiA+IFNlbnQ6IDIwMjDlubQ55pyIMeaXpSAxOTo0Nw0KPiA+ID4gPiA+IFRvOiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gPiA+IENjOiBsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnOyBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+Ow0KPiA+ID4gPiA+IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0KPiA+ID4gPiA+IDxzLmhh
dWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPiA+ID4gPiA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29t
PjsNCj4gPiA+ID4gPiBCYXVtZ2FydG5lciwgQ2xhdXMgKEdFIEhlYWx0aGNhcmUpDQo+ID4gPiA+
ID4gPGNsYXVzLmJhdW1nYXJ0bmVyQG1lZC5nZS5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6
IG1tYzA6IFRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgY21kIGludGVycnVwdCBvbg0KPiA+
ID4gPiA+IGkuTVg1MzUNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gW2FkZCBpLk1YIGFyY2hpdGVjdHVyZSBtYWludGFpbmVycyB0byBDY10NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE9uIFR1ZSwgU2VwIDAxLCAyMDIwIGF0IDA3OjM3OjMxQU0gKzAwMDAsIEJh
dW1nYXJ0bmVyLCBDbGF1cyAoR0UNCj4gPiA+ID4gPiBIZWFsdGhjYXJlKSB3cm90ZToNCj4gPiA+
ID4gPiA+IFdlIGhhdmUgYSBib2FyZCB3aXRoIGFuIGkuTVg1MzUgdXNpbmcgYSBTYW1zdW5nIGVN
TUMgYXMNCj4gPiA+ID4gPiA+IHBlcnNpc3RlbnQgc3RvcmFnZSBjb25uZWN0ZWQgdG8gZVNESEN2
My4gRXZlcnkgbm93IGFuZCB0aGVuIHdlDQo+ID4gPiA+ID4gPiBwcm9kdWNlIGEgYnVpbGQgdGhh
dCBjYXVzZXMgZW1tYyB0aW1lb3V0czoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBdWcgMjgg
MDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBUaW1lb3V0IHdhaXRpbmcgZm9yDQo+ID4gPiA+
ID4gPiBoYXJkd2FyZSBjbWQNCj4gPiA+ID4gPiBpbnRlcnJ1cHQuDQo+ID4gPiA+ID4gPiBBdWcg
MjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhjaTogPT09PT09PT09PT09IFNESENJ
DQo+ID4gPiA+ID4gPiBSRUdJU1RFUiBEVU1QID09PT09PT09PT09IEF1ZyAyOCAwNzozMjoxMiBj
c21vbiBrZXJuZWw6IG1tYzA6DQo+ID4gPiBzZGhjaTogU3lzIGFkZHI6DQo+ID4gPiA+ID4gPiAw
eGUzZjEyMDAwIHwgVmVyc2lvbjogIDB4MDAwMDEyMDEgQXVnIDI4IDA3OjMyOjEyIGNzbW9uIGtl
cm5lbDoNCj4gPiA+IG1tYzA6DQo+ID4gPiA+ID4gPiBzZGhjaTogQmxrIHNpemU6ICAweDAwMDAw
MjAwIHwgQmxrIGNudDogIDB4MDAwMDAwMDEgQXVnIDI4DQo+ID4gPiA+ID4gPiAwNzozMjoxMiBj
c21vbg0KPiA+ID4gPiA+IGtlcm5lbDogbW1jMDogc2RoY2k6IEFyZ3VtZW50OiAgMHgwMDAxMDAw
MCB8IFRybiBtb2RlOg0KPiA+ID4gPiA+IDB4MDAwMDAwMDANCj4gPiA+ID4gPiA+IEF1ZyAyOCAw
NzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOiBQcmVzZW50OiAgIDB4MDFmODAwMDgg
fA0KPiA+ID4gSG9zdA0KPiA+ID4gPiA+IGN0bDogMHgwMDAwMDAzMQ0KPiA+ID4gPiA+ID4gQXVn
IDI4IDA3OjMyOjEyIGNzbW9uIGtlcm5lbDogbW1jMDogc2RoY2k6IFBvd2VyOiAgICAgMHgwMDAw
MDAwMiB8DQo+ID4gPiBCbGsNCj4gPiA+ID4gPiBnYXA6ICAweDAwMDAwMDAwDQo+ID4gPiA+ID4g
PiBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhjaTogV2FrZS11cDogICAw
eDAwMDAwMDAwDQo+IHwNCj4gPiA+ID4gPiBDbG9jazogICAgMHgwMDAwMDExZg0KPiA+ID4gPiA+
ID4gQXVnIDI4IDA3OjMyOjEyIGNzbW9uIGtlcm5lbDogbW1jMDogc2RoY2k6IFRpbWVvdXQ6ICAg
MHgwMDAwMDA4ZSB8DQo+ID4gPiBJbnQNCj4gPiA+ID4gPiBzdGF0OiAweDAwMDAwMDAwDQo+ID4g
PiA+ID4gPiBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhjaTogSW50IGVu
YWI6DQo+ID4gPiA+ID4gPiAweDEwN2YwMDBiIHwgU2lnDQo+ID4gPiA+ID4gPiBlbmFiOiAweDEw
N2YwMDBiIEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNkaGNpOg0KPiA+ID4g
PiA+ID4gQUNtZA0KPiA+ID4gc3RhdDoNCj4gPiA+ID4gPiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6
IDB4MDAwMDEyMDENCj4gPiA+ID4gPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1t
YzA6IHNkaGNpOiBDYXBzOiAgICAgIDB4MDdlYjAwMDAgfA0KPiA+ID4gPiA+IENhcHNfMTogICAw
eDA4MTAwODEwDQo+ID4gPiA+ID4gPiBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMw
OiBzZGhjaTogQ21kOiAgICAgICAweDAwMDAwZDFhIHwNCj4gPiA+ID4gPiBNYXggY3VycjogMHgw
MDAwMDAwMA0KPiA+ID4gPiA+ID4gQXVnIDI4IDA3OjMyOjEyIGNzbW9uIGtlcm5lbDogbW1jMDog
c2RoY2k6IFJlc3BbMF06ICAgMHgwMDQwMDkwMCB8DQo+ID4gPiA+ID4gUmVzcFsxXTogIDB4MDAw
MDAwMDANCj4gPiA+ID4gPiA+IEF1ZyAyOCAwNzozMjoxMiBjc21vbiBrZXJuZWw6IG1tYzA6IHNk
aGNpOiBSZXNwWzJdOiAgIDB4MDAwMDAwMDAgfA0KPiA+ID4gPiA+IFJlc3BbM106ICAweDAwMDAw
MDAwDQo+ID4gPiA+ID4gPiBBdWcgMjggMDc6MzI6MTIgY3Ntb24ga2VybmVsOiBtbWMwOiBzZGhj
aTogSG9zdCBjdGwyOg0KPiA+ID4gPiA+ID4gMHgwMDAwMDAwMCBBdWcNCj4gPiA+ID4gPiA+IDI4
IDA3OjMyOjEyIGNzbW9uIGtlcm5lbDogbW1jMDogc2RoY2k6IEFETUEgRXJyOiAgMHgwMDAwMDAw
MCB8DQo+ID4gPiA+ID4gPiBBRE1BDQo+ID4gPiA+ID4gPiBQdHI6IDB4ZWYwNDEyMDggQXVnIDI4
IDA3OjMyOjEyIGNzbW9uIGtlcm5lbDogbW1jMDogc2RoY2k6DQo+ID4gPiA+ID4gPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gU29tZSBleHRyYSBpbmZvcm1hdGlvbjogVGhlIHRpbWVvdXQgYWx3YXlzIGhhcyBjbWQgPSAw
eDAwMDAwZDFhDQo+ID4gPiA+ID4gKE1NQ19TRU5EX1NUQVRVUykgYW5kIHJlc3BbMF0gPSAweDAw
NDAwOTAwIHdpdGggcmVzcFswXQ0KPiA+ID4gPiA+IHRyYW5zbGF0aW5nIHRvIHRoaXMgSUlVSUM6
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCaXQgOCA9IFJlYWR5IGZvciBkYXRhDQo+ID4gPiA+ID4g
Qml0IDExID0gQ1VSUkVOVF9TVEFURSBpcyBUUkFODQo+ID4gPiA+ID4gQml0IDIyID0gSWxsZWdh
bCBjb21tYW5kDQo+ID4gPiA+DQo+ID4gPiA+IEFjY29yZGluZyB0byB0aGUgY29kZSBsb2dpYywg
c2luY2UgdGhpcyBjbWQxMyBnZXQgaGFyZHdhcmUgY21kDQo+ID4gPiA+IHRpbWVvdXQsIHdoaWNo
IG1lYW5zIHRoaXMgY21kMTMgZG8gbm90IGdldCBhbnkgcmVzcG9uc2UuIEhlcmUgdGhlDQo+ID4g
PiA+IFJlc3BbMF0gc2hvdWxkIGJlIHRoZSBwcmV2aW91cyBjb21tYW5kJ3MgcmVzcG9uc2UuDQo+
ID4gPiA+DQo+ID4gPiA+IFNvIHRoaXMgbWVhbnMgdGhlIHByZXZpb3VzIGNvbW1hbmQgaXMgYW4g
aWxsZWdhbCBjb21tYW5kLCBjYXVzZQ0KPiA+ID4gPiB0aGUgZW1tYyBpbnRlcm5hbCBmaXJtd2Fy
ZSBzdHVjaywgYW5kIGNhbid0IHJlc3BvbnNlIHRvIHRoZSBuZXh0IGNtZDEzLg0KPiA+ID4gPg0K
PiA+ID4gPiBJIHRoaW5rIHdlIG5lZWQgdG8gZmlyc3RseSBpZGVudGlmeSB0aGUgc3BlY2lmaWMg
cGxhY2UgaW4gZW1tYw0KPiA+ID4gPiBkcml2ZXIgd2hpY2ggdHJpZ2dlciB0aGUgbG9nIGR1bXAu
DQo+ID4gPg0KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcywgdGhhdCBhIG1pc3NpbmcgcmVzcG9u
c2UgZnJvbSB0aGUgZU1NQyBzaG91bGQNCj4gPiA+IHRyaWdnZXIgdGhlIENvbW1hbmQgVGltZW91
dCBFcnJvciBTdGF0dXMgSVJRIGluIGVTREhDIGFmdGVyIDY0IFNEQ0xLDQo+ID4gPiBjeWNsZXMg
KHNlZSBzZWN0aW9uIDMwLjcuMTAgW0VTREhDVjN4X0lSUVNUQVRdIGluIHRoZSBpLk1YNTMgcmVm
ZXJlbmNlDQo+IG1hbnVhbCkuDQo+ID4gPiA2NCBTRENMSyBjeWNsZXMgbWVhbnMsIHRoYXQgdGhp
cyBzaG91bGQgcmVjb3ZlciBxdWlja2x5IGFuZCB3b3VsZA0KPiA+ID4gbm90IGJlIGEgcHJvYmxl
bSBmb3IgbW9zdCB1c2VjYXNlcy4NCj4gPiA+DQo+ID4gPiBCdXQgd2hhdCB3ZSBhcmUgc2VlaW5n
IGlzIHRoZSBzb2Z0d2FyZSAxMCBzZWNvbmRzIHRpbWVvdXQuIE15DQo+ID4gPiB1bmRlcnN0YW5k
aW5nIGlzLCB0aGF0IHRoaXMgc2hvdWxkIG5vdCBiZSB0cmlnZ2VyZWQgaWYgdGhlIFNESENJDQo+
ID4gPiBjb250cm9sbGVyIHdvcmtzIGFzIGV4cGVjdGVkIChlLmcuIGJ5IGdlbmVyYXRpbmcgYSBJ
UlEgZm9yIHRoZQ0KPiA+ID4gdGltZW91dCkuIFRoaXMgdGltZW91dCBpcyBtdWNoIG1vcmUgcHJv
YmxlbWF0aWMsIHNpbmNlIGFsbCBlTU1DIGFjY2Vzc2luZw0KPiBwcm9jZXNzZXMgYmxvY2sgZm9y
IHRob3NlIDEwIHNlY29uZHMuDQo+ID4gPg0KPiA+DQo+ID4gQWdyZWUsIG9ubHkgb25lIHBvc3Np
YmlsaXR5LCB0aGUgY21kMTMgZG8gbm90IHNlbmQgb3V0IHN1Y2Nlc3NmdWxseS4NCj4gDQo+IEkg
dGhpbmsgdGhlcmUgYXJlIHR3byBwb3NzaWJpbGl0aWVzOg0KPiANCj4gMS4gVGhlIGNvbW1hbmQg
aXMgbm90IHNlbmQgb3V0LCBzbyBubyBJUlFzIGFyZSByZWNlaXZlZC4NCj4gMi4gVGhlIElSUSBn
ZXRzIGxvc3Qgb3IgaXMgbm90IGdlbmVyYXRlZA0KPiANCj4gVGhlIGVzZGhjX3dyaXRlbF9sZSgp
IGhhcyBhIHdvcmthcm91bmQgdG8gYXZvaWQgbWlzc2luZyB0aGUgY2FyZCBpcnEuIElmIHRoYXQN
Cj4gZG9lcyBub3QgZnVsbHkgZml4IHRoZSBpc3N1ZSwgSSB3b3VsZCBleHBlY3QgdGhlIFNXIGZh
bGxiYWNrIHRvIGFsc28gY292ZXIgdGhhdA0KPiBjYXNlLg0KPiANCj4gPiBUaGUgY291bnQgb2Yg
NjQgU0RDTEsgY3ljbGUgb25seSB0cmlnZ2VkIGJ5IHRoZSBlbmQgb2YgdGhlIHNlbmRpbmcNCj4g
PiBjb21tYW5kLiBJZiB0aGUgY29tbWFuZCBzdGlsbCBub3Qgc2VuZCBvdXQgY29tcGxldGVseSwg
dGhlbiBzaG91bGQNCj4gPiB0cmlnZ2VyIHRoZSAxMHMgc3cgdGltZW91dC4gTGV0IG1lIGRvdWJs
ZSBjb25maXJtIHdpdGggb3VyIElDIHRlYW0uDQo+IA0KPiBBY2suDQo+IA0KPiA+IEkgc3RpbGwg
c3VnZ2VzdCB0aGF0IHdlIG5lZWQgZmlyc3QgdG8gZmluZCB3aGljaCBjbWQxMyBpbiBvdXIgbW1j
DQo+ID4gZHJpdmVyIG1lZXQgdGhpcyBpc3N1ZS4NCj4gDQo+IFdlIHdpbGwgdHJ5IHRvIGZpZ3Vy
ZSB0aGF0IG91dCBhbmQgcmVwb3J0IGJhY2suIE5lZWRzIGEgYml0IG9mIHRpbWUsIHNpbmNlIHRo
ZQ0KPiBlcnJvciBvbmx5IGFwcGVhcnMgYWZ0ZXIgc29tZSBob3VycyBvbiBhbiBhZmZlY3RlZCBr
ZXJuZWwgYW5kIGFkZGluZyB0aGUNCj4gbmVjZXNzYXJ5IGNvZGUgcG90ZW50aWFsbHkgaGlkZXMg
dGhlIHByb2JsZW0gZHVlIHRvIHRoZSBhbGlnbm1lbnQgY2hhbmdlcw0KPiByZXF1aXJpbmcgYW5v
dGhlciBydW4gd2l0aCBwYWRkaW5nIG5vcHMuDQo+IA0KPiAtLSBTZWJhc3RpYW4NCg0KSSBjaGFu
Z2VkIHRoZSBzb2Z0d2FyZSBzbyB0aGF0IGl0IGdlbmVyYXRlcyBhIGJhY2sgdHJhY2Ugd2hlbiB0
aGUgdGltZW91dCBvY2N1cnMNCmFuZCBJIGhhZCB0byBwYWQgd2l0aCBhIGZldyBOT1AgaW5zdHJ1
Y3Rpb25zIGFnYWluIHRvIGdldCB0aGUgdGltZW91dHMgdG8gb2NjdXIuDQoNCkkgcnVuIHRoZSBz
b2Z0d2FyZSBvbiB0d28gdW5pdHMgYW5kIGdvdCBhbGwgdG9nZXRoZXIgMjIgdGltZW91dHMgZHVy
aW5nIDIgZGF5cy4gIEFsbA0KYmFjayB0cmFjZXMgd2VyZSBzYW1lIGFzIGJlbG93OiAgDQoNClsg
MjE3OC40MDUzMzhdIG1tYzA6IFRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgY21kIGludGVy
cnVwdC4NClsgMjE3OC40MDUzNTRdIG1tYzA6IHNkaGNpOiA9PT09PT09PT09PT0gU0RIQ0kgUkVH
SVNURVIgRFVNUCA9PT09PT09PT09PQ0KWyAyMTc4LjQwNTM2N10gbW1jMDogc2RoY2k6IFN5cyBh
ZGRyOiAgMHhlNWYxYTAwMCB8IFZlcnNpb246ICAweDAwMDAxMjAxDQpbIDIxNzguNDA1Mzc0XSBt
bWMwOiBzZGhjaTogQmxrIHNpemU6ICAweDAwMDAwMjAwIHwgQmxrIGNudDogIDB4MDAwMDAwMDEN
ClsgMjE3OC40MDUzODBdIG1tYzA6IHNkaGNpOiBBcmd1bWVudDogIDB4MDAwMTAwMDAgfCBUcm4g
bW9kZTogMHgwMDAwMDAwMA0KWyAyMTc4LjQwNTM4OV0gbW1jMDogc2RoY2k6IFByZXNlbnQ6ICAg
MHgwMWY4MDAwOCB8IEhvc3QgY3RsOiAweDAwMDAwMDMxDQpbIDIxNzguNDA1Mzk1XSBtbWMwOiBz
ZGhjaTogUG93ZXI6ICAgICAweDAwMDAwMDAyIHwgQmxrIGdhcDogIDB4MDAwMDAwMDANClsgMjE3
OC40MDU0MDFdIG1tYzA6IHNkaGNpOiBXYWtlLXVwOiAgIDB4MDAwMDAwMDAgfCBDbG9jazogICAg
MHgwMDAwMDExZg0KWyAyMTc4LjQwNTQwN10gbW1jMDogc2RoY2k6IFRpbWVvdXQ6ICAgMHgwMDAw
MDA4ZSB8IEludCBzdGF0OiAweDAwMDAwMDAwDQpbIDIxNzguNDA1NDEzXSBtbWMwOiBzZGhjaTog
SW50IGVuYWI6ICAweDEwN2YwMDBiIHwgU2lnIGVuYWI6IDB4MTA3ZjAwMGINClsgMjE3OC40MDU0
MjBdIG1tYzA6IHNkaGNpOiBBQ21kIHN0YXQ6IDB4MDAwMDAwMDAgfCBTbG90IGludDogMHgwMDAw
MTIwMQ0KWyAyMTc4LjQwNTQyNl0gbW1jMDogc2RoY2k6IENhcHM6ICAgICAgMHgwN2ViMDAwMCB8
IENhcHNfMTogICAweDA4MTAwODEwDQpbIDIxNzguNDA1NDMyXSBtbWMwOiBzZGhjaTogQ21kOiAg
ICAgICAweDAwMDAwZDFhIHwgTWF4IGN1cnI6IDB4MDAwMDAwMDANClsgMjE3OC40MDU0MzhdIG1t
YzA6IHNkaGNpOiBSZXNwWzBdOiAgIDB4MDA0MDA5MDAgfCBSZXNwWzFdOiAgMHgwMDAwMDAwMA0K
WyAyMTc4LjQwNTQ0NF0gbW1jMDogc2RoY2k6IFJlc3BbMl06ICAgMHgwMDAwMDAwMCB8IFJlc3Bb
M106ICAweDAwMDAwMDAwDQpbIDIxNzguNDA1NDQ5XSBtbWMwOiBzZGhjaTogSG9zdCBjdGwyOiAw
eDAwMDAwMDAwDQpbIDIxNzguNDA1NDU2XSBtbWMwOiBzZGhjaTogQURNQSBFcnI6ICAweDAwMDAw
MDAwIHwgQURNQSBQdHI6IDB4ZWYwNDEyMDgNClsgMjE3OC40MDU0NjBdIG1tYzA6IHNkaGNpOiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KWyAyMTc4LjQwNTY4
MV0gQ1BVOiAwIFBJRDogMTQwIENvbW06IGt3b3JrZXIvMDo0SCBOb3QgdGFpbnRlZCA1LjguMyAj
MQ0KWyAyMTc4LjQwNTY4OV0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGkuTVg1MyAoRGV2aWNl
IFRyZWUgU3VwcG9ydCkNClsgMjE3OC40MDU3MTVdIFdvcmtxdWV1ZTogbW1jX2NvbXBsZXRlIG1t
Y19ibGtfbXFfY29tcGxldGVfd29yaw0KWyAyMTc4LjQwNTcyM10gQmFja3RyYWNlOiANClsgMjE3
OC40MDU3NDVdIFs8ODAxMGUwYmM+XSAoZHVtcF9iYWNrdHJhY2UpIGZyb20gWzw4MDEwZTQ4MD5d
IChzaG93X3N0YWNrKzB4MjAvMHgyNCkNClsgMjE3OC40MDU3NTVdICByNzowMDAwMDAwNSByNjoy
MDBiMDAxMyByNTowMDAwMDAwMCByNDo4MGY0NmZmNA0KWyAyMTc4LjQwNTc3NV0gWzw4MDEwZTQ2
MD5dIChzaG93X3N0YWNrKSBmcm9tIFs8ODA0NmMwMjQ+XSAoZHVtcF9zdGFjaysweGE0LzB4Yjgp
DQpbIDIxNzguNDA1Nzk1XSBbPDgwNDZiZjgwPl0gKGR1bXBfc3RhY2spIGZyb20gWzw4MDc2NTg5
MD5dIChtbWNfd2FpdF9mb3JfY21kKzB4OTQvMHhkMCkNClsgMjE3OC40MDU4MDRdICByNzowMDAw
MDAwNSByNjo4MGYwNGY0OCByNTowMDAwMDAwMCByNDplZDdhYmUxNA0KWyAyMTc4LjQwNTgxN10g
Wzw4MDc2NTdmYz5dIChtbWNfd2FpdF9mb3JfY21kKSBmcm9tIFs8ODA3NmMzMzg+XSAoX19tbWNf
c2VuZF9zdGF0dXMrMHg3OC8weGE4KQ0KWyAyMTc4LjQwNTgyNl0gIHI4OjAwMDAwMDAwIHI3OjAw
MDAwMDA1IHI2OmVkN2FiZTY4IHI1OmVlMTM3ODAwIHI0OjgwZjA0ZjQ4DQpbIDIxNzguNDA1ODQ0
XSBbPDgwNzZjMmMwPl0gKF9fbW1jX3NlbmRfc3RhdHVzKSBmcm9tIFs8ODA3NzVkN2M+XSAoY2Fy
ZF9idXN5X2RldGVjdCsweDVjLzB4ZjgpDQpbIDIxNzguNDA1ODUzXSAgcjc6ZWUxMzc4MDAgcjY6
MDAwMmRkYmEgcjU6ODBmMDNkMDAgcjQ6MDAwMmQ5ZDINClsgMjE3OC40MDU4NjRdIFs8ODA3NzVk
MjA+XSAoY2FyZF9idXN5X2RldGVjdCkgZnJvbSBbPDgwNzc4ZDY4Pl0gKG1tY19ibGtfbXFfY29t
cGxldGVfcHJldl9yZXEucGFydC40KzB4MTU0LzB4MjU0KQ0KWyAyMTc4LjQwNTg3NF0gIHIxMDpl
ZTEzNzgwMCByOTplZTMwMzRhOCByODowMDAwMDAwMCByNzplZTIxZWVjNCByNjo4MGYwNGY0OCBy
NTplZTMwMzQwMA0KWyAyMTc4LjQwNTg3OV0gIHI0OmVlMjFlZTA4DQpbIDIxNzguNDA1ODg5XSBb
PDgwNzc4YzE0Pl0gKG1tY19ibGtfbXFfY29tcGxldGVfcHJldl9yZXEucGFydC40KSBmcm9tIFs8
ODA3Nzk3MDQ+XSAobW1jX2Jsa19tcV9jb21wbGV0ZV93b3JrKzB4MzAvMHgzNCkNClsgMjE3OC40
MDU4OTldICByMTA6ODBmYWFhNTAgcjk6MDAwMDAwMDAgcjg6MDAwMDAwMDAgcjc6ZWVmZTQ4MDAg
cjY6ZWVmZGNiMDAgcjU6ZWQ1YTQ3MDANClsgMjE3OC40MDU5MDVdICByNDplZTIxZWVkOA0KWyAy
MTc4LjQwNTkxN10gWzw4MDc3OTZkND5dIChtbWNfYmxrX21xX2NvbXBsZXRlX3dvcmspIGZyb20g
Wzw4MDE0MjIxYz5dIChwcm9jZXNzX29uZV93b3JrKzB4MjM4LzB4NTkwKQ0KWyAyMTc4LjQwNTky
Nl0gWzw4MDE0MWZlND5dIChwcm9jZXNzX29uZV93b3JrKSBmcm9tIFs8ODAxNDJhMjA+XSAod29y
a2VyX3RocmVhZCsweDYwLzB4NWI4KQ0KWyAyMTc4LjQwNTkzNl0gIHIxMDplZWZkY2IwMCByOTo4
MGYwM2QwMCByODplZWZkY2IxOCByNzowMDAwMDAwOCByNjplZWZkY2IwMCByNTplZDVhNDcxNA0K
WyAyMTc4LjQwNTk0MV0gIHI0OmVkNWE0NzAwDQpbIDIxNzguNDA1OTU2XSBbPDgwMTQyOWMwPl0g
KHdvcmtlcl90aHJlYWQpIGZyb20gWzw4MDE0OTU3Yz5dIChrdGhyZWFkKzB4MTcwLzB4MTc0KQ0K
WyAyMTc4LjQwNTk2Nl0gIHIxMDplZDkyZGU3NCByOTplZDVhNDcwMCByODo4MDE0MjljMCByNzpl
ZDdhYTAwMCByNjowMDAwMDAwMCByNTplZGJkOGFjMA0KWyAyMTc4LjQwNTk3MV0gIHI0OmVkYTY3
MTgwDQpbIDIxNzguNDA1OTgyXSBbPDgwMTQ5NDBjPl0gKGt0aHJlYWQpIGZyb20gWzw4MDEwMDEy
OD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyYykNClsgMjE3OC40MDU5ODldIEV4Y2VwdGlvbiBz
dGFjaygweGVkN2FiZmIwIHRvIDB4ZWQ3YWJmZjgpDQpbIDIxNzguNDA1OTk3XSBiZmEwOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMA0KWyAyMTc4LjQwNjAwN10gYmZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANClsgMjE3OC40
MDYwMTVdIGJmZTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEz
IDAwMDAwMDAwDQpbIDIxNzguNDA2MDI3XSAgcjEwOjAwMDAwMDAwIHI5OjAwMDAwMDAwIHI4OjAw
MDAwMDAwIHI3OjAwMDAwMDAwIHI2OjAwMDAwMDAwIHI1OjgwMTQ5NDBjDQpbIDIxNzguNDA2MDMy
XSAgcjQ6ZWRiZDhhYzANCg0KLUNsYXVzLQ0KDQo+IA0KPiA+ID4gPiA+ID4gVGltZW91dHMgZG8g
bm90IG9jY3VyIHdpdGggZXZlcnkgYnVpbGQuIEFmdGVyIHNvbWUgZGVidWdnaW5nIEkNCj4gPiA+
ID4gPiA+IGhhdmUgZm91bmQgdGhhdCB0aW1lb3V0cyBzZWVtIHRvIGRlcGVuZCBvbiBjb2RlIGFs
aWdubWVudCBvZg0KPiA+ID4gPiA+ID4gdGhlIGVzZGhjX3JlYWRsX2xlIGZ1bmN0aW9uLiBJIGhh
dmUgYmlzZWN0ZWQgdGhlIGJlaGF2aW9yIGJ5DQo+ID4gPiA+ID4gPiB1c2luZyB0aGUgU3lzdGVt
Lm1hcCBhbmQgbW92aW5nL3BhZGRpbmcgdGhlIGNvZGUgd2l0aCBOT1ANCj4gPiA+ID4gPiA+IGlu
c3RydWN0aW9ucyAobW92IHIwLHIwKS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBNeSB0ZXN0
IGNhc2UgaGFzIDUgcHJvY2Vzc2VzIGNvbnRpbnVvdXNseSBjcmVhdGluZyBhIGZpbGUsDQo+ID4g
PiA+ID4gPiB3cml0aW5nIHJhbmRvbSBsb25nIGRhdGEsIHJlYWRpbmcgZGF0YSBhbmQgZGVsZXRp
bmcgdGhlIGZpbGUuDQo+ID4gPiA+ID4gPiBJdCBzZWVtcyB0aGF0IHdoZW4gdGhlIGVzZGhjX3dy
aXRlbF9sZSBpcyBhbGlnbmVkIG9uIGEgY2VydGFpbg0KPiA+ID4gPiA+ID4gYWRkcmVzcyB0aGVu
IHRoZSB0aW1lb3V0IHdpbGwgb2NjdXIgYWJvdXQgNSB0aW1lcy8xMmggdXNpbmcgbXkNCj4gPiA+
ID4gPiA+IHRlc3QgY2FzZS4gSWYgSSBhZGQgb25lIG1vcmUgTk9QLCB0aGUgdGltZW91dCB3aWxs
IG5vdCBvY2N1cg0KPiA+ID4gPiA+ID4gYXQgYWxsLiBJZiBJIGNvbnRpbnVlIGFkZGluZyBzb21l
IG1vcmUgTk9QcyB0aGUgdGltZW91dHMgY29tZQ0KPiA+ID4gPiA+ID4gYmFjay4gU2VlbXMgdGhh
dCBpdCBkb2Vzbid0IG1hdHRlciB3aGVyZSBpbiB0aGUgY29kZSBJIGFkZA0KPiA+ID4gPiA+ID4g
Tk9QcyBhcyBsb25nIGFzIHRoZSBhZGRyZXNzIGlzIGJlbG93IHRoZSBhZGRyZXNzIG9mIGVzZGhj
X3dyaXRlbF9sZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBhbHNvIHJ1biB0aGUgc2Ft
ZSBzb2Z0d2FyZSBvbiBhIGR1YWwgY29yZSBpLk1YNiB3aXRob3V0IGFueQ0KPiA+ID4gPiA+ID4g
dGltZW91dCBpc3N1ZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbmQgdGhlIHNhbWUga2VybmVs
IGJpbmFyeSBpcyBhbHNvIHVzZWQgb24gYW4gaS5NWDYgc2luZ2xlIGNvcmUNCj4gPiA+ID4gPiAo
YWxiZWl0IHdpdGggZGlmZmVyZW50IFNXKSB3aXRob3QgdHJpZ2dlcmluZyB0aGUgcHJvYmxlbSBz
byBmYXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgaGF2ZSByZXByb2R1Y2VkIHRoaXMgd2l0
aCBrZXJuZWwgdmVyc2lvbiA0LjE5Ljk0IGFuZCA1LjguMw0KPiA+ID4gPiA+ID4gYW5kIHdlIGhh
dmUgY29tcGlsZWQgd2l0aCBib3RoIGdjYzggYW5kIGdjYzkuIEknbSBzdGlsbA0KPiA+ID4gPiA+
ID4gc2VhcmNoaW5nIGZvciB0aGUgcm9vdCBjYXVzZSBhbmQgSSB3b3VsZCBhcHByZWNpYXRlIGFu
eQ0KPiA+ID4gPiA+ID4gdGhvdWdodHMgYWJvdXQgd2hlcmUgdG8gZ28NCj4gPiA+IG5leHQuDQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IC1DbGF1cy0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRvIG1lIGl0IGxvb2tzIGxpa2UgaXQgbWln
aHQgaW52b2x2ZSBhbiB1bmtub3duIGhhcmR3YXJlIGVycmF0YQ0KPiA+ID4gPiA+IGZvciBpLk1Y
NTMsIGJ1dCB0aGVyZSBoYXMgYmVlbiBvbmUgc2ltaWxhciByZXBvcnQgYmVmb3JlDQo+ID4gPiA+
ID4gKHVuZm9ydHVuYXRlbHkgd2l0aG91dCB0aGUgZnVsbCByZWdpc3RlciBkdW1wKSBpbnZvbHZp
bmcgdmlydHVhbGl6YXRpb246DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzEwNzA1ODIzLw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTm90ZSwg
dGhhdCBDbGF1cycga2VybmVsIGhhcyBiZWVuIGJ1aWx0IHdpdGggQ09ORklHX1BSRUVNUFRfTk9O
RT15Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLS0gU2ViYXN0aWFuDQo=
