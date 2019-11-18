Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79541000EE
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Nov 2019 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfKRJIe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 18 Nov 2019 04:08:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37841 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfKRJIe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Nov 2019 04:08:34 -0500
Received: by mail-vs1-f67.google.com with SMTP id u6so11003757vsp.4
        for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BghPULC5UyPGqCyK1zeAHOjx8ZZLIefg+Am36y5/pbE=;
        b=Pw0MMj8p0LlnfNL5IbJOueH/jHLg1Qa/uTp/EbX9PeEYraZm4/4ucchRNkZd+JXdr5
         5ZlPMG2O4DnKmDogObQljO1T4/UIwSo2B2d45lvJ2cECcebDcTKBuOHn6/BlYS70GzVQ
         zT1fD1WSZc+An41joFH5Ganlb0k+izYv67b3GGueB0eohIGHtnSmIxzhe0JaTSq/Nh2K
         PFMJuIpqKmDTi22uTsfmrjKK5MG2ugKRNofZ5BPWvy0rLbjEwkMypZkBcd1ilvyvQvpq
         9jt8khp2Rti2CkuVZkhtj2f6ki7PtshRfQWTBhbnqC5YHd52RlAUfcB+7eA0HMxGYWhE
         2dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BghPULC5UyPGqCyK1zeAHOjx8ZZLIefg+Am36y5/pbE=;
        b=ACKRLD9C8qLPzyTzTXNawbB4KNS3DZ26AyR4doj1/WY1QOjsfn+YeoKBA1ue9wMGri
         DFRnOhptG7yvGkxMMqjBk/RqDaNaMTM1ivgdnSoWahB20frgLNW46mWtOhoKLQydd7/v
         rTdLNyO+DYx08D+zVgW/uv9MSZ7M2EtfQ26a/4OV1MQUFk5u/8SFzvDF6Z2iN4cBFmNI
         kgZA/fZAaEWcCI3f4vLvvY+fd5o/gwDjDWTtKPePzSiIiyhjEoRarPXLPmSE6Z3GY1JX
         xwXRpLnG6gR6kbDMTWtbrWsYJjURWqOr+8BpHGrNZwBP04q5kjWZip6PyS+ZMGFFEyrP
         mXHw==
X-Gm-Message-State: APjAAAV5P96sJ1SK1VPMLrPrNQ99JgPeLvNzeSI2Bl1Zi2MRcq/Sqgx9
        3v7T37P8bGjUiuIRzSNRJdVoxEcO2LX9JzNOyngn6g==
X-Google-Smtp-Source: APXvYqxZ2cPOQDOOgbtbMRMPYyOPuVXbLXuf68UzKvf/TwmE5hxQYuGLkkLxzfpAHMKV3VLA+3FdtAgs3lyTtO7bPxA=
X-Received: by 2002:a67:2087:: with SMTP id g129mr18038208vsg.191.1574068113132;
 Mon, 18 Nov 2019 01:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20191117010045.4902-1-bradleybolen@gmail.com>
In-Reply-To: <20191117010045.4902-1-bradleybolen@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 10:07:57 +0100
Message-ID: <CAPDyKFreYm3EsLO=e97RCOqaKJxkYJ+fqJcgskO7PtO15Tj4fQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Fix size overflow for mmc partitions
To:     Bradley Bolen <bradleybolen@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 17 Nov 2019 at 02:00, Bradley Bolen <bradleybolen@gmail.com> wrote:
>
> With large eMMC cards, it is possible to create general purpose
> partitions that are bigger than 4GB.  The size member of the mmc_part
> struct is only an unsigned int which overflows for gp partitions larger
> than 4GB.  Change this to a u64 to handle the overflow.
>
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c   | 9 ++++-----
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8804895595f..f6912ded652d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
>         }
>  }
>
> -static void mmc_part_add(struct mmc_card *card, unsigned int size,
> +static void mmc_part_add(struct mmc_card *card, u64 size,
>                          unsigned int part_cfg, char *name, int idx, bool ro,
>                          int area_type)
>  {
> @@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  {
>         int idx;
>         u8 hc_erase_grp_sz, hc_wp_grp_sz;
> -       unsigned int part_size;
> +       u64 part_size;
>
>         /*
>          * General purpose partition feature support --
> @@ -343,8 +343,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>                                 (ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
>                                 << 8) +
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
> -                       part_size *= (size_t)(hc_erase_grp_sz *
> -                               hc_wp_grp_sz);
> +                       part_size *= (hc_erase_grp_sz * hc_wp_grp_sz);
>                         mmc_part_add(card, part_size << 19,
>                                 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
>                                 "gp%d", idx, false,
> @@ -362,7 +361,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  {
>         int err = 0, idx;
> -       unsigned int part_size;
> +       u64 part_size;
>         struct device_node *np;
>         bool broken_hpi = false;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9b6336ad3266..b59d35bb50ba 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -226,7 +226,7 @@ struct mmc_queue_req;
>   * MMC Physical partitions
>   */
>  struct mmc_part {
> -       unsigned int    size;   /* partition size (in bytes) */
> +       u64             size;   /* partition size (in bytes) */
>         unsigned int    part_cfg;       /* partition type */
>         char    name[MAX_MMC_PART_NAME_LEN];
>         bool    force_ro;       /* to make boot parts RO by default */
> --
> 2.17.1
>
