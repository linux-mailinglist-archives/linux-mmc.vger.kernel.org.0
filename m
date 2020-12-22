Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534482DDA99
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Dec 2020 22:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgLQVLF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Dec 2020 16:11:05 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:50955 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbgLQVLF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 16:11:05 -0500
Received: from localhost.localdomain ([93.22.133.164])
        by mwinf5d84 with ME
        id 5Z9K2400E3YyeAd03Z9Ln4; Thu, 17 Dec 2020 22:09:21 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 17 Dec 2020 22:09:21 +0100
X-ME-IP: 93.22.133.164
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jesper.nilsson@axis.com, lars.persson@axis.com,
        ulf.hansson@linaro.org, g.liakhovetski@gmx.de, chris@printf.net
Cc:     linux-arm-kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: usdhi6rol0: Fix a resource leak in the error handling path of the probe
Date:   Thu, 17 Dec 2020 22:09:22 +0100
Message-Id: <20201217210922.165340-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A call to 'ausdhi6_dma_release()' to undo a previous call to
'usdhi6_dma_request()' is missing in the error handling path of the probe
function.

It is already present in the remove function.

Fixes: 75fa9ea6e3c0 ("mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/usdhi6rol0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index e2d5112d809d..615f3d008af1 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1858,10 +1858,12 @@ static int usdhi6_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto e_clk_off;
+		goto e_release_dma;
 
 	return 0;
 
+e_release_dma:
+	usdhi6_dma_release(host);
 e_clk_off:
 	clk_disable_unprepare(host->clk);
 e_free_mmc:
-- 
2.27.0

