Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD73A78D8
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfIDCgF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 22:36:05 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:37254 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDCgD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 22:36:03 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 22:36:02 EDT
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.177])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0803063E54;
        Wed,  4 Sep 2019 10:28:27 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10084T140370216199936S1567564098828954_;
        Wed, 04 Sep 2019 10:28:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fd477a8e067e3326f6773ed9a13e4d86>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: Using 180 sample phase if all phases work
Date:   Wed,  4 Sep 2019 10:27:10 +0800
Message-Id: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

default_sample_phase is used to make sure the cards are enumurated
properly and will be set to 0 if not assigned. However, the sample
phase should depends on the tuned phase if running higher clock rate.
If all phases work but default_sample_phase isn't assigned, driver
set sample phase to 0 for this case, which isn't the best choice,
because we always expect to set phase to the middle of window. To
solve the following continually issues we have seen in the test, we
need set phase to the more stable one, 180, if all phases work.

mmcblk1: error -84 transferring data, sector 1735064, nr 8, cmd
response 0x900, card status 0xb00
mmcblk1: retrying using single block read
dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
mmcblk1: retrying because a re-tune was needed

.....

mmcblk1: error -84 transferring data, sector 1728672, nr 248, cmd
response 0x900, card status 0xb00
mmcblk1: retrying using single block read
dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index d4d0213..9ef9723 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -209,9 +209,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	}
 
 	if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
-		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
-		dev_info(host->dev, "All phases work, using default phase %d.",
-			 priv->default_sample_phase);
+		clk_set_phase(priv->sample_clk, 180);
+		dev_info(host->dev, "All phases work, using phase 180.");
 		goto free;
 	}
 
-- 
1.9.1



