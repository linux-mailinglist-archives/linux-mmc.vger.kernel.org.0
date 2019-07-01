Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9621434159
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfFDIOy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:14:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfFDIOx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:14:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so11510263pfa.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tvMJ5s9gExvOA7lMPut++cP3zHcPvryLWLVuc4mHs3M=;
        b=KvCoOxV2rRHo0LP8pHEGJKzTvkI2+KlTgGiFKUOXH1jmu0LkQFTIONu+GiJg50suqZ
         JdNVybOqlsfUGfx1mhiI2TS+zH2KLWFXdBS3LLxm8xLhFU3eGNeI6zNvWmmqeWjytp5Y
         42gcvY0eJ1ul3Rn/5joOnaJZP7ozr6Y7K59xNy9vWZpUXARufZCxqXgNfpJzx/8WS7H3
         NwWpPhg4ROVRzKll5FlPSOfHhuB26wbtju1fX9bkRpOkQgecgke3eOQmCZZnsJ0x/XOM
         SUjWi2fXYc2UWco7WrnJfyA9cyRnPH5v8KnKBromZG8cE2HtOS758i5ajacD+nXKM/QQ
         6zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tvMJ5s9gExvOA7lMPut++cP3zHcPvryLWLVuc4mHs3M=;
        b=YZAKciEL5Im5RN6+U/6tAP4EptdxmfW5Ee2wr2FiyuxbSPKBpoEnaIOJizPSG/rx29
         qka57DMh/ql6wOuFR9QgOEbcUjLaBohu3Fa3kmQESw+ED40AnEQOO9wWavW8FGPprisl
         jb/fcXjPegBvuTm0mgEmKXFzdeAbtkM0kpifjs/UBuO2zZHXTQL6r+Hqa64gpvWKOPDD
         J/XdMpH/1g3teHdZ+3dCO4W//O+UERtJgTatRgWGwW1Wd28USutvLdiwTsvbcPMV1Axe
         wSgGlF+WmMjCW6t1PCapDLe1wkza8TxByr42D98fOiTu89A2T3tQSacU0F/J2/22O06I
         1iTw==
X-Gm-Message-State: APjAAAWSo68QgdsphtqGuRDhoWLvMkL1DPYrR2A1Dw16rOX3CcC31WUd
        6CbgnjEfRsLJ2njjUwMoNjSq1A==
X-Google-Smtp-Source: APXvYqz3oaHjaeADX6D9WBKXX/1VIU65dXOf477C7GTyXt8pCwH2Xc5XpXXOxK2eShfdWLpu+lZGhQ==
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr27207253pfr.244.1559636093172;
        Tue, 04 Jun 2019 01:14:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] mmc: sdhci-sprd: Check the enable clock's return value correctly
Date:   Tue,  4 Jun 2019 16:14:21 +0800
Message-Id: <9c76f06c8ba1762c9706f2c20878bf39d46370dc.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Missed to check the enable clock's return value, fix it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 9a822e2..e741491 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -368,7 +368,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
-	clk_prepare_enable(sprd_host->clk_enable);
+	ret = clk_prepare_enable(sprd_host->clk_enable);
 	if (ret)
 		goto clk_disable;
 
-- 
1.7.9.5

