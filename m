Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F98628CF0
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Nov 2022 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiKNXCf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 14 Nov 2022 18:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiKNXC3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2022 18:02:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD6A1A22B;
        Mon, 14 Nov 2022 15:02:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5817461495;
        Mon, 14 Nov 2022 23:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F4C4314F;
        Mon, 14 Nov 2022 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466947;
        bh=ImluY7K1mzyE5Sw9HQCSxJdpuWkFURiyri1as01p1O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QErMp37RVXHvJ5igimaw2eIfWT+3ERYfIW4lS6++DJPA9j1K77rVk6kjHOVCr8CPs
         lWRrJApEGyiLyAdNxtypP/ONj/Q6/h2KvXNalddguqJmzbIydYehFeGFo2cHYruGcP
         zWy7jLNB8P4O9rceaSba2iwBiwlf8RAWYo9PvOYYAXA8ISDZMZ0HrFxOwz1DPIX3c9
         Bem1xcmNmjgWT/g+4hpLqipy/iK0Bc5vikzvAwSIXNYrXgVu+5lX4y6+higkYKKH2A
         t+qbmdJheUxjvU+n4M8AFNLRNBXJJahjU992wJ2WP1td6M7ye6QZnztl7kmpqZQ3iV
         +DwY5wtubGJBA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv9 5/6] clk: socfpga: remove the setting of clk-phase for sdmmc_clk
Date:   Mon, 14 Nov 2022 17:02:16 -0600
Message-Id: <20221114230217.202634-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114230217.202634-1-dinguyen@kernel.org>
References: <20221114230217.202634-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Now that the SDMMC driver supports setting the clk-phase, we can remove
the need to do it in the clock driver.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v9: no changes
v8: no changes
v7: add acked-by
v6: remove unused clk_phase in clk-gate.c
v5: new
---
 drivers/clk/socfpga/clk-gate-a10.c | 68 ------------------------------
 drivers/clk/socfpga/clk-gate.c     | 61 ---------------------------
 drivers/clk/socfpga/clk.h          |  1 -
 3 files changed, 130 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-gate-a10.c
index 738c53391e39..7cdf2f07c79b 100644
--- a/drivers/clk/socfpga/clk-gate-a10.c
+++ b/drivers/clk/socfpga/clk-gate-a10.c
@@ -35,59 +35,7 @@ static unsigned long socfpga_gate_clk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
-static int socfpga_clk_prepare(struct clk_hw *hwclk)
-{
-	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
-	int i;
-	u32 hs_timing;
-	u32 clk_phase[2];
-
-	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
-		for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
-			switch (socfpgaclk->clk_phase[i]) {
-			case 0:
-				clk_phase[i] = 0;
-				break;
-			case 45:
-				clk_phase[i] = 1;
-				break;
-			case 90:
-				clk_phase[i] = 2;
-				break;
-			case 135:
-				clk_phase[i] = 3;
-				break;
-			case 180:
-				clk_phase[i] = 4;
-				break;
-			case 225:
-				clk_phase[i] = 5;
-				break;
-			case 270:
-				clk_phase[i] = 6;
-				break;
-			case 315:
-				clk_phase[i] = 7;
-				break;
-			default:
-				clk_phase[i] = 0;
-				break;
-			}
-		}
-
-		hs_timing = SYSMGR_SDMMC_CTRL_SET_AS10(clk_phase[0], clk_phase[1]);
-		if (!IS_ERR(socfpgaclk->sys_mgr_base_addr))
-			regmap_write(socfpgaclk->sys_mgr_base_addr,
-				     SYSMGR_SDMMCGRP_CTRL_OFFSET, hs_timing);
-		else
-			pr_err("%s: cannot set clk_phase because sys_mgr_base_addr is not available!\n",
-					__func__);
-	}
-	return 0;
-}
-
 static struct clk_ops gateclk_ops = {
-	.prepare = socfpga_clk_prepare,
 	.recalc_rate = socfpga_gate_clk_recalc_rate,
 };
 
@@ -96,7 +44,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
 {
 	u32 clk_gate[2];
 	u32 div_reg[3];
-	u32 clk_phase[2];
 	u32 fixed_div;
 	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
@@ -136,21 +83,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
 		socfpga_clk->div_reg = NULL;
 	}
 
-	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
-	if (!rc) {
-		socfpga_clk->clk_phase[0] = clk_phase[0];
-		socfpga_clk->clk_phase[1] = clk_phase[1];
-
-		socfpga_clk->sys_mgr_base_addr =
-			syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-		if (IS_ERR(socfpga_clk->sys_mgr_base_addr)) {
-			pr_err("%s: failed to find altr,sys-mgr regmap!\n",
-					__func__);
-			kfree(socfpga_clk);
-			return;
-		}
-	}
-
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	init.name = clk_name;
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 53d6e3ec4309..3e347b9e9eff 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -108,61 +108,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 	return parent_rate / div;
 }
 
-static int socfpga_clk_prepare(struct clk_hw *hwclk)
-{
-	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
-	struct regmap *sys_mgr_base_addr;
-	int i;
-	u32 hs_timing;
-	u32 clk_phase[2];
-
-	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
-		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-		if (IS_ERR(sys_mgr_base_addr)) {
-			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
-			return -EINVAL;
-		}
-
-		for (i = 0; i < 2; i++) {
-			switch (socfpgaclk->clk_phase[i]) {
-			case 0:
-				clk_phase[i] = 0;
-				break;
-			case 45:
-				clk_phase[i] = 1;
-				break;
-			case 90:
-				clk_phase[i] = 2;
-				break;
-			case 135:
-				clk_phase[i] = 3;
-				break;
-			case 180:
-				clk_phase[i] = 4;
-				break;
-			case 225:
-				clk_phase[i] = 5;
-				break;
-			case 270:
-				clk_phase[i] = 6;
-				break;
-			case 315:
-				clk_phase[i] = 7;
-				break;
-			default:
-				clk_phase[i] = 0;
-				break;
-			}
-		}
-		hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
-		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-			hs_timing);
-	}
-	return 0;
-}
-
 static struct clk_ops gateclk_ops = {
-	.prepare = socfpga_clk_prepare,
 	.recalc_rate = socfpga_clk_recalc_rate,
 	.get_parent = socfpga_clk_get_parent,
 	.set_parent = socfpga_clk_set_parent,
@@ -172,7 +118,6 @@ void __init socfpga_gate_init(struct device_node *node)
 {
 	u32 clk_gate[2];
 	u32 div_reg[3];
-	u32 clk_phase[2];
 	u32 fixed_div;
 	struct clk_hw *hw_clk;
 	struct socfpga_gate_clk *socfpga_clk;
@@ -218,12 +163,6 @@ void __init socfpga_gate_init(struct device_node *node)
 		socfpga_clk->div_reg = NULL;
 	}
 
-	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
-	if (!rc) {
-		socfpga_clk->clk_phase[0] = clk_phase[0];
-		socfpga_clk->clk_phase[1] = clk_phase[1];
-	}
-
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	init.name = clk_name;
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
index d80115fbdd6a..9a2fb2dde5b8 100644
--- a/drivers/clk/socfpga/clk.h
+++ b/drivers/clk/socfpga/clk.h
@@ -50,7 +50,6 @@ struct socfpga_gate_clk {
 	u32 width;	/* only valid if div_reg != 0 */
 	u32 shift;	/* only valid if div_reg != 0 */
 	u32 bypass_shift;      /* only valid if bypass_reg != 0 */
-	u32 clk_phase[2];
 };
 
 struct socfpga_periph_clk {
-- 
2.25.1

