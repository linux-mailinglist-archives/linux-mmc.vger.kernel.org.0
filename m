Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855BF136E8F
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Jan 2020 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgAJNtK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 Jan 2020 08:49:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45013 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727734AbgAJNtJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADlv1C031938;
        Fri, 10 Jan 2020 14:49:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=2rv368pE4g4zz6kp57DPDD0CXhY4gWUUealEUKO5UXo=;
 b=tGZWjzq6gmURDGy/RZyFBmHTnznoiMQXTOM3m7qoVdNeZreVSZCIFgc0KDnPVRudiTMP
 ddH63AhNU/c8mqHF0uUhq95+6yCrlDi5Ex1gAqHB81X8X8XCCxEcWZZhb7tTvWeX1b+e
 hroPNgzEEcVZUVwiY8gD5DMfHNPHtV9TPhsH0yyYUdjC9ETCmG0WUdo0oZfzFpGslJcP
 rhNaiH6+ybPPbTLILVlgD5/6dUAM/lMws/hHH/ebonMfEe6kki2cB0fKQlHlnCCPeeFc
 ZOennkDslmBPtL+TNQVJ47Fbpz/wEYdBu+Gdf7l1DQpj51E9vp2FvjCu1T5SZZPNEAfL Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur7dtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EA7510002A;
        Fri, 10 Jan 2020 14:49:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EFCC2BC7D1;
        Fri, 10 Jan 2020 14:49:01 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:49:00
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
Subject: [PATCH 4/9] mmc: mmci: add private pointer for variant
Date:   Fri, 10 Jan 2020 14:48:18 +0100
Message-ID: <20200110134823.14882-5-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In variant init function, some references may be allocated for
variant specific usage. Add a private void* to mmci_host struct
allows at variant functions to access on this references by
mmci_host structure.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 55acc0971a44..ddcdfb827996 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -410,6 +410,7 @@ struct mmci_host {
 	struct mmc_host_ops	*mmc_ops;
 	struct mmci_host_ops	*ops;
 	struct variant_data	*variant;
+	void			*variant_priv;
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pins_opendrain;
 
-- 
2.17.1

