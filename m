Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE998B89
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfHVGrw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 02:47:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36606 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730847AbfHVGrw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 02:47:52 -0400
X-UUID: d10dbf6d7c35481eab53d1268eb088cf-20190822
X-UUID: d10dbf6d7c35481eab53d1268eb088cf-20190822
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1283895172; Thu, 22 Aug 2019 14:47:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 14:47:42 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 14:47:42 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 1/2] mmc: mediatek: fix controller busy when plug out SD
Date:   Thu, 22 Aug 2019 14:47:40 +0800
Message-ID: <20190822064741.11196-2-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

when plug out SD card, may get data CRC error, the MMC core will issue
CMD13 to get card status, then CMD13 timeout(due to card plug out) will
trigger CMD19 tuning, first CMD19 timeout has not call msdc_reset_hw()
and cause the next CMD19 gets controller busy.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b6387ef7..5cc422e5db69 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1071,11 +1071,13 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	}
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
-		if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-		    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+		if (events & MSDC_INT_CMDTMO ||
+		    (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200))
 			/*
 			 * should not clear fifo/interrupt as the tune data
-			 * may have alreay come.
+			 * may have alreay come when cmd19/cmd21 gets response
+			 * CRC error.
 			 */
 			msdc_reset_hw(host);
 		if (events & MSDC_INT_RSPCRCERR) {
-- 
2.18.0

