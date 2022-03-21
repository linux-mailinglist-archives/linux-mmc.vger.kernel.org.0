Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D524E31C4
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Mar 2022 21:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353346AbiCUUav (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Mar 2022 16:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353350AbiCUUau (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2022 16:30:50 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C337A93
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2022 13:29:22 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 61D6F2C049B;
        Mon, 21 Mar 2022 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647894559;
        bh=Qp5+pBZERst+zLxmWjMEPBRkeJzoKp4/ID4MN/ntPHs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aURLa+kms+3qE3bER0hlr9AVN1q3ziDgwc5IdQMPlzV+wlyYOoP2DitwyrudouKPr
         /Z1FhHa0s+dXpMQMVDZaZuu11wHhL9HEyqoFWAS9kTxRGHKfaXvpdyeuIaN2Kv1ryY
         C/KucaPJC4A99dexxntENqhuzd0sWwju1tE7ywRGnaSVul1Y0m6zHwqidgYF556U+4
         z5c9bTOLqccCfec3TfvlDmHAiwhylz36j+jgj9MgfPr8mChM01JI1FYQrghYPXPxu8
         HB2D1EPlCwmzLrAxHNjmXZx3GVL4HEKp/SmZL+cM4NhDbbrzz7WMojXaiV/+lBdAUv
         lVMWlqrK9rmXw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6238e01f0001>; Tue, 22 Mar 2022 09:29:19 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 09:29:18 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 09:29:18 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Topic: [PATCH v2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Index: AQHYPLUx3QLmfjjLtEW4vJNBqaPJpazJcVSA
Date:   Mon, 21 Mar 2022 20:29:18 +0000
Message-ID: <b172a1d1-fa48-6181-e66e-7dbe54076304@alliedtelesis.co.nz>
References: <20220320234938.1946259-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220320234938.1946259-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <15409BBF59235E40B7C3377FF61E24E6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=aED7WNoIxSQOKRfctN0A:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgR3JlZ29yeSwNCg0KUXVlc3Rpb24gZm9yIHlvdSBiZWxvdw0KDQpPbiAyMS8wMy8yMiAxMjo0
OSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gQ29udmVydCB0aGUgbWFydmVsbCx4ZW5vbi1zZGhj
aSBiaW5kaW5nIHRvIEpTT04gc2NoZW1hLiBDdXJyZW50bHkgdGhlDQo+IGluLXRyZWUgZHRzIGZp
bGVzIGRvbid0IHZhbGlkYXRlIGJlY2F1c2UgdGhleSB1c2Ugc2RoY2lAIGluc3RlYWQgb2YgbW1j
QA0KPiBhcyByZXF1aXJlZCBieSB0aGUgZ2VuZXJpYyBtbWMtY29udHJvbGxlciBzY2hlbWEuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVs
ZXNpcy5jby5uej4NCj4gLS0tDQo+DQo+IE5vdGVzOg0KPiAgICAgIENoYW5nZXMgaW4gdjI6DQo+
ICAgICAgLSBVcGRhdGUgTUFJTlRBSU5FUlMgZW50cnkNCj4gICAgICAtIEluY29ycG9yYXRlIGZl
ZWRiYWNrIGZyb20gS3J6eXN6dG9mDQo+DQo+ICAgLi4uL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhl
bm9uLXNkaGNpLnR4dCAgICAgIHwgMTczIC0tLS0tLS0tLS0tDQo+ICAgLi4uL2JpbmRpbmdzL21t
Yy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwgICAgIHwgMjcyICsrKysrKysrKysrKysrKysrKw0K
PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjczIGluc2VydGlvbnMoKyksIDE3NCBkZWxldGlvbnMo
LSkNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21hcnZlbGwseGVub24tc2RoY2ku
eWFtbA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS50eHQNCj4gZGVsZXRlZCBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IGM1MWE2MmQ3NTFkYy4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS50eHQN
Cj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwxNzMgKzAsMCBAQA0KPiAtTWFydmVsbCBYZW5vbiBT
REhDSSBDb250cm9sbGVyIGRldmljZSB0cmVlIGJpbmRpbmdzDQo+IC1UaGlzIGZpbGUgZG9jdW1l
bnRzIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGNvcmUgbW1jIHByb3BlcnRpZXMNCj4gLWRlc2Ny
aWJlZCBieSBtbWMudHh0IGFuZCB0aGUgcHJvcGVydGllcyB1c2VkIGJ5IHRoZSBYZW5vbiBpbXBs
ZW1lbnRhdGlvbi4NCj4gLQ0KPiAtTXVsdGlwbGUgU0RIQ3MgbWlnaHQgYmUgcHV0IGludG8gYSBz
aW5nbGUgWGVub24gSVAsIHRvIHNhdmUgc2l6ZSBhbmQgY29zdC4NCj4gLUVhY2ggU0RIQyBpcyBp
bmRlcGVuZGVudCBhbmQgb3ducyBpbmRlcGVuZGVudCByZXNvdXJjZXMsIHN1Y2ggYXMgcmVnaXN0
ZXIgc2V0cywNCj4gLWNsb2NrIGFuZCBQSFkuDQo+IC1FYWNoIFNESEMgc2hvdWxkIGhhdmUgYW4g
aW5kZXBlbmRlbnQgZGV2aWNlIHRyZWUgbm9kZS4NCj4gLQ0KPiAtUmVxdWlyZWQgUHJvcGVydGll
czoNCj4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nDQo+IC0g
IC0gIm1hcnZlbGwsYXJtYWRhLTM3MDAtc2RoY2kiOiBGb3IgY29udHJvbGxlcnMgb24gQXJtYWRh
LTM3MDAgU29DLg0KPiAtICBNdXN0IHByb3ZpZGUgYSBzZWNvbmQgcmVnaXN0ZXIgYXJlYSBhbmQg
bWFydmVsbCxwYWQtdHlwZS4NCj4gLSAgLSAibWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2kiOiBG
b3IgY29udHJvbGxlcnMgb24gQXJtYWRhIEFQODA2Lg0KPiAtICAtICJtYXJ2ZWxsLGFybWFkYS1h
cDgwNy1zZGhjaSI6IEZvciBjb250cm9sbGVycyBvbiBBcm1hZGEgQVA4MDcuDQo+IC0gIC0gIm1h
cnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNpIjogRm9yIGNvbnRyb2xsZXJzIG9uIEFybWFkYSBDUDEx
MC4NCj4gLQ0KPiAtLSBjbG9ja3M6DQo+IC0gIEFycmF5IG9mIGNsb2NrcyByZXF1aXJlZCBmb3Ig
U0RIQy4NCj4gLSAgUmVxdWlyZSBhdCBsZWFzdCBpbnB1dCBjbG9jayBmb3IgWGVub24gSVAgY29y
ZS4gRm9yIEFybWFkYSBBUDgwNiBhbmQNCj4gLSAgQ1AxMTAsIHRoZSBBWEkgY2xvY2sgaXMgYWxz
byBtYW5kYXRvcnkuDQo+IC0NCj4gLS0gY2xvY2stbmFtZXM6DQo+IC0gIEFycmF5IG9mIG5hbWVz
IGNvcnJlc3BvbmRpbmcgdG8gY2xvY2tzIHByb3BlcnR5Lg0KPiAtICBUaGUgaW5wdXQgY2xvY2sg
Zm9yIFhlbm9uIElQIGNvcmUgc2hvdWxkIGJlIG5hbWVkIGFzICJjb3JlIi4NCj4gLSAgVGhlIGlu
cHV0IGNsb2NrIGZvciB0aGUgQVhJIGJ1cyBtdXN0IGJlIG5hbWVkIGFzICJheGkiLg0KPiAtDQo+
IC0tIHJlZzoNCj4gLSAgKiBGb3IgIm1hcnZlbGwsYXJtYWRhLTM3MDAtc2RoY2kiLCB0d28gcmVn
aXN0ZXIgYXJlYXMuDQo+IC0gICAgVGhlIGZpcnN0IG9uZSBmb3IgWGVub24gSVAgcmVnaXN0ZXIu
IFRoZSBzZWNvbmQgb25lIGZvciB0aGUgQXJtYWRhIDM3MDAgU29DDQo+IC0gICAgUEhZIFBBRCBW
b2x0YWdlIENvbnRyb2wgcmVnaXN0ZXIuDQo+IC0gICAgUGxlYXNlIGZvbGxvdyB0aGUgZXhhbXBs
ZXMgd2l0aCBjb21wYXRpYmxlICJtYXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpIg0KPiAtICAgIGlu
IGJlbG93Lg0KPiAtICAgIFBsZWFzZSBhbHNvIGNoZWNrIHByb3BlcnR5IG1hcnZlbGwscGFkLXR5
cGUgaW4gYmVsb3cuDQo+IC0NCj4gLSAgKiBGb3Igb3RoZXIgY29tcGF0aWJsZSBzdHJpbmdzLCBv
bmUgcmVnaXN0ZXIgYXJlYSBmb3IgWGVub24gSVAuDQo+IC0NCj4gLU9wdGlvbmFsIFByb3BlcnRp
ZXM6DQo+IC0tIG1hcnZlbGwseGVub24tc2RoYy1pZDoNCj4gLSAgSW5kaWNhdGUgdGhlIGNvcnJl
c3BvbmRpbmcgYml0IGluZGV4IG9mIGN1cnJlbnQgU0RIQyBpbg0KPiAtICBTREhDIFN5c3RlbSBP
cGVyYXRpb24gQ29udHJvbCBSZWdpc3RlciBCaXRbNzowXS4NCj4gLSAgU2V0L2NsZWFyIHRoZSBj
b3JyZXNwb25kaW5nIGJpdCB0byBlbmFibGUvZGlzYWJsZSBjdXJyZW50IFNESEMuDQo+IC0gIElm
IFhlbm9uIElQIGNvbnRhaW5zIG9ubHkgb25lIFNESEMsIHRoaXMgcHJvcGVydHkgaXMgb3B0aW9u
YWwuDQo+IC0NCj4gLS0gbWFydmVsbCx4ZW5vbi1waHktdHlwZToNCj4gLSAgWGVub24gc3VwcG9y
dCBtdWx0aXBsZSB0eXBlcyBvZiBQSFlzLg0KPiAtICBUbyBzZWxlY3QgZU1NQyA1LjEgUEhZLCBz
ZXQ6DQo+IC0gIG1hcnZlbGwseGVub24tcGh5LXR5cGUgPSAiZW1tYyA1LjEgcGh5Ig0KPiAtICBl
TU1DIDUuMSBQSFkgaXMgdGhlIGRlZmF1bHQgY2hvaWNlIGlmIHRoaXMgcHJvcGVydHkgaXMgbm90
IHByb3ZpZGVkLg0KPiAtICBUbyBzZWxlY3QgZU1NQyA1LjAgUEhZLCBzZXQ6DQo+IC0gIG1hcnZl
bGwseGVub24tcGh5LXR5cGUgPSAiZW1tYyA1LjAgcGh5Ig0KPiAtDQo+IC0gIEFsbCB0aG9zZSB0
eXBlcyBvZiBQSFlzIGNhbiBzdXBwb3J0IGVNTUMsIFNEIGFuZCBTRElPLg0KPiAtICBQbGVhc2Ug
bm90ZSB0aGF0IHRoaXMgcHJvcGVydHkgb25seSBwcmVzZW50cyB0aGUgdHlwZSBvZiBQSFkuDQo+
IC0gIEl0IGRvZXNuJ3Qgc3RhbmQgZm9yIHRoZSBlbnRpcmUgU0RIQyB0eXBlIG9yIHByb3BlcnR5
Lg0KPiAtICBGb3IgZXhhbXBsZSwgImVtbWMgNS4xIHBoeSIgZG9lc24ndCBtZWFuIHRoYXQgdGhp
cyBYZW5vbiBTREhDIG9ubHkNCj4gLSAgc3VwcG9ydHMgZU1NQyA1LjEuDQo+IC0NCj4gLS0gbWFy
dmVsbCx4ZW5vbi1waHktem5yOg0KPiAtICBTZXQgUEhZIFpOUiB2YWx1ZS4NCj4gLSAgT25seSBh
dmFpbGFibGUgZm9yIGVNTUMgUEhZLg0KPiAtICBWYWxpZCByYW5nZSA9IFswOjB4MUZdLg0KPiAt
ICBaTlIgaXMgc2V0IGFzIDB4RiBieSBkZWZhdWx0IGlmIHRoaXMgcHJvcGVydHkgaXMgbm90IHBy
b3ZpZGVkLg0KPiAtDQo+IC0tIG1hcnZlbGwseGVub24tcGh5LXpwcjoNCj4gLSAgU2V0IFBIWSBa
UFIgdmFsdWUuDQo+IC0gIE9ubHkgYXZhaWxhYmxlIGZvciBlTU1DIFBIWS4NCj4gLSAgVmFsaWQg
cmFuZ2UgPSBbMDoweDFGXS4NCj4gLSAgWlBSIGlzIHNldCBhcyAweEYgYnkgZGVmYXVsdCBpZiB0
aGlzIHByb3BlcnR5IGlzIG5vdCBwcm92aWRlZC4NCj4gLQ0KPiAtLSBtYXJ2ZWxsLHhlbm9uLXBo
eS1uci1zdWNjZXNzLXR1bjoNCj4gLSAgU2V0IHRoZSBudW1iZXIgb2YgcmVxdWlyZWQgY29uc2Vj
dXRpdmUgc3VjY2Vzc2Z1bCBzYW1wbGluZyBwb2ludHMNCj4gLSAgdXNlZCB0byBpZGVudGlmeSBh
IHZhbGlkIHNhbXBsaW5nIHdpbmRvdywgaW4gdHVuaW5nIHByb2Nlc3MuDQo+IC0gIFZhbGlkIHJh
bmdlID0gWzE6N10uDQo+IC0gIFNldCBhcyAweDQgYnkgZGVmYXVsdCBpZiB0aGlzIHByb3BlcnR5
IGlzIG5vdCBwcm92aWRlZC4NCj4gLQ0KPiAtLSBtYXJ2ZWxsLHhlbm9uLXBoeS10dW4tc3RlcC1k
aXZpZGVyOg0KPiAtICBTZXQgdGhlIGRpdmlkZXIgZm9yIGNhbGN1bGF0aW5nIFRVTl9TVEVQLg0K
PiAtICBTZXQgYXMgNjQgYnkgZGVmYXVsdCBpZiB0aGlzIHByb3BlcnR5IGlzIG5vdCBwcm92aWRl
ZC4NCj4gLQ0KPiAtLSBtYXJ2ZWxsLHhlbm9uLXBoeS1zbG93LW1vZGU6DQo+IC0gIElmIHRoaXMg
cHJvcGVydHkgaXMgc2VsZWN0ZWQsIHRyYW5zZmVycyB3aWxsIGJ5cGFzcyBQSFkuDQo+IC0gIE9u
bHkgYXZhaWxhYmxlIHdoZW4gYnVzIGZyZXF1ZW5jeSBsb3dlciB0aGFuIDU1TUh6IGluIFNEUiBt
b2RlLg0KPiAtICBEaXNhYmxlZCBieSBkZWZhdWx0LiBQbGVhc2Ugb25seSB0cnkgdGhpcyBwcm9w
ZXJ0eSBpZiB0aW1pbmcgaXNzdWVzDQo+IC0gIGFsd2F5cyBvY2N1ciB3aXRoIFBIWSBlbmFibGVk
IGluIGVNTUMgSFMgU0RSLCBTRCBTRFIxMiwgU0QgU0RSMjUsDQo+IC0gIFNEIERlZmF1bHQgU3Bl
ZWQgYW5kIEhTIG1vZGUgYW5kIGVNTUMgbGVnYWN5IHNwZWVkIG1vZGUuDQo+IC0NCj4gLS0gbWFy
dmVsbCx4ZW5vbi10dW4tY291bnQ6DQo+IC0gIFhlbm9uIFNESEMgU29DIHVzdWFsbHkgZG9lc24n
dCBwcm92aWRlIHJlLXR1bmluZyBjb3VudGVyIGluDQo+IC0gIENhcGFiaWxpdGllcyBSZWdpc3Rl
ciAzIEJpdFsxMTo4XS4NCj4gLSAgVGhpcyBwcm9wZXJ0eSBwcm92aWRlcyB0aGUgcmUtdHVuaW5n
IGNvdW50ZXIuDQo+IC0gIElmIHRoaXMgcHJvcGVydHkgaXMgbm90IHNldCwgZGVmYXVsdCByZS10
dW5pbmcgY291bnRlciB3aWxsDQo+IC0gIGJlIHNldCBhcyAweDkgaW4gZHJpdmVyLg0KPiAtDQo+
IC0tIG1hcnZlbGwscGFkLXR5cGU6DQo+IC0gIFR5cGUgb2YgQXJtYWRhIDM3MDAgU29DIFBIWSBQ
QUQgVm9sdGFnZSBDb250cm9sbGVyIHJlZ2lzdGVyLg0KPiAtICBPbmx5IHZhbGlkIHdoZW4gIm1h
cnZlbGwsYXJtYWRhLTM3MDAtc2RoY2kiIGlzIHNlbGVjdGVkLg0KPiAtICBUd28gdHlwZXM6ICJz
ZCIgYW5kICJmaXhlZC0xLTh2Ii4NCj4gLSAgSWYgInNkIiBpcyBzZWxlY3RlZCwgU29DIFBIWSBQ
QUQgaXMgc2V0IGFzIDMuM1YgYXQgdGhlIGJlZ2lubmluZyBhbmQgaXMNCj4gLSAgc3dpdGNoZWQg
dG8gMS44ViB3aGVuIGxhdGVyIGluIGhpZ2hlciBzcGVlZCBtb2RlLg0KPiAtICBJZiAiZml4ZWQt
MS04diIgaXMgc2VsZWN0ZWQsIFNvQyBQSFkgUEFEIGlzIGZpeGVkIDEuOFYsIHN1Y2ggYXMgZm9y
IGVNTUMuDQo+IC0gIFBsZWFzZSBmb2xsb3cgdGhlIGV4YW1wbGVzIHdpdGggY29tcGF0aWJsZSAi
bWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSINCj4gLSAgaW4gYmVsb3cuDQo+IC0NCj4gLUV4YW1w
bGU6DQo+IC0tIEZvciBlTU1DOg0KPiAtDQo+IC0Jc2RoY2lAYWEwMDAwIHsNCj4gLQkJY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS1hcDgwNi1zZGhjaSI7DQo+IC0JCXJlZyA9IDwweGFhMDAw
MCAweDEwMDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTMgSVJRX1RZUEVfTEVWRUxf
SElHSD4NCj4gLQkJY2xvY2tzID0gPCZlbW1jX2Nsaz4sPCZheGlfY2xrPjsNCj4gLQkJY2xvY2st
bmFtZXMgPSAiY29yZSIsICJheGkiOw0KPiAtCQlidXMtd2lkdGggPSA8ND47DQo+IC0JCW1hcnZl
bGwseGVub24tcGh5LXNsb3ctbW9kZTsNCj4gLQkJbWFydmVsbCx4ZW5vbi10dW4tY291bnQgPSA8
MTE+Ow0KPiAtCQlub24tcmVtb3ZhYmxlOw0KPiAtCQluby1zZDsNCj4gLQkJbm8tc2RpbzsNCj4g
LQ0KPiAtCQkvKiBWbW1jIGFuZCBWcW1tYyBhcmUgYm90aCBmaXhlZCAqLw0KPiAtCX07DQo+IC0N
Cj4gLS0gRm9yIFNEL1NESU86DQo+IC0NCj4gLQlzZGhjaUBhYjAwMDAgew0KPiAtCQljb21wYXRp
YmxlID0gIm1hcnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNpIjsNCj4gLQkJcmVnID0gPDB4YWIwMDAw
IDB4MTAwMD47DQo+IC0JCWludGVycnVwdHMgPSA8R0lDX1NQSSA1NSBJUlFfVFlQRV9MRVZFTF9I
SUdIPg0KPiAtCQl2cW1tYy1zdXBwbHkgPSA8JnNkX3ZxbW1jX3JlZ3VsYXRvcj47DQo+IC0JCXZt
bWMtc3VwcGx5ID0gPCZzZF92bW1jX3JlZ3VsYXRvcj47DQo+IC0JCWNsb2NrcyA9IDwmc2RjbGs+
LCA8JmF4aV9jbGs+Ow0KPiAtCQljbG9jay1uYW1lcyA9ICJjb3JlIiwgImF4aSI7DQo+IC0JCWJ1
cy13aWR0aCA9IDw0PjsNCj4gLQkJbWFydmVsbCx4ZW5vbi10dW4tY291bnQgPSA8OT47DQo+IC0J
fTsNCj4gLQ0KPiAtLSBGb3IgZU1NQyB3aXRoIGNvbXBhdGlibGUgIm1hcnZlbGwsYXJtYWRhLTM3
MDAtc2RoY2kiOg0KPiAtDQo+IC0Jc2RoY2lAYWEwMDAwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJt
YXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpIjsNCj4gLQkJcmVnID0gPDB4YWEwMDAwIDB4MTAwMD4s
DQo+IC0JCSAgICAgIDxwaHlfYWRkciAweDQ+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MTMgSVJRX1RZUEVfTEVWRUxfSElHSD4NCj4gLQkJY2xvY2tzID0gPCZlbW1jY2xrPjsNCj4gLQkJ
Y2xvY2stbmFtZXMgPSAiY29yZSI7DQo+IC0JCWJ1cy13aWR0aCA9IDw4PjsNCj4gLQkJbW1jLWRk
ci0xXzh2Ow0KPiAtCQltbWMtaHM0MDAtMV84djsNCj4gLQkJbm9uLXJlbW92YWJsZTsNCj4gLQkJ
bm8tc2Q7DQo+IC0JCW5vLXNkaW87DQo+IC0NCj4gLQkJLyogVm1tYyBhbmQgVnFtbWMgYXJlIGJv
dGggZml4ZWQgKi8NCj4gLQ0KPiAtCQltYXJ2ZWxsLHBhZC10eXBlID0gImZpeGVkLTEtOHYiOw0K
PiAtCX07DQo+IC0NCj4gLS0gRm9yIFNEL1NESU8gd2l0aCBjb21wYXRpYmxlICJtYXJ2ZWxsLGFy
bWFkYS0zNzAwLXNkaGNpIjoNCj4gLQ0KPiAtCXNkaGNpQGFiMDAwMCB7DQo+IC0JCWNvbXBhdGli
bGUgPSAibWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSI7DQo+IC0JCXJlZyA9IDwweGFiMDAwMCAw
eDEwMDA+LA0KPiAtCQkgICAgICA8cGh5X2FkZHIgMHg0PjsNCj4gLQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDU1IElSUV9UWVBFX0xFVkVMX0hJR0g+DQo+IC0JCXZxbW1jLXN1cHBseSA9IDwmc2Rf
cmVndWxhdG9yPjsNCj4gLQkJLyogVm1tYyBpcyBmaXhlZCAqLw0KPiAtCQljbG9ja3MgPSA8JnNk
Y2xrPjsNCj4gLQkJY2xvY2stbmFtZXMgPSAiY29yZSI7DQo+IC0JCWJ1cy13aWR0aCA9IDw0PjsN
Cj4gLQ0KPiAtCQltYXJ2ZWxsLHBhZC10eXBlID0gInNkIjsNCj4gLQl9Ow0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNk
aGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21hcnZlbGws
eGVub24tc2RoY2kueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmVhZTc0OTg2ODZhZg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS55YW1sDQo+IEBA
IC0wLDAgKzEsMjcyIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwjDQo+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gKw0KPiArdGl0bGU6IE1hcnZlbGwgWGVub24gU0RIQ0kgQ29udHJvbGxlcg0KPiArDQo+ICtk
ZXNjcmlwdGlvbjogfA0KPiArICBUaGlzIGZpbGUgZG9jdW1lbnRzIGRpZmZlcmVuY2VzIGJldHdl
ZW4gdGhlIGNvcmUgTU1DIHByb3BlcnRpZXMgZGVzY3JpYmVkIGJ5DQo+ICsgIG1tYy1jb250cm9s
bGVyLnlhbWwgYW5kIHRoZSBwcm9wZXJ0aWVzIHVzZWQgYnkgdGhlIFhlbm9uIGltcGxlbWVudGF0
aW9uLg0KPiArDQo+ICsgIE11bHRpcGxlIFNESENzIG1pZ2h0IGJlIHB1dCBpbnRvIGEgc2luZ2xl
IFhlbm9uIElQLCB0byBzYXZlIHNpemUgYW5kIGNvc3QuDQo+ICsgIEVhY2ggU0RIQyBpcyBpbmRl
cGVuZGVudCBhbmQgb3ducyBpbmRlcGVuZGVudCByZXNvdXJjZXMsIHN1Y2ggYXMgcmVnaXN0ZXIN
Cj4gKyAgc2V0cywgY2xvY2sgYW5kIFBIWS4NCj4gKw0KPiArICBFYWNoIFNESEMgc2hvdWxkIGhh
dmUgYW4gaW5kZXBlbmRlbnQgZGV2aWNlIHRyZWUgbm9kZS4NCj4gKw0KPiArbWFpbnRhaW5lcnM6
DQo+ICsgIC0gVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ICsNCj4gK3By
b3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgb25lT2Y6DQo+ICsgICAgICAtIGVu
dW06DQo+ICsgICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpDQo+ICsgICAgICAg
ICAgLSBtYXJ2ZWxsLGFybWFkYS1jcDExMC1zZGhjaQ0KPiArICAgICAgICAgIC0gbWFydmVsbCxh
cm1hZGEtYXA4MDctc2RoY2kNCj4gKyAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhLWFwODA2LXNk
aGNpDQo+ICsNCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVs
bCxhcm1hZGEtYXA4MDctc2RoY2kNCj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFk
YS1hcDgwNi1zZGhjaQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtaW5JdGVtczogMQ0KPiArICAg
IG1heEl0ZW1zOiAyDQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIEZvciAibWFydmVs
bCxhcm1hZGEtMzcwMC1zZGhjaSIsIHR3byByZWdpc3RlciBhcmVhcy4gIFRoZSBmaXJzdCBvbmUN
Cj4gKyAgICAgIGZvciBYZW5vbiBJUCByZWdpc3Rlci4gVGhlIHNlY29uZCBvbmUgZm9yIHRoZSBB
cm1hZGEgMzcwMCBTb0MgUEhZIFBBRA0KPiArICAgICAgVm9sdGFnZSBDb250cm9sIHJlZ2lzdGVy
LiAgUGxlYXNlIGZvbGxvdyB0aGUgZXhhbXBsZXMgd2l0aCBjb21wYXRpYmxlDQo+ICsgICAgICAi
bWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSIgaW4gYmVsb3cuDQo+ICsgICAgICBQbGVhc2UgYWxz
byBjaGVjayBwcm9wZXJ0eSBtYXJ2ZWxsLHBhZC10eXBlIGluIGJlbG93Lg0KPiArDQo+ICsgICAg
ICBGb3Igb3RoZXIgY29tcGF0aWJsZSBzdHJpbmdzLCBvbmUgcmVnaXN0ZXIgYXJlYSBmb3IgWGVu
b24gSVAuDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1pbkl0ZW1zOiAxDQo+ICsgICAgbWF4
SXRlbXM6IDINCj4gKw0KPiArICBjbG9jay1uYW1lczoNCj4gKyAgICBtaW5JdGVtczogMQ0KPiAr
ICAgIGl0ZW1zOg0KPiArICAgICAgLSBjb25zdDogY29yZQ0KPiArICAgICAgLSBjb25zdDogYXhp
DQo+ICsNCj4gKyAgbWFydmVsbCx4ZW5vbi1zZGhjLWlkOg0KPiArICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgIG1pbmltdW06IDANCj4gKyAg
ICBtYXhpbXVtOiA3DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIEluZGljYXRlIHRo
ZSBjb3JyZXNwb25kaW5nIGJpdCBpbmRleCBvZiBjdXJyZW50IFNESEMgaW4gU0RIQyBTeXN0ZW0N
Cj4gKyAgICAgIE9wZXJhdGlvbiBDb250cm9sIFJlZ2lzdGVyIEJpdFs3OjBdLiAgU2V0L2NsZWFy
IHRoZSBjb3JyZXNwb25kaW5nIGJpdCB0bw0KPiArICAgICAgZW5hYmxlL2Rpc2FibGUgY3VycmVu
dCBTREhDLg0KPiArDQo+ICsgIG1hcnZlbGwseGVub24tcGh5LXR5cGU6DQo+ICsgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nDQo+ICsgICAgZW51bToNCj4g
KyAgICAgIC0gImVtbWMgNS4xIHBoeSINCj4gKyAgICAgIC0gImVtbWMgNS4wIHBoeSINCj4gKyAg
ICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgWGVub24gc3VwcG9ydCBtdWx0aXBsZSB0eXBlcyBv
ZiBQSFlzLiBUbyBzZWxlY3QgZU1NQyA1LjEgUEhZLCBzZXQ6DQo+ICsgICAgICBtYXJ2ZWxsLHhl
bm9uLXBoeS10eXBlID0gImVtbWMgNS4xIHBoeSIgZU1NQyA1LjEgUEhZIGlzIHRoZSBkZWZhdWx0
DQo+ICsgICAgICBjaG9pY2UgaWYgdGhpcyBwcm9wZXJ0eSBpcyBub3QgcHJvdmlkZWQuICBUbyBz
ZWxlY3QgZU1NQyA1LjAgUEhZLCBzZXQ6DQo+ICsgICAgICBtYXJ2ZWxsLHhlbm9uLXBoeS10eXBl
ID0gImVtbWMgNS4wIHBoeSINCj4gKw0KPiArICAgICAgQWxsIHRob3NlIHR5cGVzIG9mIFBIWXMg
Y2FuIHN1cHBvcnQgZU1NQywgU0QgYW5kIFNESU8uIFBsZWFzZSBub3RlIHRoYXQNCj4gKyAgICAg
IHRoaXMgcHJvcGVydHkgb25seSBwcmVzZW50cyB0aGUgdHlwZSBvZiBQSFkuICBJdCBkb2Vzbid0
IHN0YW5kIGZvciB0aGUNCj4gKyAgICAgIGVudGlyZSBTREhDIHR5cGUgb3IgcHJvcGVydHkuICBG
b3IgZXhhbXBsZSwgImVtbWMgNS4xIHBoeSIgZG9lc24ndCBtZWFuDQo+ICsgICAgICB0aGF0IHRo
aXMgWGVub24gU0RIQyBvbmx5IHN1cHBvcnRzIGVNTUMgNS4xLg0KPiArDQo+ICsgIG1hcnZlbGws
eGVub24tcGh5LXpucjoNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gKyAgICBtaW5pbXVtOiAwDQo+ICsgICAgbWF4aW11bTogMHgxZg0KPiAr
ICAgIGRlZmF1bHQ6IDB4Zg0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBTZXQgUEhZ
IFpOUiB2YWx1ZS4NCj4gKyAgICAgIE9ubHkgYXZhaWxhYmxlIGZvciBlTU1DIFBIWS4NCj4gKw0K
PiArICBtYXJ2ZWxsLHhlbm9uLXBoeS16cHI6DQo+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ICsgICAgbWluaW11bTogMA0KPiArICAgIG1heGlt
dW06IDB4MWYNCj4gKyAgICBkZWZhdWx0OiAweGYNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiAr
ICAgICAgU2V0IFBIWSBaUFIgdmFsdWUuDQo+ICsgICAgICBPbmx5IGF2YWlsYWJsZSBmb3IgZU1N
QyBQSFkuDQo+ICsNCj4gKyAgbWFydmVsbCx4ZW5vbi1waHktbnItc3VjY2Vzcy10dW46DQo+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ICsgICAg
bWluaW11bTogMQ0KPiArICAgIG1heGltdW06IDcNCj4gKyAgICBkZWZhdWx0OiAweDQNCj4gKyAg
ICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgU2V0IHRoZSBudW1iZXIgb2YgcmVxdWlyZWQgY29u
c2VjdXRpdmUgc3VjY2Vzc2Z1bCBzYW1wbGluZyBwb2ludHMNCj4gKyAgICAgIHVzZWQgdG8gaWRl
bnRpZnkgYSB2YWxpZCBzYW1wbGluZyB3aW5kb3csIGluIHR1bmluZyBwcm9jZXNzLg0KPiArDQo+
ICsgIG1hcnZlbGwseGVub24tcGh5LXR1bi1zdGVwLWRpdmlkZXI6DQo+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ICsgICAgZGVmYXVsdDogNjQN
Cj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgU2V0IHRoZSBkaXZpZGVyIGZvciBjYWxj
dWxhdGluZyBUVU5fU1RFUC4NCj4gKw0KPiArICBtYXJ2ZWxsLHhlbm9uLXBoeS1zbG93LW1vZGU6
DQo+ICsgICAgdHlwZTogYm9vbGVhbg0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBJ
ZiB0aGlzIHByb3BlcnR5IGlzIHNlbGVjdGVkLCB0cmFuc2ZlcnMgd2lsbCBieXBhc3MgUEhZLg0K
PiArICAgICAgT25seSBhdmFpbGFibGUgd2hlbiBidXMgZnJlcXVlbmN5IGxvd2VyIHRoYW4gNTVN
SHogaW4gU0RSIG1vZGUuDQo+ICsgICAgICBEaXNhYmxlZCBieSBkZWZhdWx0LiBQbGVhc2Ugb25s
eSB0cnkgdGhpcyBwcm9wZXJ0eSBpZiB0aW1pbmcgaXNzdWVzDQo+ICsgICAgICBhbHdheXMgb2Nj
dXIgd2l0aCBQSFkgZW5hYmxlZCBpbiBlTU1DIEhTIFNEUiwgU0QgU0RSMTIsIFNEIFNEUjI1LA0K
PiArICAgICAgU0QgRGVmYXVsdCBTcGVlZCBhbmQgSFMgbW9kZSBhbmQgZU1NQyBsZWdhY3kgc3Bl
ZWQgbW9kZS4NCj4gKw0KPiArICBtYXJ2ZWxsLHhlbm9uLXR1bi1jb3VudDoNCj4gKyAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gKyAgICBkZWZhdWx0
OiAweDkNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAgWGVub24gU0RIQyBTb0MgdXN1
YWxseSBkb2Vzbid0IHByb3ZpZGUgcmUtdHVuaW5nIGNvdW50ZXIgaW4NCj4gKyAgICAgIENhcGFi
aWxpdGllcyBSZWdpc3RlciAzIEJpdFsxMTo4XS4NCj4gKyAgICAgIFRoaXMgcHJvcGVydHkgcHJv
dmlkZXMgdGhlIHJlLXR1bmluZyBjb3VudGVyLg0KPiArDQo+ICthbGxPZjoNCj4gKyAgLSAkcmVm
OiBtbWMtY29udHJvbGxlci55YW1sIw0KPiArICAtIGlmOg0KPiArICAgICAgcHJvcGVydGllczoN
Cj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gKyAgICAgICAgICBjb250YWluczoNCj4gKyAgICAg
ICAgICAgIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpDQo+ICsNCj4gKyAgICB0aGVu
Og0KPiArICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgcmVnOg0KPiArICAgICAgICAgIGl0
ZW1zOg0KPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogWGVub24gSVAgcmVnaXN0ZXJzDQo+
ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBBcm1hZGEgMzcwMCBTb0MgUEhZIFBBRCBWb2x0
YWdlIENvbnRyb2wgcmVnaXN0ZXINCj4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiArDQo+ICsg
ICAgICAgIG1hcnZlbGwscGFkLXR5cGU6DQo+ICsgICAgICAgICAgZW51bToNCj4gKyAgICAgICAg
ICAgIC0gc2QNCj4gKyAgICAgICAgICAgIC0gZml4ZWQtMS04dg0KPiArICAgICAgICAgIGRlc2Ny
aXB0aW9uOiB8DQo+ICsgICAgICAgICAgICBUeXBlIG9mIEFybWFkYSAzNzAwIFNvQyBQSFkgUEFE
IFZvbHRhZ2UgQ29udHJvbGxlciByZWdpc3Rlci4NCj4gKyAgICAgICAgICAgIElmICJzZCIgaXMg
c2VsZWN0ZWQsIFNvQyBQSFkgUEFEIGlzIHNldCBhcyAzLjNWIGF0IHRoZSBiZWdpbm5pbmcNCj4g
KyAgICAgICAgICAgIGFuZCBpcyBzd2l0Y2hlZCB0byAxLjhWIHdoZW4gbGF0ZXIgaW4gaGlnaGVy
IHNwZWVkIG1vZGUuDQo+ICsgICAgICAgICAgICBJZiAiZml4ZWQtMS04diIgaXMgc2VsZWN0ZWQs
IFNvQyBQSFkgUEFEIGlzIGZpeGVkIDEuOFYsIHN1Y2ggYXMgZm9yDQo+ICsgICAgICAgICAgICBl
TU1DLg0KPiArICAgICAgICAgICAgUGxlYXNlIGZvbGxvdyB0aGUgZXhhbXBsZXMgd2l0aCBjb21w
YXRpYmxlDQo+ICsgICAgICAgICAgICAibWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSIgaW4gYmVs
b3cuDQo+ICsNCj4gKyAgICAgIHJlcXVpcmVkOg0KPiArICAgICAgICAtIG1hcnZlbGwscGFkLXR5
cGUNCj4gKw0KPiArICAtIGlmOg0KPiArICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgY29t
cGF0aWJsZToNCj4gKyAgICAgICAgICBjb250YWluczoNCj4gKyAgICAgICAgICAgIGVudW06DQo+
ICsgICAgICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEtY3AxMTAtc2RoY2kNCj4gKyAgICAgICAg
ICAgICAgLSBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1zZGhjaQ0KPiArICAgICAgICAgICAgICAtIG1h
cnZlbGwsYXJtYWRhLWFwODA2LXNkaGNpDQoNCkluIGNvbW1pdCBiYjE2ZWExNzQyYzggKCJtbWM6
IHNkaGNpLXhlbm9uOiBGaXggY2xvY2sgcmVzb3VyY2UgYnkgYWRkaW5nIA0KYW4gb3B0aW9uYWwg
YnVzIGNsb2NrIikgeW91IGFkZGVkIGEgY29tbWVudCB0aGF0ICJGb3IgQXJtYWRhIEFQODA2IGFu
ZCANCkNQMTEwLCB0aGUgQVhJIGNsb2NrIGlzIGFsc28gbWFuZGF0b3J5Ii4gVGhlIGNwMTEwIGJs
b2NrcyBhbGwgc3VwcGx5IGFuZCANCmF4aSBjbG9jayBidXQgbm9uZSBvZiB0aGUgZXhpc3Rpbmcg
YXA4MDYvYXA4MDcgYmxvY2tzIHN1cHBseSBhbiBheGkgDQpjbG9jay4gRG9lcyB0aGlzIG1lYW4g
dGhleSdyZSBhbGwgYnJva2VuIG9yIGlzIHRoZSBjbG9jayBhY3R1YWxseSANCm9wdGlvbmFsIGZv
ciB0aGUgYXA4MDYgKHRoZSBjb2RlIHNlZW1zIHRvIHRyZWF0IGl0IGFzIHN1Y2gpLg0KDQo+ICsN
Cj4gKyAgICB0aGVuOg0KPiArICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgY2xvY2tzOg0K
PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+ICsNCj4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+
ICsgICAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgICAtIGNvbnN0OiBjb3JlDQo+ICsgICAg
ICAgICAgICAtIGNvbnN0OiBheGkNCj4gKw0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBjb21w
YXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0gY2xvY2stbmFtZXMNCj4g
Kw0KPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtleGFtcGxlczoNCj4g
KyAgLSB8DQo+ICsgICAgLy8gRm9yIGVNTUMNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKw0KPiArICAgIG1tY0BhYTAwMDAg
ew0KPiArICAgICAgY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS1hcDgwNy1zZGhjaSIsICJt
YXJ2ZWxsLGFybWFkYS1hcDgwNi1zZGhjaSI7DQo+ICsgICAgICByZWcgPSA8MHhhYTAwMDAgMHgx
MDAwPjsNCj4gKyAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMyBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gKyAgICAgIGNsb2NrcyA9IDwmZW1tY19jbGsgMD4sIDwmYXhpX2NsayAwPjsNCj4g
KyAgICAgIGNsb2NrLW5hbWVzID0gImNvcmUiLCAiYXhpIjsNCj4gKyAgICAgIGJ1cy13aWR0aCA9
IDw0PjsNCj4gKyAgICAgIG1hcnZlbGwseGVub24tcGh5LXNsb3ctbW9kZTsNCj4gKyAgICAgIG1h
cnZlbGwseGVub24tdHVuLWNvdW50ID0gPDExPjsNCj4gKyAgICAgIG5vbi1yZW1vdmFibGU7DQo+
ICsgICAgICBuby1zZDsNCj4gKyAgICAgIG5vLXNkaW87DQo+ICsNCj4gKyAgICAgIC8qIFZtbWMg
YW5kIFZxbW1jIGFyZSBib3RoIGZpeGVkICovDQo+ICsgICAgfTsNCj4gKw0KPiArICAtIHwNCj4g
KyAgICAvLyBGb3IgU0QvU0RJTw0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lu
dGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiArDQo+ICsgICAgbW1jQGFiMDAwMCB7DQo+ICsg
ICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNpIjsNCj4gKyAgICAg
IHJlZyA9IDwweGFiMDAwMCAweDEwMDA+Ow0KPiArICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDU1IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgdnFtbWMtc3VwcGx5ID0gPCZzZF92
cW1tY19yZWd1bGF0b3I+Ow0KPiArICAgICAgdm1tYy1zdXBwbHkgPSA8JnNkX3ZtbWNfcmVndWxh
dG9yPjsNCj4gKyAgICAgIGNsb2NrcyA9IDwmc2RjbGsgMD4sIDwmYXhpX2NsayAwPjsNCj4gKyAg
ICAgIGNsb2NrLW5hbWVzID0gImNvcmUiLCAiYXhpIjsNCj4gKyAgICAgIGJ1cy13aWR0aCA9IDw0
PjsNCj4gKyAgICAgIG1hcnZlbGwseGVub24tdHVuLWNvdW50ID0gPDk+Ow0KPiArICAgIH07DQo+
ICsNCj4gKyAgLSB8DQo+ICsgICAgLy8gRm9yIGVNTUMgd2l0aCBjb21wYXRpYmxlICJtYXJ2ZWxs
LGFybWFkYS0zNzAwLXNkaGNpIjoNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKw0KPiArICAgIG1tY0BhYTAwMDAgew0KPiAr
ICAgICAgY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpIjsNCj4gKyAgICAg
IHJlZyA9IDwweGFhMDAwMCAweDEwMDA+LA0KPiArICAgICAgICAgICAgPDB4MTc4MDggMHg0PjsN
Cj4gKyAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gKyAgICAgIGNsb2NrcyA9IDwmZW1tY2NsayAwPjsNCj4gKyAgICAgIGNsb2NrLW5hbWVzID0g
ImNvcmUiOw0KPiArICAgICAgYnVzLXdpZHRoID0gPDg+Ow0KPiArICAgICAgbW1jLWRkci0xXzh2
Ow0KPiArICAgICAgbW1jLWhzNDAwLTFfOHY7DQo+ICsgICAgICBub24tcmVtb3ZhYmxlOw0KPiAr
ICAgICAgbm8tc2Q7DQo+ICsgICAgICBuby1zZGlvOw0KPiArDQo+ICsgICAgICAvKiBWbW1jIGFu
ZCBWcW1tYyBhcmUgYm90aCBmaXhlZCAqLw0KPiArDQo+ICsgICAgICBtYXJ2ZWxsLHBhZC10eXBl
ID0gImZpeGVkLTEtOHYiOw0KPiArICAgIH07DQo+ICsNCj4gKyAgLSB8DQo+ICsgICAgLy8gRm9y
IFNEL1NESU8gd2l0aCBjb21wYXRpYmxlICJtYXJ2ZWxsLGFybWFkYS0zNzAwLXNkaGNpIjoNCj4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5o
Pg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEu
aD4NCj4gKw0KPiArICAgIG1tY0BhYjAwMDAgew0KPiArICAgICAgY29tcGF0aWJsZSA9ICJtYXJ2
ZWxsLGFybWFkYS0zNzAwLXNkaGNpIjsNCj4gKyAgICAgIHJlZyA9IDwweGFiMDAwMCAweDEwMDA+
LA0KPiArICAgICAgICAgICAgPDB4MTc4MDggMHg0PjsNCj4gKyAgICAgIGludGVycnVwdHMgPSA8
R0lDX1NQSSA1NSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgIHZxbW1jLXN1cHBseSA9
IDwmc2RfcmVndWxhdG9yPjsNCj4gKyAgICAgIC8qIFZtbWMgaXMgZml4ZWQgKi8NCj4gKyAgICAg
IGNsb2NrcyA9IDwmc2RjbGsgMD47DQo+ICsgICAgICBjbG9jay1uYW1lcyA9ICJjb3JlIjsNCj4g
KyAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gKw0KPiArICAgICAgbWFydmVsbCxwYWQtdHlwZSA9
ICJzZCI7DQo+ICsgICAgfTsNCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5F
UlMNCj4gaW5kZXggMDVmZDA4MGI4MmYzLi44ZTBhMTlkM2I4ZDUgMTAwNjQ0DQo+IC0tLSBhL01B
SU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0xMTU5NSw3ICsxMTU5NSw3IEBA
IE1BUlZFTEwgWEVOT04gTU1DL1NEL1NESU8gSE9TVCBDT05UUk9MTEVSIERSSVZFUg0KPiAgIE06
CUh1IFppamkgPGh1emlqaUBtYXJ2ZWxsLmNvbT4NCj4gICBMOglsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnDQo+ICAgUzoJU3VwcG9ydGVkDQo+IC1GOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbW1jL21hcnZlbGwseGVub24tc2RoY2kudHh0DQo+ICtGOglEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21hcnZlbGwseGVub24tc2RoY2kueWFtbA0KPiAgIEY6
CWRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kteGVub24qDQo+ICAgDQo+ICAgTUFUUk9YIEZSQU1FQlVG
RkVSIERSSVZFUg==
