Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588EC35EF75
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Apr 2021 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349928AbhDNIXI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Apr 2021 04:23:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36819 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348780AbhDNIXE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 04:23:04 -0400
X-UUID: f3066ac312914c11921c352fd0bf4fd1-20210414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SR+2bsnHh4dFe1R8uWU6d+m3fg1wXapqvWwCeQj8FGo=;
        b=CYJlzhkckUtq/xfn9LjWXLJ3Mqk44YIhoGu+nVlQFANvIcr5y0cda9sunEjLBpCafVjBlF/C8+NBE3HSA261x34qsgEZMrdzQOpsz+6CU2GfBcexdjGIkHn7KrERY4hJn6ITDkhOzM42tnjdhAEvlrMcP3LMzqo1Km+Ris6MnoI=;
X-UUID: f3066ac312914c11921c352fd0bf4fd1-20210414
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 399149774; Wed, 14 Apr 2021 16:22:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 16:22:34 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 16:22:34 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>
Subject: [PATCH RESEND v3 0/3] MediaTek eMMC inline encryption support
Date:   Wed, 14 Apr 2021 16:09:49 +0800
Message-ID: <20210414080951.2800-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 33387F61301A372ED0E2D4B1DEA8B15ECC080FC4F0884911A8E52FE973394FBC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGVsbG8sDQoNCk1lZGlhdGVrIGVNTUMgaGFyZHdhcmUgSVAgaGFzIElubGluZSBDcnlwdG8gRW5n
aW5lIChJQ0UpLA0Kd2Ugc3VwcG9ydCBpbmxpbmUgZW5jcnlwdGlvbiBub3cuDQoNCkZvciBJbmxp
bmUgQ3J5cHRvIEVuZ2luZSAoSUNFKSwgc2VlOg0KLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hcm0tbXNtLw0KMjAyMTAxMjYwMDE0NTYuMzgyOTg5LTItZWJpZ2dlcnNAa2VybmVsLm9y
Zy9ULw0KDQpUaGlzIHBhdGNoc2V0IHN1cHBvcnRzIE1lZGlhdGVrIGVNTUMgaW5saW5lIGVuY3J5
cHRpb24gd2hpY2ggbWVldHMgdGhlDQp1cGNvbWluZyB2ZXJzaW9uIG9mIHRoZSBlTU1DIHNwZWNp
ZmljYXRpb24gc3VjaCBhcyB2NS4xIG9yIHY1LjIuDQoNClBhdGNoIDEtMiwgYWRkIGNyeXB0byBw
cm9wZXJ0eSBhbmQgY3J5cHRvIGNsb2NrLCBwYXRjaCAzLCBkb2N1bWVudCB0aGUNCmRldmljZSB0
cmVlIGRlc2NyaXB0aW9uIGFib3V0IGNyeXB0byBjbG9jay4NCg0KUGxlYXNlIG5vdGVkIHRoYXQg
dGhlcmUgaXMgYSBzcGVjaWFsIHdheSBvZiBvbi9vZmYgY3J5cHRvIGhhcmR3YXJlIElQDQppbiBv
dXIgU29DcywgdGhlIGVuYWJsZSBiaXQgbXVzdCBiZSBjb250cm9sbGVkIHVuZGVyIEFSTSBoaWdo
ZXN0DQpzZWN1cml0eSBsZXZlbCwgdGhhdCBtZWFucyBtdXN0IGluIEFSTSB0cnVzdGVkIGZpcm13
YXJlKEFURikuDQoNCkNoYW5nZWQgaW4gdjM6DQotIFJlbW92ZWQgIm1tYzogTWVkaWF0ZWs6IGVu
YWJsZSBjcnlwdG8gaGFyZHdhcmUgZW5naW5lIiBwYXRjaCB0ZW1wb3JhcmlseS4NCk5lZWRzIGZp
bmRpbmcgYSBiZXR0ZXIgd2F5IGZvciBlbmFibGUgY3J5cHRvIGhhcmR3YXJlIElQIHRocm91Z2gg
QVRGLCBzbw0KcmVtb3ZlICJtbWM6IE1lZGlhdGVrOiBlbmFibGUgY3J5cHRvIGhhcmR3YXJlIGVu
Z2luZSIgcGF0Y2ggdGVtcG9yYXJpbHksDQp3ZSBjb3VsZCBlbmFibGUgaXQgaW4gQVRGIGRpcmVj
dGx5IHdoZW4gYm9vdCB1cCB3aGljaCB3aWxsIGJlIGEgd29ya2Fyb3VuZA0Kc29sdXRpb24uIERp
c2N1c3NpbmcgYWJvdXQgdGhpcywgc2VlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1t
bWMvDQpZRSUyRm5mdTh2UkVUWU45ZE9AZ21haWwuY29tL1QvI3QNCi0gV2Ugd2lsbCBwdXQgdGhl
IGFib3ZlIG1lbnRpb25lZCBwYXRjaCBpbiBhIHNpbmdsZSBwYXRjaA0KDQoNClBlbmcgWmhvdSAo
Myk6DQogIG1tYzogTWVkaWF0ZWs6IGFkZCBJbmxpbmUgQ3J5cHRvIEVuZ2luZSBzdXBwb3J0DQog
IGFybTY0OiBkdHM6IE1lZGlhdGVrOiBNVDY3Nzk6IGFkZCBtbWMgbm9kZSB3aXRoIElDRSBzZXR0
aW5nDQogIGR0LWJpbmdkaW5nczogbW1jOiBNZWRpYXRlazogYWRkIElDRSBjbG9jaw0KDQogRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbCB8ICA2ICsrKyst
LQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgICAgICAgICAgfCAx
NCArKysrKysrKysrKysrKw0KIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDMyIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo=

