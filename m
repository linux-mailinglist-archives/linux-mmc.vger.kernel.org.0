Return-Path: <linux-mmc+bounces-3885-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F2977F71
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2024 14:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A322DB265B2
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E71DA11C;
	Fri, 13 Sep 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dvZpKPeR"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F881D933F;
	Fri, 13 Sep 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229624; cv=none; b=mV5SJFAgCKQNivtpKYN9Y64qUPVDlch1HitsBBOqEDDBS7ZneU0ZgWO1jAPcbs6uoKhxtQPddd8/umTuqyKE0Z6Yv2wOvjQNZ6xJ46vJOQzDVEgX6+1EBCF9XmV7FBUqibKXN7GaFG5Sr+5OBEH0V8kRkGeEVIbuTIgfxwLRYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229624; c=relaxed/simple;
	bh=GV4zZVgYgw5YfOBk27RQnhAwHDqLee+UKju/SCMJfok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQv1kfIizGctuvfDENtex31fehblsSGYvWRgAG58b939HB5KSvq/4N550THkhx+vy3U+xu31g28XXnW7fauMVMtGa7/ezdJ69rBUbpTMBeaCiAWaxSQaHoCBTikxkZ+uUJ3UZrDrJ5G+YUvnqQeAdcEsYVaOay9/krNdsEqi/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dvZpKPeR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DA0WQQ030116;
	Fri, 13 Sep 2024 12:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RNCrBH3U0RUGg6156buz7mWODBUQOkWB4A3cpwGF8e8=; b=dvZpKPeR4InjtowV
	zLVSys/dk6HY5x0jO0xGewFEGtQfOlygC3ngmTmdAi6h2VCViwVJOQVgybRKW6/B
	SpJ3Li5lsd/OJx7EguBEM5vMVvIgobSvmH3xZK1GHQIwMG1C4Rle9B1a7uNJAaXz
	hsqzeBA2XtX44ZFcaFYppP7KnziYiOH+8eieHM2+CPtU7u8S+BDuOrpjB3q0sVoR
	n1xfT/w1PHzrt+sUSRwN52Ff18y277CKIgvaf5PT6hWYO3T3nU9qqZ42h20+49f3
	c3HFl8szSY6hLgRmvN3c/tS0G1S33V/lmbKWowRpLsW+AaY1R4F9hoFU2iLKdkCR
	RES6LQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5a8sk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 12:13:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DCDJM1002359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 12:13:19 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 05:13:12 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <dmitry.baryshkov@linaro.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
Subject: [PATCH 1/8] dt-bindings: clock: Add Qualcomm IPQ5424 GCC
Date: Fri, 13 Sep 2024 17:42:43 +0530
Message-ID: <20240913121250.2995351-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913121250.2995351-1-quic_srichara@quicinc.com>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ew3CjhsByoyLqDcUTNQeKHk0qLJ2cFGV
X-Proofpoint-ORIG-GUID: ew3CjhsByoyLqDcUTNQeKHk0qLJ2cFGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130085

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add binding for the Qualcomm IPQ5424 Global Clock Controller

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 .../bindings/clock/qcom,ipq5424-gcc.yaml      |  58 ++++
 include/dt-bindings/clock/qcom,ipq5424-gcc.h  | 156 +++++++++
 include/dt-bindings/reset/qcom,ipq5424-gcc.h  | 310 ++++++++++++++++++
 3 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,ipq5424-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq5424-gcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-gcc.yaml
new file mode 100644
index 000000000000..af2d0cec43f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-gcc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5424-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on IPQ5424
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on IPQ5424.
+
+  See also::
+    include/dt-bindings/clock/qcom,gcc-ipq5424.h
+    include/dt-bindings/reset/qcom,ipq5424-gcc.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq5424-gcc
+
+  clocks:
+    items:
+      - description: Board XO clock source
+      - description: Sleep clock source
+      - description: PCIE 2lane PHY pipe clock source
+      - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
+      - description: USB PCIE wrapper pipe clock source
+
+  '#power-domain-cells': false
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@1800000 {
+      compatible = "qcom,ipq5424-gcc";
+      reg = <0x01800000 0x80000>;
+      clocks = <&xo_board>,
+               <&sleep_clk>,
+               <&pcie_2lane_phy_pipe_clk>,
+               <&pcie_2lane_phy_pipe_clk_x1>,
+               <&usb_pcie_wrapper_pipe_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,ipq5424-gcc.h b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
new file mode 100644
index 000000000000..31d9b9d8525a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_IPQ_GCC_IPQ5424_H
+#define _DT_BINDINGS_CLOCK_IPQ_GCC_IPQ5424_H
+
+#define GPLL0					0
+#define GPLL4					1
+#define GPLL2					2
+#define GPLL2_OUT_MAIN                          3
+#define GCC_SLEEP_CLK_SRC			4
+#define GCC_APSS_DBG_CLK                        5
+#define GCC_USB0_EUD_AT_CLK			6
+#define GCC_PCIE0_AXI_M_CLK_SRC			7
+#define GCC_PCIE0_AXI_M_CLK			8
+#define GCC_PCIE1_AXI_M_CLK_SRC			9
+#define GCC_PCIE1_AXI_M_CLK			10
+#define GCC_PCIE2_AXI_M_CLK_SRC			11
+#define GCC_PCIE2_AXI_M_CLK			12
+#define GCC_PCIE3_AXI_M_CLK_SRC			13
+#define GCC_PCIE3_AXI_M_CLK			14
+#define GCC_PCIE0_AXI_S_CLK_SRC			15
+#define GCC_PCIE0_AXI_S_BRIDGE_CLK		16
+#define GCC_PCIE0_AXI_S_CLK			17
+#define GCC_PCIE1_AXI_S_CLK_SRC			18
+#define GCC_PCIE1_AXI_S_BRIDGE_CLK		19
+#define GCC_PCIE1_AXI_S_CLK			20
+#define GCC_PCIE2_AXI_S_CLK_SRC			21
+#define GCC_PCIE2_AXI_S_BRIDGE_CLK		22
+#define GCC_PCIE2_AXI_S_CLK			23
+#define GCC_PCIE3_AXI_S_CLK_SRC			24
+#define GCC_PCIE3_AXI_S_BRIDGE_CLK		25
+#define GCC_PCIE3_AXI_S_CLK			26
+#define GCC_PCIE0_PIPE_CLK_SRC			27
+#define GCC_PCIE0_PIPE_CLK			28
+#define GCC_PCIE1_PIPE_CLK_SRC			29
+#define GCC_PCIE1_PIPE_CLK			30
+#define GCC_PCIE2_PIPE_CLK_SRC			31
+#define GCC_PCIE2_PIPE_CLK			32
+#define GCC_PCIE3_PIPE_CLK_SRC			33
+#define GCC_PCIE3_PIPE_CLK			34
+#define GCC_PCIE_AUX_CLK_SRC			35
+#define GCC_PCIE0_AUX_CLK			36
+#define GCC_PCIE1_AUX_CLK			37
+#define GCC_PCIE2_AUX_CLK			38
+#define GCC_PCIE3_AUX_CLK			39
+#define GCC_PCIE0_AHB_CLK			40
+#define GCC_PCIE1_AHB_CLK			41
+#define GCC_PCIE2_AHB_CLK			42
+#define GCC_PCIE3_AHB_CLK			43
+#define GCC_USB0_AUX_CLK_SRC			44
+#define GCC_USB0_AUX_CLK			45
+#define GCC_USB0_MASTER_CLK			46
+#define GCC_USB0_MOCK_UTMI_CLK_SRC		47
+#define GCC_USB0_MOCK_UTMI_DIV_CLK_SRC		48
+#define GCC_USB0_MOCK_UTMI_CLK			49
+#define GCC_USB0_PIPE_CLK_SRC			50
+#define GCC_USB0_PIPE_CLK			51
+#define GCC_USB0_PHY_CFG_AHB_CLK		52
+#define GCC_USB0_SLEEP_CLK			53
+#define GCC_SDCC1_APPS_CLK_SRC			54
+#define GCC_SDCC1_APPS_CLK			55
+#define GCC_SDCC1_ICE_CORE_CLK_SRC		56
+#define GCC_SDCC1_ICE_CORE_CLK			57
+#define GCC_SDCC1_AHB_CLK			58
+#define GCC_PCNOC_BFDCD_CLK_SRC			59
+#define GCC_NSSCFG_CLK				60
+#define GCC_NSSNOC_NSSCC_CLK			61
+#define GCC_NSSCC_CLK				62
+#define GCC_NSSNOC_PCNOC_1_CLK			63
+#define GCC_QPIC_AHB_CLK			64
+#define GCC_QPIC_CLK				65
+#define GCC_MDIO_AHB_CLK			66
+#define GCC_PRNG_AHB_CLK			67
+#define GCC_UNIPHY0_AHB_CLK			68
+#define GCC_UNIPHY1_AHB_CLK			69
+#define GCC_UNIPHY2_AHB_CLK			70
+#define GCC_CMN_12GPLL_AHB_CLK			71
+#define GCC_SYSTEM_NOC_BFDCD_CLK_SRC		72
+#define GCC_NSSNOC_SNOC_CLK			73
+#define GCC_NSSNOC_SNOC_1_CLK			74
+#define GCC_WCSS_AHB_CLK_SRC			75
+#define GCC_QDSS_AT_CLK_SRC			76
+#define GCC_NSSNOC_ATB_CLK			77
+#define GCC_QDSS_AT_CLK				78
+#define GCC_QDSS_TSCTR_CLK_SRC			79
+#define GCC_NSS_TS_CLK				80
+#define GCC_QPIC_IO_MACRO_CLK_SRC		81
+#define GCC_QPIC_IO_MACRO_CLK			82
+#define GCC_LPASS_AXIM_CLK_SRC			83
+#define GCC_LPASS_CORE_AXIM_CLK			84
+#define GCC_LPASS_SWAY_CLK_SRC			85
+#define GCC_LPASS_SWAY_CLK			86
+#define GCC_CNOC_LPASS_CFG_CLK                  87
+#define GCC_SNOC_LPASS_CLK                      88
+#define GCC_ADSS_PWM_CLK_SRC			89
+#define GCC_ADSS_PWM_CLK			90
+#define GCC_XO_CLK_SRC				91
+#define GCC_NSSNOC_XO_DCD_CLK			92
+#define GCC_NSSNOC_QOSGEN_REF_CLK		93
+#define GCC_NSSNOC_TIMEOUT_REF_CLK		94
+#define GCC_UNIPHY0_SYS_CLK			95
+#define GCC_UNIPHY1_SYS_CLK			96
+#define GCC_UNIPHY2_SYS_CLK			97
+#define GCC_CMN_12GPLL_SYS_CLK			98
+#define GCC_UNIPHY_SYS_CLK_SRC			99
+#define GCC_NSS_TS_CLK_SRC			100
+#define GCC_ANOC_PCIE0_1LANE_M_CLK		101
+#define GCC_ANOC_PCIE1_1LANE_M_CLK		102
+#define GCC_ANOC_PCIE2_2LANE_M_CLK		103
+#define GCC_ANOC_PCIE3_2LANE_M_CLK		104
+#define GCC_CNOC_PCIE0_1LANE_S_CLK		105
+#define GCC_CNOC_PCIE1_1LANE_S_CLK		106
+#define GCC_CNOC_PCIE2_2LANE_S_CLK		107
+#define GCC_CNOC_PCIE3_2LANE_S_CLK		108
+#define GCC_CNOC_USB_CLK			109
+#define GCC_CNOC_WCSS_AHB_CLK			110
+#define GCC_QUPV3_AHB_MST_CLK			111
+#define GCC_QUPV3_AHB_SLV_CLK			112
+#define GCC_QUPV3_I2C0_CLK			113
+#define GCC_QUPV3_I2C1_CLK			114
+#define GCC_QUPV3_SPI0_CLK			115
+#define GCC_QUPV3_SPI1_CLK			116
+#define GCC_QUPV3_UART0_CLK			117
+#define GCC_QUPV3_UART1_CLK			118
+#define GCC_QPIC_CLK_SRC			119
+#define GCC_QUPV3_I2C0_CLK_SRC			120
+#define GCC_QUPV3_I2C1_CLK_SRC			121
+#define GCC_QUPV3_I2C0_DIV_CLK_SRC              122
+#define GCC_QUPV3_I2C1_DIV_CLK_SRC              123
+#define GCC_QUPV3_SPI0_CLK_SRC			124
+#define GCC_QUPV3_SPI1_CLK_SRC			125
+#define GCC_QUPV3_UART0_CLK_SRC			126
+#define GCC_QUPV3_UART1_CLK_SRC			127
+#define GCC_USB1_MASTER_CLK			128
+#define GCC_USB1_MOCK_UTMI_CLK_SRC		129
+#define GCC_USB1_MOCK_UTMI_DIV_CLK_SRC		130
+#define GCC_USB1_MOCK_UTMI_CLK			131
+#define GCC_USB1_SLEEP_CLK			132
+#define GCC_USB1_PHY_CFG_AHB_CLK		133
+#define GCC_USB0_MASTER_CLK_SRC			134
+#define GCC_QDSS_DAP_CLK			135
+#define GCC_PCIE0_RCHNG_CLK_SRC			136
+#define GCC_PCIE0_RCHNG_CLK			137
+#define GCC_PCIE1_RCHNG_CLK_SRC			138
+#define GCC_PCIE1_RCHNG_CLK			139
+#define GCC_PCIE2_RCHNG_CLK_SRC			140
+#define GCC_PCIE2_RCHNG_CLK			141
+#define GCC_PCIE3_RCHNG_CLK_SRC			142
+#define GCC_PCIE3_RCHNG_CLK			143
+#define GCC_IM_SLEEP_CLK			144
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,ipq5424-gcc.h b/include/dt-bindings/reset/qcom,ipq5424-gcc.h
new file mode 100644
index 000000000000..bb7a4ecaced2
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,ipq5424-gcc.h
@@ -0,0 +1,310 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_IPQ_GCC_IPQ5424_H
+#define _DT_BINDINGS_RESET_IPQ_GCC_IPQ5424_H
+
+#define GCC_QUPV3_BCR				0
+#define GCC_QUPV3_I2C0_BCR			1
+#define GCC_QUPV3_UART0_BCR			2
+#define GCC_QUPV3_I2C1_BCR			3
+#define GCC_QUPV3_UART1_BCR			4
+#define GCC_QUPV3_SPI0_BCR			5
+#define GCC_QUPV3_SPI1_BCR			6
+#define GCC_IMEM_BCR				7
+#define GCC_TME_BCR				8
+#define GCC_DDRSS_BCR				9
+#define GCC_PRNG_BCR				10
+#define GCC_BOOT_ROM_BCR			11
+#define GCC_NSS_BCR				12
+#define GCC_MDIO_BCR				13
+#define GCC_UNIPHY0_BCR				14
+#define GCC_UNIPHY1_BCR				15
+#define GCC_UNIPHY2_BCR				16
+#define GCC_WCSS_BCR				17
+#define GCC_SEC_CTRL_BCR			19
+#define GCC_TME_SEC_BUS_BCR			20
+#define GCC_ADSS_BCR				21
+#define GCC_LPASS_BCR				22
+#define GCC_PCIE0_BCR				23
+#define GCC_PCIE0_LINK_DOWN_BCR			24
+#define GCC_PCIE0PHY_PHY_BCR			25
+#define GCC_PCIE0_PHY_BCR			26
+#define GCC_PCIE1_BCR				27
+#define GCC_PCIE1_LINK_DOWN_BCR			28
+#define GCC_PCIE1PHY_PHY_BCR			29
+#define GCC_PCIE1_PHY_BCR			30
+#define GCC_PCIE2_BCR				31
+#define GCC_PCIE2_LINK_DOWN_BCR			32
+#define GCC_PCIE2PHY_PHY_BCR			33
+#define GCC_PCIE2_PHY_BCR			34
+#define GCC_PCIE3_BCR				35
+#define GCC_PCIE3_LINK_DOWN_BCR			36
+#define GCC_PCIE3PHY_PHY_BCR			37
+#define GCC_PCIE3_PHY_BCR			38
+#define GCC_USB_BCR				39
+#define GCC_QUSB2_0_PHY_BCR			40
+#define GCC_USB0_PHY_BCR			41
+#define GCC_USB3PHY_0_PHY_BCR			42
+#define GCC_QDSS_BCR				43
+#define GCC_SNOC_BCR				44
+#define GCC_ANOC_BCR				45
+#define GCC_PCNOC_BCR				46
+#define GCC_PCNOC_BUS_TIMEOUT0_BCR		47
+#define GCC_PCNOC_BUS_TIMEOUT1_BCR		48
+#define GCC_PCNOC_BUS_TIMEOUT2_BCR		49
+#define GCC_PCNOC_BUS_TIMEOUT3_BCR		50
+#define GCC_PCNOC_BUS_TIMEOUT4_BCR		51
+#define GCC_PCNOC_BUS_TIMEOUT5_BCR		52
+#define GCC_PCNOC_BUS_TIMEOUT6_BCR		53
+#define GCC_PCNOC_BUS_TIMEOUT7_BCR		54
+#define GCC_PCNOC_BUS_TIMEOUT8_BCR		55
+#define GCC_PCNOC_BUS_TIMEOUT9_BCR		56
+#define GCC_QPIC_BCR				57
+#define GCC_SDCC_BCR				58
+#define GCC_DCC_BCR				59
+#define GCC_SPDM_BCR				60
+#define GCC_MPM_BCR				61
+#define GCC_APC0_VOLTAGE_DROOP_DETECTOR_BCR	62
+#define GCC_RBCPR_BCR				63
+#define GCC_CMN_BLK_BCR				64
+#define GCC_TCSR_BCR				65
+#define GCC_TLMM_BCR				66
+#define GCC_QUPV3_AHB_MST_ARES			67
+#define GCC_QUPV3_CORE_ARES			68
+#define GCC_QUPV3_2X_CORE_ARES			69
+#define GCC_QUPV3_SLEEP_ARES			70
+#define GCC_QUPV3_AHB_SLV_ARES			71
+#define GCC_QUPV3_I2C0_ARES			72
+#define GCC_QUPV3_UART0_ARES			73
+#define GCC_QUPV3_I2C1_ARES			74
+#define GCC_QUPV3_UART1_ARES			75
+#define GCC_QUPV3_SPI0_ARES			76
+#define GCC_QUPV3_SPI1_ARES			77
+#define GCC_DEBUG_ARES				78
+#define GCC_GP1_ARES				79
+#define GCC_GP2_ARES				80
+#define GCC_GP3_ARES				81
+#define GCC_IMEM_AXI_ARES			82
+#define GCC_IMEM_CFG_AHB_ARES			83
+#define GCC_TME_ARES				84
+#define GCC_TME_TS_ARES				85
+#define GCC_TME_SLOW_ARES			86
+#define GCC_TME_RTC_TOGGLE_ARES			87
+#define GCC_TIC_ARES				88
+#define GCC_PRNG_AHB_ARES			89
+#define GCC_BOOT_ROM_AHB_ARES			90
+#define GCC_NSSNOC_ATB_ARES			91
+#define GCC_NSS_TS_ARES				92
+#define GCC_NSSNOC_QOSGEN_REF_ARES		93
+#define GCC_NSSNOC_TIMEOUT_REF_ARES		94
+#define GCC_NSSNOC_MEMNOC_ARES			95
+#define GCC_NSSNOC_SNOC_ARES			96
+#define GCC_NSSCFG_ARES				97
+#define GCC_NSSNOC_NSSCC_ARES			98
+#define GCC_NSSCC_ARES				99
+#define GCC_MDIO_AHB_ARES			100
+#define GCC_UNIPHY0_SYS_ARES			101
+#define GCC_UNIPHY0_AHB_ARES			102
+#define GCC_UNIPHY1_SYS_ARES			103
+#define GCC_UNIPHY1_AHB_ARES			104
+#define GCC_UNIPHY2_SYS_ARES			105
+#define GCC_UNIPHY2_AHB_ARES			106
+#define GCC_NSSNOC_XO_DCD_ARES			107
+#define GCC_NSSNOC_SNOC_1_ARES			108
+#define GCC_NSSNOC_PCNOC_1_ARES			109
+#define GCC_NSSNOC_MEMNOC_1_ARES		110
+#define GCC_DDRSS_ATB_ARES			111
+#define GCC_DDRSS_AHB_ARES			112
+#define GCC_GEMNOC_AHB_ARES			113
+#define GCC_GEMNOC_Q6_AXI_ARES			114
+#define GCC_GEMNOC_NSSNOC_ARES			115
+#define GCC_GEMNOC_SNOC_ARES			116
+#define GCC_GEMNOC_APSS_ARES			117
+#define GCC_GEMNOC_QOSGEN_EXTREF_ARES		118
+#define GCC_GEMNOC_TS_ARES			119
+#define GCC_DDRSS_SMS_SLOW_ARES			120
+#define GCC_GEMNOC_CNOC_ARES			121
+#define GCC_GEMNOC_XO_DBG_ARES			122
+#define GCC_GEMNOC_ANOC_ARES			123
+#define GCC_DDRSS_LLCC_ATB_ARES			124
+#define GCC_LLCC_TPDM_CFG_ARES			125
+#define GCC_TME_BUS_ARES			126
+#define GCC_SEC_CTRL_ACC_ARES			127
+#define GCC_SEC_CTRL_ARES			128
+#define GCC_SEC_CTRL_SENSE_ARES			129
+#define GCC_SEC_CTRL_AHB_ARES			130
+#define GCC_SEC_CTRL_BOOT_ROM_PATCH_ARES	131
+#define GCC_ADSS_PWM_ARES			132
+#define GCC_TME_ATB_ARES			133
+#define GCC_TME_DBGAPB_ARES			134
+#define GCC_TME_DEBUG_ARES			135
+#define GCC_TME_AT_ARES				136
+#define GCC_TME_APB_ARES			137
+#define GCC_TME_DMI_DBG_HS_ARES			138
+#define GCC_APSS_AHB_ARES			139
+#define GCC_APSS_AXI_ARES			140
+#define GCC_CPUSS_TRIG_ARES			141
+#define GCC_APSS_DBG_ARES			142
+#define GCC_APSS_TS_ARES			143
+#define GCC_APSS_ATB_ARES			144
+#define GCC_Q6_AXIM_ARES			145
+#define GCC_Q6_AXIS_ARES			146
+#define GCC_Q6_AHB_ARES				147
+#define GCC_Q6_AHB_S_ARES			148
+#define GCC_Q6SS_ATBM_ARES			149
+#define GCC_Q6_TSCTR_1TO2_ARES			150
+#define GCC_Q6SS_PCLKDBG_ARES			151
+#define GCC_Q6SS_TRIG_ARES			152
+#define GCC_Q6SS_BOOT_CBCR_ARES			153
+#define GCC_WCSS_DBG_IFC_APB_ARES		154
+#define GCC_WCSS_DBG_IFC_ATB_ARES		155
+#define GCC_WCSS_DBG_IFC_NTS_ARES		156
+#define GCC_WCSS_DBG_IFC_DAPBUS_ARES		157
+#define GCC_WCSS_DBG_IFC_APB_BDG_ARES		158
+#define GCC_WCSS_DBG_IFC_NTS_BDG_ARES		159
+#define GCC_WCSS_DBG_IFC_DAPBUS_BDG_ARES	160
+#define GCC_WCSS_ECAHB_ARES			161
+#define GCC_WCSS_ACMT_ARES			162
+#define GCC_WCSS_AHB_S_ARES			163
+#define GCC_WCSS_AXI_M_ARES			164
+#define GCC_PCNOC_WAPSS_ARES			165
+#define GCC_SNOC_WAPSS_ARES			166
+#define GCC_LPASS_SWAY_ARES			167
+#define GCC_LPASS_CORE_AXIM_ARES		168
+#define GCC_PCIE0_AHB_ARES			169
+#define GCC_PCIE0_AXI_M_ARES			170
+#define GCC_PCIE0_AXI_S_ARES			171
+#define GCC_PCIE0_AXI_S_BRIDGE_ARES		172
+#define GCC_PCIE0_PIPE_ARES			173
+#define GCC_PCIE0_AUX_ARES			174
+#define GCC_PCIE1_AHB_ARES			175
+#define GCC_PCIE1_AXI_M_ARES			176
+#define GCC_PCIE1_AXI_S_ARES			177
+#define GCC_PCIE1_AXI_S_BRIDGE_ARES		178
+#define GCC_PCIE1_PIPE_ARES			179
+#define GCC_PCIE1_AUX_ARES			180
+#define GCC_PCIE2_AHB_ARES			181
+#define GCC_PCIE2_AXI_M_ARES			182
+#define GCC_PCIE2_AXI_S_ARES			183
+#define GCC_PCIE2_AXI_S_BRIDGE_ARES		184
+#define GCC_PCIE2_PIPE_ARES			185
+#define GCC_PCIE2_AUX_ARES			186
+#define GCC_PCIE3_AHB_ARES			187
+#define GCC_PCIE3_AXI_M_ARES			188
+#define GCC_PCIE3_AXI_S_ARES			189
+#define GCC_PCIE3_AXI_S_BRIDGE_ARES		190
+#define GCC_PCIE3_PIPE_ARES			191
+#define GCC_PCIE3_AUX_ARES			192
+#define GCC_USB0_MASTER_ARES			193
+#define GCC_USB0_AUX_ARES			194
+#define GCC_USB0_MOCK_UTMI_ARES			195
+#define GCC_USB0_PIPE_ARES			196
+#define GCC_USB0_SLEEP_ARES			197
+#define GCC_USB0_PHY_CFG_AHB_ARES		198
+#define GCC_QDSS_AT_ARES			199
+#define GCC_QDSS_STM_ARES			200
+#define GCC_QDSS_TRACECLKIN_ARES		201
+#define GCC_QDSS_TSCTR_DIV2_ARES		202
+#define GCC_QDSS_TSCTR_DIV3_ARES		203
+#define GCC_QDSS_TSCTR_DIV4_ARES		204
+#define GCC_QDSS_TSCTR_DIV8_ARES		205
+#define GCC_QDSS_TSCTR_DIV16_ARES		206
+#define GCC_QDSS_DAP_ARES			207
+#define GCC_QDSS_APB2JTAG_ARES			208
+#define GCC_QDSS_ETR_USB_ARES			209
+#define GCC_QDSS_DAP_AHB_ARES			210
+#define GCC_QDSS_CFG_AHB_ARES			211
+#define GCC_QDSS_EUD_AT_ARES			212
+#define GCC_QDSS_TS_ARES			213
+#define GCC_QDSS_USB_ARES			214
+#define GCC_SYS_NOC_AXI_ARES			215
+#define GCC_SNOC_QOSGEN_EXTREF_ARES		216
+#define GCC_CNOC_LPASS_CFG_ARES			217
+#define GCC_SYS_NOC_AT_ARES			218
+#define GCC_SNOC_PCNOC_AHB_ARES			219
+#define GCC_SNOC_TME_ARES			220
+#define GCC_SNOC_XO_DCD_ARES			221
+#define GCC_SNOC_TS_ARES			222
+#define GCC_ANOC0_AXI_ARES			223
+#define GCC_ANOC_PCIE0_1LANE_M_ARES		224
+#define GCC_ANOC_PCIE2_2LANE_M_ARES		225
+#define GCC_ANOC_PCIE1_1LANE_M_ARES		226
+#define GCC_ANOC_PCIE3_2LANE_M_ARES		227
+#define GCC_ANOC_PCNOC_AHB_ARES			228
+#define GCC_ANOC_QOSGEN_EXTREF_ARES		229
+#define GCC_ANOC_XO_DCD_ARES			230
+#define GCC_SNOC_XO_DBG_ARES			231
+#define GCC_AGGRNOC_ATB_ARES			232
+#define GCC_AGGRNOC_TS_ARES			233
+#define GCC_USB0_EUD_AT_ARES			234
+#define GCC_PCNOC_TIC_ARES			235
+#define GCC_PCNOC_AHB_ARES			236
+#define GCC_PCNOC_XO_DBG_ARES			237
+#define GCC_SNOC_LPASS_ARES			238
+#define GCC_PCNOC_AT_ARES			239
+#define GCC_PCNOC_XO_DCD_ARES			240
+#define GCC_PCNOC_TS_ARES			241
+#define GCC_PCNOC_BUS_TIMEOUT0_AHB_ARES		242
+#define GCC_PCNOC_BUS_TIMEOUT1_AHB_ARES		243
+#define GCC_PCNOC_BUS_TIMEOUT2_AHB_ARES		244
+#define GCC_PCNOC_BUS_TIMEOUT3_AHB_ARES		245
+#define GCC_PCNOC_BUS_TIMEOUT4_AHB_ARES		246
+#define GCC_PCNOC_BUS_TIMEOUT5_AHB_ARES		247
+#define GCC_PCNOC_BUS_TIMEOUT6_AHB_ARES		248
+#define GCC_PCNOC_BUS_TIMEOUT7_AHB_ARES		249
+#define GCC_Q6_AXIM_RESET			250
+#define GCC_Q6_AXIS_RESET			251
+#define GCC_Q6_AHB_S_RESET			252
+#define GCC_Q6_AHB_RESET			253
+#define GCC_Q6SS_DBG_RESET			254
+#define GCC_WCSS_ECAHB_RESET			255
+#define GCC_WCSS_DBG_BDG_RESET			256
+#define GCC_WCSS_DBG_RESET			257
+#define GCC_WCSS_AXI_M_RESET			258
+#define GCC_WCSS_AHB_S_RESET			259
+#define GCC_WCSS_ACMT_RESET			260
+#define GCC_WCSSAON_RESET			261
+#define GCC_PCIE0_PIPE_RESET			262
+#define GCC_PCIE0_CORE_STICKY_RESET		263
+#define GCC_PCIE0_AXI_S_STICKY_RESET		264
+#define GCC_PCIE0_AXI_S_RESET			265
+#define GCC_PCIE0_AXI_M_STICKY_RESET		266
+#define GCC_PCIE0_AXI_M_RESET			267
+#define GCC_PCIE0_AUX_RESET			268
+#define GCC_PCIE0_AHB_RESET			269
+#define GCC_PCIE1_PIPE_RESET			270
+#define GCC_PCIE1_CORE_STICKY_RESET		271
+#define GCC_PCIE1_AXI_S_STICKY_RESET		272
+#define GCC_PCIE1_AXI_S_RESET			273
+#define GCC_PCIE1_AXI_M_STICKY_RESET		274
+#define GCC_PCIE1_AXI_M_RESET			275
+#define GCC_PCIE1_AUX_RESET			276
+#define GCC_PCIE1_AHB_RESET			277
+#define GCC_PCIE2_PIPE_RESET			278
+#define GCC_PCIE2_CORE_STICKY_RESET		279
+#define GCC_PCIE2_AXI_S_STICKY_RESET		280
+#define GCC_PCIE2_AXI_S_RESET			281
+#define GCC_PCIE2_AXI_M_STICKY_RESET		282
+#define GCC_PCIE2_AXI_M_RESET			283
+#define GCC_PCIE2_AUX_RESET			284
+#define GCC_PCIE2_AHB_RESET			285
+#define GCC_PCIE3_PIPE_RESET			286
+#define GCC_PCIE3_CORE_STICKY_RESET		287
+#define GCC_PCIE3_AXI_S_STICKY_RESET		288
+#define GCC_PCIE3_AXI_S_RESET			289
+#define GCC_PCIE3_AXI_M_STICKY_RESET		290
+#define GCC_PCIE3_AXI_M_RESET			291
+#define GCC_PCIE3_AUX_RESET			292
+#define GCC_PCIE3_AHB_RESET			293
+#define GCC_NSS_PARTIAL_RESET			294
+#define GCC_UNIPHY0_XPCS_ARES			295
+#define GCC_UNIPHY1_XPCS_ARES			296
+#define GCC_UNIPHY2_XPCS_ARES			297
+#define GCC_USB1_BCR				298
+#define GCC_QUSB2_1_PHY_BCR			299
+
+#endif
-- 
2.34.1


