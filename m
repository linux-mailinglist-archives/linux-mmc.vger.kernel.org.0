Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623594FF1E
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Jun 2019 04:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFXCJO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 23 Jun 2019 22:09:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:38521 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfFXCJO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Jun 2019 22:09:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jun 2019 11:09:12 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id EE073180088;
        Mon, 24 Jun 2019 11:09:12 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Mon, 24 Jun 2019 11:09:12 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Mon, 24 Jun 2019 11:09:11 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Mon, 24 Jun 2019 11:09:11 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Topic: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Index: AQHVFsjKlX0FEPEPP0y84mvB/ydCMqapnyyA
Date:   Mon, 24 Jun 2019 02:09:10 +0000
Message-ID: <20190624110901.50EF.F0D17A80@socionext.com>
References: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <C9EDB484AEAF9B43A83E9452CF7C3FEB@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQpIZWxsbw0KDQpEb2VzIGFueW9uZSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzID8NCg0KPiBB
ZGQgdGhlIGRldmljZS10cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgTWlsYmVhdXQgU0RI
Q0kgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGFrYW8gT3JpdG8gPG9yaXRvLnRha2Fv
QHNvY2lvbmV4dC5jb20+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3Nk
aGNpLW1pbGJlYXV0LnR4dCAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhj
aS1taWxiZWF1dC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3Nk
aGNpLW1pbGJlYXV0LnR4dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
Li42MDYzMTE2DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50eHQNCj4gQEAgLTAsMCArMSwzMiBAQA0K
PiArKiBTT0NJT05FWFQgTWlsYmVhdXQgU0RIQ0kgY29udHJvbGxlcg0KPiArDQo+ICtUaGlzIGZp
bGUgZG9jdW1lbnRzIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGNvcmUgcHJvcGVydGllcyBpbiBt
bWMudHh0DQo+ICthbmQgdGhlIHByb3BlcnRpZXMgdXNlZCBieSB0aGUgc2RoY2lfbWlsYmVhdXQg
ZHJpdmVyLg0KPiArDQo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiArLSBjb21wYXRpYmxlOiAi
c29jaW9uZXh0LG1pbGJlYXV0LW0xMHYtc2RoY2ktMy4wIg0KPiArLSBjbG9ja3M6IE11c3QgY29u
dGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1lcy4gSXQgaXMgYQ0KPiAr
ICBsaXN0IG9mIHBoYW5kbGVzIGFuZCBjbG9jay1zcGVjaWZpZXIgcGFpcnMuDQo+ICsgIFNlZSAu
Li9jbG9ja3MvY2xvY2stYmluZGluZ3MudHh0IGZvciBkZXRhaWxzLg0KPiArLSBjbG9jay1uYW1l
czogU2hvdWxkIGNvbnRhaW4gdGhlIGZvbGxvd2luZyB0d28gZW50cmllczoNCj4gKwkiaWZhY2Ui
IC0gY2xvY2sgdXNlZCBmb3Igc2RoY2kgaW50ZXJmYWNlDQo+ICsJImNvcmUiICAtIGNvcmUgY2xv
Y2sgZm9yIHNkaGNpIGNvbnRyb2xsZXINCj4gKy0gdm1tYy1zdXBwbHk6IGEgcGhhbmRsZSBvZiBh
IGZpeGVkIEdQSU8gcmVndWxhdG9yDQo+ICsNCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICst
IGZ1aml0c3UsY21kLWRhdC1kZWxheS1zZWxlY3Q6IGJvb2xlYW4gcHJvcGVydHkgaW5kaWNhdGlu
ZyB0aGF0IHRoaXMgaG9zdA0KPiArICByZXF1aXJlcyB0aGUgQ01EX0RBVF9ERUxBWSBjb250cm9s
IHRvIGJlIGVuYWJsZWQuDQo+ICsNCj4gK0V4YW1wbGU6DQo+ICsJc2RoY2kzOiBtbWNAMWIwMTAw
MDAgew0KPiArCQljb21wYXRpYmxlID0gInNvY2lvbmV4dCxtaWxiZWF1dC1tMTB2LXNkaGNpLTMu
MCI7DQo+ICsJCXJlZyA9IDwweDFiMDEwMDAwIDB4MTAwMDA+Ow0KPiArCQlpbnRlcnJ1cHRzID0g
PDAgMjY1IDB4ND47DQo+ICsJCXZvbHRhZ2UtcmFuZ2VzID0gPDMzMDAgMzMwMD47DQo+ICsJCWJ1
cy13aWR0aCA9IDw0PjsNCj4gKwkJY2xvY2tzID0gPCZjbGsgNz4sIDwmYWhiX2Nsaz47DQo+ICsJ
CWNsb2NrLW5hbWVzID0gImNvcmUiLCAiaWZhY2UiOw0KPiArCQljYXAtc2Rpby1pcnE7DQo+ICsJ
CXZtbWMtc3VwcGx5ID0gPCZ2Y2Nfc2RoY2kzPjsNCj4gKwkJZnVqaXRzdSxjbWQtZGF0LWRlbGF5
LXNlbGVjdDsNCj4gKwl9Ow0KPiAtLSANCj4gMS45LjENCj4gDQoNClRoYW5rcw0KT3JpdG8NCg0K
LS0gDQpUYWthbyBPcml0byA8b3JpdG8udGFrYW9Ac29jaW9uZXh0LmNvbT4NCg==
