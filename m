Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460FD1E2605
	for <lists+linux-mmc@lfdr.de>; Tue, 26 May 2020 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgEZPv0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 May 2020 11:51:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11144 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgEZPvZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2020 11:51:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFlssq011536;
        Tue, 26 May 2020 17:51:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=28hj2+Ej7SBWOqluQzlr/PMyBCU9CRAkIHe/tLkVNjw=;
 b=GsZVjXqn0Y5Ge/pr/QFhJzOz8y4IeQERAqhaB5m/gsKRQxujdzB33xHgiwM9K51iuGS4
 DW7pk8lFiedObiO4JHPsj059bGMVenSStqc4e3oL9JIvZHSTV6EBaP3TgYEdS+MccqeW
 m7DDAF3mMkWeAymHb85hwMac43XfltluXXK76UnEuX8CwFwjoIW/fvZ8P8pUqDVvkm4A
 nwTZB2N32AMILtpuTOlMcyrZZdcs/QTTnMJzVOhLXCGz2uDfd+XEbvSpuW02XBz5kSH7
 fRMCPg6uKvjevAXKLqOGF+TKMP2fN+itYJaqz/nxYuoC2xPdCGW6eL3EP4EPlNga2kuv ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa20kgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:51:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE1B610002A;
        Tue, 26 May 2020 17:51:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CDE3E2C4B36;
        Tue, 26 May 2020 17:51:12 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May 2020 17:51:12
 +0200
From:   Ludovic Barre <ludovic.barre@st.com>
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
Subject: [PATCH 1/2] mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
Date:   Tue, 26 May 2020 17:51:02 +0200
Message-ID: <20200526155103.12514-2-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526155103.12514-1-ludovic.barre@st.com>
References: <20200526155103.12514-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
WARNING: CPU: 1 PID: 20 at kernel/dma/debug.c:500 add_dma_entry+0x16c/0x17c
DMA-API: exceeded 7 overlapping mappings of cacheline 0x031d2645
Modules linked in:
CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.5.0-rc2-00021-gdeda30999c2b-dirty #49
Hardware name: STM32 (Device Tree Support)
Workqueue: events_freezable mmc_rescan
[<c03138c0>] (unwind_backtrace) from [<c030d760>] (show_stack+0x10/0x14)
[<c030d760>] (show_stack) from [<c0f2eb28>] (dump_stack+0xc0/0xd4)
[<c0f2eb28>] (dump_stack) from [<c034a14c>] (__warn+0xd0/0xf8)
[<c034a14c>] (__warn) from [<c034a530>] (warn_slowpath_fmt+0x94/0xb8)
[<c034a530>] (warn_slowpath_fmt) from [<c03bca0c>] (add_dma_entry+0x16c/0x17c)
[<c03bca0c>] (add_dma_entry) from [<c03bdf54>] (debug_dma_map_sg+0xe4/0x3d4)
[<c03bdf54>] (debug_dma_map_sg) from [<c0d09244>] (sdmmc_idma_prep_data+0x94/0xf8)
[<c0d09244>] (sdmmc_idma_prep_data) from [<c0d05a2c>] (mmci_prep_data+0x2c/0xb0)
[<c0d05a2c>] (mmci_prep_data) from [<c0d073ec>] (mmci_start_data+0x134/0x2f0)
[<c0d073ec>] (mmci_start_data) from [<c0d078d0>] (mmci_request+0xe8/0x154)
[<c0d078d0>] (mmci_request) from [<c0cecb44>] (mmc_start_request+0x94/0xbc)

DMA api debug brings to light leaking dma-mappings, dma_map_sg and
dma_unmap_sg are not correctly balanced.

If a request is prepared, the dma_map/unmap are done in asynchronous
call pre_req (prep_data) and post_req (unprep_data). In this case
the dma-mapping is right balanced.

But if the request was not prepared, the data->host_cookie is
define to zero and the dma_map/unmap must be done in the request.
The dma_map is called by mmci_dma_start (prep_data), but there is
no dma_unmap in this case.

This patch adds dma_unmap_sg when the dma is finalized and
the data cookie is zero (request not prepared).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 14f99d8aa3f0..2965b1c062e1 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -188,6 +188,9 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+
+	if (!data->host_cookie)
+		sdmmc_idma_unprep_data(host, data, 0);
 }
 
 static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
-- 
2.17.1

