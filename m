Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DB19F29E
	for <lists+linux-mmc@lfdr.de>; Mon,  6 Apr 2020 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDFJ30 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 Apr 2020 05:29:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48061 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgDFJ30 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2020 05:29:26 -0400
X-UUID: 0d5769de15a140249192dae342ac48d9-20200406
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hsl3GJfHOubDs7v2Mnr4grCYwiLXJb28jC4OAsC2VDs=;
        b=VCgK8+T+CKSw9HWZVB+rjVb7nx0ypDHOJV5uRMNpdiuGY8bhwT1pZDJNkdQRyZdF49hZWD6Sf9F07fAdgSSyj0tVrIa2Ho+A8XBvqByUJHtfeBqkYgyHFRd+skH0C4xSnFB3qYOSAx+7/ZAk7Hr0/Q8XF5ck3T8n0RyUtRlUzI8=;
X-UUID: 0d5769de15a140249192dae342ac48d9-20200406
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 183599006; Mon, 06 Apr 2020 17:28:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Apr 2020 17:28:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Apr 2020 17:28:03 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     <mirq-linux@rere.qmqm.pl>, Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH 4/5] [4/5] mmc: mediatek: command queue support
Date:   Mon, 6 Apr 2020 17:28:00 +0800
Message-ID: <1586165281-11888-5-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586165281-11888-1-git-send-email-chun-hung.wu@mediatek.com>
References: <1586165281-11888-1-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9EDC88A9D882AF1E302692BE455AB7C9EB2BAE0811192905FAE38824E5F8FE282000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U3VwcG9ydCBjb21tYW5kIHF1ZXVlIGZvciBtdDY3NzkgcGxhdGZvcm0uDQphLiBBZGQgbXNkY19z
ZXRfYnVzeV90aW1lb3V0KCkgdG8gY2FsY3VsYXRlIGVtbWMgd3JpdGUgdGltZW91dA0KYi4gQ29u
bmVjdCBtdGsgbXNkYyBkcml2ZXIgdG8gY3FoY2kgZHJpdmVyIHRocm91Z2gNCiAgIGhvc3QtPmNx
X2hvc3QtPm9wcyA9ICZtc2RjX2NtZHFfb3BzOw0KYy4gbXNkY19jbWRxX2lycSgpIHdpbGwgbGlu
ayB1cCB3aXRoIGNxY2hpX2lycSgpLiBCZXNpZGVzLCBpdCBwcm92aWRlcw0KICAgbW9yZSBpcnEg
ZXJyb3IgbWVzc2FnZXMgbGlrZSBSU1BDUkNFUlIvQ01EVE8vREFUQUNSQ0VSUi9EQVRUTU8uDQpk
LiBVc2UgdGhlIG9wdGlvbnMgYmVsb3cgdG8gc2VwYXJhdGUgc3VwcG9ydCBmb3IgQ1FIQ0kgb3Ig
bm90LCBiZWNhdXNlDQogICBzb21lIG9mIG91ciBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IENR
SENJIGhlbmNlIG5vIGtlcm5lbCBvcHRpb246DQogICBDT05GSUdfTU1DX0NRSENJLg0KICAgI2lm
IElTX0VOQUJMRUQoQ09ORklHX01NQ19DUUhDSSkNCiAgIFhYWCAvL1N1cHBvcnQgQ1FIQ0kNCiAg
ICNlbHNlDQogICBYWFggLy9Ob3Qgc3VwcG9ydCBDUUhDSQ0KICAgI2VuZGlmDQoNClNpZ25lZC1v
ZmYtYnk6IENodW4tSHVuZyBXdSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCAxMTkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hv
c3QvbXRrLXNkLmMNCmluZGV4IGEyMzI4ZmIuLjg1MTY4ODggMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21tYy9ob3N0L210ay1zZC5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQpAQCAt
MzEsNiArMzEsOCBAQA0KICNpbmNsdWRlIDxsaW51eC9tbWMvc2Rpby5oPg0KICNpbmNsdWRlIDxs
aW51eC9tbWMvc2xvdC1ncGlvLmg+DQogDQorI2luY2x1ZGUgImNxaGNpLmgiDQorDQogI2RlZmlu
ZSBNQVhfQkRfTlVNICAgICAgICAgIDEwMjQNCiANCiAvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCkBA
IC0xNTEsNiArMTUzLDcgQEANCiAjZGVmaW5lIE1TRENfSU5UX0RNQV9CRENTRVJSICAgICgweDEg
PDwgMTcpCS8qIFcxQyAqLw0KICNkZWZpbmUgTVNEQ19JTlRfRE1BX0dQRENTRVJSICAgKDB4MSA8
PCAxOCkJLyogVzFDICovDQogI2RlZmluZSBNU0RDX0lOVF9ETUFfUFJPVEVDVCAgICAoMHgxIDw8
IDE5KQkvKiBXMUMgKi8NCisjZGVmaW5lIE1TRENfSU5UX0NNRFEgICAgICAgICAgICgweDEgPDwg
MjgpCS8qIFcxQyAqLw0KIA0KIC8qIE1TRENfSU5URU4gbWFzayAqLw0KICNkZWZpbmUgTVNEQ19J
TlRFTl9NTUNJUlEgICAgICAgKDB4MSA8PCAwKQkvKiBSVyAqLw0KQEAgLTE4MSw2ICsxODQsNyBA
QA0KIC8qIFNEQ19DRkcgbWFzayAqLw0KICNkZWZpbmUgU0RDX0NGR19TRElPSU5UV0tVUCAgICAg
KDB4MSA8PCAwKQkvKiBSVyAqLw0KICNkZWZpbmUgU0RDX0NGR19JTlNXS1VQICAgICAgICAgKDB4
MSA8PCAxKQkvKiBSVyAqLw0KKyNkZWZpbmUgU0RDX0NGR19XUkRUT0MgICAgICAgICAgKDB4MWZm
ZiAgPDwgMikgIC8qIFJXICovDQogI2RlZmluZSBTRENfQ0ZHX0JVU1dJRFRIICAgICAgICAoMHgz
IDw8IDE2KQkvKiBSVyAqLw0KICNkZWZpbmUgU0RDX0NGR19TRElPICAgICAgICAgICAgKDB4MSA8
PCAxOSkJLyogUlcgKi8NCiAjZGVmaW5lIFNEQ19DRkdfU0RJT0lERSAgICAgICAgICgweDEgPDwg
MjApCS8qIFJXICovDQpAQCAtMjI5LDYgKzIzMyw3IEBADQogI2RlZmluZSBNU0RDX1BBVENIX0JJ
VF9ERUNSQ1RNTyAgICgweDEgPDwgMzApCS8qIFJXICovDQogDQogI2RlZmluZSBNU0RDX1BBVENI
X0JJVDFfQ01EVEEgICAgICgweDcgPDwgMykgICAgLyogUlcgKi8NCisjZGVmaW5lIE1TRENfUEIx
X0JVU1lfQ0hFQ0tfU0VMICAgKDB4MSA8PCA3KSAgICAvKiBSVyAqLw0KICNkZWZpbmUgTVNEQ19Q
QVRDSF9CSVQxX1NUT1BfRExZICAoMHhmIDw8IDgpICAgIC8qIFJXICovDQogDQogI2RlZmluZSBN
U0RDX1BBVENIX0JJVDJfQ0ZHUkVTUCAgICgweDEgPDwgMTUpICAgLyogUlcgKi8NCkBAIC00MzIs
NiArNDM3LDcgQEAgc3RydWN0IG1zZGNfaG9zdCB7DQogCXN0cnVjdCBtc2RjX3NhdmVfcGFyYSBz
YXZlX3BhcmE7IC8qIHVzZWQgd2hlbiBnYXRlIEhDTEsgKi8NCiAJc3RydWN0IG1zZGNfdHVuZV9w
YXJhIGRlZl90dW5lX3BhcmE7IC8qIGRlZmF1bHQgdHVuZSBzZXR0aW5nICovDQogCXN0cnVjdCBt
c2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8qIHR1bmUgcmVzdWx0IG9mIENNRDIxL0NN
RDE5ICovDQorCXN0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0Ow0KIH07DQogDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfbW1jX2NvbXBhdGlibGUgbXQ4MTM1X2NvbXBhdCA9IHsNCkBAIC01Mjgs
NiArNTM0LDE4IEBAIHN0cnVjdCBtc2RjX2hvc3Qgew0KIAkudXNlX2ludGVybmFsX2NkID0gdHJ1
ZSwNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRpYmxlIG10Njc3
OV9jb21wYXQgPSB7DQorCS5jbGtfZGl2X2JpdHMgPSAxMiwNCisJLmhzNDAwX3R1bmUgPSBmYWxz
ZSwNCisJLnBhZF90dW5lX3JlZyA9IE1TRENfUEFEX1RVTkUwLA0KKwkuYXN5bmNfZmlmbyA9IHRy
dWUsDQorCS5kYXRhX3R1bmUgPSB0cnVlLA0KKwkuYnVzeV9jaGVjayA9IHRydWUsDQorCS5zdG9w
X2Nsa19maXggPSB0cnVlLA0KKwkuZW5oYW5jZV9yeCA9IHRydWUsDQorCS5zdXBwb3J0XzY0ZyA9
IHRydWUsDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtc2RjX29m
X2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODEzNS1tbWMiLCAuZGF0
YSA9ICZtdDgxMzVfY29tcGF0fSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMt
bW1jIiwgLmRhdGEgPSAmbXQ4MTczX2NvbXBhdH0sDQpAQCAtNTM3LDYgKzU1NSw3IEBAIHN0cnVj
dCBtc2RjX2hvc3Qgew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi1tbWMiLCAu
ZGF0YSA9ICZtdDc2MjJfY29tcGF0fSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDg1
MTYtbW1jIiwgLmRhdGEgPSAmbXQ4NTE2X2NvbXBhdH0sDQogCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ3NjIwLW1tYyIsIC5kYXRhID0gJm10NzYyMF9jb21wYXR9LA0KKwl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10Njc3OS1tbWMiLCAuZGF0YSA9ICZtdDY3NzlfY29tcGF0fSwNCiAJ
e30NCiB9Ow0KIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1zZGNfb2ZfaWRzKTsNCkBAIC03NDAs
NiArNzU5LDE1IEBAIHN0YXRpYyB2b2lkIG1zZGNfc2V0X3RpbWVvdXQoc3RydWN0IG1zZGNfaG9z
dCAqaG9zdCwgdTY0IG5zLCB1NjQgY2xrcykNCiAJCSAgICAgICh1MzIpKHRpbWVvdXQgPiAyNTUg
PyAyNTUgOiB0aW1lb3V0KSk7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG1zZGNfc2V0X2J1c3lfdGlt
ZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0KK3sNCisJdTY0
IHRpbWVvdXQ7DQorDQorCXRpbWVvdXQgPSBtc2RjX3RpbWVvdXRfY2FsKGhvc3QsIG5zLCBjbGtz
KTsNCisJc2RyX3NldF9maWVsZChob3N0LT5iYXNlICsgU0RDX0NGRywgU0RDX0NGR19XUkRUT0Ms
DQorCQkgICAgICAodTMyKSh0aW1lb3V0ID4gODE5MSA/IDgxOTEgOiB0aW1lb3V0KSk7DQorfQ0K
Kw0KIHN0YXRpYyB2b2lkIG1zZGNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0K
IHsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPnNyY19jbGtfY2cpOw0KQEAgLTE0MjYs
NiArMTQ1NCwzNiBAQCBzdGF0aWMgdm9pZCBtc2RjX2VuYWJsZV9zZGlvX2lycShzdHJ1Y3QgbW1j
X2hvc3QgKm1tYywgaW50IGVuYikNCiAJCXBtX3J1bnRpbWVfcHV0X25vaWRsZShob3N0LT5kZXYp
Ow0KIH0NCiANCisjaWYgSVNfRU5BQkxFRChDT05GSUdfTU1DX0NRSENJKQ0KK3N0YXRpYyBpcnFy
ZXR1cm5fdCBtc2RjX2NtZHFfaXJxKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHUzMiBpbnRzdHMp
DQorew0KKwlpbnQgY21kX2VyciA9IDAsIGRhdF9lcnIgPSAwOw0KKw0KKwlpZiAoaW50c3RzICYg
TVNEQ19JTlRfUlNQQ1JDRVJSKSB7DQorCQljbWRfZXJyID0gKHVuc2lnbmVkIGludCktRUlMU0VR
Ow0KKwkJZGV2X2Vycihob3N0LT5kZXYsICIlczogQ01EIENSQyBFUlIiLCBfX2Z1bmNfXyk7DQor
CX0gZWxzZSBpZiAoaW50c3RzICYgTVNEQ19JTlRfQ01EVE1PKSB7DQorCQljbWRfZXJyID0gKHVu
c2lnbmVkIGludCktRVRJTUVET1VUOw0KKwkJZGV2X2Vycihob3N0LT5kZXYsICIlczogQ01EIFRJ
TUVPVVQgRVJSIiwgX19mdW5jX18pOw0KKwl9DQorDQorCWlmIChpbnRzdHMgJiBNU0RDX0lOVF9E
QVRDUkNFUlIpIHsNCisJCWRhdF9lcnIgPSAodW5zaWduZWQgaW50KS1FSUxTRVE7DQorCQlkZXZf
ZXJyKGhvc3QtPmRldiwgIiVzOiBEQVRBIENSQyBFUlIiLCBfX2Z1bmNfXyk7DQorCX0gZWxzZSBp
ZiAoaW50c3RzICYgTVNEQ19JTlRfREFUVE1PKSB7DQorCQlkYXRfZXJyID0gKHVuc2lnbmVkIGlu
dCktRVRJTUVET1VUOw0KKwkJZGV2X2Vycihob3N0LT5kZXYsICIlczogREFUQSBUSU1FT1VUIEVS
UiIsIF9fZnVuY19fKTsNCisJfQ0KKw0KKwlpZiAoY21kX2VyciB8fCBkYXRfZXJyKSB7DQorCQlk
ZXZfZXJyKGhvc3QtPmRldiwgImNtZF9lcnIgPSAlZCwgZGF0X2VyciA9JWQsIGludHN0cyA9IDB4
JXgiLA0KKwkJCWNtZF9lcnIsIGRhdF9lcnIsIGludHN0cyk7DQorCX0NCisNCisJcmV0dXJuIGNx
aGNpX2lycShob3N0LT5tbWMsIDAsIGNtZF9lcnIsIGRhdF9lcnIpOw0KK30NCisjZW5kaWYNCisN
CiBzdGF0aWMgaXJxcmV0dXJuX3QgbXNkY19pcnEoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KIHsN
CiAJc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IChzdHJ1Y3QgbXNkY19ob3N0ICopIGRldl9pZDsN
CkBAIC0xNDYyLDYgKzE1MjAsMTYgQEAgc3RhdGljIGlycXJldHVybl90IG1zZGNfaXJxKGludCBp
cnEsIHZvaWQgKmRldl9pZCkNCiAJCWlmICghKGV2ZW50cyAmIChldmVudF9tYXNrICYgfk1TRENf
SU5UX1NESU9JUlEpKSkNCiAJCQlicmVhazsNCiANCisjaWYgSVNfRU5BQkxFRChDT05GSUdfTU1D
X0NRSENJKQ0KKwkJaWYgKChob3N0LT5tbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1FFKSAmJg0KKwkJ
ICAgIChldmVudHMgJiBNU0RDX0lOVF9DTURRKSkgew0KKwkJCW1zZGNfY21kcV9pcnEoaG9zdCwg
ZXZlbnRzKTsNCisJCQkvKiBjbGVhciBpbnRlcnJ1cHRzICovDQorCQkJd3JpdGVsKGV2ZW50cywg
aG9zdC0+YmFzZSArIE1TRENfSU5UKTsNCisJCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQorCQl9DQor
I2VuZGlmDQorDQogCQlpZiAoIW1ycSkgew0KIAkJCWRldl9lcnIoaG9zdC0+ZGV2LA0KIAkJCQki
JXM6IE1SUT1OVUxMOyBldmVudHM9JTA4WDsgZXZlbnRfbWFzaz0lMDhYXG4iLA0KQEAgLTIxNDYs
NiArMjIxNCwzNiBAQCBzdGF0aWMgaW50IG1zZGNfZ2V0X2NkKHN0cnVjdCBtbWNfaG9zdCAqbW1j
KQ0KIAkJcmV0dXJuICF2YWw7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShz
dHJ1Y3QgbW1jX2hvc3QgKm1tYykNCit7DQorCXN0cnVjdCBtc2RjX2hvc3QgKmhvc3QgPSBtbWNf
cHJpdihtbWMpOw0KKw0KKwkvKiBlbmFibGUgY21kcSBpcnEgKi8NCisJd3JpdGVsKE1TRENfSU5U
X0NNRFEsIGhvc3QtPmJhc2UgKyBNU0RDX0lOVEVOKTsNCisJLyogZW5hYmxlIGJ1c3kgY2hlY2sg
Ki8NCisJc2RyX3NldF9iaXRzKGhvc3QtPmJhc2UgKyBNU0RDX1BBVENIX0JJVDEsIE1TRENfUEIx
X0JVU1lfQ0hFQ0tfU0VMKTsNCisJLyogZGVmYXVsdCB3cml0ZSBkYXRhIC8gYnVzeSB0aW1lb3V0
IDIwcyAqLw0KKwltc2RjX3NldF9idXN5X3RpbWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAwMDAwVUxM
LCAwKTsNCisJLyogZGVmYXVsdCByZWFkIGRhdGEgdGltZW91dCAxcyAqLw0KKwltc2RjX3NldF90
aW1lb3V0KGhvc3QsIDEwMDAwMDAwMDBVTEwsIDApOw0KK30NCisNCit2b2lkIG1zZGNfY3FlX2Rp
c2FibGUoc3RydWN0IG1tY19ob3N0ICptbWMsIGJvb2wgcmVjb3ZlcnkpDQorew0KKwlzdHJ1Y3Qg
bXNkY19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCisNCisJLyogZGlzYWJsZSBjbWRxIGly
cSAqLw0KKwlzZHJfY2xyX2JpdHMoaG9zdC0+YmFzZSArIE1TRENfSU5URU4sIE1TRENfSU5UX0NN
RFEpOw0KKwkvKiBkaXNhYmxlIGJ1c3kgY2hlY2sgKi8NCisJc2RyX2Nscl9iaXRzKGhvc3QtPmJh
c2UgKyBNU0RDX1BBVENIX0JJVDEsIE1TRENfUEIxX0JVU1lfQ0hFQ0tfU0VMKTsNCisNCisJaWYg
KHJlY292ZXJ5KSB7DQorCQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBNU0RDX0RNQV9DVFJM
LA0KKwkJCSAgICAgIE1TRENfRE1BX0NUUkxfU1RPUCwgMSk7DQorCQltc2RjX3Jlc2V0X2h3KGhv
c3QpOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2hvc3Rfb3BzIG10X21z
ZGNfb3BzID0gew0KIAkucG9zdF9yZXEgPSBtc2RjX3Bvc3RfcmVxLA0KIAkucHJlX3JlcSA9IG1z
ZGNfcHJlX3JlcSwNCkBAIC0yMTYyLDYgKzIyNjAsMTEgQEAgc3RhdGljIGludCBtc2RjX2dldF9j
ZChzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCiAJLmh3X3Jlc2V0ID0gbXNkY19od19yZXNldCwNCiB9
Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY3FoY2lfaG9zdF9vcHMgbXNkY19jbWRxX29wcyA9
IHsNCisJLmVuYWJsZSAgICAgICAgID0gbXNkY19jcWVfZW5hYmxlLA0KKwkuZGlzYWJsZSAgICAg
ICAgPSBtc2RjX2NxZV9kaXNhYmxlLA0KK307DQorDQogc3RhdGljIHZvaWQgbXNkY19vZl9wcm9w
ZXJ0eV9wYXJzZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkJCQkgICBzdHJ1Y3Qg
bXNkY19ob3N0ICpob3N0KQ0KIHsNCkBAIC0yMzEyLDYgKzI0MTUsMjIgQEAgc3RhdGljIGludCBt
c2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJaG9zdC0+ZG1h
X21hc2sgPSBETUFfQklUX01BU0soMzIpOw0KIAltbWNfZGV2KG1tYyktPmRtYV9tYXNrID0gJmhv
c3QtPmRtYV9tYXNrOw0KIA0KKyNpZiBJU19FTkFCTEVEKENPTkZJR19NTUNfQ1FIQ0kpDQorCWlm
IChtbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1FFKSB7DQorCQlob3N0LT5jcV9ob3N0ID0gZGV2bV9r
emFsbG9jKGhvc3QtPm1tYy0+cGFyZW50LA0KKwkJCQkJICAgICBzaXplb2YoKmhvc3QtPmNxX2hv
c3QpLA0KKwkJCQkJICAgICBHRlBfS0VSTkVMKTsNCisJCWhvc3QtPmNxX2hvc3QtPmNhcHMgfD0g
Q1FIQ0lfVEFTS19ERVNDX1NaXzEyODsNCisJCWhvc3QtPmNxX2hvc3QtPm1taW8gPSBob3N0LT5i
YXNlICsgMHg4MDA7DQorCQlob3N0LT5jcV9ob3N0LT5vcHMgPSAmbXNkY19jbWRxX29wczsNCisJ
CWNxaGNpX2luaXQoaG9zdC0+Y3FfaG9zdCwgbW1jLCB0cnVlKTsNCisJCW1tYy0+bWF4X3NlZ3Mg
PSAxMjg7DQorCQkvKiBjcWhjaSAxNmJpdCBsZW5ndGggKi8NCisJCS8qIDAgc2l6ZSwgbWVhbnMg
NjU1MzYgc28gd2UgZG9uJ3QgaGF2ZSB0byAtMSBoZXJlICovDQorCQltbWMtPm1heF9zZWdfc2l6
ZSA9IDY0ICogMTAyNDsNCisJfQ0KKyNlbmRpZg0KKw0KIAlob3N0LT50aW1lb3V0X2Nsa3MgPSAz
ICogMTA0ODU3NjsNCiAJaG9zdC0+ZG1hLmdwZCA9IGRtYV9hbGxvY19jb2hlcmVudCgmcGRldi0+
ZGV2LA0KIAkJCQkyICogc2l6ZW9mKHN0cnVjdCBtdF9ncGRtYV9kZXNjKSwNCi0tIA0KMS45LjEN
Cg==

