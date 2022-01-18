Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44138491972
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jan 2022 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiARCyI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jan 2022 21:54:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41988 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349866AbiARCug (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jan 2022 21:50:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D09460C41;
        Tue, 18 Jan 2022 02:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF5EC36AE3;
        Tue, 18 Jan 2022 02:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642474235;
        bh=kw73XIG6NLQUBFBdk9cnkGcu9RvWgb4ZUByxLPUXsyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5syCwjd5uA5EfQ7K4VivZe1l9rK4E0Fu9/b0XgtS5UNpGUT4sNAMbwYy6tlQuPLK
         NVs0j6DY++mKU2ZB5xy133ELEJloV5s2tuICaAF7D0wryeam/36XyZVsvg3BSO8t81
         sT6Tdoyrdp6Ax/+E62eLaPmINF+AQyMf02fS/AFRrZ4bBqFux0+zFu/veTFIcK5eam
         VN8doWKhd5zHrEXFFd0b4oM71EUIJ7PcKpCIbhx3GpAoYoagADui3yBwIJKbS3BPus
         TBalwcCLyIK6CSjiNNvn/Mk4TliTeY4w2lPDwDS2craU8CotGjhx9h8rm4tjG/+Frv
         b5Mex919GOopQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sasha Levin <sashal@kernel.org>, huyue2@yulong.com,
        tiantao6@hisilicon.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/56] mmc: core: Fixup storing of OCR for MMC_QUIRK_NONSTD_SDIO
Date:   Mon, 17 Jan 2022 21:48:47 -0500
Message-Id: <20220118024908.1953673-35-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118024908.1953673-1-sashal@kernel.org>
References: <20220118024908.1953673-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 8c3e5b74b9e2146f564905e50ca716591c76d4f1 ]

The mmc core takes a specific path to support initializing of a
non-standard SDIO card. This is triggered by looking for the card-quirk,
MMC_QUIRK_NONSTD_SDIO.

In mmc_sdio_init_card() this gets rather messy, as it causes the code to
bail out earlier, compared to the usual path. This leads to that the OCR
doesn't get saved properly in card->ocr. Fortunately, only omap_hsmmc has
been using the MMC_QUIRK_NONSTD_SDIO and is dealing with the issue, by
assigning a hardcoded value (0x80) to card->ocr from an ->init_card() ops.

To make the behaviour consistent, let's instead rely on the core to save
the OCR in card->ocr during initialization.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Link: https://lore.kernel.org/r/e7936cff7fc24d187ef2680d3b4edb0ade58f293.1636564631.git.hns@goldelico.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 7568cea559220..bf0a0ef60d6b4 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -631,6 +631,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
 
+	card->ocr = ocr_card;
+
 	/*
 	 * If the host and card support UHS-I mode request the card
 	 * to switch to 1.8V signaling level.  No 1.8v signalling if
@@ -737,7 +739,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 		card = oldcard;
 	}
-	card->ocr = ocr_card;
+
 	mmc_fixup_device(card, sdio_fixup_methods);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
-- 
2.34.1

