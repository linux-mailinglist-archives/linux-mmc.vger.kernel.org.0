Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0351810347E
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Nov 2019 07:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKTGsT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Nov 2019 01:48:19 -0500
Received: from mail-eopbgr740073.outbound.protection.outlook.com ([40.107.74.73]:30688
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbfKTGrz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hceKUzHYFvHIivrERsv81lQYx1zmsAlb1YXKjLUyzWz4NDYFY9Hd0LGV0IUI7PQPKFMJbgEMqYGlu8ExhR8A1RnLwt47b5TVId+QY3Yy9ULF99EQXsJI6D9RnTDd0rz9DYNoUlIr5KfRP3g+MhkEZqPapQLrUAuuPviPMoLFOl8cCz9EycZWPQBSwFX5V6KDnXD26/hD0XHVQQra9d51xz+fps20lkpl0s1iV8NcUaXFh03FmvFBrIzQphKUUkaHShFnFbrQ6z3WWsk0yDn1m7AvrZkhX3WwReM0LeV5Odbql3jxyimrMabX7GY+MUdWYP2sxp5VeL5gE0B/w4ahAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjNlJsEg54SQNLOqjfVJfm6MTxVpU+Ns2k424JSQS18=;
 b=dd5G7IMY4soeGoq80i43RKP9X65npEl/A+fJnv0sq3Deyd+C58/n20haRuF2kTmnjSttj2brcuzhePEtYDp5Fu24OwfbO1jLMZeBR+6a5oyEVzXM2aB+hUHSDFV7I0OAgpqrONkoCNJVyF9Ffw15pfNHODzt6dT/iwIaUP1GOT0Pr3YRBfzofYStZ6Pz5F25fKjLjJXRx1JnpMZnuR6ePQCITvvF9CUPKp1dOBobLStRPgxvG9RBnU3zhOkk2Xrby6nsny7POy+7A2YXZ0ef+YV4M4XOuz9Q9ClY7fnqqTpDMVQqTRwgUNgLYvsxoN3E0CMFthWA4jaVQ1mQclPi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjNlJsEg54SQNLOqjfVJfm6MTxVpU+Ns2k424JSQS18=;
 b=GCfFT2i9BpELzSppedzRH2x8MPspiDg5HrDX/+vl929sji1Y3e/N6pWxvbUI1cFJJdzC+EyqLeHo1fq/DnrZsj5ecPjEyFg4Fka/rD5RjAMmBwLDk18INS5+YPg/9acB13hGe3wcZEjz4YffTtQOeYoBWwllKVwvBl16bQGIV94=
Received: from BN7PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:20::43)
 by MN2PR02MB6591.namprd02.prod.outlook.com (2603:10b6:208:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27; Wed, 20 Nov
 2019 06:47:49 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN7PR02CA0030.outlook.office365.com
 (2603:10b6:408:20::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmG-00061E-1M; Tue, 19 Nov 2019 22:47:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-Tk; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6laqw027289;
        Tue, 19 Nov 2019 22:47:37 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm4-000493-Lx; Tue, 19 Nov 2019 22:47:36 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E50A212138C; Wed, 20 Nov 2019 12:17:35 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 4/8] dt-bindings: mmc: Add optional generic properties for mmc
Date:   Wed, 20 Nov 2019 12:17:25 +0530
Message-Id: <1574232449-13570-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5660300002)(50466002)(70206006)(70586007)(336012)(42186006)(47776003)(446003)(11346002)(8676002)(316002)(81166006)(81156014)(44832011)(126002)(2616005)(476003)(486006)(36756003)(6266002)(103686004)(107886003)(36386004)(2906002)(478600001)(48376002)(16586007)(4326008)(426003)(50226002)(186003)(8936002)(305945005)(356004)(106002)(26005)(14444005)(51416003)(76176011)(6666004)(41533002)(42866002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6591;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4a6714-dc45-44be-a587-08d76d858f15
X-MS-TrafficTypeDiagnostic: MN2PR02MB6591:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6591FD5BEEC43434F13F1930C14F0@MN2PR02MB6591.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RVfBYBEh/H8aLckc2j8QG7lN5B4t/zn+5c531tW9wTbFdKoSeCBU+lnJWPy10I7zf2SLqrUowf4QgKG/8Up1UUYcaTV+oEbpLCn9VTzPBuniFQM+xQ8D5NFREQ7XTwytn3TUU/FdD2NwhOwozT29VFkg+CjlpDt7XpX7id1Ch3+0w/D3vyC/1G9aaYHBfepx5VxXlPZwX18c+mSQALo2O66MN8lnExUG8usjOV8RZKaeh5TtIFtJhBEPs+J7zTDgPIgjdcFLSV74pfocMP4OBvTpNUf4eXFw4X3ZZ/awZbx2XjXgNt5K95CLBMqzuQ4sb8ZsklJ9UuDKaOzpvabykE2Y0xBgX9jZNDVqhOQEgGftRnPOQIz7s0Neatfn+1c54hEM0yFiwWD7fOqtnUb57F5rTXyJbmgsy3ZQGckF5BJHsiDT8qQFjWSm4/puwQS
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4a6714-dc45-44be-a587-08d76d858f15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6591
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add optional properties for mmc hosts which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..305b2016bc17 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -333,6 +333,18 @@ patternProperties:
     required:
       - reg
 
+  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    minItems: 2
+    maxItems: 2
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+        maximum: 359
+    description:
+      Set the clock (phase) delays which are to be configured in the
+      controller while switching to particular speed mode. These values
+      are in pair of degrees.
+
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
@@ -351,6 +363,7 @@ examples:
         keep-power-in-suspend;
         wakeup-source;
         mmc-pwrseq = <&sdhci0_pwrseq>;
+        clk-phase-sd-hs = <63>, <72>;
     };
 
   - |
-- 
2.17.1

