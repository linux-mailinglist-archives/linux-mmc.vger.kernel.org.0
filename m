Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212C58B4C9
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Aug 2019 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfHMKAd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 13 Aug 2019 06:00:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728472AbfHMKAc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Aug 2019 06:00:32 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D9vEqw021952;
        Tue, 13 Aug 2019 12:00:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=aoyRokR5kzUkomjm7Ywbps3L0Afaxia9MCls/Ada1gA=;
 b=Cs9uCuurKtt/S7y9CqRY/NdQTCF7vinymf4wbVL/pujdLkggXqyEmfaCYq7NlKa7vieG
 3m6H9UQdeNE2MjSEf6fM1OTqS3pNFAi20VJfo6vaCO0lH6CySonZqnccBEfz2cSmRgLq
 v9wFE4fod6B5bJUJBlieoZWe+9paVL+Xgu2jj2ktY5HpVK32l9NGMA0ko4ACjC0LMMMn
 mz04VOllLb2iq5m/0V7iVvkPLLO3557lDgQl7PnX95nYzbrz6O3VxWnmp89+FtxRyIul
 MDDnmiUQqQc8+/a6h+B2KveWZQlN5kIg9awAseoBtv1RflULRJ1GmaPqzxHsP52K9kME GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u9kpuqdd0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Aug 2019 12:00:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B79C42;
        Tue, 13 Aug 2019 10:00:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 163D52CC9D1;
        Tue, 13 Aug 2019 12:00:11 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 12:00:10 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 12:00:07 +0200
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
Subject: [PATCH V5 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Tue, 13 Aug 2019 11:59:48 +0200
Message-ID: <20190813095951.26275-1-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
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

This patch series adds busy detect for stm32 sdmmc variant.
Some adaptations are required:
-On sdmmc the data timer is started on data transfert
and busy state, so we must add hardware busy timeout support.
-Add busy_complete callback at mmci_host_ops to allow to define
a specific busy completion by variant.
-Add sdmmc busy_complete calback.

V5:
-Replaces !cmd->data to !host->mrq->data to avoid overwrite
 of datatimer register by the first command (cmd23, without data) of
 SBC request.

V4:
-Re-work with busy_complete callback
-In series, move "mmc: mmci: add hardware busy timeout feature" in
first to simplify busy_complete prototype with err_msk parameter.

V3:
-rebase on latest mmc next
-replace re-read by status parameter. 

V2:
-mmci_cmd_irq cleanup in separate patch.
-simplify the busy_detect_flag exclude
-replace sdmmc specific comment in
"mmc: mmci: avoid fake busy polling in mmci_irq"
to focus on common behavior

Ludovic Barre (3):
  mmc: mmci: add hardware busy timeout feature
  mmc: mmci: add busy_complete callback
  mmc: mmci: sdmmc: add busy_complete callback

 drivers/mmc/host/mmci.c             | 178 +++++++++++++++++-----------
 drivers/mmc/host/mmci.h             |   7 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c |  38 ++++++
 3 files changed, 151 insertions(+), 72 deletions(-)

-- 
2.17.1

