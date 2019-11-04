Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5444FEDF48
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 12:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDLzA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 06:55:00 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:38005 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDLzA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 06:55:00 -0500
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 4 Nov 2019
 19:55:15 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     Nan Li <nan.li@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <linux-amlogic@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>
Subject: [PATCH v2] mmc: meson-gx: fix mmc dma operation
Date:   Mon, 4 Nov 2019 19:54:55 +0800
Message-ID: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Nan Li <nan.li@amlogic.com>

In MMC dma transfer, the region requested by dma_map_sg() may be released
by dma_unmap_sg() before the transfer is completed.

Put the unmap operation in front of mmc_request_done() to avoid this.

Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e712315..7667e8a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -173,6 +173,7 @@ struct meson_host {
 	int irq;
 
 	bool vqmmc_enabled;
+	bool needs_pre_post_req;
 };
 
 #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
@@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 	struct meson_host *host = mmc_priv(mmc);
 
 	host->cmd = NULL;
+	if (host->needs_pre_post_req)
+		meson_mmc_post_req(mmc, mrq, 0);
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	bool needs_pre_post_req = mrq->data &&
+
+	host->needs_pre_post_req = mrq->data &&
 			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
 
-	if (needs_pre_post_req) {
+	if (host->needs_pre_post_req) {
 		meson_mmc_get_transfer_mode(mmc, mrq);
 		if (!meson_mmc_desc_chain_mode(mrq->data))
-			needs_pre_post_req = false;
+			host->needs_pre_post_req = false;
 	}
 
-	if (needs_pre_post_req)
+	if (host->needs_pre_post_req)
 		meson_mmc_pre_req(mmc, mrq);
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
 	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
-
-	if (needs_pre_post_req)
-		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
-- 
2.7.4

