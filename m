Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C1406972
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Sep 2021 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhIJKET (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 Sep 2021 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhIJKES (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Sep 2021 06:04:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57AC061760
        for <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2021 03:03:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i28so2309474ljm.7
        for <linux-mmc@vger.kernel.org>; Fri, 10 Sep 2021 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dEuac9rSHq7JUduezT8HwcQhOBmFMqWK+qNzEaHMzA=;
        b=cGANsLiIwZL5YraDhAoqqQL3JhGo7FT78wGD1pgmxyc2ai+TMrmFAwTeu5vWSI4KP1
         iNWoki32GjMI63qL0o1REeCB/RaqLOlE5bW1vyD8voEg2byWU830Trxu1bmrWs9Vn3q/
         tO8s5UM7WWk5mwH3Oc6Y96n2L6mEABKAkFTQbV6b1hMLyKZGPyQxwVQMt8pEYT/hI647
         uo3IAbHoRlTPBsca9Xmgn/nNDloAaaHGKrc1fJKLB6FE8UPgLEuDH+6ZCI2TbnPTh5iL
         IkGEK2ZeNMNHyiklh3k5kEvIksN3xYdfOgdE+ggYgWG1/srW8ZA350zlfChsjiOkdHee
         A9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dEuac9rSHq7JUduezT8HwcQhOBmFMqWK+qNzEaHMzA=;
        b=6nTrlgCov8GMCYZgWSRgL0mOrdn9uuCA4xgbQ8KH9bJOXtV7Xa1/KHLrwhrVIkGg+L
         f6XVY5c2yQzCdyhSjGWpF6GFM6OTnEEPYbpZLxVXzJCJyWHSNHO5ad5OwVZ53OGx3lzV
         nMEbtqFMILRQQxpbWpCS2iRnEHfO7pia/F6nYgnHnsaLWwNPBLcJT/HYQeVT12/QXBgZ
         MEjLGJJh75aPK1xBLWuk/pMF14vGqmnPIvlWjWgo18+uPni44ToEX8wrqhbru7CSeWLX
         EKC6LNJ0KKY+VVWXiImBTFjhS8yIGlvXe4NKrmBHA9FWWGnR0nOXGVphV4cmf8UwAYS0
         xvsw==
X-Gm-Message-State: AOAM531esCro5Xmx0JD1zuSFa1AiHl8Z7C87nYpNmgtzpOdiZdECMhnE
        1E1wduvs4NeJvVYPBhW3aWTizkVn+IvptmB9CEDWKg==
X-Google-Smtp-Source: ABdhPJxCuqOyrV8rWgoBg25TY/oC+cAD3QE2JKgVeCDwhA23KMCoCBshviD/DHBB8EAg7Bg9OPA+k3cUGJUXolihNM0=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr3660606ljh.300.1631268185607;
 Fri, 10 Sep 2021 03:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210829131305.534417-1-dmitry.baryshkov@linaro.org> <20210829131305.534417-2-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210829131305.534417-2-dmitry.baryshkov@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Sep 2021 12:02:29 +0200
Message-ID: <CAPDyKFp9CM+x505URK=hcO0QFqcZrpqzQ6uJQ=ZLR6uq-_d5Ew@mail.gmail.com>
Subject: Re: [RFC v2 01/13] power: add power sequencer subsystem
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 29 Aug 2021 at 15:13, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Basing on MMC's pwrseq support code, add separate power sequencer
> subsystem. It will be used by other drivers to handle device power up
> requirements.

This is far too vague. You are suggesting to add a new subsystem, I
think that deserves some more explanations as justifications.

Additionally, it wouldn't hurt to explain a bit how the actual
subsystem is supposed to work, at least from a toplevel point of view.

>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/power/Kconfig           |   1 +
>  drivers/power/Makefile          |   1 +
>  drivers/power/pwrseq/Kconfig    |  11 +
>  drivers/power/pwrseq/Makefile   |   6 +
>  drivers/power/pwrseq/core.c     | 412 ++++++++++++++++++++++++++++++++
>  include/linux/pwrseq/consumer.h |  88 +++++++
>  include/linux/pwrseq/driver.h   |  75 ++++++
>  7 files changed, 594 insertions(+)
>  create mode 100644 drivers/power/pwrseq/Kconfig
>  create mode 100644 drivers/power/pwrseq/Makefile
>  create mode 100644 drivers/power/pwrseq/core.c
>  create mode 100644 include/linux/pwrseq/consumer.h
>  create mode 100644 include/linux/pwrseq/driver.h

I noticed there is no update of the MAINTAINERS file. We need that to
be a part of the $subject patch as well, I think. But, let's discuss
that later.

>
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 696bf77a7042..c87cd2240a74 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +source "drivers/power/pwrseq/Kconfig"
>  source "drivers/power/reset/Kconfig"
>  source "drivers/power/supply/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index effbf0377f32..1dbce454a8c4 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_POWER_RESET)      += reset/
>  obj-$(CONFIG_POWER_SUPPLY)     += supply/
> +obj-$(CONFIG_PWRSEQ)           += pwrseq/
> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 000000000000..8904ec9ed541
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig PWRSEQ
> +       bool "Power Sequencer drivers"
> +       help
> +         Provides support for special power sequencing drivers.

This needs more description. The name "power sequencer" isn't entirely
self-explanatory, for when this should be used. I am not saying you
should invent a new name, rather just extend the description so people
get a better idea of what this is supposed to be used for.

> +
> +         Say Y here to enable support for such devices
> +
> +if PWRSEQ
> +
> +endif
> diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
> new file mode 100644
> index 000000000000..108429ff6445
> --- /dev/null
> +++ b/drivers/power/pwrseq/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for power sequencer drivers.
> +#
> +
> +obj-$(CONFIG_PWRSEQ) += core.o
> diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
> new file mode 100644
> index 000000000000..2e4e9d123e60
> --- /dev/null
> +++ b/drivers/power/pwrseq/core.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 (c) Linaro Ltd.
> + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> + *
> + * Based on phy-core.c:
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#include <linux/device.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwrseq/consumer.h>
> +#include <linux/pwrseq/driver.h>
> +#include <linux/slab.h>
> +
> +#define        to_pwrseq(a)    (container_of((a), struct pwrseq, dev))
> +
> +static DEFINE_IDA(pwrseq_ida);
> +static DEFINE_MUTEX(pwrseq_provider_mutex);
> +static LIST_HEAD(pwrseq_provider_list);
> +
> +struct pwrseq_provider {
> +       struct device           *dev;
> +       struct module           *owner;
> +       struct list_head        list;
> +       void                    *data;
> +       struct pwrseq * (*of_xlate)(void *data, struct of_phandle_args *args);
> +};
> +
> +void pwrseq_put(struct device *dev, struct pwrseq *pwrseq)
> +{
> +       device_link_remove(dev, &pwrseq->dev);

device_links - why do we need these at this initial step?

Please drop them so we can start with a simple implementation - and
then possibly extend it.

> +
> +       module_put(pwrseq->owner);
> +       put_device(&pwrseq->dev);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_put);
> +
> +static struct pwrseq_provider *of_pwrseq_provider_lookup(struct device_node *node)
> +{
> +       struct pwrseq_provider *pwrseq_provider;
> +
> +       list_for_each_entry(pwrseq_provider, &pwrseq_provider_list, list) {
> +               if (pwrseq_provider->dev->of_node == node)
> +                       return pwrseq_provider;
> +       }
> +
> +       return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static struct pwrseq *_of_pwrseq_get(struct device *dev, const char *id)
> +{
> +       struct pwrseq_provider *pwrseq_provider;
> +       struct pwrseq *pwrseq;
> +       struct of_phandle_args args;
> +       char prop_name[64]; /* 64 is max size of property name */
> +       int ret;
> +
> +       snprintf(prop_name, 64, "%s-pwrseq", id);
> +       ret = of_parse_phandle_with_args(dev->of_node, prop_name, "#pwrseq-cells", 0, &args);

This means that you are parsing a new DT binding/property.

Please fold in a DT binding patch, preceding $subject patch, so that
new binding that it can be discussed as well.

> +       if (ret) {
> +               /*
> +                * Parsing failed. Try locating old bindings for mmc-pwrseq,
> +                * which did not use #pwrseq-cells.
> +                */
> +               if (strcmp(id, "mmc"))
> +                       return NULL;
> +
> +               ret = of_parse_phandle_with_args(dev->of_node, prop_name, NULL, 0, &args);
> +               if (ret)
> +                       return NULL;
> +
> +               dev_warn(dev, "old mmc-pwrseq binding used, add #pwrseq-cells to the provider\n");

To start simple and thus to also make review easier, I suggest to skip
the mmc-pwrseq binding for now. Let's see if we can deal with that as
a standalone change on top, later, instead.

> +       }
> +
> +       mutex_lock(&pwrseq_provider_mutex);
> +       pwrseq_provider = of_pwrseq_provider_lookup(args.np);
> +       if (IS_ERR(pwrseq_provider) || !try_module_get(pwrseq_provider->owner)) {
> +               pwrseq = ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
> +       }
> +
> +       if (!of_device_is_available(args.np)) {
> +               dev_warn(pwrseq_provider->dev, "Requested pwrseq is disabled\n");
> +               pwrseq = ERR_PTR(-ENODEV);
> +               goto out_put_module;
> +       }
> +
> +       pwrseq = pwrseq_provider->of_xlate(pwrseq_provider->data, &args);
> +
> +out_put_module:
> +       module_put(pwrseq_provider->owner);
> +
> +out_unlock:
> +       mutex_unlock(&pwrseq_provider_mutex);
> +       of_node_put(args.np);
> +
> +       return pwrseq;
> +}
> +
> +struct pwrseq * __pwrseq_get(struct device *dev, const char *id, bool optional)
> +{
> +       struct pwrseq *pwrseq;
> +       struct device_link *link;
> +
> +       pwrseq = _of_pwrseq_get(dev, id);
> +       if (pwrseq == NULL)
> +               return optional ? NULL : ERR_PTR(-ENODEV);

I think we can manage this without "optional". The optional should
typically be the default behaviour, I think.

The caller should expect to get a handle to a pwrseq - if there is
property in the DT file that says there should be one. If not, the
caller should be happy to just receive "NULL". And if there is an
error, we should return ERR_PTR, as you do.

> +       else if (IS_ERR(pwrseq))
> +               return pwrseq;
> +
> +       if (!try_module_get(pwrseq->owner))
> +               return ERR_PTR(-EPROBE_DEFER);
> +
> +       get_device(&pwrseq->dev);
> +       link = device_link_add(dev, &pwrseq->dev, DL_FLAG_STATELESS);
> +       if (!link)
> +               dev_dbg(dev, "failed to create device link to %s\n",
> +                       dev_name(pwrseq->dev.parent));
> +
> +       return pwrseq;
> +}
> +
> +struct pwrseq * pwrseq_get(struct device *dev, const char *id)
> +{
> +       return __pwrseq_get(dev, id, false);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_get);
> +
> +static void devm_pwrseq_release(struct device *dev, void *res)
> +{
> +       struct pwrseq *pwrseq = *(struct pwrseq **)res;
> +
> +       pwrseq_put(dev, pwrseq);
> +}
> +
> +struct pwrseq * devm_pwrseq_get(struct device *dev, const char *id)
> +{
> +       struct pwrseq **ptr, *pwrseq;
> +
> +       ptr = devres_alloc(devm_pwrseq_release, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq = pwrseq_get(dev, id);
> +       if (!IS_ERR(pwrseq)) {
> +               *ptr = pwrseq;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return pwrseq;
> +}
> +EXPORT_SYMBOL_GPL(devm_pwrseq_get);
> +
> +struct pwrseq * pwrseq_get_optional(struct device *dev, const char *id)
> +{
> +       return __pwrseq_get(dev, id, true);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_get_optional);

This can be dropped, if we make this the default behaviour.

> +
> +struct pwrseq * devm_pwrseq_get_optional(struct device *dev, const char *id)
> +{
> +       struct pwrseq **ptr, *pwrseq;
> +
> +       ptr = devres_alloc(devm_pwrseq_release, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq = pwrseq_get_optional(dev, id);
> +       if (!IS_ERR_OR_NULL(pwrseq)) {
> +               *ptr = pwrseq;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return pwrseq;
> +}
> +EXPORT_SYMBOL_GPL(devm_pwrseq_get_optional);

Ditto.

> +
> +int pwrseq_pre_power_on(struct pwrseq *pwrseq)
> +{
> +       if (pwrseq && pwrseq->ops->pre_power_on)
> +               return pwrseq->ops->pre_power_on(pwrseq);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_pre_power_on);
> +
> +int pwrseq_power_on(struct pwrseq *pwrseq)
> +{
> +       if (pwrseq && pwrseq->ops->power_on)
> +               return pwrseq->ops->power_on(pwrseq);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_power_on);
> +
> +void pwrseq_power_off(struct pwrseq *pwrseq)
> +{
> +       if (pwrseq && pwrseq->ops->power_off)
> +               pwrseq->ops->power_off(pwrseq);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_power_off);
> +
> +void pwrseq_reset(struct pwrseq *pwrseq)
> +{
> +       if (pwrseq && pwrseq->ops->reset)
> +               pwrseq->ops->reset(pwrseq);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_reset);
> +
> +static void pwrseq_dev_release(struct device *dev)
> +{
> +       struct pwrseq *pwrseq = to_pwrseq(dev);
> +
> +       ida_free(&pwrseq_ida, pwrseq->id);
> +       of_node_put(dev->of_node);
> +       kfree(pwrseq);
> +}
> +
> +static struct class pwrseq_class = {
> +       .name = "pwrseq",
> +       .dev_release = pwrseq_dev_release,
> +};
> +
> +struct pwrseq *__pwrseq_create(struct device *dev, struct module *owner, const struct pwrseq_ops *ops, void *data)
> +{
> +       struct pwrseq *pwrseq;
> +       int ret;
> +
> +       if (WARN_ON(!dev))
> +               return ERR_PTR(-EINVAL);
> +
> +       pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
> +       if (!pwrseq)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ret = ida_alloc(&pwrseq_ida, GFP_KERNEL);
> +       if (ret < 0)
> +               goto free_pwrseq;
> +
> +       pwrseq->id = ret;
> +
> +       device_initialize(&pwrseq->dev);
> +
> +       pwrseq->dev.class = &pwrseq_class;
> +       pwrseq->dev.parent = dev;
> +       pwrseq->dev.of_node = of_node_get(dev->of_node);
> +       pwrseq->ops = ops;
> +       pwrseq->owner = owner;
> +
> +       dev_set_drvdata(&pwrseq->dev, data);
> +
> +       ret = dev_set_name(&pwrseq->dev, "pwrseq-%s.%u", dev_name(dev), pwrseq->id);
> +       if (ret)
> +               goto put_dev;
> +
> +       ret = device_add(&pwrseq->dev);
> +       if (ret)
> +               goto put_dev;
> +
> +       if (pm_runtime_enabled(dev)) {
> +               pm_runtime_enable(&pwrseq->dev);
> +               pm_runtime_no_callbacks(&pwrseq->dev);
> +       }

I don't think we should bother with runtime PM, at least in this
initial step. Please drop it, to start simple.

> +
> +       return pwrseq;
> +
> +put_dev:
> +       /* will call pwrseq_dev_release() to free resources */
> +       put_device(&pwrseq->dev);
> +
> +       return ERR_PTR(ret);
> +
> +free_pwrseq:
> +       kfree(pwrseq);
> +
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(__pwrseq_create);
> +
> +void pwrseq_destroy(struct pwrseq *pwrseq)
> +{
> +       pm_runtime_disable(&pwrseq->dev);
> +       device_unregister(&pwrseq->dev);
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_destroy);
> +
> +static void devm_pwrseq_destroy(struct device *dev, void *res)
> +{
> +       struct pwrseq *pwrseq = *(struct pwrseq **)res;
> +
> +       pwrseq_destroy(pwrseq);
> +}
> +
> +struct pwrseq *__devm_pwrseq_create(struct device *dev, struct module *owner, const struct pwrseq_ops *ops, void *data)
> +{
> +       struct pwrseq **ptr, *pwrseq;
> +
> +       ptr = devres_alloc(devm_pwrseq_destroy, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq = __pwrseq_create(dev, owner, ops, data);
> +       if (!IS_ERR(pwrseq)) {
> +               *ptr = pwrseq;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return pwrseq;
> +}
> +EXPORT_SYMBOL_GPL(__devm_pwrseq_create);
> +
> +struct pwrseq_provider *__of_pwrseq_provider_register(struct device *dev,
> +       struct module *owner,
> +       struct pwrseq * (*of_xlate)(void *data,
> +                                   struct of_phandle_args *args),
> +       void *data)
> +{
> +       struct pwrseq_provider *pwrseq_provider;
> +
> +       pwrseq_provider = kzalloc(sizeof(*pwrseq_provider), GFP_KERNEL);
> +       if (!pwrseq_provider)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq_provider->dev = dev;
> +       pwrseq_provider->owner = owner;
> +       pwrseq_provider->of_xlate = of_xlate;
> +       pwrseq_provider->data = data;
> +
> +       mutex_lock(&pwrseq_provider_mutex);
> +       list_add_tail(&pwrseq_provider->list, &pwrseq_provider_list);
> +       mutex_unlock(&pwrseq_provider_mutex);
> +
> +       return pwrseq_provider;
> +}
> +EXPORT_SYMBOL_GPL(__of_pwrseq_provider_register);
> +
> +void of_pwrseq_provider_unregister(struct pwrseq_provider *pwrseq_provider)
> +{
> +       if (IS_ERR(pwrseq_provider))
> +               return;
> +
> +       mutex_lock(&pwrseq_provider_mutex);
> +       list_del(&pwrseq_provider->list);
> +       kfree(pwrseq_provider);
> +       mutex_unlock(&pwrseq_provider_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_pwrseq_provider_unregister);
> +
> +static void devm_pwrseq_provider_unregister(struct device *dev, void *res)
> +{
> +       struct pwrseq_provider *pwrseq_provider = *(struct pwrseq_provider **)res;
> +
> +       of_pwrseq_provider_unregister(pwrseq_provider);
> +}
> +
> +struct pwrseq_provider *__devm_of_pwrseq_provider_register(struct device *dev,
> +       struct module *owner,
> +       struct pwrseq * (*of_xlate)(void *data,
> +                                   struct of_phandle_args *args),
> +       void *data)
> +{
> +       struct pwrseq_provider **ptr, *pwrseq_provider;
> +
> +       ptr = devres_alloc(devm_pwrseq_provider_unregister, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pwrseq_provider = __of_pwrseq_provider_register(dev, owner, of_xlate, data);
> +       if (!IS_ERR(pwrseq_provider)) {
> +               *ptr = pwrseq_provider;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return pwrseq_provider;
> +}
> +EXPORT_SYMBOL_GPL(__devm_of_pwrseq_provider_register);
> +
> +struct pwrseq *of_pwrseq_xlate_onecell(void *data, struct of_phandle_args *args)
> +{
> +       struct pwrseq_onecell_data *pwrseq_data = data;
> +       unsigned int idx;
> +
> +       if (args->args_count != 1)
> +               return ERR_PTR(-EINVAL);
> +
> +       idx = args->args[0];
> +       if (idx >= pwrseq_data->num) {
> +               pr_err("%s: invalid index %u\n", __func__, idx);
> +               return ERR_PTR(-EINVAL);
> +       }

In many cases it's reasonable to leave room for future extensions, so
that a provider could serve with more than one power-sequencer. I
guess that is what you intend to do here, right?

In my opinion, I don't think what would happen, especially since a
power-sequence is something that should be specific to one particular
device (a Qcom WiFi/Blutooth chip, for example).

That said, I suggest limiting this to a 1:1 mapping between the device
node and power-sequencer. I think that should simplify the code a bit.

> +
> +       return pwrseq_data->pwrseqs[idx];
> +}
> +
> +static int __init pwrseq_core_init(void)
> +{
> +       return class_register(&pwrseq_class);
> +}
> +device_initcall(pwrseq_core_init);
> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
> new file mode 100644
> index 000000000000..fbcdc1fc0751
> --- /dev/null
> +++ b/include/linux/pwrseq/consumer.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2021 Linaro Ltd.
> + */
> +
> +#ifndef __LINUX_PWRSEQ_CONSUMER_H__
> +#define __LINUX_PWRSEQ_CONSUMER_H__
> +
> +struct pwrseq;
> +struct device;
> +
> +#if defined(CONFIG_PWRSEQ)
> +
> +struct pwrseq *__must_check pwrseq_get(struct device *dev, const char *id);
> +struct pwrseq *__must_check devm_pwrseq_get(struct device *dev, const char *id);
> +
> +struct pwrseq *__must_check pwrseq_get_optional(struct device *dev, const char *id);
> +struct pwrseq *__must_check devm_pwrseq_get_optional(struct device *dev, const char *id);
> +
> +void pwrseq_put(struct device *dev, struct pwrseq *pwrseq);
> +
> +int pwrseq_pre_power_on(struct pwrseq *pwrseq);
> +int pwrseq_power_on(struct pwrseq *pwrseq);
> +void pwrseq_power_off(struct pwrseq *pwrseq);
> +void pwrseq_reset(struct pwrseq *pwrseq);
> +
> +#else
> +
> +static inline struct pwrseq *__must_check
> +pwrseq_get(struct device *dev, const char *id)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline struct pwrseq *__must_check
> +devm_pwrseq_get(struct device *dev, const char *id)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline struct pwrseq *__must_check
> +pwrseq_get_optional(struct device *dev, const char *id)
> +{
> +       return NULL;
> +}
> +
> +static inline struct pwrseq *__must_check
> +devm_pwrseq_get_optional(struct device *dev, const char *id)
> +{
> +       return NULL;
> +}
> +
> +static inline void pwrseq_put(struct device *dev, struct pwrseq *pwrseq)
> +{
> +}
> +
> +static inline int pwrseq_pre_power_on(struct pwrseq *pwrseq)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int pwrseq_power_on(struct pwrseq *pwrseq)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline void pwrseq_power_off(struct pwrseq *pwrseq)
> +{
> +}
> +
> +static inline void pwrseq_reset(struct pwrseq *pwrseq)
> +{
> +}
> +
> +#endif
> +
> +static inline int pwrseq_full_power_on(struct pwrseq *pwrseq)
> +{
> +       int ret;
> +
> +       ret = pwrseq_pre_power_on(pwrseq);
> +       if (ret)
> +               return ret;
> +
> +       return pwrseq_power_on(pwrseq);
> +}
> +
> +#endif /* __LINUX_PWRSEQ_CONSUMER_H__ */
> diff --git a/include/linux/pwrseq/driver.h b/include/linux/pwrseq/driver.h
> new file mode 100644
> index 000000000000..b2bc46624d7e
> --- /dev/null
> +++ b/include/linux/pwrseq/driver.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2021 Linaro Ltd.
> + */
> +
> +#ifndef __LINUX_PWRSEQ_DRIVER_H__
> +#define __LINUX_PWRSEQ_DRIVER_H__
> +
> +#include <linux/device.h>
> +
> +struct pwrseq;
> +
> +struct pwrseq_ops {
> +       int (*pre_power_on)(struct pwrseq *pwrseq);
> +       int (*power_on)(struct pwrseq *pwrseq);
> +       void (*power_off)(struct pwrseq *pwrseq);
> +       void (*reset)(struct pwrseq *pwrseq);
> +};
> +
> +struct module;
> +
> +struct pwrseq {
> +       struct device dev;
> +       const struct pwrseq_ops *ops;
> +       unsigned int id;
> +       struct module *owner;
> +};
> +
> +struct pwrseq *__pwrseq_create(struct device *dev, struct module *owner, const struct pwrseq_ops *ops, void *data);
> +struct pwrseq *__devm_pwrseq_create(struct device *dev, struct module *owner, const struct pwrseq_ops *ops, void *data);
> +
> +#define pwrseq_create(dev, ops, data) __pwrseq_create((dev), THIS_MODULE, (ops), (data))
> +#define devm_pwrseq_create(dev, ops, data) __devm_pwrseq_create((dev), THIS_MODULE, (ops), (data))
> +
> +void pwrseq_destroy(struct pwrseq *pwrseq);
> +
> +static inline void *pwrseq_get_data(struct pwrseq *pwrseq)
> +{
> +       return dev_get_drvdata(&pwrseq->dev);
> +}
> +
> +#define        of_pwrseq_provider_register(dev, xlate, data)   \
> +       __of_pwrseq_provider_register((dev), THIS_MODULE, (xlate), (data))
> +
> +#define        devm_of_pwrseq_provider_register(dev, xlate, data)      \
> +       __devm_of_pwrseq_provider_register((dev), THIS_MODULE, (xlate), (data))
> +
> +struct of_phandle_args;
> +
> +struct pwrseq_provider *__of_pwrseq_provider_register(struct device *dev,
> +       struct module *owner,
> +       struct pwrseq * (*of_xlate)(void *data,
> +                                   struct of_phandle_args *args),
> +       void *data);
> +struct pwrseq_provider *__devm_of_pwrseq_provider_register(struct device *dev,
> +       struct module *owner,
> +       struct pwrseq * (*of_xlate)(void *data,
> +                                   struct of_phandle_args *args),
> +       void *data);
> +void of_pwrseq_provider_unregister(struct pwrseq_provider *pwrseq_provider);
> +
> +static inline struct pwrseq *of_pwrseq_xlate_single(void *data,
> +                                                   struct of_phandle_args *args)
> +{
> +       return data;
> +}
> +
> +struct pwrseq_onecell_data {
> +       unsigned int num;
> +       struct pwrseq *pwrseqs[];
> +};

According to my earlier comment, I think a lot can be removed from
here - if you would limit the provider to only use
of_pwrseq_xlate_single.

Again, I think it's better to start simple, as it simplifies the review.

> +
> +struct pwrseq *of_pwrseq_xlate_onecell(void *data, struct of_phandle_args *args);
> +
> +#endif /* __LINUX_PWRSEQ_DRIVER_H__ */
> --
> 2.33.0
>

Other than my comments, overall I think this looks like a good start.

Kind regards
Uffe
