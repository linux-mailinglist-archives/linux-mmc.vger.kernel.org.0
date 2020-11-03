Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C02A40CF
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Nov 2020 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgKCJzR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Nov 2020 04:55:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39308 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgKCJzQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:55:16 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39t7eiD015371, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39t7eiD015371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:55:07 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:55:06 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 6/8] misc: rtsx: Add CD & WP reverse support for RTS5261
Date:   Tue, 3 Nov 2020 17:55:05 +0800
Message-ID: <1604397305-2956-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch add CD & WP reverse support for RTS5261

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index ce65c5703453..0ef6b3e04a8d 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -510,6 +510,11 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	/* Configure driving */
 	rts5261_fill_driving(pcr, OUTPUT_3V3);
 
+	if (pcr->flags & PCR_REVERSE_SOCKET)
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x30);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
+
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
-- 
2.17.1

