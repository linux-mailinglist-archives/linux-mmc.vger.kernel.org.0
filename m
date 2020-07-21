Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670A32278ED
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jul 2020 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGUGjc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jul 2020 02:39:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6864 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgGUGjb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 02:39:31 -0400
X-UUID: 7539a72c29f64db58ccd12a237d138e0-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HDE+Nmz97xH0ltYCR/7mZosOzkYaRCE+XN7OpMwDbO0=;
        b=gYKVArj93R7G8LE9UDlFK7sMIUBPnFSglqS1QJbF11bXh9rcn92cNUrKNnSYJClCWvVCMewZcm/LDlrqExL8w5wVziD0jPrSxxreSVVY6CWIL/SoJadRPkDHCY4SvGeVKjs+rS164eZEp351hQ4jC4DiX7+dQZZCSFgzDFKj+fw=;
X-UUID: 7539a72c29f64db58ccd12a237d138e0-20200721
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1510372257; Tue, 21 Jul 2020 14:39:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 14:39:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 14:39:15 +0800
Message-ID: <1595313493.10458.1.camel@mhfsdcap03>
Subject: Re: [PATCH v7 3/4] mmc: mediatek: command queue support
From:   "yong.mao@mediatek.com" <yong.mao@mediatek.com>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
CC:     <mirq-linux@rere.qmqm.pl>, Jonathan Hunter <jonathanh@nvidia.com>,
        "Al Cooper" <alcooperx@gmail.com>,
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
        "Linus Walleij" <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <kernel-team@android.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 21 Jul 2020 14:38:13 +0800
In-Reply-To: <1595205759-5825-4-git-send-email-chun-hung.wu@mediatek.com>
References: <1595205759-5825-1-git-send-email-chun-hung.wu@mediatek.com>
         <1595205759-5825-4-git-send-email-chun-hung.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DA64DD8DC2FBB8E4BA786BAC7558BA6035E8F96A600D608D10CD9570EDFFAA072000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDA4OjQyICswODAwLCBDaHVuLUh1bmcgV3Ugd3JvdGU6DQo+
IFN1cHBvcnQgY29tbWFuZCBxdWV1ZSBmb3IgbXQ2Nzc5IHBsYXRmb3JtLg0KPiBhLiBBZGQgbXNk
Y19zZXRfYnVzeV90aW1lb3V0KCkgdG8gY2FsY3VsYXRlIGVtbWMgd3JpdGUgdGltZW91dC4NCj4g
Yi4gQ29ubmVjdCBtdGsgbXNkYyBkcml2ZXIgdG8gY3FoY2kgZHJpdmVyIHRocm91Z2gNCj4gICAg
aG9zdC0+Y3FfaG9zdC0+b3BzID0gJm1zZGNfY21kcV9vcHM7DQo+IGMuIG1zZGNfY21kcV9pcnEo
KSB3aWxsIGxpbmsgdXAgd2l0aCBjcWNoaV9pcnEoKS4gQmVzaWRlcywgaXQgcHJvdmlkZXMNCj4g
ICAgbW9yZSBpcnEgZXJyb3IgbWVzc2FnZXMgbGlrZSBSU1BDUkNFUlIvQ01EVE8vREFUQUNSQ0VS
Ui9EQVRUTU8uDQo+IGQuIFNlbGVjdCBrZXJuZWwgY29uZmlnIE1NQ19DUUhDSSBmb3IgTU1DX01U
Sw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1bi1IdW5nIFd1IDxjaHVuLWh1bmcud3VAbWVkaWF0
ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyAgfCAgIDEgKw0KPiAg
ZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25z
KCspDQo+IA0KDQpBY2tlZC1ieTogWW9uZyBNYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnIGIvZHJpdmVycy9tbWMvaG9z
dC9LY29uZmlnDQo+IGluZGV4IDNiNzA2YWYuLjljODlhNWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3QvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L0tjb25maWcNCj4g
QEAgLTEwMDksNiArMTAwOSw3IEBAIGNvbmZpZyBNTUNfTVRLDQo+ICAJdHJpc3RhdGUgIk1lZGlh
VGVrIFNEL01NQyBDYXJkIEludGVyZmFjZSBzdXBwb3J0Ig0KPiAgCWRlcGVuZHMgb24gSEFTX0RN
QQ0KPiAgCXNlbGVjdCBSRUdVTEFUT1INCj4gKwlzZWxlY3QgTU1DX0NRSENJDQo+ICAJaGVscA0K
PiAgCSAgVGhpcyBzZWxlY3RzIHRoZSBNZWRpYVRlayhSKSBTZWN1cmUgZGlnaXRhbCBhbmQgTXVs
dGltZWRpYSBjYXJkIEludGVyZmFjZS4NCj4gIAkgIElmIHlvdSBoYXZlIGEgbWFjaGluZSB3aXRo
IGEgaW50ZWdyYXRlZCBTRC9NTUMgY2FyZCByZWFkZXIsIHNheSBZIG9yIE0gaGVyZS4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jDQo+IGluZGV4IDM0N2VkNzIuLmU1NjBhMDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bW1jL2hvc3QvbXRrLXNkLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiBA
QCAtMzEsNiArMzEsOCBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L21tYy9zZGlvLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvbW1jL3Nsb3QtZ3Bpby5oPg0KPiAgDQo+ICsjaW5jbHVkZSAiY3FoY2kuaCIN
Cj4gKw0KPiAgI2RlZmluZSBNQVhfQkRfTlVNICAgICAgICAgIDEwMjQNCj4gIA0KPiAgLyotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSovDQo+IEBAIC0xNTIsNiArMTU0LDcgQEANCj4gICNkZWZpbmUgTVNEQ19J
TlRfRE1BX0JEQ1NFUlIgICAgKDB4MSA8PCAxNykJLyogVzFDICovDQo+ICAjZGVmaW5lIE1TRENf
SU5UX0RNQV9HUERDU0VSUiAgICgweDEgPDwgMTgpCS8qIFcxQyAqLw0KPiAgI2RlZmluZSBNU0RD
X0lOVF9ETUFfUFJPVEVDVCAgICAoMHgxIDw8IDE5KQkvKiBXMUMgKi8NCj4gKyNkZWZpbmUgTVNE
Q19JTlRfQ01EUSAgICAgICAgICAgKDB4MSA8PCAyOCkJLyogVzFDICovDQo+ICANCj4gIC8qIE1T
RENfSU5URU4gbWFzayAqLw0KPiAgI2RlZmluZSBNU0RDX0lOVEVOX01NQ0lSUSAgICAgICAoMHgx
IDw8IDApCS8qIFJXICovDQo+IEBAIC0xODIsNiArMTg1LDcgQEANCj4gIC8qIFNEQ19DRkcgbWFz
ayAqLw0KPiAgI2RlZmluZSBTRENfQ0ZHX1NESU9JTlRXS1VQICAgICAoMHgxIDw8IDApCS8qIFJX
ICovDQo+ICAjZGVmaW5lIFNEQ19DRkdfSU5TV0tVUCAgICAgICAgICgweDEgPDwgMSkJLyogUlcg
Ki8NCj4gKyNkZWZpbmUgU0RDX0NGR19XUkRUT0MgICAgICAgICAgKDB4MWZmZiAgPDwgMikgIC8q
IFJXICovDQo+ICAjZGVmaW5lIFNEQ19DRkdfQlVTV0lEVEggICAgICAgICgweDMgPDwgMTYpCS8q
IFJXICovDQo+ICAjZGVmaW5lIFNEQ19DRkdfU0RJTyAgICAgICAgICAgICgweDEgPDwgMTkpCS8q
IFJXICovDQo+ICAjZGVmaW5lIFNEQ19DRkdfU0RJT0lERSAgICAgICAgICgweDEgPDwgMjApCS8q
IFJXICovDQo+IEBAIC0yMzAsNiArMjM0LDcgQEANCj4gICNkZWZpbmUgTVNEQ19QQVRDSF9CSVRf
REVDUkNUTU8gICAoMHgxIDw8IDMwKQkvKiBSVyAqLw0KPiAgDQo+ICAjZGVmaW5lIE1TRENfUEFU
Q0hfQklUMV9DTURUQSAgICAgKDB4NyA8PCAzKSAgICAvKiBSVyAqLw0KPiArI2RlZmluZSBNU0RD
X1BCMV9CVVNZX0NIRUNLX1NFTCAgICgweDEgPDwgNykgICAgLyogUlcgKi8NCj4gICNkZWZpbmUg
TVNEQ19QQVRDSF9CSVQxX1NUT1BfRExZICAoMHhmIDw8IDgpICAgIC8qIFJXICovDQo+ICANCj4g
ICNkZWZpbmUgTVNEQ19QQVRDSF9CSVQyX0NGR1JFU1AgICAoMHgxIDw8IDE1KSAgIC8qIFJXICov
DQo+IEBAIC00MzEsOSArNDM2LDExIEBAIHN0cnVjdCBtc2RjX2hvc3Qgew0KPiAgCQkJCSAvKiBj
bWQgcmVzcG9uc2Ugc2FtcGxlIHNlbGVjdGlvbiBmb3IgSFM0MDAgKi8NCj4gIAlib29sIGhzNDAw
X21vZGU7CS8qIGN1cnJlbnQgZU1NQyB3aWxsIHJ1biBhdCBoczQwMCBtb2RlICovDQo+ICAJYm9v
bCBpbnRlcm5hbF9jZDsJLyogVXNlIGludGVybmFsIGNhcmQtZGV0ZWN0IGxvZ2ljICovDQo+ICsJ
Ym9vbCBjcWhjaTsJCS8qIHN1cHBvcnQgZU1NQyBodyBjbWRxICovDQo+ICAJc3RydWN0IG1zZGNf
c2F2ZV9wYXJhIHNhdmVfcGFyYTsgLyogdXNlZCB3aGVuIGdhdGUgSENMSyAqLw0KPiAgCXN0cnVj
dCBtc2RjX3R1bmVfcGFyYSBkZWZfdHVuZV9wYXJhOyAvKiBkZWZhdWx0IHR1bmUgc2V0dGluZyAq
Lw0KPiAgCXN0cnVjdCBtc2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8qIHR1bmUgcmVz
dWx0IG9mIENNRDIxL0NNRDE5ICovDQo+ICsJc3RydWN0IGNxaGNpX2hvc3QgKmNxX2hvc3Q7DQo+
ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZSBtdDgx
MzVfY29tcGF0ID0gew0KPiBAQCAtNzY0LDYgKzc3MSwxNSBAQCBzdGF0aWMgdm9pZCBtc2RjX3Nl
dF90aW1lb3V0KHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHU2NCBucywgdTY0IGNsa3MpDQo+ICAJ
CSAgICAgICh1MzIpKHRpbWVvdXQgPiAyNTUgPyAyNTUgOiB0aW1lb3V0KSk7DQo+ICB9DQo+ICAN
Cj4gK3N0YXRpYyB2b2lkIG1zZGNfc2V0X2J1c3lfdGltZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpo
b3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0KPiArew0KPiArCXU2NCB0aW1lb3V0Ow0KPiArDQo+ICsJ
dGltZW91dCA9IG1zZGNfdGltZW91dF9jYWwoaG9zdCwgbnMsIGNsa3MpOw0KPiArCXNkcl9zZXRf
ZmllbGQoaG9zdC0+YmFzZSArIFNEQ19DRkcsIFNEQ19DRkdfV1JEVE9DLA0KPiArCQkgICAgICAo
dTMyKSh0aW1lb3V0ID4gODE5MSA/IDgxOTEgOiB0aW1lb3V0KSk7DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyB2b2lkIG1zZGNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KPiAgew0K
PiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShob3N0LT5zcmNfY2xrX2NnKTsNCj4gQEAgLTE0ODEs
NiArMTQ5NywzNCBAQCBzdGF0aWMgdm9pZCBtc2RjX2VuYWJsZV9zZGlvX2lycShzdHJ1Y3QgbW1j
X2hvc3QgKm1tYywgaW50IGVuYikNCj4gIAkJcG1fcnVudGltZV9wdXRfbm9pZGxlKGhvc3QtPmRl
dik7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBtc2RjX2NtZHFfaXJxKHN0cnVj
dCBtc2RjX2hvc3QgKmhvc3QsIHUzMiBpbnRzdHMpDQo+ICt7DQo+ICsJaW50IGNtZF9lcnIgPSAw
LCBkYXRfZXJyID0gMDsNCj4gKw0KPiArCWlmIChpbnRzdHMgJiBNU0RDX0lOVF9SU1BDUkNFUlIp
IHsNCj4gKwkJY21kX2VyciA9IC1FSUxTRVE7DQo+ICsJCWRldl9lcnIoaG9zdC0+ZGV2LCAiJXM6
IENNRCBDUkMgRVJSIiwgX19mdW5jX18pOw0KPiArCX0gZWxzZSBpZiAoaW50c3RzICYgTVNEQ19J
TlRfQ01EVE1PKSB7DQo+ICsJCWNtZF9lcnIgPSAtRVRJTUVET1VUOw0KPiArCQlkZXZfZXJyKGhv
c3QtPmRldiwgIiVzOiBDTUQgVElNRU9VVCBFUlIiLCBfX2Z1bmNfXyk7DQo+ICsJfQ0KPiArDQo+
ICsJaWYgKGludHN0cyAmIE1TRENfSU5UX0RBVENSQ0VSUikgew0KPiArCQlkYXRfZXJyID0gLUVJ
TFNFUTsNCj4gKwkJZGV2X2Vycihob3N0LT5kZXYsICIlczogREFUQSBDUkMgRVJSIiwgX19mdW5j
X18pOw0KPiArCX0gZWxzZSBpZiAoaW50c3RzICYgTVNEQ19JTlRfREFUVE1PKSB7DQo+ICsJCWRh
dF9lcnIgPSAtRVRJTUVET1VUOw0KPiArCQlkZXZfZXJyKGhvc3QtPmRldiwgIiVzOiBEQVRBIFRJ
TUVPVVQgRVJSIiwgX19mdW5jX18pOw0KPiArCX0NCj4gKw0KPiArCWlmIChjbWRfZXJyIHx8IGRh
dF9lcnIpIHsNCj4gKwkJZGV2X2Vycihob3N0LT5kZXYsICJjbWRfZXJyID0gJWQsIGRhdF9lcnIg
PSVkLCBpbnRzdHMgPSAweCV4IiwNCj4gKwkJCWNtZF9lcnIsIGRhdF9lcnIsIGludHN0cyk7DQo+
ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGNxaGNpX2lycShob3N0LT5tbWMsIDAsIGNtZF9lcnIsIGRh
dF9lcnIpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaXJxcmV0dXJuX3QgbXNkY19pcnEoaW50IGly
cSwgdm9pZCAqZGV2X2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBtc2RjX2hvc3QgKmhvc3QgPSAoc3Ry
dWN0IG1zZGNfaG9zdCAqKSBkZXZfaWQ7DQo+IEBAIC0xNTE3LDYgKzE1NjEsMTQgQEAgc3RhdGlj
IGlycXJldHVybl90IG1zZGNfaXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gIAkJaWYgKCEo
ZXZlbnRzICYgKGV2ZW50X21hc2sgJiB+TVNEQ19JTlRfU0RJT0lSUSkpKQ0KPiAgCQkJYnJlYWs7
DQo+ICANCj4gKwkJaWYgKChob3N0LT5tbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1FFKSAmJg0KPiAr
CQkgICAgKGV2ZW50cyAmIE1TRENfSU5UX0NNRFEpKSB7DQo+ICsJCQltc2RjX2NtZHFfaXJxKGhv
c3QsIGV2ZW50cyk7DQo+ICsJCQkvKiBjbGVhciBpbnRlcnJ1cHRzICovDQo+ICsJCQl3cml0ZWwo
ZXZlbnRzLCBob3N0LT5iYXNlICsgTVNEQ19JTlQpOw0KPiArCQkJcmV0dXJuIElSUV9IQU5ETEVE
Ow0KPiArCQl9DQo+ICsNCj4gIAkJaWYgKCFtcnEpIHsNCj4gIAkJCWRldl9lcnIoaG9zdC0+ZGV2
LA0KPiAgCQkJCSIlczogTVJRPU5VTEw7IGV2ZW50cz0lMDhYOyBldmVudF9tYXNrPSUwOFhcbiIs
DQo+IEBAIC0yMjAxLDYgKzIyNTMsMzYgQEAgc3RhdGljIGludCBtc2RjX2dldF9jZChzdHJ1Y3Qg
bW1jX2hvc3QgKm1tYykNCj4gIAkJcmV0dXJuICF2YWw7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2
b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4gK3sNCj4gKwlzdHJ1
Y3QgbXNkY19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gKw0KPiArCS8qIGVuYWJsZSBj
bWRxIGlycSAqLw0KPiArCXdyaXRlbChNU0RDX0lOVF9DTURRLCBob3N0LT5iYXNlICsgTVNEQ19J
TlRFTik7DQo+ICsJLyogZW5hYmxlIGJ1c3kgY2hlY2sgKi8NCj4gKwlzZHJfc2V0X2JpdHMoaG9z
dC0+YmFzZSArIE1TRENfUEFUQ0hfQklUMSwgTVNEQ19QQjFfQlVTWV9DSEVDS19TRUwpOw0KPiAr
CS8qIGRlZmF1bHQgd3JpdGUgZGF0YSAvIGJ1c3kgdGltZW91dCAyMHMgKi8NCj4gKwltc2RjX3Nl
dF9idXN5X3RpbWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gKwkvKiBkZWZh
dWx0IHJlYWQgZGF0YSB0aW1lb3V0IDFzICovDQo+ICsJbXNkY19zZXRfdGltZW91dChob3N0LCAx
MDAwMDAwMDAwVUxMLCAwKTsNCj4gK30NCj4gKw0KPiArdm9pZCBtc2RjX2NxZV9kaXNhYmxlKHN0
cnVjdCBtbWNfaG9zdCAqbW1jLCBib29sIHJlY292ZXJ5KQ0KPiArew0KPiArCXN0cnVjdCBtc2Rj
X2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiArDQo+ICsJLyogZGlzYWJsZSBjbWRxIGly
cSAqLw0KPiArCXNkcl9jbHJfYml0cyhob3N0LT5iYXNlICsgTVNEQ19JTlRFTiwgTVNEQ19JTlRf
Q01EUSk7DQo+ICsJLyogZGlzYWJsZSBidXN5IGNoZWNrICovDQo+ICsJc2RyX2Nscl9iaXRzKGhv
c3QtPmJhc2UgKyBNU0RDX1BBVENIX0JJVDEsIE1TRENfUEIxX0JVU1lfQ0hFQ0tfU0VMKTsNCj4g
Kw0KPiArCWlmIChyZWNvdmVyeSkgew0KPiArCQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBN
U0RDX0RNQV9DVFJMLA0KPiArCQkJICAgICAgTVNEQ19ETUFfQ1RSTF9TVE9QLCAxKTsNCj4gKwkJ
bXNkY19yZXNldF9odyhob3N0KTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbW1jX2hvc3Rfb3BzIG10X21zZGNfb3BzID0gew0KPiAgCS5wb3N0X3JlcSA9IG1zZGNf
cG9zdF9yZXEsDQo+ICAJLnByZV9yZXEgPSBtc2RjX3ByZV9yZXEsDQo+IEBAIC0yMjE3LDYgKzIy
OTksMTEgQEAgc3RhdGljIGludCBtc2RjX2dldF9jZChzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4g
IAkuaHdfcmVzZXQgPSBtc2RjX2h3X3Jlc2V0LA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBjcWhjaV9ob3N0X29wcyBtc2RjX2NtZHFfb3BzID0gew0KPiArCS5lbmFibGUgICAg
ICAgICA9IG1zZGNfY3FlX2VuYWJsZSwNCj4gKwkuZGlzYWJsZSAgICAgICAgPSBtc2RjX2NxZV9k
aXNhYmxlLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIHZvaWQgbXNkY19vZl9wcm9wZXJ0eV9wYXJz
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgCQkJCSAgIHN0cnVjdCBtc2RjX2hv
c3QgKmhvc3QpDQo+ICB7DQo+IEBAIC0yMjM3LDYgKzIzMjQsMTIgQEAgc3RhdGljIHZvaWQgbXNk
Y19vZl9wcm9wZXJ0eV9wYXJzZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgCQlo
b3N0LT5oczQwMF9jbWRfcmVzcF9zZWxfcmlzaW5nID0gdHJ1ZTsNCj4gIAllbHNlDQo+ICAJCWhv
c3QtPmhzNDAwX2NtZF9yZXNwX3NlbF9yaXNpbmcgPSBmYWxzZTsNCj4gKw0KPiArCWlmIChvZl9w
cm9wZXJ0eV9yZWFkX2Jvb2wocGRldi0+ZGV2Lm9mX25vZGUsDQo+ICsJCQkJICAic3VwcG9ydHMt
Y3FlIikpDQo+ICsJCWhvc3QtPmNxaGNpID0gdHJ1ZTsNCj4gKwllbHNlDQo+ICsJCWhvc3QtPmNx
aGNpID0gZmFsc2U7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gQEAgLTIzNTIsNiArMjQ0NSw4IEBAIHN0YXRp
YyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJ
bW1jLT5jYXBzMiB8PSBNTUNfQ0FQMl9TRElPX0lSUV9OT1RIUkVBRDsNCj4gIA0KPiAgCW1tYy0+
Y2FwcyB8PSBNTUNfQ0FQX0NNRDIzOw0KPiArCWlmIChob3N0LT5jcWhjaSkNCj4gKwkJbW1jLT5j
YXBzMiB8PSBNTUNfQ0FQMl9DUUUgfCBNTUNfQ0FQMl9DUUVfRENNRDsNCj4gIAkvKiBNTUMgY29y
ZSB0cmFuc2ZlciBzaXplcyB0dW5hYmxlIHBhcmFtZXRlcnMgKi8NCj4gIAltbWMtPm1heF9zZWdz
ID0gTUFYX0JEX05VTTsNCj4gIAlpZiAoaG9zdC0+ZGV2X2NvbXAtPnN1cHBvcnRfNjRnKQ0KPiBA
QCAtMjM2Nyw2ICsyNDYyLDI2IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJaG9zdC0+ZG1hX21hc2sgPSBETUFfQklUX01BU0so
MzIpOw0KPiAgCW1tY19kZXYobW1jKS0+ZG1hX21hc2sgPSAmaG9zdC0+ZG1hX21hc2s7DQo+ICAN
Cj4gKwlpZiAobW1jLT5jYXBzMiAmIE1NQ19DQVAyX0NRRSkgew0KPiArCQlob3N0LT5jcV9ob3N0
ID0gZGV2bV9remFsbG9jKGhvc3QtPm1tYy0+cGFyZW50LA0KPiArCQkJCQkgICAgIHNpemVvZigq
aG9zdC0+Y3FfaG9zdCksDQo+ICsJCQkJCSAgICAgR0ZQX0tFUk5FTCk7DQo+ICsJCWlmICghaG9z
dC0+Y3FfaG9zdCkgew0KPiArCQkJcmV0ID0gLUVOT01FTTsNCj4gKwkJCWdvdG8gaG9zdF9mcmVl
Ow0KPiArCQl9DQo+ICsJCWhvc3QtPmNxX2hvc3QtPmNhcHMgfD0gQ1FIQ0lfVEFTS19ERVNDX1Na
XzEyODsNCj4gKwkJaG9zdC0+Y3FfaG9zdC0+bW1pbyA9IGhvc3QtPmJhc2UgKyAweDgwMDsNCj4g
KwkJaG9zdC0+Y3FfaG9zdC0+b3BzID0gJm1zZGNfY21kcV9vcHM7DQo+ICsJCXJldCA9IGNxaGNp
X2luaXQoaG9zdC0+Y3FfaG9zdCwgbW1jLCB0cnVlKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdv
dG8gaG9zdF9mcmVlOw0KPiArCQltbWMtPm1heF9zZWdzID0gMTI4Ow0KPiArCQkvKiBjcWhjaSAx
NmJpdCBsZW5ndGggKi8NCj4gKwkJLyogMCBzaXplLCBtZWFucyA2NTUzNiBzbyB3ZSBkb24ndCBo
YXZlIHRvIC0xIGhlcmUgKi8NCj4gKwkJbW1jLT5tYXhfc2VnX3NpemUgPSA2NCAqIDEwMjQ7DQo+
ICsJfQ0KPiArDQo+ICAJaG9zdC0+dGltZW91dF9jbGtzID0gMyAqIDEwNDg1NzY7DQo+ICAJaG9z
dC0+ZG1hLmdwZCA9IGRtYV9hbGxvY19jb2hlcmVudCgmcGRldi0+ZGV2LA0KPiAgCQkJCTIgKiBz
aXplb2Yoc3RydWN0IG10X2dwZG1hX2Rlc2MpLA0KDQo=

