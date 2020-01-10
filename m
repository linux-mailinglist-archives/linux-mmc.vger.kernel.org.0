Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29837136EAE
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Jan 2020 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgAJNtg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 Jan 2020 08:49:36 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17204 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727641AbgAJNtK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:10 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADm1BU013173;
        Fri, 10 Jan 2020 14:48:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=osJmv1TofsLiqLia+94YgpW5rj8JhzwPxMGK3NL9Llg=;
 b=NvDIzwRF0aOr30ToKAQhM5i7mH5PaS3NmVgue8zbeTb5SOLRFKxKvQMyBzxcneiZHlNp
 99j4ODpZA6InjXwpROIl76F8IQzKuJlmSfHIZjDgIkC3Wm4jOx7v5zC+SXN8rLPK76mZ
 AzJMTLipQyIOsRlULGlboJULI+9mY+y5go1fm8MO+oGPnNbL7fl2jcy6VXQfr6f71J+L
 x6Bg5JM+TaMZd0iPal2HOoBCWtvbV8dO/26TtZIw6MO1IKepOsVysOOe7sAbOE8tLcL1
 nj3a9d2SqJ8/Uxn2Uw71hnruJsC2EaDr6t99xM/Z7+LRman0Nh01RY2Omf/daysTE6PV pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xepyt8w05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:48:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0A8D10002A;
        Fri, 10 Jan 2020 14:48:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E39B72BC7C9;
        Fri, 10 Jan 2020 14:48:57 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:48:57
 +0100
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
Subject: [PATCH 1/9] mmc: mmci: sdmmc: replace sg_dma_xxx macros
Date:   Fri, 10 Jan 2020 14:48:15 +0100
Message-ID: <20200110134823.14882-2-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sg_dma_xxx should be used after a dma_map_sg call has been done
to get bus addresses of each of the SG entries and their lengths.
But mmci_host_ops validate_data can be called before dma_map_sg.
This patch replaces theses macros by sg->offset and sg->length
which are always defined.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index a4f7e8e689d3..6ccfbbc82c77 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -36,8 +36,8 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 	 * excepted the last element which has no constraint on idmasize
 	 */
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
-		if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32)) ||
-		    !IS_ALIGNED(sg_dma_len(data->sg), SDMMC_IDMA_BURST)) {
+		if (!IS_ALIGNED(data->sg->offset, sizeof(u32)) ||
+		    !IS_ALIGNED(data->sg->length, SDMMC_IDMA_BURST)) {
 			dev_err(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
@@ -45,7 +45,7 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 		}
 	}
 
-	if (!IS_ALIGNED(sg_dma_address(data->sg), sizeof(u32))) {
+	if (!IS_ALIGNED(data->sg->offset, sizeof(u32))) {
 		dev_err(mmc_dev(host->mmc),
 			"unaligned last scatterlist: ofst:%x length:%d\n",
 			data->sg->offset, data->sg->length);
-- 
2.17.1

