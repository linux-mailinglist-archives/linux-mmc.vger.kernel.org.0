Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7C143AC3
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jan 2020 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAUKWA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jan 2020 05:22:00 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:29195
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbgAUKWA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jan 2020 05:22:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhhAg9kghf1DX0kEcAOKKWc98RjasvG7LIzGHlrldnKypYd85vGcq7JOEg1OcDaYPdrGPsW/0c9lrlhDHv9GpeWhFAC/HaYSH5/GBmw+IVEZ05mqYxLLNe+R+aB4nRk6WNZnREJYH5oxzHOz10ilmOpoJ85jQNjaJuTrXNKjbJwwlFlScSnHAShlic+A8L0a+bqHu6n1wN8krVsK3BJQRg99nqe+4IEQKTAEgoul4oQxMU7rjGzeCACBVAsEsGIj5iwVp0iMWWMsfdV3EAyBEa+AaNKD5h6tKdTK7bmhWIwgJWLcMGwqiug/ZPCbqTdIdRPg1/E+fqf3hZQzPwlOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ngJSv1It+IyrguH3IPQ1bQnQ7LgzeJT8d8yWuBIWos=;
 b=oGu3WaqksPwKQlo/VfnvbMUih13we/xj9AyETgQj+yAvTWZwH1YNdtF8CaEkDLnBVI86nYF2SXnQ4XbAYOWQGzhIPCGM5EBj6aDC5g7/9kZa2lCAmk2rt1xvng/3ddNFPhvQDJ1/cdtTblixu6fY8tz1vwHhH4WmKIsGCyFXDN8PUf6ZlbadVxhvOmyzTFmVy7Mtoct/qQfxytvG8mQBgItzGkP+Cz3NtpKXaJd4QLLaG5dwwfc8xrRoBUqctmCPnDJ2YqexaUjQpvCiJzK4Q04v/2JhURwhFvkZq8hCzW4gcw1jbArijX/fFp0Lj7miGcnOfF4zokHlEE6EYzY2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ngJSv1It+IyrguH3IPQ1bQnQ7LgzeJT8d8yWuBIWos=;
 b=cVq4V/Vkp2RvadlJ25Cz+f9Xys5fDn1+So5Au1eZoLFAyDBxI4ko8XMw0agsqpMW2YXI9svYriZhSgUvZku0AMTAv4Mg5mhsRuvluJQHIpKf9CmSoe54/Ad1KPZRvzhLHaNv4JXerlGPMUoMSUEtWMFT4naKoICE7/jj0gkwZ1k=
Received: from DM6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:5:1f4::35)
 by DM6PR02MB4731.namprd02.prod.outlook.com (2603:10b6:5:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.24; Tue, 21 Jan
 2020 10:21:53 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR02CA0094.outlook.office365.com
 (2603:10b6:5:1f4::35) with Microsoft SMTP Server (version=TLS1_2,
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
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Tue, 21 Jan 2020 10:21:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfQ-0000zB-2A; Tue, 21 Jan 2020 02:21:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfK-0003Rc-Ui; Tue, 21 Jan 2020 02:21:46 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00LALgB2001399;
        Tue, 21 Jan 2020 02:21:42 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1itqfF-0003Po-RU; Tue, 21 Jan 2020 02:21:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 13AB512215B; Tue, 21 Jan 2020 15:51:41 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        manish.narani@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/4] mmc: sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms
Date:   Tue, 21 Jan 2020 15:51:34 +0530
Message-Id: <1579602095-30060-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(26005)(70206006)(2906002)(478600001)(70586007)(36756003)(426003)(6636002)(2616005)(6666004)(336012)(44832011)(5660300002)(42186006)(81156014)(8936002)(81166006)(8676002)(316002)(356004)(4326008)(6266002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4731;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963385c3-5f80-4057-d843-08d79e5bbbd9
X-MS-TrafficTypeDiagnostic: DM6PR02MB4731:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4731A08C08FD2F5E74A665E4C10D0@DM6PR02MB4731.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DugiXgIfN3uG0Ssz/6Ao95ga0Ak8TVrJya+WcsaqZOSLFImJ04pzutjnDlVrTBWUW49F63U6g4H+zEXi77bE3bhAEIvYHlk7hhFpCkOA1bvYTt5Kx6XOnxMyP07r36eVaRRAuSZx0MLc7eI+O1ORTZgEiO+M7+6kJ2kYl+h9kfmdNCNmVVk3i2AjLhBgLxAW+TXA1V+KL/nJQfbVUvsxLKOoPfMunDCKQFY38NzyoTlGgxm9jvS7LOBUmkSvlLgk3IhvzVkSC1Z9YAZ8z7aBrPc1XhCG6APwhe8btcsxNka3L4HmpR9K4rmtAV14AHVLloQJ9y4HMUbGSq2ZgHfiRtnI3KZnI2XrThKyNNCM3PmCTcOwX4T0GagjTEqacXBBO4ISVM9ayZhwve3qL0OclD3yagCw8kXpvb7x2Vso4M4B9NpnsoK/JbBLjfs6vVz
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:21:52.5581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963385c3-5f80-4057-d843-08d79e5bbbd9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4731
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The DLL resets are required while executing the auto tuning procedure in
ZynqMP. This patch adds code to support the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e49b44b4d82e..39176ab5ca1f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -757,6 +757,50 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
 	.set_phase = sdhci_zynqmp_sampleclk_set_phase,
 };
 
+static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
+		sdhci_arasan->clk_data.clk_of_data;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
+	u16 clk;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Issue DLL Reset */
+	eemi_ops->ioctl(deviceid, IOCTL_SD_DLL_RESET,
+			PM_DLL_RESET_PULSE, 0, NULL);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	sdhci_enable_clk(host, clk);
+}
+
+static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct clk_hw *hw = &sdhci_arasan->clk_data.sdcardclk_hw;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 device_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 :
+							   NODE_SD_1;
+	int err;
+
+	arasan_zynqmp_dll_reset(host, device_id);
+
+	err = sdhci_execute_tuning(mmc, opcode);
+	if (err)
+		return err;
+
+	arasan_zynqmp_dll_reset(host, device_id);
+
+	return 0;
+}
+
 /**
  * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
  *
@@ -1247,6 +1291,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 		zynqmp_clk_data->eemi_ops = eemi_ops;
 		sdhci_arasan->clk_data.clk_of_data = zynqmp_clk_data;
+		host->mmc_host_ops.execute_tuning =
+			arasan_zynqmp_execute_tuning;
 	}
 
 	arasan_dt_parse_clk_phases(&pdev->dev, &sdhci_arasan->clk_data);
-- 
2.17.1

