Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDF713A2
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfGWIMi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 04:12:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38673 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730388AbfGWIMi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 04:12:38 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N8BIso008018;
        Tue, 23 Jul 2019 10:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=YrknJftt6VIlHpGtrvVzemnK/I6k/YYARggXDgpVmRk=;
 b=P3rvtsObr/ZvnHZT31I0T5NyWd74hlJ7eBMgnwt4mMhXm7SBkUWOQ7rRMkrTkDqFtZna
 v2Vsq9bUbE4xmzjEAc6YJRNvJiz79EyNx3922phFb+1dc3dORi8dKNNGjhBSyfj8yFPz
 h4j0MSVeLHEkbDNEbczSxju/EcgEr3g0RUNEYEEhYbc2hRN2nAQZqSsuBxs7ixuntd58
 pZht/4nBdw5dYEjEa4fznJBChwSxaAg295VJMxOqRVj3POpbQXNC8Tn0zPobvdQJu9vA
 mttgAcHW+fnc0BEz611xpyt4fiFgKko/6G68e2klTkruYVbGj9AsVTEhoka7ri1kdLaz cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tuw7w6xh1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Jul 2019 10:12:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6213434;
        Tue, 23 Jul 2019 08:12:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 307752529;
        Tue, 23 Jul 2019 08:12:22 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 10:12:21 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Tue, 23 Jul 2019 10:12:21 +0200
From:   Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: mmci: Clarify comments and some code for busy
 detection
Thread-Topic: [PATCH V2] mmc: mmci: Clarify comments and some code for busy
 detection
Thread-Index: AQHVQH5854V+cStNKE66Ugn9j/c7nabXuiuA
Date:   Tue, 23 Jul 2019 08:12:21 +0000
Message-ID: <793757e2-5722-3597-4f1f-e5e021d1bd77@st.com>
References: <20190722111317.20177-1-ulf.hansson@linaro.org>
In-Reply-To: <20190722111317.20177-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E57BF122BBB0745BD8BC85658D61E44@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGVsbG8gVWxmLCBhbGwsDQoNCkkgdHJpZWQgdGhpcyBuZXcgcGF0Y2ggYW5kIGRpZCBub3QgZmFj
ZSBpc3N1ZXMgc28gZmFyLg0KVGhhdCBpcyBzYWlkLCBzb21lIGNvbW1lbnRzIGJlbG93Lg0KDQpS
ZWdhcmRzLCBKZWFuLU5pY29sYXMuDQoNCk9uIDcvMjIvMTkgMToxMyBQTSwgVWxmIEhhbnNzb24g
d3JvdGU6DQo+IFRoZSBjb2RlIGRlYWxpbmcgd2l0aCBidXN5IGRldGVjdGlvbiBpcyBzb21ld2hh
dCBjb21wbGljYXRlZC4gSW4gYSB3YXkgdG8NCj4gbWFrZSBpdCBhIGJpdCBjbGVhcmVyLCBsZXQn
cyB0cnkgdG8gY2xhcmlmeSB0aGUgY29tbWVudHMgaW4gdGhlIGNvZGUgYWJvdXQNCj4gaXQuDQo+
DQo+IEFkZGl0aW9uYWxseSwgbW92ZSB0aGUgcGFydCBmb3IgY2xlYXJpbmcgdGhlIHNvIGNhbGxl
ZCBidXN5IHN0YXJ0IElSUSwgdG8NCj4gdGhlIHBsYWNlIHdoZXJlIHRoZSBJUlEgaXMgYWN0dWFs
bHkgZGVsaXZlcmVkLiBJZGVhbGx5LCB0aGlzIHNob3VsZCBtYWtlDQo+IHRoZSBjb2RlIGEgYml0
IG1vcmUgcm9idXN0LCBidXQgYWxzbyBhIGJpdCBlYXNpZXIgdG8gdW5kZXJzdGFuZC4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPg0KPiBDaGFuZ2VzIGluIHYyOg0KPiAJLSBTcXVhc2hlZCBwYXRjaCAxIGFuZCBwYXRjaCAy
Lg0KPiAJLSBLZWVwIHRoZSByZS1yZWFkIG9uIHRoZSBzdGF0dXMgcmVnaXN0ZXIsIGJ1dCBleHBs
YWluIHdoeSBpdCdzIG5lZWRlZC4NCj4gCS0gTW92ZSB0aGUgY2xlYXJpbmcgb2YgdGhlIGJ1c3kg
c3RhcnQgSVJRIGF0IHRoZSBwb2ludCBpdCdzIGRlbGl2ZXJlZC4NCj4NCj4gLS0tDQo+ICAgZHJp
dmVycy9tbWMvaG9zdC9tbWNpLmMgfCA2MyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAyOSBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jIGIvZHJp
dmVycy9tbWMvaG9zdC9tbWNpLmMNCj4gaW5kZXggMzU2ODMzYTYwNmQ1Li5kM2Y4NzZjOGMyOTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jDQo+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3QvbW1jaS5jDQo+IEBAIC0xMjIyLDQ3ICsxMjIyLDU4IEBAIG1tY2lfY21kX2lycShz
dHJ1Y3QgbW1jaV9ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNtZCwNCj4gICAJICAg
ICAgKE1DSV9DTURDUkNGQUlMfE1DSV9DTURUSU1FT1VUfE1DSV9DTURTRU5UfE1DSV9DTURSRVNQ
RU5EKSkpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+IC0JLyoNCj4gLQkgKiBTVCBNaWNybyB2YXJp
YW50OiBoYW5kbGUgYnVzeSBkZXRlY3Rpb24uDQo+IC0JICovDQo+ICsJLyogSGFuZGxlIGJ1c3kg
ZGV0ZWN0aW9uIG9uIERBVDAgaWYgdGhlIHZhcmlhbnQgc3VwcG9ydHMgaXQuICovDQo+ICAgCWlm
IChidXN5X3Jlc3AgJiYgaG9zdC0+dmFyaWFudC0+YnVzeV9kZXRlY3QpIHsNCj4gICANCj4gLQkJ
LyogV2UgYXJlIGJ1c3kgd2l0aCBhIGNvbW1hbmQsIHJldHVybiAqLw0KPiArCQkvKg0KPiArCQkg
KiBJZiB0aGVyZSBpcyBhIGNvbW1hbmQgaW4tcHJvZ3Jlc3MgdGhhdCBoYXMgYmVlbiBzdWNjZXNz
ZnVsbHkNCj4gKwkJICogc2VudCwgdGhlbiBiYWlsIG91dCBpZiBidXN5IHN0YXR1cyBpcyBzZXQg
YW5kIHdhaXQgZm9yIHRoZQ0KPiArCQkgKiBidXN5IGVuZCBJUlEuDQo+ICsJCSAqDQo+ICsJCSAq
IE5vdGUgdGhhdCwgdGhlIEhXIHRyaWdnZXJzIGFuIElSUSBvbiBib3RoIGVkZ2VzIHdoaWxlDQo+
ICsJCSAqIG1vbml0b3JpbmcgREFUMCBmb3IgYnVzeSBjb21wbGV0aW9uLCBidXQgdGhlcmUgaXMg
b25seSBvbmUNCj4gKwkJICogc3RhdHVzIGJpdCBpbiBNTUNJU1RBVFVTIGZvciB0aGUgYnVzeSBz
dGF0ZS4gVGhlcmVmb3JlDQo+ICsJCSAqIGJvdGggdGhlIHN0YXJ0IGFuZCB0aGUgZW5kIGludGVy
cnVwdHMgbmVlZHMgdG8gYmUgY2xlYXJlZCwNCj4gKwkJICogb25lIGFmdGVyIHRoZSBvdGhlci4g
U28sIGNsZWFyIHRoZSBidXN5IHN0YXJ0IElSUSBoZXJlLg0KPiArCQkgKi8NCj4gICAJCWlmICho
b3N0LT5idXN5X3N0YXR1cyAmJg0KPiAtCQkgICAgKHN0YXR1cyAmIGhvc3QtPnZhcmlhbnQtPmJ1
c3lfZGV0ZWN0X2ZsYWcpKQ0KDQpUbyBteSBtaW5kLCBwdXJwb3NlIG9mIHRoYXQgaWYgY29uZGl0
aW9uIGlzIHRvIHdhaXQgZm9yIGJ1c3kgZW5kIGV2ZW50DQp3aGlsZSB0aGUgb25lIGp1c3QgYmVs
b3cgaXMgdG8gY2xlYXIgc3RhcnQgZXZlbnQgYW5kIHVubWFzayBidXN5IGVuZCBpcnEuDQpTbyBJ
IHRoaW5rIG1heWJlIGl0J3MgYSBiaXQgbGF0ZSB0byBjbGVhciBidXN5IHN0YXJ0IGV2ZW50ID8g
V2hhdCBkbyB5b3UgDQp0aGluayA/DQoNCj4gKwkJICAgIChzdGF0dXMgJiBob3N0LT52YXJpYW50
LT5idXN5X2RldGVjdF9mbGFnKSkgew0KPiArCQkJd3JpdGVsKGhvc3QtPnZhcmlhbnQtPmJ1c3lf
ZGV0ZWN0X21hc2ssDQo+ICsJCQkgICAgICAgaG9zdC0+YmFzZSArIE1NQ0lDTEVBUik7DQo+ICAg
CQkJcmV0dXJuOw0KPiArCQl9DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBXZSB3ZXJlIG5vdCBi
dXN5LCBidXQgd2Ugbm93IGdvdCBhIGJ1c3kgcmVzcG9uc2Ugb24NCj4gLQkJICogc29tZXRoaW5n
IHRoYXQgd2FzIG5vdCBhbiBlcnJvciwgYW5kIHdlIGRvdWJsZS1jaGVjaw0KPiAtCQkgKiB0aGF0
IHRoZSBzcGVjaWFsIGJ1c3kgc3RhdHVzIGJpdCBpcyBzdGlsbCBzZXQgYmVmb3JlDQo+IC0JCSAq
IHByb2NlZWRpbmcuDQo+ICsJCSAqIEJlZm9yZSB1bm1hc2tpbmcgZm9yIHRoZSBidXN5IGVuZCBJ
UlEsIGNvbmZpcm0gdGhhdCB0aGUNCj4gKwkJICogY29tbWFuZCB3YXMgc2VudCBzdWNjZXNzZnVs
bHkuIFRvIGtlZXAgdHJhY2sgb2YgaGF2aW5nIGENCj4gKwkJICogY29tbWFuZCBpbi1wcm9ncmVz
cywgd2FpdGluZyBmb3IgYnVzeSBzaWduYWxpbmcgdG8gZW5kLA0KPiArCQkgKiBzdG9yZSB0aGUg
c3RhdHVzIGluIGhvc3QtPmJ1c3lfc3RhdHVzLg0KPiArCQkgKg0KPiArCQkgKiBOb3RlIHRoYXQs
IHRoZSBjYXJkIG1heSBuZWVkIGEgY291cGxlIG9mIGNsb2NrIGN5Y2xlcyBiZWZvcmUNCj4gKwkJ
ICogaXQgc3RhcnRzIHNpZ25hbGluZyBidXN5IG9uIERBVDAsIGhlbmNlIHJlLXJlYWQgdGhlDQo+
ICsJCSAqIE1NQ0lTVEFUVVMgcmVnaXN0ZXIgaGVyZSwgdG8gYWxsb3cgdGhlIGJ1c3kgYml0IHRv
IGJlIHNldC4NCj4gKwkJICogUG90ZW50aWFsbHkgd2UgbWF5IGV2ZW4gbmVlZCB0byBwb2xsIHRo
ZSByZWdpc3RlciBmb3IgYQ0KPiArCQkgKiB3aGlsZSwgdG8gYWxsb3cgaXQgdG8gYmUgc2V0LCBi
dXQgdGVzdHMgaW5kaWNhdGVzIHRoYXQgaXQNCj4gKwkJICogaXNuJ3QgbmVlZGVkLg0KPiAgIAkJ
ICovDQo+ICAgCQlpZiAoIWhvc3QtPmJ1c3lfc3RhdHVzICYmDQo+ICAgCQkgICAgIShzdGF0dXMg
JiAoTUNJX0NNRENSQ0ZBSUx8TUNJX0NNRFRJTUVPVVQpKSAmJg0KPiAgIAkJICAgIChyZWFkbChi
YXNlICsgTU1DSVNUQVRVUykgJiBob3N0LT52YXJpYW50LT5idXN5X2RldGVjdF9mbGFnKSkgew0K
PiAgIA0KPiAtCQkJLyogQ2xlYXIgdGhlIGJ1c3kgc3RhcnQgSVJRICovDQo+IC0JCQl3cml0ZWwo
aG9zdC0+dmFyaWFudC0+YnVzeV9kZXRlY3RfbWFzaywNCj4gLQkJCSAgICAgICBob3N0LT5iYXNl
ICsgTU1DSUNMRUFSKTsNCg0KV2h5IG5vdCBjbGVhcmluZyBidXN5IHN0YXJ0IGV2ZW50IGFzIHNv
b24gYXMgcG9zc2libGUgPyBNYXliZSBJIGFtIHdyb25nIA0KYnV0IGFzIGZhciBhcyBJIHVuZGVy
c3RhbmQsDQp3ZSBzaGFsbCAoYWx3YXlzKSBlbnRlciB0aGF0IGlmIGNvbmRpdGlvbiBiZWZvcmUg
dGhlIG9uZSBqdXN0IGFib3ZlID8NCg0KPiAtDQo+IC0JCQkvKiBVbm1hc2sgdGhlIGJ1c3kgZW5k
IElSUSAqLw0KPiAgIAkJCXdyaXRlbChyZWFkbChiYXNlICsgTU1DSU1BU0swKSB8DQo+ICAgCQkJ
ICAgICAgIGhvc3QtPnZhcmlhbnQtPmJ1c3lfZGV0ZWN0X21hc2ssDQo+ICAgCQkJICAgICAgIGJh
c2UgKyBNTUNJTUFTSzApOw0KPiAtCQkJLyoNCj4gLQkJCSAqIE5vdyBjYWNoZSB0aGUgbGFzdCBy
ZXNwb25zZSBzdGF0dXMgY29kZSAodW50aWwNCj4gLQkJCSAqIHRoZSBidXN5IGJpdCBnb2VzIGxv
dyksIGFuZCByZXR1cm4uDQo+IC0JCQkgKi8NCj4gKw0KPiAgIAkJCWhvc3QtPmJ1c3lfc3RhdHVz
ID0NCj4gICAJCQkJc3RhdHVzICYgKE1DSV9DTURTRU5UfE1DSV9DTURSRVNQRU5EKTsNCj4gICAJ
CQlyZXR1cm47DQo+ICAgCQl9DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBBdCB0aGlzIHBvaW50
IHdlIGFyZSBub3QgYnVzeSB3aXRoIGEgY29tbWFuZCwgd2UgaGF2ZQ0KPiAtCQkgKiBub3QgcmVj
ZWl2ZWQgYSBuZXcgYnVzeSByZXF1ZXN0LCBjbGVhciBhbmQgbWFzayB0aGUgYnVzeQ0KPiAtCQkg
KiBlbmQgSVJRIGFuZCBmYWxsIHRocm91Z2ggdG8gcHJvY2VzcyB0aGUgSVJRLg0KPiArCQkgKiBJ
ZiB0aGVyZSBpcyBhIGNvbW1hbmQgaW4tcHJvZ3Jlc3MgdGhhdCBoYXMgYmVlbiBzdWNjZXNzZnVs
bHkNCj4gKwkJICogc2VudCBhbmQgdGhlIGJ1c3kgYml0IGlzbid0IHNldCwgaXQgbWVhbnMgd2Ug
aGF2ZSByZWNlaXZlZA0KPiArCQkgKiB0aGUgYnVzeSBlbmQgSVJRLiBDbGVhciBhbmQgbWFzayB0
aGUgSVJRLCB0aGVuIGNvbnRpbnVlIHRvDQo+ICsJCSAqIHByb2Nlc3MgdGhlIGNvbW1hbmQuDQo+
ICAgCQkgKi8NCj4gICAJCWlmIChob3N0LT5idXN5X3N0YXR1cykgew0KPiAgIA0KPiBAQCAtMTUw
OCwxNCArMTUxOSw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtbWNpX2lycShpbnQgaXJxLCB2b2lk
ICpkZXZfaWQpDQo+ICAgCQl9DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBXZSBpbnRlbnRpb25h
bGx5IGNsZWFyIHRoZSBNQ0lfU1RfQ0FSREJVU1kgSVJRIChpZiBpdCdzDQo+IC0JCSAqIGVuYWJs
ZWQpIGluIG1tY2lfY21kX2lycSgpIGZ1bmN0aW9uIHdoZXJlIFNUIE1pY3JvIGJ1c3kNCj4gLQkJ
ICogZGV0ZWN0aW9uIHZhcmlhbnQgaXMgaGFuZGxlZC4gQ29uc2lkZXJpbmcgdGhlIEhXIHNlZW1z
IHRvIGJlDQo+IC0JCSAqIHRyaWdnZXJpbmcgdGhlIElSUSBvbiBib3RoIGVkZ2VzIHdoaWxlIG1v
bml0b3JpbmcgREFUMCBmb3INCj4gLQkJICogYnVzeSBjb21wbGV0aW9uIGFuZCB0aGF0IHNhbWUg
c3RhdHVzIGJpdCBpcyB1c2VkIHRvIG1vbml0b3INCj4gLQkJICogc3RhcnQgYW5kIGVuZCBvZiBi
dXN5IGRldGVjdGlvbiwgc3BlY2lhbCBjYXJlIG11c3QgYmUgdGFrZW4NCj4gLQkJICogdG8gbWFr
ZSBzdXJlIHRoYXQgYm90aCBzdGFydCBhbmQgZW5kIGludGVycnVwdHMgYXJlIGFsd2F5cw0KPiAt
CQkgKiBjbGVhcmVkIG9uZSBhZnRlciB0aGUgb3RoZXIuDQo+ICsJCSAqIEJ1c3kgZGV0ZWN0aW9u
IGlzIG1hbmFnZWQgYnkgbW1jaV9jbWRfaXJxKCksIGluY2x1ZGluZyB0bw0KPiArCQkgKiBjbGVh
ciB0aGUgY29ycmVzcG9uZGluZyBJUlEuDQo+ICAgCQkgKi8NCj4gICAJCXN0YXR1cyAmPSByZWFk
bChob3N0LT5iYXNlICsgTU1DSU1BU0swKTsNCj4gICAJCWlmIChob3N0LT52YXJpYW50LT5idXN5
X2RldGVjdCkNCg0K
