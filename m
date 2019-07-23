Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381EF718D1
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbfGWNAX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 09:00:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44629 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390003AbfGWNAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 09:00:23 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NCuche031209;
        Tue, 23 Jul 2019 15:00:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=U2j5ln7jYCtd1p+J1xFj0IptnUXk/Xn1rVVueI9MqLE=;
 b=DUWzLBWI4BpAiGQDH8E+mX6rxeXz0cVXA6yCty1JxWaBW2BoskH7fWzLkD1DfhHxUg0P
 B8j72xVXuJOOLpPtEC4ATpCjaXDFQed8Vexm/bFlMU2RFOOkjkAvNsaCoPgi/GzIBF2q
 IVzPjUaZVBLZLrGawihnsrRznhGXN4iIC2h9AS7TwNaa1dJ6ojiOG48E8CeImcBRTwia
 QfRpHZ3quWH3LdGpnvEqb6HTQ05pnRM9zBP7z1qVQeW/Y0gXfO54dPLJoWMbach7njfv
 lwLysfxXy+robo68yM7JUK/Bjnh6GflqSPC/KkHFBDyW6tgnwOsJElr/VlXRLptTDz6p Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tuw7w8as0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Jul 2019 15:00:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58E3031;
        Tue, 23 Jul 2019 13:00:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9C5C4E58;
        Tue, 23 Jul 2019 13:00:13 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 15:00:13 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Tue, 23 Jul 2019 15:00:13 +0200
From:   Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3] mmc: mmci: Clarify comments and some code for busy
 detection
Thread-Topic: [PATCH V3] mmc: mmci: Clarify comments and some code for busy
 detection
Thread-Index: AQHVQVIZowCAzWo39kqOtM0ybn5Tl6bYCPAA
Date:   Tue, 23 Jul 2019 13:00:13 +0000
Message-ID: <7a135c30-d659-a58e-4bb1-0daceee17c97@st.com>
References: <20190723122809.17509-1-ulf.hansson@linaro.org>
In-Reply-To: <20190723122809.17509-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <729B39B8FCC113469DE2C7021CF8094D@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_05:,,
 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQpJIGRpZCBhIHF1aWNrIHRlc3QgYm9vdGluZyBvbiBlbW1jIHdpdGggdGhhdCBu
ZXcgcGF0Y2guDQpMb29rcyBnb29kIHRvIG1lLg0KDQpCZXN0IHJlZ2FyZHMsDQpKZWFuLU5pY29s
YXMuDQoNCk9uIDcvMjMvMTkgMjoyOCBQTSwgVWxmIEhhbnNzb24gd3JvdGU6DQo+IFRoZSBjb2Rl
IGRlYWxpbmcgd2l0aCBidXN5IGRldGVjdGlvbiBpcyBzb21ld2hhdCBjb21wbGljYXRlZC4gSW4g
YSB3YXkgdG8NCj4gbWFrZSBpdCBhIGJpdCBjbGVhcmVyLCBsZXQncyB0cnkgdG8gY2xhcmlmeSB0
aGUgY29tbWVudHMgaW4gdGhlIGNvZGUgYWJvdXQNCj4gaXQuDQo+DQo+IEFkZGl0aW9uYWxseSwg
bW92ZSB0aGUgcGFydCBmb3IgY2xlYXJpbmcgdGhlIHNvIGNhbGxlZCBidXN5IHN0YXJ0IElSUSwg
dG8NCj4gdGhlIHBsYWNlIHdoZXJlIHRoZSBJUlEgaXMgYWN0dWFsbHkgZGVsaXZlcmVkLiBJZGVh
bGx5LCB0aGlzIHNob3VsZCBtYWtlDQo+IHRoZSBjb2RlIGEgYml0IG1vcmUgcm9idXN0Lg0KPg0K
PiBGaW5hbGx5LCB0byBpbXByb3ZlIHVuZGVyc3RhbmRpbmcgb2YgdGhlIGNvZGUgYW5kIHRoZSBz
ZXF1ZW5jZSBvZiB0aGUgYnVzeQ0KPiBkZXRlY3Rpb24sIG1vdmUgdGhlIGNvcnJlc3BvbmRpbmcg
Y29kZSBhcm91bmQgYSBiaXQgaW4gbW1jaV9jbWRfaXJxKCkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiAtLS0NCj4NCj4gQ2hhbmdl
cyBpbiB2MzoNCj4gCS0gTW92ZSBzb21lIGNvZGUgYXJyb3VuZCB0byBtYWtlIGl0IGV2ZW4gbW9y
ZSBjbGVhciBob3cgdGhlIGJ1c3kNCj4gCWRldGVjdGlvbiB3b3Jrcy4gVXBkYXRlZCB0aGUgY2hh
bmdlbG9nIGFjY29yZGluZ2x5Lg0KPg0KPiAtLS0NCj4gICBkcml2ZXJzL21tYy9ob3N0L21tY2ku
YyB8IDY5ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L21tY2ku
Yw0KPiBpbmRleCAzNTY4MzNhNjA2ZDUuLjRjMzVlNzYwOWM4OSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9tbWNpLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMNCj4g
QEAgLTEyMjIsNDcgKzEyMjIsNTggQEAgbW1jaV9jbWRfaXJxKHN0cnVjdCBtbWNpX2hvc3QgKmhv
c3QsIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kLA0KPiAgIAkgICAgICAoTUNJX0NNRENSQ0ZBSUx8
TUNJX0NNRFRJTUVPVVR8TUNJX0NNRFNFTlR8TUNJX0NNRFJFU1BFTkQpKSkNCj4gICAJCXJldHVy
bjsNCj4gICANCj4gLQkvKg0KPiAtCSAqIFNUIE1pY3JvIHZhcmlhbnQ6IGhhbmRsZSBidXN5IGRl
dGVjdGlvbi4NCj4gLQkgKi8NCj4gKwkvKiBIYW5kbGUgYnVzeSBkZXRlY3Rpb24gb24gREFUMCBp
ZiB0aGUgdmFyaWFudCBzdXBwb3J0cyBpdC4gKi8NCj4gICAJaWYgKGJ1c3lfcmVzcCAmJiBob3N0
LT52YXJpYW50LT5idXN5X2RldGVjdCkgew0KPiAgIA0KPiAtCQkvKiBXZSBhcmUgYnVzeSB3aXRo
IGEgY29tbWFuZCwgcmV0dXJuICovDQo+IC0JCWlmIChob3N0LT5idXN5X3N0YXR1cyAmJg0KPiAt
CQkgICAgKHN0YXR1cyAmIGhvc3QtPnZhcmlhbnQtPmJ1c3lfZGV0ZWN0X2ZsYWcpKQ0KPiAtCQkJ
cmV0dXJuOw0KPiAtDQo+ICAgCQkvKg0KPiAtCQkgKiBXZSB3ZXJlIG5vdCBidXN5LCBidXQgd2Ug
bm93IGdvdCBhIGJ1c3kgcmVzcG9uc2Ugb24NCj4gLQkJICogc29tZXRoaW5nIHRoYXQgd2FzIG5v
dCBhbiBlcnJvciwgYW5kIHdlIGRvdWJsZS1jaGVjaw0KPiAtCQkgKiB0aGF0IHRoZSBzcGVjaWFs
IGJ1c3kgc3RhdHVzIGJpdCBpcyBzdGlsbCBzZXQgYmVmb3JlDQo+IC0JCSAqIHByb2NlZWRpbmcu
DQo+ICsJCSAqIEJlZm9yZSB1bm1hc2tpbmcgZm9yIHRoZSBidXN5IGVuZCBJUlEsIGNvbmZpcm0g
dGhhdCB0aGUNCj4gKwkJICogY29tbWFuZCB3YXMgc2VudCBzdWNjZXNzZnVsbHkuIFRvIGtlZXAg
dHJhY2sgb2YgaGF2aW5nIGENCj4gKwkJICogY29tbWFuZCBpbi1wcm9ncmVzcywgd2FpdGluZyBm
b3IgYnVzeSBzaWduYWxpbmcgdG8gZW5kLA0KPiArCQkgKiBzdG9yZSB0aGUgc3RhdHVzIGluIGhv
c3QtPmJ1c3lfc3RhdHVzLg0KPiArCQkgKg0KPiArCQkgKiBOb3RlIHRoYXQsIHRoZSBjYXJkIG1h
eSBuZWVkIGEgY291cGxlIG9mIGNsb2NrIGN5Y2xlcyBiZWZvcmUNCj4gKwkJICogaXQgc3RhcnRz
IHNpZ25hbGluZyBidXN5IG9uIERBVDAsIGhlbmNlIHJlLXJlYWQgdGhlDQo+ICsJCSAqIE1NQ0lT
VEFUVVMgcmVnaXN0ZXIgaGVyZSwgdG8gYWxsb3cgdGhlIGJ1c3kgYml0IHRvIGJlIHNldC4NCj4g
KwkJICogUG90ZW50aWFsbHkgd2UgbWF5IGV2ZW4gbmVlZCB0byBwb2xsIHRoZSByZWdpc3RlciBm
b3IgYQ0KPiArCQkgKiB3aGlsZSwgdG8gYWxsb3cgaXQgdG8gYmUgc2V0LCBidXQgdGVzdHMgaW5k
aWNhdGVzIHRoYXQgaXQNCj4gKwkJICogaXNuJ3QgbmVlZGVkLg0KPiAgIAkJICovDQo+ICAgCQlp
ZiAoIWhvc3QtPmJ1c3lfc3RhdHVzICYmDQo+ICAgCQkgICAgIShzdGF0dXMgJiAoTUNJX0NNRENS
Q0ZBSUx8TUNJX0NNRFRJTUVPVVQpKSAmJg0KPiAgIAkJICAgIChyZWFkbChiYXNlICsgTU1DSVNU
QVRVUykgJiBob3N0LT52YXJpYW50LT5idXN5X2RldGVjdF9mbGFnKSkgew0KPiAgIA0KPiAtCQkJ
LyogQ2xlYXIgdGhlIGJ1c3kgc3RhcnQgSVJRICovDQo+IC0JCQl3cml0ZWwoaG9zdC0+dmFyaWFu
dC0+YnVzeV9kZXRlY3RfbWFzaywNCj4gLQkJCSAgICAgICBob3N0LT5iYXNlICsgTU1DSUNMRUFS
KTsNCj4gLQ0KPiAtCQkJLyogVW5tYXNrIHRoZSBidXN5IGVuZCBJUlEgKi8NCj4gICAJCQl3cml0
ZWwocmVhZGwoYmFzZSArIE1NQ0lNQVNLMCkgfA0KPiAgIAkJCSAgICAgICBob3N0LT52YXJpYW50
LT5idXN5X2RldGVjdF9tYXNrLA0KPiAgIAkJCSAgICAgICBiYXNlICsgTU1DSU1BU0swKTsNCj4g
LQkJCS8qDQo+IC0JCQkgKiBOb3cgY2FjaGUgdGhlIGxhc3QgcmVzcG9uc2Ugc3RhdHVzIGNvZGUg
KHVudGlsDQo+IC0JCQkgKiB0aGUgYnVzeSBiaXQgZ29lcyBsb3cpLCBhbmQgcmV0dXJuLg0KPiAt
CQkJICovDQo+ICsNCj4gICAJCQlob3N0LT5idXN5X3N0YXR1cyA9DQo+ICAgCQkJCXN0YXR1cyAm
IChNQ0lfQ01EU0VOVHxNQ0lfQ01EUkVTUEVORCk7DQo+ICAgCQkJcmV0dXJuOw0KPiAgIAkJfQ0K
PiAgIA0KPiAgIAkJLyoNCj4gLQkJICogQXQgdGhpcyBwb2ludCB3ZSBhcmUgbm90IGJ1c3kgd2l0
aCBhIGNvbW1hbmQsIHdlIGhhdmUNCj4gLQkJICogbm90IHJlY2VpdmVkIGEgbmV3IGJ1c3kgcmVx
dWVzdCwgY2xlYXIgYW5kIG1hc2sgdGhlIGJ1c3kNCj4gLQkJICogZW5kIElSUSBhbmQgZmFsbCB0
aHJvdWdoIHRvIHByb2Nlc3MgdGhlIElSUS4NCj4gKwkJICogSWYgdGhlcmUgaXMgYSBjb21tYW5k
IGluLXByb2dyZXNzIHRoYXQgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5DQo+ICsJCSAqIHNlbnQsIHRo
ZW4gYmFpbCBvdXQgaWYgYnVzeSBzdGF0dXMgaXMgc2V0IGFuZCB3YWl0IGZvciB0aGUNCj4gKwkJ
ICogYnVzeSBlbmQgSVJRLg0KPiArCQkgKg0KPiArCQkgKiBOb3RlIHRoYXQsIHRoZSBIVyB0cmln
Z2VycyBhbiBJUlEgb24gYm90aCBlZGdlcyB3aGlsZQ0KPiArCQkgKiBtb25pdG9yaW5nIERBVDAg
Zm9yIGJ1c3kgY29tcGxldGlvbiwgYnV0IHRoZXJlIGlzIG9ubHkgb25lDQo+ICsJCSAqIHN0YXR1
cyBiaXQgaW4gTU1DSVNUQVRVUyBmb3IgdGhlIGJ1c3kgc3RhdGUuIFRoZXJlZm9yZQ0KPiArCQkg
KiBib3RoIHRoZSBzdGFydCBhbmQgdGhlIGVuZCBpbnRlcnJ1cHRzIG5lZWRzIHRvIGJlIGNsZWFy
ZWQsDQo+ICsJCSAqIG9uZSBhZnRlciB0aGUgb3RoZXIuIFNvLCBjbGVhciB0aGUgYnVzeSBzdGFy
dCBJUlEgaGVyZS4NCj4gKwkJICovDQo+ICsJCWlmIChob3N0LT5idXN5X3N0YXR1cyAmJg0KPiAr
CQkgICAgKHN0YXR1cyAmIGhvc3QtPnZhcmlhbnQtPmJ1c3lfZGV0ZWN0X2ZsYWcpKSB7DQo+ICsJ
CQl3cml0ZWwoaG9zdC0+dmFyaWFudC0+YnVzeV9kZXRlY3RfbWFzaywNCj4gKwkJCSAgICAgICBo
b3N0LT5iYXNlICsgTU1DSUNMRUFSKTsNCj4gKwkJCXJldHVybjsNCj4gKwkJfQ0KPiArDQo+ICsJ
CS8qDQo+ICsJCSAqIElmIHRoZXJlIGlzIGEgY29tbWFuZCBpbi1wcm9ncmVzcyB0aGF0IGhhcyBi
ZWVuIHN1Y2Nlc3NmdWxseQ0KPiArCQkgKiBzZW50IGFuZCB0aGUgYnVzeSBiaXQgaXNuJ3Qgc2V0
LCBpdCBtZWFucyB3ZSBoYXZlIHJlY2VpdmVkDQo+ICsJCSAqIHRoZSBidXN5IGVuZCBJUlEuIENs
ZWFyIGFuZCBtYXNrIHRoZSBJUlEsIHRoZW4gY29udGludWUgdG8NCj4gKwkJICogcHJvY2VzcyB0
aGUgY29tbWFuZC4NCj4gICAJCSAqLw0KPiAgIAkJaWYgKGhvc3QtPmJ1c3lfc3RhdHVzKSB7DQo+
ICAgDQo+IEBAIC0xNTA4LDE0ICsxNTE5LDggQEAgc3RhdGljIGlycXJldHVybl90IG1tY2lfaXJx
KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gICAJCX0NCj4gICANCj4gICAJCS8qDQo+IC0JCSAq
IFdlIGludGVudGlvbmFsbHkgY2xlYXIgdGhlIE1DSV9TVF9DQVJEQlVTWSBJUlEgKGlmIGl0J3MN
Cj4gLQkJICogZW5hYmxlZCkgaW4gbW1jaV9jbWRfaXJxKCkgZnVuY3Rpb24gd2hlcmUgU1QgTWlj
cm8gYnVzeQ0KPiAtCQkgKiBkZXRlY3Rpb24gdmFyaWFudCBpcyBoYW5kbGVkLiBDb25zaWRlcmlu
ZyB0aGUgSFcgc2VlbXMgdG8gYmUNCj4gLQkJICogdHJpZ2dlcmluZyB0aGUgSVJRIG9uIGJvdGgg
ZWRnZXMgd2hpbGUgbW9uaXRvcmluZyBEQVQwIGZvcg0KPiAtCQkgKiBidXN5IGNvbXBsZXRpb24g
YW5kIHRoYXQgc2FtZSBzdGF0dXMgYml0IGlzIHVzZWQgdG8gbW9uaXRvcg0KPiAtCQkgKiBzdGFy
dCBhbmQgZW5kIG9mIGJ1c3kgZGV0ZWN0aW9uLCBzcGVjaWFsIGNhcmUgbXVzdCBiZSB0YWtlbg0K
PiAtCQkgKiB0byBtYWtlIHN1cmUgdGhhdCBib3RoIHN0YXJ0IGFuZCBlbmQgaW50ZXJydXB0cyBh
cmUgYWx3YXlzDQo+IC0JCSAqIGNsZWFyZWQgb25lIGFmdGVyIHRoZSBvdGhlci4NCj4gKwkJICog
QnVzeSBkZXRlY3Rpb24gaXMgbWFuYWdlZCBieSBtbWNpX2NtZF9pcnEoKSwgaW5jbHVkaW5nIHRv
DQo+ICsJCSAqIGNsZWFyIHRoZSBjb3JyZXNwb25kaW5nIElSUS4NCj4gICAJCSAqLw0KPiAgIAkJ
c3RhdHVzICY9IHJlYWRsKGhvc3QtPmJhc2UgKyBNTUNJTUFTSzApOw0KPiAgIAkJaWYgKGhvc3Qt
PnZhcmlhbnQtPmJ1c3lfZGV0ZWN0KQ0KDQo=
