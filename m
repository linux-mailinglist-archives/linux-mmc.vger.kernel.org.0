Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB9EBD76
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Nov 2019 07:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfKAGGV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 1 Nov 2019 02:06:21 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:17486
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729878AbfKAGGR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwAbZbFN6TuS6Q1xg3NCchiXValaxyw8qzBcXgh+VEZyL9JqVIMAmW2f60a4wXr75tbjPbjdIchxOcRMcnpOpM6YIWsukKqhu5RPSNuBnSYugz0QwjOdJcDB0G9isNPiLWb27OVQEL/s3KbP4yB2pzVCuLWKwJHoPr+pxKkmZKNVpNoMEW/HekPJf8J6gkdCzMGchq39W/j0BjFSZbEw/v2Pqh2MdRIO32Q6zDX3MPIac80PM3/FG1ynu+KUrjnZzTAQHYkGDD6izd6mdfGbXH24DUZpMFN2aGlYf7giHiM1sk748UTkg/VLkBmaPHd24wk4fllFuIc1qol8yyeh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edVVdzq8QzskSlrSs9Pol89U+5YzrFKRUIqdGgUxodQ=;
 b=Dk0/vq1c5pi7QtubNrvMWn+SpKWs2NNEkD34Hx4VQDQPJ+hTyDrtk9yBu4b00YletKmov+OiquDa1p38Rrd9UbPCvLEih5XQhZQBLjADq2Y+Gr4UAtttTNNwhhHWkd7+UwCCg0bhuDcGQKOgNLRcTQ2U1WkJ3wA7q4c1c1qzQdIs7OeIGFLq1cLEv9fNukdkcedLL92tVSeRm2xS2knRWyn70SUIcevEJyQUiBd1E1SNqDiUfwjdTqbGOG7RwC6IjKBDs+cI/g6HN5lUMice263VR2TsEy+TjRNh8CIH5baLsaG3cxQt1jBPDK49GodGeUoHI8TRcOgOvyxDw0hIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edVVdzq8QzskSlrSs9Pol89U+5YzrFKRUIqdGgUxodQ=;
 b=LaGPzN7p0FfsvBHcMJA+MgyjTGScR1JGRCm7TKnhFMhtHpAyvsOvD3dPM2O04yalyuZCQQkDBU9ir5OYFSzAbfdNCzUdbpti/u+0nJw01LFYs8n3T15vJ9L/1fVqj9QDT80XBuIVZhkPkuIJJalkt9kWSMmB+e3+O+p6ISSsni4=
Received: from MWHPR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:301:73::27) by BY5PR02MB6674.namprd02.prod.outlook.com
 (2603:10b6:a03:202::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Fri, 1 Nov
 2019 06:06:10 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR0201CA0050.outlook.office365.com
 (2603:10b6:301:73::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 06:06:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4X-0005mO-7k; Thu, 31 Oct 2019 23:06:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4S-0007dN-3M; Thu, 31 Oct 2019 23:06:04 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165vpj005659;
        Thu, 31 Oct 2019 23:05:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4L-0007Zs-Lf; Thu, 31 Oct 2019 23:05:57 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D947112137F; Fri,  1 Nov 2019 11:35:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date:   Fri,  1 Nov 2019 11:35:45 +0530
Message-Id: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(42186006)(107886003)(14444005)(51416003)(478600001)(81166006)(6266002)(26005)(16586007)(8936002)(2906002)(50226002)(8676002)(316002)(81156014)(103686004)(4326008)(106002)(70586007)(48376002)(36756003)(2616005)(5660300002)(486006)(426003)(305945005)(47776003)(476003)(126002)(44832011)(70206006)(356004)(50466002)(6666004)(36386004)(186003)(336012)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6674;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a3b7d5-fe78-44b6-e057-08d75e91976f
X-MS-TrafficTypeDiagnostic: BY5PR02MB6674:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6674B8DA8369CD04E3B0B6AFC1620@BY5PR02MB6674.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dDABIU4gc8gXc4MragYEWzb/JMU9Xr1BBuIAAetivp3BUgZrUUhUH7ICtXJPzNBr8Ckcx5D/yDGHni4olNgKd31fv56wEFh8se9cyu2/dQT7/MtnhOtJ4yacZCfMSZWwX6wbbw6IZMJeq2otQ8JVtz+gIy8KdEdgfhMzqcsmZCWmrU/tbD66tWKgb9HMfLfztjNd/ReBtw2IbHJGDklyLDauspyiJWsZhdNACgq4OteqOq6BBDcBiTQi8ynYIHeRhr+WmaVimv2mBJ0NA4Z3cdLNksrv4I3dB6WSU25wxNFTCWKHtkalTDtg/cllAE5alNa9QqwZ9R5TOG++CZQZ5ioURCnCevdCPE/u1sv7fzzslDv57BNtjzjwa2hzxO4g+y11FUk2NOSRkPbZ6M10YYC+bfa4NEdULFbBWcOZ88Wqnt1FZJLIgEJdAKkBPUX
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:09.8363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a3b7d5-fe78-44b6-e057-08d75e91976f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6674
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series does the following:
 - Reorganize the Clock Handling in Arasan SD driver
 - Adds new sampling clock in Arasan SD driver
 - Adds support to set Clock Delays in SD Arasan Driver
 - Add SDIO Tap Delay handling in ZynqMP firmware driver
 - Add support for ZynqMP Tap Delays setting in Arasan SD driver

Changes in v2:
	- Replaced the deprecated calls to clock framework APIs
	- Added support for dev_clk_get() call to work for SD card clock
	- Separated the clock data struct
	- Fragmented the patch series in smaller patches to make it more
	  readable

Changes in v3:
	- Reverted "Replaced the deprecated calls to clock framework APIs"
	- Removed devm_clk_get() call which was added in v2

Changes in v4:
	- Made the Phase Delay properties Arasan specific

Changes in v5:
	- Made Clock Phase Delay properties common
	- Moved documentation of them to the common mmc documentation.

Manish Narani (8):
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: Add optional generic properties for mmc
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay nodes
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  25 +-
 .../bindings/mmc/mmc-controller.yaml          |  92 ++++
 drivers/mmc/host/sdhci-of-arasan.c            | 478 +++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  13 +-
 4 files changed, 576 insertions(+), 32 deletions(-)

-- 
2.17.1

