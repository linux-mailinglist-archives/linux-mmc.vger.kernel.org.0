Return-Path: <linux-mmc+bounces-6884-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD629ACC69B
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76EE16C322
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Jun 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5F22FDEC;
	Tue,  3 Jun 2025 12:27:40 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466D1CA81
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953660; cv=none; b=rs9nwXLT6sN9p9hVdgC8MC6Mecf52BckQsaWgw1yoJ5sSblZ+jWQ7Iws9BVLTE6GnhmG3S1Fyxc/zUskkNvnJ8E/wzxZ8u5MAGxRclYxuPExSKJY0Xv2uZDdbQBrZPbhnjnrCYZJZSbNzMyAjLeZHtT/25S8cUUA59YTRf4epkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953660; c=relaxed/simple;
	bh=Jo50mjX8g7pRrBeDOWmfAXKSVZYCmTv8mlKXIKrRDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjeRW2sF8dRj545ZEYQpHVKarLrePOeQfdByyDf5HvbLPp3+rLs0quA/rFwjzgP4McNo9xYFzBEPEHU3JbrSS67RugTdnRJKbhnz9rIDBswtkGnWuV2HIxpiqc5/i+ylCRIXUoEiDPNsmj3QjE4lKpdK98twA9yO1ZB6quHqE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxHHI56j5oZjYKAQ--.33023S3;
	Tue, 03 Jun 2025 20:27:37 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMBxXsUz6j5oxg4HAQ--.25394S5;
	Tue, 03 Jun 2025 20:27:36 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 23/36] mmc: sdricoh_cs: Use devm_mmc_alloc_host() helper
Date: Tue,  3 Jun 2025 20:27:20 +0800
Message-ID: <ce16815710f97e853586a0496c315729bd11fb3f.1748933789.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMBxXsUz6j5oxg4HAQ--.25394S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWxCrWDXw45JF1Uur4ftFc_yoW8WFWUpF
	Z8Xa4YkrykXF1fXw45Aa15uryrWw40g3y8KayxKws3X39F9asrtrn29FyFqFyfCFWktan3
	XF1UKr1Dur1qqabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW3AVW8Xw1lYx0Ex4A2jsIE
	14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y40E4I
	xF1VCIxcxG6Fyj6r4UJwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU5IoGPUUUUU==

Use new function devm_mmc_alloc_host() to simplify the code.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdricoh_cs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 57b8c1a96756..481cb552c2b4 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -403,9 +403,9 @@ static int sdricoh_init_mmc(struct pci_dev *pci_dev,
 	}
 	/* allocate privdata */
 	mmc = pcmcia_dev->priv =
-	    mmc_alloc_host(sizeof(struct sdricoh_host), &pcmcia_dev->dev);
+	    devm_mmc_alloc_host(&pcmcia_dev->dev, sizeof(*host));
 	if (!mmc) {
-		dev_err(dev, "mmc_alloc_host failed\n");
+		dev_err(dev, "devm_mmc_alloc_host failed\n");
 		result = -ENOMEM;
 		goto unmap_io;
 	}
@@ -431,7 +431,7 @@ static int sdricoh_init_mmc(struct pci_dev *pci_dev,
 	if (sdricoh_reset(host)) {
 		dev_dbg(dev, "could not reset\n");
 		result = -EIO;
-		goto free_host;
+		goto unmap_io;
 	}
 
 	result = mmc_add_host(mmc);
@@ -440,8 +440,6 @@ static int sdricoh_init_mmc(struct pci_dev *pci_dev,
 		dev_dbg(dev, "mmc host registered\n");
 		return 0;
 	}
-free_host:
-	mmc_free_host(mmc);
 unmap_io:
 	pci_iounmap(pci_dev, iobase);
 	return result;
@@ -483,10 +481,8 @@ static void sdricoh_pcmcia_detach(struct pcmcia_device *link)
 		mmc_remove_host(mmc);
 		pci_iounmap(host->pci_dev, host->iobase);
 		pci_dev_put(host->pci_dev);
-		mmc_free_host(mmc);
 	}
 	pcmcia_disable_device(link);
-
 }
 
 #ifdef CONFIG_PM
-- 
2.47.1


