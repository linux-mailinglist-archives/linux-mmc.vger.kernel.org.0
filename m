Return-Path: <linux-mmc+bounces-6660-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CFDAC0510
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A510E7B38ED
	for <lists+linux-mmc@lfdr.de>; Thu, 22 May 2025 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA74221F33;
	Thu, 22 May 2025 07:00:24 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC82222CE
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897224; cv=none; b=NWGJnyYzupdUTLXG2munrn4cuwX88zV3wageLZ+swhGL/KZEgZn5g1dVuD4Ex0znNgXnfJXwYGKJYcHZB2CBGpgXnr24vemuKiiSPPqSTzgRLCUP2Aah90cZ78Cy1uta5N+Pb/2R8cKKlY15Z3j7GxZKeqzxoveaCltSgBCs82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897224; c=relaxed/simple;
	bh=RMgjqMQOH/CQhkqrxRQ+UfYlhncYkjEfAOKyXQyIK+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMCRLq26ymHHKoRW8G96v2lv3plKhJDS2qLDXAhsuzOpSl6DNmDOoAFrhfx68Tk3wq/Ajc8YVPVUJ3qng1mRc2o5EkazE4bNa3WeUn3jxLj4Ja27YK5jVe4NyzSf+0OkAkh4WTP0P3xP93n6TmR14un4wV/UY8w91DpCxGkD5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxNHCFyy5oYyL2AA--.3893S3;
	Thu, 22 May 2025 15:00:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMSDyy5oMHLnAA--.4625S3;
	Thu, 22 May 2025 15:00:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 15/36] mmc: mxcmmc: Use devm_mmc_alloc_host() helper
Date: Thu, 22 May 2025 15:00:09 +0800
Message-ID: <fbe462e93c559867bd19168f1130e480b7875ce0.1747877176.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMAxzMSDyy5oMHLnAA--.4625S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4DuFy3AF4xuF43AFyDXFc_yoW5Gw4fp3
	Z5XFW3KFW8urWFg397Gw1DGF15Jw4fKayxC393Ww1kWw1Y9rWDta95uF9YqFn5AF95JF4Y
	gF4UJr4kuFn8WFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_
	GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUx_-BDUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/mmc/host/mxcmmc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 95d8d40a06a8..adde0e3cb9f9 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1005,23 +1005,21 @@ static int mxcmci_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto out_free;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 
 	host->phys_base = res->start;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out_free;
+		return ret;
 	mmc->ops = &mxcmci_ops;
 
 	/* For devicetree parsing, the bus width is read from devicetree */
@@ -1054,7 +1052,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	if (!mmc->ocr_avail) {
 		if (pdata && pdata->ocr_avail)
@@ -1070,20 +1068,16 @@ static int mxcmci_probe(struct platform_device *pdev)
 		host->default_irq_mask = 0;
 
 	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(host->clk_ipg)) {
-		ret = PTR_ERR(host->clk_ipg);
-		goto out_free;
-	}
+	if (IS_ERR(host->clk_ipg))
+		return PTR_ERR(host->clk_ipg);
 
 	host->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(host->clk_per)) {
-		ret = PTR_ERR(host->clk_per);
-		goto out_free;
-	}
+	if (IS_ERR(host->clk_per))
+		return PTR_ERR(host->clk_per);
 
 	ret = clk_prepare_enable(host->clk_per);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	ret = clk_prepare_enable(host->clk_ipg);
 	if (ret)
@@ -1169,9 +1163,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 out_clk_per_put:
 	clk_disable_unprepare(host->clk_per);
 
-out_free:
-	mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -1190,8 +1181,6 @@ static void mxcmci_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(host->clk_per);
 	clk_disable_unprepare(host->clk_ipg);
-
-	mmc_free_host(mmc);
 }
 
 static int mxcmci_suspend(struct device *dev)
-- 
2.47.1


