Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC296F92
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHUCkm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:40:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40937 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfHUCkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:40:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id w16so385070pfn.7
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=pucFcgN1fWrC8ETrL4iTGcbEQjQsh6oQjzZCjUPUq9bxlFw0y88Bw+K8LbfKHGQC15
         f0tluknyHRejt1yPMcuVKxsdPSJPSqvjXrt2fDLuFO/5iJ2SlXuDvoPatf/C24ch5ttF
         hIWoG99makuXMf7Dzw8opP48Hob4C9dqASXQVO7Ry8wwhW+gig/gkkqsxMXFT4BoZjtp
         AviH/ca2HbQlGXlXTVSdzt7uY6mtTqCdyJFOz5nTYKGyyp64JiImDWUVEHPC+BcDaaEb
         sPrLx74lt95lpxYpF6BHWQjw9SEJhCjMtFa7FsEeg991GiPk42FWzid9pyZj+UvXw8lK
         PW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=pDKyye0Eij8g/HS+swrbpBUVa6TpLk5ypWUEccpm5gnGwqzNb7UG6R16jO6FU/DMsm
         mPG6XmevtQmms7syIAgLWGZ3fTY2l0ruQiWxlyTZVKVHVAEiwErh689fex1YaHwa+W0z
         Vw7d6Nl+UnG+fvtl2qvcOJBpvV0tArchi0GdXxLbSAKJ7N8ovR1rMIjdlXthDvppNqY2
         K2BfIrEz7VyKuyUL+pgWbLTI5xsLxJ4ZeEG6TEbYnLoE8M6QqVgi+PrfgUNVG61edWEb
         QltzROBXEOFGNecVugcPDfLXPSA3x2tR49K4N5ld55JE0sWKO6lhgq8I3sFMh5mOqoDc
         PRrw==
X-Gm-Message-State: APjAAAVB89+c04uRJEJDh7f4AV/hnIWP7EyjP2TH54JIcx9vyIREobBZ
        hkVzNPYxIy8t/H6Hw42z0RaG
X-Google-Smtp-Source: APXvYqwqK2deXjgneC4tJPgel+d3O7JA1/h4LlAF/xl3gkQy8XD9LK1JHI+ZadItk89DPE8MFlKFTw==
X-Received: by 2002:a17:90a:23c8:: with SMTP id g66mr3038864pje.123.1566355240941;
        Tue, 20 Aug 2019 19:40:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] clk: actions: Fix factor clk struct member access
Date:   Wed, 21 Aug 2019 08:10:08 +0530
Message-Id: <20190821024014.14070-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since the helper "owl_factor_helper_round_rate" is shared between factor
and composite clocks, using the factor clk specific helper function
like "hw_to_owl_factor" to access its members will create issues when
called from composite clk specific code. Hence, pass the "factor_hw"
struct pointer directly instead of fetching it using factor clk specific
helpers.

This issue has been observed when a composite clock like "sd0_clk" tried
to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
error.

While we are at it, let's rename the "clk_val_best" function to
"owl_clk_val_best" since this is an owl SoCs specific helper.

Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/actions/owl-factor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
index 317d4a9e112e..f15e2621fa18 100644
--- a/drivers/clk/actions/owl-factor.c
+++ b/drivers/clk/actions/owl-factor.c
@@ -64,11 +64,10 @@ static unsigned int _get_table_val(const struct clk_factor_table *table,
 	return val;
 }
 
-static int clk_val_best(struct clk_hw *hw, unsigned long rate,
+static int owl_clk_val_best(const struct owl_factor_hw *factor_hw,
+			struct clk_hw *hw, unsigned long rate,
 			unsigned long *best_parent_rate)
 {
-	struct owl_factor *factor = hw_to_owl_factor(hw);
-	struct owl_factor_hw *factor_hw = &factor->factor_hw;
 	const struct clk_factor_table *clkt = factor_hw->table;
 	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
 	unsigned long parent_rate_saved = *best_parent_rate;
@@ -126,7 +125,7 @@ long owl_factor_helper_round_rate(struct owl_clk_common *common,
 	const struct clk_factor_table *clkt = factor_hw->table;
 	unsigned int val, mul = 0, div = 1;
 
-	val = clk_val_best(&common->hw, rate, parent_rate);
+	val = owl_clk_val_best(factor_hw, &common->hw, rate, parent_rate);
 	_get_table_div_mul(clkt, val, &mul, &div);
 
 	return *parent_rate * mul / div;
-- 
2.17.1

