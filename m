Return-Path: <linux-mmc+bounces-6593-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E389ABD749
	for <lists+linux-mmc@lfdr.de>; Tue, 20 May 2025 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F366A3BEE3E
	for <lists+linux-mmc@lfdr.de>; Tue, 20 May 2025 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA821D3F9;
	Tue, 20 May 2025 11:46:52 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DA21C9F2
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741612; cv=none; b=XIc0NWD5bgghKEOwQj36J1UVLHsne5AQmMFB59ayutwqkYrIrtxi0g6V8e7LEuNJtmN4Z5JyLwbUvHE5UlErrcnb04NmfI9/eaQ2HElrJ5GNJppnEJrzAexeLFUBkUUXD/Hdcuhy+ht9dVzaPV8YvK7rJlxHmNM1cE+sb7lY0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741612; c=relaxed/simple;
	bh=INniQ8BXTAMv4PfCtddbeRBRu+Mm1gdi22ITeeOAXTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1e1DMLuk/O5cnAFUEV7Rml9u/AhDT60T6rKJ17Bmm/0k6cBXoZPzx2c1rKFlWiXwCOjFEkPCK7s8/Em6whcpg3HfH74tQMTr4Wsr2mbORl0PbRBXqlzHT4lzH65r42J7mtOd3cY/QiKrpeDwXt0HdU+Fx848KpxV3MdVXZrUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxaeGpayxoFF7zAA--.22235S3;
	Tue, 20 May 2025 19:46:49 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzxuhayxotzvjAA--.5319S5;
	Tue, 20 May 2025 19:46:47 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>
Subject: [PATCH 27/36] mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:46:34 +0800
Message-ID: <0d16c9af84f9b8e31568f409a4eefd5e5ad6d1c8.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzxuhayxotzvjAA--.5319S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw43Zw47Zry7ZFy7ArWrZwc_yoW5GryrpF
	s3JrZrKr18Jr4Yg393Gw1DA3WFyr4Sqay7WrWkWwn3Jw15ArWDKwn3CFyFvFs5GFWkJr4a
	gF4UGF4UCa4UWFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	ZFpf9x07bV5rxUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/usdhi6rol0.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 49efb960a052..85b49c07918b 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1762,17 +1762,17 @@ static int usdhi6_probe(struct platform_device *pdev)
 	if (irq_sdio < 0)
 		return irq_sdio;
 
-	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto e_free_mmc;
+		return ret;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
-		goto e_free_mmc;
+		return ret;
 
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
@@ -1785,30 +1785,24 @@ static int usdhi6_probe(struct platform_device *pdev)
 	mmc->max_busy_timeout = USDHI6_REQ_TIMEOUT_MS;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->pinctrl))
+		return PTR_ERR(host->pinctrl);
 
 	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
 
 	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		ret = PTR_ERR(host->clk);
-		goto e_free_mmc;
-	}
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
 
 	host->imclk = clk_get_rate(host->clk);
 
 	ret = clk_prepare_enable(host->clk);
 	if (ret < 0)
-		goto e_free_mmc;
+		return ret;
 
 	version = usdhi6_read(host, USDHI6_VERSION);
 	if ((version & 0xfff) != 0xa0d) {
@@ -1878,9 +1872,6 @@ static int usdhi6_probe(struct platform_device *pdev)
 	usdhi6_dma_release(host);
 e_clk_off:
 	clk_disable_unprepare(host->clk);
-e_free_mmc:
-	mmc_free_host(mmc);
-
 	return ret;
 }
 
@@ -1894,7 +1885,6 @@ static void usdhi6_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&host->timeout_work);
 	usdhi6_dma_release(host);
 	clk_disable_unprepare(host->clk);
-	mmc_free_host(host->mmc);
 }
 
 static struct platform_driver usdhi6_driver = {
-- 
2.47.1


