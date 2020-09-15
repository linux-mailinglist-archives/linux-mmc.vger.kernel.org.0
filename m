Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23A8269E4C
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Sep 2020 08:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIOGNp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Sep 2020 02:13:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61722 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726200AbgIOGN2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:13:28 -0400
X-UUID: 806472a4c76e46e883724a5e00965d51-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7qnmH6zd2m7IXntKt3yluwEtjEbUCrvblIFqr4JiihY=;
        b=sE2rMTYIF/ES3v13hQ4LVINuQIaOX8TmX/3/N4DJMb1fgsbikAM+4U7uHNNhAnnYAa2yLp4G4moXV6eJcG37BUCLkLEqlLROSNKypIL31U+UH+2MLsgKqfTm/X9DHnzlJTGRHq1xaSqpIaNt6MPcDS0v7OpD8OxdcPpKvTp+gcA=;
X-UUID: 806472a4c76e46e883724a5e00965d51-20200915
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 791850006; Tue, 15 Sep 2020 14:13:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:13:20 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:13:20 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [RESEND 2/3] arm64: dts: mt8192: add mmc device node
Date:   Tue, 15 Sep 2020 14:11:09 +0800
Message-ID: <20200915061110.25833-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200915061110.25833-1-wenbin.mei@mediatek.com>
References: <20200915061110.25833-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBtbWMgZGV2aWNlIG5vZGUgZm9yIG10ODE5Mg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLWV2Yi5kdHMgfCA4OSArKysrKysrKysrKysrKysr
KysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpICAgIHwgMzQg
KysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzIGIvYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTItZXZiLmR0cw0KaW5kZXggMDIwNTgzN2ZhNjk4
Li5hNDI3OWZhODdjMmIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5Mi1ldmIuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
Mi1ldmIuZHRzDQpAQCAtNSw2ICs1LDcgQEANCiAgKi8NCiAvZHRzLXYxLzsNCiAjaW5jbHVkZSAi
bXQ4MTkyLmR0c2kiDQorI2luY2x1ZGUgIm10NjM1OS5kdHNpIg0KIA0KIC8gew0KIAltb2RlbCA9
ICJNZWRpYVRlayBNVDgxOTIgZXZhbHVhdGlvbiBib2FyZCI7DQpAQCAtMjcsMyArMjgsOTEgQEAN
CiAmdWFydDAgew0KIAlzdGF0dXMgPSAib2theSI7DQogfTsNCisNCismbW1jMCB7DQorCXN0YXR1
cyA9ICJva2F5IjsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInN0YXRlX3VocyI7DQor
CXBpbmN0cmwtMCA9IDwmbW1jMF9waW5zX2RlZmF1bHQ+Ow0KKwlwaW5jdHJsLTEgPSA8Jm1tYzBf
cGluc191aHM+Ow0KKwlidXMtd2lkdGggPSA8OD47DQorCW1heC1mcmVxdWVuY3kgPSA8MjAwMDAw
MDAwPjsNCisJY2FwLW1tYy1oaWdoc3BlZWQ7DQorCW1tYy1oczIwMC0xXzh2Ow0KKwltbWMtaHM0
MDAtMV84djsNCisJc3VwcG9ydHMtY3FlOw0KKwljYXAtbW1jLWh3LXJlc2V0Ow0KKwluby1zZGlv
Ow0KKwluby1zZDsNCisJaHM0MDAtZHMtZGVsYXkgPSA8MHgxMjgxND47DQorCXZtbWMtc3VwcGx5
ID0gPCZtdDYzNTlfdmVtY18xX2xkb19yZWc+Ow0KKwl2cW1tYy1zdXBwbHkgPSA8Jm10NjM1OV92
dWZzX2xkb19yZWc+Ow0KKwlhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfTVNE
QzUwXzBfU0VMPjsNCisJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9wY2tnZW4gQ0xLX1RP
UF9NU0RDUExMPjsNCisJbm9uLXJlbW92YWJsZTsNCit9Ow0KKw0KKyZwaW8gew0KKwltbWMwX3Bp
bnNfZGVmYXVsdDogbW1jMGRlZmF1bHQgew0KKwkJcGluc19jbWRfZGF0IHsNCisJCQlwaW5tdXgg
PSA8UElOTVVYX0dQSU8xODRfX0ZVTkNfTVNEQzBfREFUMD4sDQorCQkJCSA8UElOTVVYX0dQSU8x
ODhfX0ZVTkNfTVNEQzBfREFUMT4sDQorCQkJCSA8UElOTVVYX0dQSU8xODVfX0ZVTkNfTVNEQzBf
REFUMj4sDQorCQkJCSA8UElOTVVYX0dQSU8xOTNfX0ZVTkNfTVNEQzBfREFUMz4sDQorCQkJCSA8
UElOTVVYX0dQSU8xODZfX0ZVTkNfTVNEQzBfREFUND4sDQorCQkJCSA8UElOTVVYX0dQSU8xODlf
X0ZVTkNfTVNEQzBfREFUNT4sDQorCQkJCSA8UElOTVVYX0dQSU8xODdfX0ZVTkNfTVNEQzBfREFU
Nj4sDQorCQkJCSA8UElOTVVYX0dQSU8xOTBfX0ZVTkNfTVNEQzBfREFUNz4sDQorCQkJCSA8UElO
TVVYX0dQSU8xODNfX0ZVTkNfTVNEQzBfQ01EPjsNCisJCQlpbnB1dC1lbmFibGU7DQorCQkJZHJp
dmUtc3RyZW50aCA9IDwzPjsNCisJCQltZWRpYXRlayxwdWxsLXVwLWFkdiA9IDwxPjsNCisJCX07
DQorDQorCQlwaW5zX2NsayB7DQorCQkJcGlubXV4ID0gPFBJTk1VWF9HUElPMTkyX19GVU5DX01T
REMwX0NMSz47DQorCQkJZHJpdmUtc3RyZW50aCA9IDwzPjsNCisJCQltZWRpYXRlayxwdWxsLWRv
d24tYWR2ID0gPDI+Ow0KKwkJfTsNCisNCisJCXBpbnNfcnN0IHsNCisJCQlwaW5tdXggPSA8UElO
TVVYX0dQSU8xOTRfX0ZVTkNfTVNEQzBfUlNUQj47DQorCQkJZHJpdmUtc3RyZW50aCA9IDwzPjsN
CisJCQltZWRpYXRlayxwdWxsLXVwLWFkdiA9IDwxPjsNCisJCX07DQorCX07DQorDQorCW1tYzBf
cGluc191aHM6IG1tYzBAMHsNCisJCXBpbnNfY21kX2RhdCB7DQorCQkJcGlubXV4ID0gPFBJTk1V
WF9HUElPMTg0X19GVU5DX01TREMwX0RBVDA+LA0KKwkJCQkgPFBJTk1VWF9HUElPMTg4X19GVU5D
X01TREMwX0RBVDE+LA0KKwkJCQkgPFBJTk1VWF9HUElPMTg1X19GVU5DX01TREMwX0RBVDI+LA0K
KwkJCQkgPFBJTk1VWF9HUElPMTkzX19GVU5DX01TREMwX0RBVDM+LA0KKwkJCQkgPFBJTk1VWF9H
UElPMTg2X19GVU5DX01TREMwX0RBVDQ+LA0KKwkJCQkgPFBJTk1VWF9HUElPMTg5X19GVU5DX01T
REMwX0RBVDU+LA0KKwkJCQkgPFBJTk1VWF9HUElPMTg3X19GVU5DX01TREMwX0RBVDY+LA0KKwkJ
CQkgPFBJTk1VWF9HUElPMTkwX19GVU5DX01TREMwX0RBVDc+LA0KKwkJCQkgPFBJTk1VWF9HUElP
MTgzX19GVU5DX01TREMwX0NNRD47DQorCQkJaW5wdXQtZW5hYmxlOw0KKwkJCWRyaXZlLXN0cmVu
dGggPSA8ND47DQorCQkJbWVkaWF0ZWsscHVsbC11cC1hZHYgPSA8MT47DQorCQl9Ow0KKw0KKwkJ
cGluc19jbGsgew0KKwkJCXBpbm11eCA9IDxQSU5NVVhfR1BJTzE5Ml9fRlVOQ19NU0RDMF9DTEs+
Ow0KKwkJCWRyaXZlLXN0cmVudGggPSA8ND47DQorCQkJbWVkaWF0ZWsscHVsbC1kb3duLWFkdiA9
IDwyPjsNCisJCX07DQorDQorCQlwaW5zX2RzIHsNCisJCQlwaW5tdXggPSA8UElOTVVYX0dQSU8x
OTFfX0ZVTkNfTVNEQzBfRFNMPjsNCisJCQlkcml2ZS1zdHJlbnRoID0gPDQ+Ow0KKwkJCW1lZGlh
dGVrLHB1bGwtZG93bi1hZHYgPSA8Mj47DQorCQl9Ow0KKw0KKwkJcGluc19yc3Qgew0KKwkJCXBp
bm11eCA9IDxQSU5NVVhfR1BJTzE5NF9fRlVOQ19NU0RDMF9SU1RCPjsNCisJCQlkcml2ZS1zdHJl
bnRoID0gPDM+Ow0KKwkJCW1lZGlhdGVrLHB1bGwtdXAtYWR2ID0gPDE+Ow0KKwkJfTsNCisJfTsN
Cit9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQppbmRleCBmYWVh
MGQ5N2MyYTkuLmRlM2QxMGMwZWVlZiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTkyLmR0c2kNCkBAIC03NjAsNiArNzYwLDQwIEBADQogCQkJI2Nsb2NrLWNlbGxzID0gPDE+
Ow0KIAkJfTsNCiANCisJCW1tYzA6IG1tY0AxMWY2MDAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTItbW1jIiwgIm1lZGlhdGVrLG10ODE4My1tbWMiOw0KKwkJCXJlZyA9IDww
IDB4MTFmNjAwMDAgMCAweDEwMDA+LA0KKwkJCSAgICAgIDwwIDB4MTFmNTAwMDAgMCAweDEwMDA+
Ow0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA5OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0K
KwkJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9NU0RDNTBfMF9TRUw+LA0KKwkJCQkgPCZt
c2RjX3RvcCBDTEtfTVNEQ19UT1BfSF9NU1RfMFA+LA0KKwkJCQkgPCZtc2RjX3RvcCBDTEtfTVNE
Q19UT1BfU1JDXzBQPiwNCisJCQkJIDwmbXNkY190b3AgQ0xLX01TRENfVE9QX1BfQ0ZHPiwNCisJ
CQkJIDwmbXNkY190b3AgQ0xLX01TRENfVE9QX1BfTVNEQzA+LA0KKwkJCQkgPCZtc2RjX3RvcCBD
TEtfTVNEQ19UT1BfQVhJPiwNCisJCQkJIDwmbXNkY190b3AgQ0xLX01TRENfVE9QX0FIQjJBWElf
QlJHX0FYST47DQorCQkJY2xvY2stbmFtZXMgPSAic291cmNlIiwgImhjbGsiLCAic291cmNlX2Nn
IiwgInN5c19jZyIsDQorCQkJCSAgICAgICJwY2xrX2NnIiwgImF4aV9jZyIsICJhaGJfY2ciOw0K
KwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0KKw0KKwkJbW1jMTogbW1jQDExZjcwMDAw
IHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1tbWMiLCAibWVkaWF0ZWssbXQ4
MTgzLW1tYyI7DQorCQkJcmVnID0gPDAgMHgxMWY3MDAwMCAwIDB4MTAwMD4sDQorCQkJICAgICAg
PDAgMHgxMWM3MDAwMCAwIDB4MTAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEwMyBJ
UlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KKwkJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9N
U0RDMzBfMV9TRUw+LA0KKwkJCQkgPCZtc2RjX3RvcCBDTEtfTVNEQ19UT1BfSF9NU1RfMVA+LA0K
KwkJCQkgPCZtc2RjX3RvcCBDTEtfTVNEQ19UT1BfU1JDXzFQPiwNCisJCQkJIDwmbXNkY190b3Ag
Q0xLX01TRENfVE9QX1BfQ0ZHPiwNCisJCQkJIDwmbXNkY190b3AgQ0xLX01TRENfVE9QX1BfTVNE
QzE+LA0KKwkJCQkgPCZtc2RjX3RvcCBDTEtfTVNEQ19UT1BfQVhJPiwNCisJCQkJIDwmbXNkY190
b3AgQ0xLX01TRENfVE9QX0FIQjJBWElfQlJHX0FYST47DQorCQkJY2xvY2stbmFtZXMgPSAic291
cmNlIiwgImhjbGsiLCAic291cmNlX2NnIiwgInN5c19jZyIsDQorCQkJCSAgICAgICJwY2xrX2Nn
IiwgImF4aV9jZyIsICJhaGJfY2ciOw0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQl9Ow0K
Kw0KIAkJbWZnY2ZnOiBzeXNjb25AMTNmYmYwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTkyLW1mZ2NmZyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTNmYmYwMDAgMCAw
eDEwMDA+Ow0KLS0gDQoyLjE4LjANCg==

