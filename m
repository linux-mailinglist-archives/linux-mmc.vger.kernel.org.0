Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4162BB12FB
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Sep 2019 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfILQpi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Sep 2019 12:45:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41136 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbfILQpi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2019 12:45:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so13774007pgg.8
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2019 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzHuMtsgq4ib7mYhTsVdQliYa76hPj5SgO5JUAD+5/s=;
        b=hGUcb8uwCLbEbP48LCiAS7gD4P24Dm44r3cJx5ciD1tWm9xohmOL4EPiML1N2yucZL
         PQ+4qs833Inh2Ygw8ANXEMOltzYQ8if28r9yqn4vp5ZbmP+KUPKhC8F//sllK5CZCBO0
         5PmtdjUnORTiIyJePICk9U0c5kNoa923EgjG2GnsOqlYb4xyx3cPqEWFPiTTgYExrtf9
         U4sTRTOqOifLsZYbyxQucSz05Xah43l2nneeVLbkKWjYwWc0Whohk+mi5uNLXXcpj4ph
         L5+47nkWRHnsD61Ig9YHIKL2QOubV+1DbIdDUYAqzWbmQ35C8+MKEhskoQgcZppaLVYT
         fDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzHuMtsgq4ib7mYhTsVdQliYa76hPj5SgO5JUAD+5/s=;
        b=SD0g/d4ii/xvE2V/VEOaoNOCNtUt6bG03xQhqfeDR11/ax3URhFDUiPKSpplR0tTGs
         8iKXdtmR55NtJBh627mdDf1/enpbW9l+BZxyQLp0EAiqbE4lKw/+vkcLogZGfY5uwtFr
         xOp/kNb/HfE0Qw8r/yTOEBl7dRG7kYFgtsT3yrVo/4OTOCIJYBB0dNErvavVvUMAhIlg
         51/R04WtMCeJA8XriEgFTamR+jyk12h2q0EIuKLAXR1X4fLOgM3/UG8g20IN5aEktuB6
         EeQnpurwgxPPLqqvlYEd6xYsSFLZwGxcBNlbYr3nhvPZkLSNCOpJFOySiWr9sTxcOzgI
         /EnQ==
X-Gm-Message-State: APjAAAWFarQdQ3kXuP1/aret8RBD1USQwqIUOWGUIz4e78D3WpAPd0CI
        gBI48Vni5KRHt3fv1V7XMEafjg==
X-Google-Smtp-Source: APXvYqx5hgm+utW7g0bBJWhJtmGVmjnhDR8zfEd41Du2vT+L/SckjwdzUALWJ5GR0WtjWvAas2+olQ==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr1159144pje.57.1568306736101;
        Thu, 12 Sep 2019 09:45:36 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p11sm27753496pff.136.2019.09.12.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 09:45:35 -0700 (PDT)
Date:   Thu, 12 Sep 2019 09:45:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        vbadigan@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [RFC 1/2] mmc: sdhci-msm: Add support for bus bandwidth voting
Message-ID: <20190912164532.GA8466@tuxbook-pro>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 06 Sep 05:47 PDT 2019, Pradeep P V K wrote:

> Vote for the MSM bus bandwidth required by SDHC driver
> based on the clock frequency and bus width of the card.
> Otherwise,the system clocks may run at minimum clock speed
> and thus affecting the performance.
> 
> This change is based on Georgi Djakov [RFC]
> (https://lkml.org/lkml/2018/10/11/499)
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>

This says that Sahitya wrote the patch, then Subhash handled it, then
Veerabhadrarao handled it and finally you handled it; but you're at the
same time listed as author (by From:).

Please see section 12 on Co-Developed-by in submitting-patches.rst

> ---
>  drivers/mmc/host/sdhci-msm.c | 393 ++++++++++++++++++++++++++++++++++++++++++-

This patch implements support for requesting bandwidth to the register
space and for the controllers access to DDR. To me this seems like
common requirements for any mmc controller, can this functionality be
provided by the mmc/sdhci common code?

Regards,
Bjorn

>  1 file changed, 390 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b75c82d..71515ca 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -11,6 +11,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/interconnect.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -122,6 +123,9 @@
>  #define msm_host_writel(msm_host, val, host, offset) \
>  	msm_host->var_ops->msm_writel_relaxed(val, host, offset)
>  
> +#define SDHC_DDR "sdhc-ddr"
> +#define CPU_SDHC "cpu-sdhc"
> +
>  struct sdhci_msm_offset {
>  	u32 core_hc_mode;
>  	u32 core_mci_data_cnt;
> @@ -228,6 +232,31 @@ struct sdhci_msm_variant_info {
>  	const struct sdhci_msm_offset *offset;
>  };
>  
> +struct msm_bus_vectors {
> +	uint64_t ab;
> +	uint64_t ib;
> +};
> +
> +struct msm_bus_path {
> +	unsigned int num_paths;
> +	struct msm_bus_vectors *vec;
> +};
> +
> +struct sdhci_msm_bus_vote_data {
> +	const char *name;
> +	unsigned int num_usecase;
> +	struct msm_bus_path *usecase;
> +
> +	unsigned int *bw_vecs;
> +	unsigned int bw_vecs_size;
> +
> +	struct icc_path *sdhc_ddr;
> +	struct icc_path *cpu_sdhc;
> +
> +	uint32_t curr_vote;
> +
> +};
> +
>  struct sdhci_msm_host {
>  	struct platform_device *pdev;
>  	void __iomem *core_mem;	/* MSM SDCC mapped address */
> @@ -253,8 +282,13 @@ struct sdhci_msm_host {
>  	const struct sdhci_msm_offset *offset;
>  	bool use_cdr;
>  	u32 transfer_mode;
> +	bool skip_bus_bw_voting;
> +	struct sdhci_msm_bus_vote_data *bus_vote_data;
> +	struct delayed_work bus_vote_work;
>  };
>  
> +static void sdhci_msm_bus_voting(struct sdhci_host *host, u32 enable);
> +
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1557,6 +1591,8 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	msm_set_clock_rate_for_bus_mode(host, clock);
>  out:
> +	if (!msm_host->skip_bus_bw_voting)
> +		sdhci_msm_bus_voting(host, !!clock);
>  	__sdhci_msm_set_clock(host, clock);
>  }
>  
> @@ -1678,6 +1714,341 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>  
> +static int sdhci_msm_dt_get_array(struct device *dev, const char *prop_name,
> +				 u32 **bw_vecs, int *len, u32 size)
> +{
> +	int ret = 0;
> +	struct device_node *np = dev->of_node;
> +	size_t sz;
> +	u32 *arr = NULL;
> +
> +	if (!of_get_property(np, prop_name, len)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	sz = *len = *len / sizeof(*arr);
> +	if (sz <= 0 || (size > 0 && (sz > size))) {
> +		dev_err(dev, "%s invalid size\n", prop_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	arr = devm_kzalloc(dev, sz * sizeof(*arr), GFP_KERNEL);
> +	if (!arr) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = of_property_read_u32_array(np, prop_name, arr, sz);
> +	if (ret < 0) {
> +		dev_err(dev, "%s failed reading array %d\n", prop_name, ret);
> +		goto out;
> +	}
> +	*bw_vecs = arr;
> +out:
> +	if (ret)
> +		*len = 0;
> +	return ret;
> +}
> +
> +/* Returns required bandwidth in Bytes per Sec */
> +static unsigned long sdhci_get_bw_required(struct sdhci_host *host,
> +					struct mmc_ios *ios)
> +{
> +	unsigned long bw;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	bw = msm_host->clk_rate;
> +
> +	if (ios->bus_width == MMC_BUS_WIDTH_4)
> +		bw /= 2;
> +	else if (ios->bus_width == MMC_BUS_WIDTH_1)
> +		bw /= 8;
> +
> +	return bw;
> +}
> +
> +static int sdhci_msm_bus_get_vote_for_bw(struct sdhci_msm_host *host,
> +					   unsigned int bw)
> +{
> +	struct sdhci_msm_bus_vote_data *bvd = host->bus_vote_data;
> +
> +	unsigned int *table = bvd->bw_vecs;
> +	unsigned int size = bvd->bw_vecs_size;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (bw <= table[i])
> +			break;
> +	}
> +
> +	if (i && (i == size))
> +		i--;
> +
> +	return i;
> +}
> +
> +/*
> + * This function must be called with host lock acquired.
> + * Caller of this function should also ensure that msm bus client
> + * handle is not null.
> + */
> +static inline int sdhci_msm_bus_set_vote(struct sdhci_msm_host *msm_host,
> +					     int vote,
> +					     unsigned long *flags)
> +{
> +	struct sdhci_host *host =  platform_get_drvdata(msm_host->pdev);
> +	struct sdhci_msm_bus_vote_data *bvd = msm_host->bus_vote_data;
> +	struct msm_bus_path *usecase = bvd->usecase;
> +	struct msm_bus_vectors *vec = usecase[vote].vec;
> +	int ddr_rc = 0, cpu_rc = 0;
> +
> +	if (vote != bvd->curr_vote) {
> +		spin_unlock_irqrestore(&host->lock, *flags);
> +		pr_debug("%s: vote:%d sdhc_ddr ab:%llu ib:%llu cpu_sdhc ab:%llu ib:%llu\n",
> +				mmc_hostname(host->mmc), vote, vec[0].ab,
> +				vec[0].ib, vec[1].ab, vec[1].ib);
> +		ddr_rc = icc_set_bw(bvd->sdhc_ddr, vec[0].ab, vec[0].ib);
> +		cpu_rc = icc_set_bw(bvd->cpu_sdhc, vec[1].ab, vec[1].ib);
> +		spin_lock_irqsave(&host->lock, *flags);
> +		if (ddr_rc || cpu_rc) {
> +			pr_err("%s: icc_set() failed\n",
> +				mmc_hostname(host->mmc));
> +			goto out;
> +		}
> +		bvd->curr_vote = vote;
> +	}
> +out:
> +	return cpu_rc;
> +}
> +
> +/*
> + * Internal work. Work to set 0 bandwidth for msm bus.
> + */
> +static void sdhci_msm_bus_work(struct work_struct *work)
> +{
> +	struct sdhci_msm_host *msm_host;
> +	struct sdhci_host *host;
> +	unsigned long flags;
> +
> +	msm_host = container_of(work, struct sdhci_msm_host,
> +				bus_vote_work.work);
> +	host =  platform_get_drvdata(msm_host->pdev);
> +
> +	/* Check handle and return */
> +	if (!msm_host->bus_vote_data->sdhc_ddr ||
> +			!msm_host->bus_vote_data->cpu_sdhc)
> +		return;
> +	spin_lock_irqsave(&host->lock, flags);
> +	/* don't vote for 0 bandwidth if any request is in progress */
> +	if (!host->mmc->ongoing_mrq)
> +		sdhci_msm_bus_set_vote(msm_host, 0, &flags);
> +	else
> +		pr_warn("Transfer in progress.Skipping bus voting to 0\n");
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +/*
> + * This function cancels any scheduled delayed work and sets the bus
> + * vote based on bw (bandwidth) argument.
> + */
> +static void sdhci_msm_bus_cancel_work_and_set_vote(struct sdhci_host *host,
> +						unsigned int bw)
> +{
> +	int vote;
> +	unsigned long flags;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	cancel_delayed_work_sync(&msm_host->bus_vote_work);
> +	spin_lock_irqsave(&host->lock, flags);
> +	vote = sdhci_msm_bus_get_vote_for_bw(msm_host, bw);
> +	sdhci_msm_bus_set_vote(msm_host, vote, &flags);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +
> +#define MSM_MMC_BUS_VOTING_DELAY	200 /* msecs */
> +#define VOTE_ZERO  0
> +
> +/* This function queues a work which will set the bandwidth requiement to 0 */
> +static void sdhci_msm_bus_queue_work(struct sdhci_host *host)
> +{
> +	unsigned long flags;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	if (msm_host->bus_vote_data->curr_vote != VOTE_ZERO)
> +		queue_delayed_work(system_wq,
> +				   &msm_host->bus_vote_work,
> +				   msecs_to_jiffies(MSM_MMC_BUS_VOTING_DELAY));
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static struct sdhci_msm_bus_vote_data *sdhci_msm_get_bus_vote_data(struct device
> +				       *dev, struct sdhci_msm_host *host)
> +
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *of_node = dev->of_node;
> +	struct sdhci_msm_bus_vote_data *bvd = NULL;
> +	struct msm_bus_path *usecase = NULL;
> +	int ret = 0, i = 0, j, k, num_paths, len;
> +	const uint32_t *vec_arr = NULL;
> +	bool mem_err = false;
> +
> +	if (!pdev) {
> +		dev_err(dev, "Null platform device!\n");
> +		return NULL;
> +	}
> +
> +	bvd = devm_kzalloc(dev, sizeof(struct sdhci_msm_bus_vote_data),
> +				GFP_KERNEL);
> +	if (!bvd) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "No sufficient memory!\n");
> +		return bvd;
> +	}
> +	ret = sdhci_msm_dt_get_array(dev, "qcom,bus-bw-vectors-bps",
> +				&bvd->bw_vecs, &bvd->bw_vecs_size, 0);
> +	if (ret) {
> +		dev_info(dev, "No dt property of bus bw. voting defined!\n");
> +		dev_info(dev, "Skipping Bus BW voting now!!\n");
> +		host->skip_bus_bw_voting = true;
> +		if (ret != -EINVAL && ret != -ENOMEM)
> +			goto free;
> +		goto err;
> +	}
> +
> +	ret = of_property_read_string(of_node, "qcom,msm-bus,name", &bvd->name);
> +	if (ret) {
> +		dev_err(dev, "Error: (%d) Bus name missing!\n", ret);
> +		goto err;
> +	}
> +
> +	ret = of_property_read_u32(of_node, "qcom,msm-bus,num-cases",
> +		&bvd->num_usecase);
> +	if (ret) {
> +		dev_err(dev, "Error: num-usecases not found\n");
> +		goto err;
> +	}
> +
> +	usecase = devm_kzalloc(dev, (sizeof(struct msm_bus_path) *
> +				   bvd->num_usecase), GFP_KERNEL);
> +	if (!usecase)
> +		goto err;
> +
> +	ret = of_property_read_u32(of_node, "qcom,msm-bus,num-paths",
> +				   &num_paths);
> +	if (ret) {
> +		dev_err(dev, "Error: num_paths not found\n");
> +		goto out;
> +	}
> +
> +	vec_arr = of_get_property(of_node, "qcom,msm-bus,vectors-KBps", &len);
> +	if (vec_arr == NULL) {
> +		dev_err(dev, "Error: Vector array not found\n");
> +		goto out;
> +	}
> +
> +	for (i = 0; i < bvd->num_usecase; i++) {
> +		usecase[i].num_paths = num_paths;
> +		usecase[i].vec = devm_kzalloc(dev, num_paths *
> +					      sizeof(struct msm_bus_vectors),
> +					      GFP_KERNEL);
> +		if (!usecase[i].vec) {
> +			mem_err = true;
> +			dev_err(dev, "Error: Failed to alloc mem for vectors\n");
> +			goto out;
> +		}
> +		for (j = 0; j < num_paths; j++) {
> +			int idx = ((i * num_paths) + j) * 2;
> +
> +			usecase[i].vec[j].ab = (uint64_t)
> +				be32_to_cpu(vec_arr[idx]);
> +			usecase[i].vec[j].ib = (uint64_t)
> +				be32_to_cpu(vec_arr[idx + 1]);
> +		}
> +	}
> +
> +	bvd->usecase = usecase;
> +	return bvd;
> +out:
> +	if (mem_err) {
> +		for (k = i - 1; k >= 0; k--)
> +			devm_kfree(dev, usecase[k].vec);
> +	}
> +	devm_kfree(dev, usecase);
> +free:
> +	devm_kfree(dev, bvd->bw_vecs);
> +err:
> +	devm_kfree(dev, bvd);
> +	bvd = NULL;
> +	return bvd;
> +}
> +
> +static int sdhci_msm_bus_register(struct sdhci_msm_host *host,
> +				struct platform_device *pdev)
> +{
> +	struct sdhci_msm_bus_vote_data *bsd;
> +	struct device *dev = &pdev->dev;
> +
> +	bsd = sdhci_msm_get_bus_vote_data(dev, host);
> +	if (!bsd) {
> +		dev_err(&pdev->dev, "Failed: getting bus_scale data\n");
> +		return PTR_ERR(bsd);
> +	}
> +	host->bus_vote_data = bsd;
> +
> +	bsd->sdhc_ddr = of_icc_get(&pdev->dev, SDHC_DDR);
> +	if (IS_ERR(bsd->sdhc_ddr)) {
> +		dev_err(&pdev->dev, "Error: (%ld) failed getting %s path\n",
> +			PTR_ERR(bsd->sdhc_ddr), SDHC_DDR);
> +		return PTR_ERR(bsd->sdhc_ddr);
> +	}
> +
> +	bsd->cpu_sdhc = of_icc_get(&pdev->dev, CPU_SDHC);
> +	if (IS_ERR(bsd->cpu_sdhc)) {
> +		dev_err(&pdev->dev, "Error: (%ld) failed getting %s path\n",
> +			PTR_ERR(bsd->cpu_sdhc), CPU_SDHC);
> +		return PTR_ERR(bsd->cpu_sdhc);
> +	}
> +
> +	INIT_DELAYED_WORK(&host->bus_vote_work, sdhci_msm_bus_work);
> +
> +	return 0;
> +}
> +
> +static void sdhci_msm_bus_unregister(struct device *dev,
> +				struct sdhci_msm_host *host)
> +{
> +	struct sdhci_msm_bus_vote_data *bsd = host->bus_vote_data;
> +	int i;
> +
> +	icc_put(bsd->sdhc_ddr);
> +	icc_put(bsd->cpu_sdhc);
> +
> +	for (i = 0; i < bsd->num_usecase; i++)
> +		devm_kfree(dev, bsd->usecase[i].vec);
> +	devm_kfree(dev, bsd->usecase);
> +	devm_kfree(dev, bsd->bw_vecs);
> +	devm_kfree(dev, bsd);
> +}
> +
> +static void sdhci_msm_bus_voting(struct sdhci_host *host, u32 enable)
> +{
> +	struct mmc_ios *ios = &host->mmc->ios;
> +	unsigned int bw;
> +
> +	bw = sdhci_get_bw_required(host, ios);
> +	if (enable)
> +		sdhci_msm_bus_cancel_work_and_set_vote(host, bw);
> +	else
> +		sdhci_msm_bus_queue_work(host);
> +}
> +
>  static const struct sdhci_msm_variant_ops mci_var_ops = {
>  	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>  	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
> @@ -1839,6 +2210,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
>  	}
>  
> +	ret = sdhci_msm_bus_register(msm_host, pdev);
> +	if (ret && !msm_host->skip_bus_bw_voting)
> +		goto clk_disable;
> +
> +	if (!msm_host->skip_bus_bw_voting)
> +		sdhci_msm_bus_voting(host, 1);
> +
>  	if (!msm_host->mci_removed) {
>  		core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  		msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
> @@ -1846,7 +2224,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  		if (IS_ERR(msm_host->core_mem)) {
>  			ret = PTR_ERR(msm_host->core_mem);
> -			goto clk_disable;
> +			goto bus_unregister;
>  		}
>  	}
>  
> @@ -1918,7 +2296,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>  	if (msm_host->pwr_irq < 0) {
>  		ret = msm_host->pwr_irq;
> -		goto clk_disable;
> +		goto bus_unregister;
>  	}
>  
>  	sdhci_msm_init_pwr_irq_wait(msm_host);
> @@ -1931,7 +2309,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  					dev_name(&pdev->dev), host);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
> -		goto clk_disable;
> +		goto bus_unregister;
>  	}
>  
>  	pm_runtime_get_noresume(&pdev->dev);
> @@ -1956,6 +2334,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +bus_unregister:
> +	if (!msm_host->skip_bus_bw_voting) {
> +		sdhci_msm_bus_cancel_work_and_set_vote(host, 0);
> +		sdhci_msm_bus_unregister(&pdev->dev, msm_host);
> +	}
>  clk_disable:
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);
> @@ -1985,6 +2368,10 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  				   msm_host->bulk_clks);
>  	if (!IS_ERR(msm_host->bus_clk))
>  		clk_disable_unprepare(msm_host->bus_clk);
> +	if (!msm_host->skip_bus_bw_voting) {
> +		sdhci_msm_bus_cancel_work_and_set_vote(host, 0);
> +		sdhci_msm_bus_unregister(&pdev->dev, msm_host);
> +	}
>  	sdhci_pltfm_free(pdev);
>  	return 0;
>  }
> -- 
> 1.9.1
> 
