Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4E6FDEDA
	for <lists+linux-mmc@lfdr.de>; Wed, 10 May 2023 15:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjEJNmd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 10 May 2023 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjEJNm1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 09:42:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0149F9;
        Wed, 10 May 2023 06:42:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AD8Nb8019417;
        Wed, 10 May 2023 13:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+nwlNr0Re3LItNYjvBs+KrpGC+K7uDFNzBuvOSPPuvw=;
 b=GEeXIj8L6VSuUtFlzgUjkqInBBa+QRZdMKCp7/+CdyDwBsF6AFb7Er8U2y05QzFsH8Pc
 ITCTVLwAKArJyZf01Aoe/xN1eroHWA60Qj9j5P+HMgHmZEfIGkXIIYdOY9DimZh3yPWa
 8PA+ibnTYPJ79qYumIoM7xCm1PXAW8Bb9FogtDWfMoPvzt1NARezK8nfQ50lycZa9A+4
 Fic6LA94WVgDdHoztU0ERR0WCV5rR2xy0t2qQ7cH/yAcQqgmO7khOCug3EYcztkWLmRO
 LjuXded1FyylxVF53yPoTXYMLF6pukGUcRrqK3QHA8858e6C4X/W4A16wq+CJSvCYvtB Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg6u0gp2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 13:42:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ADg3pu011100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 13:42:03 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 06:41:58 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_srichara@quicinc.com>
Subject: [PATCH v4 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Date:   Wed, 10 May 2023 19:11:17 +0530
Message-ID: <20230510134121.1232286-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510134121.1232286-1-quic_srichara@quicinc.com>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AWCBXYX4qrxho9rd_RN-8DorgcoScjzS
X-Proofpoint-ORIG-GUID: AWCBXYX4qrxho9rd_RN-8DorgcoScjzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add pinctrl definitions for the TLMM of IPQ5018.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 drivers/pinctrl/qcom/Kconfig           |  10 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5018.c | 791 +++++++++++++++++++++++++
 3 files changed, 802 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5018.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e52cfab8d5ae..00f91007a2ec 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -39,6 +39,16 @@ config PINCTRL_IPQ4019
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found in the Qualcomm IPQ4019 platform.
 
+config PINCTRL_IPQ5018
+	tristate "Qualcomm Technologies, Inc. IPQ5018 pin controller driver"
+	depends on GPIOLIB && OF
+	select PINCTRL_MSM
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for
+	  the Qualcomm Technologies Inc. TLMM block found on the
+	  Qualcomm Technologies Inc. IPQ5018 platform. Select this for
+	  IPQ5018.
+
 config PINCTRL_IPQ8064
 	tristate "Qualcomm IPQ8064 pin controller driver"
 	depends on OF
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 521b021b74ba..be91b62130c2 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_MSM)	+= pinctrl-msm.o
 obj-$(CONFIG_PINCTRL_APQ8064)	+= pinctrl-apq8064.o
 obj-$(CONFIG_PINCTRL_APQ8084)	+= pinctrl-apq8084.o
 obj-$(CONFIG_PINCTRL_IPQ4019)	+= pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_IPQ5018)	+= pinctrl-ipq5018.o
 obj-$(CONFIG_PINCTRL_IPQ8064)	+= pinctrl-ipq8064.o
 obj-$(CONFIG_PINCTRL_IPQ5332)	+= pinctrl-ipq5332.o
 obj-$(CONFIG_PINCTRL_IPQ8074)	+= pinctrl-ipq8074.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5018.c b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
new file mode 100644
index 000000000000..5e2cf9f67704
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
@@ -0,0 +1,791 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2021, 2023 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-msm.h"
+
+#define FUNCTION(fname)			                \
+	[msm_mux_##fname] = {		                \
+		.name = #fname,				\
+		.groups = fname##_groups,               \
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+	}
+
+#define REG_SIZE 0x1000
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
+	{					        \
+		.name = "gpio" #id,			\
+		.pins = gpio##id##_pins,		\
+		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
+		.funcs = (int[]){			\
+			msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9			\
+		},				        \
+		.nfuncs = 10,				\
+		.ctl_reg = REG_SIZE * id,		\
+		.io_reg = 0x4 + REG_SIZE * id,		\
+		.intr_cfg_reg = 0x8 + REG_SIZE * id,	\
+		.intr_status_reg = 0xc + REG_SIZE * id,	\
+		.intr_target_reg = 0x8 + REG_SIZE * id,	\
+		.mux_bit = 2,			\
+		.pull_bit = 0,			\
+		.drv_bit = 6,			\
+		.oe_bit = 9,			\
+		.in_bit = 0,			\
+		.out_bit = 1,			\
+		.intr_enable_bit = 0,		\
+		.intr_status_bit = 0,		\
+		.intr_target_bit = 5,		\
+		.intr_target_kpss_val = 3,	\
+		.intr_raw_status_bit = 4,	\
+		.intr_polarity_bit = 1,		\
+		.intr_detection_bit = 2,	\
+		.intr_detection_width = 2,	\
+	}
+
+static const struct pinctrl_pin_desc ipq5018_pins[] = {
+	PINCTRL_PIN(0, "GPIO_0"),
+	PINCTRL_PIN(1, "GPIO_1"),
+	PINCTRL_PIN(2, "GPIO_2"),
+	PINCTRL_PIN(3, "GPIO_3"),
+	PINCTRL_PIN(4, "GPIO_4"),
+	PINCTRL_PIN(5, "GPIO_5"),
+	PINCTRL_PIN(6, "GPIO_6"),
+	PINCTRL_PIN(7, "GPIO_7"),
+	PINCTRL_PIN(8, "GPIO_8"),
+	PINCTRL_PIN(9, "GPIO_9"),
+	PINCTRL_PIN(10, "GPIO_10"),
+	PINCTRL_PIN(11, "GPIO_11"),
+	PINCTRL_PIN(12, "GPIO_12"),
+	PINCTRL_PIN(13, "GPIO_13"),
+	PINCTRL_PIN(14, "GPIO_14"),
+	PINCTRL_PIN(15, "GPIO_15"),
+	PINCTRL_PIN(16, "GPIO_16"),
+	PINCTRL_PIN(17, "GPIO_17"),
+	PINCTRL_PIN(18, "GPIO_18"),
+	PINCTRL_PIN(19, "GPIO_19"),
+	PINCTRL_PIN(20, "GPIO_20"),
+	PINCTRL_PIN(21, "GPIO_21"),
+	PINCTRL_PIN(22, "GPIO_22"),
+	PINCTRL_PIN(23, "GPIO_23"),
+	PINCTRL_PIN(24, "GPIO_24"),
+	PINCTRL_PIN(25, "GPIO_25"),
+	PINCTRL_PIN(26, "GPIO_26"),
+	PINCTRL_PIN(27, "GPIO_27"),
+	PINCTRL_PIN(28, "GPIO_28"),
+	PINCTRL_PIN(29, "GPIO_29"),
+	PINCTRL_PIN(30, "GPIO_30"),
+	PINCTRL_PIN(31, "GPIO_31"),
+	PINCTRL_PIN(32, "GPIO_32"),
+	PINCTRL_PIN(33, "GPIO_33"),
+	PINCTRL_PIN(34, "GPIO_34"),
+	PINCTRL_PIN(35, "GPIO_35"),
+	PINCTRL_PIN(36, "GPIO_36"),
+	PINCTRL_PIN(37, "GPIO_37"),
+	PINCTRL_PIN(38, "GPIO_38"),
+	PINCTRL_PIN(39, "GPIO_39"),
+	PINCTRL_PIN(40, "GPIO_40"),
+	PINCTRL_PIN(41, "GPIO_41"),
+	PINCTRL_PIN(42, "GPIO_42"),
+	PINCTRL_PIN(43, "GPIO_43"),
+	PINCTRL_PIN(44, "GPIO_44"),
+	PINCTRL_PIN(45, "GPIO_45"),
+	PINCTRL_PIN(46, "GPIO_46"),
+};
+
+#define DECLARE_MSM_GPIO_PINS(pin) \
+	static const unsigned int gpio##pin##_pins[] = { pin }
+DECLARE_MSM_GPIO_PINS(0);
+DECLARE_MSM_GPIO_PINS(1);
+DECLARE_MSM_GPIO_PINS(2);
+DECLARE_MSM_GPIO_PINS(3);
+DECLARE_MSM_GPIO_PINS(4);
+DECLARE_MSM_GPIO_PINS(5);
+DECLARE_MSM_GPIO_PINS(6);
+DECLARE_MSM_GPIO_PINS(7);
+DECLARE_MSM_GPIO_PINS(8);
+DECLARE_MSM_GPIO_PINS(9);
+DECLARE_MSM_GPIO_PINS(10);
+DECLARE_MSM_GPIO_PINS(11);
+DECLARE_MSM_GPIO_PINS(12);
+DECLARE_MSM_GPIO_PINS(13);
+DECLARE_MSM_GPIO_PINS(14);
+DECLARE_MSM_GPIO_PINS(15);
+DECLARE_MSM_GPIO_PINS(16);
+DECLARE_MSM_GPIO_PINS(17);
+DECLARE_MSM_GPIO_PINS(18);
+DECLARE_MSM_GPIO_PINS(19);
+DECLARE_MSM_GPIO_PINS(20);
+DECLARE_MSM_GPIO_PINS(21);
+DECLARE_MSM_GPIO_PINS(22);
+DECLARE_MSM_GPIO_PINS(23);
+DECLARE_MSM_GPIO_PINS(24);
+DECLARE_MSM_GPIO_PINS(25);
+DECLARE_MSM_GPIO_PINS(26);
+DECLARE_MSM_GPIO_PINS(27);
+DECLARE_MSM_GPIO_PINS(28);
+DECLARE_MSM_GPIO_PINS(29);
+DECLARE_MSM_GPIO_PINS(30);
+DECLARE_MSM_GPIO_PINS(31);
+DECLARE_MSM_GPIO_PINS(32);
+DECLARE_MSM_GPIO_PINS(33);
+DECLARE_MSM_GPIO_PINS(34);
+DECLARE_MSM_GPIO_PINS(35);
+DECLARE_MSM_GPIO_PINS(36);
+DECLARE_MSM_GPIO_PINS(37);
+DECLARE_MSM_GPIO_PINS(38);
+DECLARE_MSM_GPIO_PINS(39);
+DECLARE_MSM_GPIO_PINS(40);
+DECLARE_MSM_GPIO_PINS(41);
+DECLARE_MSM_GPIO_PINS(42);
+DECLARE_MSM_GPIO_PINS(43);
+DECLARE_MSM_GPIO_PINS(44);
+DECLARE_MSM_GPIO_PINS(45);
+DECLARE_MSM_GPIO_PINS(46);
+
+enum ipq5018_functions {
+	msm_mux_atest_char,
+	msm_mux_audio_pdm0,
+	msm_mux_audio_pdm1,
+	msm_mux_audio_rxbclk,
+	msm_mux_audio_rxd,
+	msm_mux_audio_rxfsync,
+	msm_mux_audio_rxmclk,
+	msm_mux_audio_txbclk,
+	msm_mux_audio_txd,
+	msm_mux_audio_txfsync,
+	msm_mux_audio_txmclk,
+	msm_mux_blsp0_i2c,
+	msm_mux_blsp0_spi,
+	msm_mux_blsp0_uart0,
+	msm_mux_blsp0_uart1,
+	msm_mux_blsp1_i2c0,
+	msm_mux_blsp1_i2c1,
+	msm_mux_blsp1_spi0,
+	msm_mux_blsp1_spi1,
+	msm_mux_blsp1_uart0,
+	msm_mux_blsp1_uart1,
+	msm_mux_blsp1_uart2,
+	msm_mux_blsp2_i2c0,
+	msm_mux_blsp2_i2c1,
+	msm_mux_blsp2_spi,
+	msm_mux_blsp2_spi0,
+	msm_mux_blsp2_spi1,
+	msm_mux_btss,
+	msm_mux_burn0,
+	msm_mux_burn1,
+	msm_mux_cri_trng,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cxc_clk,
+	msm_mux_cxc_data,
+	msm_mux_dbg_out,
+	msm_mux_eud_gpio,
+	msm_mux_gcc_plltest,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_led0,
+	msm_mux_led2,
+	msm_mux_mac0,
+	msm_mux_mac1,
+	msm_mux_mdc,
+	msm_mux_mdio,
+	msm_mux_pcie0_clk,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk,
+	msm_mux_pcie1_wake,
+	msm_mux_pll_test,
+	msm_mux_prng_rosc,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_traceclk_b,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracectl_b,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qdss_tracedata_b,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_qspi_data,
+	msm_mux_reset_out,
+	msm_mux_sdc1_clk,
+	msm_mux_sdc1_cmd,
+	msm_mux_sdc1_data,
+	msm_mux_wci_txd,
+	msm_mux_wci_rxd,
+	msm_mux_wsa_swrm,
+	msm_mux_wsi_clk3,
+	msm_mux_wsi_data3,
+	msm_mux_wsis_reset,
+	msm_mux_xfem,
+	msm_mux__,
+};
+
+static const char * const atest_char_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio37",
+};
+
+static const char * const _groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46",
+};
+
+static const char * const wci_txd_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3",
+	"gpio42", "gpio43", "gpio44", "gpio45",
+};
+
+static const char * const wci_rxd_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3",
+	"gpio42", "gpio43", "gpio44", "gpio45",
+};
+
+static const char * const xfem_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3",
+	"gpio42", "gpio43", "gpio44", "gpio45",
+};
+
+static const char * const qdss_cti_trig_out_a0_groups[] = {
+	"gpio0",
+};
+
+static const char * const qdss_cti_trig_in_a0_groups[] = {
+	"gpio1",
+};
+
+static const char * const qdss_cti_trig_out_a1_groups[] = {
+	"gpio2",
+};
+
+static const char * const qdss_cti_trig_in_a1_groups[] = {
+	"gpio3",
+};
+
+static const char * const sdc1_data_groups[] = {
+	"gpio4", "gpio5", "gpio6", "gpio7",
+};
+
+static const char * const qspi_data_groups[] = {
+	"gpio4",
+	"gpio5",
+	"gpio6",
+	"gpio7",
+};
+
+static const char * const blsp1_spi1_groups[] = {
+	"gpio4", "gpio5", "gpio6", "gpio7",
+};
+
+static const char * const btss_groups[] = {
+	"gpio4", "gpio5", "gpio6", "gpio7", "gpio8", "gpio17", "gpio18",
+	"gpio19", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+};
+
+static const char * const dbg_out_groups[] = {
+	"gpio4",
+};
+
+static const char * const qdss_traceclk_a_groups[] = {
+	"gpio4",
+};
+
+static const char * const burn0_groups[] = {
+	"gpio4",
+};
+
+static const char * const cxc_clk_groups[] = {
+	"gpio5",
+};
+
+static const char * const blsp1_i2c1_groups[] = {
+	"gpio5", "gpio6",
+};
+
+static const char * const qdss_tracectl_a_groups[] = {
+	"gpio5",
+};
+
+static const char * const burn1_groups[] = {
+	"gpio5",
+};
+
+static const char * const cxc_data_groups[] = {
+	"gpio6",
+};
+
+static const char * const qdss_tracedata_a_groups[] = {
+	"gpio6", "gpio7", "gpio8", "gpio9", "gpio10", "gpio11", "gpio12",
+	"gpio13", "gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19",
+	"gpio20", "gpio21",
+};
+
+static const char * const mac0_groups[] = {
+	"gpio7",
+};
+
+static const char * const sdc1_cmd_groups[] = {
+	"gpio8",
+};
+
+static const char * const qspi_cs_groups[] = {
+	"gpio8",
+};
+
+static const char * const mac1_groups[] = {
+	"gpio8",
+};
+
+static const char * const sdc1_clk_groups[] = {
+	"gpio9",
+};
+
+static const char * const qspi_clk_groups[] = {
+	"gpio9",
+};
+
+static const char * const blsp0_spi_groups[] = {
+	"gpio10", "gpio11", "gpio12", "gpio13",
+};
+
+static const char * const blsp1_uart0_groups[] = {
+	"gpio10", "gpio11", "gpio12", "gpio13",
+};
+
+static const char * const gcc_plltest_groups[] = {
+	"gpio10", "gpio12",
+};
+
+static const char * const gcc_tlmm_groups[] = {
+	"gpio11",
+};
+
+static const char * const blsp0_i2c_groups[] = {
+	"gpio12", "gpio13",
+};
+
+static const char * const pcie0_clk_groups[] = {
+	"gpio14",
+};
+
+static const char * const cri_trng0_groups[] = {
+	"gpio14",
+};
+
+static const char * const cri_trng1_groups[] = {
+	"gpio15",
+};
+
+static const char * const pcie0_wake_groups[] = {
+	"gpio16",
+};
+
+static const char * const cri_trng_groups[] = {
+	"gpio16",
+};
+
+static const char * const pcie1_clk_groups[] = {
+	"gpio17",
+};
+
+static const char * const prng_rosc_groups[] = {
+	"gpio17",
+};
+
+static const char * const blsp1_spi0_groups[] = {
+	"gpio18", "gpio19", "gpio20", "gpio21",
+};
+
+static const char * const pcie1_wake_groups[] = {
+	"gpio19",
+};
+
+static const char * const blsp1_i2c0_groups[] = {
+	"gpio19", "gpio20",
+};
+
+static const char * const blsp0_uart0_groups[] = {
+	"gpio20", "gpio21",
+};
+
+static const char * const pll_test_groups[] = {
+	"gpio22",
+};
+
+static const char * const eud_gpio_groups[] = {
+	"gpio22", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+};
+
+static const char * const audio_rxmclk_groups[] = {
+	"gpio23", "gpio23",
+};
+
+static const char * const audio_pdm0_groups[] = {
+	"gpio23", "gpio24",
+};
+
+static const char * const blsp2_spi1_groups[] = {
+	"gpio23", "gpio24", "gpio25", "gpio26",
+};
+
+static const char * const blsp1_uart2_groups[] = {
+	"gpio23", "gpio24", "gpio25", "gpio26",
+};
+
+static const char * const qdss_tracedata_b_groups[] = {
+	"gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28", "gpio29",
+	"gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35", "gpio36",
+	"gpio37", "gpio38",
+};
+
+static const char * const audio_rxbclk_groups[] = {
+	"gpio24",
+};
+
+static const char * const audio_rxfsync_groups[] = {
+	"gpio25",
+};
+
+static const char * const audio_pdm1_groups[] = {
+	"gpio25", "gpio26",
+};
+
+static const char * const blsp2_i2c1_groups[] = {
+	"gpio25", "gpio26",
+};
+
+static const char * const audio_rxd_groups[] = {
+	"gpio26",
+};
+
+static const char * const audio_txmclk_groups[] = {
+	"gpio27", "gpio27",
+};
+
+static const char * const wsa_swrm_groups[] = {
+	"gpio27", "gpio28",
+};
+
+static const char * const blsp2_spi_groups[] = {
+	"gpio27",
+};
+
+static const char * const audio_txbclk_groups[] = {
+	"gpio28",
+};
+
+static const char * const blsp0_uart1_groups[] = {
+	"gpio28", "gpio29",
+};
+
+static const char * const audio_txfsync_groups[] = {
+	"gpio29",
+};
+
+static const char * const audio_txd_groups[] = {
+	"gpio30",
+};
+
+static const char * const wsis_reset_groups[] = {
+	"gpio30",
+};
+
+static const char * const blsp2_spi0_groups[] = {
+	"gpio31", "gpio32", "gpio33", "gpio34",
+};
+
+static const char * const blsp1_uart1_groups[] = {
+	"gpio31", "gpio32", "gpio33", "gpio34",
+};
+
+static const char * const blsp2_i2c0_groups[] = {
+	"gpio33", "gpio34",
+};
+
+static const char * const mdc_groups[] = {
+	"gpio36",
+};
+
+static const char * const wsi_clk3_groups[] = {
+	"gpio36",
+};
+
+static const char * const mdio_groups[] = {
+	"gpio37",
+};
+
+static const char * const wsi_data3_groups[] = {
+	"gpio37",
+};
+
+static const char * const qdss_traceclk_b_groups[] = {
+	"gpio39",
+};
+
+static const char * const reset_out_groups[] = {
+	"gpio40",
+};
+
+static const char * const qdss_tracectl_b_groups[] = {
+	"gpio40",
+};
+
+static const char * const pwm0_groups[] = {
+	"gpio42",
+};
+
+static const char * const qdss_cti_trig_out_b0_groups[] = {
+	"gpio42",
+};
+
+static const char * const pwm1_groups[] = {
+	"gpio43",
+};
+
+static const char * const qdss_cti_trig_in_b0_groups[] = {
+	"gpio43",
+};
+
+static const char * const pwm2_groups[] = {
+	"gpio44",
+};
+
+static const char * const qdss_cti_trig_out_b1_groups[] = {
+	"gpio44",
+};
+
+static const char * const pwm3_groups[] = {
+	"gpio45",
+};
+
+static const char * const qdss_cti_trig_in_b1_groups[] = {
+	"gpio45",
+};
+
+static const char * const led0_groups[] = {
+	"gpio46", "gpio30", "gpio10",
+};
+
+static const char * const led2_groups[] = {
+	"gpio30",
+};
+
+static const char * const gpio_groups[] = {
+	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
+	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
+	"gpio43", "gpio44", "gpio45", "gpio46",
+};
+
+static const struct msm_function ipq5018_functions[] = {
+	FUNCTION(atest_char),
+	FUNCTION(audio_pdm0),
+	FUNCTION(audio_pdm1),
+	FUNCTION(audio_rxbclk),
+	FUNCTION(audio_rxd),
+	FUNCTION(audio_rxfsync),
+	FUNCTION(audio_rxmclk),
+	FUNCTION(audio_txbclk),
+	FUNCTION(audio_txd),
+	FUNCTION(audio_txfsync),
+	FUNCTION(audio_txmclk),
+	FUNCTION(blsp0_i2c),
+	FUNCTION(blsp0_spi),
+	FUNCTION(blsp0_uart0),
+	FUNCTION(blsp0_uart1),
+	FUNCTION(blsp1_i2c0),
+	FUNCTION(blsp1_i2c1),
+	FUNCTION(blsp1_spi0),
+	FUNCTION(blsp1_spi1),
+	FUNCTION(blsp1_uart0),
+	FUNCTION(blsp1_uart1),
+	FUNCTION(blsp1_uart2),
+	FUNCTION(blsp2_i2c0),
+	FUNCTION(blsp2_i2c1),
+	FUNCTION(blsp2_spi),
+	FUNCTION(blsp2_spi0),
+	FUNCTION(blsp2_spi1),
+	FUNCTION(btss),
+	FUNCTION(burn0),
+	FUNCTION(burn1),
+	FUNCTION(cri_trng),
+	FUNCTION(cri_trng0),
+	FUNCTION(cri_trng1),
+	FUNCTION(cxc_clk),
+	FUNCTION(cxc_data),
+	FUNCTION(dbg_out),
+	FUNCTION(eud_gpio),
+	FUNCTION(gcc_plltest),
+	FUNCTION(gcc_tlmm),
+	FUNCTION(gpio),
+	FUNCTION(led0),
+	FUNCTION(led2),
+	FUNCTION(mac0),
+	FUNCTION(mac1),
+	FUNCTION(mdc),
+	FUNCTION(mdio),
+	FUNCTION(pcie0_clk),
+	FUNCTION(pcie0_wake),
+	FUNCTION(pcie1_clk),
+	FUNCTION(pcie1_wake),
+	FUNCTION(pll_test),
+	FUNCTION(prng_rosc),
+	FUNCTION(pwm0),
+	FUNCTION(pwm1),
+	FUNCTION(pwm2),
+	FUNCTION(pwm3),
+	FUNCTION(qdss_cti_trig_in_a0),
+	FUNCTION(qdss_cti_trig_in_a1),
+	FUNCTION(qdss_cti_trig_in_b0),
+	FUNCTION(qdss_cti_trig_in_b1),
+	FUNCTION(qdss_cti_trig_out_a0),
+	FUNCTION(qdss_cti_trig_out_a1),
+	FUNCTION(qdss_cti_trig_out_b0),
+	FUNCTION(qdss_cti_trig_out_b1),
+	FUNCTION(qdss_traceclk_a),
+	FUNCTION(qdss_traceclk_b),
+	FUNCTION(qdss_tracectl_a),
+	FUNCTION(qdss_tracectl_b),
+	FUNCTION(qdss_tracedata_a),
+	FUNCTION(qdss_tracedata_b),
+	FUNCTION(qspi_clk),
+	FUNCTION(qspi_cs),
+	FUNCTION(qspi_data),
+	FUNCTION(reset_out),
+	FUNCTION(sdc1_clk),
+	FUNCTION(sdc1_cmd),
+	FUNCTION(sdc1_data),
+	FUNCTION(wci_txd),
+	FUNCTION(wci_rxd),
+	FUNCTION(wsa_swrm),
+	FUNCTION(wsi_clk3),
+	FUNCTION(wsi_data3),
+	FUNCTION(wsis_reset),
+	FUNCTION(xfem),
+};
+
+static const struct msm_pingroup ipq5018_groups[] = {
+	PINGROUP(0, atest_char, _, qdss_cti_trig_out_a0, wci_txd, wci_rxd, xfem, _, _, _),
+	PINGROUP(1, atest_char, _, qdss_cti_trig_in_a0, wci_txd, wci_rxd, xfem, _, _, _),
+	PINGROUP(2, atest_char, _, qdss_cti_trig_out_a1, wci_txd, wci_rxd, xfem, _, _, _),
+	PINGROUP(3, atest_char, _, qdss_cti_trig_in_a1, wci_txd, wci_rxd, xfem, _, _, _),
+	PINGROUP(4, sdc1_data, qspi_data, blsp1_spi1, btss, dbg_out, qdss_traceclk_a, _, burn0, _),
+	PINGROUP(5, sdc1_data, qspi_data, cxc_clk, blsp1_spi1, blsp1_i2c1, btss, _, qdss_tracectl_a, _),
+	PINGROUP(6, sdc1_data, qspi_data, cxc_data, blsp1_spi1, blsp1_i2c1, btss, _, qdss_tracedata_a, _),
+	PINGROUP(7, sdc1_data, qspi_data, mac0, blsp1_spi1, btss, _, qdss_tracedata_a, _, _),
+	PINGROUP(8, sdc1_cmd, qspi_cs, mac1, btss, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(9, sdc1_clk, qspi_clk, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(10, blsp0_spi, blsp1_uart0, led0, gcc_plltest, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(11, blsp0_spi, blsp1_uart0, _, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(12, blsp0_spi, blsp0_i2c, blsp1_uart0, _, gcc_plltest, qdss_tracedata_a, _, _, _),
+	PINGROUP(13, blsp0_spi, blsp0_i2c, blsp1_uart0, _, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(14, pcie0_clk, _, _, cri_trng0, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(15, _, _, cri_trng1, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(16, pcie0_wake, _, _, cri_trng, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(17, pcie1_clk, btss, _, prng_rosc, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(18, blsp1_spi0, btss, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(19, pcie1_wake, blsp1_spi0, blsp1_i2c0, btss, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(20, blsp0_uart0, blsp1_spi0, blsp1_i2c0, _, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(21, blsp0_uart0, blsp1_spi0, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(22, _, pll_test, eud_gpio, _, _, _, _, _, _),
+	PINGROUP(23, audio_rxmclk, audio_pdm0, audio_rxmclk, blsp2_spi1, blsp1_uart2, btss, _, qdss_tracedata_b, _),
+	PINGROUP(24, audio_rxbclk, audio_pdm0, blsp2_spi1, blsp1_uart2, btss, _, qdss_tracedata_b, _, _),
+	PINGROUP(25, audio_rxfsync, audio_pdm1, blsp2_i2c1, blsp2_spi1, blsp1_uart2, btss, _, qdss_tracedata_b, _),
+	PINGROUP(26, audio_rxd, audio_pdm1, blsp2_i2c1, blsp2_spi1, blsp1_uart2, btss, _, qdss_tracedata_b, _),
+	PINGROUP(27, audio_txmclk, wsa_swrm, audio_txmclk, blsp2_spi, btss, _, qdss_tracedata_b, _, _),
+	PINGROUP(28, audio_txbclk, wsa_swrm, blsp0_uart1, btss, qdss_tracedata_b, _, _, _, _),
+	PINGROUP(29, audio_txfsync, _, blsp0_uart1, _, qdss_tracedata_b, _, _, _, _),
+	PINGROUP(30, audio_txd, led2, led0, _, _, _, _, _, _),
+	PINGROUP(31, blsp2_spi0, blsp1_uart1, _, qdss_tracedata_b, eud_gpio, _, _, _, _),
+	PINGROUP(32, blsp2_spi0, blsp1_uart1, _, qdss_tracedata_b, eud_gpio, _, _, _, _),
+	PINGROUP(33, blsp2_i2c0, blsp2_spi0, blsp1_uart1, _, qdss_tracedata_b, eud_gpio, _, _, _),
+	PINGROUP(34, blsp2_i2c0, blsp2_spi0, blsp1_uart1, _, qdss_tracedata_b, eud_gpio, _, _, _),
+	PINGROUP(35, _, qdss_tracedata_b, eud_gpio, _, _, _, _, _, _),
+	PINGROUP(36, mdc, qdss_tracedata_b, _, wsi_clk3, _, _, _, _, _),
+	PINGROUP(37, mdio, atest_char, qdss_tracedata_b, _, wsi_data3, _, _, _, _),
+	PINGROUP(38, qdss_tracedata_b, _, _, _, _, _, _, _, _),
+	PINGROUP(39, qdss_traceclk_b, _, _, _, _, _, _, _, _),
+	PINGROUP(40, reset_out, qdss_tracectl_b, _, _, _, _, _, _, _),
+	PINGROUP(41, _, _, _, _, _, _, _, _, _),
+	PINGROUP(42, pwm0, qdss_cti_trig_out_b0, wci_txd, wci_rxd, xfem, _, _, _, _),
+	PINGROUP(43, pwm1, qdss_cti_trig_in_b0, wci_txd, wci_rxd, xfem, _, _, _, _),
+	PINGROUP(44, pwm2, qdss_cti_trig_out_b1, wci_txd, wci_rxd, xfem, _, _, _, _),
+	PINGROUP(45, pwm3, qdss_cti_trig_in_b1, wci_txd, wci_rxd, xfem, _, _, _, _),
+	PINGROUP(46, led0, _, _, _, _, _, _, _, _),
+};
+
+static const struct msm_pinctrl_soc_data ipq5018_pinctrl = {
+	.pins = ipq5018_pins,
+	.npins = ARRAY_SIZE(ipq5018_pins),
+	.functions = ipq5018_functions,
+	.nfunctions = ARRAY_SIZE(ipq5018_functions),
+	.groups = ipq5018_groups,
+	.ngroups = ARRAY_SIZE(ipq5018_groups),
+	.ngpios = 47,
+};
+
+static int ipq5018_pinctrl_probe(struct platform_device *pdev)
+{
+	return msm_pinctrl_probe(pdev, &ipq5018_pinctrl);
+}
+
+static const struct of_device_id ipq5018_pinctrl_of_match[] = {
+	{ .compatible = "qcom,ipq5018-tlmm", },
+	{ },
+};
+
+static struct platform_driver ipq5018_pinctrl_driver = {
+	.driver = {
+		.name = "ipq5018-tlmm",
+		.of_match_table = ipq5018_pinctrl_of_match,
+	},
+	.probe = ipq5018_pinctrl_probe,
+	.remove = msm_pinctrl_remove,
+};
+
+static int __init ipq5018_pinctrl_init(void)
+{
+	return platform_driver_register(&ipq5018_pinctrl_driver);
+}
+arch_initcall(ipq5018_pinctrl_init);
+
+static void __exit ipq5018_pinctrl_exit(void)
+{
+	platform_driver_unregister(&ipq5018_pinctrl_driver);
+}
+module_exit(ipq5018_pinctrl_exit);
+
+MODULE_DESCRIPTION("Qualcomm Technologies Inc ipq5018 pinctrl driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, ipq5018_pinctrl_of_match);
-- 
2.34.1

