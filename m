Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F317E6464
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Nov 2023 08:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjKIHg3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Nov 2023 02:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIHg2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Nov 2023 02:36:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC0A4;
        Wed,  8 Nov 2023 23:36:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A97YlrP61389220, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A97YlrP61389220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 15:34:47 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 15:34:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Nov 2023 15:34:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 9 Nov 2023 15:34:47 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
Subject: RE: [PATCH V5][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Thread-Topic: [PATCH V5][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Thread-Index: AQHaDWS6bgJQYjHbsUGXSDsoEHOUn7BmNDyAgAttm+A=
Date:   Thu, 9 Nov 2023 07:34:47 +0000
Message-ID: <6da3391700204ebc8d2c0bb5e927d2c8@realtek.com>
References: <20231102081514.22945-1-jyanchou@realtek.com>
 <20231102081514.22945-4-jyanchou@realtek.com>
 <9c083c35-a8fb-4ee3-90a3-96af7efec11f@linaro.org>
In-Reply-To: <9c083c35-a8fb-4ee3-90a3-96af7efec11f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+PiBBZGQgUmVhbHRlayBtbWMgZHJpdmVyIHRvIG1ha2UgZ29vZCB1
c2UgU3lub3BzeXMgRGVzaWduV2FyZSBtbWMgY21kcSANCj4+IGhvc3QgZHJpdmVyLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEp5YW4gQ2hvdSA8anlhbmNob3VAcmVhbHRlay5jb20+DQo+Pg0KPj4g
LS0tDQo+PiB2NCAtPiB2NToNCj4+IC0gRml4IGxpbnV4IGNvZGluZyBzdHlsZSBpc3N1ZXMuDQo+
PiAtIE1vZGlmeSB0aGUgdXNlIG9mIHNpemVvZigqKS4NCj4+IC0gUmVtb3ZlIHVzZWxlc3MgZnVu
Y3Rpb24gYW5kIHBhcmFtZXRlciBwYXNzaW5nLg0KPj4gLSBSZXBsYWNlIHBsYXRmb3JtX2dldF9y
ZXNvdXJjZSBieSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKS4NCg0KPiBJdCdzIG1l
cmdlIHdpbmRvdy4gU2VuZGluZyBiaWcgcGF0Y2hzZXQgZXZlcnkgZGF5IHdvbid0IGdldCB5b3Ug
ZmFyLg0KDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kLg0KDQo+Pg0KPj4gdjMgLT4gdjQ6DQo+PiAt
IE1vZGlmeSBkbWEgc2V0dGluZydzIGNvZGUgdG8gZml4IGxpbnV4IGNvZGluZyBzdHlsZS4NCj4+
IC0gRHJvcCB1c2VsZXNzIGZ1bmN0aW9uIG1lc3NhZ2VzLg0KPj4gLSBSZW1vdmUgTU9EVUxFX0FM
SUFTKCkuDQo+Pg0KPj4gdjAgLT4gdjE6DQo+PiAtIEZpeCB0aGUgY29tcGlsZXIgY29tcGxhaW5z
Lg0KPj4gLS0tDQoNCg0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgZHdfbWNpX3J0a19wYXJzZV9kdChz
dHJ1Y3QgZHdfbWNpICpob3N0KSB7DQo+PiArICAgICBzdHJ1Y3QgZHdfbWNpX3J0a2VtbWNfaG9z
dCAqcHJpdjsNCj4+ICsgICAgIGNvbnN0IHUzMiAqcHJvcDsNCj4+ICsgICAgIGludCBzaXplLCBy
ZXQ7DQo+PiArDQo+PiArICAgICBwcml2ID0gZGV2bV9remFsbG9jKGhvc3QtPmRldiwgc2l6ZW9m
KCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+PiArICAgICBpZiAoIXByaXYpDQo+PiArICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKyAgICAgcHJpdi0+cGluY3RybCA9IGRldm1f
cGluY3RybF9nZXQoaG9zdC0+ZGV2KTsNCj4+ICsgICAgIGlmIChJU19FUlIocHJpdi0+cGluY3Ry
bCkpDQo+PiArICAgICAgICAgICAgIGRldl9kYmcoaG9zdC0+ZGV2LCAibm8gcGluY3RybFxuIik7
DQo+PiArDQo+PiArICAgICBwcml2LT5waW5zX2RlZmF1bHQgPSBwaW5jdHJsX2xvb2t1cF9zdGF0
ZShwcml2LT5waW5jdHJsLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUElOQ1RSTF9TVEFURV9ERUZBVUxUKTsNCj4+ICsgICAgIGlmIChJU19FUlIo
cHJpdi0+cGluc19kZWZhdWx0KSkNCj4+ICsgICAgICAgICAgICAgZGV2X3dhcm4oaG9zdC0+ZGV2
LCAiY291bGQgbm90IGdldCBkZWZhdWx0IHN0YXRlXG4iKTsNCj4+ICsNCj4+ICsgICAgIHByaXYt
PnBpbnNfc2RyNTAgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShwcml2LT5waW5jdHJsLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJzZHI1MCIpOw0KPj4g
KyAgICAgaWYgKElTX0VSUihwcml2LT5waW5zX3NkcjUwKSkNCj4+ICsgICAgICAgICAgICAgZGV2
X3dhcm4oaG9zdC0+ZGV2LCAiY291bGQgbm90IGdldCBzZHI1MCBzdGF0ZVxuIik7DQo+PiArDQo+
PiArICAgICBwcml2LT5waW5zX2hzMjAwID0gcGluY3RybF9sb29rdXBfc3RhdGUocHJpdi0+cGlu
Y3RybCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
aHMyMDAiKTsNCj4+ICsgICAgIGlmIChJU19FUlIocHJpdi0+cGluc19oczIwMCkpDQo+PiArICAg
ICAgICAgICAgIGRldl93YXJuKGhvc3QtPmRldiwgImNvdWxkIG5vdCBnZXQgaHMyMDAgc3RhdGVc
biIpOw0KPj4gKw0KPj4gKyAgICAgcHJpdi0+cGluc19oczQwMCA9IHBpbmN0cmxfbG9va3VwX3N0
YXRlKHByaXYtPnBpbmN0cmwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImhzNDAwIik7DQo+PiArICAgICBpZiAoSVNfRVJSKHByaXYtPnBpbnNfaHM0
MDApKQ0KPj4gKyAgICAgICAgICAgICBkZXZfd2Fybihob3N0LT5kZXYsICJjb3VsZCBub3QgZ2V0
IGhzNDAwIHN0YXRlXG4iKTsNCj4+ICsNCj4+ICsgICAgIHByaXYtPnBpbnNfdHVuZTAgPSBwaW5j
dHJsX2xvb2t1cF9zdGF0ZShwcml2LT5waW5jdHJsLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJ0dW5lMCIpOw0KPj4gKyAgICAgaWYgKElTX0VSUihw
cml2LT5waW5zX3R1bmUwKSkNCj4+ICsgICAgICAgICAgICAgZGV2X3dhcm4oaG9zdC0+ZGV2LCAi
Y291bGQgbm90IGdldCB0dW5lMCBzdGF0ZVxuIik7DQo+PiArDQo+PiArICAgICBwcml2LT5waW5z
X3R1bmUxID0gcGluY3RybF9sb29rdXBfc3RhdGUocHJpdi0+cGluY3RybCwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHVuZTEiKTsNCj4+ICsgICAg
IGlmIChJU19FUlIocHJpdi0+cGluc190dW5lMSkpDQo+PiArICAgICAgICAgICAgIGRldl93YXJu
KGhvc3QtPmRldiwgImNvdWxkIG5vdCBnZXQgdHVuZTEgc3RhdGVcbiIpOw0KPj4gKw0KPj4gKyAg
ICAgcHJpdi0+cGluc190dW5lMiA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKHByaXYtPnBpbmN0cmws
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInR1bmUy
Iik7DQo+PiArICAgICBpZiAoSVNfRVJSKHByaXYtPnBpbnNfdHVuZTIpKQ0KPj4gKyAgICAgICAg
ICAgICBkZXZfd2Fybihob3N0LT5kZXYsICJjb3VsZCBub3QgZ2V0IHR1bmUyIHN0YXRlXG4iKTsN
Cj4+ICsNCj4+ICsgICAgIHByaXYtPnBpbnNfdHVuZTMgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShw
cml2LT5waW5jdHJsLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJ0dW5lMyIpOw0KPj4gKyAgICAgaWYgKElTX0VSUihwcml2LT5waW5zX3R1bmUzKSkN
Cj4+ICsgICAgICAgICAgICAgZGV2X3dhcm4oaG9zdC0+ZGV2LCAiY291bGQgbm90IGdldCB0dW5l
MyBzdGF0ZVxuIik7DQo+PiArDQo+PiArICAgICBwcml2LT5waW5zX3R1bmU0ID0gcGluY3RybF9s
b29rdXBfc3RhdGUocHJpdi0+cGluY3RybCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAidHVuZTQiKTsNCj4+ICsNCj4+ICsgICAgIGlmIChJU19FUlIo
cHJpdi0+cGluc190dW5lNCkpDQo+PiArICAgICAgICAgICAgIGRldl93YXJuKGhvc3QtPmRldiwg
ImNvdWxkIG5vdCBnZXQgdHVuZTQgc3RhdGVcbiIpOw0KPj4gKw0KPj4gKyAgICAgcHJpdi0+dnAw
ID0gZGV2bV9jbGtfZ2V0KGhvc3QtPmRldiwgInZwMCIpOw0KPj4gKyAgICAgaWYgKElTX0VSUihw
cml2LT52cDApKQ0KPj4gKyAgICAgICAgICAgICBkZXZfZXJyX3Byb2JlKGhvc3QtPmRldiwgcmV0
LCAiY291bGQgbm90IGdldCB2cDAgDQo+PiArIGNsa1xuIik7DQo+PiArDQo+PiArICAgICBwcml2
LT52cDEgPSBkZXZtX2Nsa19nZXQoaG9zdC0+ZGV2LCAidnAxIik7DQo+PiArICAgICBpZiAoSVNf
RVJSKHByaXYtPnZwMSkpDQo+PiArICAgICAgICAgICAgIGRldl9lcnJfcHJvYmUoaG9zdC0+ZGV2
LCByZXQsICJjb3VsZCBub3QgZ2V0IHZwMSANCj4+ICsgY2xrXG4iKTsNCj4+ICsNCj4+ICsgICAg
IGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woaG9zdC0+ZGV2LT5vZl9ub2RlLCAic3VwcG9ydHMt
Y3FlIikpDQo+PiArICAgICAgICAgICAgIHByaXYtPmlzX2NxZSA9IDE7DQo+PiArICAgICBlbHNl
DQo+PiArICAgICAgICAgICAgIHByaXYtPmlzX2NxZSA9IDA7DQo+PiArDQo+PiArICAgICBwcm9w
ID0gb2ZfZ2V0X3Byb3BlcnR5KGhvc3QtPmRldi0+b2Zfbm9kZSwgInJkcS1jdHJsIiwgJnNpemUp
Ow0KDQo+IE5BSw0KDQpJIHdpbGwgcmVtb3ZlIHVzZWxlc3MgYmluZGluZ3MuDQoNCj4+ICsgICAg
IGlmIChwcm9wKQ0KPj4gKyAgICAgICAgICAgICBwcml2LT5yZHFfY3RybCA9IG9mX3JlYWRfbnVt
YmVyKHByb3AsIDEpOw0KPj4gKyAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICBwcml2LT5yZHFf
Y3RybCA9IDA7DQo+PiArDQo+PiArICAgICBwcml2LT5lbW1jX21vZGUgPSAzOw0KPj4gKw0KPj4g
KyAgICAgcHJpdi0+bTJ0bXggPSANCj4+ICsgc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRs
ZShob3N0LT5kZXYtPm9mX25vZGUsIA0KPj4gKyAicmVhbHRlayxtMnRteCIpOw0KDQo+IE5BSywg
Zm9yIHRoZSBzYW1lIHJlYXNvbnMgSSBtZW50aW9uZWQgZm9yIG90aGVyIHBhdGNoLg0KDQo+IEkg
d2lsbCBrZWVwIE5BSy1pbmcgdGlsbCB5b3Ugc3RhcnQgdGVzdGluZyB5b3VyIERUUy4NCg0KU29y
cnksIEkgYW0gbm90IHN1cmUgd2hldGhlciBJIG1vZGlmeSB0aGUgY29ycmVjdCB0aGluZyB5b3Ug
c2FpZC4gSSB3aWxsIGFkZA0KDQpyZWFsdGVrLG0ydG14IGluIGJpbmRpbmdzLg0KDQo+PiArICAg
ICBpZiAoSVNfRVJSX09SX05VTEwocHJpdi0+bTJ0bXgpKQ0KPj4gKyAgICAgICAgICAgICBkZXZf
ZXJyX3Byb2JlKGhvc3QtPmRldiwgcmV0LCAiY2FuIG5vdCBnZXQgbTJtdHggDQo+PiArIG5vZGUu
XG4iKTsNCj4+ICsNCj4+ICsgICAgIGhvc3QtPnByaXYgPSBwcml2Ow0KPj4gKw0KPj4gKyAgICAg
cmV0dXJuIDA7DQo+PiArfQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPiANClNlbnQ6
IFRodXJzZGF5LCBOb3ZlbWJlciAyLCAyMDIzIDQ6NTcgUE0NClRvOiBKeWFuIENob3UgW+WRqOiK
t+WuiV0gPGp5YW5jaG91QHJlYWx0ZWsuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgYWRy
aWFuLmh1bnRlckBpbnRlbC5jb207IGpoODAuY2h1bmdAc2Ftc3VuZy5jb207IHJpdGVzaGhAY29k
ZWF1cm9yYS5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBhc3V0b3NoZEBjb2RlYXVyb3JhLm9yZw0K
Q2M6IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBh
cm5kQGFybmRiLmRlOyBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7IGRvdWdAc2NobW9yZ2FsLmNv
bTsgdG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tOyBhYmVsLnZlc2FAbGluYXJvLm9yZzsgd2ls
bGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbQ0KU3ViamVjdDogUmU6IFtQQVRDSCBWNV1bMy80XSBt
bWM6IEFkZCBkdyBtb2JpbGUgbW1jIGNtZHEgcnRrIGRyaXZlcg0KDQoNCkV4dGVybmFsIG1haWwu
DQoNCg0KDQpPbiAwMi8xMS8yMDIzIDA5OjE1LCBKeWFuIENob3Ugd3JvdGU6DQo+IEFkZCBSZWFs
dGVrIG1tYyBkcml2ZXIgdG8gbWFrZSBnb29kIHVzZSBTeW5vcHN5cyBEZXNpZ25XYXJlIG1tYyBj
bWRxIA0KPiBob3N0IGRyaXZlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSnlhbiBDaG91IDxqeWFu
Y2hvdUByZWFsdGVrLmNvbT4NCj4NCj4gLS0tDQo+IHY0IC0+IHY1Og0KPiAtIEZpeCBsaW51eCBj
b2Rpbmcgc3R5bGUgaXNzdWVzLg0KPiAtIE1vZGlmeSB0aGUgdXNlIG9mIHNpemVvZigqKS4NCj4g
LSBSZW1vdmUgdXNlbGVzcyBmdW5jdGlvbiBhbmQgcGFyYW1ldGVyIHBhc3NpbmcuDQo+IC0gUmVw
bGFjZSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UgYnkgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlKCkuDQoNCkl0J3MgbWVyZ2Ugd2luZG93LiBTZW5kaW5nIGJpZyBwYXRjaHNldCBldmVyeSBk
YXkgd29uJ3QgZ2V0IHlvdSBmYXIuDQoNCj4NCj4gdjMgLT4gdjQ6DQo+IC0gTW9kaWZ5IGRtYSBz
ZXR0aW5nJ3MgY29kZSB0byBmaXggbGludXggY29kaW5nIHN0eWxlLg0KPiAtIERyb3AgdXNlbGVz
cyBmdW5jdGlvbiBtZXNzYWdlcy4NCj4gLSBSZW1vdmUgTU9EVUxFX0FMSUFTKCkuDQo+DQo+IHYw
IC0+IHYxOg0KPiAtIFNlcGVyYXRlIGRpZmZlcmVudCBzdXBwb3J0IGludG8gc2luZ2xlIHBhdGNo
Lg0KPiAtIEZpeCB0aGUgY29tcGlsZXIgY29tcGxhaW5zLg0KPiAtLS0NCg0KDQo+ICsNCj4gK3N0
YXRpYyBpbnQgZHdfbWNpX3J0a19wYXJzZV9kdChzdHJ1Y3QgZHdfbWNpICpob3N0KSB7DQo+ICsg
ICAgIHN0cnVjdCBkd19tY2lfcnRrZW1tY19ob3N0ICpwcml2Ow0KPiArICAgICBjb25zdCB1MzIg
KnByb3A7DQo+ICsgICAgIGludCBzaXplLCByZXQ7DQo+ICsNCj4gKyAgICAgcHJpdiA9IGRldm1f
a3phbGxvYyhob3N0LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiArICAgICBp
ZiAoIXByaXYpDQo+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKyAgICAg
cHJpdi0+cGluY3RybCA9IGRldm1fcGluY3RybF9nZXQoaG9zdC0+ZGV2KTsNCj4gKyAgICAgaWYg
KElTX0VSUihwcml2LT5waW5jdHJsKSkNCj4gKyAgICAgICAgICAgICBkZXZfZGJnKGhvc3QtPmRl
diwgIm5vIHBpbmN0cmxcbiIpOw0KPiArDQo+ICsgICAgIHByaXYtPnBpbnNfZGVmYXVsdCA9IHBp
bmN0cmxfbG9va3VwX3N0YXRlKHByaXYtPnBpbmN0cmwsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBJTkNUUkxfU1RBVEVfREVGQVVMVCk7DQo+ICsg
ICAgIGlmIChJU19FUlIocHJpdi0+cGluc19kZWZhdWx0KSkNCj4gKyAgICAgICAgICAgICBkZXZf
d2Fybihob3N0LT5kZXYsICJjb3VsZCBub3QgZ2V0IGRlZmF1bHQgc3RhdGVcbiIpOw0KPiArDQo+
ICsgICAgIHByaXYtPnBpbnNfc2RyNTAgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShwcml2LT5waW5j
dHJsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInNk
cjUwIik7DQo+ICsgICAgIGlmIChJU19FUlIocHJpdi0+cGluc19zZHI1MCkpDQo+ICsgICAgICAg
ICAgICAgZGV2X3dhcm4oaG9zdC0+ZGV2LCAiY291bGQgbm90IGdldCBzZHI1MCBzdGF0ZVxuIik7
DQo+ICsNCj4gKyAgICAgcHJpdi0+cGluc19oczIwMCA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKHBy
aXYtPnBpbmN0cmwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiaHMyMDAiKTsNCj4gKyAgICAgaWYgKElTX0VSUihwcml2LT5waW5zX2hzMjAwKSkNCj4g
KyAgICAgICAgICAgICBkZXZfd2Fybihob3N0LT5kZXYsICJjb3VsZCBub3QgZ2V0IGhzMjAwIHN0
YXRlXG4iKTsNCj4gKw0KPiArICAgICBwcml2LT5waW5zX2hzNDAwID0gcGluY3RybF9sb29rdXBf
c3RhdGUocHJpdi0+cGluY3RybCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJoczQwMCIpOw0KPiArICAgICBpZiAoSVNfRVJSKHByaXYtPnBpbnNfaHM0
MDApKQ0KPiArICAgICAgICAgICAgIGRldl93YXJuKGhvc3QtPmRldiwgImNvdWxkIG5vdCBnZXQg
aHM0MDAgc3RhdGVcbiIpOw0KPiArDQo+ICsgICAgIHByaXYtPnBpbnNfdHVuZTAgPSBwaW5jdHJs
X2xvb2t1cF9zdGF0ZShwcml2LT5waW5jdHJsLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgInR1bmUwIik7DQo+ICsgICAgIGlmIChJU19FUlIocHJpdi0+
cGluc190dW5lMCkpDQo+ICsgICAgICAgICAgICAgZGV2X3dhcm4oaG9zdC0+ZGV2LCAiY291bGQg
bm90IGdldCB0dW5lMCBzdGF0ZVxuIik7DQo+ICsNCj4gKyAgICAgcHJpdi0+cGluc190dW5lMSA9
IHBpbmN0cmxfbG9va3VwX3N0YXRlKHByaXYtPnBpbmN0cmwsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHVuZTEiKTsNCj4gKyAgICAgaWYgKElTX0VS
Uihwcml2LT5waW5zX3R1bmUxKSkNCj4gKyAgICAgICAgICAgICBkZXZfd2Fybihob3N0LT5kZXYs
ICJjb3VsZCBub3QgZ2V0IHR1bmUxIHN0YXRlXG4iKTsNCj4gKw0KPiArICAgICBwcml2LT5waW5z
X3R1bmUyID0gcGluY3RybF9sb29rdXBfc3RhdGUocHJpdi0+cGluY3RybCwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ0dW5lMiIpOw0KPiArICAgICBp
ZiAoSVNfRVJSKHByaXYtPnBpbnNfdHVuZTIpKQ0KPiArICAgICAgICAgICAgIGRldl93YXJuKGhv
c3QtPmRldiwgImNvdWxkIG5vdCBnZXQgdHVuZTIgc3RhdGVcbiIpOw0KPiArDQo+ICsgICAgIHBy
aXYtPnBpbnNfdHVuZTMgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShwcml2LT5waW5jdHJsLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInR1bmUzIik7DQo+
ICsgICAgIGlmIChJU19FUlIocHJpdi0+cGluc190dW5lMykpDQo+ICsgICAgICAgICAgICAgZGV2
X3dhcm4oaG9zdC0+ZGV2LCAiY291bGQgbm90IGdldCB0dW5lMyBzdGF0ZVxuIik7DQo+ICsNCj4g
KyAgICAgcHJpdi0+cGluc190dW5lNCA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKHByaXYtPnBpbmN0
cmwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHVu
ZTQiKTsNCj4gKw0KPiArICAgICBpZiAoSVNfRVJSKHByaXYtPnBpbnNfdHVuZTQpKQ0KPiArICAg
ICAgICAgICAgIGRldl93YXJuKGhvc3QtPmRldiwgImNvdWxkIG5vdCBnZXQgdHVuZTQgc3RhdGVc
biIpOw0KPiArDQo+ICsgICAgIHByaXYtPnZwMCA9IGRldm1fY2xrX2dldChob3N0LT5kZXYsICJ2
cDAiKTsNCj4gKyAgICAgaWYgKElTX0VSUihwcml2LT52cDApKQ0KPiArICAgICAgICAgICAgIGRl
dl9lcnJfcHJvYmUoaG9zdC0+ZGV2LCByZXQsICJjb3VsZCBub3QgZ2V0IHZwMCANCj4gKyBjbGtc
biIpOw0KPiArDQo+ICsgICAgIHByaXYtPnZwMSA9IGRldm1fY2xrX2dldChob3N0LT5kZXYsICJ2
cDEiKTsNCj4gKyAgICAgaWYgKElTX0VSUihwcml2LT52cDEpKQ0KPiArICAgICAgICAgICAgIGRl
dl9lcnJfcHJvYmUoaG9zdC0+ZGV2LCByZXQsICJjb3VsZCBub3QgZ2V0IHZwMSANCj4gKyBjbGtc
biIpOw0KPiArDQo+ICsgICAgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woaG9zdC0+ZGV2LT5v
Zl9ub2RlLCAic3VwcG9ydHMtY3FlIikpDQo+ICsgICAgICAgICAgICAgcHJpdi0+aXNfY3FlID0g
MTsNCj4gKyAgICAgZWxzZQ0KPiArICAgICAgICAgICAgIHByaXYtPmlzX2NxZSA9IDA7DQo+ICsN
Cj4gKyAgICAgcHJvcCA9IG9mX2dldF9wcm9wZXJ0eShob3N0LT5kZXYtPm9mX25vZGUsICJyZHEt
Y3RybCIsICZzaXplKTsNCg0KTkFLDQoNCj4gKyAgICAgaWYgKHByb3ApDQo+ICsgICAgICAgICAg
ICAgcHJpdi0+cmRxX2N0cmwgPSBvZl9yZWFkX251bWJlcihwcm9wLCAxKTsNCj4gKyAgICAgZWxz
ZQ0KPiArICAgICAgICAgICAgIHByaXYtPnJkcV9jdHJsID0gMDsNCj4gKw0KPiArICAgICBwcml2
LT5lbW1jX21vZGUgPSAzOw0KPiArDQo+ICsgICAgIHByaXYtPm0ydG14ID0gDQo+ICsgc3lzY29u
X3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShob3N0LT5kZXYtPm9mX25vZGUsIA0KPiArICJyZWFs
dGVrLG0ydG14Iik7DQoNCk5BSywgZm9yIHRoZSBzYW1lIHJlYXNvbnMgSSBtZW50aW9uZWQgZm9y
IG90aGVyIHBhdGNoLg0KDQpJIHdpbGwga2VlcCBOQUstaW5nIHRpbGwgeW91IHN0YXJ0IHRlc3Rp
bmcgeW91ciBEVFMuDQoNCg0KPiArICAgICBpZiAoSVNfRVJSX09SX05VTEwocHJpdi0+bTJ0bXgp
KQ0KPiArICAgICAgICAgICAgIGRldl9lcnJfcHJvYmUoaG9zdC0+ZGV2LCByZXQsICJjYW4gbm90
IGdldCBtMm10eCANCj4gKyBub2RlLlxuIik7DQo+ICsNCj4gKyAgICAgaG9zdC0+cHJpdiA9IHBy
aXY7DQo+ICsNCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9DQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6
eXN6dG9mDQoNCg==
