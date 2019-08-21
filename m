Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33896FCF
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHUC4w (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:56:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40529 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfHUC4w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:56:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so490215pls.7
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=aABCInNix2J6e7HF4fvEuYdfPtOj7yi3+jBRArEzJDf4aafZ2Ya4C+W1j2S5Md9TSx
         /yi/W6AgbXxfHF5mD/0/dFnswnFKNhOqDpclsLoqR8lEqTvp4MBGyFbeN8B4y7yp21qb
         MZXqFWO4v3gk1rdrKNogftXfbH4IRIJicTGZZllZJyuFr8Vy8lhtWIdzEkHq8WFS5V/J
         dQbnNm9Tt56q6SL4w9Hiw3pxtObzputeTinFIye4JGdn6LSaffY/LgIQG/2QyttgmpBc
         JzMXdRaGT9iay1Sn/hbgP0GZvVZDBdOXIjl5u1HN8gY3JUTYGnRnnruISYy9oaT4ATkb
         UyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=C6A8v87Vlt884gNq+QktOo4dMcegepnJRcydsQqv+3WuICsx4GGF/F72iM2rat1jqv
         ATX1z7AhxnrhokTWyk7ThUIpsgJmdKcdzjQ0uY7XxIz7L8vwnzJEVWoBnoQignNXgoOr
         GelgcguGRGlf4UWVi/NHUtETwpERWtNCCr54zVNg9M4iszOhD9tYZ7F9UB7QkdiaAXbO
         GGV3l7sOvj+MGqWvq7VPcv+jyzuXwZYBPVYoSmNsl59vEkiK9z/auQcBNflNgvc/BWo2
         4MidH7/M6qS+byTQ0/C7X4+FvnWRaIosFRtRxvsQLHssFRNla6OlzfuiWYZxr9q6ed+6
         5Mlw==
X-Gm-Message-State: APjAAAVMIVLkJPN7Bl3fiREBDFdXGL+qcHw0zT8JnYnTs0W3/Wh1+Ha2
        ehCIMF1XRBH+Eps0qXKIde5C
X-Google-Smtp-Source: APXvYqz/D9TK9ocC2hxlw7TCgv5eGRysLPMZA6XeB/qEjTGNGia88h08J6CCNlGAEU6PX2oWTrC8nA==
X-Received: by 2002:a17:902:b588:: with SMTP id a8mr19709561pls.15.1566356211322;
        Tue, 20 Aug 2019 19:56:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:56:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/7] clk: actions: Fix factor clk struct member access
Date:   Wed, 21 Aug 2019 08:26:23 +0530
Message-Id: <20190821025629.15470-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

