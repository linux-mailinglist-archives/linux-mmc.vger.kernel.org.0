Return-Path: <linux-mmc+bounces-1688-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D789724C
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC63B1F22EE1
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F514C596;
	Wed,  3 Apr 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNaRJZXv"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37C14B074
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153840; cv=none; b=cXgmTmC9Pm9FWn5V05FP2ELXkYsFjihZOBcI0WBLLZEs7vpNVpz4S9t0pByu5Jw4DFHx9NzB5UY6KEudk4dZcPEGUToAt/aswkAWRe/PRMzXpNs2fivaV46GrNyaK5aExhRT3dpX5dpZj3kJUqEk1PqWSWIIe1H7yFrtrjjLiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153840; c=relaxed/simple;
	bh=44MLP9zefnsNnal/9x3LUH01f3HB/XMi7tqRa1ODu/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow/CG/sFW8TtVNudE7hNZjDsleeZheL47xYCrTomz08nK8n7qnAMhBmKoU43RSplJcT3zJxS0UnMb0bI6pBHigtyDs+bZg+/zC94TlEJtSLKPm09WpQR772JCGGupAcLyXFyHdPPlcsHHMaWZGwhH00I2jMEQ/7LoNklN4lWwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uNaRJZXv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4e5ee91879so480713466b.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153836; x=1712758636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0vV1TVhRuXYRf/9v8gYugm0cKFpboW4ZZINajTG3+I=;
        b=uNaRJZXvanAS5Bdenpj9jIK8YQ571I0xjJzdRUAElmKB2hjP4IDGTTPm3OnF9AYxx4
         7Ay5aULnJM3CnwGKnsH2xrXofFpa8/s3lmOqAlrEEVlR461CJVkUNtGZnzs8m0Ly1eGY
         r34hkVnT4aA4D0o5LsRm2LWkOiV+CZy06B2ADgxZ9btuC+Ik7TF7RKfQixNM0JUCTjoO
         e9Rm9MrhT9Rmsb4VmXx0115fJpP8iyLmL/4Ske52nHls0c17c3xiUMDXOj3/OhJVhcux
         FaNc2jorEMyzsupyqxxyCcvj0A2DxcZXEr5+5dsWEUD5F/Wn6qud3yrEx1g3XEjfwE8f
         1tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153836; x=1712758636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0vV1TVhRuXYRf/9v8gYugm0cKFpboW4ZZINajTG3+I=;
        b=q36nXAQ429P8ty8Zbe1iCmsxd6f9SkAkQDb4qgNKuJ7gP89HhkBr9RZzLUgDIGWlBc
         VREIB9iYw3P95zEoWT9VG0PrQ6LQFp/M87FCdd3ohKCaOWOTjgr7t/6iy24wj+VfbVOh
         w8JMC4ORAdim6/oXtJIwz2Sa2HgaATBxk8ex8cNPFMRndeWgYm1If/fXekngxLH6DqUw
         xQJ2RcZhljx2czu0dM2QPoLaEGGUdekzXCQbjw2LPxH0rIIXY/4YGOv+AkH6I+IPN0v/
         ne6zOvRPOlTNeROmpW7bRk/MztEp3iB14rEKbh6WJe3odmiHegNGPXq1urh6m0J8l8QZ
         BFug==
X-Gm-Message-State: AOJu0YzRGO68RHWr83N2bM62ZjJ8bbE8IX8gQlRY2FTO60BeAtziS6r5
	UGB3lJbTXJ0LZKDhDzDGk3flSxBhLfE0vKqcLnXrqCZ0JeMANnL3phdDIgaWQGcfqQCRX+3KtwI
	e
X-Google-Smtp-Source: AGHT+IESXedZWS12j/IBeLIYCIeiTvUtDhGnVVmwc7Y65AKvMiVNSuQO/q5aF56JXsx/yKl9XqaeMg==
X-Received: by 2002:a17:906:b889:b0:a4e:101e:8a97 with SMTP id hb9-20020a170906b88900b00a4e101e8a97mr1828471ejb.65.1712153836735;
        Wed, 03 Apr 2024 07:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:55 +0200
Subject: [PATCH v2 6/7] wifi: mwifiex: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-6-ae46d6b955eb@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=44MLP9zefnsNnal/9x3LUH01f3HB/XMi7tqRa1ODu/w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTe16dq1dJEsJSnP/kRyVGwLiEnTFn788+oV
 GGtYkan9UyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k3gAKCRDBN2bmhouD
 1/9kEACCfFciE1oJa5A3bFkEqBgQPN/py7DctCjUn70y9z0g5ME7fMcUi9khdsK8OM3rvoqne+o
 U8NNqieNKtAO9IMi2CPA1wC8M4Wh9e4SCx5XngbxiNWP9/eEAnHvBGxckTaLGtPrX0yqgvpb8zf
 8DDyI6avfAZTM75Goy/SBVEFEQHhNDXHBwAsHJfHHerATA2Eb0RtNfrdl6KZNHpw9dBki/Gqguq
 SmFaK64ZzF3NvOxY3j0bnSd7+TSXkt/XbCu94FYgP69uva7f608NittH/9PlF3lPqtwoMFZuite
 C72R5lG5ygVaTQrAjmpVPU+ptiW1S4WE56ZoAMnE13XJ40cnXSfWCTvHVkap0FYipYZJ2jbI6ZW
 T52u7f1yoFmxcJMxt+wi0OFJ5yr0sRPZ4ykTk0TE0FEnjdfZUTra0qpR1eTpP4SwDyNKwTHqerO
 7mCz2E+zeY7hHhvcaiaVLD67Zh3oiZaz7Gk0bCdz+AIZSS4+r/eIJZPXCi87hUJG7mzgB7kCyKO
 n629sK+58CEmUGqaqdYlJyFJhXPRHh0x3psIBUbElx8S/NNF8VpPJ+ayj+xk0YEQBcco9ZuQjVG
 XvGW/Qwa5uZQp0HPCL5SceQ0/zwQULALaSmtsD/ZYO5Jd3u1gzfyw0+kMi/gdZyZ+KN53+foAhu
 PLE3iIJrkQ+zufA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Kalle Valo <kvalo@kernel.org>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

Depends on the patch in mmc tree.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f41048b5cd3c..bda9b2b8a1f3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -979,7 +979,6 @@ static struct sdio_driver mwifiex_sdio = {
 	.probe = mwifiex_sdio_probe,
 	.remove = mwifiex_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = mwifiex_sdio_coredump,
 		.pm = &mwifiex_sdio_pm_ops,
 	}

-- 
2.34.1


