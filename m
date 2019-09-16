Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E5B3DEB
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Sep 2019 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfIPPqX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Sep 2019 11:46:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42064 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389351AbfIPPqX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2019 11:46:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so219460pgp.9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2019 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=M5RVRQtcNRNLU3Ce3wJub13vbJguuHeWcsX6869rW9uUNvO3oDGO+dG4akmpsUmnwS
         25PYYsfU3gW6VKNqgZ1lkVtZ6xaOgA7rp1CpRc9TWjzr/nuXjljUOcreI2mbqzeauhzz
         USnKKVodkIcVBGx4qlAdeCd9A4x8ZMPhwmRo5jrJb0F9b3pDX98q88l31hVbaCa2xMbX
         8BFGpiisTg6Crzk14UeBSg6OwTc4CmsWyFtRQgoMJKg7PSdET2OQMWt2e26dsJ/7Sv2Y
         uoYrIwt1W6o1JBINl4aLs1OcGbc0Q0LrcxvUFE09NT/VFnTL/69tctyPGnxzz6oIJT9y
         XhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=i7Eim7orckOpGyrokj8kZ0N0fAzuVZtt0Rl8HfroIuY5JCAq2VvXqvD24LKslN52Az
         ryVIRk1Ol+BIAdkndrOP5req2v+PKnrmrHZ27JR00t+MxZjDyOKc+85YlPa3spDoft2O
         sxh2hPoxoBw0QpGVOxhjP7jJI1Uh+/xOfA/97ss78sFCBSSsYHu1s+SryCl+hFU+B2DK
         fFyJCujjrp/NVu6kGsGiyj3WRQGxIwaKfH/+VRwu38a1KV9fZCKDutNjnaVQwJDja9qe
         aAMHUyRZITEd/3Ojoe7iW6r2AKdk8VA2DkXYsvSLcVhllC18wRWeBBxo1DD2ZoBIbrrA
         wjCw==
X-Gm-Message-State: APjAAAVPp5NBMyeu2bgdjmQuHrDrrk1KVu9pyREc9lMQ7fw4NA8cUB5h
        YbHtoE7snX8xkybvtk52rwPs
X-Google-Smtp-Source: APXvYqysfDcCptETjMW/S/qMH4c/coJa64VGrwt2nMp6xw1D34MZvm+EGbIcXKxRSbmamm8V0sqSHw==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr55987727pgc.20.1568648782559;
        Mon, 16 Sep 2019 08:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/7] clk: actions: Fix factor clk struct member access
Date:   Mon, 16 Sep 2019 21:15:40 +0530
Message-Id: <20190916154546.24982-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
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

