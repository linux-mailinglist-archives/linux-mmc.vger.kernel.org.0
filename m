Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1D32B128
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Mar 2021 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbhCCBri (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 2 Mar 2021 20:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349127AbhCBM3J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 07:29:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9895864FC5;
        Tue,  2 Mar 2021 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686365;
        bh=XQ2zSEW/W21CTzIhc5QdKoiwCXhCc8zccWUX161ff7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEuPY4//gDCoR/92+fpkQmYSrDO2VOvPULLx/BFhG+cnFYK1yAAB7/nF88b6t0Jb2
         GSzXb2IwyVjF5/fbKbYElcst1C7wMKCqGDWFAui7sLKrpte7bFLq+tXaKzSTH7R6cN
         G/mkqj9UW5vflYF0SCJw37EXN0j152uebOm/j1QWGDbEgPQemOTVePmLCrpDoqcDSd
         5OQp/cEZMcf3f9DZ20MCO2QwpX2M/QmwQcH+BYyVjReqgthqEvRehkeIRotGhpVSUz
         /IKyEVAQM5B1K+yIHpLlRErDw4u6eZxH5Rj9/zy9o2uQK02wZFxWlO5AEg1hShMr6D
         sWn/3gVm/0V7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/10] mmc: mxs-mmc: Fix a resource leak in an error handling path in 'mxs_mmc_probe()'
Date:   Tue,  2 Mar 2021 06:59:13 -0500
Message-Id: <20210302115921.63636-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115921.63636-1-sashal@kernel.org>
References: <20210302115921.63636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 0bb7e560f821c7770973a94e346654c4bdccd42c ]

If 'mmc_of_parse()' fails, we must undo the previous 'dma_request_chan()'
call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20201208203527.49262-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mxs-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index c8b8ac66ff7e..687fd68fbbcd 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -651,7 +651,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out_clk_disable;
+		goto out_free_dma;
 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-- 
2.30.1

