Return-Path: <linux-mmc+bounces-6154-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE0A853E9
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Apr 2025 08:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647AD17EBF7
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Apr 2025 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A751C27C875;
	Fri, 11 Apr 2025 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NcXceHkd"
X-Original-To: linux-mmc@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAD1EE019;
	Fri, 11 Apr 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351731; cv=none; b=YLUYp4vqdeREzwaAVX09LPgM3bmdZEj5GZXQaD0gZXnIOEdmKNjOj2JfGPEjMwboYmd1XI8pvOczpp+4lHwOOV+NV/9uLRbolZEqBKbg/QJFKqWaI6keqsrbsfrMqTx+De7ehwUiOKyWaz3zgnEdk6wdX0AnRXqbpRrxpJ5MtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351731; c=relaxed/simple;
	bh=v4ikpYhTZh3eseTwcRtX2ERZ5hlAidT1UMVq7Q7rXHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hb0TImUGO4lerh80BaLKMNzTL2sSgvrdqakdn//ViiJ4x0lN0Okv1+NbpAcr/rHzeznaZU8C8PZ+fQVh1Dd7/mfKXYdjFIIjvbBV/vAGHS3ZxYusu2pC7CFNlcrPYUiMcPOPua8+abjMzcbAbcEnc3aN/Lcmd7TXZo+hEjtb5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NcXceHkd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53B68fEzA673835, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744351721; bh=v4ikpYhTZh3eseTwcRtX2ERZ5hlAidT1UMVq7Q7rXHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NcXceHkdMOxEhHBcSmC+U9Au0HCjnf65rtpbsU3SD3ZmFVqdkSicA6wx7Qljs81Gg
	 TcG8gVmTc46n5ZpU8/zbC9mmRpY76r0UqcnIY/mLG4geMiPvq2qiOL3h4jgMo64YCc
	 KXQb5u1vvIj4vFq9d1ElJJFAqZC+N+Z1LhI2JCS+vIqwcJtNwPwoFJqhUcSwdrUjX4
	 qV0zDHoxgf9xjM5u2parWqj71fNDjA6n60SaYQqVGOPPjLl+K7puaVtnPdfYJQdHM0
	 e0lAsVPlgGBpHPO71gbB7L/ZAJBVRTmN+aOGfJfGaD80WVMD7LoF9+xd6hr/9VwtUv
	 Y6ANc1EUK242A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53B68fEzA673835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:08:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Apr 2025 14:08:42 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Apr 2025 14:08:41 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Fri, 11 Apr 2025 14:08:41 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
Thread-Topic: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
Thread-Index: AQHborD2846vsF6F3E6a08GwR4gCjrOa1GaAgAFzDHCAACp8AIABkEDQ
Date: Fri, 11 Apr 2025 06:08:41 +0000
Message-ID: <8107c871dc294edab09736157079a3b4@realtek.com>
References: <20250401025123.895307-1-ricky_wu@realtek.com>
 <CAPDyKFpn5xB50eTomNM=4LbFDX4r154iY2Qk8GBiYb+vor0kbA@mail.gmail.com>
 <1fde0217fa544560888c3e6f4f5963f9@realtek.com>
 <CAPDyKFogPwixHGdmUy_z_udrUpU36mi_9cqdo1bPdM88OL1Erw@mail.gmail.com>
In-Reply-To: <CAPDyKFogPwixHGdmUy_z_udrUpU36mi_9cqdo1bPdM88OL1Erw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+DQo+ID4gPiA+DQo+ID4gPiA+IFNEIHNwZWMgZGVmaW5pdGlvbjoNCj4gPiA+ID4gIkhvc3Qg
cHJvdmlkZXMgYXQgbGVhc3QgNzQgQ2xvY2tzIGJlZm9yZSBpc3N1aW5nIGZpcnN0IGNvbW1hbmQi
DQo+ID4gPiA+IEFmdGVyIDFtcyBmb3IgdGhlIHZvbHRhZ2Ugc3RhYmxlIHRoZW4gc3RhcnQgaXNz
dWluZyB0aGUgQ2xvY2sNCj4gPiA+ID4gc2lnbmFscw0KPiA+ID4gPg0KPiA+ID4gPiBhZGQgaWYg
c3RhdGVtZW50IHRvIGlzc3VlL3N0b3AgdGhlIGNsb2NrIHNpZ25hbCB0byBjYXJkOg0KPiA+ID4g
PiBUaGUgcG93ZXIgc3RhdGUgZnJvbSBQT1dFUl9PRkYgdG8gUE9XRVJfVVAgaXNzdWUgdGhlIHNp
Z25hbCB0bw0KPiA+ID4gPiBjYXJkLCBQT1dFUl9VUCB0byBQT1dFUl9PTiBzdG9wIHRoZSBzaWdu
YWwNCj4gPiA+ID4NCj4gPiA+ID4gYWRkIDEwMG1zIGRlbGF5IGluIHBvd2VyX29uIHRvIG1ha2Ug
c3VyZSB0aGUgcG93ZXIgY3ljbGUgY29tcGxldGUNCj4gPiA+DQo+ID4gPiBXaHkgMTAwbXM/IFRo
YXQgc291bmRzIGEgbG90IHRvIG1lPw0KPiA+ID4NCj4gPiBIaSBVbGYsDQo+ID4NCj4gPiBUaGlz
IDEwMG1zIGRlbGF5IGlzIHRvIGVuc3VyZSB0aGUgdm9sdGFnZSBpcyBiZWxvdyAwLjVWIGJlZm9y
ZSBwb3dlcg0KPiA+IG9uIGR1cmluZyBhIHBvd2VyIGN5Y2xlLCBUaGUgZGVsYXlzIGluIHRoZSBt
bWMgY29yZSBpcyBub3Qgc3VmZmljaWVudCBmb3IgdGhlDQo+IHJ0c3ggdXNiIGRldmljZS4NCj4g
PiBCZWNhdXNlIGR1cmluZyB0aGUgY2FyZCByZWNvZ25pdGlvbiBwcm9jZXNzLCB0aGUgY2FyZCBw
b3dlciB3aWxsIGJlIHRvZ2dsZWQNCj4gb25jZSBpbiAxbXMuDQo+ID4gSWYgdGhlIGNhcmQgcG93
ZXIgaXMgbm90IGZ1bGx5IGRpc2NoYXJnZWQgd2l0aGluIHRoYXQgMW1zIGJlZm9yZSBiZWluZw0K
PiA+IHR1cm5lZCBvbiBhZ2FpbiwgSXQgbWF5IGFmZmVjdCB0aGUgY2FyZCByZWNvZ25pdGlvbg0K
PiANCj4gT2theSwgSSBzZWUuIFNvIDFtcyBpc24ndCBzdWZmaWNpZW50IGZvciB5b3VyIGNhc2Uu
DQo+IA0KPiBJcyB0aGVyZSBhIHJlZ3VsYXRvciBkZXNjcmliZWQgc29tZXdoZXJlPyBDb3VsZCB0
aGlzIGRlbGF5IGJlIHBhcnQgb2YgdGhlDQo+IHJlZ3VsYXRvciBlbmFibGUvZGlzYWJsZSBpbnN0
ZWFkPw0KPiANCj4gPg0KPiA+ID4gSXMgdGhpcyBmaXhpbmcgYSByZWFsIHByb2JsZW0gb3IgaXMg
anVzdCB0cnlpbmcgdG8gYmV0dGVyIGZvbGxvdyB0aGUgc3BlYz8NCj4gPiA+DQo+ID4NCj4gPiBX
ZSBmb3VuZCBzb21lIGNhcmRzIG5vdCBiZSByZWNvZ25pemVkIGlmIG5vdCBpc3N1ZSB0aGlzIDc0
IGNsb2Nrcw0KPiANCj4gVGhhdCBzdGlsbCBkb2Vzbid0IGV4cGxhaW4gd2h5IHlvdSBwaWNrZWQg
ZXhhY3RseSAxMDBtcyBhcyB0aGUgZGVsYXkuDQo+IEFzc3VtaW5nIHdlIGFyZSBydW5uaW5nIGF0
IGxvd2VzdCBpbml0aWFsaXphdGlvbiBmcmVxdWVuY3kgZm9yIFNEL2VNTUMgYXQNCj4gMTAwa0h6
LCB0aGVuIDc0IGNsb2NrcyBhcmU6DQo+IA0KPiA3NC8xMDAwMDAgPSAwLDAwMDc0cy4NCj4gDQoN
CkkgdGhpbmsgd2UgZ290IGEgbGl0dGxlIG1peGVkIHVwLi4uDQpJIHRoaW5rIEkgbmVlZCB0byBz
ZXBhcmF0ZSB0aGlzIHBhdGNoIGludG8gMiBwYXJ0DQoxKSBmb3IgNzQgY2xvY2tzIGlzc3VlIA0K
MikgYWRkIGRlbGF5IDEwMG1zIGJlZm9yZSBydHN4IHBvd2VyIG9uDQoNCkkgdGhpbmsgMSkgaXMg
bm8gcHJvYmxlbSBmb3IgeW91PyBJdCBpcyBmb3IgU0Qgc3BlYyBhbmQgc29tZSBjYXJkcyBjaGVj
ayB0aGlzLiANCjIpIGFkZCAxMDBtcyBiZWZvcmUgcG93ZXIgb24gaXQgaXMgdG8gbWFrZSBzdXJl
IHRoZSBsYXN0IHRpbWUgcG93ZXIgb2ZmIGRpZCB0aGUgZGlzY2hhcmdlIGNsZWFuLA0KQmVjYXVz
ZSBkdXJpbmcgdGhlIGNhcmQgcmVjb2duaXRpb24gcHJvY2VzcywgdGhlIGNhcmQgcG93ZXIgd2ls
bCBiZSB0b2dnbGVkIGluIDFtc++8jA0KYW5kIHdlIGZvdW5kIDFtcyBpcyBub3QgZW5vdWdoIGZv
ciBkaXNjaGFyZ2UNCg0KaWYgKDEpIGFuZCAoMikgYXJlIG9rIGZvciB5b3UgSSB3aWxsIHNlcGFy
YXRlIGl0IEluIFYyIDEvMiBhbmQgMi8yDQpvciB0d28gdW5yZWxhdGVkIHBhdGNoZXMgKDEpIGZv
ciA3NCBjbG9jayBpc3N1ZSwgKDIpIGZvciBtYWtlIHN1cmUgdGhlIHZvbHRhZ2UgaXMgYmVsb3cg
MC41ViBiZWZvcmUgcG93ZXIgb24NCndoaWNoIG9uZSB5b3UgdGhpbmsgaXMgZ29vZD8NCiANClJp
Y2t5DQoNCj4gDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgV3Ug
PHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvbW1j
L2hvc3QvcnRzeF91c2Jfc2RtbWMuYyB8IDI4DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qv
cnRzeF91c2Jfc2RtbWMuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF91c2Jfc2Rt
bWMuYw0KPiA+ID4gPiBpbmRleCBkMjI5YzJiODNlYTkuLmU1ODIwYjJiYjM4MCAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3VzYl9zZG1tYy5jDQo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF91c2Jfc2RtbWMuYw0KPiA+ID4gPiBAQCAtNDgsNyAr
NDgsNyBAQCBzdHJ1Y3QgcnRzeF91c2Jfc2RtbWMgew0KPiA+ID4gPiAgICAgICAgIGJvb2wgICAg
ICAgICAgICAgICAgICAgIGRkcl9tb2RlOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHVuc2ln
bmVkIGNoYXIgICAgICAgICAgIHBvd2VyX21vZGU7DQo+ID4gPiA+IC0NCj4gPiA+ID4gKyAgICAg
ICB1bnNpZ25lZCBjaGFyICAgICAgICAgICBwcmV2X3Bvd2VyX21vZGU7DQo+ID4gPiA+ICAjaWZk
ZWYgUlRTWF9VU0JfVVNFX0xFRFNfQ0xBU1MNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgbGVkX2Ns
YXNzZGV2ICAgICBsZWQ7DQo+ID4gPiA+ICAgICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAg
bGVkX25hbWVbMzJdOw0KPiA+ID4gPiBAQCAtOTUyLDYgKzk1Miw4IEBAIHN0YXRpYyBpbnQgc2Rf
cG93ZXJfb24oc3RydWN0IHJ0c3hfdXNiX3NkbW1jDQo+ID4gPiAqaG9zdCkNCj4gPiA+ID4gICAg
ICAgICBzdHJ1Y3QgcnRzeF91Y3IgKnVjciA9IGhvc3QtPnVjcjsNCj4gPiA+ID4gICAgICAgICBp
bnQgZXJyOw0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIG1zbGVlcCgxMDApOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICAgICAgICAgZGV2X2RiZyhzZG1tY19kZXYoaG9zdCksICIlc1xuIiwgX19mdW5j
X18pOw0KPiA+ID4gPiAgICAgICAgIHJ0c3hfdXNiX2luaXRfY21kKHVjcik7DQo+ID4gPiA+ICAg
ICAgICAgcnRzeF91c2JfYWRkX2NtZCh1Y3IsIFdSSVRFX1JFR19DTUQsIENBUkRfU0VMRUNULA0K
PiAweDA3LA0KPiA+ID4gPiBTRF9NT0RfU0VMKTsgQEAgLTEwMTQsNiArMTAxNiwxNiBAQCBzdGF0
aWMgaW50DQo+ID4gPiBzZF9zZXRfcG93ZXJfbW9kZShzdHJ1Y3QgcnRzeF91c2Jfc2RtbWMgKmhv
c3QsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBjaGFyIHBvd2VyX21vZGUpICB7
DQo+ID4gPiA+ICAgICAgICAgaW50IGVycjsNCj4gPiA+ID4gKyAgICAgICBpbnQgcG93ZXJfbW9k
ZV90ZW1wOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBydHN4X3VjciAqdWNyID0gaG9zdC0+dWNy
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcG93ZXJfbW9kZV90ZW1wID0gcG93ZXJfbW9k
ZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmICgocG93ZXJfbW9kZSA9PSBNTUNfUE9X
RVJfT04pICYmDQo+IChob3N0LT5wb3dlcl9tb2RlDQo+ID4gPiA9PSBNTUNfUE9XRVJfT04pICYm
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIChob3N0LT5wcmV2X3Bvd2VyX21vZGUg
PT0NCj4gPiA+IE1NQ19QT1dFUl9VUCkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGhvc3Qt
PnByZXZfcG93ZXJfbW9kZSA9IE1NQ19QT1dFUl9PTjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IHJ0c3hfdXNiX3dyaXRlX3JlZ2lzdGVyKHVjciwgU0RfQlVTX1NUQVQsDQo+ID4gPiBTRF9DTEtf
VE9HR0xFX0VOLCAweDAwKTsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAg
ICAgICAgaWYgKHBvd2VyX21vZGUgIT0gTU1DX1BPV0VSX09GRikNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgIHBvd2VyX21vZGUgPSBNTUNfUE9XRVJfT047IEBAIC0xMDI5LDkNCj4gPiA+ICsxMDQx
LDE4IEBADQo+ID4gPiA+IHN0YXRpYyBpbnQgc2Rfc2V0X3Bvd2VyX21vZGUoc3RydWN0IHJ0c3hf
dXNiX3NkbW1jICpob3N0LA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgZXJyID0gc2RfcG93ZXJf
b24oaG9zdCk7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtICAgICAgIGlm
ICghZXJyKQ0KPiA+ID4gPiAtICAgICAgICAgICAgICAgaG9zdC0+cG93ZXJfbW9kZSA9IHBvd2Vy
X21vZGU7DQo+ID4gPiA+ICsgICAgICAgaWYgKCFlcnIpIHsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGlmICgocG93ZXJfbW9kZV90ZW1wID09IE1NQ19QT1dFUl9VUCkgJiYNCj4gPiA+IChob3N0
LT5wb3dlcl9tb2RlID09IE1NQ19QT1dFUl9PRkYpKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGhvc3QtPnByZXZfcG93ZXJfbW9kZSA9DQo+IE1NQ19QT1dFUl9VUDsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcnRzeF91c2Jfd3JpdGVfcmVnaXN0ZXIodWNyLCBT
RF9CVVNfU1RBVCwNCj4gPiA+IFNEX0NMS19UT0dHTEVfRU4sDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTRF9DTEtfVE9HR0xFX0VOKTsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgaWYg
KChwb3dlcl9tb2RlX3RlbXAgPT0gTU1DX1BPV0VSX09GRikgJiYNCj4gPiA+IChob3N0LT5wb3dl
cl9tb2RlID09IE1NQ19QT1dFUl9PTikpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGhvc3QtPnByZXZfcG93ZXJfbW9kZSA9DQo+IE1NQ19QT1dFUl9PRkY7DQo+ID4gPiA+DQo+ID4g
PiA+ICsgICAgICAgICAgICAgICBob3N0LT5wb3dlcl9tb2RlID0gcG93ZXJfbW9kZTsNCj4gPiA+
ID4gKyAgICAgICB9DQo+ID4gPiA+ICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiA+ID4gIH0NCj4g
PiA+ID4NCj4gPiA+ID4gQEAgLTEzMTYsNiArMTMzNyw3IEBAIHN0YXRpYyB2b2lkIHJ0c3hfdXNi
X2luaXRfaG9zdChzdHJ1Y3QNCj4gPiA+IHJ0c3hfdXNiX3NkbW1jICpob3N0KQ0KPiA+ID4gPiAg
ICAgICAgIG1tYy0+bWF4X3JlcV9zaXplID0gNTI0Mjg4Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAg
ICAgIGhvc3QtPnBvd2VyX21vZGUgPSBNTUNfUE9XRVJfT0ZGOw0KPiA+ID4gPiArICAgICAgIGhv
c3QtPnByZXZfcG93ZXJfbW9kZSA9IE1NQ19QT1dFUl9PRkY7DQo+ID4gPiA+ICB9DQo+ID4gPiA+
DQo+ID4gPiA+ICBzdGF0aWMgaW50IHJ0c3hfdXNiX3NkbW1jX2Rydl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI1LjENCj4gPiA+ID4N
Cj4gPiA+DQo+ID4gPiBLaW5kIHJlZ2FyZHMNCj4gPiA+IFVmZmUNCg==

