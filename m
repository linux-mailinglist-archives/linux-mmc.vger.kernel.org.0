Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180C82CBF88
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Dec 2020 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLBO02 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Dec 2020 09:26:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:49101 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLBO01 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 09:26:27 -0500
IronPort-SDR: 1hpIvdlHpW1BTw6GVrGpWq7g2wI51YB4bt7B7i3c3PAthR/eqUSc/sQfw0SSHEBCU9gDmwIR5u
 fEERB0OqQ5EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191237422"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="191237422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 06:25:47 -0800
IronPort-SDR: IIuCUpAxxh9v/TacCJhn1lbrrt0BlSo992la3KVuHURMewBbdNr+Sk3wMfOfeoDZyUZKsg4pPd
 Bctc+3gk2bIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="365318446"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2020 06:25:38 -0800
Subject: Re: [PATCH 1/8] mmc: add basic support for inline encryption
To:     Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
References: <20201112194011.103774-1-ebiggers@kernel.org>
 <20201112194011.103774-2-ebiggers@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5074a294-58cb-0da8-fe82-36eef6d31b77@intel.com>
Date:   Wed, 2 Dec 2020 16:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201112194011.103774-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/11/20 9:40 pm, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for adding CQHCI crypto engine (inline encryption)
> support, add the code required to make mmc_core and mmc_block aware of
> inline encryption.  Specifically:
> 
> - Add a capability flag MMC_CAP2_CRYPTO to struct mmc_host.  Drivers
>   will set this if the host and driver support inline encryption.
> 
> - Embed a blk_keyslot_manager in struct mmc_host.  Drivers will
>   initialize this if the host and driver support inline encryption.
>   mmc_block registers this keyslot manager with the request_queue of any
>   MMC card attached to the host.  mmc_core destroys this keyslot manager
>   when freeing the mmc_host.
> 
> - Make mmc_block copy the crypto keyslot and crypto data unit number
>   from struct request to struct mmc_request, so that drivers will have
>   access to them.
> 
> - If the MMC host is reset, reprogram all the keyslots to ensure that
>   the software state stays in sync with the hardware state.
> 
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/Kconfig  |  8 ++++++
>  drivers/mmc/core/Makefile |  1 +
>  drivers/mmc/core/block.c  |  3 +++
>  drivers/mmc/core/core.c   |  3 +++
>  drivers/mmc/core/crypto.c | 54 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/crypto.h | 46 +++++++++++++++++++++++++++++++++
>  drivers/mmc/core/host.c   |  2 ++
>  drivers/mmc/core/queue.c  |  3 +++
>  include/linux/mmc/core.h  |  6 +++++
>  include/linux/mmc/host.h  |  7 +++++
>  10 files changed, 133 insertions(+)
>  create mode 100644 drivers/mmc/core/crypto.c
>  create mode 100644 drivers/mmc/core/crypto.h
> 
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index c12fe13e4b147..ae8b69aee6190 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -81,3 +81,11 @@ config MMC_TEST
>  	  This driver is only of interest to those developing or
>  	  testing a host driver. Most people should say N here.
>  
> +config MMC_CRYPTO
> +	bool "MMC Crypto Engine Support"
> +	depends on BLK_INLINE_ENCRYPTION
> +	help
> +	  Enable Crypto Engine Support in MMC.
> +	  Enabling this makes it possible for the kernel to use the crypto
> +	  capabilities of the MMC device (if present) to perform crypto
> +	  operations on data being transferred to/from the device.
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index 95ffe008ebdf8..6a907736cd7a5 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
>  mmc_block-objs			:= block.o queue.o
>  obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
>  obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
> +mmc_core-$(CONFIG_MMC_CRYPTO)	+= crypto.o
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8d3df0be0355c..eaf2f10743260 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -51,6 +51,7 @@
>  #include "block.h"
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> @@ -1247,6 +1248,8 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>  
>  	memset(brq, 0, sizeof(struct mmc_blk_request));
>  
> +	mmc_crypto_prepare_req(mqrq);
> +
>  	brq->mrq.data = &brq->data;
>  	brq->mrq.tag = req->tag;
>  
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d42037f0f10d7..275de270232b3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -37,6 +37,7 @@
>  
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "bus.h"
>  #include "host.h"
>  #include "sdio_bus.h"
> @@ -992,6 +993,8 @@ void mmc_set_initial_state(struct mmc_host *host)
>  		host->ops->hs400_enhanced_strobe(host, &host->ios);
>  
>  	mmc_set_ios(host);
> +
> +	mmc_crypto_set_initial_state(host);
>  }
>  
>  /**
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> new file mode 100644
> index 0000000000000..4f47eb4740db0
> --- /dev/null
> +++ b/drivers/mmc/core/crypto.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMC crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <linux/blk-crypto.h>
> +#include <linux/mmc/host.h>
> +
> +#include "core.h"
> +#include "crypto.h"
> +#include "queue.h"
> +
> +void mmc_crypto_set_initial_state(struct mmc_host *host)
> +{
> +	/* Reset might clear all keys, so reprogram all the keys. */
> +	if (host->caps2 & MMC_CAP2_CRYPTO)
> +		blk_ksm_reprogram_all_keys(&host->ksm);
> +}
> +
> +void mmc_crypto_free_host(struct mmc_host *host)
> +{
> +	if (host->caps2 & MMC_CAP2_CRYPTO)
> +		blk_ksm_destroy(&host->ksm);
> +}
> +
> +void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
> +{
> +	if (host->caps2 & MMC_CAP2_CRYPTO)
> +		blk_ksm_register(&host->ksm, q);
> +}
> +EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
> +
> +void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
> +{
> +	struct request *req = mmc_queue_req_to_req(mqrq);
> +	struct mmc_request *mrq = &mqrq->brq.mrq;
> +
> +	if (!req->crypt_keyslot)
> +		return;
> +
> +	mrq->crypto_enabled = true;
> +	mrq->crypto_key_slot = blk_ksm_get_slot_idx(req->crypt_keyslot);
> +
> +	/*
> +	 * For now we assume that all MMC drivers set max_dun_bytes_supported=4,
> +	 * which is the limit for CQHCI crypto.  So all DUNs should be 32-bit.
> +	 */
> +	WARN_ON_ONCE(req->crypt_ctx->bc_dun[0] > U32_MAX);
> +
> +	mrq->data_unit_num = req->crypt_ctx->bc_dun[0];
> +}
> +EXPORT_SYMBOL_GPL(mmc_crypto_prepare_req);
> diff --git a/drivers/mmc/core/crypto.h b/drivers/mmc/core/crypto.h
> new file mode 100644
> index 0000000000000..4780639b832f4
> --- /dev/null
> +++ b/drivers/mmc/core/crypto.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * MMC crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#ifndef _MMC_CORE_CRYPTO_H
> +#define _MMC_CORE_CRYPTO_H
> +
> +struct mmc_host;
> +struct mmc_queue_req;
> +struct request_queue;
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +
> +void mmc_crypto_set_initial_state(struct mmc_host *host);
> +
> +void mmc_crypto_free_host(struct mmc_host *host);
> +
> +void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host);
> +
> +void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq);
> +
> +#else /* CONFIG_MMC_CRYPTO */
> +
> +static inline void mmc_crypto_set_initial_state(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_free_host(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_setup_queue(struct request_queue *q,
> +					  struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
> +{
> +}
> +
> +#endif /* !CONFIG_MMC_CRYPTO */
> +
> +#endif /* _MMC_CORE_CRYPTO_H */
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 96b2ca1f1b06d..d962b9ca0e37a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  
>  #include "core.h"
> +#include "crypto.h"
>  #include "host.h"
>  #include "slot-gpio.h"
>  #include "pwrseq.h"
> @@ -532,6 +533,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>   */
>  void mmc_free_host(struct mmc_host *host)
>  {
> +	mmc_crypto_free_host(host);
>  	mmc_pwrseq_free(host);
>  	put_device(&host->class_dev);
>  }
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c308..d96db852bb91a 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -19,6 +19,7 @@
>  #include "block.h"
>  #include "core.h"
>  #include "card.h"
> +#include "crypto.h"
>  #include "host.h"
>  
>  #define MMC_DMA_MAP_MERGE_SEGMENTS	512
> @@ -405,6 +406,8 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  	mutex_init(&mq->complete_lock);
>  
>  	init_waitqueue_head(&mq->wait);
> +
> +	mmc_crypto_setup_queue(mq->queue, host);
>  }
>  
>  static inline bool mmc_merge_capable(struct mmc_host *host)
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 29aa507116261..ab19245e99451 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -162,6 +162,12 @@ struct mmc_request {
>  	bool			cap_cmd_during_tfr;
>  
>  	int			tag;
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +	bool			crypto_enabled;
> +	int			crypto_key_slot;
> +	u32			data_unit_num;
> +#endif
>  };
>  
>  struct mmc_card;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c079b932330f2..550460bf1b37c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -15,6 +15,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/pm.h>
>  #include <linux/dma-direction.h>
> +#include <linux/keyslot-manager.h>
>  
>  struct mmc_ios {
>  	unsigned int	clock;			/* clock rate */
> @@ -377,6 +378,7 @@ struct mmc_host {
>  #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
>  #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
>  #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
> +#define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
>  
>  	int			fixed_drv_type;	/* fixed driver type for non-removable media */
>  
> @@ -471,6 +473,11 @@ struct mmc_host {
>  	bool			cqe_enabled;
>  	bool			cqe_on;
>  
> +	/* Inline encryption support */
> +#ifdef CONFIG_MMC_CRYPTO
> +	struct blk_keyslot_manager ksm;
> +#endif
> +
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
>  
> 

