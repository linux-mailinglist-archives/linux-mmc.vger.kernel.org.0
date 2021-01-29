Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA5D308568
	for <lists+linux-mmc@lfdr.de>; Fri, 29 Jan 2021 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhA2F7x (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 29 Jan 2021 00:59:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42837 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229459AbhA2F7w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2021 00:59:52 -0500
X-UUID: d736d2dac6294db5bddfb9e9ff0ca9e2-20210129
X-UUID: d736d2dac6294db5bddfb9e9ff0ca9e2-20210129
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 756881680; Fri, 29 Jan 2021 13:59:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 13:59:02 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 13:59:01 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: enable crypto hardware engine
Date:   Fri, 29 Jan 2021 13:57:30 +0800
Message-ID: <20210129055730.29672-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F643E4D8A52540A16926E24EDAD3AEBDBDD5D9B21BA9F4EE6110F45D4BAD75512000:8
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use SMC call enable hardware crypto engine due to it only be control
in EL3.

Change-Id: I5c6c8c534442e030bc5a4de23a317049924a8852
Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 20 ++++++++++++++++++++
 drivers/mmc/host/mtk-sd.h | 11 +++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 drivers/mmc/host/mtk-sd.h

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e870afd66ae8..0387427b65a4 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -4,6 +4,7 @@
  * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -33,6 +34,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "cqhci.h"
+#include "mtk-sd.h"
 
 #define MAX_BD_NUM          1024
 #define MSDC_NR_CLOCKS      3
@@ -2467,6 +2469,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct msdc_host *host;
 	struct resource *res;
+	struct arm_smccc_res smccc_res;
 	int ret;
 
 	if (!pdev->dev.of_node) {
@@ -2612,6 +2615,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		/* 0 size, means 65536 so we don't have to -1 here */
 		mmc->max_seg_size = 64 * 1024;
 	}
+	/*
+	 * 1: MSDC_AES_CTL_INIT
+	 * 4: cap_id, no-meaning
+	 * 1: cfg_id, we choose the second cfg group
+	 */
+	if (mmc->caps2 & MMC_CAP2_CRYPTO)
+		arm_smccc_smc(MTK_SIP_MMC_CONTROL,
+			1, 4, 1, 0, 0, 0, 0, &smccc_res);
 
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
@@ -2770,6 +2781,15 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 
 	msdc_ungate_clock(host);
 	msdc_restore_reg(host);
+
+	/*
+	 * 1: MSDC_AES_CTL_INIT
+	 * 4: cap_id, no-meaning
+	 * 1: cfg_id, we choose the second cfg group
+	 */
+	if (mmc->caps2 & MMC_CAP2_CRYPTO)
+		arm_smccc_smc(MTK_SIP_MMC_CONTROL,
+			1, 4, 1, 0, 0, 0, 0, &smccc_res);
 	return 0;
 }
 
diff --git a/drivers/mmc/host/mtk-sd.h b/drivers/mmc/host/mtk-sd.h
new file mode 100755
index 000000000000..e9421ef7d880
--- /dev/null
+++ b/drivers/mmc/host/mtk-sd.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+
+/*
+ * SiP commands
+ */
+#define MTK_SIP_MMC_CONTROL               MTK_SIP_SMC_CMD(0x273)
-- 
2.18.0

