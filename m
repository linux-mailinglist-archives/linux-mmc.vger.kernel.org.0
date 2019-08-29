Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4AA0F0C
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 03:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfH2Brc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Aug 2019 21:47:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46235 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Brc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2019 21:47:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id o3so785562plb.13;
        Wed, 28 Aug 2019 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWbB+arBJsDjT4iykZ2xGw0U15fa9Mgp2LMlYFEFahY=;
        b=dcl7DI/sZV/Cwi3MsGYjLD29jabf7MyJueotrteCEREelfXsF6iPUSmw6NlXm/iSkE
         OPB2m5/fbW0Cg+pn4iyveTX+/M2qw4tFuCzy6/ilQg1p7L+/8z37LMK/64h4M/+FfJ+d
         vJ/ieu4ei92rGee81AvWsz23LE26eJQtXglCtt0wL1Vv6nfW9sOVs1OgwZSMzOl9hUN3
         Wm1Fwfz4bkxfFjWRH+Neq8YTTs8SChrnd7SXPFpxlgTqKzxo9AQrhyuhIVuBnTF4EYK6
         gmgQYJSMlJqk9oh2FmdXIzuOD0z8ZbS4oOrkXHS60XvSVd4i7LRNs6MUH4bBfu3RsVuU
         LPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWbB+arBJsDjT4iykZ2xGw0U15fa9Mgp2LMlYFEFahY=;
        b=FzEkQea9/xabqZvjQ87oN/PdHPUjk61RNu9sdorig4kDIJ2Lrg85Jgi/9vbtDZkdfn
         LY1KiFAxQpjjPogT83f4Zc4/g5y01ibU+bGdKNDu22FDS+vCycfEkMabIt4ZViEbtnbF
         kUBuTFSfdHmB/Vw9kjtFkAszr9uWT/DDWYVI61668d3limx2oZWhIVMfbSh2IAdYV+v3
         zohE6Ysr/yLwXL5lEqsigBNNkNuammZ31rVDBFSncnWrq0W4PF5aTRWkw6aSUd5iPXq0
         5L3YD6qTTqwBYYs6jrZ2DVisCp0wqJuoxfoteZoEGEHEBb24nRjSVdoSlWC1lX14fMZh
         vvoA==
X-Gm-Message-State: APjAAAVDFbnZ5ZRKJ7FAACJppRbLZJcOheg2aJIeri/h5QLQj0/vSABz
        P5m3aKHPfR/JqNOtP2NkIu4=
X-Google-Smtp-Source: APXvYqzEWsi0SGNnEmGjO2j/IVYnxUC/dHv0hVy7pAURZ8eQ82tdO+H+bbtO2s4dbyX85VgOtzdSvQ==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12mr7451128plo.198.1567043251870;
        Wed, 28 Aug 2019 18:47:31 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:47:31 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 3/5] mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Thu, 29 Aug 2019 09:46:43 +0800
Message-Id: <20190829014645.4479-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The bit of PRESET_VAL_ENABLE in HOST_CONTROL2 register is reserved on
sprd's sd host controller, set quirk2 to disable configuring this.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 90cb2af91159..27d0b57f3f89 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -510,7 +510,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_sprd_ops,
 };
 
-- 
2.20.1

