Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0982436D2
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Aug 2020 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMIoo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 13 Aug 2020 04:44:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgHMIoo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 04:44:44 -0400
X-UUID: 48f7b7df88504e19851c9459faa44a64-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xVTG3i3NZ+1cOXWR7yCUvveG4pS/BEjPy1kRWzM1V+Y=;
        b=gQgNOIKUV634mhXdI8ViLjtLHo6VxPvLTSOjjyZwAgvx3SKdff7EuszeWSEW7pIJMkJ29Wz/gcQJAIy8Zf9LHQuTXuWf3LSHSVY5DcRB62VOlaFAwQ14otMGSMbPGwxCQk7TMoYPN1Qt6B6vfHAZX/oXRarZoKer7UOHCLNFytQ=;
X-UUID: 48f7b7df88504e19851c9459faa44a64-20200813
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 369335559; Thu, 13 Aug 2020 16:44:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 16:44:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 16:44:37 +0800
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
Subject: [v3,0/3] mmc: mediatek: add optional reset property mmc: mediatek: add optional module reset property  arm64: dts: mt7622: add reset node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt |  2 ++ arch/arm64/boot/dts/mediatek/mt7622.dtsi         |  2 ++ drivers/mmc/host/mtk-sd.c                        | 13 +++++++++++++ 3 files changed, 17 insertions(+)
Date:   Thu, 13 Aug 2020 16:43:37 +0800
Message-ID: <20200813084340.27292-1-wenbin.mei@mediatek.com>
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

