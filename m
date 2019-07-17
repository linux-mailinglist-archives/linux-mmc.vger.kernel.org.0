Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228F66B9EA
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGQKRA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jul 2019 06:17:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfGQKQ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jul 2019 06:16:59 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HAGWJ7029856;
        Wed, 17 Jul 2019 12:16:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=1Jn0+zt50XDumNDUWAb7tHQ1eonPdVNvuM0PAOElg5E=;
 b=BoCgRA7eLuOLrctLst9mx+lEhPsaYXyIhpyiFHE4katD7840ixhvqajNze5jWmuy92N6
 hw2YLNjsLtMltRInkmozk0GV6v5v99bzh5XWr8QcX9ls62Gd9oEJygTAT8oLxQAHUfsm
 Z/dgH0G2RdfDj3zXdZvehsxnzggk8hLdLSE68V7xZKQf0MzX4XSSa+/OQCCkr19CciaH
 cO8dYTrvVRhLwlLCT3GtutBO3+GcvWxASDxa35luhHcOICO8Lhya1J3/vGuF5rQzOc5g
 SfpenfG833J/8ffRpxGmSmyynH8PPcMIval8BBc0Lm1QgltB9NQ5bahme2N+2LYIdFTN 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tsdepegpm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 17 Jul 2019 12:16:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27C0938;
        Wed, 17 Jul 2019 10:16:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE46D2D0A;
        Wed, 17 Jul 2019 10:16:30 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 12:16:30 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Wed, 17 Jul 2019 12:16:30 +0200
From:   Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
Thread-Topic: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy
 status
Thread-Index: AQHVOyxJBbFI4qOyEEiK9auMIxtGvqbOeYOA
Date:   Wed, 17 Jul 2019 10:16:30 +0000
Message-ID: <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com>
References: <20190715164217.27297-1-ulf.hansson@linaro.org>
In-Reply-To: <20190715164217.27297-1-ulf.hansson@linaro.org>
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
Content-ID: <0975DDDE0ED6334D8F86B98D7AF96762@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_03:,,
 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGVsbG8gVWxmLCBhbGwsDQoNCkZvciB0ZXN0aW5nIHB1cnBvc2UsIEkgY2hlcnJ5LXBpY2tlZCB5
b3VyIHBhdGNoIG9uIHRvcCBvZiBhIDQuMTkuMzAgYmFzaXMuDQooSSBhcG9sb2dpemUgYXMgaXQn
cyBhIGJpdCBvbGQuIEkgbWlzcyB0aW1lIHRvIGRvIGEgcmViYXNlIG9uIGN1cnJlbnQgDQpsaW51
eC1uZXh0IHJpZ2h0IG5vdy4pDQoNClVuZm9ydHVuYXRlbHksIEkgZ290IGEga2VybmVsIGNyYXNo
IGFwcGx5aW5nIGl0IDooDQoNCkFzIHlvdSBtYXkga25vdywgU1Qgc3RhMTI5NS9zdGExMzg1IFNv
QyBlbWJlZHMgdGhlIHNhbWUgcGwwOHggdmFyaWFudCANCnRoYW4gb25lIGluIFU4NTAwLg0KU28g
SXQgbG9va3MgbGlrZSBkb3VibGUtY2hlY2tpbmcgYWdhaW4gbW1jaSBzdGF0dXMgdG8gbWFrZSBz
dXJlIGJ1c3kgDQpmbGFnIGlzIHN0aWxsIHNldA0KanVzdCBiZWZvcmUgcHJvY2VlZGluZyBmb3Ig
YnVzeSBlbmQgaXMgcmVxdWlyZWQgaW4gb3VyIGNhc2UuDQoNClJlZ2FyZHMuDQpKZWFuLU5pY29s
YXMuDQoNCk9uIDcvMTUvMTkgNjo0MiBQTSwgVWxmIEhhbnNzb24gd3JvdGU6DQo+IFRoZSBNTUNJ
U1RBVFVTIHJlZ2lzdGVyIGlzIHJlYWQgZnJvbSB0aGUgSVJRIGhhbmRsZXIsIG1tY2lfaXJxKCku
IEZvcg0KPiBwcm9jZXNzaW5nLCBpdHMgdmFsdWUgaXMgdGhlbiBwYXNzZWQgYXMgYW4gaW4tcGFy
YW1ldGVyIHRvIG1tY2lfY21kX2lycSgpLg0KPg0KPiBXaGVuIGRlYWxpbmcgd2l0aCBidXN5IGRl
dGVjdGlvbiwgdGhlIE1NQ0lTVEFUVVMgcmVnaXN0ZXIgaXMgYmVpbmcgcmUtcmVhZCwNCj4gYXMg
dG8gcmV0cmlldmUgYW4gdXBkYXRlZCB2YWx1ZS4gSG93ZXZlciwgdGhpcyBvcGVyYXRpb24gaXMg
bGlrZWx5IGNvc3RpbmcNCj4gbW9yZSB0aGFuIGl0IGJlbmVmaXRzLCBhcyB0aGUgdmFsdWUgd2Fz
IHJlYWQgb25seSBhIGZldyBjeWNsZXMgYWdvLiBGb3INCj4gdGhpcyByZWFzb24sIGxldCdzIHNp
bXBseSBkcm9wIHRoZSByZS1yZWFkIGFuZCB1c2UgdGhlIHZhbHVlIGZyb20gdGhlDQo+IGluLXBh
cmFtZXRlciBpbnN0ZWFkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMgfCA4
ICsrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jIGIvZHJpdmVy
cy9tbWMvaG9zdC9tbWNpLmMNCj4gaW5kZXggMzU2ODMzYTYwNmQ1Li41ZjM1YWZjNGRiZjkgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jDQo+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvbW1jaS5jDQo+IEBAIC0xMjMzLDE0ICsxMjMzLDEyIEBAIG1tY2lfY21kX2lycShzdHJ1
Y3QgbW1jaV9ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNtZCwNCj4gICAJCQlyZXR1
cm47DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBXZSB3ZXJlIG5vdCBidXN5LCBidXQgd2Ugbm93
IGdvdCBhIGJ1c3kgcmVzcG9uc2Ugb24NCj4gLQkJICogc29tZXRoaW5nIHRoYXQgd2FzIG5vdCBh
biBlcnJvciwgYW5kIHdlIGRvdWJsZS1jaGVjaw0KPiAtCQkgKiB0aGF0IHRoZSBzcGVjaWFsIGJ1
c3kgc3RhdHVzIGJpdCBpcyBzdGlsbCBzZXQgYmVmb3JlDQo+IC0JCSAqIHByb2NlZWRpbmcuDQo+
ICsJCSAqIEJlZm9yZSB1bm1hc2tpbmcgZm9yIHRoZSBidXN5IGVuZCBJUlEsIGNvbmZpcm0gdGhh
dCB0aGUNCj4gKwkJICogY29tbWFuZCB3YXMgc2VudCBzdWNjZXNzZnVsbHkuDQo+ICAgCQkgKi8N
Cj4gICAJCWlmICghaG9zdC0+YnVzeV9zdGF0dXMgJiYNCj4gICAJCSAgICAhKHN0YXR1cyAmIChN
Q0lfQ01EQ1JDRkFJTHxNQ0lfQ01EVElNRU9VVCkpICYmDQo+IC0JCSAgICAocmVhZGwoYmFzZSAr
IE1NQ0lTVEFUVVMpICYgaG9zdC0+dmFyaWFudC0+YnVzeV9kZXRlY3RfZmxhZykpIHsNCj4gKwkJ
ICAgIChzdGF0dXMgJiBob3N0LT52YXJpYW50LT5idXN5X2RldGVjdF9mbGFnKSkgew0KPiAgIA0K
PiAgIAkJCS8qIENsZWFyIHRoZSBidXN5IHN0YXJ0IElSUSAqLw0KPiAgIAkJCXdyaXRlbChob3N0
LT52YXJpYW50LT5idXN5X2RldGVjdF9tYXNrLA0KDQo=
