Return-Path: <linux-mmc+bounces-6678-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9997AC0520
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE823AF401
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54EC13AA2E;
	Thu, 22 May 2025 07:01:27 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D523BBC9
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897287; cv=none; b=T3SyZFd7bsl/39fbc8kaUcWJr8H5+7wwAvD2GJ9dAg6O76bUf5T6dq9XeCvOxJ24od5sLhckzLsOxDgBXKc53ZgWoRjoYu3XnummH0tl8nIg6/1Hsb2DhDktieYNp/Shj2WSWKN/ndWX2gFjilnpXVV9f0tlHsg3was0bf4UwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897287; c=relaxed/simple;
	bh=IogaLZypf8vHM+NzMbRv7WBM7J6jfgDRpsyuw0mYvyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGalQ1zy3aNwD9pzjf7+i0/zJvOtn9A11LHFdsTMaT4ltGFx3puB2yUDzwLFC39nWWyx3v57mRjcG78KRtoAz8mXyzywfENVOdn/Kya0MQTWj2T1aGvqt02ZfrVRUyzuhueYdAWeeH8YjdZANtFUuqvsyfaubA01a3Y4uIkhHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Axx2nDyy5oESP2AA--.35693S3;
	Thu, 22 May 2025 15:01:23 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCx_ca+yy5ok3LnAA--.8460S5;
	Thu, 22 May 2025 15:01:21 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 33/36] mmc: tmio: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:01:09 +0800
Message-ID: <28ce061b07838c3427ee67306118133c13b368f1.1747877176.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_ca+yy5ok3LnAA--.8460S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFWkCrWkWrWrCw4kGw1kCrX_yoWrtF1DpF
	W5J3s8JrWUCFWFg3yDCa1DZFyrXw4vgayxK3y8Gwn7Z345GryDGr1DCFyjvF95JFWDWFsa
	qF4rKr18Cw1rArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq
	6s0DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b-3ktUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/renesas_sdhi_core.c |  6 +-----
 drivers/mmc/host/tmio_mmc.h          |  1 -
 drivers/mmc/host/tmio_mmc_core.c     | 18 +++---------------
 drivers/mmc/host/uniphier-sd.c       |  8 ++------
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e6fa3ed42560..4647d86e145e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1164,7 +1164,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
-		goto efree;
+		return ret;
 
 	rcfg.of_node = of_get_available_child_by_name(dev->of_node, "vqmmc-regulator");
 	if (rcfg.of_node) {
@@ -1266,9 +1266,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 edisclk:
 	renesas_sdhi_clk_disable(host);
-efree:
-	tmio_mmc_host_free(host);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
@@ -1279,7 +1276,6 @@ void renesas_sdhi_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	renesas_sdhi_clk_disable(host);
-	tmio_mmc_host_free(host);
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 41787ea77a13..23b0be8e6d7d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -199,7 +199,6 @@ struct tmio_mmc_host {
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 					  struct tmio_mmc_data *pdata);
-void tmio_mmc_host_free(struct tmio_mmc_host *host);
 int tmio_mmc_host_probe(struct tmio_mmc_host *host);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host);
 void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index b71241f55df5..c25c5fec3d77 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1097,7 +1097,7 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	if (IS_ERR(ctl))
 		return ERR_CAST(ctl);
 
-	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1110,29 +1110,17 @@ struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev,
 	mmc->ops = &host->ops;
 
 	ret = mmc_of_parse(host->mmc);
-	if (ret) {
-		host = ERR_PTR(ret);
-		goto free;
-	}
+	if (ret)
+		return ERR_PTR(ret);
 
 	tmio_mmc_of_parse(pdev, mmc);
 
 	platform_set_drvdata(pdev, host);
 
-	return host;
-free:
-	mmc_free_host(mmc);
-
 	return host;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
 
-void tmio_mmc_host_free(struct tmio_mmc_host *host)
-{
-	mmc_free_host(host->mmc);
-}
-EXPORT_SYMBOL_GPL(tmio_mmc_host_free);
-
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 {
 	struct platform_device *pdev = _host->pdev;
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 4ad02cfdc238..1eae2f4b6c1f 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -663,8 +663,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 		priv->rst_hw = devm_reset_control_get_exclusive(dev, "hw");
 		if (IS_ERR(priv->rst_hw)) {
 			dev_err(dev, "failed to get hw reset\n");
-			ret = PTR_ERR(priv->rst_hw);
-			goto free_host;
+			return PTR_ERR(priv->rst_hw);
 		}
 		host->ops.card_hw_reset = uniphier_sd_hw_reset;
 	}
@@ -694,7 +693,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 	ret = uniphier_sd_clk_enable(host);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	uniphier_sd_host_init(host);
 
@@ -720,8 +719,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 disable_clk:
 	uniphier_sd_clk_disable(host);
-free_host:
-	tmio_mmc_host_free(host);
 
 	return ret;
 }
@@ -732,7 +729,6 @@ static void uniphier_sd_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 	uniphier_sd_clk_disable(host);
-	tmio_mmc_host_free(host);
 }
 
 static const struct of_device_id uniphier_sd_match[] = {
-- 
2.47.1


