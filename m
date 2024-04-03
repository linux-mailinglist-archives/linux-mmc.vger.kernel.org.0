Return-Path: <linux-mmc+bounces-1682-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C223A897247
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471CBB2C60D
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C314901F;
	Wed,  3 Apr 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx9NMrXl"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4A14900C
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153829; cv=none; b=J+KNJrfkYdYHgV/uVPl164CTDjaEIO16Bsy5XsGJvcrVqSmpPdde1lw17e95YkFPXnJcJso5UTZzJ2epMfd0+wMN+C9rqp6b0sN1E/4x14CojovnHB6gpjpjU8N2Jo7aDIBHJJCTvmG/EX05BXAWOAil91ahxnlX5NWmUTyQWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153829; c=relaxed/simple;
	bh=sLpMucYAHhsdtxJHN7w3Qoxaqd4j7HhpYMAWN0I+lGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CNFc5CejkJhyTmHbFHUhbx0jvh/OXqBABinPYqLryDzcTaAxPClPcSAvAZcD6MMzRpyE4Q9/4C6nJ2kSdjeWL7a4QqqgVV/55Z63uwXQaiPc3bv4lIykN6TfE2qlXMBENdbzsnhF+cdvb0O1cRZAf3bki52nqVl5o11S9g7rbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sx9NMrXl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51320fc5d6so80904866b.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153826; x=1712758626; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuCdjLuGGbkRMQ83O6riv/SQKm1Ri8pT6mWmBtg/ZLU=;
        b=sx9NMrXlQ+u3ukWVEs+VrEc4EfgDdAgT7Q8F59YYGunEa2gn9draEM1l62YlQcPKJC
         Jiteq6eRuNI9eGQPGCkQUlxZGvtNVUXMtRrAvKrfR1b1ZMyAua2LCXLAuIIURnPQN5oD
         ZxRqsEbNqMNrq+oFowyOk1FGBNl33CM1Eaq4ddRhMd31iVsxf4ixtzySDIhfE+PY4A2M
         2qIY4g1rdqSfB1HJKzFwQpS3zmvw+d8OiHv1n3PyZH3OmhqLCrGM0KFXVMN8+LE7Piuj
         g8Lx6defrNpJvLfi+jpeJBvPd4QqZLFzNimaDgHFruOK4QYsmYz1L8xpP40t0iCyMaMr
         vWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153826; x=1712758626;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuCdjLuGGbkRMQ83O6riv/SQKm1Ri8pT6mWmBtg/ZLU=;
        b=cdKN3KHDyEeDWsaLJahEW5MZMBN63RwR158Dt2spoJoSvyD2dCj8XdzBmISg4FxUXt
         81BIdUd3fYpOtqQAJ9xqeDE96ThwaVhK+0+Z3BFET3wJasPc4zMkF7wavKlI3c+eS0nk
         gZ0mfpmhWAzFAKHcVv4unewyqodnnSTsLcAH4wf/XjLSdTHHEUR8liwSKJRD/cAwlsy6
         XyE1G3QbrMan81zJGU0w2EMufVMAcYTlsws51M0OG4M06W2L6ID078Enl28YW1nuizd7
         r9DaZ9a9mZK50iFXy5jryIdEkbmzZ0VE3Oo6os1gYfZdMwwq48neV8EEtU7uMyLEO+sw
         K0ww==
X-Gm-Message-State: AOJu0YzPfpdKewmVQ/7xYm5IFHXcS2jmjEnao/ILwxqSDGFt0ElfVEKG
	Sf5/WKWD3utCoW2f1fWxjgyg4Lk73wvLeCKdWBF4STxjmX97uh2OjR1HejWCupYqftiy1p25xqS
	+
X-Google-Smtp-Source: AGHT+IFO8Vb9lHvVlqh4Fhvzs8+Osxn5YUdvNkeRmO3RgCSXeLQUOJc/FTwyahym7ZIF7zC+/P+mMg==
X-Received: by 2002:a17:906:2286:b0:a4e:2ad3:60ff with SMTP id p6-20020a170906228600b00a4e2ad360ffmr10167064eja.47.1712153825752;
        Wed, 03 Apr 2024 07:17:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/7] mmc/wifi/bluetooth: store owner from modules with
 sdio_register_driver()
Date: Wed, 03 Apr 2024 16:16:49 +0200
Message-Id: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFkDWYC/32NQQ6CMBBFr0Jm7Zi2YIyuvIdhUdoBJsGOmSpqC
 He3cgCX7yX//QUyKVOGc7WA0syZJRVwuwrC6NNAyLEwOOMaU7sT3iQ+J0J5JVLMkQV9Fw+R6t7
 GYwNld1fq+b01r23hkfND9LNdzPZn/9VmiwapMdZ01obg/WXi5FX2ogO067p+ATismyqzAAAA
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
 Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sLpMucYAHhsdtxJHN7w3Qoxaqd4j7HhpYMAWN0I+lGI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTWhZYH5I8P8YpT2j4tBswcTi465OR3R2Vdy
 MFQyrfbcxKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k1gAKCRDBN2bmhouD
 13mdD/9oyNN2LDJS4UUT9lh9FMmVKzv4zMsED2g7AFXgqM0qm2cmuSWbj4u0GU5NwOX7BrqZ0vm
 1MoFRjiJXrPRIf7W0+2V4H+nJoVr1yuR2iyhjUzHWMvuP0zH94qu171iOEclYnnYRB1qU+aLfL1
 kJzO1IgcZr62n1nUT87KOIg6EYDjM3bkN70HEKdTpUnT/4IeQGlz31nGBN5fMwY7ilGcHj2o6eD
 SD/B+XlchCBRqtClLLHRjE6vWL3Kh8waYpVcQN5tkTL8n4Z6Kx2V2ggi/cRaAivFJE0QO0twESt
 a2uhb7p02ZXGJUgcq/q8X3ZHdg3Tk52fyiITyoVkmqt+aeXgy3BIjNLzbEYYCdkbE+O+a6aIVMY
 sWh80j9S3lKWFD459htyZZNQ+JAYTQOPyskSA0Y77+ZJ2hcky7Bj0npm4yECJMg7Clz5yA/nOCP
 /p3pZpdzVSifUQjpfg/Pyb3kFJfSAY8JZyX3rHkMb8drpepqWBRAhDZXwCnHmb8gFL9U1fn9149
 H/c92m5ZCti6AeuyN9qchKtH+ni3k2ZwfcSCq0jHltwjYJRvyR/f9kdOe7BtQVEtUHEKrn/TPPn
 ucoPD3S7+PK5iVuBtSj1znupa2G6inwizGfgWIioyOsREpGfSWWDon01uTGqrV6OhMBIx5fIAGI
 RSRd/yitwa0sF4w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
1. Add "wifi: ath10k: sdio: simplify module initialization" patch, from
   my other patchset to avoid conflicts.
2. Add Acks/Rb tags.
3. Drop applied SDIO patch, which was the dependency for the rest
   cleanups.
4. Update subjects according to feedback.
- Link to v1: https://lore.kernel.org/r/20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org

Merging
=======
With Acks from Kalle, please take entire set via mmc/sdio.

Description
===========
Modules registering driver with sdio_register_driver() might
forget to set .owner field.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in commit 9447057eaff8
("platform_device: use a macro instead of platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      Bluetooth: btmrvl_sdio: drop driver owner initialization
      Bluetooth: btmtksdio: drop driver owner initialization
      wifi: ath10k: sdio: simplify module initialization
      wifi: ath10k: sdio: drop driver owner initialization
      wifi: brcm80211: drop driver owner initialization
      wifi: mwifiex: drop driver owner initialization
      wifi: wfx: drop driver owner initialization

 drivers/bluetooth/btmrvl_sdio.c                     |  1 -
 drivers/bluetooth/btmtksdio.c                       |  1 -
 drivers/net/wireless/ath/ath10k/sdio.c              | 21 +--------------------
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |  1 -
 drivers/net/wireless/marvell/mwifiex/sdio.c         |  1 -
 drivers/net/wireless/silabs/wfx/bus_sdio.c          |  1 -
 6 files changed, 1 insertion(+), 25 deletions(-)
---
base-commit: 7d860d3177a745017d38b37bc2bff2f090631148
change-id: 20240329-module-owner-sdio-abd5de3f1d74

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


