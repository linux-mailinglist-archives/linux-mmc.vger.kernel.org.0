Return-Path: <linux-mmc+bounces-245-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3E7FB147
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Nov 2023 06:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67896B20FAC
	for <lists+linux-mmc@lfdr.de>; Tue, 28 Nov 2023 05:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D15101CE;
	Tue, 28 Nov 2023 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-mmc@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66DDE;
	Mon, 27 Nov 2023 21:33:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AS5WmWeA1823288, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AS5WmWeA1823288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 13:32:49 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Nov 2023 13:32:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Nov 2023 13:32:47 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f]) by
 RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f%5]) with mapi id
 15.01.2507.034; Tue, 28 Nov 2023 13:32:47 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        Ricky WU <ricky_wu@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com"
	<yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: [PATCH v5 0/3] Support new card reader rts5264
Thread-Topic: [PATCH v5 0/3] Support new card reader rts5264
Thread-Index: AQHaIbrekMPUQS8MCESu3/xB2PqzCQ==
Date: Tue, 28 Nov 2023 05:32:47 +0000
Message-ID: <d166d6a70c46419f8d2670e63f542ea1@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

U3VtbWFyeQ0KPT09PT09PQ0KVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IG5ldyBjYXJkIHJlYWRl
ciBydHM1MjY0DQpydHM1MjY0IGNhbiBzdXBwb3J0IHNkIGV4cHJlc3MgY2FyZCANCm5ldyBkZWZp
bml0aW9ucyBhbmQgZnVuY3Rpb25zIGRlZmluZSBpbiBuZXcgZmlsZSBydHM1MjY0LmggcnRzNTI2
NC5jDQoNClBhdGNoIHN0cnVjdHVyZQ0KPT09PT09PT09PT09PT09DQp2NC0+djU6DQphZGQgc3Vt
bWFyeSBmb3IgdGhpcyBzZXJpZXMNCg0KdjMtPnY0Og0Kc3BsaXQgbmV3IGRlZmluaXRpb24gcGFy
dCB1cCBmcm9tIHNhbWUgcGF0Y2ggDQoNCnYyLT52MzoNCnNwbGl0IG1pc2MgcGFydCBhbmQgbW1j
IHBhcnQNCg0KdjEtPnYyOg0KcmVtb3ZlIGljIHZlcnNpb24gY2hlY2sgZm9yIHJ0czUyNjQNCg0K
Umlja3kgV3UoMyk6DQogbWlzYzogcnRzeDogYWRkIHRvIHN1cHBvcnQgbmV3IGNhcmQgcmVhZGVy
IHJ0czUyNjQgbmV3DQogZGVmaW5pdGlvbiBhbmQgZnVuY3Rpb24NCiBtaXNjOiBydHN4OiBhZGQg
dG8gc3VwcG9ydCBuZXcgY2FyZCByZWFkZXIgcnRzNTI2NA0KIG1tYzogcnRzeDogYWRkIHJ0czUy
NjQgdG8gc3VwcG9ydCBzZCBleHByZXNzIGNhcmQNCg0KIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVy
L01ha2VmaWxlICAgfCAgIDIgKy0NCiBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmMg
IHwgODg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9taXNjL2NhcmRy
ZWFkZXIvcnRzNTI2NC5oICB8IDI3OCArKysrKysrKysNCiBkcml2ZXJzL21pc2MvY2FyZHJlYWRl
ci9ydHN4X3Bjci5jIHwgIDMwICstDQogZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzeF9wY3Iu
aCB8ICAgMSArDQogZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jICB8ICAxNyArLQ0K
IGluY2x1ZGUvbGludXgvcnRzeF9wY2kuaCAgICAgICAgICAgfCAgIDggKw0KIDcgZmlsZXMgY2hh
bmdlZCwgMTIxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2NC5oDQoNCg0KLS0gDQoyLjI1LjE=

