Return-Path: <linux-mmc+bounces-2086-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506E8C5901
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694141C21AE7
	for <lists+linux-mmc@lfdr.de>; Tue, 14 May 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B817EBA6;
	Tue, 14 May 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFZNjmjJ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945231292D2;
	Tue, 14 May 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701528; cv=none; b=XkXzfWLohUpWqsewUwuG2fxA1/hsEr6CFKrs87XUup3KlGQ/jBLTiCKsrT1KHZ1TbxfaEF+5eyFHpCMJg8ljihX45j0ozVqz7FHUoARxT73pl6LHy6XmsnHmXM2LjvHM3VWR/5i6HrcMSREqgOKHiNnwAmanKzgMeCJJJz9j+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701528; c=relaxed/simple;
	bh=5eSG0yVHOgX7q8DmWM35E997LvHTT/LsnKwRqAW38WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNNcN4KLnkVJLubd9wOqLu+OFuSgknzFjUWbRRZufbWlXiUDJfrfQDCho1KN89y8bMCT1COATFGVnzXT6KONfZP1D7pNn3+wLFarTfbRtwQIY7bdZsYWNt3tstqO0EnaW0G27goeEHUpAyKJH5VsnVQpmmpRAOBIoMXoM38zzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFZNjmjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0CDC2BD10;
	Tue, 14 May 2024 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715701528;
	bh=5eSG0yVHOgX7q8DmWM35E997LvHTT/LsnKwRqAW38WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFZNjmjJNgY4xuQ2YC9wLMCR49aYdCiSEKMcbyaGvBpFYMNWkkM/QGSqihxOpmCpG
	 6BxvpV4Liu1Cnjw8UXCHWe0XQu26K/WmPsM/XkKef49Nfy3btTdCwdX4d5QhzZkcv7
	 dxCHKlyZOOSSZWJDp59nbZFgJpuyqzPwd4HHyUpc=
Date: Tue, 14 May 2024 17:45:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Manuel Traut <manut@mecka.net>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024051424-shack-blinking-547a@gregkh>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-2-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507091619.2208810-2-jens.wiklander@linaro.org>

On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands. Such a partition provides authenticated and replay
> protected access, hence suitable as a secure storage.
> 
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
> 
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
> 
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Benn�e <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/misc/Kconfig     |  10 ++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
>  5 files changed, 387 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8999497011a2..e83152c42499 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19012,6 +19012,13 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
>  F:	drivers/media/platform/sunxi/sun8i-rotate/
>  
> +RPMB SUBSYSTEM
> +M:	Jens Wiklander <jens.wiklander@linaro.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported
> +F:	drivers/misc/rpmb-core.c
> +F:	include/linux/rpmb.h
> +
>  RPMSG TTY DRIVER
>  M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>  L:	linux-remoteproc@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..dbff9e8c3a03 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,6 +104,16 @@ config PHANTOM
>  	  If you choose to build module, its name will be phantom. If unsure,
>  	  say N here.
>  
> +config RPMB
> +	tristate "RPMB partition interface"
> +	depends on MMC
> +	help
> +	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
> +	  UFS. Provides interface for in-kernel security controllers to access
> +	  RPMB unit.
> +
> +	  If unsure, select N.
> +
>  config TIFM_CORE
>  	tristate "TI Flash Media interface support"
>  	depends on PCI
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..8af058ad1df4 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)		+= lkdtm/
>  obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)		+= phantom.o
> +obj-$(CONFIG_RPMB)		+= rpmb-core.o
>  obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> new file mode 100644
> index 000000000000..e42a45debc76
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> + * Copyright(c) 2021 - 2024 Linaro Ltd.
> + */
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/slab.h>
> +
> +static struct list_head rpmb_dev_list;
> +static DEFINE_MUTEX(rpmb_mutex);
> +static struct blocking_notifier_head rpmb_interface =
> +	BLOCKING_NOTIFIER_INIT(rpmb_interface);
> +
> +/**
> + * rpmb_dev_get() - increase rpmb device ref counter
> + * @rdev: rpmb device
> + */
> +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> +{
> +	if (rdev)
> +		get_device(rdev->parent_dev);

Odd, why are you thinking the parent reference has anything to do with
this device's reference?

Why isn't this a "real" device and part of the driver model properly?
This way of "hanging onto" a device and attempting to influence it's
reference count is odd, please make this real and not "fake".

Bonus, you get that notifier callback "for free" if you do that.  But
really, notifier callbacks are a pain, are you sure you want that?

thanks,

greg k-h

