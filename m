Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83BB6FDE1
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfGVKd7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 06:33:59 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:55049 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729697AbfGVKd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 06:33:58 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.146) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Mon, 22 Jul 2019 10:30:01 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Jul 2019 10:15:32 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 22 Jul 2019 10:15:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/eKITG4iE26eRSTDCJjYx0detTEUh0te6GvyJ/kDeDZK0NkjnUK4Ew+4yyslQnxNkc9mEK8wjCa1D6L/B5K8xioUb8Ae4XxPgCTCamoEddoLjPblQJMmy0Nxnw/AgocrgZbLBjyMYGBP6OrXM8W6EFufy1FY3O2tXAdGKIE19+4DaVx7Qh2imdvi5aoblFMUu2Qwro0h8LtxbNVqKc+Qhgip4Jm+Pt0d0n1z13h3crm4NNUpBIYexnG0r/jYNtpYgmJIx8FzceEm1ysVQSuXJRwwDxCpqlLdb4ftCYA3kC7WScUCjXxg+Y0xkZnG2gfzHvUy9PsT0Q3GQSaQK4B0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i56TEZAUVPAHnm5dqqYwTDD3ljESbyZmG/XYe7NPUuw=;
 b=BGXXlqzfCDQf76FdMRgrCB8CPcohZUzdvSn1O9FVO9h4hD8R52y7Z7C9qkKg2gTumHXnfcTDvCNUcosG+X8Byt+Bsler+7Qtq30wjllVJHZnEmKIJLJBXjCW6lDeBuIV3DOKcT899akjf6ETTpJVCa0dJKGiEeO7ojDexRWXf34WxqCRn7rH3U7dm3Ga5TzaJioUNWorbGH2pxVNTeNCOwohvQl/e1quaOSYsyShQu9W71VV64cfbcWoGB8GQam6Cwwouz3ZlHjV89mYMKYL3iW/Wy/YlTkOUy3yAMusmq6TEx2a6PuNzA921sqRlaWV7T36yuQAHfR0w+thbtf6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR1801MB1909.namprd18.prod.outlook.com (10.171.255.24) by
 CY4PR1801MB1943.namprd18.prod.outlook.com (10.171.255.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 10:15:31 +0000
Received: from CY4PR1801MB1909.namprd18.prod.outlook.com
 ([fe80::1d84:4a66:a3f4:97f8]) by CY4PR1801MB1909.namprd18.prod.outlook.com
 ([fe80::1d84:4a66:a3f4:97f8%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 10:15:31 +0000
From:   Matthias Brugger <mbrugger@suse.com>
To:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/18] mmc: sdhci-iproc: Add support for emmc2 of the
 BCM2711
Thread-Topic: [PATCH 10/18] mmc: sdhci-iproc: Add support for emmc2 of the
 BCM2711
Thread-Index: AQHVQFYQd91gaSX3ekC/BwEhDMmMbqbWbBEA
Date:   Mon, 22 Jul 2019 10:15:31 +0000
Message-ID: <55b337d1-8e6c-2b80-9859-c35a82ea5df3@suse.com>
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::33) To CY4PR1801MB1909.namprd18.prod.outlook.com
 (2603:10b6:910:7a::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mbrugger@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.223.144.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1da348d9-cbee-4801-fc37-08d70e8d86aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1943;
x-ms-traffictypediagnostic: CY4PR1801MB1943:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1801MB19433F9229BB6F80E9E61E4DBAC40@CY4PR1801MB1943.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(478600001)(6436002)(31696002)(6486002)(14454004)(6512007)(6306002)(53936002)(229853002)(31686004)(66556008)(66476007)(66066001)(86362001)(25786009)(66946007)(6246003)(5660300002)(66446008)(64756008)(2906002)(316002)(7736002)(110136005)(54906003)(966005)(81156014)(81166006)(7416002)(8936002)(4326008)(8676002)(36756003)(71200400001)(71190400001)(6506007)(386003)(6116002)(14444005)(256004)(3846002)(68736007)(52116002)(305945005)(99286004)(486006)(446003)(11346002)(476003)(76176011)(26005)(186003)(53546011)(2616005)(102836004)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1801MB1943;H:CY4PR1801MB1909.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GdAujMcfaX13uljKV1TWYyb3XzqK2TkDq5+bpXD4Jcy1NrxYzrGQfMLHbf/GYpVpAwggPYOU3+4qzwnjVkLgkvMYjYCDaol3ons0iKgCGwTakaSpOk2M5D9i12rfiOfdY27AY8dCl4cAC2jxy8ywjfjg8FQltC5r3tAYWkKcypRSwlaa8jNXWYwGim+gmAC36c5MLoZhjecWhFwkeej3RlxrHpPQe5iZgatr3/5l0M5G5CalVrFT8gcHGpArAg8BCJL68WR261IhA7HKNI36UO88afsrjvKgYmhxy0ZKre84MIMy1R4MsfMu8rN7fn05kEN6mUbwPOTQMAsqlCuD8g88Bv/BKWfmtVGz8JoMPYKfxsQtu6x9e3OgOEEaCiwE+277+hjmcAZbE+BSoyKhhK+aS4VhrvIu/TzUP3vkbGQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09C4B038350A3B47A7C493B68609A1CF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da348d9-cbee-4801-fc37-08d70e8d86aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 10:15:31.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbrugger@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1943
X-OriginatorOrg: suse.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCk9uIDIyLzA3LzIwMTkgMDg6MjMsIFN0ZWZhbiBXYWhyZW4gd3JvdGU6DQo+IFRoZSBhZGRp
dGlvbmFsIGVtbWMyIGludGVyZmFjZSBvZiB0aGUgQkNNMjcxMSBpcyBhbiBpbXByb3ZlZCB2ZXJz
aW9uDQo+IG9mIHRoZSBvbGQgZW1tYyBjb250cm9sbGVyLCB3aGljaCBpcyBhYmxlIHRvIHByb3Zp
ZGUgRERSNTAgbW9kZSBvbiB0aGUNCj4gUmFzcGJlcnJ5IFBpIDQuIEV4Y2VwdCAzMiBiaXQgb25s
eSByZWdpc3RlciBhY2Nlc3Mgbm8gb3RoZXIgcXVpcmtzIGFyZQ0KPiBrbm93biB5ZXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gV2FocmVuIDx3YWhyZW5zdEBnbXgubmV0Pg0KDQpSZXZp
ZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWJydWdnZXJAc3VzZS5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWlwcm9jLmMgfCA5ICsrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktaXByb2MuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktaXByb2MuYw0KPiBp
bmRleCAyZmViNGVmLi4yYjljZGNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWlwcm9jLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1pcHJvYy5jDQo+IEBA
IC0yNjEsOCArMjYxLDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfaXByb2NfZGF0YSBi
Y20yODM1X2RhdGEgPSB7DQo+ICAJLm1tY19jYXBzID0gMHgwMDAwMDAwMCwNCj4gIH07DQo+IA0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhIHNkaGNpX2JjbTI3MTFfcGx0
Zm1fZGF0YSA9IHsNCj4gKwkub3BzID0gJnNkaGNpX2lwcm9jXzMyb25seV9vcHMsDQo+ICt9Ow0K
PiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX2lwcm9jX2RhdGEgYmNtMjcxMV9kYXRh
ID0gew0KPiArCS5wZGF0YSA9ICZzZGhjaV9iY20yNzExX3BsdGZtX2RhdGEsDQo+ICt9Ow0KPiAr
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZGhjaV9pcHJvY19vZl9tYXRj
aFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAiYnJjbSxiY20yODM1LXNkaGNpIiwgLmRhdGEg
PSAmYmNtMjgzNV9kYXRhIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJicmNtLGJjbTI3MTEtZW1t
YzIiLCAuZGF0YSA9ICZiY20yNzExX2RhdGEgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gImJyY20s
c2RoY2ktaXByb2MtY3lnbnVzIiwgLmRhdGEgPSAmaXByb2NfY3lnbnVzX2RhdGF9LA0KPiAgCXsg
LmNvbXBhdGlibGUgPSAiYnJjbSxzZGhjaS1pcHJvYyIsIC5kYXRhID0gJmlwcm9jX2RhdGEgfSwN
Cj4gIAl7IH0NCj4gLS0NCj4gMi43LjQNCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA0K
