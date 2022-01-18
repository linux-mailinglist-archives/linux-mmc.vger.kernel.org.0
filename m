Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DE49196E
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jan 2022 03:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiARCyG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jan 2022 21:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbiARCnX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jan 2022 21:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC63C08E875;
        Mon, 17 Jan 2022 18:37:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5763C612C6;
        Tue, 18 Jan 2022 02:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DCAC36AEF;
        Tue, 18 Jan 2022 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473439;
        bh=Ie4qdRRo3GQzYifj9cDxbYRfZvg5hjiq7dfpnsXoKsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMgi8F9MTsVpX1oPgomkhjJRyGz5/vnWlMraI48e/lPOv9ETdm8kBBXZAVpMeShqq
         AfSmLywiUSpUpqQ3YdwYSlQUJqfZaYLGIhihD6ejHKIwrfoN/jDKf7yAAymirLJvw1
         rfjQnCfMRdczXELn8UOTgQgRI+pQjdr0YdgLMGCZSA/OSH/cmyLxgE6Fdr0x0vNdFt
         9UPx5aOxXr62ox9cOORvK16pANM6y1IgzvSVG722k3tGN5LihK+E/xyORy6JZ6WKgd
         f3ZAZRvcvOfy5JeQSSaFJqoWtyo3UKIvwbh2RxYpeDor0nUZRjUsapIS4jN1GHHsme
         rX7uJeo9sCgjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sasha Levin <sashal@kernel.org>, linus.walleij@linaro.org,
        tiantao6@hisilicon.com, huyue2@yulong.com,
        linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 118/188] mmc: core: Fixup storing of OCR for MMC_QUIRK_NONSTD_SDIO
Date:   Mon, 17 Jan 2022 21:30:42 -0500
Message-Id: <20220118023152.1948105-118-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118023152.1948105-1-sashal@kernel.org>
References: <20220118023152.1948105-1-sashal@kernel.org>
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
index 68edf7a615be5..5447c47157aa5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -708,6 +708,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
 
+	card->ocr = ocr_card;
+
 	/*
 	 * If the host and card support UHS-I mode request the card
 	 * to switch to 1.8V signaling level.  No 1.8v signalling if
@@ -820,7 +822,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			goto mismatch;
 		}
 	}
-	card->ocr = ocr_card;
+
 	mmc_fixup_device(card, sdio_fixup_methods);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
-- 
2.34.1

