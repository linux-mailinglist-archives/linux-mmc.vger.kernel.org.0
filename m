Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69C1603F
	for <lists+linux-mmc@lfdr.de>; Tue,  7 May 2019 11:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEGJOv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 May 2019 05:14:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:3463 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfEGJOu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 May 2019 05:14:50 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 May 2019 18:14:48 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1ACBF180B47;
        Tue,  7 May 2019 18:14:49 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 7 May 2019 18:14:49 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 7 May 2019 18:14:48 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 7 May 2019 18:14:48 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Index: AQHU+9RXOLUG4XsvaU+oK6YWULWxq6ZSXNwAgAx/PYA=
Date:   Tue, 7 May 2019 09:14:47 +0000
Message-ID: <20190507181439.9D74.F0D17A80@socionext.com>
References: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
 <CAPDyKFouv1MDJXwDryqhC=X4mLycoAigB3x6Xee09U+QNGTa-Q@mail.gmail.com>
In-Reply-To: <CAPDyKFouv1MDJXwDryqhC=X4mLycoAigB3x6Xee09U+QNGTa-Q@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4B9D2BC15922934897589C9947C4EF2C@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQpUaGFuayB5b3UgZm9yIHJldmlld2luZyBteSBwYXRjaGVzLg0KU29ycnkgZm9yIG15IGxhdGUg
cmVwbHkuIEphcGFuIHdhcyBpbiBTcHJpbmcgVmFjYXRpb24uDQoNCj4gT24gRnJpLCAyNiBBcHIg
MjAxOSBhdCAwNDowNCwgVGFrYW8gT3JpdG8gPG9yaXRvLnRha2FvQHNvY2lvbmV4dC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFrYW8gT3JpdG8gPG9yaXRvLnRha2FvQHNv
Y2lvbmV4dC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9z
ZGhjaS1taWxiZWF1dC50eHQgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50eHQN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL3NkaGNpLW1pbGJlYXV0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwLi43MDA4NDYyDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0DQo+ID4g
QEAgLTAsMCArMSwzNSBAQA0KPiA+ICsqIFNPQ0lPTkVYVCBTREhDSSBjb250cm9sbGVyDQo+ID4g
Kw0KPiA+ICtUaGlzIGZpbGUgZG9jdW1lbnRzIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGNvcmUg
cHJvcGVydGllcyBpbiBtbWMudHh0DQo+ID4gK2FuZCB0aGUgcHJvcGVydGllcyB1c2VkIGJ5IHRo
ZSBzZGhjaV9taWxiZWF1dCBkcml2ZXIuDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICstIGNvbXBhdGlibGU6ICJzb2Npb25leHQsbWlsYmVhdXQtbTEwdi1zZGhjaS0zLjAi
DQo+ID4gKy0gY2xvY2tzOiBNdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggZW50cnkgaW4g
Y2xvY2stbmFtZXMuIEl0IGlzIGENCj4gPiArICBsaXN0IG9mIHBoYW5kbGVzIGFuZCBjbG9jay1z
cGVjaWZpZXIgcGFpcnMuDQo+ID4gKyAgU2VlIC4uL2Nsb2Nrcy9jbG9jay1iaW5kaW5ncy50eHQg
Zm9yIGRldGFpbHMuDQo+ID4gKy0gY2xvY2stbmFtZXM6IFNob3VsZCBjb250YWluIHRoZSBmb2xs
b3dpbmcgdHdvIGVudHJpZXM6DQo+ID4gKyAgICAgICAiaWZhY2UiIC0gY2xvY2sgdXNlZCBmb3Ig
c2RoY2kgaW50ZXJmYWNlDQo+ID4gKyAgICAgICAiY29yZSIgIC0gY29yZSBjbG9jayBmb3Igc2Ro
Y2kgY29udHJvbGxlcg0KPiA+ICsNCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiArLSB2
cW1tYy1zdXBwbHk6IHBoYW5kbGUgdG8gdGhlIHJlZ3VsYXRvciBkZXZpY2UgdHJlZSBub2RlLCBt
ZW50aW9uZWQNCj4gPiArICBhcyB0aGUgVkNDUS9WRERfSU8gc3VwcGx5IGluIHRoZSBlTU1DL1NE
IHNwZWNzLg0KPiA+ICstIGZ1aml0c3UsY21kLWRhdC1kZWxheS1zZWxlY3Q6IGJvb2xlYW4gcHJv
cGVydHkgaW5kaWNhdGluZyB0aGF0IHRoaXMgaG9zdA0KPiA+ICsgIHJlcXVpcmVzIHRoZSBDTURf
REFUX0RFTEFZIGNvbnRyb2wgdG8gYmUgZW5hYmxlZC4NCj4gPiArLSBzbmksbW1jLXBvd2VyLWdw
aW86IHNldCBwcm9wZXJ0eSBpbmRpY2F0aW5nIHRoYXQgcG93ZXIgb24gb3Igb2ZmIG5lZWRzDQo+
ID4gKyAgY29udHJvbCBvZiBncGlvcy4NCj4gDQo+IFBsZWFzZSB1c2UgYSB2bW1jLXN1cHBseSBp
bnN0ZWFkIG9mICJwb3dlci1ncGlvIiAod2hpY2ggbWVhbnMgeW91IG5lZWQNCj4gdG8gbW9kZWwg
dGhpcyBhcyBhIGZpeGVkIEdQSU8gcmVndWxhdG9yKS4NCg0KT0ssIEkgd2lsbCBzdHVkeSBhYm91
dCByZWd1bGF0b3Ivdm1tYy1zdXBwbHkgYW5kIGNoYW5nZSB0byB1c2UgaXQuDQoNClRoYW5rcw0K
T3JpdG8NCg0KPiANCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKyAgICAgICBzZGhjaTM6IG1t
Y0AxYjAxMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic29jaW9uZXh0
LG1pbGJlYXV0LW0xMHYtc2RoY2ktMy4wIjsNCj4gPiArICAgICAgICAgICAgICAgcmVnID0gPDB4
MWIwMTAwMDAgMHgxMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCAy
NjUgMHg0PjsNCj4gPiArICAgICAgICAgICAgICAgdm9sdGFnZS1yYW5nZXMgPSA8MzMwMCAzMzAw
PjsNCj4gPiArICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPiA+ICsgICAgICAgICAg
ICAgICBjbG9ja3MgPSA8JmNsayA3PiwgPCZhaGJfY2xrPjsNCj4gPiArICAgICAgICAgICAgICAg
Y2xvY2stbmFtZXMgPSAiY29yZSIsICJpZmFjZSI7DQo+ID4gKyAgICAgICAgICAgICAgIGNhcC1z
ZGlvLWlycTsNCj4gPiArICAgICAgICAgICAgICAgc25pLG1tYy1wb3dlci1ncGlvID0gPCZwaW5j
dHJsIDUzIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZ1
aml0c3UsY21kLWRhdC1kZWxheS1zZWxlY3Q7DQo+ID4gKyAgICAgICB9Ow0KPiA+IC0tDQo+ID4g
MS45LjENCj4gPg0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQotLSANClRha2Fv
IE9yaXRvIDxvcml0by50YWthb0Bzb2Npb25leHQuY29tPg0K
