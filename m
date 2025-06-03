Return-Path: <linux-mmc+bounces-6873-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E87ACC68D
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D690B171D58
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D4231848;
	Tue,  3 Jun 2025 12:26:37 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5F22E402
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953597; cv=none; b=B/+cOxYru2HSl15MYYT7g0YMRyNuyCWZ99jXgDn2Hn0889n2J7yoFkmgySdwFNbuldQ2PRW1W3S1/YjiHEkQ64l5CfB6O+fU9GDIgDERHSbFrsr7nK2TN/cl4CHZ+hkMEg1//XjMGEij83DHnP9D2mM96IDfZjm1lg+CSH8P080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953597; c=relaxed/simple;
	bh=S/sPKIWTs0wb0vVytHX3NU+LeEo5bYZpThxkaupe+HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rmdr9+6le7xYa5xxmL6UixNNVLwQZLIoJ/VEZO1MIB4eaceMSArYmjQFwm0b+ahmi+P0AOC8os1vzaShNH1DOvm3qYysYFbMjaSqT4xwu69ARau8RDbUiO/EcvZ04Har1DgiYb0Efr+eBG+vx73/kKhVWd/Vb/ykGI6ZnfSvxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8BxrnL56T5oxTUKAQ--.33738S3;
	Tue, 03 Jun 2025 20:26:33 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBx3MTx6T5oNQ4HAQ--.23320S5;
	Tue, 03 Jun 2025 20:26:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 13/36] mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:26:14 +0800
Message-ID: <c2bdcea3720b81660b3226180640e32fffefc464.1748933789.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3MTx6T5oNQ4HAQ--.23320S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWxCw1fCr45Xr1xur15GFX_yoW8KFWDpF
	Z3Ja43KryYyF4fWrW8Ja1DAF4I9r1IgayUCay8Wwn7u3ZrAr1DKws8Ca40va4rAFWrGa4j
	qFWUJF15CaykJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFrWrUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/moxart-mmc.c | 40 ++++++++++++-----------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a12048e5de63..3dd8f232052f 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -558,41 +558,33 @@ static int moxart_probe(struct platform_device *pdev)
 	int irq, ret;
 	u32 i;
 
-	mmc = mmc_alloc_host(sizeof(struct moxart_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc) {
-		dev_err(dev, "mmc_alloc_host failed\n");
-		ret = -ENOMEM;
-		goto out_mmc;
+		dev_err(dev, "devm_mmc_alloc_host failed\n");
+		return -ENOMEM;
 	}
 
 	ret = of_address_to_resource(node, 0, &res_mmc);
-	if (ret) {
-		dev_err(dev, "of_address_to_resource failed\n");
-		goto out_mmc;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "of_address_to_resource failed\n");
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0) {
-		dev_err(dev, "irq_of_parse_and_map failed\n");
-		ret = -EINVAL;
-		goto out_mmc;
-	}
+	if (irq <= 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "irq_of_parse_and_map failed\n");
 
 	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto out_mmc;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	reg_mmc = devm_ioremap_resource(dev, &res_mmc);
-	if (IS_ERR(reg_mmc)) {
-		ret = PTR_ERR(reg_mmc);
-		goto out_mmc;
-	}
+	if (IS_ERR(reg_mmc))
+		return PTR_ERR(reg_mmc);
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out_mmc;
+		return ret;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -686,9 +678,6 @@ static int moxart_probe(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
-out_mmc:
-	if (mmc)
-		mmc_free_host(mmc);
 	return ret;
 }
 
@@ -707,7 +696,6 @@ static void moxart_remove(struct platform_device *pdev)
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
-	mmc_free_host(mmc);
 }
 
 static const struct of_device_id moxart_mmc_match[] = {
-- 
2.47.1


