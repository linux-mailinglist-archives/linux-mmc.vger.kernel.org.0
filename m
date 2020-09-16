Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8726BD7B
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Sep 2020 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIPGq0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Sep 2020 02:46:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:21421 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIPGqZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Sep 2020 02:46:25 -0400
IronPort-SDR: H2+SbOqIwdnwJtrUDqCd7XeIO6XdKbzWNWFDmpzfaWbEBFT0cHyfyQdaTjG44cxZYq0bcsrHOL
 hr7+U47pZAbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244249240"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="244249240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 23:46:22 -0700
IronPort-SDR: 8pNiFhKB8xjXCqso4CeNLCnXovZ1q+gtlWZnwxSSRIfOrevC91gDvwR7dIgxs0g0D684SDqvco
 Dhou4HeYmx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="319734879"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2020 23:46:19 -0700
Subject: Re: [RFC PATCH V3 09/21] mmc: sdhci: add UHS-II related definitions
 in headers
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111021.29397-1-benchuanggli@gmail.com>
 <241daa0e-1729-0e75-7922-3225654891c3@intel.com>
 <20200915064710.GC2860208@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e5ec27c6-5ae9-9d11-6a3c-036a439b6ddd@intel.com>
Date:   Wed, 16 Sep 2020 09:45:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915064710.GC2860208@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/09/20 9:47 am, AKASHI Takahiro wrote:
> Adrian,
> 
> On Fri, Aug 21, 2020 at 05:04:16PM +0300, Adrian Hunter wrote:
>> On 10/07/20 2:10 pm, Ben Chuang wrote:
>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>
>>> Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci-uhs2.h | 215 ++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.h      |  91 +++++++++++++-
>>>  2 files changed, 305 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
>>> new file mode 100644
>>> index 000000000000..a7f53f95d69a
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-uhs2.h
>>> @@ -0,0 +1,215 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
>>> + *  Interface driver
>>> + *
>>> + * Header file for Host Controller UHS2 related registers and I/O accessors.
>>> + *
>>> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
>>> + */
>>> +#ifndef __SDHCI_UHS2_H
>>> +#define __SDHCI_UHS2_H
>>> +
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/mmc/core.h>
>>> +#include <linux/mmc/uhs2.h>
>>
>> These includes should not be here unless this file needs them, which doesn't
>> look like it.
> 
> Okay.
> 
>> Wouldn't hurt to make use of BIT and GENMASK macros since this is a new file.
> 
> Will try to convert all.
> 
>>> +
>>> +/*
>>> + * UHS-II Controller registers
>>> + * 0x74 preset in sdhci.h
>>> + * 0x80
>>> + * 0x84-0xB4
>>> + * 0xB8-0xCF
>>> + * 0xE0-0xE7
>>> + */
>>> +/* UHS2 */
>>> +#define SDHCI_UHS2_BLOCK_SIZE	0x80
>>> +#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
>>> +	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
>>> +
>>> +#define SDHCI_UHS2_BLOCK_COUNT	0x84
>>> +
>>> +#define SDHCI_UHS2_CMD_PACKET	0x88
>>> +#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
>>> +
>>> +#define SDHCI_UHS2_TRANS_MODE	0x9C
>>> +#define  SDHCI_UHS2_TRNS_DMA		0x0001
>>> +#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	0x0002
>>> +#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	0x0010
>>> +#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	0x0020
>>> +#define  SDHCI_UHS2_TRNS_RES_R5		0x0040
>>> +#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	0x0080
>>> +#define  SDHCI_UHS2_TRNS_RES_INT_DIS	0x0100
>>> +#define  SDHCI_UHS2_TRNS_WAIT_EBSY	0x4000
>>> +#define  SDHCI_UHS2_TRNS_2L_HD		0x8000
>>> +
>>> +#define SDHCI_UHS2_COMMAND	0x9E
>>> +#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
>>> +#define  SDHCI_UHS2_COMMAND_DATA	0x0020
>>> +#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
>>> +#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
>>> +#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
>>> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	0x1F00
>>> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
>>> +
>>> +#define SDHCI_UHS2_RESPONSE	0xA0
>>> +#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
>>> +
>>> +#define SDHCI_UHS2_MSG_SELECT	0xB4
>>> +#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
>>> +#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
>>> +#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
>>> +#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
>>> +
>>> +#define SDHCI_UHS2_MSG		0xB8
>>> +
>>> +#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
>>> +
>>> +#define SDHCI_UHS2_DEV_SELECT	0xBE
>>> +#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	0x0F
>>> +#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	0x80
>>> +
>>> +#define SDHCI_UHS2_DEV_INT_CODE	0xBF
>>> +
>>> +#define SDHCI_UHS2_SW_RESET	0xC0
>>> +#define SDHCI_UHS2_SW_RESET_FULL	0x0001
>>> +#define SDHCI_UHS2_SW_RESET_SD		0x0002
>>> +
>>> +#define SDHCI_UHS2_TIMER_CTRL	0xC2
>>> +#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
>>> +
>>> +#define SDHCI_UHS2_ERR_INT_STATUS		0xC4
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_EN		0xC8
>>> +#define SDHCI_UHS2_ERR_INT_SIG_EN		0xCC
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	0x00000001
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_RES		0x00000002
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	0x00000004
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_CRC		0x00000008
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		0x00000010
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_TID		0x00000020
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	0x00000080
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		0x00000100
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		0x00008000
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	0x00010000
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	0x00020000
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	0x08000000
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
>>> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
>>> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
>>> +/* CRC Error occurs during a packet receiving */
>>> +#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
>>> +		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
>>> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
>>> +
>>> +#define SDHCI_UHS2_SET_PTR	0xE0
>>> +#define   SDHCI_UHS2_GEN_SET_POWER_LOW		0x0001
>>> +#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
>>> +#define   SDHCI_UHS2_GEN_SET_2L_FD_HD		0x0
>>> +#define   SDHCI_UHS2_GEN_SET_2D1U_FD		0x2
>>> +#define   SDHCI_UHS2_GEN_SET_1D2U_FD		0x3
>>> +#define   SDHCI_UHS2_GEN_SET_2D2U_FD		0x4
>>> +
>>> +#define   SDHCI_UHS2_PHY_SET_SPEED_POS		6
>>> +#define   SDHCI_UHS2_PHY_SET_HIBER_EN		0x00008000
>>> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	0x000F0000
>>> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
>>> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	0x00F00000
>>> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
>>> +
>>> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	0x0000FF00
>>> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS		8
>>> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	0x00030000
>>> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
>>> +
>>> +#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	0x000000FF
>>> +
>>> +#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
>>> +#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	0x0000000F
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	0x000000F0
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	((gap) * 360)
>>> +#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	0x00003F00
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	0x00004000
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		0x00008000
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	0x00030000
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
>>> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		0x003C0000
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	0x00C00000
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
>>> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
>>> +
>>> +#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK		0x0000003F
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK		0x000000C0
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT		6
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A		0
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B		1
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	0x000F0000
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	0x00F00000
>>> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
>>> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	0x0000003F
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		0x0000FF00
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	0x00070000
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	0xFFF00000
>>> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
>>> +
>>> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
>>> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	0x000000FF
>>> +
>>> +#define SDHCI_UHS2_TEST_PTR	0xE4
>>> +#define  SDHCI_UHS2_TEST_ERR_HEADER	0x00000001
>>> +#define  SDHCI_UHS2_TEST_ERR_RES	0x00000002
>>> +#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	0x00000004
>>> +#define  SDHCI_UHS2_TEST_ERR_CRC	0x00000008
>>> +#define  SDHCI_UHS2_TEST_ERR_FRAME	0x00000010
>>> +#define  SDHCI_UHS2_TEST_ERR_TID	0x00000020
>>> +#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	0x00000080
>>> +#define  SDHCI_UHS2_TEST_ERR_EBUSY	0x00000100
>>> +#define  SDHCI_UHS2_TEST_ERR_ADMA	0x00008000
>>> +#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	0x00010000
>>> +#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	0x00020000
>>> +#define  SDHCI_UHS2_TEST_ERR_VENDOR	0x08000000
>>> +
>>> +#define SDHCI_UHS2_EMBED_CTRL	0xE6
>>> +#define SDHCI_UHS2_VENDOR	0xE8
>>> +
>>> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>>> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>>> +
>>> +#endif /* __SDHCI_UHS2_H */
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 0008bbd27127..ecf55394ea46 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -43,8 +43,27 @@
>>>  #define  SDHCI_TRNS_READ	0x10
>>>  #define  SDHCI_TRNS_MULTI	0x20
>>>  
>>> +/*
>>> + * Defined in Host Version 4.10.
>>> + * 1 - R5 (SDIO)
>>> + * 0 - R1 (Memory)
>>> + */
>>> +#define  SDHCI_TRNS_RES_TYPE		0x40
>>> +#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
>>> +#define  SDHCI_TRNS_RES_INT_DIS		0x0100
>>> +
>>>  #define SDHCI_COMMAND		0x0E
>>>  #define  SDHCI_CMD_RESP_MASK	0x03
>>> +
>>> +/*
>>> + * Host Version 4.10 adds this bit to distinguish a main command or
>>> + * sub command.
>>> + * CMD53(SDIO) - main command
>>> + * CMD52(SDIO) - sub command which doesn't have data block or doesn't
>>> + * indicate busy.
>>> + */
>>> +#define  SDHCI_CMD_SUB_CMD	0x04
>>> +
>>>  #define  SDHCI_CMD_CRC		0x08
>>>  #define  SDHCI_CMD_INDEX	0x10
>>>  #define  SDHCI_CMD_DATA		0x20
>>> @@ -60,11 +79,19 @@
>>>  
>>>  #define SDHCI_RESPONSE		0x10
>>>  
>>> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
>>> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
>>> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
>>> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8
>>> +
>>>  #define SDHCI_BUFFER		0x20
>>>  
>>>  #define SDHCI_PRESENT_STATE	0x24
>>>  #define  SDHCI_CMD_INHIBIT	0x00000001
>>>  #define  SDHCI_DATA_INHIBIT	0x00000002
>>> +
>>> +#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
>>> +
>>>  #define  SDHCI_DOING_WRITE	0x00000100
>>>  #define  SDHCI_DOING_READ	0x00000200
>>>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
>>> @@ -80,6 +107,13 @@
>>>  #define   SDHCI_DATA_0_LVL_MASK	0x00100000
>>>  #define  SDHCI_CMD_LVL		0x01000000
>>>  
>>> +#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
>>> +#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
>>> +#define  SDHCI_SUB_CMD_STATUS		0x10000000
>>> +#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
>>> +#define  SDHCI_UHS2_LANE_SYNC		0x40000000
>>> +#define  SDHCI_UHS2_IF_DETECT		0x80000000
>>> +
>>>  #define SDHCI_HOST_CONTROL	0x28
>>>  #define  SDHCI_CTRL_LED		0x01
>>>  #define  SDHCI_CTRL_4BITBUS	0x02
>>> @@ -100,6 +134,11 @@
>>>  #define  SDHCI_POWER_300	0x0C
>>>  #define  SDHCI_POWER_330	0x0E
>>>  
>>> +/* VDD2 - UHS2 */
>>> +#define  SDHCI_VDD2_POWER_ON		0x10
>>> +#define  SDHCI_VDD2_POWER_180		0xA0
>>> +#define  SDHCI_VDD2_POWER_120		0x80
>>> +
>>>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>>>  
>>>  #define SDHCI_WAKE_UP_CONTROL	0x2B
>>> @@ -110,7 +149,7 @@
>>>  #define SDHCI_CLOCK_CONTROL	0x2C
>>>  #define  SDHCI_DIVIDER_SHIFT	8
>>>  #define  SDHCI_DIVIDER_HI_SHIFT	6
>>> -#define  SDHCI_DIV_MASK	0xFF
>>> +#define  SDHCI_DIV_MASK		0xFF
>>>  #define  SDHCI_DIV_MASK_LEN	8
>>>  #define  SDHCI_DIV_HI_MASK	0x300
>>>  #define  SDHCI_PROG_CLOCK_MODE	0x0020
>>> @@ -139,6 +178,10 @@
>>>  #define  SDHCI_INT_CARD_REMOVE	0x00000080
>>>  #define  SDHCI_INT_CARD_INT	0x00000100
>>>  #define  SDHCI_INT_RETUNE	0x00001000
>>> +
>>> +/* Host Version 4.10 */
>>> +#define  SDHCI_INT_FX_EVENT	0x00002000
>>> +
>>>  #define  SDHCI_INT_CQE		0x00004000
>>>  #define  SDHCI_INT_ERROR	0x00008000
>>>  #define  SDHCI_INT_TIMEOUT	0x00010000
>>> @@ -152,6 +195,9 @@
>>>  #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
>>>  #define  SDHCI_INT_ADMA_ERROR	0x02000000
>>>  
>>> +/* Host Version 4.0 */
>>> +#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
>>> +
>>>  #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
>>>  #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
>>>  
>>> @@ -178,6 +224,9 @@
>>>  #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
>>>  #define  SDHCI_AUTO_CMD_INDEX	0x00000010
>>>  
>>> +/* Host Version 4.10 */
>>> +#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
>>> +
>>>  #define SDHCI_HOST_CONTROL2		0x3E
>>>  #define  SDHCI_CTRL_UHS_MASK		0x0007
>>>  #define   SDHCI_CTRL_UHS_SDR12		0x0000
>>> @@ -186,6 +235,7 @@
>>>  #define   SDHCI_CTRL_UHS_SDR104		0x0003
>>>  #define   SDHCI_CTRL_UHS_DDR50		0x0004
>>>  #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
>>> +#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */
>>>  #define  SDHCI_CTRL_VDD_180		0x0008
>>>  #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
>>>  #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
>>> @@ -194,9 +244,12 @@
>>>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>>>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>>>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
>>> +#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */
>>> +#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
>>>  #define  SDHCI_CMD23_ENABLE		0x0800
>>>  #define  SDHCI_CTRL_V4_MODE		0x1000
>>>  #define  SDHCI_CTRL_64BIT_ADDR		0x2000
>>> +#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>>>  
>>>  #define SDHCI_CAPABILITIES	0x40
>>> @@ -217,11 +270,13 @@
>>>  #define  SDHCI_CAN_VDD_180	0x04000000
>>>  #define  SDHCI_CAN_64BIT_V4	0x08000000
>>>  #define  SDHCI_CAN_64BIT	0x10000000
>>> +#define  SDHCI_CAN_ASYNC_INT	0x20000000
>>>  
>>>  #define SDHCI_CAPABILITIES_1	0x44
>>>  #define  SDHCI_SUPPORT_SDR50	0x00000001
>>>  #define  SDHCI_SUPPORT_SDR104	0x00000002
>>>  #define  SDHCI_SUPPORT_DDR50	0x00000004
>>> +#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */
>>>  #define  SDHCI_DRIVER_TYPE_A	0x00000010
>>>  #define  SDHCI_DRIVER_TYPE_C	0x00000020
>>>  #define  SDHCI_DRIVER_TYPE_D	0x00000040
>>> @@ -230,19 +285,28 @@
>>>  #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
>>>  #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
>>>  #define  SDHCI_CAN_DO_ADMA3	0x08000000
>>> +#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
>>> +#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */
>>>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>>>  
>>>  #define SDHCI_MAX_CURRENT		0x48
>>> +#define SDHCI_MAX_CURRENT_1		0x4C
>>>  #define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
>>>  #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
>>>  #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
>>>  #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
>>> +#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
>>>  #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
>>>  
>>>  /* 4C-4F reserved for more max current */
>>>  
>>>  #define SDHCI_SET_ACMD12_ERROR	0x50
>>> +/* Host Version 4.10 */
>>> +#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
>>>  #define SDHCI_SET_INT_ERROR	0x52
>>> +/* Host Version 4.10 */
>>> +#define SDHCI_SET_INT_TUNING_ERROR	0x0400
>>> +#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
>>>  
>>>  #define SDHCI_ADMA_ERROR	0x54
>>>  
>>> @@ -259,10 +323,16 @@
>>>  #define SDHCI_PRESET_FOR_SDR104        0x6C
>>>  #define SDHCI_PRESET_FOR_DDR50 0x6E
>>>  #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
>>> +
>>> +/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
>>> +/* UHS2 */
>>> +#define SDHCI_PRESET_FOR_UHS2  0x74
>>>  #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
>>>  #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
>>>  #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
>>>  
>>> +#define SDHCI_ADMA3_ADDRESS	0x78
>>> +
>>>  #define SDHCI_SLOT_INT_STATUS	0xFC
>>>  
>>>  #define SDHCI_HOST_VERSION	0xFE
>>> @@ -653,6 +723,25 @@ struct sdhci_ops {
>>>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
>>>  };
>>>  
>>> +struct sdhci_uhs2_ops {
>>> +	/* UHS-2 support */
>>> +	void	(*reset)(struct sdhci_host *host, u16 mask);
>>> +	void	(*set_timeout)(struct sdhci_host *host);
>>> +	void	(*set_transfer_mode)(struct sdhci_host *host,
>>> +				     struct mmc_command *cmd);
>>> +	void	(*send_command)(struct sdhci_host *host,
>>> +				struct mmc_command *cmd);
>>> +	void	(*finish_command)(struct sdhci_host *host);
>>> +	void	(*do_set_ios)(struct sdhci_host *host, struct mmc_ios *ios);
>>> +	int	(*do_detect_init)(struct sdhci_host *host);
>>> +	int	(*do_set_reg)(struct sdhci_host *host, enum uhs2_act act);
>>> +	void	(*irq)(struct sdhci_host *host);
>>> +	int	(*add_host)(struct sdhci_host *host, u32 caps1);
>>> +	void	(*remove_host)(struct sdhci_host *host, int dead);
>>> +};
>>
>> Instead of this structure, please just add functions to sdhci_ops.
> 
> I think that one of your requirements is to purge all uhs2-related
> code from sdhci.c and that the structure above meets it.
> 
> But I will try to move them to struct sdhci_ops if you really want.

Sorry if it seems like a pain, but yes please.

> 
> -Takahiro Akashi
> 
>>> +
>>> +extern struct sdhci_uhs2_ops sdhci_uhs2_ops;
>>> +
>>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>  
>>>  static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
>>>
>>

