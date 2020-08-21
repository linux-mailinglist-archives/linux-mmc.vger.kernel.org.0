Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0613724D44D
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Aug 2020 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHULnU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 Aug 2020 07:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgHULk3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 07:40:29 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E3C061386
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 04:40:28 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id x187so343315vkc.1
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFNgDSMc7JOMGIbPZKb/OM6A+GqZX9psHWOlB5ar+8s=;
        b=rMtoye0n9R6CuarSrOjS3GnRJXq8MQO92TIhglcsWPkbhQ+t3LF7VUNYEIFispbcQB
         GWrK7DAs19icD9A2aOF5PC6LkmVp7hfYH0xc4Inpl9d7G5bn2UKKmH5Kc/XouZzotJsV
         h3KfCBML42tfubh89YH7YcsP3R5ilW0IqWOXpivmiFe3f1NvV9313n0sYb0EPhxEyloO
         kxhnvxkx7jaFkSQWAoM2YuRizKwoMxlKE2shkN7YL3Uk07L6KH8Qk0x0m0czpUHOxaG7
         TuxHRz/70zuRbG9ZwboW7hOXwd2pb2IvGvClQI5WECZLdTKHkahTd5Pfm9GYqZkJW6T2
         yTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFNgDSMc7JOMGIbPZKb/OM6A+GqZX9psHWOlB5ar+8s=;
        b=GqtX8GJVYfOam28rjn3glSWf8SQ9YeSxRT8t9j46WvqqFNsRh+GEYsTIRUxO6B0Bxd
         0X5m1pQPSptMxTXNgVNq172MlSOqAqsdiHSRB4O4Q1mGdLa3a/4m+vMnVOmZycV+Hz6w
         b0dzlvmM10kGg9oAkXvO42Sjp2+HlypPXPSTjANTTjtx2J5gybKHMtSgygAqBesPj+NI
         BNG3ggqrc5CeL5Oub2soAdS4nFFWQA6GEun11lSMtmDCHhOr33U1cgU5fUY97oSgyI7e
         RlUT8+umUGd3DCghctfTZmHAuvqQRM00Xaeizw6aWTRDN5HhoisBXjx9GGLxIdaOx8n2
         eBwQ==
X-Gm-Message-State: AOAM5316CLKpEydkaMIVnuSVWZ0A6PD8u/lOgRYdBfvi1al2gOnxzKSm
        TwzDhGj0seN5KetTYlUz2aQ/tSrXmQBkHVWCYV0oMEhc294imA==
X-Google-Smtp-Source: ABdhPJyApFROnp9qxiPoSbwTyAOBYp7NZD6ksF9hOJPMheBrGIqdrfFCyydF03TREJ78km0Fbid2Ek/R0/bxgm8ji6o=
X-Received: by 2002:a1f:9d85:: with SMTP id g127mr1230202vke.101.1598010027651;
 Fri, 21 Aug 2020 04:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 13:39:51 +0200
Message-ID: <CAPDyKFp1uwkmFVWXbCG32bRtu2kkUq_Vog646c=evmTixW6adA@mail.gmail.com>
Subject: Re: [PATCH mmc-next v2] mmc: allow setting slot index via device tree alias
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As with GPIO, UART and others, allow specifying the device index via the
> aliases node in the device tree.
>
> On embedded devices, there is often a combination of removable (e.g.
> SD card) and non-removable MMC devices (e.g. eMMC).
> Therefore the index might change depending on
>
> * host of removable device
> * removable card present or not
>
> This makes it difficult to hardcode the root device, if it is on the
> non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
> if SD card is not present at boot, eMMC will be mmcblk0.

Can you please add some information why Part-UUID/labels don't work
well to solve this problem on some embedded systems?

I think that deserves to be in the changelog, after all the long
discussions we had in the history around this.

I will continue to review the code in a separate email, in a while.

Kind regards
Uffe

>
> All indices defined in the aliases node will be reserved for use by the
> respective MMC device, moving the indices of devices that don't have an
> alias up into the non-reserved range. If the aliases node is not found,
> the driver will act as before.
>
> This is a rebased and slightly cleaned up version of
> https://www.spinics.net/lists/linux-mmc/msg26588.html .
>
> Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
> Link: https://lkml.org/lkml/2020/8/5/194
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>
> v2: fix missing symbols for modular mmcblock
>
>  drivers/mmc/core/block.c | 13 +++++++++++--
>  drivers/mmc/core/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h  |  3 +++
>  drivers/mmc/core/host.c  | 15 +++++++++++++--
>  4 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 7896952de1ac..4620afaf0e50 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -38,6 +38,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/debugfs.h>
> +#include <linux/of.h>
>
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -2260,9 +2261,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                                               int area_type)
>  {
>         struct mmc_blk_data *md;
> -       int devidx, ret;
> +       int rsvidx, devidx = -1, ret;
> +
> +       rsvidx = mmc_get_reserved_index(card->host);
> +       if (rsvidx >= 0)
> +               devidx = ida_simple_get(&mmc_blk_ida, rsvidx, rsvidx + 1,
> +                                       GFP_KERNEL);
> +       if (devidx < 0)
> +               devidx = ida_simple_get(&mmc_blk_ida,
> +                                       mmc_first_nonreserved_index(),
> +                                       max_devices, GFP_KERNEL);



>
> -       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>         if (devidx < 0) {
>                 /*
>                  * We get -ENOSPC because there are no more any available
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8ccae6452b9c..5bce281a5faa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2419,10 +2419,50 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
>  }
>  #endif
>
> +static int mmc_max_reserved_idx = -1;
> +
> +/**
> + * mmc_first_nonreserved_index() - get the first index that is not reserved
> + */
> +int mmc_first_nonreserved_index(void)
> +{
> +       return mmc_max_reserved_idx + 1;
> +}
> +EXPORT_SYMBOL(mmc_first_nonreserved_index);
> +
> +/**
> + * mmc_get_reserved_index() - get the index reserved for this MMC host
> + *
> + * Returns:
> + *   The index reserved for this host on success,
> + *   negative error if no index is reserved for this host
> + */
> +int mmc_get_reserved_index(struct mmc_host *host)
> +{
> +       return of_alias_get_id(host->parent->of_node, "mmc");
> +}
> +EXPORT_SYMBOL(mmc_get_reserved_index);
> +
> +static void __init mmc_of_reserve_idx(void)
> +{
> +       int max;
> +
> +       max = of_alias_get_highest_id("mmc");
> +       if (max < 0)
> +               return;
> +
> +       mmc_max_reserved_idx = max;
> +
> +       pr_debug("MMC: reserving %d slots for OF aliases\n",
> +                mmc_max_reserved_idx + 1);
> +}
> +
>  static int __init mmc_init(void)
>  {
>         int ret;
>
> +       mmc_of_reserve_idx();
> +
>         ret = mmc_register_bus();
>         if (ret)
>                 return ret;
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 575ac0257af2..6aef6cf4e90f 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -79,6 +79,9 @@ int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
>  int mmc_attach_sdio(struct mmc_host *host);
>
> +int mmc_first_nonreserved_index(void);
> +int mmc_get_reserved_index(struct mmc_host *host);
> +
>  /* Module parameters */
>  extern bool use_spi_crc;
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index ce43f7573d80..386e15afde83 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
>         int err;
>         struct mmc_host *host;
> +       int alias_id, min_idx, max_idx;
>
>         host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
>         if (!host)
> @@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       host->parent = dev;
> +
> +       alias_id = mmc_get_reserved_index(host);
> +       if (alias_id >= 0) {
> +               min_idx = alias_id;
> +               max_idx = alias_id + 1;
> +       } else {
> +               min_idx = mmc_first_nonreserved_index();
> +               max_idx = 0;
> +       }
> +
> +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> @@ -406,7 +418,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         dev_set_name(&host->class_dev, "mmc%d", host->index);
>         host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
>
> -       host->parent = dev;
>         host->class_dev.parent = dev;
>         host->class_dev.class = &mmc_host_class;
>         device_initialize(&host->class_dev);
> --
> 2.17.1
>
