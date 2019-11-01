Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDEEBE0A
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Nov 2019 07:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfKAGnh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 1 Nov 2019 02:43:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55978 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbfKAGng (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Nov 2019 02:43:36 -0400
X-UUID: 4cbeed378d1743dfb3ed0ccfbb2398f3-20191101
X-UUID: 4cbeed378d1743dfb3ed0ccfbb2398f3-20191101
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1901611303; Fri, 01 Nov 2019 14:43:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 14:43:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 14:43:24 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH 1/3] [1/3] mmc: core: expose MMC_CAP2_CQE* to dt
Date:   Fri, 1 Nov 2019 14:43:00 +0800
Message-ID: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1790563609A4B527A36D226ACFB9CECC63DA74F3C4E3D57248FE8956863EA0C82000:8
X-MTK:  N
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Expose MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD
to host->caps2 if
1. "supports-cqe" is defined in dt and
2. "disable-cqe-dcmd" is not defined in dt.

Change-Id: I3d172e6bcfac34520c3932a6f8df2e20f2c0d05b
CR-Id:
Feature:
Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
---
 drivers/mmc/core/host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 105b7a7..efb0dbe 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -319,6 +319,14 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_SD;
 	if (device_property_read_bool(dev, "no-mmc"))
 		host->caps2 |= MMC_CAP2_NO_MMC;
+	if (device_property_read_bool(dev, "supports-cqe"))
+		host->caps2 |= MMC_CAP2_CQE;
+
+	/* Must be after "supports-cqe" check */
+	if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
+		if (host->caps2 & MMC_CAP2_CQE)
+			host->caps2 |= MMC_CAP2_CQE_DCMD;
+	}
 
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
-- 
1.9.1

