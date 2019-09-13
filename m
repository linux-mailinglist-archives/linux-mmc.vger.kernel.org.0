Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309F8B1AF3
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 11:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbfIMJlB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 05:41:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35918 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbfIMJlB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 05:41:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id x80so21654204lff.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cnHaKGcMzTZrMV9+DycpQtbjSI9gqCpzF+WM5KDAOYI=;
        b=mdidwElC8ipcbQxW/mPtNfu0vZY4TgHVrd3CNdL05yVYt9Lu77V+SZgbcEh87oEj7t
         gkLldHdYEKEK06Fc+cZqP2I5MK7PrKHFf900QCERYDJNbKvModF4UfEzyA9/RkDX0WaI
         SJHrbh0A/ebWMzJzgdAL/7wS7xRVVjYng9uolBqjzY+4IgDkI+iApBGAKRoU+g7BTgHP
         oXflWjRSzo7cjca5l98vN4G5cmz8MUZGpy2viBXMqx+fHTLL+NECNr+yfj0nN+yFBwXb
         TZxJCjC6I7KpNKLSNhb/hcD6L7Vo3PS3c8Yu/ndzVGYexUP+v1YOD+w5D8Dz96F1gL5m
         1m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cnHaKGcMzTZrMV9+DycpQtbjSI9gqCpzF+WM5KDAOYI=;
        b=B7KGS05K87wP4luvUpGCd6DYIiFWxNyG9NUtQFnGJc8DDm7ZzDp6VIIPca+GZ1jRGp
         ofgOTuE8Bgpj/qDgdvHvrV61kPR3HShb//prpPJ44nh5nZUFHeg4C5QvTpiY8o03cv0q
         PdAhCVHrw2JRBNrSmJqTgp86l5irD5XuW2nKuk2ty7tZl90+g5Mae55ewLLEmNy4VlDW
         SgThy8mhdcOSwlIx6WXKzRGhRo5Szgab3lWyUdLoOhwF9w+ckD4IPFzu6qJnYR4PR9WU
         vCsc9zui2wGrI+qDlQznVzgWFbQDZ2CcxWhDr3ROUsrcDc8YO8Nv2/Fd0VwjYGmuiBVB
         bgfw==
X-Gm-Message-State: APjAAAUxtyaBqchX6vyasvX/5qy87pwM5lXzbT7PmxYzQnKJuPHCAOxU
        dI8WPDQDsxSSPLyNdPZIiPIWk2CntZo=
X-Google-Smtp-Source: APXvYqwEiWp/yNjzuQzjQoTmrkabJNoCTsTHyjiRt4f7PpRE9siDiHU3jHYq2MuhjIpOrvFqdSrDzw==
X-Received: by 2002:a19:2207:: with SMTP id i7mr30863016lfi.185.1568367658137;
        Fri, 13 Sep 2019 02:40:58 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l9sm6183358ljg.79.2019.09.13.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 02:40:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] Revert "mmc: tmio: move runtime PM enablement to the driver implementations"
Date:   Fri, 13 Sep 2019 11:40:53 +0200
Message-Id: <20190913094053.20753-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This reverts commit 7ff213193310ef8d0ee5f04f79d791210787ac2c.

It turns out that the above commit introduces other problems. For example,
calling pm_runtime_set_active() must not be done prior calling
pm_runtime_enable() as that makes it fail. This leads to additional
problems, such as clock enables being wrongly balanced.

Rather than fixing the problem on top, let's start over by doing a revert.

Fixes: 7ff213193310 ("mmc: tmio: move runtime PM enablement to the driver implementations")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_core.c |  6 ------
 drivers/mmc/host/tmio_mmc.c          |  5 -----
 drivers/mmc/host/tmio_mmc_core.c     | 11 ++---------
 drivers/mmc/host/uniphier-sd.c       |  3 ---
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 64d3b5fb7fe5..4a2872f49a60 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -774,8 +774,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	pm_runtime_enable(&pdev->dev);
-
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
 		goto efree;
@@ -856,8 +854,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 efree:
 	tmio_mmc_host_free(host);
 
-	pm_runtime_disable(&pdev->dev);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
@@ -869,8 +865,6 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 8539e10784b4..93e83ad25976 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -172,8 +172,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
 
-	pm_runtime_enable(&pdev->dev);
-
 	ret = tmio_mmc_host_probe(host);
 	if (ret)
 		goto host_free;
@@ -193,7 +191,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	tmio_mmc_host_remove(host);
 host_free:
 	tmio_mmc_host_free(host);
-	pm_runtime_disable(&pdev->dev);
 cell_disable:
 	if (cell->disable)
 		cell->disable(pdev);
@@ -210,8 +207,6 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 	if (cell->disable)
 		cell->disable(pdev);
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 2cb3f951c3e2..8b299c1f0069 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1153,15 +1153,6 @@ void tmio_mmc_host_free(struct tmio_mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_free);
 
-/**
- * tmio_mmc_host_probe() - Common probe for all implementations
- * @_host: Host to probe
- *
- * Perform tasks common to all implementations probe functions.
- *
- * The caller should have called pm_runtime_enable() prior to calling
- * the common probe function.
- */
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 {
 	struct platform_device *pdev = _host->pdev;
@@ -1260,6 +1251,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
@@ -1295,6 +1287,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 49aad9a79c18..91a2be41edf6 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -631,7 +631,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	host->clk_disable = uniphier_sd_clk_disable;
 	host->set_clock = uniphier_sd_set_clock;
 
-	pm_runtime_enable(&pdev->dev);
 	ret = uniphier_sd_clk_enable(host);
 	if (ret)
 		goto free_host;
@@ -653,7 +652,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 free_host:
 	tmio_mmc_host_free(host);
-	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -664,7 +662,6 @@ static int uniphier_sd_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

