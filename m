Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA09295839
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Oct 2020 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503237AbgJVGES (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Oct 2020 02:04:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34657 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503238AbgJVGER (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2020 02:04:17 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 09M645AF0010102, This message is accepted by code: ctloc85258
Received: from RSEXMBS02.realsil.com.cn ([172.29.17.196])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 09M645AF0010102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 14:04:06 +0800
Received: from RSEXMBS02.realsil.com.cn (172.29.17.196) by
 RSEXMBS02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 22 Oct 2020 14:04:05 +0800
Received: from RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef]) by
 RSEXMBS02.realsil.com.cn ([fe80::f8fc:93be:88f4:52ef%7]) with mapi id
 15.01.2044.004; Thu, 22 Oct 2020 14:04:05 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMy8zXSBtbWM6IHJ0c3g6IEFkZCBTRCBFeHByZXNz?= =?utf-8?Q?_mode_support_for_RTS5261?=
Thread-Topic: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWkt9BwBVjFlHHd0at7hFkgpI9BamhuQuAgAGMm/A=
Date:   Thu, 22 Oct 2020 06:04:05 +0000
Message-ID: <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn>
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
In-Reply-To: <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gT24gRnJpLCAyNSBTZXAgMjAyMCBhdCAwMzo1NywgPHJ1aV9mZW5nQHJlYWxzaWwuY29t
LmNuPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFJ1aSBGZW5nIDxydWlfZmVuZ0ByZWFsc2lsLmNv
bS5jbj4NCj4gPg0KPiA+IFJUUzUyNjEgc3VwcG9ydCBsZWdhY3kgU0QgbW9kZSBhbmQgU0QgRXhw
cmVzcyBtb2RlLg0KPiA+IEluIFNENy54LCBTRCBhc3NvY2lhdGlvbiBpbnRyb2R1Y2UgU0QgRXhw
cmVzcyBhcyBhIG5ldyBtb2RlLg0KPiA+IFRoaXMgcGF0Y2ggbWFrZXMgUlRTNTI2MSBzdXBwb3J0
IFNEIEV4cHJlc3MgbW9kZS4NCj4gDQo+IEFzIHBlciBwYXRjaCAyLCBjYW4geW91IHBsZWFzZSBh
ZGQgc29tZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHdoYXQgY2hhbmdlcw0KPiBhcmUgbmVlZGVk
IHRvIHN1cHBvcnQgU0QgRXhwcmVzcz8gVGhpcyBqdXN0IHN0YXRlcyB0aGF0IHRoZSBzdXBwb3J0
IGlzDQo+IGltcGxlbWVudGVkLCBidXQgcGxlYXNlIGVsYWJvcmF0ZSBob3cuDQo+IA0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUnVpIEZlbmcgPHJ1aV9mZW5nQHJlYWxzaWwuY29tLmNuPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMgfCA1OQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU5IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3J0c3hf
cGNpX3NkbW1jLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KPiA+
IGluZGV4IDI3NjNhMzc2YjA1NC4uZWZkZTM3NGE0YTVlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
cnRzeF9wY2lfc2RtbWMuYw0KPiA+IEBAIC04OTUsNyArODk1LDkgQEAgc3RhdGljIGludCBzZF9z
ZXRfYnVzX3dpZHRoKHN0cnVjdA0KPiA+IHJlYWx0ZWtfcGNpX3NkbW1jICpob3N0LCAgc3RhdGlj
IGludCBzZF9wb3dlcl9vbihzdHJ1Y3QNCj4gPiByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCkgIHsN
Cj4gPiAgICAgICAgIHN0cnVjdCBydHN4X3BjciAqcGNyID0gaG9zdC0+cGNyOw0KPiA+ICsgICAg
ICAgc3RydWN0IG1tY19ob3N0ICptbWMgPSBob3N0LT5tbWM7DQo+ID4gICAgICAgICBpbnQgZXJy
Ow0KPiA+ICsgICAgICAgdTMyIHZhbDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGhvc3QtPnBvd2Vy
X3N0YXRlID09IFNETU1DX1BPV0VSX09OKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPiBAQCAtOTIyLDYgKzkyNCwxNCBAQCBzdGF0aWMgaW50IHNkX3Bvd2VyX29uKHN0cnVjdCBy
ZWFsdGVrX3BjaV9zZG1tYw0KPiAqaG9zdCkNCj4gPiAgICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+DQo+ID4gKyAgICAgICBpZiAoUENJX1BJ
RChwY3IpID09IFBJRF81MjYxKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IHJ0c3hfcGNp
X3JlYWRsKHBjciwgUlRTWF9CSVBSKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHZhbCAmIFNE
X1dSSVRFX1BST1RFQ1QpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwY3ItPmV4dHJh
X2NhcHMgJj0NCj4gfkVYVFJBX0NBUFNfU0RfRVhQUkVTUzsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBtbWMtPmNhcHMyICY9IH4oTU1DX0NBUDJfU0RfRVhQIHwNCj4gPiArIE1NQ19DQVAy
X1NEX0VYUF8xXzJWKTsNCj4gDQo+IFRoaXMgbG9va3MgYSBiaXQgd2VpcmQgdG8gbWUuIEZvciBh
IHdyaXRlIHByb3RlY3RlZCBjYXJkIHlvdSB3YW50IHRvIGRpc2FibGUgdGhlDQo+IFNEX0VYUFJF
U1Mgc3VwcG9ydCwgcmlnaHQ/DQo+IA0KUmlnaHQuIElmIGVuZCB1c2VyIGluc2VydCBhIHdyaXRl
IHByb3RlY3RlZCBTRCBleHByZXNzIGNhcmQsIEkgd2lsbCBkaXNhYmxlIFNEX0VYUFJFU1Mgc3Vw
cG9ydC4NCklmIGhvc3Qgc3dpdGNoIHRvIFNEIEVYUFJFU1MgbW9kZSwgdGhlIGNhcmQgd2lsbCBi
ZSByZWNvZ25pemVkIGFzIGEgd3JpdGFibGUgUENJZS9OVk1lIGRldmljZSwNCkkgdGhpbmsgdGhp
cyBpcyBub3QgZW5kIHVzZXIncyBwdXJwb3NlLg0KDQo+IElzIHRoZXJlIG5vIG1lY2hhbmlzbSB0
byBzdXBwb3J0IHJlYWQtb25seSBQQ0llL05WTWUgYmFzZWQgc3RvcmFnZSBkZXZpY2VzPw0KPiBJ
ZiB0aGF0IGlzIHRoZSBjYXNlLCBtYXliZSBpdCdzIHNpbXBseSBiZXR0ZXIgdG8gbm90IHN1cHBv
cnQgdGhlIHJlYWRvbmx5IG9wdGlvbg0KPiBhdCBhbGwgZm9yIFNEIGV4cHJlc3MgY2FyZHM/DQo+
IA0KSSB0aGluayB0aGVyZSdzIG5vIG1lY2hhbmlzbSB0byBzdXBwb3J0IHJlYWQtb25seSBQQ0ll
L05WTWUgYmFzZWQgc3RvcmFnZSBkZXZpY2VzLg0KQnV0IGRpZmZlcmVudCB2ZW5kZXJzIG1heSBo
YXZlIGRpZmZlcmVudCBvcGluaW9ucy4gVGhpcyBpcyBvbmx5IFJlYWx0ZWsncyBvcGluaW9uLg0K
DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAg
ICBob3N0LT5wb3dlcl9zdGF0ZSA9IFNETU1DX1BPV0VSX09OOw0KPiA+ICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPiBAQCAtMTEyNyw2ICsxMTM3LDggQEAgc3RhdGljIGludCBzZG1tY19n
ZXRfY2Qoc3RydWN0IG1tY19ob3N0ICptbWMpDQo+ID4gICAgICAgICBpZiAodmFsICYgU0RfRVhJ
U1QpDQo+ID4gICAgICAgICAgICAgICAgIGNkID0gMTsNCj4gPg0KPiA+ICsgICAgICAgaWYgKHBj
ci0+ZXh0cmFfY2FwcyAmIEVYVFJBX0NBUFNfU0RfRVhQUkVTUykNCj4gPiArICAgICAgICAgICAg
ICAgbW1jLT5jYXBzMiB8PSBNTUNfQ0FQMl9TRF9FWFAgfA0KPiBNTUNfQ0FQMl9TRF9FWFBfMV8y
VjsNCj4gDQo+IFRoaXMgbG9va3Mgd3JvbmcuIFlvdSBzaG91bGRuJ3QgYmUgdXNpbmcgdGhlIC0+
Z2V0X2NkKCkgY2FsbGJhY2sgdG8gcmUtZW5hYmxlDQo+IG1tYyBjYXBzLg0KPiANCj4gTm9ybWFs
bHkgc2V0IHRoZSBtbWMgY2FwcyB3aGlsZSBob3N0IHByb2JlcyAoZnJvbSB0aGUgLT5wcm9iZSgp
IGNhbGxiYWNrKSwgYnV0DQo+IEkgZ3Vlc3MgdGhpcyBpcyBraW5kIG9mIGEgc3BlY2lhbCBjYXNl
LCBhcyB0aGUgcmVhZC1vbmx5IHN3aXRjaCBzdGF0ZSBpc24ndCBrbm93bg0KPiB1bnRpbCB3ZSBo
YXZlIHBvd2VyZWQgb24gdGhlIGNhcmQsIHJpZ2h0Pw0KPiANClJpZ2h0Lg0KDQo+IElmIHRoYXQg
aXMgdGhlIGNhc2UsIEkgc3VnZ2VzdCB0byByZS1lbmFibGUgdGhlIG1tYyBjYXBzIGZyb20gdGhl
DQo+IC0+c2V0X2lvcygpIGNhbGxiYWNrIGluc3RlYWQsIHdoZW4gaW9zLT5wb3dlcl9tb2RlID09
IE1NQ19QT1dFUl9PRkYuDQo+IA0KSSB3aWxsIG1vdmUgaXQgdG8gc2RfcG93ZXJfb24oKS4NCg0K
PiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwY3ItPnBjcl9tdXRleCk7DQo+ID4NCj4gPiAgICAg
ICAgIHJldHVybiBjZDsNCj4gPiBAQCAtMTMwOCw2ICsxMzIwLDUwIEBAIHN0YXRpYyBpbnQgc2Rt
bWNfZXhlY3V0ZV90dW5pbmcoc3RydWN0DQo+IG1tY19ob3N0ICptbWMsIHUzMiBvcGNvZGUpDQo+
ID4gICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzZG1t
Y19pbml0X3NkX2V4cHJlc3Moc3RydWN0IG1tY19ob3N0ICptbWMsIHN0cnVjdCBtbWNfaW9zDQo+
ID4gKyppb3MpIHsNCj4gPiArICAgICAgIHUzMiByZWxpbmtfdGltZSwgdmFsOw0KPiA+ICsgICAg
ICAgc3RydWN0IHJlYWx0ZWtfcGNpX3NkbW1jICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPiAr
ICAgICAgIHN0cnVjdCBydHN4X3BjciAqcGNyID0gaG9zdC0+cGNyOw0KPiA+ICsNCj4gPiArICAg
ICAgIC8qDQo+ID4gKyAgICAgICAgKiBJZiBjYXJkIGhhcyBQQ0llIGF2YWlsYWJpbGl0eSBhbmQg
V1AgaWYgb2ZmLA0KPiA+ICsgICAgICAgICogcmVhZGVyIHN3aXRjaCB0byBQQ0llIG1vZGUuDQo+
ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIHZhbCA9IHJ0c3hfcGNpX3JlYWRsKHBjciwgUlRT
WF9CSVBSKTsNCj4gPiArICAgICAgIGlmICghKHZhbCAmIFNEX1dSSVRFX1BST1RFQ1QpKSB7DQo+
IA0KPiBUaGlzIHNob3VsZCBub3QgYmUgbmVlZGVkLCBhcyB5b3UgaGF2ZSBhbHJlYWR5IGNoZWNr
ZWQgdGhlIHdyaXRlIHByb3RlY3QgYml0DQo+IGJlZm9yZSBlbmFibGluZyB0aGUgbW1jIGNhcHMg
Zm9yIFNEIEVYUFJFU1MsIHJpZ2h0Pw0KPiANClJpZ2h0Lg0KDQo+ID4gKyAgICAgICAgICAgICAg
IC8qIFNldCByZWxpbmtfdGltZSBmb3IgY2hhbmdpbmcgdG8gUENJZSBjYXJkICovDQo+ID4gKyAg
ICAgICAgICAgICAgIHJlbGlua190aW1lID0gMHg4RkZGOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNyLCAweEZGMDEsIDB4RkYsIHJlbGlua190
aW1lKTsNCj4gPiArICAgICAgICAgICAgICAgcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNyLCAw
eEZGMDIsIDB4RkYsIHJlbGlua190aW1lID4+DQo+IDgpOw0KPiA+ICsgICAgICAgICAgICAgICBy
dHN4X3BjaV93cml0ZV9yZWdpc3RlcihwY3IsIDB4RkYwMywgMHgwMSwgcmVsaW5rX3RpbWUNCj4g
PiArID4+IDE2KTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHJ0c3hfcGNpX3dyaXRlX3Jl
Z2lzdGVyKHBjciwgUEVUWENGRywgMHg4MCwgMHg4MCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJ0
c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgTERPX1ZDQ19DRkcwLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIFJUUzUyNjFfTERPMV9PQ1BfVEhEX01BU0ssDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcGNyLT5vcHRpb24uc2RfODAwbUFfb2NwX3RoZCk7DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAocGNyLT5vcHMtPmRpc2FibGVfYXV0b19ibGluaykNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBwY3ItPm9wcy0+ZGlzYWJsZV9hdXRvX2JsaW5rKHBjcik7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAvKiBGb3IgUENJZS9OVk1lIG1vZGUgY2FuJ3QgZW50
ZXIgZGVsaW5rIGlzc3VlICovDQo+ID4gKyAgICAgICAgICAgICAgIHBjci0+aHdfcGFyYW0uaW50
ZXJydXB0X2VuICY9IH4oU0RfSU5UX0VOKTsNCj4gPiArICAgICAgICAgICAgICAgcnRzeF9wY2lf
d3JpdGVsKHBjciwgUlRTWF9CSUVSLA0KPiA+ICsgcGNyLT5od19wYXJhbS5pbnRlcnJ1cHRfZW4p
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNy
LCBSVFM1MjYwX0FVVE9MT0FEX0NGRzQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgUlRT
NTI2MV9BVVhfQ0xLXzE2TV9FTiwNCj4gUlRTNTI2MV9BVVhfQ0xLXzE2TV9FTik7DQo+ID4gKyAg
ICAgICAgICAgICAgIHJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgUlRTNTI2MV9GV19DRkcw
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIFJUUzUyNjFfRldfRU5URVJfRVhQUkVTUywN
Cj4gUlRTNTI2MV9GV19FTlRFUl9FWFBSRVNTKTsNCj4gPiArICAgICAgICAgICAgICAgcnRzeF9w
Y2lfd3JpdGVfcmVnaXN0ZXIocGNyLCBSVFM1MjYxX0ZXX0NGRzEsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgUlRTNTI2MV9NQ1VfQlVTX1NFTF9NQVNLIHwNCj4gUlRTNTI2MV9NQ1VfQ0xP
Q0tfU0VMX01BU0sNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB8IFJUUzUyNjFfTUNVX0NM
T0NLX0dBVElORyB8DQo+IFJUUzUyNjFfRFJJVkVSX0VOQUJMRV9GVywNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBSVFM1MjYxX01DVV9DTE9DS19TRUxfMTZNIHwNCj4gUlRTNTI2MV9NQ1Vf
Q0xPQ0tfR0FUSU5HDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfCBSVFM1MjYxX0RSSVZF
Ul9FTkFCTEVfRlcpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2hvc3Rfb3BzIHJlYWx0ZWtf
cGNpX3NkbW1jX29wcyA9IHsNCj4gPiAgICAgICAgIC5wcmVfcmVxID0gc2RtbWNfcHJlX3JlcSwN
Cj4gPiAgICAgICAgIC5wb3N0X3JlcSA9IHNkbW1jX3Bvc3RfcmVxLA0KPiA+IEBAIC0xMzE3LDYg
KzEzNzMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1tY19ob3N0X29wcw0KPiByZWFsdGVrX3Bj
aV9zZG1tY19vcHMgPSB7DQo+ID4gICAgICAgICAuZ2V0X2NkID0gc2RtbWNfZ2V0X2NkLA0KPiA+
ICAgICAgICAgLnN0YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRjaCA9IHNkbW1jX3N3aXRjaF92b2x0
YWdlLA0KPiA+ICAgICAgICAgLmV4ZWN1dGVfdHVuaW5nID0gc2RtbWNfZXhlY3V0ZV90dW5pbmcs
DQo+ID4gKyAgICAgICAuaW5pdF9zZF9leHByZXNzID0gc2RtbWNfaW5pdF9zZF9leHByZXNzLA0K
PiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGluaXRfZXh0cmFfY2FwcyhzdHJ1Y3QgcmVh
bHRla19wY2lfc2RtbWMgKmhvc3QpIEBADQo+ID4gLTEzMzgsNiArMTM5NSw4IEBAIHN0YXRpYyB2
b2lkIGluaXRfZXh0cmFfY2FwcyhzdHJ1Y3QgcmVhbHRla19wY2lfc2RtbWMNCj4gKmhvc3QpDQo+
ID4gICAgICAgICAgICAgICAgIG1tYy0+Y2FwcyB8PSBNTUNfQ0FQXzhfQklUX0RBVEE7DQo+ID4g
ICAgICAgICBpZiAocGNyLT5leHRyYV9jYXBzICYgRVhUUkFfQ0FQU19OT19NTUMpDQo+ID4gICAg
ICAgICAgICAgICAgIG1tYy0+Y2FwczIgfD0gTU1DX0NBUDJfTk9fTU1DOw0KPiA+ICsgICAgICAg
aWYgKHBjci0+ZXh0cmFfY2FwcyAmIEVYVFJBX0NBUFNfU0RfRVhQUkVTUykNCj4gPiArICAgICAg
ICAgICAgICAgbW1jLT5jYXBzMiB8PSBNTUNfQ0FQMl9TRF9FWFAgfA0KPiBNTUNfQ0FQMl9TRF9F
WFBfMV8yVjsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHJlYWx0ZWtfaW5pdF9ob3N0
KHN0cnVjdCByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCkNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+
DQo+IA0KPiBBIGZvbGxvdyB1cCBxdWVzdGlvbjoNCj4gDQo+IEJhc2VkIHVwb24geW91ciBmZWVk
YmFjayBmcm9tIG91ciBlYXJsaWVyIGRpc2N1c3Npb25zLCBJIGJlbGlldmUgeW91IHN0YXRlZA0K
PiB0aGF0IHRoZSBjYXJkIHJlYWRlciBkcml2ZXIgKHJ0c3hfcGNpX2RyaXZlcikgd2lsbCB1bnJl
Z2lzdGVyIHRoZSBjb3JyZXNwb25kaW5nDQo+IG1mZC9wbGF0Zm9ybSBkZXZpY2UgdGhhdCBjb3Jy
ZXNwb25kcyB0byB0aGUgcnRzeF9wY2lfc2RtbWNfZHJpdmVyIC0gd2hlbiBpdA0KPiBnZXRzIGNv
bmZpZ3VyZWQgdG8gbWFuYWdlIGEgUENJZS9OVk1lIGJhc2VkIHN0b3JhZ2UgZGV2aWNlLiBDb3Jy
ZWN0Pw0KPiANCj4gUGVyaGFwcyBJIGRpZG4ndCBnZXQgdGhhdCBwYXJ0IGNvcnJlY3RseSwgYnV0
IGlmIHRoaXMgaXMgdGhlIGNhc2UsIGl0IG1lYW5zIHRoYXQgdGhlDQo+IC0+cmVtb3ZlKCkgY2Fs
bGJhY2sgKHJ0c3hfcGNpX3NkbW1jX2Rydl9yZW1vdmUoKSkgd2lsbCBiZSBpbnZva2VkLg0KPiBG
dXJ0aGVybW9yZSwgdGhpcyB3aWxsIGNhdXNlIHRoZSAtPnNldF9pb3MoKSBjYWxsYmFjayB0byBi
ZSBpbnZva2VkIHdoZW4gdGhlDQo+IGNvcmUgY2FsbHMgbW1jX3Bvd2VyX29mZigpIGluIHRoYXQg
cGF0aC4gSXNuJ3QgdGhhdCBhIHByb2JsZW0gdGhhdCB5b3UgbmVlZCB0bw0KPiBhZGRyZXNzPw0K
PiANCkFmdGVyIGluaXRfc2RfZXhwcmVzcygpIGlzIGNhbGxlZCwgbW1jX3Bvd2VyX29mZigpIHdp
bGwgbm90IHdvcmssIHNvIGl0J3Mgbm90IGEgcHJvYmxlbSBJIG5lZWQgdG8NCmFkZHJlc3MuDQoN
Cj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUg
ZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
