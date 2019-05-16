Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF442103C
	for <lists+linux-mmc@lfdr.de>; Thu, 16 May 2019 23:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEPVnQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 16 May 2019 17:43:16 -0400
Received: from mail-eopbgr770109.outbound.protection.outlook.com ([40.107.77.109]:35910
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbfEPVnQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 May 2019 17:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zpbfwSZOjfieyDGJIecyaUXs0Yz5vv8bXEc6DBOLVk=;
 b=AoZW2L+uUDf2koFO1M7Dw1zTfdyRvhmcoObiCbHE+G6Yoy9ve5LKm+Np+IQH7VdMTD7GnUQgpUmhZ4eM8dSurRBb+Ciht/R6FWYKGb9EVfKeKHRdIvEXAXMzkEQ0HMrZUCyweRT6gr83p3azQQLnOzwK+6wwAU9RvL87LBRd/jk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3691.namprd06.prod.outlook.com (10.167.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 21:42:31 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::88d1:40e0:d1be:1daf]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::88d1:40e0:d1be:1daf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 21:42:31 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "yinbo.zhu@nxp.com" <yinbo.zhu@nxp.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "xiaobo.xie@nxp.com" <xiaobo.xie@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "jimmy.zhao@nxp.com" <jimmy.zhao@nxp.com>
Subject: Re: [PATCH v5 4/5] mmc: sdhci-of-esdhc: add erratum eSDHC7 support
Thread-Topic: [PATCH v5 4/5] mmc: sdhci-of-esdhc: add erratum eSDHC7 support
Thread-Index: AQHVDDBDBTbJP70190OUgT7UO1nGmg==
Date:   Thu, 16 May 2019 21:42:31 +0000
Message-ID: <1558042950.4229.153.camel@impinj.com>
References: <20190311021814.42326-1-yinbo.zhu@nxp.com>
         <20190311021814.42326-4-yinbo.zhu@nxp.com>
In-Reply-To: <20190311021814.42326-4-yinbo.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72c05f6-d28f-4dda-ece0-08d6da47664a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR0601MB3691;
x-ms-traffictypediagnostic: MWHPR0601MB3691:
x-microsoft-antispam-prvs: <MWHPR0601MB36910454ED4ABED2443855E6D30A0@MWHPR0601MB3691.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(396003)(136003)(39850400004)(346002)(189003)(199004)(229853002)(6486002)(68736007)(99286004)(6512007)(4326008)(25786009)(86362001)(2201001)(110136005)(54906003)(6246003)(316002)(14454004)(53936002)(478600001)(6436002)(103116003)(76176011)(8936002)(8676002)(81166006)(81156014)(66066001)(7736002)(476003)(446003)(36756003)(2906002)(14444005)(11346002)(26005)(102836004)(186003)(305945005)(256004)(2616005)(66476007)(66556008)(5660300002)(64756008)(66446008)(71190400001)(71200400001)(6116002)(3846002)(66946007)(73956011)(2501003)(6506007)(486006)(91956017)(76116006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3691;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7/PFk/5oD75JOO3BiJKwa4u6V5/cznwQgVeo8PcDIpg0rJtS4H6WIm9Gi/Viih05IjWWVjtyRv47BO6yltikpOdrc6CrskNuOISgZUeo4UCjhJ3E2c3luDJsCco+VEgNgh5du9cwG540VWeK+DLhPlaz4dZt/veYXF9M9EjzlmvJWrmIleTNAUpy6JY3JUG+l7RejU7PxDbNu+nuQZqdBrXNfVS3rQw7b1W+lFeeGSehfRILzEDOA0WPQBE6uUJ5Uw+7m9fdnpl3jM53NZG31rX7K7i4ZyXvr9P8zRCf+Pwj74lvRYiVMvDz8PKYOyRFcbDhTg45S2AXaFy0mudiaPJBBKn5mNEH06PHsP6XvthM645PD4mMzqJoLlpRuaYEaO7aGdPCwmc9RwMFxddHXOg9pZWq3SqQ79282SXrgjc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF97FBC1B5E18047BBCBFBE35C638730@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72c05f6-d28f-4dda-ece0-08d6da47664a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 21:42:31.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3691
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTExIGF0IDAyOjE2ICswMDAwLCBZaW5ibyBaaHUgd3JvdGU6DQo+IEZy
b206IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQo+IA0KPiBJbnZhbGlkIFRyYW5zZmVy
IENvbXBsZXRlIChJUlFTVEFUW1RDXSkgYml0IGNvdWxkIGJlIHNldCBkdXJpbmcNCj4gbXVsdGkt
d3JpdGUgb3BlcmF0aW9uIGV2ZW4gd2hlbiB0aGUgQkxLX0NOVCBpbiBCTEtBVFRSIHJlZ2lzdGVy
DQo+IGhhcyBub3QgcmVhY2hlZCB6ZXJvLiBUaGVyZWZvcmUsIFRyYW5zZmVyIENvbXBsZXRlIG1p
Z2h0IGJlDQo+IHJlcG9ydGVkIHR3aWNlIGR1ZSB0byB0aGlzIGVycmF0dW0gc2luY2UgYSB2YWxp
ZCBUcmFuc2ZlciBDb21wbGV0ZQ0KPiBvY2N1cnMgd2hlbiBCTEtfQ05UIHJlYWNoZXMgemVyby4g
VGhpcyBlcnJhdHVtIGlzIHRvIGZpeCB0aGlzIGlzc3VlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZ
aW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgaW4gdjU6DQo+IAkJd3Jp
dGUgU0RIQ0lfSU5UX0RBVEFfRU5EIHRvIFNESENJX0lOVF9TVEFUVVMgdG8gY2xlYXIgaXQNCj4g
DQo+ICANCj4gK3N0YXRpYyB1MzIgZXNkaGNfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1
MzIgaW50bWFzaykNCj4gK3sNCj4gKwl1MzIgY29tbWFuZDsNCj4gKw0KPiArCWlmIChvZl9maW5k
X2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLA0KPiArCQkJCSJmc2wscDIwMjAtZXNkaGMiKSkg
ew0KDQpUaGlzIHNjYW5zIHRoZSBlbnRpcmUgZGV2aWNlIHRyZWUgZm9yIGFueSBub2RlcyBtYXRj
aGluZyB0aGlzLiAgT24NCmV2ZXJ5IGlycS4gIEluIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCg0K
VGhhdCdzIG51dHMhDQoNCkZpcnN0bHksIHdoeSBzY2FuIHRoZSBlbnRpcmUgZGV2aWNlIHRyZWUh
ICBJdCBzZWVtcyBsaWtlIGFsbCB0aGVzZQ0Kb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwg
TlVMTCwgLi4uKSBjYWxscyBhcmUgd3JvbmcuICBEb24ndCB5b3UNCndhbnQgdG8ga25vdyBpZiAq
dGhpcyogaG9zdCBpcyBhbiBmc2wscDIwMjAtZXNkaGM/ICBOb3QgaWYgYW55IG9mDQpmc2wscDIw
MjAtZXNkaGMgaG9zdHMgZXhpc3QsIGV2ZW4gaWYgdGhpcyBpc24ndCBvbmU/DQoNClRoaXMgd291
bGQgYmUgZmFyIGJldHRlciBkb25lIHdpdGg6DQpvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYt
Pm9mX25vZGUsICJmc2wsZnNsLHAyMDIwLWVzZGhjIikNCg0KVGhlcmUgaXMgYSBtYXRjaCB0YWJs
ZSBpbiB0aGUgZHJpdmVyOg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc2RoY2lf
ZXNkaGNfb2ZfbWF0Y2hbXSA9IHsNCiAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIx
YS1lc2RoYyIsIC5kYXRhID0gJmxzMTAyMWFfZXNkaGNfY2xrfSwNCiAgICAgICAgeyAuY29tcGF0
aWJsZSA9ICJmc2wsbHMxMDQ2YS1lc2RoYyIsIC5kYXRhID0gJmxzMTA0NmFfZXNkaGNfY2xrfSwN
Cg0KYW5kIHNvIG9uLiAgV2hhdCB5b3Ugc2hvdWxkIGRvIGlzIGFkZCBhbiBlbnRyeSBmb3IgcDIw
MjAgYW5kIGdpdmUgaXQNCnNvbWUgcGxhdGZvcm0gZGF0YSB0aGF0IGluZGljYXRlcyBpdCBoYXMg
dGhlc2UgcXVpcmtzLg0KDQpUaGUgaXJxIGhhbmRsZXIgc2hvdWxkIG5vdCBiZSBsb29raW5nIGF0
IHRoZSBkZXZpY2UgdHJlZSBvbiBlYWNoIElSUS4gDQpDaGVjayBhIGJpdCBmbGFnIGluIHRoZSBk
cml2ZXIncyBzdGF0ZSBkYXRhLg0KDQpTaW5jZSB5b3Uga25vdyBpZiB0aGlzIGlycSBjYWxsYmFj
ayBpcyBuZWVkZWQgb3Igbm90IGJlZm9yZSB0aGUgZGV2aWNlDQppcyByZWdpc3RlcmVkLCBpdCB3
b3VsZCBiZSBldmVuIG1vcmUgZWZmaWNpZW50IHRvIHNpbXBsZSBub3QgdXNlIGl0IG9uDQphIG5v
bi1wMjAyMC4gIEkuZS4sIHNldCBvcHMtPmlycSB0byB0aGlzIGhhbmRsZXIgZnVuY3Rpb24gb24g
cDIwMjAgYW5kDQpzZXQgaXQgdG8gTlVMTCBvbiBvdGhlciBkZXZpY2VzLiAgVGhhdCB3YXkgaXQg
bmV2ZXIgZXZlbiBnZXRzIGNhbGxlZC4NCg0KDQo+ICsJCWNvbW1hbmQgPSBTREhDSV9HRVRfQ01E
KHNkaGNpX3JlYWR3KGhvc3QsDQo+ICsJCQkJCVNESENJX0NPTU1BTkQpKTsNCj4gKwkJaWYgKGNv
bW1hbmQgPT0gTU1DX1dSSVRFX01VTFRJUExFX0JMT0NLICYmDQo+ICsJCQkJc2RoY2lfcmVhZHco
aG9zdCwgU0RIQ0lfQkxPQ0tfQ09VTlQpICYmDQo+ICsJCQkJaW50bWFzayAmIFNESENJX0lOVF9E
QVRBX0VORCkgew0KPiArCQkJaW50bWFzayAmPSB+U0RIQ0lfSU5UX0RBVEFfRU5EOw0KPiArCQkJ
c2RoY2lfd3JpdGVsKGhvc3QsIFNESENJX0lOVF9EQVRBX0VORCwNCj4gKwkJCQkJU0RIQ0lfSU5U
X1NUQVRVUyk7DQo+ICsJCX0NCj4gKwl9DQo+ICsJcmV0dXJuIGludG1hc2s7DQo+ICt9DQo+ICsN
Cj4gICNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gIHN0YXRpYyB1MzIgZXNkaGNfcHJvY3RsOw0K
PiAgc3RhdGljIGludCBlc2RoY19vZl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gQEAg
LTkxNCw2ICs5MzQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9lc2Ro
Y19iZV9vcHMgPSB7DQo+ICAJLnNldF9idXNfd2lkdGggPSBlc2RoY19wbHRmbV9zZXRfYnVzX3dp
ZHRoLA0KPiAgCS5yZXNldCA9IGVzZGhjX3Jlc2V0LA0KPiAgCS5zZXRfdWhzX3NpZ25hbGluZyA9
IGVzZGhjX3NldF91aHNfc2lnbmFsaW5nLA0KPiArCS5pcnEgPSBlc2RoY19pcnEsDQo+ICB9Ow0K
PiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9lc2RoY19sZV9vcHMg
PSB7DQo+IEBAIC05MzEsNiArOTUyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9vcHMg
c2RoY2lfZXNkaGNfbGVfb3BzID0gew0KPiAgCS5zZXRfYnVzX3dpZHRoID0gZXNkaGNfcGx0Zm1f
c2V0X2J1c193aWR0aCwNCj4gIAkucmVzZXQgPSBlc2RoY19yZXNldCwNCj4gIAkuc2V0X3Voc19z
aWduYWxpbmcgPSBlc2RoY19zZXRfdWhzX3NpZ25hbGluZywNCj4gKwkuaXJxID0gZXNkaGNfaXJx
LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhIHNk
aGNpX2VzZGhjX2JlX3BkYXRhID0gew==
