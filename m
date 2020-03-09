Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF617EC84
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Mar 2020 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgCIXQO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Mar 2020 19:16:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3431 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgCIXQO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2020 19:16:14 -0400
X-UUID: b88d9c8491a345efbbbbfbe5a728094a-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lWnTG8Dlpfa7Gb5noWGxFDmhnIB+Ok5FYjYFtioW3kU=;
        b=RWgorQCF/272C9CgR2GlfgIBuVO/5SGQ2lGJ89WgacBbK14/p9zXDJ9VavUC0jG4pF8VMxQ7Q9nXoEd3vRb6csbw2r5pIkhcwPxgJSyNkWgYI/82JW5qcd9WHSXnOEMqC/x2pRm93Kc38EPx5/ZF6ifwEoSOdBV6fSsks3IjhNk=;
X-UUID: b88d9c8491a345efbbbbfbe5a728094a-20200310
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 754977298; Tue, 10 Mar 2020 07:16:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 07:14:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 07:13:24 +0800
Message-ID: <1583795768.23665.5.camel@mtkswgap22>
Subject: Re: [PATCH v3 4/4] dt-bindings: mmc: mediatek: Add document for
 mt6779
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
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
        Kuohong Wang <kuohong.wang@mediatek.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Mar 2020 07:16:08 +0800
In-Reply-To: <96e4df17-999e-2356-f203-4cef26a8d66d@gmail.com>
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
         <1581922564-24914-5-git-send-email-chun-hung.wu@mediatek.com>
         <20200219030225.GA14824@bogus>
         <96e4df17-999e-2356-f203-4cef26a8d66d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTIwIGF0IDIzOjA2ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTkvMDIvMjAyMCAwNDowMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gT24g
TW9uLCAxNyBGZWIgMjAyMCAxNDo1NjowNCArMDgwMCwgQ2h1bi1IdW5nIFd1IHdyb3RlOg0KPiA+
PiBBZGQgY29tcGF0aWJsZSBub2RlIGZvciBtdDY3NzkgbW1jDQo+ID4+DQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IENodW4tSHVuZyBXdSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPj4gLS0t
DQo+ID4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQg
fCAxICsNCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pg0KPiA+IA0K
PiA+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IA0KPiANCj4g
V2l0aCB0aGUgY29tbWl0IGZyb20gcGF0Y2ggMy80IHRoZSBjb21wYXRpYmxlIHNob3VsZCBiZToN
Cj4gIm1lZGlhdGVrLG10Njc3OS1tbWMiLCAibWVkaWF0ZWssbXQ4MTgzLW1tYyI6IGZvciBtbWMg
aG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ2Nzc5DQpBcyBJIGtub3cgbXQ4MTgzIGlzIG10Njc3
MSBwbGF0Zm9ybSBub3QgbXQ2Nzc5Lg0KbXQ2NzcxIGRvZXMgbm90IHN1cHBvcnQgQ1FIQ0kuDQo+
IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KDQo=

