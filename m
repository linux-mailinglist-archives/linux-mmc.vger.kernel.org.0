Return-Path: <linux-mmc+bounces-2084-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4318C58B7
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4DB1C2197F
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CA17EBA1;
	Tue, 14 May 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="SfQ/CRwb"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A317EB87;
	Tue, 14 May 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700555; cv=none; b=gKN9326U+/KRbrV5coIln+hy2mMi/n0hRdlmFHXPJbt8lFE0WRN3ya1DEhOuIgKhm526iwe/zegX4cf0N9lNQUISrrLzUFA+aaWngkVnddu59Vk+Cj9STWjwt4+HYI0P9x3XF73SwnjhVsUxRRwssqE/MqbODAipJ2JqDnzg+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700555; c=relaxed/simple;
	bh=AddzcenlLdr6i0tot32CsUBTmGtg4ExhvC1tGgHis6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8RiSzfxEaQudq1nxO5w4MtMoqKJqTdC13+Plgai4CuZwfnBnWOpwArhTZAFP2ga30Zgk9bqZtOtMkJpkbves527NmCv+/s99z9MHO+KJMIcX7gmaoB6UYj12QmPLBrpjPE1UjMDtSKzw+WoQRmTgq9xqNWDypfAhJX3+XTZVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=SfQ/CRwb reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1715700552; bh=AddzcenlLdr6i0tot32CsUBTmGtg4ExhvC1tGgHis6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfQ/CRwbVYxAdfzB/66DTIxHe230MqzbKx41KUI2RIgBLQDjeTeAqP55A5AWoEhOE
	 G2/jyLeP4fASPCGDqSdboCGc+gDpnDxUEvNsZHWaPHESru77M9dLdtjqhhBlIY+jaK
	 ZUtGpQtkoAMnsLSDIr/GoRt3SMOVCkRGNspRDCTKEZJsSnAfZQjDFuH/rgaMO2F+30
	 jw1DY1Ng99dbb+yBEQjO7kcH8EDu4oPOOPFpCcMz2tvtqC/0rgHD1t/RiLiay2JSsU
	 4WKBokGFVM6jg0GCo3S7C+86HYA7So0oP2lnyd9W3lglnfpgAvGRvXQk9qv3mUC+2w
	 UNjCfGvud5PRQ==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 9F5DC4D4650;
	Tue, 14 May 2024 17:29:11 +0200 (CEST)
Date: Tue, 14 May 2024 15:29:10 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 3/3] optee: probe RPMB device using RPMB subsystem
Message-ID: <ZkODRk7Us-9MlyYb@mecka.net>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-4-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507091619.2208810-4-jens.wiklander@linaro.org>

On Tue, May 07, 2024 at 11:16:19AM +0200, Jens Wiklander wrote:
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPMB subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
> 
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Tested-by: Manuel Traut <manut@mecka.net>

> ---
>  drivers/tee/optee/core.c          |  30 ++++++
>  drivers/tee/optee/device.c        |   7 ++
>  drivers/tee/optee/ffa_abi.c       |   8 ++
>  drivers/tee/optee/optee_private.h |  21 +++-
>  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++++
>  drivers/tee/optee/rpc.c           | 166 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   7 ++
>  7 files changed, 273 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 3aed554bc8d8..082691c10a90 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/rpmb.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/tee_drv.h>
> @@ -80,6 +81,31 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  	shm->pages = NULL;
>  }
>  
> +void optee_bus_scan_rpmb(struct work_struct *work)
> +{
> +	struct optee *optee = container_of(work, struct optee,
> +					   rpmb_scan_bus_work);
> +	int ret;
> +
> +	if (!optee->rpmb_scan_bus_done) {
> +		ret = optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB);
> +		optee->rpmb_scan_bus_done = !ret;
> +		if (ret && ret != -ENODEV)
> +			pr_info("Scanning for RPMB device: ret %d\n", ret);
> +	}
> +}
> +
> +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
> +			 void *data)
> +{
> +	struct optee *optee = container_of(intf, struct optee, rpmb_intf);
> +
> +	if (action == RPMB_NOTIFY_ADD_DEVICE)
> +		schedule_work(&optee->rpmb_scan_bus_work);
> +
> +	return 0;
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>  	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> @@ -161,6 +187,8 @@ void optee_release_supp(struct tee_context *ctx)
>  
>  void optee_remove_common(struct optee *optee)
>  {
> +	rpmb_interface_unregister(&optee->rpmb_intf);
> +	cancel_work_sync(&optee->rpmb_scan_bus_work);
>  	/* Unregister OP-TEE specific client devices on TEE bus */
>  	optee_unregister_devices();
>  
> @@ -177,6 +205,8 @@ void optee_remove_common(struct optee *optee)
>  	tee_shm_pool_free(optee->pool);
>  	optee_supp_uninit(&optee->supp);
>  	mutex_destroy(&optee->call_queue.mutex);
> +	rpmb_dev_put(optee->rpmb_dev);
> +	mutex_destroy(&optee->rpmb_dev_mutex);
>  }
>  
>  static int smc_abi_rc;
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 4b1092127694..4274876857c8 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -43,6 +43,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
>  	ret = tee_client_invoke_func(ctx, &inv_arg, param);
>  	if ((ret < 0) || ((inv_arg.ret != TEEC_SUCCESS) &&
>  			  (inv_arg.ret != TEEC_ERROR_SHORT_BUFFER))) {
> +		/*
> +		 * TEE_ERROR_STORAGE_NOT_AVAILABLE is returned when getting
> +		 * the list of device TAs that depends on RPMB but a usable
> +		 * RPMB device isn't found.
> +		 */
> +		if (inv_arg.ret == TEE_ERROR_STORAGE_NOT_AVAILABLE)
> +			return -ENODEV;
>  		pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n",
>  		       inv_arg.ret);
>  		return -EINVAL;
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index ecb5eb079408..a8dfdb30b4e8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/arm_ffa.h>
>  #include <linux/errno.h>
> +#include <linux/rpmb.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	optee_cq_init(&optee->call_queue, 0);
>  	optee_supp_init(&optee->supp);
>  	optee_shm_arg_cache_init(optee, arg_cache_flags);
> +	mutex_init(&optee->rpmb_dev_mutex);
>  	ffa_dev_set_drvdata(ffa_dev, optee);
>  	ctx = teedev_open(optee->teedev);
>  	if (IS_ERR(ctx)) {
> @@ -955,6 +957,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	if (rc)
>  		goto err_unregister_devices;
>  
> +	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> +	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
> +	rpmb_interface_register(&optee->rpmb_intf);
>  	pr_info("initialized driver\n");
>  	return 0;
>  
> @@ -968,6 +973,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	teedev_close_context(ctx);
>  err_rhashtable_free:
>  	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
> +	rpmb_dev_put(optee->rpmb_dev);
> +	mutex_destroy(&optee->rpmb_dev_mutex);
> +	rpmb_interface_unregister(&optee->rpmb_intf);
>  	optee_supp_uninit(&optee->supp);
>  	mutex_destroy(&optee->call_queue.mutex);
>  	mutex_destroy(&optee->ffa.mutex);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 7a5243c78b55..ae72f3dda1d2 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/arm-smccc.h>
>  #include <linux/rhashtable.h>
> +#include <linux/rpmb.h>
>  #include <linux/semaphore.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> @@ -20,11 +21,13 @@
>  /* Some Global Platform error codes used in this driver */
>  #define TEEC_SUCCESS			0x00000000
>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
> +#define TEEC_ERROR_ITEM_NOT_FOUND	0xFFFF0008
>  #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
>  #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
>  #define TEEC_ERROR_BUSY			0xFFFF000D
>  #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
> +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
>  
>  #define TEEC_ORIGIN_COMMS		0x00000002
>  
> @@ -197,6 +200,12 @@ struct optee_ops {
>   * @notif:		notification synchronization struct
>   * @supp:		supplicant synchronization struct for RPC to supplicant
>   * @pool:		shared memory pool
> + * @mutex:		mutex protecting @rpmb_dev
> + * @rpmb_dev:		current RPMB device or NULL
> + * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
> + *			was already done
> + * @rpmb_scan_bus_work	workq to for an RPMB device and to scan optee bus
> + *			and register RPMB dependent optee drivers
>   * @rpc_param_count:	If > 0 number of RPC parameters to make room for
>   * @scan_bus_done	flag if device registation was already done.
>   * @scan_bus_work	workq to scan optee bus and register optee drivers
> @@ -215,9 +224,15 @@ struct optee {
>  	struct optee_notif notif;
>  	struct optee_supp supp;
>  	struct tee_shm_pool *pool;
> +	/* Protects rpmb_dev pointer */
> +	struct mutex rpmb_dev_mutex;
> +	struct rpmb_dev *rpmb_dev;
> +	struct notifier_block rpmb_intf;
>  	unsigned int rpc_param_count;
> -	bool   scan_bus_done;
> +	bool scan_bus_done;
> +	bool rpmb_scan_bus_done;
>  	struct work_struct scan_bus_work;
> +	struct work_struct rpmb_scan_bus_work;
>  };
>  
>  struct optee_session {
> @@ -280,8 +295,12 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  
>  #define PTA_CMD_GET_DEVICES		0x0
>  #define PTA_CMD_GET_DEVICES_SUPP	0x1
> +#define PTA_CMD_GET_DEVICES_RPMB	0x2
>  int optee_enumerate_devices(u32 func);
>  void optee_unregister_devices(void);
> +void optee_bus_scan_rpmb(struct work_struct *work);
> +int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
> +			 void *data);
>  
>  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			       size_t size, size_t align,
> diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
> index f3f06e0994a7..4a3c02914f9c 100644
> --- a/drivers/tee/optee/optee_rpc_cmd.h
> +++ b/drivers/tee/optee/optee_rpc_cmd.h
> @@ -103,4 +103,39 @@
>  /* I2C master control flags */
>  #define OPTEE_RPC_I2C_FLAGS_TEN_BIT	BIT(0)
>  
> +/*
> + * Reset RPMB probing
> + *
> + * Releases an eventually already used RPMB devices and starts over searching
> + * for RPMB devices. Returns the kind of shared memory to use in subsequent
> + * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
> + *
> + * [out]    value[0].a	    OPTEE_RPC_SHM_TYPE_*, the parameter for
> + *			    OPTEE_RPC_CMD_SHM_ALLOC
> + */
> +#define OPTEE_RPC_CMD_RPMB_PROBE_RESET	22
> +
> +/*
> + * Probe next RPMB device
> + *
> + * [out]    value[0].a	    Type of RPMB device, OPTEE_RPC_RPMB_*
> + * [out]    value[0].b	    EXT CSD-slice 168 "RPMB Size"
> + * [out]    value[0].c	    EXT CSD-slice 222 "Reliable Write Sector Count"
> + * [out]    memref[1]       Buffer with the raw CID
> + */
> +#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT	23
> +
> +/* Type of RPMB device */
> +#define OPTEE_RPC_RPMB_EMMC		0
> +#define OPTEE_RPC_RPMB_UFS		1
> +#define OPTEE_RPC_RPMB_NVME		2
> +
> +/*
> + * Replay Protected Memory Block access
> + *
> + * [in]     memref[0]	    Frames to device
> + * [out]    memref[1]	    Frames from device
> + */
> +#define OPTEE_RPC_CMD_RPMB_FRAMES	24
> +
>  #endif /*__OPTEE_RPC_CMD_H*/
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..f3acb4240fcb 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/rpmb.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
> @@ -255,6 +256,162 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
>  	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
>  }
>  
> +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
> +					     struct optee *optee,
> +					     struct optee_msg_arg *arg)
> +{
> +	struct tee_param params[1];
> +
> +	if (!IS_ENABLED(CONFIG_RPMB)) {
> +		handle_rpc_supp_cmd(ctx, optee, arg);
> +		return;
> +	}
> +
> +	if (arg->num_params != ARRAY_SIZE(params) ||
> +	    optee->ops->from_msg_param(optee, params, arg->num_params,
> +				       arg->params) ||
> +	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	params[0].u.value.a = OPTEE_RPC_SHM_TYPE_KERNEL;
> +	params[0].u.value.b = 0;
> +	params[0].u.value.c = 0;
> +	if (optee->ops->to_msg_param(optee, arg->params,
> +				     arg->num_params, params)) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	mutex_lock(&optee->rpmb_dev_mutex);
> +	rpmb_dev_put(optee->rpmb_dev);
> +	optee->rpmb_dev = NULL;
> +	mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +	arg->ret = TEEC_SUCCESS;
> +}
> +
> +static int rpmb_type_to_rpc_type(enum rpmb_type rtype)
> +{
> +	switch (rtype) {
> +	case RPMB_TYPE_EMMC:
> +		return OPTEE_RPC_RPMB_EMMC;
> +	case RPMB_TYPE_UFS:
> +		return OPTEE_RPC_RPMB_UFS;
> +	case RPMB_TYPE_NVME:
> +		return OPTEE_RPC_RPMB_NVME;
> +	default:
> +		return -1;
> +	}
> +}
> +
> +static int rpc_rpmb_match(struct rpmb_dev *rdev, const void *data)
> +{
> +	return rpmb_type_to_rpc_type(rdev->descr.type) >= 0;
> +}
> +
> +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
> +					    struct optee *optee,
> +					    struct optee_msg_arg *arg)
> +{
> +	struct rpmb_dev *rdev;
> +	struct tee_param params[2];
> +	void *buf;
> +
> +	if (!IS_REACHABLE(CONFIG_RPMB)) {
> +		handle_rpc_supp_cmd(ctx, optee, arg);
> +		return;
> +	}
> +
> +	if (arg->num_params != ARRAY_SIZE(params) ||
> +	    optee->ops->from_msg_param(optee, params, arg->num_params,
> +				       arg->params) ||
> +	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
> +	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +	buf = tee_shm_get_va(params[1].u.memref.shm,
> +			     params[1].u.memref.shm_offs);
> +	if (!buf) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	mutex_lock(&optee->rpmb_dev_mutex);
> +	rdev = rpmb_dev_find_device(NULL, optee->rpmb_dev, rpc_rpmb_match);
> +	rpmb_dev_put(optee->rpmb_dev);
> +	optee->rpmb_dev = rdev;
> +	mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +	if (!rdev) {
> +		arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;
> +		return;
> +	}
> +
> +	if (params[1].u.memref.size < rdev->descr.dev_id_len) {
> +		arg->ret = TEEC_ERROR_SHORT_BUFFER;
> +		return;
> +	}
> +	memcpy(buf, rdev->descr.dev_id, rdev->descr.dev_id_len);
> +	params[1].u.memref.size = rdev->descr.dev_id_len;
> +	params[0].u.value.a = rpmb_type_to_rpc_type(rdev->descr.type);
> +	params[0].u.value.b = rdev->descr.capacity;
> +	params[0].u.value.c = rdev->descr.reliable_wr_count;
> +	if (optee->ops->to_msg_param(optee, arg->params,
> +				     arg->num_params, params)) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	arg->ret = TEEC_SUCCESS;
> +}
> +
> +static void handle_rpc_func_rpmb_frames(struct tee_context *ctx,
> +					struct optee *optee,
> +					struct optee_msg_arg *arg)
> +{
> +	struct tee_param params[2];
> +	struct rpmb_dev *rdev;
> +	void *p0, *p1;
> +
> +	mutex_lock(&optee->rpmb_dev_mutex);
> +	rdev = rpmb_dev_get(optee->rpmb_dev);
> +	mutex_unlock(&optee->rpmb_dev_mutex);
> +	if (!rdev) {
> +		handle_rpc_supp_cmd(ctx, optee, arg);
> +		return;
> +	}
> +
> +	if (arg->num_params != ARRAY_SIZE(params) ||
> +	    optee->ops->from_msg_param(optee, params, arg->num_params,
> +				       arg->params) ||
> +	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT ||
> +	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		goto out;
> +	}
> +
> +	p0 = tee_shm_get_va(params[0].u.memref.shm,
> +			    params[0].u.memref.shm_offs);
> +	p1 = tee_shm_get_va(params[1].u.memref.shm,
> +			    params[1].u.memref.shm_offs);
> +	if (rpmb_route_frames(rdev, p0, params[0].u.memref.size, p1,
> +			      params[1].u.memref.size)) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		goto out;
> +	}
> +	if (optee->ops->to_msg_param(optee, arg->params,
> +				     arg->num_params, params)) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		goto out;
> +	}
> +	arg->ret = TEEC_SUCCESS;
> +out:
> +	rpmb_dev_put(rdev);
> +}
> +
>  void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
>  		   struct optee_msg_arg *arg)
>  {
> @@ -271,6 +428,15 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
>  	case OPTEE_RPC_CMD_I2C_TRANSFER:
>  		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
>  		break;
> +	case OPTEE_RPC_CMD_RPMB_PROBE_RESET:
> +		handle_rpc_func_rpmb_probe_reset(ctx, optee, arg);
> +		break;
> +	case OPTEE_RPC_CMD_RPMB_PROBE_NEXT:
> +		handle_rpc_func_rpmb_probe_next(ctx, optee, arg);
> +		break;
> +	case OPTEE_RPC_CMD_RPMB_FRAMES:
> +		handle_rpc_func_rpmb_frames(ctx, optee, arg);
> +		break;
>  	default:
>  		handle_rpc_supp_cmd(ctx, optee, arg);
>  	}
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a37f87087e5c..c23bcf35c8cb 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/rpmb.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -1715,6 +1716,7 @@ static int optee_probe(struct platform_device *pdev)
>  	optee->smc.memremaped_shm = memremaped_shm;
>  	optee->pool = pool;
>  	optee_shm_arg_cache_init(optee, arg_cache_flags);
> +	mutex_init(&optee->rpmb_dev_mutex);
>  
>  	platform_set_drvdata(pdev, optee);
>  	ctx = teedev_open(optee->teedev);
> @@ -1769,6 +1771,9 @@ static int optee_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_disable_shm_cache;
>  
> +	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> +	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
> +	rpmb_interface_register(&optee->rpmb_intf);
>  	pr_info("initialized driver\n");
>  	return 0;
>  
> @@ -1782,6 +1787,8 @@ static int optee_probe(struct platform_device *pdev)
>  err_close_ctx:
>  	teedev_close_context(ctx);
>  err_supp_uninit:
> +	rpmb_dev_put(optee->rpmb_dev);
> +	mutex_destroy(&optee->rpmb_dev_mutex);
>  	optee_shm_arg_cache_uninit(optee);
>  	optee_supp_uninit(&optee->supp);
>  	mutex_destroy(&optee->call_queue.mutex);
> -- 
> 2.34.1
> 

