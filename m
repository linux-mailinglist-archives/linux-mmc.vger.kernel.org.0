Return-Path: <linux-mmc+bounces-281-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA07FD824
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 14:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D3228278F
	for <lists+linux-mmc@lfdr.de>; Wed, 29 Nov 2023 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741820328;
	Wed, 29 Nov 2023 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oondal7M"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73659D
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 05:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701264700; x=1732800700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uZcv9aIvQUZwiTSb0GSz4lUFf5Umxqq3HewMBlMj5vg=;
  b=Oondal7Ms2GEvurx3jyXIR4YIFYXOy7voIBjGT1Bl5cUFFl1B+2NybDJ
   1lI9e6qIMG7PboOTYcy6k6fvopPqx3o6EYrEvNVGyj8uxnWfZB/HSfGwp
   oYDOmusMb32YmT8YqEPlJSypjoA1/JpcN3M6YBNg6E07H8oVyxNRHHYbd
   g9fga/vfyKkWozzfTbekaaBFlZ7NNr/hHK2AdIf8yDKqOGW3JQTmIumQ4
   cmYCZqK/uLYKWPBH10RbgqCht6oFcS+KrjM7uoAZHCO58Bko4n1PCqY8c
   yidCETnU/fmAhjsyPyd1M8Z3Cs6yvUVMu9QRWk1oBSQqo9F/Sd090JFME
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="397059025"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="397059025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803303566"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="803303566"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.43.226])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 05:31:38 -0800
Message-ID: <071d9e4f-b936-4816-a652-bd0195799494@intel.com>
Date: Wed, 29 Nov 2023 15:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Daniil Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231129092535.3278-1-avri.altman@wdc.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231129092535.3278-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/23 11:25, Avri Altman wrote:
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode. So for the close-ended case, it
> will be: cmd6->cmd23-cmd25-cmd6.
> 
> Some host controllers however, get confused when multi-block rw is sent
> without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
> I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
> on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.
> 
> Instead of a quirk, or hooking the request function of the msm ops,
> it would be better to fix the ioctl handling and make it use mrq.sbc
> instead of issuing SET_BLOCK_COUNT separately.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changelog:
> v3--v4:
> 	check sbc.error as well
> v2--v3:
> 	Adopt Adrian's proposal
> v1--v2:
> 	remove redundant reference of reliable write
> ---
>  drivers/mmc/core/block.c | 46 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f9a5cffa64b1..892e74e611a0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
>  	struct mmc_ioc_cmd ic;
>  	unsigned char *buf;
>  	u64 buf_bytes;
> +	unsigned int flags;
> +#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
> +#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
> +
>  	struct mmc_rpmb_data *rpmb;
>  };
>  
> @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
>  }
>  
>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
> -			       struct mmc_blk_ioc_data *idata)
> +			       struct mmc_blk_ioc_data **idatas, int i)
>  {
>  	struct mmc_command cmd = {}, sbc = {};
>  	struct mmc_data data = {};
> @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  	unsigned int busy_timeout_ms;
>  	int err;
>  	unsigned int target_part;
> +	struct mmc_blk_ioc_data *idata = idatas[i];
> +	struct mmc_blk_ioc_data *prev_idata = NULL;
>  
>  	if (!card || !md || !idata)
>  		return -EINVAL;
>  
> +	if (idata->flags & MMC_BLK_IOC_DROP)
> +		return 0;
> +
> +	if (idata->flags & MMC_BLK_IOC_SBC)
> +		prev_idata = idatas[i - 1];
> +
>  	/*
>  	 * The RPMB accesses comes in from the character device, so we
>  	 * need to target these explicitly. Else we just target the
> @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  			return err;
>  	}
>  
> -	if (idata->rpmb) {
> +	if (idata->rpmb || prev_idata) {
>  		sbc.opcode = MMC_SET_BLOCK_COUNT;
>  		/*
>  		 * We don't do any blockcount validation because the max size
> @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		 * 'Reliable Write' bit here.
>  		 */
>  		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
> +		if (prev_idata)
> +			sbc.arg = prev_idata->ic.arg;
>  		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  		mrq.sbc = &sbc;
>  	}
> @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  	mmc_wait_for_req(card->host, &mrq);
>  	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
>  
> +	if (prev_idata) {
> +		memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
> +		if (sbc.error) {
> +			dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
> +							__func__, sbc.error);
> +			return sbc.error;
> +		}
> +	}
> +
>  	if (cmd.error) {
>  		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
>  						__func__, cmd.error);
> @@ -1032,6 +1055,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>  	md->reset_done &= ~type;
>  }
>  
> +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
> +{
> +	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
> +	int i;
> +
> +	for (i = 1; i < mq_rq->ioc_count; i++) {
> +		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
> +		    mmc_op_multi(idata[i]->ic.opcode)) {
> +			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
> +			idata[i]->flags |= MMC_BLK_IOC_SBC;
> +		}
> +	}
> +}
> +
>  /*
>   * The non-block commands come back from the block layer after it queued it and
>   * processed it with all other requests and then they get issued in this
> @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>  			if (ret)
>  				break;
>  		}
> +
> +		mmc_blk_check_sbc(mq_rq);
> +
>  		fallthrough;
>  	case MMC_DRV_OP_IOCTL_RPMB:
>  		idata = mq_rq->drv_op_data;
>  		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
> -			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> +			ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
>  			if (ret)
>  				break;
>  		}


