Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E34A9E70
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfIEJeD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 05:34:03 -0400
Received: from mail-eopbgr740108.outbound.protection.outlook.com ([40.107.74.108]:25132
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731084AbfIEJeC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Sep 2019 05:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7VsDSwFxNMEB7D+nIAPSEYKUoJ4UZu8yzfbKVERd6S6ZK2RsfCPHOPxh/xJQnVylFAjzJCQQiRYOdkhYOVZBll4UVPZnE4YwhtIuxP0Ck1GvG+UA7h1qgKTkQh77Wf7hHVJXFtlVChFj76RX88gW/XJWolOfPuU9Jo5FOE3NoPGr7SD5wqoppqESZXyN6t9mTds9Lvlrpd34ugZ4adHMxRy9IaAYstWqUEzvWU22A/Mk9FtRwTCifPk9QaWgGOC2htdBRpuT6OveTsmZxGZcoujDPb6J39l/Ri5kIChzgx7Z7FEjbcqDa/kyBiN8If/3w12kRg+6Ezgln+QNADaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFcYz8DAbkvUmOBJilM6uGcd5hT1x/JpMrcXzzFkZlY=;
 b=DywrXttThXXYQo7M+Y32OUDxAXjk6ZyQfexOUfZgx0p0k5xmX7E+jpFp+ex/In9PRgWeQs5pK6G5XONUoVRnsFXITOUqkGH7sujZZFxVCj/tvl6Fidp2s5TF9fuciF1SWJBdsTgrtD2Z3Jt23rKUZ3zGh0Or8jBfSMWwDzC/TsFIPPwKys+d89BE4u7Zvqp7pTsa5ov8HIyur0596Vk7cHl4ysBh+p3S0V2txRMEWDZw4ZxHokVVGtFYY22QKKdBz4H+vOWYXTws3CwqmtempGCbfOKrc+qK7+MmXsrEEc3P02b2vcLqfV2GyE9764V9ujqjXR8tt5wk5AZL/LZIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFcYz8DAbkvUmOBJilM6uGcd5hT1x/JpMrcXzzFkZlY=;
 b=YMCzH6xrZys/On2gXlyccAUfA2uExc+4AviZIjr4wjXPdbgvBETEVjU5bMBUS8+pg1ByyUaM2Dp1G3UN4TIrHl95LasiznqLc4nFsD+xTAjfSMLwLKc2QGjnVfw+PASAt1NLNNtdZpNbemE7Z3U34PilbRr4DOB+MP7jlP7Rzm8=
Received: from CH2PR16MB3479.namprd16.prod.outlook.com (10.255.155.220) by
 CH2PR16MB3573.namprd16.prod.outlook.com (52.132.247.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 5 Sep 2019 09:33:19 +0000
Received: from CH2PR16MB3479.namprd16.prod.outlook.com
 ([fe80::54da:5603:acb1:9538]) by CH2PR16MB3479.namprd16.prod.outlook.com
 ([fe80::54da:5603:acb1:9538%2]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 09:33:19 +0000
From:   "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
To:     Daniel Drake <drake@endlessm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Subject: RE: [PATCH] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD
 host controller"
Thread-Topic: [PATCH] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD
 host controller"
Thread-Index: AdVjy66YNfeWhyZcQsKqEJvYpevQOw==
Date:   Thu, 5 Sep 2019 09:33:19 +0000
Message-ID: <CH2PR16MB3479DFF5DE7E598252E76CC4E5BB0@CH2PR16MB3479.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
x-originating-ip: [58.48.115.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1600d68d-4fba-4c4f-31b2-08d731e41660
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CH2PR16MB3573;
x-ms-traffictypediagnostic: CH2PR16MB3573:
x-microsoft-antispam-prvs: <CH2PR16MB3573F436F9AB56F23F0FED74E5BB0@CH2PR16MB3573.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39840400004)(376002)(346002)(199004)(189003)(186003)(81166006)(508600001)(2501003)(4326008)(110136005)(54906003)(14444005)(86362001)(14454004)(74316002)(81156014)(25786009)(7696005)(6506007)(53936002)(6246003)(8676002)(316002)(33656002)(66066001)(229853002)(99286004)(71190400001)(71200400001)(102836004)(26005)(6436002)(7736002)(64756008)(8936002)(66946007)(6116002)(66476007)(66556008)(66446008)(2906002)(55016002)(476003)(486006)(256004)(5660300002)(52536014)(305945005)(3846002)(76116006)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR16MB3573;H:CH2PR16MB3479.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AjFL3MmSPKZ6xHOc8SWIgO9NCQoqLQWRNUNWXJv0leesw+4+y9snUr1631Lm5PDiMIqLcBkiLcJ3u3+5lVI/icD0lPCvTdwzfpeylatGu61mDt43hqtWEtSzbvAz+rKHV/v+3lUGBWUBJHFpz1gLKZ9pizo+SYX9M5liTafEa2eWBG9zdiaT90fEla4cSZZPNhcsDod1WzAsC5086MytPDjHI904y2qgXfkSn8qbw9+hpnj3iZ8yTMHBc8Z8hkGWFrcSZP3K9JsA7aPUUlGxxghbFsZ3sr+GLXvFWztAlKEBwX8s9/nKzK3WeIAYmAAZIzD0v071AKPmKkFXUvX1JXzwx47ZDgtdB7Hrk+sZDMQWT+b5A9HldiKo9FnnJx3Wf2rljmAgOpzEcGofW351wt44kV72t/0dnCfTrc4UI+8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1600d68d-4fba-4c4f-31b2-08d731e41660
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 09:33:19.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naBOGBFjjaUCo9Bddcw2wIpMd7BgENsV12aORR6IkhXyjrVcoDgNLnK/PeiYzkD8IXVx7ag/V80+TLsC+ltZoNkO90NZ1uYug1GRs2vrHFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR16MB3573
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgRGFuaWVsLA0KCUkgc3VnZ2VzdGlvbiB0aGF0IHlvdSBzZXQgUENSKFBDSSBDb25maWd1cmF0
aW9uIFJlZ2lzdGVyKSAweDMwOCBiaXQ0IHRvIDEgYmVmb3JlIGxvYWQgbW9kdWxlICIgc2RoY2lf
cGNpICIgdGhlbiB0ZXN0IGFnYWluLg0KCUZvciBzdXBwb3J0IDEuOFYgZU1NQyBjaGlwIGJldHRl
ciwgSSBoYWQgc3VibWl0IHNvbWUgcGF0Y2hlcyB0byBMaW51eCBrZXJuZWwuICBCdXQgdGhlc2Ug
cGF0Y2hlcyBhcmUgb25seSB3b3JrIHdoZW4gUENSIDB4MzA4IGJpdDQgaXMgMS4gDQogICAgICAg
ICAgICAgIElmIHlvdSB1c2UgTzIgU0QgaG9zdCBjb250cm9sbGVyIGFzIFNEIGNhcmQgcmVhZGVy
LCB5b3UnZCBiZXR0ZXIgc2V0IFBDUiAweDMwOCBiaXQ0IHRvIDA7IA0KICAgICAgICAgICAgICBJ
ZiB5b3UgdXNlIE8yIFNEIGhvc3QgY29udHJvbGxlciBhcyBlTU1DIGhvc3QsIHlvdSdkIGJldHRl
ciBzZXQgUENSIDB4MzA4IGJpdDQgdG8gMS4NCkJSDQpFcm5lc3QNCg0KLS0tLS3Tyrz+1K28/i0t
LS0tDQq3orz+yMs6IERhbmllbCBEcmFrZSA8ZHJha2VAZW5kbGVzc20uY29tPiANCreiy83Ksbzk
OiAyMDE5xOo51MI1yNUgMTI6NTYNCsrVvP7IyzogdWxmLmhhbnNzb25AbGluYXJvLm9yZw0Ks63L
zTogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXhAZW5kbGVzc20uY29tOyBFcm5lc3Qg
WmhhbmcoV0gpIDxlcm5lc3QuemhhbmdAYmF5aHVidGVjaC5jb20+DQrW98ziOiBbUEFUQ0hdIFJl
dmVydCAibW1jOiBzZGhjaTogUmVtb3ZlIHVubmVlZGVkIHF1aXJrMiBmbGFnIG9mIE8yIFNEIGhv
c3QgY29udHJvbGxlciINCg0KVGhpcyByZXZlcnRzIGNvbW1pdCA0MTQxMjZmOWU1YWJmMTk3M2M2
NjFkMjQyMjk1NDNhOTQ1OGZhOGNlLg0KDQpUaGlzIGNvbW1pdCBicm9rZSBlTU1DIHN0b3JhZ2Ug
YWNjZXNzIG9uIGEgbmV3IGNvbnN1bWVyIE1pbmlQQyBiYXNlZCBvbiBBTUQgU29DLCB3aGljaCBo
YXMgZU1NQyBjb25uZWN0ZWQgdG86DQoNCjAyOjAwLjAgU0QgSG9zdCBjb250cm9sbGVyOiBPMiBN
aWNybywgSW5jLiBEZXZpY2UgODYyMCAocmV2IDAxKSAocHJvZy1pZiAwMSkNCglTdWJzeXN0ZW06
IE8yIE1pY3JvLCBJbmMuIERldmljZSAwMDAyDQoNCkR1cmluZyBwcm9iZSwgc2V2ZXJhbCBlcnJv
cnMgYXJlIHNlZW4gaW5jbHVkaW5nOg0KDQogIG1tYzE6IEdvdCBkYXRhIGludGVycnVwdCAweDAy
MDAwMDAwIGV2ZW4gdGhvdWdoIG5vIGRhdGEgb3BlcmF0aW9uIHdhcyBpbiBwcm9ncmVzcy4NCiAg
bW1jMTogVGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuDQogIG1tYzE6IGVy
cm9yIC0xMTAgd2hpbHN0IGluaXRpYWxpc2luZyBNTUMgY2FyZA0KDQpSZXZlcnRpbmcgdGhpcyBj
b21taXQgYWxsb3dzIHRoZSBlTU1DIHN0b3JhZ2UgdG8gYmUgZGV0ZWN0ZWQgJiB1c2FibGUgYWdh
aW4uDQoNClNpZ25lZC1vZmYtYnk6IERhbmllbCBEcmFrZSA8ZHJha2VAZW5kbGVzc20uY29tPg0K
LS0tDQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIGIvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1wY2ktbzJtaWNyby5jDQppbmRleCA5ZGM0NTQ4MjcxYjQuLjE5OTQ0YjAwNDlkYiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KKysrIGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQpAQCAtNDMyLDcgKzQzMiw2IEBAIGlu
dCBzZGhjaV9wY2lfbzJfcHJvYmVfc2xvdChzdHJ1Y3Qgc2RoY2lfcGNpX3Nsb3QgKnNsb3QpDQog
CQkJCQltbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7DQogCQkJCWhvc3QtPmZsYWdzICY9IH5TREhD
SV9TSUdOQUxJTkdfMzMwOw0KIAkJCQlob3N0LT5mbGFncyB8PSBTREhDSV9TSUdOQUxJTkdfMTgw
Ow0KLQkJCQlob3N0LT5xdWlya3MyIHw9IFNESENJX1FVSVJLMl9DTEVBUl9UUkFOU0ZFUk1PREVf
UkVHX0JFRk9SRV9DTUQ7DQogCQkJCWhvc3QtPm1tYy0+Y2FwczIgfD0gTU1DX0NBUDJfTk9fU0Q7
DQogCQkJCWhvc3QtPm1tYy0+Y2FwczIgfD0gTU1DX0NBUDJfTk9fU0RJTzsNCiAJCQkJcGNpX3dy
aXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KQEAgLTY4Miw2ICs2ODEsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9wY2lfbzJfb3BzID0geyAgY29uc3Qgc3RydWN0
IHNkaGNpX3BjaV9maXhlcyBzZGhjaV9vMiA9IHsNCiAJLnByb2JlID0gc2RoY2lfcGNpX28yX3By
b2JlLA0KIAkucXVpcmtzID0gU0RIQ0lfUVVJUktfTk9fRU5EQVRUUl9JTl9OT1BERVNDLA0KKwku
cXVpcmtzMiA9IFNESENJX1FVSVJLMl9DTEVBUl9UUkFOU0ZFUk1PREVfUkVHX0JFRk9SRV9DTUQs
DQogCS5wcm9iZV9zbG90ID0gc2RoY2lfcGNpX28yX3Byb2JlX3Nsb3QsICAjaWZkZWYgQ09ORklH
X1BNX1NMRUVQDQogCS5yZXN1bWUgPSBzZGhjaV9wY2lfbzJfcmVzdW1lLA0KLS0NCjIuMjAuMQ0K
DQo=
