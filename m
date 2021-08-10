Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B43D9CE9
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Jul 2021 06:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhG2Erl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Jul 2021 00:47:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:54973 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhG2Erl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2021 00:47:41 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 28 Jul 2021 21:47:38 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Jul 2021 21:47:36 -0700
X-QCInternal: smtphost
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg02-blr.qualcomm.com with ESMTP; 29 Jul 2021 10:17:29 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 7DF9B35F9; Thu, 29 Jul 2021 10:17:27 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V2 2/2] mmc: sdhci-msm: Use maximum possible data timeout value
Date:   Thu, 29 Jul 2021 10:16:41 +0530
Message-Id: <1627534001-17256-3-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627534001-17256-1-git-send-email-sartgarg@codeaurora.org>
References: <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
 <1627534001-17256-1-git-send-email-sartgarg@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

The Qcom SD controller defines the usage of 0xF in data
timeout counter register (0x2E) which is actually a reserved
bit as per specification. This would result in maximum of 21.26 secs
timeout value.

Some SDcard taking more time than 2.67secs (timeout value corresponding
to 0xE) and with that observed data timeout errors.
So increasing the timeout value to max possible timeout.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e44b7a6..19e4673 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2696,6 +2696,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 
+	/* Set the timeout value to max possible */
+	host->max_timeout_count = 0xF;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.7.4

