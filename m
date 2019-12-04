Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFC11237A
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Dec 2019 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLDHUM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Dec 2019 02:20:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12645 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725958AbfLDHUL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 02:20:11 -0500
X-UUID: e75ae8e96c784b838a1fb6fd2ce691bf-20191204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=32Tnt40dZXjr4Tv/qzDO3kCW1vUpG7jJjRmXOdyYdQ8=;
        b=HWjCPuitjcfQB8ZPKlR8Td4sa7eb3gOkNUSgr1LjwBjcAfiMMmsTOtTMpVWNI8+e3Vtsm0KWwMpRw9wOMONdHW7NEyhPdlKNg//xNqwgx6tB0JdXXrJbznL5lb8MqgdDknKNXWQoaRcNdm75VAz/hgAeg8szzsBkBJEdRsYsQQU=;
X-UUID: e75ae8e96c784b838a1fb6fd2ce691bf-20191204
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2041926307; Wed, 04 Dec 2019 15:20:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Dec 2019 15:19:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Dec 2019 15:19:06 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <hsinyi@google.com>
Subject: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
Date:   Wed, 4 Dec 2019 15:19:58 +0800
Message-ID: <20191204071958.18553-1-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dGhlcmUgaXMgYSBjaGFuY2UgdGhhdCBhbHdheXMgZ2V0IHJlc3BvbnNlIENSQyBlcnJvciBhZnRl
ciBIUzIwMCB0dW5pbmcsDQp0aGUgcmVhc29uIGlzIHRoYXQgbmVlZCBzZXQgQ01EX1RBIHRvIDIu
IHRoaXMgbW9kaWZpY2F0aW9uIGlzIG9ubHkgZm9yDQpNVDgxNzMuDQoNClNpZ25lZC1vZmYtYnk6
IENoYW90aWFuIEppbmcgPGNoYW90aWFuLmppbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9t
bWMvaG9zdC9tdGstc2QuYw0KaW5kZXggMTg5ZTQyNjc0ZDg1Li4wMTBmZTI5YTQ4ODggMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0
L210ay1zZC5jDQpAQCAtMjI4LDYgKzIyOCw3IEBADQogI2RlZmluZSBNU0RDX1BBVENIX0JJVF9T
UENQVVNIICAgICgweDEgPDwgMjkpCS8qIFJXICovDQogI2RlZmluZSBNU0RDX1BBVENIX0JJVF9E
RUNSQ1RNTyAgICgweDEgPDwgMzApCS8qIFJXICovDQogDQorI2RlZmluZSBNU0RDX1BBVENIX0JJ
VDFfQ01EVEEgICAgICgweDcgPDwgMykgICAgLyogUlcgKi8NCiAjZGVmaW5lIE1TRENfUEFUQ0hf
QklUMV9TVE9QX0RMWSAgKDB4ZiA8PCA4KSAgICAvKiBSVyAqLw0KIA0KICNkZWZpbmUgTVNEQ19Q
QVRDSF9CSVQyX0NGR1JFU1AgICAoMHgxIDw8IDE1KSAgIC8qIFJXICovDQpAQCAtMTg4MSw2ICsx
ODgyLDcgQEAgc3RhdGljIGludCBoczQwMF90dW5lX3Jlc3BvbnNlKHN0cnVjdCBtbWNfaG9zdCAq
bW1jLCB1MzIgb3Bjb2RlKQ0KIA0KIAkvKiBzZWxlY3QgRU1NQzUwIFBBRCBDTUQgdHVuZSAqLw0K
IAlzZHJfc2V0X2JpdHMoaG9zdC0+YmFzZSArIFBBRF9DTURfVFVORSwgQklUKDApKTsNCisJc2Ry
X3NldF9maWVsZChob3N0LT5iYXNlICsgTVNEQ19QQVRDSF9CSVQxLCBNU0RDX1BBVENIX0JJVDFf
Q01EVEEsIDIpOw0KIA0KIAlpZiAobW1jLT5pb3MudGltaW5nID09IE1NQ19USU1JTkdfTU1DX0hT
MjAwIHx8DQogCSAgICBtbWMtPmlvcy50aW1pbmcgPT0gTU1DX1RJTUlOR19VSFNfU0RSMTA0KQ0K
LS0gDQoyLjE4LjANCg==

