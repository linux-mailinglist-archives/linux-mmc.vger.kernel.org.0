Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88F230F9
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbfETKM2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 06:12:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35223 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbfETKM1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 06:12:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so1124017plo.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=va9J4UW4i6NFUGtzfpaY8tfEC/B62lw3LIia2oCGJ4I=;
        b=CqYTASlzHxuj19VEkiNYFaWBgj/+AcONyfvUgSBiBiQDowtzgjclMCFW17Cx6Liwr/
         yTHpl33VMY+PK1nwAw97ptE/aov9Ny5Gd9CDUPr0BmI6OPlfMVCa88nBG0nfPFrWKmc5
         4xJmj6AY4t13zS/X2WSYUqFnK48emMw1jtHxivKXmKM0FLP1o78D9881x/AX5Y5H4trs
         BR7RWlDcGDLZXJQywZ1nZaZE1slyONTDCdLubvEOiOJ43/lPQo5uRKtVdbjKNxgEFBYR
         psxab5AHlmJ1Xmw4MdgUFX5yEcnCO4VWW9lbwf2QlwniZg7uBKRAoLg1DUSzr20QZmNr
         5xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=va9J4UW4i6NFUGtzfpaY8tfEC/B62lw3LIia2oCGJ4I=;
        b=TOlfclegb16hwnNmBX7X5O5iMq8Qyl66qF2cibDuVT7KIxgrfj4fsZPi/4qb6azKjr
         im3AdM5A5KLofzGQXiZhHW+kGcA+Ql1mvG2OwlM4vpiZorL9yyFnWOlahcqnM7Xv3cE7
         x7UNulPTRtpoH/ZZ83sX0KUl6+Lh2x25tMzu6uLf/SWlHYxRztT/rIA/+5ajwfKypenh
         5JmBxjvKU+ZCBvaMC+/rZImt1BeljEwYbPeQDNhPVILdXSF3fR31FVUjiR0fszkZCDfv
         xB30QQvvn37RsPqlwZl1SicdooUCc3cNDd2/T1caq8D2tqjIBwozPLYYKFlXnwE/70Rv
         f5Pw==
X-Gm-Message-State: APjAAAVHTx6tTLjo4uAUSsvcTtZQdjVDHeTRvb9lbxgV2JVi3OGusNPN
        PyPS2vmUAMpnCepU5NZuADO1Bw==
X-Google-Smtp-Source: APXvYqy8HueQjfTYyMBchyG+3yVOgHldG2Viyebm4bLNlkUI6Z3Kj5vcojNZbJJuuIgiyzD8yg/meg==
X-Received: by 2002:a17:902:f212:: with SMTP id gn18mr12999942plb.106.1558347147096;
        Mon, 20 May 2019 03:12:27 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:26 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/9] mmc: sdhci-sprd: Check the enable clock's return value correctly
Date:   Mon, 20 May 2019 18:11:54 +0800
Message-Id: <7e4d922ba5aff5241b0186e9480a98b14693b28d.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Missed to check the enable clock's return value, fix it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

