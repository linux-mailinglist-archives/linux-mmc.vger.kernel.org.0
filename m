Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3988B4C5
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Aug 2019 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfHMKAb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 13 Aug 2019 06:00:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51572 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728410AbfHMKAb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Aug 2019 06:00:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D9v0oJ019980;
        Tue, 13 Aug 2019 12:00:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=zMT76XrZdrJ/EPXAeRIWxjFDs506pA3po4wu+4Lf2cc=;
 b=jJ1flULglu5ROI6e/7eE+t0Qlt0I+d2imZvZk5MNfneS0nk474Lb6oa2a8nMafRsj9XE
 /jFHCU8WbUW0pdovk6eJ54J0K0HIClB6f1LTZ7/lMo2fwkgKfc+BUh3HoEcKSo08cVpo
 LYkgkWvCR3SOqF7jQ0MqPI5QlSlRo+hh3wA6f9JB85BkLr8R1S73XQgUe1HTo4dOURRh
 7PCGpnFnppmi2U9sI57dRk0qqi20o2SBecMN24w1XCDiL07UffP1obFPEPVnPJ21BtWG
 LGfwQyi3zlUm+u6cVuE1MlFEH6C7Qkz7ZRyXDFEuDuP/hUqEdiqneU5yhwkbyP2/nmSB RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u9mtky9uq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Aug 2019 12:00:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37B7E38;
        Tue, 13 Aug 2019 10:00:14 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2771A2CC9D2;
        Tue, 13 Aug 2019 12:00:14 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 12:00:13 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 12:00:12 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V5 1/3] mmc: mmci: add hardware busy timeout feature
Date:   Tue, 13 Aug 2019 11:59:49 +0200
Message-ID: <20190813095951.26275-2-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813095951.26275-1-ludovic.Barre@st.com>
References: <20190813095951.26275-1-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_04:,,
 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

In some variants, the data timer starts and decrements
when the DPSM enters in Wait_R or Busy state
(while data transfer or MMC_RSP_BUSY), and generates a
data timeout error if the counter reach 0.

-Define max_busy_timeout (in ms) according to clock.
-Set data timer register if the command has rsp_busy flag.
 If busy_timeout is not defined by framework, the busy
 length after Data Burst is defined as 1 second
 (refer: 4.6.2.2 Write of sd specification part1 v6-0).
-Add MCI_DATATIMEOUT error management in mmci_cmd_irq.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  3 +++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c37e70dbe250..c50586540765 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1075,6 +1075,7 @@ static void
 mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
+	unsigned long long clks = 0;
 
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
@@ -1097,6 +1098,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		else
 			c |= host->variant->cmdreg_srsp;
 	}
+
+	if (host->variant->busy_timeout && !host->mrq->data) {
+		if (cmd->flags & MMC_RSP_BUSY) {
+			if (!cmd->busy_timeout)
+				cmd->busy_timeout = 1000;
+
+			clks = (unsigned long long)cmd->busy_timeout;
+			clks *=	host->cclk;
+			do_div(clks, MSEC_PER_SEC);
+		}
+		writel_relaxed(clks, host->base + MMCIDATATIMER);
+	}
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1203,6 +1217,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 {
 	void __iomem *base = host->base;
 	bool sbc, busy_resp;
+	u32 err_msk;
 
 	if (!cmd)
 		return;
@@ -1215,8 +1230,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	 * handling. Note that we tag on any latent IRQs postponed
 	 * due to waiting for busy status.
 	 */
-	if (!((status|host->busy_status) &
-	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
+	err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
+	if (host->variant->busy_timeout && busy_resp)
+		err_msk |= MCI_DATATIMEOUT;
+
+	if (!((status | host->busy_status) &
+	      (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
 		return;
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
@@ -1235,8 +1254,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * while, to allow it to be set, but tests indicates that it
 		 * isn't needed.
 		 */
-		if (!host->busy_status &&
-		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
+		if (!host->busy_status && !(status & err_msk) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
 			writel(readl(base + MMCIMASK0) |
@@ -1290,6 +1308,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else if (host->variant->busy_timeout && busy_resp &&
+		   status & MCI_DATATIMEOUT) {
+		cmd->error = -ETIMEDOUT;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1948,6 +1969,8 @@ static int mmci_probe(struct amba_device *dev,
 	 * Enable busy detection.
 	 */
 	if (variant->busy_detect) {
+		u32 max_busy_timeout = 0;
+
 		mmci_ops.card_busy = mmci_card_busy;
 		/*
 		 * Not all variants have a flag to enable busy detection
@@ -1957,7 +1980,11 @@ static int mmci_probe(struct amba_device *dev,
 			mmci_write_datactrlreg(host,
 					       host->variant->busy_dpsm_flag);
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
-		mmc->max_busy_timeout = 0;
+
+		if (variant->busy_timeout)
+			max_busy_timeout = ~0UL / (mmc->f_max / MSEC_PER_SEC);
+
+		mmc->max_busy_timeout = max_busy_timeout;
 	}
 
 	/* Prepare a CMD12 - needed to clear the DPSM on some variants. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 833236ecb31e..d8b7f6774e8f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -287,6 +287,8 @@ struct mmci_host;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_timeout: true if the variant starts data timer when the DPSM
+ *		  enter in Wait_R or Busy state.
  * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
  * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
  *		      indicating that the card is busy
@@ -333,6 +335,7 @@ struct variant_data {
 	u8			signal_direction:1;
 	u8			pwrreg_clkgate:1;
 	u8			busy_detect:1;
+	u8			busy_timeout:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-- 
2.17.1

