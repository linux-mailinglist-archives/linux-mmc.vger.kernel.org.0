Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841225179D8
	for <lists+linux-mmc@lfdr.de>; Tue,  3 May 2022 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiEBWTO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 2 May 2022 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355473AbiEBWTI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2022 18:19:08 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2A2AE1;
        Mon,  2 May 2022 15:15:36 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id m6-20020a05683023a600b0060612720715so3377856ots.10;
        Mon, 02 May 2022 15:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fLdXsrZ0td3xAHhnDJxq9po+L0qVIsEUYsJpn6yQ2c=;
        b=6NUdq62zOWKH1iUz5g6KbEz0YDOTQSJ2Ezy5mKlBnA0VGqzf/97Tlc/yWeUOstNo8/
         HGJKBROtWIrGTw9Cdh8FMdHuFSyB4AEMTmprQWDwpBjjKFJuE5As1l+ph82STdQRwX6l
         hCCTV6ct/WMsE8NzoR0MLW2G9brJRf62k5gn7171ZNZtuoMbSTibPLXD0qHZkO1uctBU
         zqch2LMAUm/KhRMU7XDpqAKd4uvqY3Cy1SsLCiniPUSwSEnwJvplOWOn5+mA5IGDK1pr
         BESLFfChxT4u+eOxAnn2fBQ/9djfXMVOWulxs/NCk6bl4KMZxCKNyLQhEXGDYCwNhU6c
         OoCA==
X-Gm-Message-State: AOAM5315ToWxmTylrJ5xSiMacAVFUZyaJ9ONuI0ux8L9OQ/bJuBhwIZz
        Q8FDQ8yIgZr50xIz0KV/Hw==
X-Google-Smtp-Source: ABdhPJwhDPT+RtBbfYTVhejzzIcqQ21AinBNdYr0ECJowPiJkCTS7RbMJDWcqC+gmHwPYSexhhRU+g==
X-Received: by 2002:a9d:2a9:0:b0:603:e74c:e4e7 with SMTP id 38-20020a9d02a9000000b00603e74ce4e7mr5089593otl.85.1651529735316;
        Mon, 02 May 2022 15:15:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y2-20020a056870e3c200b000eb0e40b4b8sm3870427oad.48.2022.05.02.15.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:15:34 -0700 (PDT)
Received: (nullmailer pid 1888750 invoked by uid 1000);
        Mon, 02 May 2022 22:15:33 -0000
Date:   Mon, 2 May 2022 17:15:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCHv1 05/19] clk: rockchip: add dt-binding header for rk3588
Message-ID: <YnBYBWWiieWWRpdM@robh.at.kernel.org>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422170920.401914-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 22, 2022 at 07:09:06PM +0200, Sebastian Reichel wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Add the dt-bindings header for the rk3588, that gets shared between
> the clock controller and the clock references in the dts.
> Add softreset ID for rk3588.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  include/dt-bindings/clock/rk3588-cru.h | 1491 ++++++++++++++++++++++++
>  1 file changed, 1491 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rk3588-cru.h
> 
> diff --git a/include/dt-bindings/clock/rk3588-cru.h b/include/dt-bindings/clock/rk3588-cru.h
> new file mode 100644
> index 000000000000..d51e6ed939b3
> --- /dev/null
> +++ b/include/dt-bindings/clock/rk3588-cru.h
> @@ -0,0 +1,1491 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Assuming you have permission, dual license please.

> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3588_H
> +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3588_H
> +
> +/* cru-clocks indices */
> +
> +/* cru plls */
> +#define PLL_B0PLL			1
> +#define PLL_B1PLL			2
> +#define PLL_LPLL			3
> +#define PLL_V0PLL			4
> +#define PLL_AUPLL			5
> +#define PLL_CPLL			6
> +#define PLL_GPLL			7
> +#define PLL_NPLL			8
> +#define PLL_PPLL			9
> +#define ARMCLK_L			10
> +#define ARMCLK_B01			11
> +#define ARMCLK_B23			12
> +
> +/* cru clocks */
> +#define PCLK_BIGCORE0_ROOT		20
> +#define PCLK_BIGCORE0_PVTM		21
> +#define PCLK_BIGCORE1_ROOT		22
> +#define PCLK_BIGCORE1_PVTM		23
> +#define PCLK_DSU_S_ROOT			24
> +#define PCLK_DSU_ROOT			25
> +#define PCLK_DSU_NS_ROOT		26
> +#define PCLK_LITCORE_PVTM		27
> +#define PCLK_DBG			28
> +#define PCLK_DSU			29
> +#define PCLK_S_DAPLITE			30
> +#define PCLK_M_DAPLITE			31
> +#define MBIST_MCLK_PDM1			32
> +#define MBIST_CLK_ACDCDIG		33
> +#define HCLK_I2S2_2CH			34
> +#define HCLK_I2S3_2CH			35
> +#define CLK_I2S2_2CH_SRC		36
> +#define CLK_I2S2_2CH_FRAC		37
> +#define CLK_I2S2_2CH			38
> +#define MCLK_I2S2_2CH			39
> +#define I2S2_2CH_MCLKOUT		40
> +#define CLK_DAC_ACDCDIG			41
> +#define CLK_I2S3_2CH_SRC		42
> +#define CLK_I2S3_2CH_FRAC		43
> +#define CLK_I2S3_2CH			44
> +#define MCLK_I2S3_2CH			45
> +#define I2S3_2CH_MCLKOUT		46
> +#define PCLK_ACDCDIG			47
> +#define HCLK_I2S0_8CH			48
> +#define CLK_I2S0_8CH_TX_SRC		49
> +#define CLK_I2S0_8CH_TX_FRAC		50
> +#define MCLK_I2S0_8CH_TX		51
> +#define CLK_I2S0_8CH_TX			52
> +#define CLK_I2S0_8CH_RX_SRC		53
> +#define CLK_I2S0_8CH_RX_FRAC		54
> +#define MCLK_I2S0_8CH_RX		55
> +#define CLK_I2S0_8CH_RX			56
> +#define I2S0_8CH_MCLKOUT		57
> +#define HCLK_PDM1			58
> +#define MCLK_PDM1			59
> +#define HCLK_AUDIO_ROOT			60
> +#define PCLK_AUDIO_ROOT			61
> +#define HCLK_SPDIF0			62
> +#define CLK_SPDIF0_SRC			63
> +#define CLK_SPDIF0_FRAC			64
> +#define MCLK_SPDIF0			65
> +#define CLK_SPDIF0			66
> +#define CLK_SPDIF1			67
> +#define HCLK_SPDIF1			68
> +#define CLK_SPDIF1_SRC			69
> +#define CLK_SPDIF1_FRAC			70
> +#define MCLK_SPDIF1			71
> +#define ACLK_AV1_ROOT			72
> +#define ACLK_AV1			73
> +#define PCLK_AV1_ROOT			74
> +#define PCLK_AV1			75
> +#define PCLK_MAILBOX0			76
> +#define PCLK_MAILBOX1			77
> +#define PCLK_MAILBOX2			78
> +#define PCLK_PMU2			79
> +#define PCLK_PMUCM0_INTMUX		80
> +#define PCLK_DDRCM0_INTMUX		81
> +#define PCLK_TOP			82
> +#define PCLK_PWM1			83
> +#define CLK_PWM1			84
> +#define CLK_PWM1_CAPTURE		85
> +#define PCLK_PWM2			86
> +#define CLK_PWM2			87
> +#define CLK_PWM2_CAPTURE		88
> +#define PCLK_PWM3			89
> +#define CLK_PWM3			90
> +#define CLK_PWM3_CAPTURE		91
> +#define PCLK_BUSTIMER0			92
> +#define PCLK_BUSTIMER1			93
> +#define CLK_BUS_TIMER_ROOT		94
> +#define CLK_BUSTIMER0			95
> +#define CLK_BUSTIMER1			96
> +#define CLK_BUSTIMER2			97
> +#define CLK_BUSTIMER3			98
> +#define CLK_BUSTIMER4			99
> +#define CLK_BUSTIMER5			100
> +#define CLK_BUSTIMER6			101
> +#define CLK_BUSTIMER7			102
> +#define CLK_BUSTIMER8			103
> +#define CLK_BUSTIMER9			104
> +#define CLK_BUSTIMER10			105
> +#define CLK_BUSTIMER11			106
> +#define PCLK_WDT0			107
> +#define TCLK_WDT0			108
> +#define PCLK_CAN0			111
> +#define CLK_CAN0			112
> +#define PCLK_CAN1			113
> +#define CLK_CAN1			114
> +#define PCLK_CAN2			115
> +#define CLK_CAN2			116
> +#define ACLK_DECOM			117
> +#define PCLK_DECOM			118
> +#define DCLK_DECOM			119
> +#define ACLK_DMAC0			120
> +#define ACLK_DMAC1			121
> +#define ACLK_DMAC2			122
> +#define ACLK_BUS_ROOT			123
> +#define ACLK_GIC			124
> +#define PCLK_GPIO1			125
> +#define DBCLK_GPIO1			126
> +#define PCLK_GPIO2			127
> +#define DBCLK_GPIO2			128
> +#define PCLK_GPIO3			129
> +#define DBCLK_GPIO3			130
> +#define PCLK_GPIO4			131
> +#define DBCLK_GPIO4			132
> +#define PCLK_I2C1			133
> +#define PCLK_I2C2			134
> +#define PCLK_I2C3			135
> +#define PCLK_I2C4			136
> +#define PCLK_I2C5			137
> +#define PCLK_I2C6			138
> +#define PCLK_I2C7			139
> +#define PCLK_I2C8			140
> +#define CLK_I2C1			141
> +#define CLK_I2C2			142
> +#define CLK_I2C3			143
> +#define CLK_I2C4			144
> +#define CLK_I2C5			145
> +#define CLK_I2C6			146
> +#define CLK_I2C7			147
> +#define CLK_I2C8			148
> +#define PCLK_OTPC_NS			149
> +#define CLK_OTPC_NS			150
> +#define CLK_OTPC_ARB			151
> +#define CLK_OTPC_AUTO_RD_G		152
> +#define CLK_OTP_PHY_G			153
> +#define PCLK_SARADC			156
> +#define CLK_SARADC			157
> +#define PCLK_SPI0			158
> +#define PCLK_SPI1			159
> +#define PCLK_SPI2			160
> +#define PCLK_SPI3			161
> +#define PCLK_SPI4			162
> +#define CLK_SPI0			163
> +#define CLK_SPI1			164
> +#define CLK_SPI2			165
> +#define CLK_SPI3			166
> +#define CLK_SPI4			167
> +#define ACLK_SPINLOCK			168
> +#define PCLK_TSADC			169
> +#define CLK_TSADC			170
> +#define PCLK_UART1			171
> +#define PCLK_UART2			172
> +#define PCLK_UART3			173
> +#define PCLK_UART4			174
> +#define PCLK_UART5			175
> +#define PCLK_UART6			176
> +#define PCLK_UART7			177
> +#define PCLK_UART8			178
> +#define PCLK_UART9			179
> +#define CLK_UART1_SRC			180
> +#define CLK_UART1_FRAC			181
> +#define CLK_UART1			182
> +#define SCLK_UART1			183
> +#define CLK_UART2_SRC			184
> +#define CLK_UART2_FRAC			185
> +#define CLK_UART2			186
> +#define SCLK_UART2			187
> +#define CLK_UART3_SRC			188
> +#define CLK_UART3_FRAC			189
> +#define CLK_UART3			190
> +#define SCLK_UART3			191
> +#define CLK_UART4_SRC			192
> +#define CLK_UART4_FRAC			193
> +#define CLK_UART4			194
> +#define SCLK_UART4			195
> +#define CLK_UART5_SRC			196
> +#define CLK_UART5_FRAC			197
> +#define CLK_UART5			198
> +#define SCLK_UART5			199
> +#define CLK_UART6_SRC			200
> +#define CLK_UART6_FRAC			201
> +#define CLK_UART6			202
> +#define SCLK_UART6			203
> +#define CLK_UART7_SRC			204
> +#define CLK_UART7_FRAC			205
> +#define CLK_UART7			206
> +#define SCLK_UART7			207
> +#define CLK_UART8_SRC			208
> +#define CLK_UART8_FRAC			209
> +#define CLK_UART8			210
> +#define SCLK_UART8			211
> +#define CLK_UART9_SRC			212
> +#define CLK_UART9_FRAC			213
> +#define CLK_UART9			214
> +#define SCLK_UART9			215
> +#define ACLK_CENTER_ROOT		216
> +#define ACLK_CENTER_LOW_ROOT		217
> +#define HCLK_CENTER_ROOT		218
> +#define PCLK_CENTER_ROOT		219
> +#define ACLK_DMA2DDR			220
> +#define ACLK_DDR_SHAREMEM		221
> +#define ACLK_CENTER_S200_ROOT		222
> +#define ACLK_CENTER_S400_ROOT		223
> +#define FCLK_DDR_CM0_CORE		224
> +#define CLK_DDR_TIMER_ROOT		225
> +#define CLK_DDR_TIMER0			226
> +#define CLK_DDR_TIMER1			227
> +#define TCLK_WDT_DDR			228
> +#define CLK_DDR_CM0_RTC			228
> +#define PCLK_WDT			230
> +#define PCLK_TIMER			231
> +#define PCLK_DMA2DDR			232
> +#define PCLK_SHAREMEM			233
> +#define CLK_50M_SRC			234
> +#define CLK_100M_SRC			235
> +#define CLK_150M_SRC			236
> +#define CLK_200M_SRC			237
> +#define CLK_250M_SRC			238
> +#define CLK_300M_SRC			239
> +#define CLK_350M_SRC			240
> +#define CLK_400M_SRC			241
> +#define CLK_450M_SRC			242
> +#define CLK_500M_SRC			243
> +#define CLK_600M_SRC			244
> +#define CLK_650M_SRC			245
> +#define CLK_700M_SRC			246
> +#define CLK_800M_SRC			247
> +#define CLK_1000M_SRC			248
> +#define CLK_1200M_SRC			249
> +#define ACLK_TOP_M300_ROOT		250
> +#define ACLK_TOP_M500_ROOT		251
> +#define ACLK_TOP_M400_ROOT		252
> +#define ACLK_TOP_S200_ROOT		253
> +#define ACLK_TOP_S400_ROOT		254
> +#define CLK_MIPI_CAMARAOUT_M0		255
> +#define CLK_MIPI_CAMARAOUT_M1		256
> +#define CLK_MIPI_CAMARAOUT_M2		257
> +#define CLK_MIPI_CAMARAOUT_M3		258
> +#define CLK_MIPI_CAMARAOUT_M4		259
> +#define MCLK_GMAC0_OUT			260
> +#define REFCLKO25M_ETH0_OUT		261
> +#define REFCLKO25M_ETH1_OUT		262
> +#define CLK_CIFOUT_OUT			263
> +#define PCLK_MIPI_DCPHY0		264
> +#define PCLK_MIPI_DCPHY1		265
> +#define PCLK_CSIPHY0			268
> +#define PCLK_CSIPHY1			269
> +#define ACLK_TOP_ROOT			270
> +#define PCLK_TOP_ROOT			271
> +#define ACLK_LOW_TOP_ROOT		272
> +#define PCLK_CRU			273
> +#define PCLK_GPU_ROOT			274
> +#define CLK_GPU_SRC			275
> +#define CLK_GPU				276
> +#define CLK_GPU_COREGROUP		277
> +#define CLK_GPU_STACKS			278
> +#define PCLK_PVTM2			279
> +#define CLK_PVTM2			280
> +#define CLK_GPU_PVTM			281
> +#define PCLK_GPU_GRF			282
> +#define ACLK_ISP1_ROOT			283
> +#define HCLK_ISP1_ROOT			284
> +#define CLK_ISP1_CORE			285
> +#define CLK_ISP1_CORE_MARVIN		286
> +#define CLK_ISP1_CORE_VICAP		287
> +#define ACLK_ISP1			288
> +#define HCLK_ISP1			289
> +#define ACLK_NPU1			290
> +#define HCLK_NPU1			291
> +#define ACLK_NPU2			292
> +#define HCLK_NPU2			293
> +#define HCLK_NPU_CM0_ROOT		294
> +#define FCLK_NPU_CM0_CORE		295
> +#define CLK_NPU_CM0_RTC			296
> +#define PCLK_PVTM1			297
> +#define PCLK_NPU_GRF			298
> +#define CLK_PVTM1			299
> +#define CLK_NPU_PVTM			300
> +#define ACLK_NPU0			301
> +#define HCLK_NPU0			302
> +#define HCLK_NPU_ROOT			303
> +#define CLK_NPU_DSU0			304
> +#define PCLK_NPU_ROOT			305
> +#define PCLK_NPU_TIMER			306
> +#define CLK_NPUTIMER_ROOT		307
> +#define CLK_NPUTIMER0			308
> +#define CLK_NPUTIMER1			309
> +#define PCLK_NPU_WDT			310
> +#define TCLK_NPU_WDT			311
> +#define HCLK_EMMC			312
> +#define ACLK_EMMC			313
> +#define CCLK_EMMC			314
> +#define BCLK_EMMC			315
> +#define TMCLK_EMMC			316
> +#define SCLK_SFC			317
> +#define HCLK_SFC			318
> +#define HCLK_SFC_XIP			319
> +#define HCLK_NVM_ROOT			320
> +#define ACLK_NVM_ROOT			321
> +#define CLK_GMAC0_PTP_REF		322
> +#define CLK_GMAC1_PTP_REF		323
> +#define CLK_GMAC_125M			324
> +#define CLK_GMAC_50M			325
> +#define ACLK_PHP_GIC_ITS		326
> +#define ACLK_MMU_PCIE			327
> +#define ACLK_MMU_PHP			328
> +#define ACLK_PCIE_4L_DBI		329
> +#define ACLK_PCIE_2L_DBI		330
> +#define ACLK_PCIE_1L0_DBI		331
> +#define ACLK_PCIE_1L1_DBI		332
> +#define ACLK_PCIE_1L2_DBI		333
> +#define ACLK_PCIE_4L_MSTR		334
> +#define ACLK_PCIE_2L_MSTR		335
> +#define ACLK_PCIE_1L0_MSTR		336
> +#define ACLK_PCIE_1L1_MSTR		337
> +#define ACLK_PCIE_1L2_MSTR		338
> +#define ACLK_PCIE_4L_SLV		339
> +#define ACLK_PCIE_2L_SLV		340
> +#define ACLK_PCIE_1L0_SLV		341
> +#define ACLK_PCIE_1L1_SLV		342
> +#define ACLK_PCIE_1L2_SLV		343
> +#define PCLK_PCIE_4L			344
> +#define PCLK_PCIE_2L			345
> +#define PCLK_PCIE_1L0			347
> +#define PCLK_PCIE_1L1			348
> +#define PCLK_PCIE_1L2			349
> +#define CLK_PCIE_AUX0			350
> +#define CLK_PCIE_AUX1			351
> +#define CLK_PCIE_AUX2			352
> +#define CLK_PCIE_AUX3			353
> +#define CLK_PCIE_AUX4			354
> +#define CLK_PIPEPHY0_REF		355
> +#define CLK_PIPEPHY1_REF		356
> +#define CLK_PIPEPHY2_REF		357
> +#define PCLK_PHP_ROOT			358
> +#define PCLK_GMAC0			359
> +#define PCLK_GMAC1			360
> +#define ACLK_PCIE_ROOT			361
> +#define ACLK_PHP_ROOT			362
> +#define ACLK_PCIE_BRIDGE		363
> +#define ACLK_GMAC0			364
> +#define ACLK_GMAC1			365
> +#define CLK_PMALIVE0			366
> +#define CLK_PMALIVE1			367
> +#define CLK_PMALIVE2			368
> +#define ACLK_SATA0			369
> +#define ACLK_SATA1			370
> +#define ACLK_SATA2			371
> +#define CLK_RXOOB0			372
> +#define CLK_RXOOB1			373
> +#define CLK_RXOOB2			374
> +#define ACLK_USB3OTG2			375
> +#define SUSPEND_CLK_USB3OTG2		376
> +#define REF_CLK_USB3OTG2		377
> +#define CLK_UTMI_OTG2			378
> +#define CLK_PIPEPHY0_PIPE_G		379
> +#define CLK_PIPEPHY1_PIPE_G		380
> +#define CLK_PIPEPHY2_PIPE_G		381
> +#define CLK_PIPEPHY0_PIPE_ASIC_G	382
> +#define CLK_PIPEPHY1_PIPE_ASIC_G	383
> +#define CLK_PIPEPHY2_PIPE_ASIC_G	384
> +#define CLK_PIPEPHY2_PIPE_U3_G		385
> +#define CLK_PCIE1L2_PIPE		386
> +#define CLK_PCIE4L_PIPE			387
> +#define CLK_PCIE2L_PIPE			388
> +#define PCLK_PCIE_COMBO_PIPE_PHY0	389
> +#define PCLK_PCIE_COMBO_PIPE_PHY1	390
> +#define PCLK_PCIE_COMBO_PIPE_PHY2	391
> +#define PCLK_PCIE_COMBO_PIPE_PHY	392
> +#define HCLK_RGA3_1			393
> +#define ACLK_RGA3_1			394
> +#define CLK_RGA3_1_CORE			395
> +#define ACLK_RGA3_ROOT			396
> +#define HCLK_RGA3_ROOT			397
> +#define ACLK_RKVDEC_CCU			398
> +#define HCLK_RKVDEC0			399
> +#define ACLK_RKVDEC0			400
> +#define CLK_RKVDEC0_CA			401
> +#define CLK_RKVDEC0_HEVC_CA		402
> +#define CLK_RKVDEC0_CORE		403
> +#define HCLK_RKVDEC1			404
> +#define ACLK_RKVDEC1			405
> +#define CLK_RKVDEC1_CA			406
> +#define CLK_RKVDEC1_HEVC_CA		407
> +#define CLK_RKVDEC1_CORE		408
> +#define HCLK_SDIO			409
> +#define CCLK_SRC_SDIO			410
> +#define ACLK_USB_ROOT			411
> +#define HCLK_USB_ROOT			412
> +#define HCLK_HOST0			413
> +#define HCLK_HOST_ARB0			414
> +#define HCLK_HOST1			415
> +#define HCLK_HOST_ARB1			416
> +#define ACLK_USB3OTG0			417
> +#define SUSPEND_CLK_USB3OTG0		418
> +#define REF_CLK_USB3OTG0		419
> +#define ACLK_USB3OTG1			420
> +#define SUSPEND_CLK_USB3OTG1		421
> +#define REF_CLK_USB3OTG1		422
> +#define UTMI_OHCI_CLK48_HOST0		423
> +#define UTMI_OHCI_CLK48_HOST1		424
> +#define HCLK_IEP2P0			425
> +#define ACLK_IEP2P0			426
> +#define CLK_IEP2P0_CORE			427
> +#define ACLK_JPEG_ENCODER0		428
> +#define HCLK_JPEG_ENCODER0		429
> +#define ACLK_JPEG_ENCODER1		430
> +#define HCLK_JPEG_ENCODER1		431
> +#define ACLK_JPEG_ENCODER2		432
> +#define HCLK_JPEG_ENCODER2		433
> +#define ACLK_JPEG_ENCODER3		434
> +#define HCLK_JPEG_ENCODER3		435
> +#define ACLK_JPEG_DECODER		436
> +#define HCLK_JPEG_DECODER		437
> +#define HCLK_RGA2			438
> +#define ACLK_RGA2			439
> +#define CLK_RGA2_CORE			440
> +#define HCLK_RGA3_0			441
> +#define ACLK_RGA3_0			442
> +#define CLK_RGA3_0_CORE			443
> +#define ACLK_VDPU_ROOT			444
> +#define ACLK_VDPU_LOW_ROOT		445
> +#define HCLK_VDPU_ROOT			446
> +#define ACLK_JPEG_DECODER_ROOT		447
> +#define ACLK_VPU			448
> +#define HCLK_VPU			449
> +#define HCLK_RKVENC0_ROOT		450
> +#define ACLK_RKVENC0_ROOT		451
> +#define HCLK_RKVENC0			452
> +#define ACLK_RKVENC0			453
> +#define CLK_RKVENC0_CORE		454
> +#define HCLK_RKVENC1_ROOT		455
> +#define ACLK_RKVENC1_ROOT		456
> +#define HCLK_RKVENC1			457
> +#define ACLK_RKVENC1			458
> +#define CLK_RKVENC1_CORE		459
> +#define ICLK_CSIHOST01			460
> +#define ICLK_CSIHOST0			461
> +#define ICLK_CSIHOST1			462
> +#define PCLK_CSI_HOST_0			463
> +#define PCLK_CSI_HOST_1			464
> +#define PCLK_CSI_HOST_2			465
> +#define PCLK_CSI_HOST_3			466
> +#define PCLK_CSI_HOST_4			467
> +#define PCLK_CSI_HOST_5			468
> +#define ACLK_FISHEYE0			469
> +#define HCLK_FISHEYE0			470
> +#define CLK_FISHEYE0_CORE		471
> +#define ACLK_FISHEYE1			472
> +#define HCLK_FISHEYE1			473
> +#define CLK_FISHEYE1_CORE		474
> +#define CLK_ISP0_CORE			475
> +#define CLK_ISP0_CORE_MARVIN		476
> +#define CLK_ISP0_CORE_VICAP		477
> +#define ACLK_ISP0			478
> +#define HCLK_ISP0			479
> +#define ACLK_VI_ROOT			480
> +#define HCLK_VI_ROOT			481
> +#define PCLK_VI_ROOT			482
> +#define DCLK_VICAP			483
> +#define ACLK_VICAP			484
> +#define HCLK_VICAP			485
> +#define PCLK_DP0			486
> +#define PCLK_DP1			487
> +#define PCLK_S_DP0			488
> +#define PCLK_S_DP1			489
> +#define CLK_DP0				490
> +#define CLK_DP1				491
> +#define HCLK_HDCP_KEY0			492
> +#define ACLK_HDCP0			493
> +#define HCLK_HDCP0			494
> +#define PCLK_HDCP0			495
> +#define HCLK_I2S4_8CH			496
> +#define ACLK_TRNG0			497
> +#define PCLK_TRNG0			498
> +#define ACLK_VO0_ROOT			499
> +#define HCLK_VO0_ROOT			500
> +#define HCLK_VO0_S_ROOT			501
> +#define PCLK_VO0_ROOT			502
> +#define PCLK_VO0_S_ROOT			503
> +#define PCLK_VO0GRF			504
> +#define CLK_I2S4_8CH_TX_SRC		505
> +#define CLK_I2S4_8CH_TX_FRAC		506
> +#define MCLK_I2S4_8CH_TX		507
> +#define CLK_I2S4_8CH_TX			508
> +#define HCLK_I2S8_8CH			510
> +#define CLK_I2S8_8CH_TX_SRC		511
> +#define CLK_I2S8_8CH_TX_FRAC		512
> +#define MCLK_I2S8_8CH_TX		513
> +#define CLK_I2S8_8CH_TX			514
> +#define HCLK_SPDIF2_DP0			516
> +#define CLK_SPDIF2_DP0_SRC		517
> +#define CLK_SPDIF2_DP0_FRAC		518
> +#define MCLK_SPDIF2_DP0			519
> +#define CLK_SPDIF2_DP0			520
> +#define MCLK_SPDIF2			521
> +#define HCLK_SPDIF5_DP1			522
> +#define CLK_SPDIF5_DP1_SRC		523
> +#define CLK_SPDIF5_DP1_FRAC		524
> +#define MCLK_SPDIF5_DP1			525
> +#define CLK_SPDIF5_DP1			526
> +#define MCLK_SPDIF5			527
> +#define PCLK_EDP0			528
> +#define CLK_EDP0_24M			529
> +#define CLK_EDP0_200M			530
> +#define PCLK_EDP1			531
> +#define CLK_EDP1_24M			532
> +#define CLK_EDP1_200M			533
> +#define HCLK_HDCP_KEY1			534
> +#define ACLK_HDCP1			535
> +#define HCLK_HDCP1			536
> +#define PCLK_HDCP1			537
> +#define ACLK_HDMIRX			538
> +#define PCLK_HDMIRX			539
> +#define CLK_HDMIRX_REF			540
> +#define CLK_HDMIRX_AUD_SRC		541
> +#define CLK_HDMIRX_AUD_FRAC		542
> +#define CLK_HDMIRX_AUD			543
> +#define CLK_HDMIRX_AUD_P_MUX		544
> +#define PCLK_HDMITX0			545
> +#define CLK_HDMITX0_EARC		546
> +#define CLK_HDMITX0_REF			547
> +#define PCLK_HDMITX1			548
> +#define CLK_HDMITX1_EARC		549
> +#define CLK_HDMITX1_REF			550
> +#define CLK_HDMITRX_REFSRC		551
> +#define ACLK_TRNG1			552
> +#define PCLK_TRNG1			553
> +#define ACLK_HDCP1_ROOT			554
> +#define ACLK_HDMIRX_ROOT		555
> +#define HCLK_VO1_ROOT			556
> +#define HCLK_VO1_S_ROOT			557
> +#define PCLK_VO1_ROOT			558
> +#define PCLK_VO1_S_ROOT			559
> +#define PCLK_S_EDP0			560
> +#define PCLK_S_EDP1			561
> +#define PCLK_S_HDMIRX			562
> +#define HCLK_I2S10_8CH			563
> +#define CLK_I2S10_8CH_RX_SRC		564
> +#define CLK_I2S10_8CH_RX_FRAC		565
> +#define CLK_I2S10_8CH_RX		566
> +#define MCLK_I2S10_8CH_RX		567
> +#define HCLK_I2S7_8CH			568
> +#define CLK_I2S7_8CH_RX_SRC		569
> +#define CLK_I2S7_8CH_RX_FRAC		570
> +#define CLK_I2S7_8CH_RX			571
> +#define MCLK_I2S7_8CH_RX		572
> +#define HCLK_I2S9_8CH			574
> +#define CLK_I2S9_8CH_RX_SRC		575
> +#define CLK_I2S9_8CH_RX_FRAC		576
> +#define CLK_I2S9_8CH_RX			577
> +#define MCLK_I2S9_8CH_RX		578
> +#define CLK_I2S5_8CH_TX_SRC		579
> +#define CLK_I2S5_8CH_TX_FRAC		580
> +#define CLK_I2S5_8CH_TX			581
> +#define MCLK_I2S5_8CH_TX		582
> +#define HCLK_I2S5_8CH			584
> +#define CLK_I2S6_8CH_TX_SRC		585
> +#define CLK_I2S6_8CH_TX_FRAC		586
> +#define CLK_I2S6_8CH_TX			587
> +#define MCLK_I2S6_8CH_TX		588
> +#define CLK_I2S6_8CH_RX_SRC		589
> +#define CLK_I2S6_8CH_RX_FRAC		590
> +#define CLK_I2S6_8CH_RX			591
> +#define MCLK_I2S6_8CH_RX		592
> +#define I2S6_8CH_MCLKOUT		593
> +#define HCLK_I2S6_8CH			594
> +#define HCLK_SPDIF3			595
> +#define CLK_SPDIF3_SRC			596
> +#define CLK_SPDIF3_FRAC			597
> +#define CLK_SPDIF3			598
> +#define MCLK_SPDIF3			599
> +#define HCLK_SPDIF4			600
> +#define CLK_SPDIF4_SRC			601
> +#define CLK_SPDIF4_FRAC			602
> +#define CLK_SPDIF4			603
> +#define MCLK_SPDIF4			604
> +#define HCLK_SPDIFRX0			605
> +#define MCLK_SPDIFRX0			606
> +#define HCLK_SPDIFRX1			607
> +#define MCLK_SPDIFRX1			608
> +#define HCLK_SPDIFRX2			609
> +#define MCLK_SPDIFRX2			610
> +#define ACLK_VO1USB_TOP_ROOT		611
> +#define HCLK_VO1USB_TOP_ROOT		612
> +#define CLK_HDMIHDP0			613
> +#define CLK_HDMIHDP1			614
> +#define PCLK_HDPTX0			615
> +#define PCLK_HDPTX1			616
> +#define PCLK_USBDPPHY0			617
> +#define PCLK_USBDPPHY1			618
> +#define ACLK_VOP_ROOT			619
> +#define ACLK_VOP_LOW_ROOT		620
> +#define HCLK_VOP_ROOT			621
> +#define PCLK_VOP_ROOT			622
> +#define HCLK_VOP			623
> +#define ACLK_VOP			624
> +#define DCLK_VOP0_SRC			625
> +#define DCLK_VOP1_SRC			626
> +#define DCLK_VOP2_SRC			627
> +#define DCLK_VOP0			628
> +#define DCLK_VOP1			629
> +#define DCLK_VOP2			630
> +#define DCLK_VOP3			631
> +#define PCLK_DSIHOST0			632
> +#define PCLK_DSIHOST1			633
> +#define CLK_DSIHOST0			634
> +#define CLK_DSIHOST1			635
> +#define CLK_VOP_PMU			636
> +#define ACLK_VOP_DOBY			637
> +#define ACLK_VOP_SUB_SRC		638
> +#define CLK_USBDP_PHY0_IMMORTAL		639
> +#define CLK_USBDP_PHY1_IMMORTAL		640
> +#define CLK_PMU0			641
> +#define PCLK_PMU0			642
> +#define PCLK_PMU0IOC			643
> +#define PCLK_GPIO0			644
> +#define DBCLK_GPIO0			645
> +#define PCLK_I2C0			646
> +#define CLK_I2C0			647
> +#define HCLK_I2S1_8CH			648
> +#define CLK_I2S1_8CH_TX_SRC		649
> +#define CLK_I2S1_8CH_TX_FRAC		650
> +#define CLK_I2S1_8CH_TX			651
> +#define MCLK_I2S1_8CH_TX		652
> +#define CLK_I2S1_8CH_RX_SRC		653
> +#define CLK_I2S1_8CH_RX_FRAC		654
> +#define CLK_I2S1_8CH_RX			655
> +#define MCLK_I2S1_8CH_RX		656
> +#define I2S1_8CH_MCLKOUT		657
> +#define CLK_PMU1_50M_SRC		658
> +#define CLK_PMU1_100M_SRC		659
> +#define CLK_PMU1_200M_SRC		660
> +#define CLK_PMU1_300M_SRC		661
> +#define CLK_PMU1_400M_SRC		662
> +#define HCLK_PMU1_ROOT			663
> +#define PCLK_PMU1_ROOT			664
> +#define PCLK_PMU0_ROOT			665
> +#define HCLK_PMU_CM0_ROOT		666
> +#define PCLK_PMU1			667
> +#define CLK_DDR_FAIL_SAFE		668
> +#define CLK_PMU1			669
> +#define HCLK_PDM0			670
> +#define MCLK_PDM0			671
> +#define HCLK_VAD			672
> +#define FCLK_PMU_CM0_CORE		673
> +#define CLK_PMU_CM0_RTC			674
> +#define PCLK_PMU1_IOC			675
> +#define PCLK_PMU1PWM			676
> +#define CLK_PMU1PWM			677
> +#define CLK_PMU1PWM_CAPTURE		678
> +#define PCLK_PMU1TIMER			679
> +#define CLK_PMU1TIMER_ROOT		680
> +#define CLK_PMU1TIMER0			681
> +#define CLK_PMU1TIMER1			682
> +#define CLK_UART0_SRC			683
> +#define CLK_UART0_FRAC			684
> +#define CLK_UART0			685
> +#define SCLK_UART0			686
> +#define PCLK_UART0			687
> +#define PCLK_PMU1WDT			688
> +#define TCLK_PMU1WDT			689
> +#define CLK_CR_PARA			690
> +#define CLK_HDPTX0_REF_XTAL		691
> +#define CLK_REF_MIPI_DCPHY0		692
> +#define CLK_OTGPHY_U3_0			693
> +#define CLK_USBDP_PHY0_REF_XTAL		694
> +#define CLK_REF_PIPE_PHY0_OSC_SRC	695
> +#define CLK_REF_PIPE_PHY1_OSC_SRC	696
> +#define CLK_REF_PIPE_PHY2_OSC_SRC	697
> +#define CLK_REF_PIPE_PHY0_PLL_SRC	698
> +#define CLK_REF_PIPE_PHY1_PLL_SRC	699
> +#define CLK_REF_PIPE_PHY2_PLL_SRC	700
> +#define CLK_REF_PIPE_PHY0		701
> +#define CLK_REF_PIPE_PHY1		702
> +#define CLK_REF_PIPE_PHY2		703
> +#define SCLK_SDIO_DRV			704
> +#define SCLK_SDIO_SAMPLE		705
> +#define SCLK_SDMMC_DRV			706
> +#define SCLK_SDMMC_SAMPLE		707
> +#define CLK_PCIE1L0_PIPE		708
> +#define CLK_PCIE1L1_PIPE		709
> +#define CLK_BIGCORE0_PVTM		710
> +#define CLK_CORE_BIGCORE0_PVTM		711
> +#define CLK_BIGCORE1_PVTM		712
> +#define CLK_CORE_BIGCORE1_PVTM		713
> +#define CLK_LITCORE_PVTM		714
> +#define CLK_CORE_LITCORE_PVTM		715
> +
> +#define CLK_NR_CLKS			(CLK_CORE_LITCORE_PVTM + 1)
> +
> +/********Name=SOFTRST_CON01,Offset=0xA04********/
> +#define SRST_A_TOP_BIU			19
> +#define SRST_P_TOP_BIU			20
> +#define SRST_P_CSIPHY0			22
> +#define SRST_CSIPHY0			23
> +#define SRST_P_CSIPHY1			24
> +#define SRST_CSIPHY1			25
> +#define SRST_A_TOP_M500_BIU		31
> +/********Name=SOFTRST_CON02,Offset=0xA08********/
> +#define SRST_A_TOP_M400_BIU		32
> +#define SRST_A_TOP_S200_BIU		33
> +#define SRST_A_TOP_S400_BIU		34
> +#define SRST_A_TOP_M300_BIU		35
> +#define SRST_USBDP_COMBO_PHY0_INIT	40
> +#define SRST_USBDP_COMBO_PHY0_CMN	41
> +#define SRST_USBDP_COMBO_PHY0_LANE	42
> +#define SRST_USBDP_COMBO_PHY0_PCS	43
> +#define SRST_USBDP_COMBO_PHY1_INIT	47
> +/********Name=SOFTRST_CON03,Offset=0xA0C********/
> +#define SRST_USBDP_COMBO_PHY1_CMN	48
> +#define SRST_USBDP_COMBO_PHY1_LANE	49
> +#define SRST_USBDP_COMBO_PHY1_PCS	50
> +#define SRST_DCPHY0			59
> +#define SRST_P_MIPI_DCPHY0		62
> +#define SRST_P_MIPI_DCPHY0_GRF		63
> +/********Name=SOFTRST_CON04,Offset=0xA10********/
> +#define SRST_DCPHY1			64
> +#define SRST_P_MIPI_DCPHY1		67
> +#define SRST_P_MIPI_DCPHY1_GRF		68
> +#define SRST_P_APB2ASB_SLV_CDPHY	69
> +#define SRST_P_APB2ASB_SLV_CSIPHY	70
> +#define SRST_P_APB2ASB_SLV_VCCIO3_5	71
> +#define SRST_P_APB2ASB_SLV_VCCIO6	72
> +#define SRST_P_APB2ASB_SLV_EMMCIO	73
> +#define SRST_P_APB2ASB_SLV_IOC_TOP	74
> +#define SRST_P_APB2ASB_SLV_IOC_RIGHT	75
> +/********Name=SOFTRST_CON05,Offset=0xA14********/
> +#define SRST_P_CRU			80
> +#define SRST_A_CHANNEL_SECURE2VO1USB	87
> +#define SRST_A_CHANNEL_SECURE2CENTER	88
> +#define SRST_H_CHANNEL_SECURE2VO1USB	94
> +#define SRST_H_CHANNEL_SECURE2CENTER	95
> +/********Name=SOFTRST_CON06,Offset=0xA18********/
> +#define SRST_P_CHANNEL_SECURE2VO1USB	96
> +#define SRST_P_CHANNEL_SECURE2CENTER	97
> +/********Name=SOFTRST_CON07,Offset=0xA1C********/
> +#define SRST_H_AUDIO_BIU		114
> +#define SRST_P_AUDIO_BIU		115
> +#define SRST_H_I2S0_8CH			116
> +#define SRST_M_I2S0_8CH_TX		119
> +#define SRST_M_I2S0_8CH_RX		122
> +#define SRST_P_ACDCDIG			123
> +#define SRST_H_I2S2_2CH			124
> +#define SRST_H_I2S3_2CH			125
> +/********Name=SOFTRST_CON08,Offset=0xA20********/
> +#define SRST_M_I2S2_2CH			128
> +#define SRST_M_I2S3_2CH			131
> +#define SRST_DAC_ACDCDIG		132
> +#define SRST_H_SPDIF0			142
> +/********Name=SOFTRST_CON09,Offset=0xA24********/
> +#define SRST_M_SPDIF0			145
> +#define SRST_H_SPDIF1			146
> +#define SRST_M_SPDIF1			149
> +#define SRST_H_PDM1			150
> +#define SRST_PDM1			151
> +/********Name=SOFTRST_CON10,Offset=0xA28********/
> +#define SRST_A_BUS_BIU			161
> +#define SRST_P_BUS_BIU			162
> +#define SRST_A_GIC			163
> +#define SRST_A_GIC_DBG			164
> +#define SRST_A_DMAC0			165
> +#define SRST_A_DMAC1			166
> +#define SRST_A_DMAC2			167
> +#define SRST_P_I2C1			168
> +#define SRST_P_I2C2			169
> +#define SRST_P_I2C3			170
> +#define SRST_P_I2C4			171
> +#define SRST_P_I2C5			172
> +#define SRST_P_I2C6			173
> +#define SRST_P_I2C7			174
> +#define SRST_P_I2C8			175
> +/********Name=SOFTRST_CON11,Offset=0xA2C********/
> +#define SRST_I2C1			176
> +#define SRST_I2C2			177
> +#define SRST_I2C3			178
> +#define SRST_I2C4			179
> +#define SRST_I2C5			180
> +#define SRST_I2C6			181
> +#define SRST_I2C7			182
> +#define SRST_I2C8			183
> +#define SRST_P_CAN0			184
> +#define SRST_CAN0			185
> +#define SRST_P_CAN1			186
> +#define SRST_CAN1			187
> +#define SRST_P_CAN2			188
> +#define SRST_CAN2			189
> +#define SRST_P_SARADC			190
> +/********Name=SOFTRST_CON12,Offset=0xA30********/
> +#define SRST_P_TSADC			192
> +#define SRST_TSADC			193
> +#define SRST_P_UART1			194
> +#define SRST_P_UART2			195
> +#define SRST_P_UART3			196
> +#define SRST_P_UART4			197
> +#define SRST_P_UART5			198
> +#define SRST_P_UART6			199
> +#define SRST_P_UART7			200
> +#define SRST_P_UART8			201
> +#define SRST_P_UART9			202
> +#define SRST_S_UART1			205
> +/********Name=SOFTRST_CON13,Offset=0xA34********/
> +#define SRST_S_UART2			208
> +#define SRST_S_UART3			211
> +#define SRST_S_UART4			214
> +#define SRST_S_UART5			217
> +#define SRST_S_UART6			220
> +#define SRST_S_UART7			223
> +/********Name=SOFTRST_CON14,Offset=0xA38********/
> +#define SRST_S_UART8			226
> +#define SRST_S_UART9			229
> +#define SRST_P_SPI0			230
> +#define SRST_P_SPI1			231
> +#define SRST_P_SPI2			232
> +#define SRST_P_SPI3			233
> +#define SRST_P_SPI4			234
> +#define SRST_SPI0			235
> +#define SRST_SPI1			236
> +#define SRST_SPI2			237
> +#define SRST_SPI3			238
> +#define SRST_SPI4			239
> +/********Name=SOFTRST_CON15,Offset=0xA3C********/
> +#define SRST_P_WDT0			240
> +#define SRST_T_WDT0			241
> +#define SRST_P_SYS_GRF			242
> +#define SRST_P_PWM1			243
> +#define SRST_PWM1			244
> +#define SRST_P_PWM2			246
> +#define SRST_PWM2			247
> +#define SRST_P_PWM3			249
> +#define SRST_PWM3			250
> +#define SRST_P_BUSTIMER0		252
> +#define SRST_P_BUSTIMER1		253
> +#define SRST_BUSTIMER0			255
> +/********Name=SOFTRST_CON16,Offset=0xA40********/
> +#define SRST_BUSTIMER1			256
> +#define SRST_BUSTIMER2			257
> +#define SRST_BUSTIMER3			258
> +#define SRST_BUSTIMER4			259
> +#define SRST_BUSTIMER5			260
> +#define SRST_BUSTIMER6			261
> +#define SRST_BUSTIMER7			262
> +#define SRST_BUSTIMER8			263
> +#define SRST_BUSTIMER9			264
> +#define SRST_BUSTIMER10			265
> +#define SRST_BUSTIMER11			266
> +#define SRST_P_MAILBOX0			267
> +#define SRST_P_MAILBOX1			268
> +#define SRST_P_MAILBOX2			269
> +#define SRST_P_GPIO1			270
> +#define SRST_GPIO1			271
> +/********Name=SOFTRST_CON17,Offset=0xA44********/
> +#define SRST_P_GPIO2			272
> +#define SRST_GPIO2			273
> +#define SRST_P_GPIO3			274
> +#define SRST_GPIO3			275
> +#define SRST_P_GPIO4			276
> +#define SRST_GPIO4			277
> +#define SRST_A_DECOM			278
> +#define SRST_P_DECOM			279
> +#define SRST_D_DECOM			280
> +#define SRST_P_TOP			281
> +#define SRST_A_GICADB_GIC2CORE_BUS	283
> +#define SRST_P_DFT2APB			284
> +#define SRST_P_APB2ASB_MST_TOP		285
> +#define SRST_P_APB2ASB_MST_CDPHY	286
> +#define SRST_P_APB2ASB_MST_BOT_RIGHT	287
> +/********Name=SOFTRST_CON18,Offset=0xA48********/
> +#define SRST_P_APB2ASB_MST_IOC_TOP	288
> +#define SRST_P_APB2ASB_MST_IOC_RIGHT	289
> +#define SRST_P_APB2ASB_MST_CSIPHY	290
> +#define SRST_P_APB2ASB_MST_VCCIO3_5	291
> +#define SRST_P_APB2ASB_MST_VCCIO6	292
> +#define SRST_P_APB2ASB_MST_EMMCIO	293
> +#define SRST_A_SPINLOCK			294
> +#define SRST_P_OTPC_NS			297
> +#define SRST_OTPC_NS			298
> +#define SRST_OTPC_ARB			299
> +/********Name=SOFTRST_CON19,Offset=0xA4C********/
> +#define SRST_P_BUSIOC			304
> +#define SRST_P_PMUCM0_INTMUX		308
> +#define SRST_P_DDRCM0_INTMUX		309
> +/********Name=SOFTRST_CON20,Offset=0xA50********/
> +#define SRST_P_DDR_DFICTL_CH0		320
> +#define SRST_P_DDR_MON_CH0		321
> +#define SRST_P_DDR_STANDBY_CH0		322
> +#define SRST_P_DDR_UPCTL_CH0		323
> +#define SRST_TM_DDR_MON_CH0		324
> +#define SRST_P_DDR_GRF_CH01		325
> +#define SRST_DFI_CH0			326
> +#define SRST_SBR_CH0			327
> +#define SRST_DDR_UPCTL_CH0		328
> +#define SRST_DDR_DFICTL_CH0		329
> +#define SRST_DDR_MON_CH0		330
> +#define SRST_DDR_STANDBY_CH0		331
> +#define SRST_A_DDR_UPCTL_CH0		332
> +#define SRST_P_DDR_DFICTL_CH1		333
> +#define SRST_P_DDR_MON_CH1		334
> +#define SRST_P_DDR_STANDBY_CH1		335
> +/********Name=SOFTRST_CON21,Offset=0xA54********/
> +#define SRST_P_DDR_UPCTL_CH1		336
> +#define SRST_TM_DDR_MON_CH1		337
> +#define SRST_DFI_CH1			338
> +#define SRST_SBR_CH1			339
> +#define SRST_DDR_UPCTL_CH1		340
> +#define SRST_DDR_DFICTL_CH1		341
> +#define SRST_DDR_MON_CH1		342
> +#define SRST_DDR_STANDBY_CH1		343
> +#define SRST_A_DDR_UPCTL_CH1		344
> +#define SRST_A_DDR01_MSCH0		349
> +#define SRST_A_DDR01_RS_MSCH0		350
> +#define SRST_A_DDR01_FRS_MSCH0		351
> +/********Name=SOFTRST_CON22,Offset=0xA58********/
> +#define SRST_A_DDR01_SCRAMBLE0		352
> +#define SRST_A_DDR01_FRS_SCRAMBLE0	353
> +#define SRST_A_DDR01_MSCH1		354
> +#define SRST_A_DDR01_RS_MSCH1		355
> +#define SRST_A_DDR01_FRS_MSCH1		356
> +#define SRST_A_DDR01_SCRAMBLE1		357
> +#define SRST_A_DDR01_FRS_SCRAMBLE1	358
> +#define SRST_P_DDR01_MSCH0		359
> +#define SRST_P_DDR01_MSCH1		360
> +/********Name=SOFTRST_CON23,Offset=0xA5C********/
> +#define SRST_P_DDR_DFICTL_CH2		368
> +#define SRST_P_DDR_MON_CH2		369
> +#define SRST_P_DDR_STANDBY_CH2		370
> +#define SRST_P_DDR_UPCTL_CH2		371
> +#define SRST_TM_DDR_MON_CH2		372
> +#define SRST_P_DDR_GRF_CH23		373
> +#define SRST_DFI_CH2			374
> +#define SRST_SBR_CH2			375
> +#define SRST_DDR_UPCTL_CH2		376
> +#define SRST_DDR_DFICTL_CH2		377
> +#define SRST_DDR_MON_CH2		378
> +#define SRST_DDR_STANDBY_CH2		379
> +#define SRST_A_DDR_UPCTL_CH2		380
> +#define SRST_P_DDR_DFICTL_CH3		381
> +#define SRST_P_DDR_MON_CH3		382
> +#define SRST_P_DDR_STANDBY_CH3		383
> +/********Name=SOFTRST_CON24,Offset=0xA60********/
> +#define SRST_P_DDR_UPCTL_CH3		384
> +#define SRST_TM_DDR_MON_CH3		385
> +#define SRST_DFI_CH3			386
> +#define SRST_SBR_CH3			387
> +#define SRST_DDR_UPCTL_CH3		388
> +#define SRST_DDR_DFICTL_CH3		389
> +#define SRST_DDR_MON_CH3		390
> +#define SRST_DDR_STANDBY_CH3		391
> +#define SRST_A_DDR_UPCTL_CH3		392
> +#define SRST_A_DDR23_MSCH2		397
> +#define SRST_A_DDR23_RS_MSCH2		398
> +#define SRST_A_DDR23_FRS_MSCH2		399
> +/********Name=SOFTRST_CON25,Offset=0xA64********/
> +#define SRST_A_DDR23_SCRAMBLE2		400
> +#define SRST_A_DDR23_FRS_SCRAMBLE2	401
> +#define SRST_A_DDR23_MSCH3		402
> +#define SRST_A_DDR23_RS_MSCH3		403
> +#define SRST_A_DDR23_FRS_MSCH3		404
> +#define SRST_A_DDR23_SCRAMBLE3		405
> +#define SRST_A_DDR23_FRS_SCRAMBLE3	406
> +#define SRST_P_DDR23_MSCH2		407
> +#define SRST_P_DDR23_MSCH3		408
> +/********Name=SOFTRST_CON26,Offset=0xA68********/
> +#define SRST_ISP1			419
> +#define SRST_ISP1_VICAP			420
> +#define SRST_A_ISP1_BIU			422
> +#define SRST_H_ISP1_BIU			424
> +/********Name=SOFTRST_CON27,Offset=0xA6C********/
> +#define SRST_A_RKNN1			432
> +#define SRST_A_RKNN1_BIU		433
> +#define SRST_H_RKNN1			434
> +#define SRST_H_RKNN1_BIU		435
> +/********Name=SOFTRST_CON28,Offset=0xA70********/
> +#define SRST_A_RKNN2			448
> +#define SRST_A_RKNN2_BIU		449
> +#define SRST_H_RKNN2			450
> +#define SRST_H_RKNN2_BIU		451
> +/********Name=SOFTRST_CON29,Offset=0xA74********/
> +#define SRST_A_RKNN_DSU0		467
> +#define SRST_P_NPUTOP_BIU		469
> +#define SRST_P_NPU_TIMER		470
> +#define SRST_NPUTIMER0			472
> +#define SRST_NPUTIMER1			473
> +#define SRST_P_NPU_WDT			474
> +#define SRST_T_NPU_WDT			475
> +#define SRST_P_PVTM1			476
> +#define SRST_P_NPU_GRF			477
> +#define SRST_PVTM1			478
> +/********Name=SOFTRST_CON30,Offset=0xA78********/
> +#define SRST_NPU_PVTPLL			480
> +#define SRST_H_NPU_CM0_BIU		482
> +#define SRST_F_NPU_CM0_CORE		483
> +#define SRST_T_NPU_CM0_JTAG		484
> +#define SRST_A_RKNN0			486
> +#define SRST_A_RKNN0_BIU		487
> +#define SRST_H_RKNN0			488
> +#define SRST_H_RKNN0_BIU		489
> +/********Name=SOFTRST_CON31,Offset=0xA7C********/
> +#define SRST_H_NVM_BIU			498
> +#define SRST_A_NVM_BIU			499
> +#define SRST_H_EMMC			500
> +#define SRST_A_EMMC			501
> +#define SRST_C_EMMC			502
> +#define SRST_B_EMMC			503
> +#define SRST_T_EMMC			504
> +#define SRST_S_SFC			505
> +#define SRST_H_SFC			506
> +#define SRST_H_SFC_XIP			507
> +/********Name=SOFTRST_CON32,Offset=0xA80********/
> +#define SRST_P_GRF			513
> +#define SRST_P_DEC_BIU			514
> +#define SRST_P_PHP_BIU			517
> +#define SRST_A_PCIE_GRIDGE		520
> +#define SRST_A_PHP_BIU			521
> +#define SRST_A_GMAC0			522
> +#define SRST_A_GMAC1			523
> +#define SRST_A_PCIE_BIU			524
> +#define SRST_PCIE0_POWER_UP		525
> +#define SRST_PCIE1_POWER_UP		526
> +#define SRST_PCIE2_POWER_UP		527
> +/********Name=SOFTRST_CON33,Offset=0xA84********/
> +#define SRST_PCIE3_POWER_UP		528
> +#define SRST_PCIE4_POWER_UP		529
> +#define SRST_P_PCIE0			540
> +#define SRST_P_PCIE1			541
> +#define SRST_P_PCIE2			542
> +#define SRST_P_PCIE3			543
> +/********Name=SOFTRST_CON34,Offset=0xA88********/
> +#define SRST_P_PCIE4			544
> +#define SRST_A_PHP_GIC_ITS		550
> +#define SRST_A_MMU_PCIE			551
> +#define SRST_A_MMU_PHP			552
> +#define SRST_A_MMU_BIU			553
> +/********Name=SOFTRST_CON35,Offset=0xA8C********/
> +#define SRST_A_USB3OTG2			567
> +/********Name=SOFTRST_CON37,Offset=0xA94********/
> +#define SRST_PMALIVE0			596
> +#define SRST_PMALIVE1			597
> +#define SRST_PMALIVE2			598
> +#define SRST_A_SATA0			599
> +#define SRST_A_SATA1			600
> +#define SRST_A_SATA2			601
> +#define SRST_RXOOB0			602
> +#define SRST_RXOOB1			603
> +#define SRST_RXOOB2			604
> +#define SRST_ASIC0			605
> +#define SRST_ASIC1			606
> +#define SRST_ASIC2			607
> +/********Name=SOFTRST_CON40,Offset=0xAA0********/
> +#define SRST_A_RKVDEC_CCU		642
> +#define SRST_H_RKVDEC0			643
> +#define SRST_A_RKVDEC0			644
> +#define SRST_H_RKVDEC0_BIU		645
> +#define SRST_A_RKVDEC0_BIU		646
> +#define SRST_RKVDEC0_CA			647
> +#define SRST_RKVDEC0_HEVC_CA		648
> +#define SRST_RKVDEC0_CORE		649
> +/********Name=SOFTRST_CON41,Offset=0xAA4********/
> +#define SRST_H_RKVDEC1			658
> +#define SRST_A_RKVDEC1			659
> +#define SRST_H_RKVDEC1_BIU		660
> +#define SRST_A_RKVDEC1_BIU		661
> +#define SRST_RKVDEC1_CA			662
> +#define SRST_RKVDEC1_HEVC_CA		663
> +#define SRST_RKVDEC1_CORE		664
> +/********Name=SOFTRST_CON42,Offset=0xAA8********/
> +#define SRST_A_USB_BIU			674
> +#define SRST_H_USB_BIU			675
> +#define SRST_A_USB3OTG0			676
> +#define SRST_A_USB3OTG1			679
> +#define SRST_H_HOST0			682
> +#define SRST_H_HOST_ARB0		683
> +#define SRST_H_HOST1			684
> +#define SRST_H_HOST_ARB1		685
> +#define SRST_A_USB_GRF			686
> +#define SRST_C_USB2P0_HOST0		687
> +/********Name=SOFTRST_CON43,Offset=0xAAC********/
> +#define SRST_C_USB2P0_HOST1		688
> +#define SRST_HOST_UTMI0			689
> +#define SRST_HOST_UTMI1			690
> +/********Name=SOFTRST_CON44,Offset=0xAB0********/
> +#define SRST_A_VDPU_BIU			708
> +#define SRST_A_VDPU_LOW_BIU		709
> +#define SRST_H_VDPU_BIU			710
> +#define SRST_A_JPEG_DECODER_BIU		711
> +#define SRST_A_VPU			712
> +#define SRST_H_VPU			713
> +#define SRST_A_JPEG_ENCODER0		714
> +#define SRST_H_JPEG_ENCODER0		715
> +#define SRST_A_JPEG_ENCODER1		716
> +#define SRST_H_JPEG_ENCODER1		717
> +#define SRST_A_JPEG_ENCODER2		718
> +#define SRST_H_JPEG_ENCODER2		719
> +/********Name=SOFTRST_CON45,Offset=0xAB4********/
> +#define SRST_A_JPEG_ENCODER3		720
> +#define SRST_H_JPEG_ENCODER3		721
> +#define SRST_A_JPEG_DECODER		722
> +#define SRST_H_JPEG_DECODER		723
> +#define SRST_H_IEP2P0			724
> +#define SRST_A_IEP2P0			725
> +#define SRST_IEP2P0_CORE		726
> +#define SRST_H_RGA2			727
> +#define SRST_A_RGA2			728
> +#define SRST_RGA2_CORE			729
> +#define SRST_H_RGA3_0			730
> +#define SRST_A_RGA3_0			731
> +#define SRST_RGA3_0_CORE		732
> +/********Name=SOFTRST_CON47,Offset=0xABC********/
> +#define SRST_H_RKVENC0_BIU		754
> +#define SRST_A_RKVENC0_BIU		755
> +#define SRST_H_RKVENC0			756
> +#define SRST_A_RKVENC0			757
> +#define SRST_RKVENC0_CORE		758
> +/********Name=SOFTRST_CON48,Offset=0xAC0********/
> +#define SRST_H_RKVENC1_BIU		770
> +#define SRST_A_RKVENC1_BIU		771
> +#define SRST_H_RKVENC1			772
> +#define SRST_A_RKVENC1			773
> +#define SRST_RKVENC1_CORE		774
> +/********Name=SOFTRST_CON49,Offset=0xAC4********/
> +#define SRST_A_VI_BIU			787
> +#define SRST_H_VI_BIU			788
> +#define SRST_P_VI_BIU			789
> +#define SRST_D_VICAP			790
> +#define SRST_A_VICAP			791
> +#define SRST_H_VICAP			792
> +#define SRST_ISP0			794
> +#define SRST_ISP0_VICAP			795
> +/********Name=SOFTRST_CON50,Offset=0xAC8********/
> +#define SRST_FISHEYE0			800
> +#define SRST_FISHEYE1			803
> +#define SRST_P_CSI_HOST_0		804
> +#define SRST_P_CSI_HOST_1		805
> +#define SRST_P_CSI_HOST_2		806
> +#define SRST_P_CSI_HOST_3		807
> +#define SRST_P_CSI_HOST_4		808
> +#define SRST_P_CSI_HOST_5		809
> +/********Name=SOFTRST_CON51,Offset=0xACC********/
> +#define SRST_CSIHOST0_VICAP		820
> +#define SRST_CSIHOST1_VICAP		821
> +#define SRST_CSIHOST2_VICAP		822
> +#define SRST_CSIHOST3_VICAP		823
> +#define SRST_CSIHOST4_VICAP		824
> +#define SRST_CSIHOST5_VICAP		825
> +#define SRST_CIFIN			829
> +/********Name=SOFTRST_CON52,Offset=0xAD0********/
> +#define SRST_A_VOP_BIU			836
> +#define SRST_A_VOP_LOW_BIU		837
> +#define SRST_H_VOP_BIU			838
> +#define SRST_P_VOP_BIU			839
> +#define SRST_H_VOP			840
> +#define SRST_A_VOP			841
> +#define SRST_D_VOP0			845
> +#define SRST_D_VOP2HDMI_BRIDGE0		846
> +#define SRST_D_VOP2HDMI_BRIDGE1		847
> +/********Name=SOFTRST_CON53,Offset=0xAD4********/
> +#define SRST_D_VOP1			848
> +#define SRST_D_VOP2			849
> +#define SRST_D_VOP3			850
> +#define SRST_P_VOPGRF			851
> +#define SRST_P_DSIHOST0			852
> +#define SRST_P_DSIHOST1			853
> +#define SRST_DSIHOST0			854
> +#define SRST_DSIHOST1			855
> +#define SRST_VOP_PMU			856
> +#define SRST_P_VOP_CHANNEL_BIU		857
> +/********Name=SOFTRST_CON55,Offset=0xADC********/
> +#define SRST_H_VO0_BIU			885
> +#define SRST_H_VO0_S_BIU		886
> +#define SRST_P_VO0_BIU			887
> +#define SRST_P_VO0_S_BIU		888
> +#define SRST_A_HDCP0_BIU		889
> +#define SRST_P_VO0GRF			890
> +#define SRST_H_HDCP_KEY0		891
> +#define SRST_A_HDCP0			892
> +#define SRST_H_HDCP0			893
> +#define SRST_HDCP0			895
> +/********Name=SOFTRST_CON56,Offset=0xAE0********/
> +#define SRST_P_TRNG0			897
> +#define SRST_DP0			904
> +#define SRST_DP1			905
> +#define SRST_H_I2S4_8CH			906
> +#define SRST_M_I2S4_8CH_TX		909
> +#define SRST_H_I2S8_8CH			910
> +/********Name=SOFTRST_CON57,Offset=0xAE4********/
> +#define SRST_M_I2S8_8CH_TX		913
> +#define SRST_H_SPDIF2_DP0		914
> +#define SRST_M_SPDIF2_DP0		918
> +#define SRST_H_SPDIF5_DP1		919
> +#define SRST_M_SPDIF5_DP1		923
> +/********Name=SOFTRST_CON59,Offset=0xAEC********/
> +#define SRST_A_HDCP1_BIU		950
> +#define SRST_A_VO1_BIU			952
> +#define SRST_H_VOP1_BIU			953
> +#define SRST_H_VOP1_S_BIU		954
> +#define SRST_P_VOP1_BIU			955
> +#define SRST_P_VO1GRF			956
> +#define SRST_P_VO1_S_BIU		957
> +/********Name=SOFTRST_CON60,Offset=0xAF0********/
> +#define SRST_H_I2S7_8CH			960
> +#define SRST_M_I2S7_8CH_RX		963
> +#define SRST_H_HDCP_KEY1		964
> +#define SRST_A_HDCP1			965
> +#define SRST_H_HDCP1			966
> +#define SRST_HDCP1			968
> +#define SRST_P_TRNG1			970
> +#define SRST_P_HDMITX0			971
> +/********Name=SOFTRST_CON61,Offset=0xAF4********/
> +#define SRST_HDMITX0_REF		976
> +#define SRST_P_HDMITX1			978
> +#define SRST_HDMITX1_REF		983
> +#define SRST_A_HDMIRX			985
> +#define SRST_P_HDMIRX			986
> +#define SRST_HDMIRX_REF			987
> +/********Name=SOFTRST_CON62,Offset=0xAF8********/
> +#define SRST_P_EDP0			992
> +#define SRST_EDP0_24M			993
> +#define SRST_P_EDP1			995
> +#define SRST_EDP1_24M			996
> +#define SRST_M_I2S5_8CH_TX		1000
> +#define SRST_H_I2S5_8CH			1004
> +#define SRST_M_I2S6_8CH_TX		1007
> +/********Name=SOFTRST_CON63,Offset=0xAFC********/
> +#define SRST_M_I2S6_8CH_RX		1010
> +#define SRST_H_I2S6_8CH			1011
> +#define SRST_H_SPDIF3			1012
> +#define SRST_M_SPDIF3			1015
> +#define SRST_H_SPDIF4			1016
> +#define SRST_M_SPDIF4			1019
> +#define SRST_H_SPDIFRX0			1020
> +#define SRST_M_SPDIFRX0			1021
> +#define SRST_H_SPDIFRX1			1022
> +#define SRST_M_SPDIFRX1			1023
> +/********Name=SOFTRST_CON64,Offset=0xB00********/
> +#define SRST_H_SPDIFRX2			1024
> +#define SRST_M_SPDIFRX2			1025
> +#define SRST_LINKSYM_HDMITXPHY0		1036
> +#define SRST_LINKSYM_HDMITXPHY1		1037
> +#define SRST_VO1_BRIDGE0		1038
> +#define SRST_VO1_BRIDGE1		1039
> +/********Name=SOFTRST_CON65,Offset=0xB04********/
> +#define SRST_H_I2S9_8CH			1040
> +#define SRST_M_I2S9_8CH_RX		1043
> +#define SRST_H_I2S10_8CH		1044
> +#define SRST_M_I2S10_8CH_RX		1047
> +#define SRST_P_S_HDMIRX			1048
> +/********Name=SOFTRST_CON66,Offset=0xB08********/
> +#define SRST_GPU			1060
> +#define SRST_SYS_GPU			1061
> +#define SRST_A_S_GPU_BIU		1064
> +#define SRST_A_M0_GPU_BIU		1065
> +#define SRST_A_M1_GPU_BIU		1066
> +#define SRST_A_M2_GPU_BIU		1067
> +#define SRST_A_M3_GPU_BIU		1068
> +#define SRST_P_GPU_BIU			1070
> +#define SRST_P_PVTM2			1071
> +/********Name=SOFTRST_CON67,Offset=0xB0C********/
> +#define SRST_PVTM2			1072
> +#define SRST_P_GPU_GRF			1074
> +#define SRST_GPU_PVTPLL			1075
> +#define SRST_GPU_JTAG			1076
> +/********Name=SOFTRST_CON68,Offset=0xB10********/
> +#define SRST_A_AV1_BIU			1089
> +#define SRST_A_AV1			1090
> +#define SRST_P_AV1_BIU			1092
> +#define SRST_P_AV1			1093
> +/********Name=SOFTRST_CON69,Offset=0xB14********/
> +#define SRST_A_DDR_BIU			1108
> +#define SRST_A_DMA2DDR			1109
> +#define SRST_A_DDR_SHAREMEM		1110
> +#define SRST_A_DDR_SHAREMEM_BIU		1111
> +#define SRST_A_CENTER_S200_BIU		1114
> +#define SRST_A_CENTER_S400_BIU		1115
> +#define SRST_H_AHB2APB			1116
> +#define SRST_H_CENTER_BIU		1117
> +#define SRST_F_DDR_CM0_CORE		1118
> +/********Name=SOFTRST_CON70,Offset=0xB18********/
> +#define SRST_DDR_TIMER0			1120
> +#define SRST_DDR_TIMER1			1121
> +#define SRST_T_WDT_DDR			1122
> +#define SRST_T_DDR_CM0_JTAG		1123
> +#define SRST_P_CENTER_GRF		1125
> +#define SRST_P_AHB2APB			1126
> +#define SRST_P_WDT			1127
> +#define SRST_P_TIMER			1128
> +#define SRST_P_DMA2DDR			1129
> +#define SRST_P_SHAREMEM			1130
> +#define SRST_P_CENTER_BIU		1131
> +#define SRST_P_CENTER_CHANNEL_BIU	1132
> +/********Name=SOFTRST_CON72,Offset=0xB20********/
> +#define SRST_P_USBDPGRF0		1153
> +#define SRST_P_USBDPPHY0		1154
> +#define SRST_P_USBDPGRF1		1155
> +#define SRST_P_USBDPPHY1		1156
> +#define SRST_P_HDPTX0			1157
> +#define SRST_P_HDPTX1			1158
> +#define SRST_P_APB2ASB_SLV_BOT_RIGHT	1159
> +#define SRST_P_USB2PHY_U3_0_GRF0	1160
> +#define SRST_P_USB2PHY_U3_1_GRF0	1161
> +#define SRST_P_USB2PHY_U2_0_GRF0	1162
> +#define SRST_P_USB2PHY_U2_1_GRF0	1163
> +#define SRST_HDPTX0_ROPLL		1164
> +#define SRST_HDPTX0_LCPLL		1165
> +#define SRST_HDPTX0			1166
> +#define SRST_HDPTX1_ROPLL		1167
> +/********Name=SOFTRST_CON73,Offset=0xB24********/
> +#define SRST_HDPTX1_LCPLL		1168
> +#define SRST_HDPTX1			1169
> +#define SRST_HDPTX0_HDMIRXPHY_SET	1170
> +#define SRST_USBDP_COMBO_PHY0		1171
> +#define SRST_USBDP_COMBO_PHY0_LCPLL	1172
> +#define SRST_USBDP_COMBO_PHY0_ROPLL	1173
> +#define SRST_USBDP_COMBO_PHY0_PCS_HS	1174
> +#define SRST_USBDP_COMBO_PHY1		1175
> +#define SRST_USBDP_COMBO_PHY1_LCPLL	1176
> +#define SRST_USBDP_COMBO_PHY1_ROPLL	1177
> +#define SRST_USBDP_COMBO_PHY1_PCS_HS	1178
> +#define SRST_HDMIHDP0			1180
> +#define SRST_HDMIHDP1			1181
> +/********Name=SOFTRST_CON74,Offset=0xB28********/
> +#define SRST_A_VO1USB_TOP_BIU		1185
> +#define SRST_H_VO1USB_TOP_BIU		1187
> +/********Name=SOFTRST_CON75,Offset=0xB2C********/
> +#define SRST_H_SDIO_BIU			1201
> +#define SRST_H_SDIO			1202
> +#define SRST_SDIO			1203
> +/********Name=SOFTRST_CON76,Offset=0xB30********/
> +#define SRST_H_RGA3_BIU			1218
> +#define SRST_A_RGA3_BIU			1219
> +#define SRST_H_RGA3_1			1220
> +#define SRST_A_RGA3_1			1221
> +#define SRST_RGA3_1_CORE		1222
> +/********Name=SOFTRST_CON77,Offset=0xB34********/
> +#define SRST_REF_PIPE_PHY0		1238
> +#define SRST_REF_PIPE_PHY1		1239
> +#define SRST_REF_PIPE_PHY2		1240
> +
> +/********Name=PHPTOPSOFTRST_CON0,Offset=0x8A00********/
> +#define SRST_P_PHPTOP_CRU		131073
> +#define SRST_P_PCIE2_GRF0		131074
> +#define SRST_P_PCIE2_GRF1		131075
> +#define SRST_P_PCIE2_GRF2		131076
> +#define SRST_P_PCIE2_PHY0		131077
> +#define SRST_P_PCIE2_PHY1		131078
> +#define SRST_P_PCIE2_PHY2		131079
> +#define SRST_P_PCIE3_PHY		131080
> +#define SRST_P_APB2ASB_SLV_CHIP_TOP	131081
> +#define SRST_PCIE30_PHY			131082
> +
> +/********Name=PMU1SOFTRST_CON00,Offset=0x30A00********/
> +#define SRST_H_PMU1_BIU			786442
> +#define SRST_P_PMU1_BIU			786443
> +#define SRST_H_PMU_CM0_BIU		786444
> +#define SRST_F_PMU_CM0_CORE		786445
> +#define SRST_T_PMU1_CM0_JTAG		786446
> +
> +/********Name=PMU1SOFTRST_CON01,Offset=0x30A04********/
> +#define SRST_DDR_FAIL_SAFE		786449
> +#define SRST_P_CRU_PMU1			786450
> +#define SRST_P_PMU1_GRF			786452
> +#define SRST_P_PMU1_IOC			786453
> +#define SRST_P_PMU1WDT			786454
> +#define SRST_T_PMU1WDT			786455
> +#define SRST_P_PMU1TIMER		786456
> +#define SRST_PMU1TIMER0			786458
> +#define SRST_PMU1TIMER1			786459
> +#define SRST_P_PMU1PWM			786460
> +#define SRST_PMU1PWM			786461
> +
> +/********Name=PMU1SOFTRST_CON02,Offset=0x30A08********/
> +#define SRST_P_I2C0			786465
> +#define SRST_I2C0			786466
> +#define SRST_S_UART0			786469
> +#define SRST_P_UART0			786470
> +#define SRST_H_I2S1_8CH			786471
> +#define SRST_M_I2S1_8CH_TX		786474
> +#define SRST_M_I2S1_8CH_RX		786477
> +#define SRST_H_PDM0			786478
> +#define SRST_PDM0			786479
> +
> +/********Name=PMU1SOFTRST_CON03,Offset=0x30A0C********/
> +#define SRST_H_VAD			786480
> +#define SRST_HDPTX0_INIT		786491
> +#define SRST_HDPTX0_CMN			786492
> +#define SRST_HDPTX0_LANE		786493
> +#define SRST_HDPTX1_INIT		786495
> +
> +/********Name=PMU1SOFTRST_CON04,Offset=0x30A10********/
> +#define SRST_HDPTX1_CMN			786496
> +#define SRST_HDPTX1_LANE		786497
> +#define SRST_M_MIPI_DCPHY0		786499
> +#define SRST_S_MIPI_DCPHY0		786500
> +#define SRST_M_MIPI_DCPHY1		786501
> +#define SRST_S_MIPI_DCPHY1		786502
> +#define SRST_OTGPHY_U3_0		786503
> +#define SRST_OTGPHY_U3_1		786504
> +#define SRST_OTGPHY_U2_0		786505
> +#define SRST_OTGPHY_U2_1		786506
> +
> +/********Name=PMU1SOFTRST_CON05,Offset=0x30A14********/
> +#define SRST_P_PMU0GRF			786515
> +#define SRST_P_PMU0IOC			786516
> +#define SRST_P_GPIO0			786517
> +#define SRST_GPIO0			786518
> +
> +/* scmi-clocks indices */
> +
> +#define SCMI_CLK_CPUL			0
> +#define SCMI_CLK_DSU			1
> +#define SCMI_CLK_CPUB01			2
> +#define SCMI_CLK_CPUB23			3
> +#define SCMI_CLK_DDR			4
> +#define SCMI_CLK_GPU			5
> +#define SCMI_CLK_NPU			6
> +#define SCMI_CLK_SBUS			7
> +#define SCMI_PCLK_SBUS			8
> +#define SCMI_CCLK_SD			9
> +#define SCMI_DCLK_SD			10
> +#define SCMI_ACLK_SECURE_NS		11
> +#define SCMI_HCLK_SECURE_NS		12
> +#define SCMI_TCLK_WDT			13
> +#define SCMI_KEYLADDER_CORE		14
> +#define SCMI_KEYLADDER_RNG		15
> +#define SCMI_ACLK_SECURE_S		16
> +#define SCMI_HCLK_SECURE_S		17
> +#define SCMI_PCLK_SECURE_S		18
> +#define SCMI_CRYPTO_RNG			19
> +#define SCMI_CRYPTO_CORE		20
> +#define SCMI_CRYPTO_PKA			21
> +#define SCMI_SPLL			22
> +
> +/********Name=SECURE_SOFTRST_CON00,Offset=0xA00********/
> +#define SRST_A_SECURE_NS_BIU		10
> +#define SRST_H_SECURE_NS_BIU		11
> +#define SRST_A_SECURE_S_BIU		12
> +#define SRST_H_SECURE_S_BIU		13
> +#define SRST_P_SECURE_S_BIU		14
> +#define SRST_CRYPTO_CORE		15
> +/********Name=SECURE_SOFTRST_CON01,Offset=0xA04********/
> +#define SRST_CRYPTO_PKA			16
> +#define SRST_CRYPTO_RNG			17
> +#define SRST_A_CRYPTO			18
> +#define SRST_H_CRYPTO			19
> +#define SRST_KEYLADDER_CORE		25
> +#define SRST_KEYLADDER_RNG		26
> +#define SRST_A_KEYLADDER		27
> +#define SRST_H_KEYLADDER		28
> +#define SRST_P_OTPC_S			29
> +#define SRST_OTPC_S			30
> +#define SRST_WDT_S			31
> +/********Name=SECURE_SOFTRST_CON02,Offset=0xA08********/
> +#define SRST_T_WDT_S			32
> +#define SRST_H_BOOTROM			33
> +#define SRST_A_DCF			34
> +#define SRST_P_DCF			35
> +#define SRST_H_BOOTROM_NS		37
> +#define SRST_P_KEYLADDER		46
> +#define SRST_H_TRNG_S			47
> +/********Name=SECURE_SOFTRST_CON03,Offset=0xA0C********/
> +#define SRST_H_TRNG_NS			48
> +#define SRST_D_SDMMC_BUFFER		49
> +#define SRST_H_SDMMC			50
> +#define SRST_H_SDMMC_BUFFER		51
> +#define SRST_SDMMC			52
> +#define SRST_P_TRNG_CHK			53
> +#define SRST_TRNG_S			54
> +
> +#endif
> -- 
> 2.35.1
> 
> 
