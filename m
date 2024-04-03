Return-Path: <linux-mmc+bounces-1685-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F389723E
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6416028A7D5
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE814A612;
	Wed,  3 Apr 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZosLR6WI"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6F14A08F
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153835; cv=none; b=bmAlahCjprY19sEvjXtoyO3MNjTuOA73ut7MD8aB9bm2b+h7omiK6q7xYNOXy2KbXzbTYUmvs+/RxHKhfj9n5OWEyg0iGqqjL6E3e/LVuGcepulmXEJDnAEBYTr1NZw7AgxCIR1sHzsOEEbrbz3TPhPGEzeFy3Yme3zC7Q+TCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153835; c=relaxed/simple;
	bh=84zMF8c7ejIeEw/PrFg37PetkFt6D4yoyHa2Q638+x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py/n/1srF+wT7DCGZO9xGsKNQMounTecq+MM+j7xxl0pXTNuIUCvNAeXAYe8j3vQETUlVKFyb0FbhVM85UsmcvioJH9qSVddRQdR8NksTdZvRFNZDxLNpiCiKBiZIebwuyixQUJRestxbjdtz1E1wIvGJ8tb5lkAgc3BgUm0SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZosLR6WI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e39f5030dso673265966b.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153831; x=1712758631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BETDSA3lUOn0sAQ76GOdjltAIl8rL8ja5xGlP+sx/I8=;
        b=ZosLR6WIAy6SXFlW0lMMW0Ok7P/+JattGJQD/XcANWO8MIIJJaS1AEZ/N9F84bxRbR
         GRoF/AOv/xXXM41GneQRlwWUFYl72p9SP/UN1B4rj+pZEk8P1vZdJ9xQ0kYX2/PmVW/e
         Y0W4uhc1DmGcH+o1iwtOZYdXPObEfeTRUZenwCklxDg0F6tp4ZNZSkGj99oHgfQ1v4YD
         IunQ1zEbHdqZdY9L481oE7EBP2KHj7UrmWH9KqckC9ikurp0XN+pwvpI2kInlIwRP53S
         eDjw8/xSRAgvTFdF3rpvZrp4FymvxGDLFgPzNwjQ2mKQ1PlUgx85JWEtVLgwxZlFfBs4
         iclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153831; x=1712758631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BETDSA3lUOn0sAQ76GOdjltAIl8rL8ja5xGlP+sx/I8=;
        b=hmUE0w96gacu/qA7qrlHhXLsyyON91+6MsTwNdIypn5/oCMEOnBHoK9796yxnnMRYg
         ngc5P20L6V2cv1b27qiVBYm7LWAmwX2g4vyU40tnBFEL6vKOoQTSzCBk2LLiZDhfyfQM
         Rmke02Kw86AeC3SIlPSHVsERjRbYeLkKdQBcpUEyMsijP469ScSQznrnQ3ArPlcwK7iK
         ADKcgZgEwhbUC6Db/0XN+hAkBf+aXWSiOGq5lp/UTv+h3DTjicWul6ICMRzmleMdYoJ7
         6YoZOPhp7Y7ABJNW6X6w4XlkHGV1NBfGtkRovK6/oiwtfzjpGapsOZ/KFKjhaEjGwzc0
         xwTg==
X-Gm-Message-State: AOJu0YwNJmkGYJ1GYBfGADV8Xa6S4Ww3BYEymal6MW/JGnSjLzEjjaoX
	ozxe9F+3+f+mR1MlpfV71JEMwtUt9s1Yi18waBjsPFYq1Knz42puEi3OuSGt75g=
X-Google-Smtp-Source: AGHT+IE1w6g2ucl/6IDzZmSNYwasQaFWqR1hQjGTPf/zJiNt+ECvgZll7C7tOYfQKox7jLfE/t4qNA==
X-Received: by 2002:a17:907:72c8:b0:a4e:8024:87f6 with SMTP id du8-20020a17090772c800b00a4e802487f6mr5679542ejc.66.1712153831564;
        Wed, 03 Apr 2024 07:17:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:52 +0200
Subject: [PATCH v2 3/7] wifi: ath10k: sdio: simplify module initialization
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-3-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=84zMF8c7ejIeEw/PrFg37PetkFt6D4yoyHa2Q638+x4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTbyM65zcvlEfiPazS0kbhT4junWR/REE800
 uUG+OWmZwSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k2wAKCRDBN2bmhouD
 180pD/47q0AiV5Hxqsie9qNBuzm6JBeut4X6plfgi0CLEaa18s6SlSIYmjyQJrEaIIjiwYkHl9R
 mNz6kX5GPEbh4BOI/LcKeOxZadJaAlD9TefFcic5Ysxzx5v+3dbYdVHdk+VfEGOd7VfE9/rOAO0
 BQTjfDderHaoJePQC4UGkW+gWTgv06CccSq1b0cc3lL1vQFTjPEYPpkXyLErRlj3A1mf+B9tJqU
 QSG8JFugLbprDi4NOHbNyq5e321sRMMpEfs9rSVsbQ6Dfn3BeXn015N/NfoXYVcfPh0z/su1G67
 AoFkVFLW/KLuKCA20mWiAuob85XpRTaefVGaNsYSWOzfN/PBbEzWxuyK6UoCieqUsD+IxQXCNaq
 9kfvpAIrEtJsGcMCbIFZ1wY+s+BQpNX0S07dSG4Cjiuel3qY1TwiAx9uwoky9uJ8Qwmb9lNjm61
 zXbrVvNFnnE6WPOG/aAF69LkYOdYZ4WCA3n9B/F+GhplQZ4EGvQwWysETP8LwPuz5gDHhiME3Ny
 M/2ndx82o/bHeg8MbwmGjbxANR+iLNhDqdy06BYjNlYWLn6dctZeAV6hk5IOG2XpY0mpIPXdPXA
 q6MWuaAs7gMQsmksWyFardD2jh268J9qqV2DrLrlPxACunW82BMYT/aQ8WfxbiFEMl4ZjJJ3uBj
 mFCcm2iroS8Auzg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

This driver's initialization functions do not perform any custom code,
except printing messages.  Printing messages on modules
loading/unloading is discouraged because it pollutes the dmesg
regardless whether user actually has this device.  Core kernel code
already gives tools to investigate whether module was loaded or not.

Drop the printing messages which allows to replace open-coded
module_sdio_driver().

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2 moved from other patchset to avoid conflicts.
---
 drivers/net/wireless/ath/ath10k/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 0ab5433f6cf6..1acb9fba9a8e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2671,25 +2671,7 @@ static struct sdio_driver ath10k_sdio_driver = {
 		.pm = ATH10K_SDIO_PM_OPS,
 	},
 };
-
-static int __init ath10k_sdio_init(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&ath10k_sdio_driver);
-	if (ret)
-		pr_err("sdio driver registration failed: %d\n", ret);
-
-	return ret;
-}
-
-static void __exit ath10k_sdio_exit(void)
-{
-	sdio_unregister_driver(&ath10k_sdio_driver);
-}
-
-module_init(ath10k_sdio_init);
-module_exit(ath10k_sdio_exit);
+module_sdio_driver(ath10k_sdio_driver);
 
 MODULE_AUTHOR("Qualcomm Atheros");
 MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN SDIO devices");

-- 
2.34.1


