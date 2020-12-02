Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B042CBE0E
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Dec 2020 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgLBNPk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Dec 2020 08:15:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:55542 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgLBNPk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 08:15:40 -0500
IronPort-SDR: oCnmEuuqrM069TNN/RlxrwY4ktmbUBBrOzzVDihQTCW7uMqWEMJN+g+Cku8/H8tzrt7QMVyICi
 6IWOER2xJgRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="237137668"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="237137668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 05:14:57 -0800
IronPort-SDR: 4bUCAipc8/5e2Pu2lVxmi/b5AvdoKMZzMkdcAFynARVgekB+qcgtGtZHQyfdcEv2Hxxpi1a7il
 Tap4+TLi6qVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="550054064"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 05:14:52 -0800
Subject: Re: [PATCH 3/8] mmc: cqhci: add support for inline encryption
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
 <20201112194011.103774-4-ebiggers@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <48269904-d031-c2fd-59c5-78f7948b032a@intel.com>
Date:   Wed, 2 Dec 2020 15:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201112194011.103774-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/11/20 9:40 pm, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for eMMC inline encryption using the blk-crypto framework
> (Documentation/block/inline-encryption.rst).
> 
> eMMC inline encryption support is specified by the upcoming JEDEC eMMC
> v5.2 specification.  It is only specified for the CQ interface, not the
> non-CQ interface.  Although the eMMC v5.2 specification hasn't been
> officially released yet, the crypto support was already agreed on
> several years ago, and it was already implemented by at least two major
> hardware vendors.  Lots of hardware in the field already supports and
> uses it, e.g. Snapdragon 630 to give one example.
> 
> eMMC inline encryption support is very similar to the UFS inline
> encryption support which was standardized in the UFS v2.1 specification
> and was already upstreamed.  The only major difference is that eMMC
> limits data unit numbers to 32 bits, unlike UFS's 64 bits.
> 
> Like we did with UFS, make the crypto support opt-in by individual
> drivers; don't enable it automatically whenever the hardware declares
> crypto support.  This is necessary because in every case we've seen,
> some extra vendor-specific logic is needed to use the crypto support.
> 
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

One minor comment and a question below.

> ---
>  drivers/mmc/host/Makefile       |   1 +
>  drivers/mmc/host/cqhci-core.c   |  66 +++++++--
>  drivers/mmc/host/cqhci-crypto.c | 233 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci-crypto.h |  47 +++++++
>  drivers/mmc/host/cqhci.h        |  81 ++++++++++-
>  5 files changed, 416 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/mmc/host/cqhci-crypto.c
>  create mode 100644 drivers/mmc/host/cqhci-crypto.h
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 20c2f9463d0dc..35158508ab63d 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
>  obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
>  cqhci-y					+= cqhci-core.o
> +cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
>  obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
>  
>  ifeq ($(CONFIG_CB710_DEBUG),y)
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index 697fe40756bf2..ac0f886b1e7d2 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -18,6 +18,7 @@
>  #include <linux/mmc/card.h>
>  
>  #include "cqhci.h"
> +#include "cqhci-crypto.h"
>  
>  #define DCMD_SLOT 31
>  #define NUM_SLOTS 32
> @@ -258,6 +259,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  	if (cq_host->caps & CQHCI_TASK_DESC_SZ_128)
>  		cqcfg |= CQHCI_TASK_DESC_SZ;
>  
> +	if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +		cqcfg |= CQHCI_CRYPTO_GENERAL_ENABLE;
> +
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  
>  	cqhci_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
> @@ -408,13 +412,15 @@ static void cqhci_disable(struct mmc_host *mmc)
>  }
>  
>  static void cqhci_prep_task_desc(struct mmc_request *mrq,
> -					u64 *data, bool intr)
> +				 struct cqhci_host *cq_host, int tag)

It would be neater if the changes to cqhci_prep_task_desc() parameters could
be a separate patch.

>  {
> +	__le64 *task_desc = (__le64 __force *)get_desc(cq_host, tag);
>  	u32 req_flags = mrq->data->flags;
> +	u64 desc0;
>  
> -	*data = CQHCI_VALID(1) |
> +	desc0 = CQHCI_VALID(1) |
>  		CQHCI_END(1) |
> -		CQHCI_INT(intr) |
> +		CQHCI_INT(1) |
>  		CQHCI_ACT(0x5) |
>  		CQHCI_FORCED_PROG(!!(req_flags & MMC_DATA_FORCED_PRG)) |
>  		CQHCI_DATA_TAG(!!(req_flags & MMC_DATA_DAT_TAG)) |
> @@ -425,8 +431,19 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
>  		CQHCI_BLK_COUNT(mrq->data->blocks) |
>  		CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
>  
> -	pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx\n",
> -		 mmc_hostname(mrq->host), mrq->tag, (unsigned long long)*data);
> +	task_desc[0] = cpu_to_le64(desc0);
> +
> +	if (cq_host->caps & CQHCI_TASK_DESC_SZ_128) {
> +		u64 desc1 = cqhci_crypto_prep_task_desc(mrq);
> +
> +		task_desc[1] = cpu_to_le64(desc1);
> +
> +		pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx%016llx\n",
> +			 mmc_hostname(mrq->host), mrq->tag, desc1, desc0);
> +	} else {
> +		pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx\n",
> +			 mmc_hostname(mrq->host), mrq->tag, desc0);
> +	}
>  }
>  
>  static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
> @@ -567,8 +584,6 @@ static inline int cqhci_tag(struct mmc_request *mrq)
>  static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	int err = 0;
> -	u64 data = 0;
> -	u64 *task_desc = NULL;
>  	int tag = cqhci_tag(mrq);
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	unsigned long flags;
> @@ -598,9 +613,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	}
>  
>  	if (mrq->data) {
> -		task_desc = (__le64 __force *)get_desc(cq_host, tag);
> -		cqhci_prep_task_desc(mrq, &data, 1);
> -		*task_desc = cpu_to_le64(data);
> +		cqhci_prep_task_desc(mrq, cq_host, tag);
> +
>  		err = cqhci_prep_tran_desc(mrq, cq_host, tag);
>  		if (err) {
>  			pr_err("%s: cqhci: failed to setup tx desc: %d\n",
> @@ -671,6 +685,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>  	struct cqhci_host *cq_host = mmc->cqe_private;
>  	struct cqhci_slot *slot;
>  	u32 terri;
> +	u32 tdpe;
>  	int tag;
>  
>  	spin_lock(&cq_host->lock);
> @@ -709,6 +724,27 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>  		}
>  	}
>  
> +	/*
> +	 * Handle "Invalid Crypto Configuration Error".  This should never
> +	 * happen, since the block layer ensures that all crypto-enabled I/O
> +	 * requests have a valid keyslot before they reach the driver.
> +	 */
> +	if (status & CQHCI_IS_ICCE) {
> +		tdpe = cqhci_readl(cq_host, CQHCI_TDPE);
> +		WARN_ONCE(1,
> +			  "%s: cqhci: invalid crypto configuration error. IRQ status: 0x%08x TDPE: 0x%08x\n",
> +			  mmc_hostname(mmc), status, tdpe);
> +		while (tdpe != 0) {
> +			tag = __ffs(tdpe);
> +			tdpe &= ~(1 << tag);
> +			slot = &cq_host->slot[tag];
> +			if (!slot->mrq)
> +				continue;
> +			slot->flags = cqhci_error_flags(data_error, cmd_error);
> +			cqhci_recovery_needed(mmc, slot->mrq, true);
> +		}
> +	}
> +

What about GCE?

>  	if (!cq_host->recovery_halt) {
>  		/*
>  		 * The only way to guarantee forward progress is to mark at
> @@ -774,7 +810,8 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>  
>  	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc), status);
>  
> -	if ((status & CQHCI_IS_RED) || cmd_error || data_error)
> +	if ((status & (CQHCI_IS_RED | CQHCI_IS_GCE | CQHCI_IS_ICCE)) ||
> +	    cmd_error || data_error)
>  		cqhci_error_irq(mmc, status, cmd_error, data_error);
>  
>  	if (status & CQHCI_IS_TCC) {
> @@ -1141,6 +1178,13 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
>  		goto out_err;
>  	}
>  
> +	err = cqhci_crypto_init(cq_host);
> +	if (err) {
> +		pr_err("%s: CQHCI crypto initialization failed\n",
> +		       mmc_hostname(mmc));
> +		goto out_err;
> +	}
> +
>  	spin_lock_init(&cq_host->lock);
>  
>  	init_completion(&cq_host->halt_comp);
> diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
> new file mode 100644
> index 0000000000000..b14a5a15f5b52
> --- /dev/null
> +++ b/drivers/mmc/host/cqhci-crypto.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CQHCI crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <linux/blk-crypto.h>
> +#include <linux/keyslot-manager.h>
> +#include <linux/mmc/host.h>
> +
> +#include "cqhci-crypto.h"
> +
> +/* Map from blk-crypto modes to CQHCI crypto algorithm IDs and key sizes */
> +static const struct cqhci_crypto_alg_entry {
> +	enum cqhci_crypto_alg alg;
> +	enum cqhci_crypto_key_size key_size;
> +} cqhci_crypto_algs[BLK_ENCRYPTION_MODE_MAX] = {
> +	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
> +		.alg = CQHCI_CRYPTO_ALG_AES_XTS,
> +		.key_size = CQHCI_CRYPTO_KEY_SIZE_256,
> +	},
> +};
> +
> +static inline struct cqhci_host *
> +cqhci_host_from_ksm(struct blk_keyslot_manager *ksm)
> +{
> +	struct mmc_host *mmc = container_of(ksm, struct mmc_host, ksm);
> +
> +	return mmc->cqe_private;
> +}
> +
> +static void cqhci_crypto_program_key(struct cqhci_host *cq_host,
> +				     const union cqhci_crypto_cfg_entry *cfg,
> +				     int slot)
> +{
> +	u32 slot_offset = cq_host->crypto_cfg_register + slot * sizeof(*cfg);
> +	int i;
> +
> +	/* Clear CFGE */
> +	cqhci_writel(cq_host, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
> +
> +	/* Write the key */
> +	for (i = 0; i < 16; i++) {
> +		cqhci_writel(cq_host, le32_to_cpu(cfg->reg_val[i]),
> +			     slot_offset + i * sizeof(cfg->reg_val[0]));
> +	}
> +	/* Write dword 17 */
> +	cqhci_writel(cq_host, le32_to_cpu(cfg->reg_val[17]),
> +		     slot_offset + 17 * sizeof(cfg->reg_val[0]));
> +	/* Write dword 16, which includes the new value of CFGE */
> +	cqhci_writel(cq_host, le32_to_cpu(cfg->reg_val[16]),
> +		     slot_offset + 16 * sizeof(cfg->reg_val[0]));
> +}
> +
> +static int cqhci_crypto_keyslot_program(struct blk_keyslot_manager *ksm,
> +					const struct blk_crypto_key *key,
> +					unsigned int slot)
> +
> +{
> +	struct cqhci_host *cq_host = cqhci_host_from_ksm(ksm);
> +	const union cqhci_crypto_cap_entry *ccap_array =
> +		cq_host->crypto_cap_array;
> +	const struct cqhci_crypto_alg_entry *alg =
> +			&cqhci_crypto_algs[key->crypto_cfg.crypto_mode];
> +	u8 data_unit_mask = key->crypto_cfg.data_unit_size / 512;
> +	int i;
> +	int cap_idx = -1;
> +	union cqhci_crypto_cfg_entry cfg = {};
> +
> +	BUILD_BUG_ON(CQHCI_CRYPTO_KEY_SIZE_INVALID != 0);
> +	for (i = 0; i < cq_host->crypto_capabilities.num_crypto_cap; i++) {
> +		if (ccap_array[i].algorithm_id == alg->alg &&
> +		    ccap_array[i].key_size == alg->key_size &&
> +		    (ccap_array[i].sdus_mask & data_unit_mask)) {
> +			cap_idx = i;
> +			break;
> +		}
> +	}
> +	if (WARN_ON(cap_idx < 0))
> +		return -EOPNOTSUPP;
> +
> +	cfg.data_unit_size = data_unit_mask;
> +	cfg.crypto_cap_idx = cap_idx;
> +	cfg.config_enable = CQHCI_CRYPTO_CONFIGURATION_ENABLE;
> +
> +	if (ccap_array[cap_idx].algorithm_id == CQHCI_CRYPTO_ALG_AES_XTS) {
> +		/* In XTS mode, the blk_crypto_key's size is already doubled */
> +		memcpy(cfg.crypto_key, key->raw, key->size/2);
> +		memcpy(cfg.crypto_key + CQHCI_CRYPTO_KEY_MAX_SIZE/2,
> +		       key->raw + key->size/2, key->size/2);
> +	} else {
> +		memcpy(cfg.crypto_key, key->raw, key->size);
> +	}
> +
> +	cqhci_crypto_program_key(cq_host, &cfg, slot);
> +
> +	memzero_explicit(&cfg, sizeof(cfg));
> +	return 0;
> +}
> +
> +static void cqhci_crypto_clear_keyslot(struct cqhci_host *cq_host, int slot)
> +{
> +	/*
> +	 * Clear the crypto cfg on the device. Clearing CFGE
> +	 * might not be sufficient, so just clear the entire cfg.
> +	 */
> +	union cqhci_crypto_cfg_entry cfg = {};
> +
> +	cqhci_crypto_program_key(cq_host, &cfg, slot);
> +}
> +
> +static int cqhci_crypto_keyslot_evict(struct blk_keyslot_manager *ksm,
> +				      const struct blk_crypto_key *key,
> +				      unsigned int slot)
> +{
> +	struct cqhci_host *cq_host = cqhci_host_from_ksm(ksm);
> +
> +	cqhci_crypto_clear_keyslot(cq_host, slot);
> +	return 0;
> +}
> +
> +static const struct blk_ksm_ll_ops cqhci_ksm_ops = {
> +	.keyslot_program	= cqhci_crypto_keyslot_program,
> +	.keyslot_evict		= cqhci_crypto_keyslot_evict,
> +};
> +
> +static enum blk_crypto_mode_num
> +cqhci_find_blk_crypto_mode(union cqhci_crypto_cap_entry cap)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cqhci_crypto_algs); i++) {
> +		BUILD_BUG_ON(CQHCI_CRYPTO_KEY_SIZE_INVALID != 0);
> +		if (cqhci_crypto_algs[i].alg == cap.algorithm_id &&
> +		    cqhci_crypto_algs[i].key_size == cap.key_size)
> +			return i;
> +	}
> +	return BLK_ENCRYPTION_MODE_INVALID;
> +}
> +
> +/**
> + * cqhci_crypto_init - initialize CQHCI crypto support
> + * @cq_host: a cqhci host
> + *
> + * If the driver previously set MMC_CAP2_CRYPTO and the CQE declares
> + * CQHCI_CAP_CS, initialize the crypto support.  This involves reading the
> + * crypto capability registers, initializing the keyslot manager, clearing all
> + * keyslots, and enabling 128-bit task descriptors.
> + *
> + * Return: 0 if crypto was initialized or isn't supported; whether
> + *	   MMC_CAP2_CRYPTO remains set indicates which one of those cases it is.
> + *	   Also can return a negative errno value on unexpected error.
> + */
> +int cqhci_crypto_init(struct cqhci_host *cq_host)
> +{
> +	struct mmc_host *mmc = cq_host->mmc;
> +	struct device *dev = mmc_dev(mmc);
> +	struct blk_keyslot_manager *ksm = &mmc->ksm;
> +	unsigned int num_keyslots;
> +	unsigned int cap_idx;
> +	enum blk_crypto_mode_num blk_mode_num;
> +	unsigned int slot;
> +	int err = 0;
> +
> +	if (!(mmc->caps2 & MMC_CAP2_CRYPTO) ||
> +	    !(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
> +		goto out;
> +
> +	cq_host->crypto_capabilities.reg_val =
> +			cpu_to_le32(cqhci_readl(cq_host, CQHCI_CCAP));
> +
> +	cq_host->crypto_cfg_register =
> +		(u32)cq_host->crypto_capabilities.config_array_ptr * 0x100;
> +
> +	cq_host->crypto_cap_array =
> +		devm_kcalloc(dev, cq_host->crypto_capabilities.num_crypto_cap,
> +			     sizeof(cq_host->crypto_cap_array[0]), GFP_KERNEL);
> +	if (!cq_host->crypto_cap_array) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * CCAP.CFGC is off by one, so the actual number of crypto
> +	 * configurations (a.k.a. keyslots) is CCAP.CFGC + 1.
> +	 */
> +	num_keyslots = cq_host->crypto_capabilities.config_count + 1;
> +
> +	err = blk_ksm_init(ksm, num_keyslots);
> +	if (err)
> +		goto out_free_caps;
> +
> +	ksm->ksm_ll_ops = cqhci_ksm_ops;
> +	ksm->dev = dev;
> +
> +	/* Unfortunately, CQHCI crypto only supports 32 DUN bits. */
> +	ksm->max_dun_bytes_supported = 4;
> +
> +	/*
> +	 * Cache all the crypto capabilities and advertise the supported crypto
> +	 * modes and data unit sizes to the block layer.
> +	 */
> +	for (cap_idx = 0; cap_idx < cq_host->crypto_capabilities.num_crypto_cap;
> +	     cap_idx++) {
> +		cq_host->crypto_cap_array[cap_idx].reg_val =
> +			cpu_to_le32(cqhci_readl(cq_host,
> +						CQHCI_CRYPTOCAP +
> +						cap_idx * sizeof(__le32)));
> +		blk_mode_num = cqhci_find_blk_crypto_mode(
> +					cq_host->crypto_cap_array[cap_idx]);
> +		if (blk_mode_num == BLK_ENCRYPTION_MODE_INVALID)
> +			continue;
> +		ksm->crypto_modes_supported[blk_mode_num] |=
> +			cq_host->crypto_cap_array[cap_idx].sdus_mask * 512;
> +	}
> +
> +	/* Clear all the keyslots so that we start in a known state. */
> +	for (slot = 0; slot < num_keyslots; slot++)
> +		cqhci_crypto_clear_keyslot(cq_host, slot);
> +
> +	/* CQHCI crypto requires the use of 128-bit task descriptors. */
> +	cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	return 0;
> +
> +out_free_caps:
> +	devm_kfree(dev, cq_host->crypto_cap_array);
> +	cq_host->crypto_cap_array = NULL;
> +out:
> +	mmc->caps2 &= ~MMC_CAP2_CRYPTO;
> +	return err;
> +}
> diff --git a/drivers/mmc/host/cqhci-crypto.h b/drivers/mmc/host/cqhci-crypto.h
> new file mode 100644
> index 0000000000000..60b58ee0e6256
> --- /dev/null
> +++ b/drivers/mmc/host/cqhci-crypto.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * CQHCI crypto engine (inline encryption) support
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#ifndef LINUX_MMC_CQHCI_CRYPTO_H
> +#define LINUX_MMC_CQHCI_CRYPTO_H
> +
> +#include <linux/mmc/host.h>
> +
> +#include "cqhci.h"
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +
> +int cqhci_crypto_init(struct cqhci_host *host);
> +
> +/*
> + * Returns the crypto bits that should be set in bits 64-127 of the
> + * task descriptor.
> + */
> +static inline u64 cqhci_crypto_prep_task_desc(struct mmc_request *mrq)
> +{
> +	if (!mrq->crypto_enabled)
> +		return 0;
> +
> +	return CQHCI_CRYPTO_ENABLE_BIT |
> +	       CQHCI_CRYPTO_KEYSLOT(mrq->crypto_key_slot) |
> +	       mrq->data_unit_num;
> +}
> +
> +#else /* CONFIG_MMC_CRYPTO */
> +
> +static inline int cqhci_crypto_init(struct cqhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static inline u64 cqhci_crypto_prep_task_desc(struct mmc_request *mrq)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_MMC_CRYPTO */
> +
> +#endif /* LINUX_MMC_CQHCI_CRYPTO_H */
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 89bf6adbce8ca..5c18734624fea 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -22,10 +22,13 @@
>  
>  /* capabilities */
>  #define CQHCI_CAP			0x04
> +#define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
> +
>  /* configuration */
>  #define CQHCI_CFG			0x08
>  #define CQHCI_DCMD			0x00001000
>  #define CQHCI_TASK_DESC_SZ		0x00000100
> +#define CQHCI_CRYPTO_GENERAL_ENABLE	0x00000002
>  #define CQHCI_ENABLE			0x00000001
>  
>  /* control */
> @@ -39,8 +42,11 @@
>  #define CQHCI_IS_TCC			BIT(1)
>  #define CQHCI_IS_RED			BIT(2)
>  #define CQHCI_IS_TCL			BIT(3)
> +#define CQHCI_IS_GCE			BIT(4) /* General Crypto Error */
> +#define CQHCI_IS_ICCE			BIT(5) /* Invalid Crypto Config Error */
>  
> -#define CQHCI_IS_MASK (CQHCI_IS_TCC | CQHCI_IS_RED)
> +#define CQHCI_IS_MASK (CQHCI_IS_TCC | CQHCI_IS_RED | \
> +		       CQHCI_IS_GCE | CQHCI_IS_ICCE)
>  
>  /* interrupt status enable */
>  #define CQHCI_ISTE			0x14
> @@ -78,6 +84,9 @@
>  /* task clear */
>  #define CQHCI_TCLR			0x38
>  
> +/* task descriptor processing error */
> +#define CQHCI_TDPE			0x3c
> +
>  /* send status config 1 */
>  #define CQHCI_SSC1			0x40
>  #define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
> @@ -107,6 +116,10 @@
>  /* command response argument */
>  #define CQHCI_CRA			0x5C
>  
> +/* crypto capabilities */
> +#define CQHCI_CCAP			0x100
> +#define CQHCI_CRYPTOCAP			0x104
> +
>  #define CQHCI_INT_ALL			0xF
>  #define CQHCI_IC_DEFAULT_ICCTH		31
>  #define CQHCI_IC_DEFAULT_ICTOVAL	1
> @@ -133,11 +146,71 @@
>  #define CQHCI_CMD_TIMING(x)		(((x) & 1) << 22)
>  #define CQHCI_RESP_TYPE(x)		(((x) & 0x3) << 23)
>  
> +/* crypto task descriptor fields (for bits 64-127 of task descriptor) */
> +#define CQHCI_CRYPTO_ENABLE_BIT		(1ULL << 47)
> +#define CQHCI_CRYPTO_KEYSLOT(x)		((u64)(x) << 32)
> +
>  /* transfer descriptor fields */
>  #define CQHCI_DAT_LENGTH(x)		(((x) & 0xFFFF) << 16)
>  #define CQHCI_DAT_ADDR_LO(x)		(((x) & 0xFFFFFFFF) << 32)
>  #define CQHCI_DAT_ADDR_HI(x)		(((x) & 0xFFFFFFFF) << 0)
>  
> +/* CCAP - Crypto Capability 100h */
> +union cqhci_crypto_capabilities {
> +	__le32 reg_val;
> +	struct {
> +		u8 num_crypto_cap;
> +		u8 config_count;
> +		u8 reserved;
> +		u8 config_array_ptr;
> +	};
> +};
> +
> +enum cqhci_crypto_key_size {
> +	CQHCI_CRYPTO_KEY_SIZE_INVALID	= 0,
> +	CQHCI_CRYPTO_KEY_SIZE_128	= 1,
> +	CQHCI_CRYPTO_KEY_SIZE_192	= 2,
> +	CQHCI_CRYPTO_KEY_SIZE_256	= 3,
> +	CQHCI_CRYPTO_KEY_SIZE_512	= 4,
> +};
> +
> +enum cqhci_crypto_alg {
> +	CQHCI_CRYPTO_ALG_AES_XTS		= 0,
> +	CQHCI_CRYPTO_ALG_BITLOCKER_AES_CBC	= 1,
> +	CQHCI_CRYPTO_ALG_AES_ECB		= 2,
> +	CQHCI_CRYPTO_ALG_ESSIV_AES_CBC		= 3,
> +};
> +
> +/* x-CRYPTOCAP - Crypto Capability X */
> +union cqhci_crypto_cap_entry {
> +	__le32 reg_val;
> +	struct {
> +		u8 algorithm_id;
> +		u8 sdus_mask; /* Supported data unit size mask */
> +		u8 key_size;
> +		u8 reserved;
> +	};
> +};
> +
> +#define CQHCI_CRYPTO_CONFIGURATION_ENABLE (1 << 7)
> +#define CQHCI_CRYPTO_KEY_MAX_SIZE 64
> +/* x-CRYPTOCFG - Crypto Configuration X */
> +union cqhci_crypto_cfg_entry {
> +	__le32 reg_val[32];
> +	struct {
> +		u8 crypto_key[CQHCI_CRYPTO_KEY_MAX_SIZE];
> +		/* 4KB/512 = 8 */
> +		u8 data_unit_size;
> +		u8 crypto_cap_idx;
> +		u8 reserved_1;
> +		u8 config_enable;
> +		u8 reserved_multi_host;
> +		u8 reserved_2;
> +		u8 vsb[2];
> +		u8 reserved_3[56];
> +	};
> +};
> +
>  struct cqhci_host_ops;
>  struct mmc_host;
>  struct mmc_request;
> @@ -196,6 +269,12 @@ struct cqhci_host {
>  	struct completion halt_comp;
>  	wait_queue_head_t wait_queue;
>  	struct cqhci_slot *slot;
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +	union cqhci_crypto_capabilities crypto_capabilities;
> +	union cqhci_crypto_cap_entry *crypto_cap_array;
> +	u32 crypto_cfg_register;
> +#endif
>  };
>  
>  struct cqhci_host_ops {
> 

