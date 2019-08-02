Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8807F583
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbfHBKyG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 06:54:06 -0400
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:20036
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfHBKyF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Aug 2019 06:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw1K7N08bO+uWt1x+qprbcGPikhpxjbNwBt7IWmxR545gxqAYUm9YirsMTJKIAlo5BJxm6IjQg57C94V9FE5MfEu2S1er2hpB2NVXyEwvDUt2jkwePxq/OAHo2excoHWKXHfv+q/4TlHAwJfz4r61wVDXJoiXdlRHkV3Cqr1Fv4SJBNdWjTSzrxeptLI4XveLtNomTTxE+sl8+JtNjPAsbxbjCNtMFrD4199sobjKnQnlci+wLwext3jUgEMW5M/9m35WJgvxk9Vl/mwTae1+YGlJj2aOTPhUPUM61+KEXKasxDR7Nhus6Q//bsybiuOFOd0ibie7pnTXlg5nj1IQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0vaE8+84m9aPlAZ1gvTP2wn23SvAld4SS0M2K2+tD4=;
 b=C0OO6uST7xMB6msFu/YJcYGHzauvZxatzQ13ob8U3nWsHn3aF4rhb3a3nIJBS8QhjxnthhTVnKMCbZ5elL7i3NXgoYMwYPZh8EOOoJZFFegf4zwRl69EjSrPdr2rm5YmXiTBhK8MRFqdv8SG1WNVLts8H8/Yf5H3WyKrgf4WLPloj2MI+dvmXhNazJWHch6RkIS103si5uGcvmKpBFCqtCmE3ImdJL5oqGcpVOHlo/EQmpckMQ0HutmxS9e6bCR3r7zwqCgXrxalgTewxPwul39pgf7gPIyC3yxpTZghH/vPSGuugr7m/9wPr+i01Wwfshg+Txur+grtKDZVKABprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bayhubtech.com;dmarc=pass action=none
 header.from=bayhubtech.com;dkim=pass header.d=bayhubtech.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0vaE8+84m9aPlAZ1gvTP2wn23SvAld4SS0M2K2+tD4=;
 b=TbyQAoaqdFvAi9E/dIRiwUcqZxcODybtxi9qsDQXH2eUZ/KftkykQHKIGbT6ckDVETyDhxgtxBWSBr2rQVMEYUVay/CjzRDzmOdtOOSqoT+q9q4BMmUt/N9uT/QCyXS3ovE+4xC8R8NSnmQyazgNdc9LQ7br+mn7onjhAL4HTgc=
Received: from MW2PR16MB2249.namprd16.prod.outlook.com (52.132.181.148) by
 MW2PR16MB2412.namprd16.prod.outlook.com (52.132.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Fri, 2 Aug 2019 10:53:59 +0000
Received: from MW2PR16MB2249.namprd16.prod.outlook.com
 ([fe80::453:d331:e0f5:52ba]) by MW2PR16MB2249.namprd16.prod.outlook.com
 ([fe80::453:d331:e0f5:52ba%7]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 10:53:59 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>
Subject: RE: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock
 Phase shift issue
Thread-Topic: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock
 Phase shift issue
Thread-Index: AQHVQ+K4pHmBxuIv/kq4swnDVRnZkqbhhhOAgAXovFA=
Date:   Fri, 2 Aug 2019 10:53:58 +0000
Message-ID: <MW2PR16MB2249FF19BBE7890B0E7703C9EAD90@MW2PR16MB2249.namprd16.prod.outlook.com>
References: <1564166909-7437-1-git-send-email-shirley.her@bayhubtech.com>
 <0ce0b72d-46f6-ee06-092b-abb0d656c083@intel.com>
In-Reply-To: <0ce0b72d-46f6-ee06-092b-abb0d656c083@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chevron.li@bayhubtech.com; 
x-originating-ip: [58.48.115.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ddc9c62-6ed6-4599-9376-08d71737b93d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MW2PR16MB2412;
x-ms-traffictypediagnostic: MW2PR16MB2412:
x-microsoft-antispam-prvs: <MW2PR16MB2412706C995D94FC8272DF33EAD90@MW2PR16MB2412.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(396003)(376002)(136003)(199004)(189003)(13464003)(33656002)(66556008)(5660300002)(7736002)(305945005)(52536014)(66946007)(71190400001)(68736007)(66476007)(66446008)(64756008)(71200400001)(66066001)(99286004)(7696005)(186003)(30864003)(8676002)(81156014)(8936002)(81166006)(2501003)(53546011)(102836004)(2201001)(6506007)(76176011)(6436002)(107886003)(229853002)(25786009)(26005)(3846002)(6116002)(2906002)(88996005)(4326008)(508600001)(14454004)(54906003)(486006)(6246003)(55016002)(110136005)(74316002)(9686003)(256004)(476003)(446003)(11346002)(53936002)(316002)(86362001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR16MB2412;H:MW2PR16MB2249.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q+juaRF1/6RXyhv1QYPPwL3Be3ZVBIQ5rFw4RU8mQoQcVupZ5MQSJybsvTCZ0Lg7v2tc471htmfLQP+S/VUMnlxFc3shs4RhlfmbUmkEHLsPH/GIP50EoXixUqkOdKQ+o28sd9cM61Y4GU3OJfwICOr1h2bi1DlmMrKiNShH8g82BdrvkbpOUQ0Ax3D8CNFVBlkaKjhjJcEP+w/kzn/otnAdzqlzHcMkHOQbJeXL7bn4rc4aWn6wpeuKstNo2XR/pyZVO2mgv03rVvoKy86rsssDxR9wZnVJEK5a5c+vxm5iQhsJ2kCSW6KIIRpVDmiz9ZOrMjvfxmxy/7cXQoChYU4bDBcZrejzXcKf/K0ah4K4gQA05FN9AfZ/bakNwVPIMfUnF+Xv+xlKtkK5No72e7rKjmrGOyiWTxV4sGMmY5s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc9c62-6ed6-4599-9376-08d71737b93d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 10:53:58.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chevron.li@bayhubtech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR16MB2412
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksIEFkcmlhbiwNCg0KRmlyc3RseSwgcmVhbGx5IGFwcHJlY2lhdGUgZm9yIHlvdXIgdmFsdWFi
bGUgc3VnZ2VzdGlvbnMuDQoNCkZvciB5b3VyIHF1ZXN0aW9uIHRoYXQgIiBUdW5pbmcgd2lsbCBi
ZSBleGVjdXRlZCB3aGVuZXZlciB0aGUgc3lzdGVtIHJlc3VtZXMsIHdoaWNoIGlzIG5vdCBhbiBl
cnJvci4gQ2FuIHlvdSBleHBsYWluIHdoZW4gZXJyb3IgcmVjb3ZlcnkgaXMgbmVlZGVkLA0KYW5k
IGhvdyB0aGlzIHBhdGNoIHdvcmtzLiINCg0KV2UgaGF2ZSBibG93IHF1ZXN0aW9ucyBuZWVkIHlv
dXIgaGVscC4NCg0KMS4gSW4gd2hpY2ggY2FzZXMgY2FyZCBpbml0aWFsaXphdGlvbiBtb2R1bGUo
bW1jX2luaXRfY2FyZCkgd2lsbCBiZSBjYWxsZWQgYWZ0ZXIgZmlyc3QgaW5pdCBjb21wbGV0ZWQg
ZXhjbHVkZSBlcnJvciBoYXBwZW5lZD8gV2hldGhlciB0aGUgY2FzZSBpcyBSZXN1bWUgZnJvbSBp
ZGxlIG9yIHNsZWVwLCBhbnkgY2FzZSBlbHNlPw0KICBJbiB3aGljaCBjYXNlcyB0dW5pbmcgbW9k
dWxlKGV4ZWN1dGVfdHVuaW5nKSB3aWxsIGJlIGNhbGxlZCBhZnRlciBmaXJzdCBpbml0IGNvbXBs
ZXRlZCBleGNsdWRlIGVycm9yIGhhcHBlbmVkPyBXaGV0aGVyIHRoZSBjYXNlIGlzIFJlc3VtZSBm
cm9tIGlkbGUgb3Igc2xlZXAsIGFueSBjYXNlIGVsc2U/DQoNCkJlY2F1c2UgaW4gQmF5aHViIGRy
aXZlciwgb25jZSB0dW5pbmcgbW9kdWxlIGlzIGNhbGxlZCBleGNsdWRlIGZpcnN0IGluaXRpYWxp
emF0aW9uIHRoZSB0dW5pbmcgY2FsbCB3aWxsIGJlIHRob3VnaHQgYXMgZXJyb3IgcmVjb3Zlcnkg
dHVuaW5nLg0KDQoyLiBJZiB0aGUgdHVuaW5nIGFuZCBpbml0aWFsaXphdGlvbiBhcmUgY2FsbGVk
IGNhc2VzIGFyZSBub3QgY2xlYXJseSwgY2FuIHdlIGdldCB0aGUgbW1jX2Jsa19yZXF1ZXN0IGVy
cm9yIHN0YXR1cyhibG9jayByZXF1ZXN0IGVycm9yKSBpbiB0dW5pbmcgbW9kdWxlPw0KDQpXaGF0
IG1ldGhvZCBjYW4gYmUgdXNlZCB0byBnZXQgdGhlIHN0cnVjdHVyZSBtbWNfYmxrX3JlcXVlc3Qg
aW4gdHVuaW5nIG1vZHVsZShleGVjdXRlX3R1bmluZykNCg0KMy4gSWYgdGhlcmUgaXMgbm8gbWV0
aG9kIHRvIGdldCB0aGUgYmxvY2sgcmVxdWVzdCBlcnJvciBzdGF0dXMgaW4gdHVuaW5nIG1vZHVs
ZSwgd2Ugd2FudCB0byBhZGQgYSB2YXJpYWJsZSB0byBzYXZlIHRoZSBlcnJvciBzdGF0dXMgZHVy
aW5nIGJsb2NrIHJlcXVlc3QsDQphbmQgdXNlIGl0IGluIHR1bmluZyBtb2R1bGUgYXMgdGhlIGNv
bmRpdGlvbiB0byBjYWxsIEJheWh1YiBkbGwgcmVjb3ZlcnkuDQoNClNvIHdoaWNoIHN0cnVjdHVy
ZSB0aGUgdmFyaWFibGUgc2hvdWxkIGJlIGFkZGVkLCBhbmQgaG93IHRvIGFjcXVpcmUgaXQgaW4g
bW1jX2Jsa19tcV9yd19yZWNvdmVyeSwgaG93IHRvIGFjcXVpcmUgaXQgaW4gZXhlY3V0ZV90dW5p
bmcuDQoNCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5IQ0KDQpUaGFua3MsDQpDaGV2cm9u
DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFkcmlhbiBIdW50ZXIgW21h
aWx0bzphZHJpYW4uaHVudGVyQGludGVsLmNvbV0gDQpTZW50OiAyMDE55bm0N+aciDI55pelIDIw
OjEzDQpUbzogU2hpcmxleSBIZXIgKFNDKTsgVWxmIEhhbnNzb247IGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBMb3VpcyBMdSAoVFAp
OyBNYXggSHVhbmcgKFNDKTsgQ2hldnJvbiBMaSAoV0gpDQpTdWJqZWN0OiBSZTogW1BBVENIIFYy
IDEvMV0gbW1jOiBzZGhjaTogRml4IE8yIEhvc3QgZGF0YSByZWFkL3dyaXRlIERMTCBsb2NrIFBo
YXNlIHNoaWZ0IGlzc3VlDQoNCk9uIDI2LzA3LzE5IDk6NDggUE0sIFNoaXJsZXkgSGVyIChTQykg
d3JvdGU6DQo+IEZpeCBkYXRhIHJlYWQvd3JpdGUgZXJyb3IgaW4gSFMyMDAgbW9kZSBkdWUgdG8g
Y2hpcCBETEwgbG9jayBwaGFzZSANCj4gc2hpZnQNCg0KTW9yZSBleHBsYW5hdGlvbiBpcyBuZWVk
ZWQuICBTZWUgY29tbWVudCBiZWxvdyB3aGVyZQ0Kc2RoY2lfbzJfZXJyb3JfcmVjb3ZlcnkoKSBp
cyBjYWxsZWQuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6U2hpcmxleSBIZXI8c2hpcmxleS5oZXJA
YmF5aHVidGVjaC5jb20+DQo+IC0tLQ0KPiBjaGFuZ2UgaW4gVjI6DQo+ICAgMS4gVXNlIHVzbGVl
cF9yYW5nZSBpbnN0ZWFkIG9mIHVkZWxheQ0KPiAgIDIuIG1vdmUgZGxsX2FkanVzdF9jb3VudCB0
byBzZGhjaS1wY2ktbzJtaWNyby5jDQo+IA0KPiBjaGFuZ2UgaW4gVjE6DQo+ICAgMS4gQWRkIGVy
cm9yIHJlY292ZXJ5IGZ1bmN0aW9uIHRvIHJlbG9jayB0aGUgRExMIHdpdGggY29ycmVjdCBwaGFz
ZQ0KPiAgIDIuIFJldHVuaW5nIEhTMjAwIGFmdGVyIERMTCBsb2NrZWQNCj4gLS0tDQo+IC0tLQ0K
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIHwgMTU3IA0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzMyBpbnNl
cnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMgDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
Y2ktbzJtaWNyby5jDQo+IGluZGV4IDlkYzQ1NDguLmM0M2IyY2UgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCj4gQEAgLTUxLDEzICs1MSw2MCBAQA0KPiAgI2RlZmlu
ZSBPMl9TRF9WRU5ET1JfU0VUVElORzIJMHgxQzgNCj4gICNkZWZpbmUgTzJfU0RfSFdfVFVOSU5H
X0RJU0FCTEUJQklUKDQpDQo+ICANCj4gLSNkZWZpbmUgTzJfUExMX1dEVF9DT05UUk9MMQkweDFD
Qw0KPiArI2RlZmluZSBPMl9QTExfRExMX1dEVF9DT05UUk9MMQkweDFDQw0KDQpSZW5hbWluZyBP
Ml9QTExfV0RUX0NPTlRST0wxIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KDQo+ICAjZGVm
aW5lICBPMl9QTExfRk9SQ0VfQUNUSVZFCUJJVCgxOCkNCj4gICNkZWZpbmUgIE8yX1BMTF9MT0NL
X1NUQVRVUwlCSVQoMTQpDQo+ICAjZGVmaW5lICBPMl9QTExfU09GVF9SRVNFVAlCSVQoMTIpDQo+
ICsjZGVmaW5lICBPMl9ETExfTE9DS19TVEFUVVMJQklUKDExKQ0KPiAgDQo+ICAjZGVmaW5lIE8y
X1NEX0RFVEVDVF9TRVRUSU5HIDB4MzI0DQo+ICANCj4gK3N0YXRpYyBjb25zdCB1MzIgZG1kbl90
YWJsZVs1XSA9IHsweDI1MTAwMDAwLCAweDJCMUMwMDAwLA0KPiArCTB4MkMxQTAwMDAsIDB4Mzcx
QjAwMDAsIDB4MzUxMDAwMDB9OyBzdGF0aWMgdTggZGxsX2FkanVzdF9jb3VudDsNCg0KVGhpcyBz
aG91bGQgYmUgaW4gYSBzdHJ1Y3Q6DQoNCnN0cnVjdCBvMl9ob3N0IHsNCgl1OCBkbGxfYWRqdXN0
X2NvdW50Ow0KfQ0KDQoNCj4gK3N0YXRpYyBpbnQgc2RoY2lfbzJfZ2V0X2NkKHN0cnVjdCBtbWNf
aG9zdCAqbW1jKTsNCg0KUGxlYXNlIG1ha2UgYSBzZXBhcmF0ZSBwYXRjaCB0aGF0IHJlb3JkZXJz
IHRoZSBmdW5jdGlvbnMgc28gdGhhdCBmb3J3YXJkIGRlY2xhcmF0aW9uIG9mIHNkaGNpX28yX2dl
dF9jZCgpIGlzIG5vdCBuZWNlc3NhcnkuDQoNCj4gKw0KPiArc3RhdGljIHZvaWQgbzJfcGNpX3Nl
dF9iYXNlY2xrKHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcCwgdTMyIA0KPiArdmFsdWUpIHsN
Cj4gKwl1MzIgc2NyYXRjaF8zMjsNCj4gKw0KPiArCXBjaV9yZWFkX2NvbmZpZ19kd29yZChjaGlw
LT5wZGV2LA0KPiArCQkJICAgICAgTzJfU0RfUExMX1NFVFRJTkcsICZzY3JhdGNoXzMyKTsNCj4g
Kw0KPiArCXNjcmF0Y2hfMzIgJj0gMHgwMDAwRkZGRjsNCj4gKwlzY3JhdGNoXzMyIHw9IHZhbHVl
Ow0KPiArDQo+ICsJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiArCQkJICAg
ICAgIE8yX1NEX1BMTF9TRVRUSU5HLCBzY3JhdGNoXzMyKTsgfQ0KPiArDQo+ICtzdGF0aWMgaW50
IHNkaGNpX28yX3dhaXRfZGxsX2RldGVjdF9sb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KSB7
DQo+ICsJa3RpbWVfdCB0aW1lb3V0Ow0KPiArCXUzMiBzY3JhdGNoMzI7DQo+ICsNCj4gKwl1c2xl
ZXBfcmFuZ2UoNTAwMCwgNjAwMCk7DQo+ICsJc2NyYXRjaDMyID0gc2RoY2lfcmVhZGwoaG9zdCwg
TzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiArCWlmICghKHNjcmF0Y2gzMiAmIE8yX0RMTF9M
T0NLX1NUQVRVUykpIHsNCj4gKwkJcHJfd2FybigiJXM6IERMTCBpcyBzdGlsbCB1bmxvY2tlZCBh
ZnRlciB3YWl0IDVtc1xuIiwNCj4gKwkJCW1tY19ob3N0bmFtZShob3N0LT5tbWMpKTsNCj4gKwl9
DQo+ICsNCj4gKwkvKiBEZXRlY3QgNTAwIG1zICovDQo+ICsJdGltZW91dCA9IGt0aW1lX2FkZF9t
cyhrdGltZV9nZXQoKSwgNTAwKTsNCj4gKwl3aGlsZSAoMSkgew0KPiArCQlib29sIHRpbWVkb3V0
ID0ga3RpbWVfYWZ0ZXIoa3RpbWVfZ2V0KCksIHRpbWVvdXQpOw0KPiArDQo+ICsJCXNjcmF0Y2gz
MiA9IHNkaGNpX3JlYWRsKGhvc3QsIE8yX1BMTF9ETExfV0RUX0NPTlRST0wxKTsNCj4gKwkJaWYg
KCEoc2NyYXRjaDMyICYgTzJfRExMX0xPQ0tfU1RBVFVTKSkNCj4gKwkJCXJldHVybiAwOw0KPiAr
DQo+ICsJCWlmICh0aW1lZG91dCkNCj4gKwkJCXJldHVybiAxOw0KPiArCQl1c2xlZXBfcmFuZ2Uo
MTAsIDEwMDApOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgc2RoY2lfbzJfc2V0
X3R1bmluZ19tb2RlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KSAgew0KPiAgCXUxNiByZWc7DQo+
IEBAIC05NSwxMSArMTQyLDg1IEBAIHN0YXRpYyB2b2lkIF9fc2RoY2lfbzJfZXhlY3V0ZV90dW5p
bmcoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHUzMiBvcGNvZGUpDQo+ICAJc2RoY2lfcmVzZXRf
dHVuaW5nKGhvc3QpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50IHNkaGNpX28yX2Vycm9yX3Jl
Y292ZXJ5KHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcCwNCj4gKwkJCQkgc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QpDQo+ICt7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsJdTggc2NyYXRjaF84ID0g
MDsNCj4gKwl1MzIgc2NyYXRjaF8zMiA9IDA7DQoNClBsZWFzZSBhZGQgYSBibGFuayBsaW5lIGFm
dGVyIGxvY2FsIHZhcmlhYmxlIGRlY2xhcmF0aW9uDQoNCj4gKwkvKiBEaXNhYmxlIGNsb2NrICov
DQo+ICsJc2RoY2lfd3JpdGViKGhvc3QsIDAsIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPiArDQo+
ICtETExfQURKVVNUOg0KDQpQbGVhc2UgdXNlIGEgJ2RvJywgJ2Zvcicgb3IgJ3doaWxlJyBsb29w
Lg0KDQo+ICsJaWYgKGRsbF9hZGp1c3RfY291bnQgPj0gNSkgew0KPiArCQlkbGxfYWRqdXN0X2Nv
dW50ID0gNDsNCj4gKwkJcHJfd2FybigiJXM6IGVycm9yIHJlY292ZXJ5IGZhaWxlZCB3aXRoIHRo
ZSBkbGxfYWRqdXN0X2NvdW50IG92ZXIgbWF4IHZhbHVlLlxuIiwNCj4gKwkJCW1tY19ob3N0bmFt
ZShob3N0LT5tbWMpKTsNCg0KSXNuJ3QgaXQgbmVjZXNzYXJ5IHRvIGV4aXQgdGhlIGxvb3AgaGVy
ZT8NCg0KPiArCX0NCj4gKw0KPiArCS8qIFVuTG9jayBXUCAqLw0KPiArCXJldCA9IHBjaV9yZWFk
X2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsDQo+ICsJCQlPMl9TRF9MT0NLX1dQLCAmc2NyYXRjaF84
KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJc2NyYXRjaF84ICY9
IDB4N2Y7DQo+ICsJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tf
V1AsIHNjcmF0Y2hfOCk7DQo+ICsNCj4gKwkvKiBQTEwgc29mdHdhcmUgcmVzZXQgKi8NCj4gKwlz
Y3JhdGNoXzMyID0gc2RoY2lfcmVhZGwoaG9zdCwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0K
PiArCXNjcmF0Y2hfMzIgfD0gTzJfUExMX1NPRlRfUkVTRVQ7DQo+ICsJc2RoY2lfd3JpdGVsKGhv
c3QsIHNjcmF0Y2hfMzIsIE8yX1BMTF9ETExfV0RUX0NPTlRST0wxKTsNCj4gKw0KPiArCXJldCA9
IHBjaV9yZWFkX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiArCQkJCSAgICBPMl9TRF9GVU5D
X1JFRzQsDQo+ICsJCQkJICAgICZzY3JhdGNoXzMyKTsNCj4gKwkvKiBFbmFibGUgQmFzZSBDbGsg
c2V0dGluZyBjaGFuZ2UgKi8NCj4gKwlzY3JhdGNoXzMyIHw9IE8yX1NEX0ZSRUc0X0VOQUJMRV9D
TEtfU0VUOw0KPiArCXBjaV93cml0ZV9jb25maWdfZHdvcmQoY2hpcC0+cGRldiwgTzJfU0RfRlVO
Q19SRUc0LCBzY3JhdGNoXzMyKTsNCj4gKwlvMl9wY2lfc2V0X2Jhc2VjbGsoY2hpcCwgZG1kbl90
YWJsZVtkbGxfYWRqdXN0X2NvdW50XSk7DQo+ICsNCj4gKw0KDQpQbGVhc2UgZG9uJ3QgdXNlIG11
bHRpcGxlIGJsYW5rIGxpbmVzDQoNCj4gKwkvKiBFbmFibGUgaW50ZXJuYWwgY2xvY2sgKi8NCj4g
KwlzY3JhdGNoXzggPSBTREhDSV9DTE9DS19JTlRfRU47DQo+ICsJc2RoY2lfd3JpdGViKGhvc3Qs
IHNjcmF0Y2hfOCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+ICsNCj4gKwlpZiAoc2RoY2lfbzJf
Z2V0X2NkKGhvc3QtPm1tYykpIHsNCj4gKwkJaWYgKHNkaGNpX28yX3dhaXRfZGxsX2RldGVjdF9s
b2NrKGhvc3QpKSB7DQo+ICsJCQlzY3JhdGNoXzggfD0gU0RIQ0lfQ0xPQ0tfQ0FSRF9FTjsNCj4g
KwkJCXNkaGNpX3dyaXRlYihob3N0LCBzY3JhdGNoXzgsIFNESENJX0NMT0NLX0NPTlRST0wpOw0K
PiArCQkJcmV0ID0gMTsNCj4gKwkJfSBlbHNlIHsNCj4gKw0KDQpCbGFuayBsaW5lcyBhcmVuJ3Qg
bmVjZXNzYXJ5IGFmdGVyIGFuIG9wZW4gYnJhY2UgJ3snDQoNCj4gKwkJCXByX3dhcm4oIiVzOiBE
TEwgdW5sb2NrZWQgd2hlbiBkbGxfYWRqdXN0X2NvdW50IGlzICVkLlxuIiwNCj4gKwkJCW1tY19o
b3N0bmFtZShob3N0LT5tbWMpLCBkbGxfYWRqdXN0X2NvdW50KTsNCj4gKwkJCWRsbF9hZGp1c3Rf
Y291bnQrKzsNCj4gKwkJCWdvdG8gRExMX0FESlVTVDsNCj4gKwkJfQ0KPiArCX0gZWxzZQ0KPiAr
CQlnb3RvIERMTF9BREpVU1Q7DQoNCmJyYWNlcyB7fSBzaG91bGQgYmUgdXNlZCBvbiBhbGwgYXJt
cyBvZiB0aGlzIHN0YXRlbWVudA0KDQo+ICsNCj4gKwkJLyogTG9jayBXUCAqLw0KPiArCXJldCA9
IHBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsDQo+ICsJCQkJICAgTzJfU0RfTE9DS19X
UCwgJnNjcmF0Y2hfOCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwlzY3Jh
dGNoXzggfD0gMHg4MDsNCj4gKwlwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJf
U0RfTE9DS19XUCwgc2NyYXRjaF84KTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBz
dGF0aWMgaW50IHNkaGNpX28yX2V4ZWN1dGVfdHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCB1
MzIgb3Bjb2RlKSAgDQo+IHsNCj4gIAlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2
KG1tYyk7DQo+ICsJc3RydWN0IHNkaGNpX3BjaV9zbG90ICpzbG90ID0gc2RoY2lfcHJpdihob3N0
KTsNCg0KVGhpcyBpcyBob3cgeW91IGdldCBhIHJlZmVyZW5jZSB0byBvMl9ob3N0Og0KDQoJc3Ry
dWN0IG8yX2hvc3QgKm8yX2hvc3QgPSBzZGhjaV9wY2lfcHJpdihzbG90KTsNCg0KPiAgCWludCBj
dXJyZW50X2J1c193aWR0aCA9IDA7DQo+ICANCj4gKw0KDQpQbGVhc2UgZG9uJ3QgdXNlIG11bHRp
cGxlIGJsYW5rIGxpbmVzDQoNCj4gKwlpZiAoZGxsX2FkanVzdF9jb3VudCkNCg0KZGxsX2FkanVz
dF9jb3VudCBzaG91bGQgYmUgaW4gc3RydWN0IG8yX2hvc3QNCg0KCW8yX2hvc3QtPmRsbF9hZGp1
c3RfY291bnQNCg0KPiArCQlzZGhjaV9vMl9lcnJvcl9yZWNvdmVyeShzbG90LT5jaGlwLCBob3N0
KTsNCg0KVHVuaW5nIHdpbGwgYmUgZXhlY3V0ZWQgd2hlbmV2ZXIgdGhlIHN5c3RlbSByZXN1bWVz
LCB3aGljaCBpcyBub3QgYW4gZXJyb3IuDQpDYW4geW91IGV4cGxhaW4gd2hlbiBlcnJvciByZWNv
dmVyeSBpcyBuZWVkZWQsIGFuZCBob3cgdGhpcyBwYXRjaCB3b3Jrcy4NCg0KPiArDQo+ICsJZGxs
X2FkanVzdF9jb3VudCsrOw0KPiAgCS8qDQo+ICAJICogVGhpcyBoYW5kbGVyIG9ubHkgaW1wbGVt
ZW50cyB0aGUgZU1NQyB0dW5pbmcgdGhhdCBpcyBzcGVjaWZpYyB0bw0KPiAgCSAqIHRoaXMgY29u
dHJvbGxlci4gIEZhbGwgYmFjayB0byB0aGUgc3RhbmRhcmQgbWV0aG9kIGZvciBvdGhlciBUSU1J
TkcuDQo+IEBAIC0xMzEsMjMgKzI1MiwxMSBAQCBzdGF0aWMgaW50IHNkaGNpX28yX2V4ZWN1dGVf
dHVuaW5nKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCB1MzIgb3Bjb2RlKQ0KPiAgCQltbWMtPmlvcy5i
dXNfd2lkdGggPSBNTUNfQlVTX1dJRFRIXzg7DQo+ICAJCXNkaGNpX3NldF9idXNfd2lkdGgoaG9z
dCwgY3VycmVudF9idXNfd2lkdGgpOw0KPiAgCX0NCj4gLQ0KDQpQbGVhc2UgYXZvaWQgdW5yZWxh
dGVkIHdoaXRlIHNwYWNlIGNoYW5nZXMuDQoNCj4gIAlob3N0LT5mbGFncyAmPSB+U0RIQ0lfSFM0
MDBfVFVOSU5HOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBvMl9w
Y2lfc2V0X2Jhc2VjbGsoc3RydWN0IHNkaGNpX3BjaV9jaGlwICpjaGlwLCB1MzIgDQo+IHZhbHVl
KSAtew0KPiAtCXUzMiBzY3JhdGNoXzMyOw0KPiAtCXBjaV9yZWFkX2NvbmZpZ19kd29yZChjaGlw
LT5wZGV2LA0KPiAtCQkJICAgICAgTzJfU0RfUExMX1NFVFRJTkcsICZzY3JhdGNoXzMyKTsNCj4g
IA0KPiAtCXNjcmF0Y2hfMzIgJj0gMHgwMDAwRkZGRjsNCj4gLQlzY3JhdGNoXzMyIHw9IHZhbHVl
Ow0KPiAtDQo+IC0JcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiAtCQkJICAg
ICAgIE8yX1NEX1BMTF9TRVRUSU5HLCBzY3JhdGNoXzMyKTsNCj4gLX0NCj4gIA0KPiAgc3RhdGlj
IHZvaWQgbzJfcGNpX2xlZF9lbmFibGUoc3RydWN0IHNkaGNpX3BjaV9jaGlwICpjaGlwKSAgeyBA
QCANCj4gLTMxNiwyMyArNDI1LDIzIEBAIHN0YXRpYyB2b2lkIHNkaGNpX28yX2VuYWJsZV9pbnRl
cm5hbF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gIAl1MzIgc2NyYXRjaDMyOw0K
PiAgDQo+ICAJLyogUExMIHNvZnR3YXJlIHJlc2V0ICovDQo+IC0Jc2NyYXRjaDMyID0gc2RoY2lf
cmVhZGwoaG9zdCwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsJc2NyYXRjaDMyID0gc2RoY2lf
cmVhZGwoaG9zdCwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgCXNjcmF0Y2gzMiB8PSBP
Ml9QTExfU09GVF9SRVNFVDsNCj4gLQlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBPMl9Q
TExfV0RUX0NPTlRST0wxKTsNCj4gKwlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBPMl9Q
TExfRExMX1dEVF9DT05UUk9MMSk7DQo+ICAJdWRlbGF5KDEpOw0KPiAgCXNjcmF0Y2gzMiAmPSB+
KE8yX1BMTF9TT0ZUX1JFU0VUKTsNCj4gLQlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBP
Ml9QTExfV0RUX0NPTlRST0wxKTsNCj4gKwlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBP
Ml9QTExfRExMX1dEVF9DT05UUk9MMSk7DQo+ICANCj4gIAkvKiBQTEwgZm9yY2UgYWN0aXZlICov
DQo+ICAJc2NyYXRjaDMyIHw9IE8yX1BMTF9GT1JDRV9BQ1RJVkU7DQo+IC0Jc2RoY2lfd3JpdGVs
KGhvc3QsIHNjcmF0Y2gzMiwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsJc2RoY2lfd3JpdGVs
KGhvc3QsIHNjcmF0Y2gzMiwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgDQo+ICAJLyog
V2FpdCBtYXggMjAgbXMgKi8NCj4gIAl0aW1lb3V0ID0ga3RpbWVfYWRkX21zKGt0aW1lX2dldCgp
LCAyMCk7DQo+ICAJd2hpbGUgKDEpIHsNCj4gIAkJYm9vbCB0aW1lZG91dCA9IGt0aW1lX2FmdGVy
KGt0aW1lX2dldCgpLCB0aW1lb3V0KTsNCj4gIA0KPiAtCQlzY3JhdGNoID0gc2RoY2lfcmVhZHco
aG9zdCwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsJCXNjcmF0Y2ggPSBzZGhjaV9yZWFkdyho
b3N0LCBPMl9QTExfRExMX1dEVF9DT05UUk9MMSk7DQo+ICAJCWlmIChzY3JhdGNoICYgTzJfUExM
X0xPQ0tfU1RBVFVTKQ0KPiAgCQkJYnJlYWs7DQo+ICAJCWlmICh0aW1lZG91dCkgew0KPiBAQCAt
MzUwLDE2ICs0NTksMTYgQEAgc3RhdGljIHZvaWQgDQo+IHNkaGNpX28yX2VuYWJsZV9pbnRlcm5h
bF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gIA0KPiAgb3V0Og0KPiAgCS8qIENh
bmNlbCBQTEwgZm9yY2UgYWN0aXZlICovDQo+IC0Jc2NyYXRjaDMyID0gc2RoY2lfcmVhZGwoaG9z
dCwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsJc2NyYXRjaDMyID0gc2RoY2lfcmVhZGwoaG9z
dCwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgCXNjcmF0Y2gzMiAmPSB+TzJfUExMX0ZP
UkNFX0FDVElWRTsNCj4gLQlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBPMl9QTExfV0RU
X0NPTlRST0wxKTsNCj4gKwlzZGhjaV93cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBPMl9QTExfRExM
X1dEVF9DT05UUk9MMSk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgc2RoY2lfbzJfZ2V0X2Nk
KHN0cnVjdCBtbWNfaG9zdCAqbW1jKSAgew0KPiAgCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0g
bW1jX3ByaXYobW1jKTsNCj4gLQ0KDQpQbGVhc2Uga2VlcCB0aGUgYmxhbmsgbGluZSBhZnRlciBk
ZWNsYXJhdGlvbnMuDQoNCj4gLQlzZGhjaV9vMl9lbmFibGVfaW50ZXJuYWxfY2xvY2soaG9zdCk7
DQo+ICsJaWYgKCEoc2RoY2lfcmVhZHcoaG9zdCwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpICYg
TzJfUExMX0xPQ0tfU1RBVFVTKSkNCj4gKwkJc2RoY2lfbzJfZW5hYmxlX2ludGVybmFsX2Nsb2Nr
KGhvc3QpOw0KPiAgDQo+ICAJcmV0dXJuICEhKHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX1BSRVNF
TlRfU1RBVEUpICYgDQo+IFNESENJX0NBUkRfUFJFU0VOVCk7ICB9IEBAIC0zNjksNyArNDc4LDcg
QEAgc3RhdGljIHZvaWQgDQo+IHNkaGNpX28yX2VuYWJsZV9jbGsoc3RydWN0IHNkaGNpX2hvc3Qg
Kmhvc3QsIHUxNiBjbGspDQo+ICAJLyogRW5hYmxlIGludGVybmFsIGNsb2NrICovDQo+ICAJY2xr
IHw9IFNESENJX0NMT0NLX0lOVF9FTjsNCj4gIAlzZGhjaV93cml0ZXcoaG9zdCwgY2xrLCBTREhD
SV9DTE9DS19DT05UUk9MKTsNCj4gLQ0KPiArCXNkaGNpX28yX2VuYWJsZV9pbnRlcm5hbF9jbG9j
ayhob3N0KTsNCj4gIAlpZiAoc2RoY2lfbzJfZ2V0X2NkKGhvc3QtPm1tYykpIHsNCj4gIAkJY2xr
IHw9IFNESENJX0NMT0NLX0NBUkRfRU47DQo+ICAJCXNkaGNpX3dyaXRldyhob3N0LCBjbGssIFNE
SENJX0NMT0NLX0NPTlRST0wpOyBAQCAtNDAwLDcgKzUwOSw3IEBAIA0KPiBpbnQgc2RoY2lfcGNp
X28yX3Byb2JlX3Nsb3Qoc3RydWN0IHNkaGNpX3BjaV9zbG90ICpzbG90KQ0KPiAgDQo+ICAJY2hp
cCA9IHNsb3QtPmNoaXA7DQo+ICAJaG9zdCA9IHNsb3QtPmhvc3Q7DQo+IC0NCj4gKwlkbGxfYWRq
dXN0X2NvdW50ID0gMDsNCj4gIAljYXBzID0gc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lfQ0FQQUJJ
TElUSUVTKTsNCj4gIA0KPiAgCS8qDQo+IA0KDQpTZXQgdXAgbzJfaG9zdCBsaWtlIHRoaXM6DQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCmIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQppbmRleCBjNDNiMmNlY2RmMzAuLmNm
ZTU3ZjIzZGNmMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWlj
cm8uYw0KKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQpAQCAtNzk2
LDQgKzc5Niw1IEBAIGNvbnN0IHN0cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2RoY2lfbzIgPSB7DQog
CS5yZXN1bWUgPSBzZGhjaV9wY2lfbzJfcmVzdW1lLA0KICNlbmRpZg0KIAkub3BzID0gJnNkaGNp
X3BjaV9vMl9vcHMsDQorCS5wcml2X3NpemUgPSBzaXplb2Yoc3RydWN0IG8yX2hvc3QpLA0KIH07
DQo=
