Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63828143ACA
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jan 2020 11:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAUKWO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jan 2020 05:22:14 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:51649
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbgAUKV4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jan 2020 05:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxHZhQctCZSzxkeNkwqQaacQ5HJIit/+++78TtoKlQ5z3Bgoz2jsPqHBdR+OaAgOn1BXrm30YZUDN+3IowrkpRHR3W2+QAvuzNFs3d2zsUXTJyH/uNTd15IgcNfJWDkxu5Vdzdh1ydBvKiTxGDsWypQFepv9MiijpWM8wvlXuXYI/Psw5FiLmnUyVY+XzfBBaWCLjq5ajq4dISEbN51rDu3uYUA4dwO3Xqnb8Ww7TsnWlY6iUUOSvCNr9IEbxIhFQhmbQxNA55k34nT1b0YCmGU0pTJgi8X7UW05FK7XRISIQhnJMmEPoaAAnk6wBSoaonSzPMBfssuPC3jVknfzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9sux/EuVdMHy0oMMXxWoYsD/dE07fqnc/P+Rq9MVBs=;
 b=RPF7oxgq+q+ey1tEglqya3/8I6eGPWt7yOxKMly3t8Y9QDGhcn2Q5ZwR+FQqjvZkszUMGO1A0kfO4IbybarJCMZN8RyCBpMp1ToJbUMB6c/hartotY3bj5ePKNNCuSacCDp4nlOUxUViGWInZ2IZT7YOSv90LCmhPyfdnibBvK/5kVO1JhALJ+oLtnbvheCPGA5OoDeP6iBrlPqxBt6K8M+LxHweXl1dCO7YmTGEjkO3HpUyqnyOH7JQwgSmydQd1CWbVk5WHJ4MmIcLy70gL7SRjwS4NltezqWpC4jngKEPVzYXK1tO2bpEZ2bcfGZkjxDlvWyPjDyYUGWprioWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9sux/EuVdMHy0oMMXxWoYsD/dE07fqnc/P+Rq9MVBs=;
 b=J6SJMaCtJIE4P0Pc5Hga3a2Fpxj0N7MXgk3WUp7B2oX5ySq536OnaQbqpoFLYO1aDm9t5EMTIXd4370oc7cU5w7+5LyyxiW/D/sGqkzyhOoH+KfYJVgYu92qeDtCiP4FnYcnAtscXh5sw34DoduIvAaqdKJ1nv9RbOcu3w+NY3M=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by CH2PR02MB6055.namprd02.prod.outlook.com (2603:10b6:610:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.21; Tue, 21 Jan
 2020 10:21:52 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 10:21:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Tue, 21 Jan 2020 10:21:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfQ-0000zC-5N; Tue, 21 Jan 2020 02:21:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfL-0003Rc-1U; Tue, 21 Jan 2020 02:21:47 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00LALgTX001397;
        Tue, 21 Jan 2020 02:21:42 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1itqfF-0003Pn-Qm; Tue, 21 Jan 2020 02:21:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0E4A6121DAE; Tue, 21 Jan 2020 15:51:41 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        manish.narani@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/4] firmware: xilinx: Add DLL reset support
Date:   Tue, 21 Jan 2020 15:51:33 +0530
Message-Id: <1579602095-30060-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(26005)(336012)(8936002)(70206006)(70586007)(8676002)(2906002)(81156014)(5660300002)(186003)(81166006)(36756003)(4326008)(356004)(6666004)(478600001)(6636002)(6266002)(316002)(44832011)(42186006)(2616005)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6055;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20333428-a169-4a5c-fe38-08d79e5bbbdb
X-MS-TrafficTypeDiagnostic: CH2PR02MB6055:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6055258EC641218F57AEABB8C10D0@CH2PR02MB6055.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gS4WjdkwYMsoFD9+RTIPq2Hp8n0DFBXbEFRQCP95VMpTkZxJtRMVcTgu1dLmmahrKRizXJ/FhcwA6KNP3VWMu9IjA3N50pxwW8/tJp1rDn5q/PFXePjMg5lrU+7X3kQRMmpDNuE0+Ck6IvywZE15wut4cC6cDma9Aez3jfngJqAvHqxRv2DXEu+cfpe568c9kn5GSV/zDkG3pD6jiJCEf1HbTS/sQv5Tg4KI6tQwyhQZdUKSxcZaIWoe/W6vY4gv4RLHzkVqkmGnlGrYf6hCP9WahYZGuLApHV0EH3Q0RYvUY1eJdmrZEphjLotllMEe6UwHrDSE8FZuaidVJYKnnuskUS494T4iPNW63hlMeYCLHCJPBERrogLcI4/Oz2K97g63qEPh9rI4rCfOuEOGfqxjWhTFm+v+Riomc8R70nduJ1TdR2j2G9Cp2Oln+3q
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:21:52.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20333428-a169-4a5c-fe38-08d79e5bbbdb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6055
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SD DLL resets are required for some of the operations on ZynqMP platform.
Add DLL reset support in ZynqMP firmware driver for SD DLL reset.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 1 +
 include/linux/firmware/xlnx-zynqmp.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 89eb198cee5e..165ec0f1e10a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
 {
 	switch (ioctl_id) {
+	case IOCTL_SD_DLL_RESET:
 	case IOCTL_SET_SD_TAPDELAY:
 	case IOCTL_SET_PLL_FRAC_MODE:
 	case IOCTL_GET_PLL_FRAC_MODE:
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e41ad9e37136..01a6d972b8a8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -92,7 +92,8 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
-	IOCTL_SET_SD_TAPDELAY = 7,
+	IOCTL_SD_DLL_RESET = 6,
+	IOCTL_SET_SD_TAPDELAY,
 	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
@@ -262,6 +263,12 @@ enum tap_delay_type {
 	PM_TAPDELAY_OUTPUT,
 };
 
+enum dll_reset_type {
+	PM_DLL_RESET_ASSERT,
+	PM_DLL_RESET_RELEASE,
+	PM_DLL_RESET_PULSE,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.17.1

