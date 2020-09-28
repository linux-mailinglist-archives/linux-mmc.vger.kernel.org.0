Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61CE27AEC7
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Sep 2020 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1NML (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Sep 2020 09:12:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42469 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726630AbgI1NMK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 09:12:10 -0400
X-UUID: 0407f2f2b0f143da82c7644447b26af0-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HAnA55pH2gnLs+1hkZyu5tVa5XboVMuVkFZwZIdK4vo=;
        b=fCvkD3jJOa2dxniqJzocCkOHJ4PkBknLrM2bCzptbmxv9FgA2NmdjsK1or441z6Ievja+CjUlX9t75OSGfMkZsfkFn48Z7QJFReSAglYc61QaE+22BBMQ220h9CG7T7iZRvg8etqx7e6Ju97lAwNuYmItnHFN4wz3lMNkuy2i5k=;
X-UUID: 0407f2f2b0f143da82c7644447b26af0-20200928
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1218535599; Mon, 28 Sep 2020 21:11:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Sep 2020 21:11:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 21:11:57 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 0/4] Add mmc support for MT8192 SoC
Date:   Mon, 28 Sep 2020 21:09:14 +0800
Message-ID: <20200928130918.32326-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2hhbmdlIGluIHYyOg0KQ29udmVydCBtdGstc2QgdG8ganNvbi1zY2hlbWENCg0KV2VuYmluIE1l
aSAoNCk6DQogIGR0LWJpbmRpbmdzOiBtbWM6IENvbnZlcnQgbXRrLXNkIHRvIGpzb24tc2NoZW1h
DQogIG1tYzogZHQtYmluZGluZ3M6IGFkZCBzdXBwb3J0IGZvciBNVDgxOTIgU29DDQogIGFybTY0
OiBkdHM6IG10ODE5MjogYWRkIG1tYyBkZXZpY2Ugbm9kZQ0KICBtbWM6IG1lZGlhdGVrOiBBZGQg
c3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIE1UODE5MiBtc2RjDQotLS0NClRoaXMgcGF0Y2ggZGVw
ZW5kcyBvbg0KW3Y0LDEvM10gYXJtNjQ6IGR0czogQWRkIE1lZGlhdGVrIFNvQyBNVDgxOTIgYW5k
IGV2YWx1YXRpb24gYm9hcmQgZHRzIGFuZCBNYWtlZmlsZQ0KW3YzLDEvOV0gZHQtYmluZGluZ3M6
IEFSTTogTWVkaWF0ZWs6IERvY3VtZW50IGJpbmRpbmdzIGZvciBNVDgxOTIgQlNQDQpbdjMsNi85
XSBjbGs6IG1lZGlhdGVrOiBBZGQgZHQtYmluZGluZ3MgZm9yIE1UODE5MiBjbG9ja3MNClt2Myw5
LzldIGNsazogbWVkaWF0ZWs6IEFkZCBNVDgxOTIgY2xvY2sgc3VwcG9ydA0KW3YzLDEvM10gZHQt
YmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIHBpbmN0cmwgZmlsZQ0KW3YzLDIvM10gZHQt
YmluZGluZ3M6IHBpbmN0cmw6IG10ODE5MjogYWRkIGJpbmRpbmcgZG9jdW1lbnQNClt2MywzLzNd
IHBpbmN0cmw6IGFkZCBwaW5jdHJsIGRyaXZlciBvbiBtdDgxOTINClt2MiwxLzRdIHNvYzogbWVk
aWF0ZWs6IHB3cmFwOiB1c2UgQklUKCkgbWFjcm8NClt2MiwyLzRdIHNvYzogbWVkaWF0ZWs6IHB3
cmFwOiBhZGQgYXJiaXRlciBjYXBhYmlsaXR5DQpbdjIsMy80XSBkdC1iaW5kaW5nczogbWVkaWF0
ZWs6IGFkZCBjb21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KW3YyLDQvNF0gc29jOiBt
ZWRpYXRlazogcHdyYXA6IGFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjg3My84MTkyIFNvQ3MNClsy
LzhdIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0aGUgTWVkaWFUZWsgTVQ2
MzU5IFBNSUMNClszLzhdIGR0LWJpbmRpbmdzOiByZWd1bGF0b3I6IEFkZCBkb2N1bWVudCBmb3Ig
TVQ2MzU5IHJlZ3VsYXRvcg0KWzQvOF0gbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVr
IE1UNjM1OSBQTUlDDQpbNS84XSByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBvcnQgZm9yIE1U
NjM1OSByZWd1bGF0b3INCls3LzhdIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBmb3Ig
TVQ2MzU5UCByZWd1bGF0b3INCls4LzhdIGFybTY0OiBkdHM6IG10NjM1OTogYWRkIFBNSUMgTVQ2
MzU5IHJlbGF0ZWQgbm9kZXMNCg0KUGxlYXNlIGFsc28gYWNjZXB0IHRoaXMgcGF0Y2ggdG9nZXRo
ZXIgd2l0aCBbMV1bMl1bM11bNF1bNV0NCnRvIGF2b2lkIGJ1aWxkIGFuZCBkdCBiaW5kaW5nIGNo
ZWNrIGVycm9yLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzMyNjIxDQpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zNDI1OTMNClszXSBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/
c2VyaWVzPTMzMDAxNw0KWzRdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzIyOTM3DQpbNV0gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0zMjMxNzENCi0t
LQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0ICAgICAgICB8ICA3NSAt
LS0tLS0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbCAgICAgICB8
IDE3NiArKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi1ldmIuZHRzICAgfCAgODkgKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxOTIuZHRzaSAgICAgIHwgIDM0ICsrKysNCiBkcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jICAgICAgICAgICAgICAgICAgICAgfCAgNzcgKysrKysrLS0NCiA1IGZpbGVzIGNoYW5nZWQs
IDM1OCBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QudHh0DQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNk
LnlhbWwNCg0KLS0NCjIuMTguMA0KDQo=

