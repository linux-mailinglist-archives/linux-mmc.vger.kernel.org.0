Return-Path: <linux-mmc+bounces-6863-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CBACC672
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC4D1719A6
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D122DF80;
	Tue,  3 Jun 2025 12:25:38 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172C22D7B0
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953538; cv=none; b=iqoDrFWJEEhUgosvqxT+zPoO2U+amqZx326RpNnggez8bMCt4yjX8rwkF5P0pPveQ+4u3siWuV7ZEliARPyEEGSjqLjEpRgdE7fFn/SiWpGM6kFLPZRstl5tpCuPQ3sK1pMF4a149+BUJMcKN/Ku0zJeNC0RBtugcEWU+dyOPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953538; c=relaxed/simple;
	bh=GLQ5H6ecp16WcqEk+/59/M+RaQu7hCI/XbEyEK6OyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S26mFBjfJ803Y4XMh0Gf0vGW1CS/pfUI6vHAX38fXzscKHmrZphjUi8PD6OUhmRqE1BbC6bbu+X3l6FKORO5leH2K/RXjCJF6l9j+gnlUVt1NNRUleJKxAoDZBu8DDMz2DuGQZBeMuYoDdAzgBh/aOlyZo93xIlwO3UvxEVc0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8CxyuC_6T5oOjUKAQ--.33699S3;
	Tue, 03 Jun 2025 20:25:35 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMCxLcW36T5ovA0HAQ--.22246S4;
	Tue, 03 Jun 2025 20:25:34 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v3 02/36] mmc: atmel: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:25:14 +0800
Message-ID: <0688b77b93d27bd2f2e155fca6f53a1766fc3a80.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMCxLcW36T5ovA0HAQ--.22246S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW3Jw1UCw4rKr1DWr18tFc_yoW8XF4xpa
	y3Wa4jyr4rGF45Wa1DCrZrKFy5XrW3t39FkFW7C3ykZr1Utr1jqFnY9Fy7tF13AFy8AF13
	Xan8Zr4Uu3WDJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Aubin Constans <aubin.constans@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/atmel-mci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 14e981b834b6..f72fe4b805f6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2247,7 +2247,7 @@ static int atmci_init_slot(struct atmel_mci *host,
 	struct atmel_mci_slot		*slot;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*slot));
 	if (!mmc)
 		return -ENOMEM;
 
@@ -2320,10 +2320,8 @@ static int atmci_init_slot(struct atmel_mci *host,
 	host->slot[id] = slot;
 	mmc_regulator_get_supply(mmc);
 	ret = mmc_add_host(mmc);
-	if (ret) {
-		mmc_free_host(mmc);
+	if (ret)
 		return ret;
-	}
 
 	if (slot->detect_pin) {
 		timer_setup(&slot->detect_timer, atmci_detect_change, 0);
@@ -2361,7 +2359,6 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	}
 
 	slot->host->slot[id] = NULL;
-	mmc_free_host(slot->mmc);
 }
 
 static int atmci_configure_dma(struct atmel_mci *host)
-- 
2.47.1


