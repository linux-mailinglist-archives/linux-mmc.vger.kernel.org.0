Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4932DBC34
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Dec 2020 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgLPHrN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Dec 2020 02:47:13 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47570 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgLPHrN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 02:47:13 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG7fLn9009997;
        Tue, 15 Dec 2020 23:46:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=4JQngb4vTl2z5Km2Q0sbQvmvyYV/348D1o4EIdvAylU=;
 b=NPb5S7s6hYBD1HL61yH1+Aa/XnTifB5fFbr20+dGV80cQWXjlFSXK22fjfnzOuSxVUbM
 Pp4ODuZ97d0XpbhFz3AHpS8cShTDbgRFXcMbUzse3o4eiuv/zG374q+Z0Ug8Qe6oucay
 CA5qYAZr9nhHSZ0myEll4x93qraD46+1gbHefZCHMjfiy+06nNP+tqIdZH1myPL9lKOR
 6PRgHigjol1XRPlUScVEexEz58XgEFXz8LI4ZjFHPEUMDj0LFpreIm4jz5Do7X2ufu5x
 x5dlEeVTvg0jpd7GchHDAJdQiXq8ymknULRuoli83Nyk0m8AZ+v6T8/n3Q3Pu1g9gXv9 kw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tataf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:46:27 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 23:46:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 23:46:26 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 3DC163F703F;
        Tue, 15 Dec 2020 23:46:24 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <adrian.hunter@intel.com>, <mw@semihalf.com>, <jaz@semihalf.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: xenon: add AP807 compatible string
Date:   Wed, 16 Dec 2020 09:45:38 +0200
Message-ID: <20201216074540.30616-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216074540.30616-1-kostap@marvell.com>
References: <20201216074540.30616-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

This patch adds DT binding description for the Xenon
SD/MMC controller included in AP807 north bridge.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
index ed1456f5c94d..c51a62d751dc 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
@@ -12,6 +12,7 @@ Required Properties:
   - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SoC.
   Must provide a second register area and marvell,pad-type.
   - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
+  - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
   - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
 
 - clocks:
-- 
2.17.1

