Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B594CDA56A
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404767AbfJQGWH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 02:22:07 -0400
Received: from mail-eopbgr770049.outbound.protection.outlook.com ([40.107.77.49]:23431
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389411AbfJQGWH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Oct 2019 02:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkGZ2MAQiq7jSgewGxYvolRSKK0Y92peUFy3py8BrRwA9+xMvDaYjhLpSAzQXh1f8eSh27Qf+dF0xAmnxvNhOFtGueKaboOvRVewP+ECDjtHSreeshl6ocmgeVPauUja6egebVVRnYt+cW7XrsNzfKyaSZ8gEkwVzrcHNMTnjJ8Mcj5zavjKtHWKuMNl1VAmEjJML3wtmUba0kkD5s0zemQDdWEgTIahq2pOeoHkt/FaugSOhL5gkml65Ya9WoEYuWJV1WjlVtjKtzDZZdPNnWW1rNYcZUlbixJFgwn6eXxp2wF70TJHLhrugMjSl/ip6Jkrq7Zk5w0a2uUOFOYwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXoPYeaz6IJVGbGlZ6HkOSNYtTLoVxVYczxjp4u62TI=;
 b=m/kT5YLg0gQI/TnGCl9EJ15RHdEobb9gtm34+zSY+O7fbRHtsLTd1UCkQFMOuBwl9D2in9sTXyUlV0KotHsAd2Xjz35Bx7wdOqOlMroeCbtmzDWId5Ff1ysL3SfPFeP1Zdi6O84KUbNFefoL6aVjnEy/pxrm9s9vyEctGGHpaJblVBJ6ikMHG1z49Cir+n3d507yBjVLjmAGaCBu9pn1xu7R4D+3JXn3gRaxlP/Ihnweh6dikElkUXA1PrtGqm3VIV7R8UhRL0yj45QjQnSTNcQ4rBdyLK9IRzYSaAItWLWHkucCU/CFrbWKLxuZJGND/4SezBr5NyMRZwzSjyiEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXoPYeaz6IJVGbGlZ6HkOSNYtTLoVxVYczxjp4u62TI=;
 b=mCIhriplcResGZ0NkbHseO3Re/50MD+DVouIFk7DX1vWeYxVnZtUNpBhAwPn48gw7ommjzcQcgiKLE+Ny1/UBk1Skj1zGTGRNCTatQAGQxynLXVUzqABHH9f+FZUlDjtq07ajZ2KLcYH+mGv43pziXZpYaqFcONPylhu5eRNpKI=
Received: from CY4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:903:117::12)
 by DM6PR02MB4219.namprd02.prod.outlook.com (2603:10b6:5:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Thu, 17 Oct
 2019 06:22:05 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR02CA0026.outlook.office365.com
 (2603:10b6:903:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Thu, 17 Oct 2019 06:22:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 17 Oct 2019 06:22:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAh-0004ah-O5; Wed, 16 Oct 2019 23:22:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAc-0003f6-Kh; Wed, 16 Oct 2019 23:21:58 -0700
Received: from [172.23.64.104] (helo=xhdvnc123.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iKzAb-0003ey-OJ; Wed, 16 Oct 2019 23:21:57 -0700
Received: by xhdvnc123.xilinx.com (Postfix, from userid 16987)
        id EF84D43A9B; Thu, 17 Oct 2019 11:51:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v3 2/8] dt-bindings: mmc: arasan: Update Documentation for the input clock
Date:   Thu, 17 Oct 2019 11:51:44 +0530
Message-Id: <1571293310-92563-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(50226002)(76176011)(4326008)(51416003)(16586007)(48376002)(47776003)(44832011)(478600001)(36756003)(305945005)(70206006)(106002)(70586007)(426003)(356004)(6666004)(26005)(336012)(107886003)(5660300002)(186003)(6266002)(486006)(42186006)(2616005)(476003)(126002)(36386004)(2906002)(8936002)(81156014)(81166006)(103686004)(8676002)(316002)(446003)(50466002)(11346002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4219;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55e307f7-7458-4a85-a8a9-08d752ca5433
X-MS-TrafficTypeDiagnostic: DM6PR02MB4219:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4219F8A1D9C6D16D63B1E5B8C16D0@DM6PR02MB4219.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lxb+tRWn2tUlDtbs+exrpgoG2owOAe1IIBuaePWkvUuf4r+Q8HURBeKkqNjjIVx0JIW2R0PT6nydu6BTc6NMk2SU8/89MjS7lhJhYzADj74FdgS3UhpVZmVTwpAy4ssv/liFFoAzoADPPWMzlLQqG688GpnsBETWiX2/7ob3PJkZo96rg3KNesGzmsdr/mPpWdq/W+cKKi82GCeBrNTecFTXWCn95Parbo4Mfartg9sCEU10pqCZAVEDtj+hT13R12BowL2rvzQ+RxJQkdM1ZnJDK5F1ZjamxsBqLQ9lVhuwYpv1Fhb8v8hv1i97ZleKc0Po5wv9E/F6rVdcb7Y/tIjT75wHOCnQl91VzSAwrVco9RdNEFzBvlvgpdPLPZ1uK1vUqods1u5+lZJctP4fhVrdQVMRF2L0v3txUD1YCfI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 06:22:04.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e307f7-7458-4a85-a8a9-08d752ca5433
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4219
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for an optional input clock which is essentially used
in sampling the input data coming from the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7ca0aa7ccc0b..b51e40b2e0c5 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -38,9 +38,9 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
-  - #clock-cells: If specified this should be the value <0>.  With this property
-    in place we will export a clock representing the Card Clock.  This clock
-    is expected to be consumed by our PHY.  You must also specify
+  - #clock-cells: If specified this should be the value <0> or <1>. With this
+    property in place we will export one or two clocks representing the Card
+    Clock. These clocks are expected to be consumed by our PHY.
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
-- 
2.17.1

