Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F52427C3
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Aug 2020 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHLJib (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Aug 2020 05:38:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25765 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgHLJia (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 05:38:30 -0400
X-UUID: 6127cccfc2364e2cbf779ee07afcb872-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xVTG3i3NZ+1cOXWR7yCUvveG4pS/BEjPy1kRWzM1V+Y=;
        b=GaivWfKynI2L6k5ae8TAln6yDo2XrEp3QqwuBEjHpk+b1NrtuSHM0P7PksYOreCZoOKPX7HBpD4xYXfT84QgCB01U9h8t1aDZ4Zv+746WrRc9ZjCevyreIhxqj8dhiIxZT6pX6/WIz039YJSdL4TfOEAALwwjNkdSWGQIUtozZ4=;
X-UUID: 6127cccfc2364e2cbf779ee07afcb872-20200812
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 118660555; Wed, 12 Aug 2020 17:38:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:38:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:38:23 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 0/3] mmc: mediatek: add optional module reset property mmc: mediatek: add optional module reset property  arm64: dts: mt7622: add reset node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt |  2 ++ arch/arm64/boot/dts/mediatek/mt7622.dtsi         |  2 ++ drivers/mmc/host/mtk-sd.c                        | 13 +++++++++++++ 3 files changed, 17 insertions(+)
Date:   Wed, 12 Aug 2020 17:37:23 +0800
Message-ID: <20200812093726.10123-1-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

LS0NCjIuMTguMA0K

