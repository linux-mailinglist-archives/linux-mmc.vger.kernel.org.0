Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187D95C259
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jul 2019 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfGARwu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jul 2019 13:52:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfGARwt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2019 13:52:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hi0Tu-00021l-Ub; Mon, 01 Jul 2019 17:52:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Drake <drake@endlessm.com>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: alcor: remove a redundant greater or equal to zero comparison
Date:   Mon,  1 Jul 2019 18:52:46 +0100
Message-Id: <20190701175246.32270-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A greater or equal comparison on the unsigned int variable tmp_diff
is always true as unsigned ints are never negative.  Hence the
comparison is redundant and can be removed.

Addresses-Coverity: ("Unsigned compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/alcor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index e481535cba2b..1aee485d56d4 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -672,7 +672,7 @@ static void alcor_set_clock(struct alcor_sdmmc_host *host, unsigned int clock)
 		tmp_clock = DIV_ROUND_UP(cfg->clk_src_freq, tmp_div);
 		tmp_diff = abs(clock - tmp_clock);
 
-		if (tmp_diff >= 0 && tmp_diff < diff) {
+		if (tmp_diff < diff) {
 			diff = tmp_diff;
 			clk_src = cfg->clk_src_reg;
 			clk_div = tmp_div;
-- 
2.20.1

