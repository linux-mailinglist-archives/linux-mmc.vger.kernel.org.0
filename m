Return-Path: <linux-mmc+bounces-2083-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3AF8C58B4
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448B81C21A4F
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3717EB94;
	Tue, 14 May 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="IWCK29hX"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211217EB87;
	Tue, 14 May 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700540; cv=none; b=kXyF6kLTW/SQ4FLsNptbJFfHJy8vO3fP2NBpG1kxLfkFVjsGUmqb1a9zBB+NIoqVNzX+M23ajs5v8sxYn+VpiTtdYuUlqoB5TCclPK71Jb0sYa3vkC20gxjLcV31Sge7oV0crHPXUb5SkavF7gCwxmVbWDCgJ8C0B4DE5plRdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700540; c=relaxed/simple;
	bh=bZPt6R9dCuVBudMssCKVz3sPHwmqPX6RnPrNkXI9/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW+aq5JDwjpsa/yLHwwbfiogdrAo0yC2LF7wcuPCylSX+G54UPr/IYk4fMxSqmYAE0sodEz3grnNEqzrPA+qL0Gff9JawdzWN5mHUvl2JxA4wNVF8M+L0KvdKrUijndPD3NpgjhYq3dzmTnAUubtmEfv+vQ+xonkWdUQPBTXKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=IWCK29hX reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1715700537; bh=bZPt6R9dCuVBudMssCKVz3sPHwmqPX6RnPrNkXI9/PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWCK29hXnVBLGFBl5P2cOicePYJQuMLfOlRg1HEY+hqONdQPTviUwBkyJ2DD85x7m
	 B5Azul6mILd0PEHyvxAzb5sGd7ujUT0BU0GF3/dR/WZQuYQVQ0H382ymU17D1NcOaY
	 n3tXzGJC680M/P/F86tQ4uhAT0uVOlYAGLA69y/EYqvJtuhNJTaaoSHsbJbZMtSjwJ
	 tsnsELumeZDEN8jr7+EHnPq1cJOyGNujJEKkYBhfPDbkPMLkhYbM9HuhhEsXbSSyMr
	 rc4s60bWfC5P24lYRzBS/2XimmPtFhupruG7Z0PNSHb4rQS36PP/k9MSFUKFx9f8Lp
	 mx2fzq3GjPOQQ==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id C6CDD4D464B;
	Tue, 14 May 2024 17:28:56 +0200 (CEST)
Date: Tue, 14 May 2024 15:28:55 +0000
From: Manuel Traut <manut@mecka.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v6 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Message-ID: <ZkODN1MQ9viIn0TF@mecka.net>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-3-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507091619.2208810-3-jens.wiklander@linaro.org>

On Tue, May 07, 2024 at 11:16:18AM +0200, Jens Wiklander wrote:
> Register eMMC RPMB partition with the RPMB subsystem and provide
> an implementation for the RPMB access operations abstracting
> the actual multi step process.
> 
> Add a callback to extract the needed device information at registration
> to avoid accessing the struct mmc_card at a later stage as we're not
> holding a reference counter for this struct.
> 
> Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> instead of in mmc_rpmb_chrdev_open(). This is needed by the
> route_frames() function pointer in struct rpmb_ops.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Tested-by: Manuel Traut <manut@mecka.net>

> ---
>  drivers/mmc/core/block.c | 241 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 239 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..a7f126fbc605 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -33,6 +33,7 @@
>  #include <linux/cdev.h>
>  #include <linux/mutex.h>
>  #include <linux/scatterlist.h>
> +#include <linux/string.h>
>  #include <linux/string_helpers.h>
>  #include <linux/delay.h>
>  #include <linux/capability.h>
> @@ -40,6 +41,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/debugfs.h>
> +#include <linux/rpmb.h>
>  
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
>  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>  
> +/**
> + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> + *
> + * @stuff        : stuff bytes
> + * @key_mac      : The authentication key or the message authentication
> + *                 code (MAC) depending on the request/response type.
> + *                 The MAC will be delivered in the last (or the only)
> + *                 block of data.
> + * @data         : Data to be written or read by signed access.
> + * @nonce        : Random number generated by the host for the requests
> + *                 and copied to the response by the RPMB engine.
> + * @write_counter: Counter value for the total amount of the successful
> + *                 authenticated data write requests made by the host.
> + * @addr         : Address of the data to be programmed to or read
> + *                 from the RPMB. Address is the serial number of
> + *                 the accessed block (half sector 256B).
> + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> + *                 read/programmed.
> + * @result       : Includes information about the status of the write counter
> + *                 (valid, expired) and result of the access made to the RPMB.
> + * @req_resp     : Defines the type of request and response to/from the memory.
> + *
> + * The stuff bytes and big-endian properties are modeled to fit to the spec.
> + */
> +struct rpmb_frame {
> +	u8     stuff[196];
> +	u8     key_mac[32];
> +	u8     data[256];
> +	u8     nonce[16];
> +	__be32 write_counter;
> +	__be16 addr;
> +	__be16 block_count;
> +	__be16 result;
> +	__be16 req_resp;
> +} __packed;
> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> +
>  static DEFINE_MUTEX(block_mutex);
>  
>  /*
> @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
>  	int id;
>  	unsigned int part_index;
>  	struct mmc_blk_data *md;
> +	struct rpmb_dev *rdev;
>  	struct list_head node;
>  };
>  
> @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
>  
>  	get_device(&rpmb->dev);
>  	filp->private_data = rpmb;
> -	mmc_blk_get(rpmb->md->disk);
>  
>  	return nonseekable_open(inode, filp);
>  }
> @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
>  	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
>  						  struct mmc_rpmb_data, chrdev);
>  
> -	mmc_blk_put(rpmb->md);
>  	put_device(&rpmb->dev);
>  
>  	return 0;
> @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>  {
>  	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>  
> +	rpmb_dev_unregister(rpmb->rdev);
> +	mmc_blk_put(rpmb->md);
>  	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
>  	kfree(rpmb);
>  }
>  
> +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
> +{
> +	unsigned int n;
> +
> +	for (n = 0; n < cmd_count; n++)
> +		kfree(idata[n]);
> +	kfree(idata);
> +}
> +
> +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
> +					     unsigned int cmd_count)
> +{
> +	struct mmc_blk_ioc_data **idata;
> +	unsigned int n;
> +
> +	idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> +	if (!idata)
> +		return NULL;
> +
> +	for (n = 0; n < cmd_count; n++) {
> +		idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
> +		if (!idata[n]) {
> +			free_idata(idata, n);
> +			return NULL;
> +		}
> +		idata[n]->rpmb = rpmb;
> +	}
> +
> +	return idata;
> +}
> +
> +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> +		      int write_flag, u8 *buf, unsigned int buf_bytes)
> +{
> +	/*
> +	 * The size of an RPMB frame must match what's expected by the
> +	 * hardware.
> +	 */
> +	BUILD_BUG_ON(sizeof(struct rpmb_frame) != 512);
> +
> +	idata->ic.opcode = opcode;
> +	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +	idata->ic.write_flag = write_flag;
> +	idata->ic.blksz = sizeof(struct rpmb_frame);
> +	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
> +	idata->buf = buf;
> +	idata->buf_bytes = buf_bytes;
> +}
> +
> +static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
> +				 unsigned int req_len, u8 *resp,
> +				 unsigned int resp_len)
> +{
> +	struct rpmb_frame *frm = (struct rpmb_frame *)req;
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +	struct mmc_blk_data *md = rpmb->md;
> +	struct mmc_blk_ioc_data **idata;
> +	struct mmc_queue_req *mq_rq;
> +	unsigned int cmd_count;
> +	struct request *rq;
> +	u16 req_type;
> +	bool write;
> +	int ret;
> +
> +	if (IS_ERR(md->queue.card))
> +		return PTR_ERR(md->queue.card);
> +
> +	if (req_len < sizeof(*frm))
> +		return -EINVAL;
> +
> +	req_type = be16_to_cpu(frm->req_resp);
> +	switch (req_type) {
> +	case RPMB_PROGRAM_KEY:
> +		if (req_len != sizeof(struct rpmb_frame) ||
> +		    resp_len != sizeof(struct rpmb_frame))
> +			return -EINVAL;
> +		write = true;
> +		break;
> +	case RPMB_GET_WRITE_COUNTER:
> +		if (req_len != sizeof(struct rpmb_frame) ||
> +		    resp_len != sizeof(struct rpmb_frame))
> +			return -EINVAL;
> +		write = false;
> +		break;
> +	case RPMB_WRITE_DATA:
> +		if (req_len % sizeof(struct rpmb_frame) ||
> +		    resp_len != sizeof(struct rpmb_frame))
> +			return -EINVAL;
> +		write = true;
> +		break;
> +	case RPMB_READ_DATA:
> +		if (req_len != sizeof(struct rpmb_frame) ||
> +		    resp_len % sizeof(struct rpmb_frame))
> +			return -EINVAL;
> +		write = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (write)
> +		cmd_count = 3;
> +	else
> +		cmd_count = 2;
> +
> +	idata = alloc_idata(rpmb, cmd_count);
> +	if (!idata)
> +		return -ENOMEM;
> +
> +	if (write) {
> +		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
> +
> +		/* Send write request frame(s) */
> +		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> +			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> +
> +		/* Send result request frame */
> +		memset(frm, 0, sizeof(*frm));
> +		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
> +		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> +			  resp_len);
> +
> +		/* Read response frame */
> +		set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
> +	} else {
> +		/* Send write request frame(s) */
> +		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req_len);
> +
> +		/* Read response frame */
> +		set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
> +	}
> +
> +	rq = blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
> +	if (IS_ERR(rq)) {
> +		ret = PTR_ERR(rq);
> +		goto out;
> +	}
> +
> +	mq_rq = req_to_mmc_queue_req(rq);
> +	mq_rq->drv_op = MMC_DRV_OP_IOCTL_RPMB;
> +	mq_rq->drv_op_result = -EIO;
> +	mq_rq->drv_op_data = idata;
> +	mq_rq->ioc_count = cmd_count;
> +	blk_execute_rq(rq, false);
> +	ret = req_to_mmc_queue_req(rq)->drv_op_result;
> +
> +	blk_mq_free_request(rq);
> +
> +out:
> +	free_idata(idata, cmd_count);
> +	return ret;
> +}
> +
>  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  				   struct mmc_blk_data *md,
>  				   unsigned int part_index,
> @@ -2741,6 +2939,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  	rpmb->dev.release = mmc_blk_rpmb_device_release;
>  	device_initialize(&rpmb->dev);
>  	dev_set_drvdata(&rpmb->dev, rpmb);
> +	mmc_blk_get(md->disk);
>  	rpmb->md = md;
>  
>  	cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops);
> @@ -3002,6 +3201,42 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>  
>  #endif /* CONFIG_DEBUG_FS */
>  
> +static void mmc_blk_rpmb_add(struct mmc_card *card)
> +{
> +	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
> +	struct mmc_rpmb_data *rpmb;
> +	struct rpmb_dev *rdev;
> +	unsigned int n;
> +	u32 cid[4];
> +	struct rpmb_descr descr = {
> +		.type = RPMB_TYPE_EMMC,
> +		.route_frames = mmc_route_rpmb_frames,
> +		.reliable_wr_count = card->ext_csd.enhanced_rpmb_supported ?
> +				     2 : 32,
> +		.capacity = card->ext_csd.raw_rpmb_size_mult,
> +		.dev_id = (void *)cid,
> +		.dev_id_len = sizeof(cid),
> +	};
> +
> +	/*
> +	 * Provice CID as an octet array. The CID needs to be interpreted
> +	 * when used as input to derive the RPMB key since some fields
> +	 * will change due to firmware updates.
> +	 */
> +	for (n = 0; n < 4; n++)
> +		cid[n] = be32_to_cpu(card->raw_cid[n]);
> +
> +	list_for_each_entry(rpmb, &md->rpmbs, node) {
> +		rdev = rpmb_dev_register(&rpmb->dev, &descr);
> +		if (IS_ERR(rdev)) {
> +			pr_warn("%s: could not register RPMB device\n",
> +				dev_name(&rpmb->dev));
> +			continue;
> +		}
> +		rpmb->rdev = rdev;
> +	}
> +}
> +
>  static int mmc_blk_probe(struct mmc_card *card)
>  {
>  	struct mmc_blk_data *md;
> @@ -3047,6 +3282,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>  		pm_runtime_enable(&card->dev);
>  	}
>  
> +	mmc_blk_rpmb_add(card);
> +
>  	return 0;
>  
>  out:
> -- 
> 2.34.1
> 

