Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21227A06BA
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Sep 2023 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjINN7v (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Sep 2023 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjINN7v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:59:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BED1BF8
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:59:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59b5484fbe6so11992187b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694699986; x=1695304786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLk/UIhbEWHcOxkr8dOZqvdg6nN0C0eDPfAyjrTnPMc=;
        b=LbBUX8YiRxKogPXtT1ixaB0lX1o52ymH/hbBjmi3ooD9FHzPvu0pWzSHJR3gVQO0Rw
         O3EbVM1+xBYLcb8wJnd+VuOI8U8QGVWsFAg+0cnpQCHFY8Vm0IbTpfLEzZNFNNJI4gbY
         435dkVPUl96vxTQCEzh/S+MosCitgsDU5mMAeTOfyRSA1FVrDZ3v17a+7ob56kxv+7wo
         L0A1OwFRy7rfuNcDTVHaiWvnAx6xtFtK4rfrCu2FdZqIVGxVkqXJccw4FFiVEda9JlEk
         0bvQc/q3mB5jd1OtmWTXL9t6F2TOxc04YT0pxQS9NFddFNpHnAvMxTNa6O7xMIAkHz85
         BpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699986; x=1695304786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLk/UIhbEWHcOxkr8dOZqvdg6nN0C0eDPfAyjrTnPMc=;
        b=fXHItlllc4/cdoWGPwMG2es50sC0Yut45k6nchgrM6EIYnIdQum/KtMNDz6EdOn78c
         v5sEyc3wiGL0zc5qWZObEOnzUizgRep0ONLdNJ6BRu9fzbj++3elD94v345Jf9dFTeqc
         TTzG/flc1dn6+WjsC/L9FgAFzNNkb7vF+wOTAXmSyxQOUFhsXd8momtSSi2b4hy5iN0n
         C+hV6RPiirtYq7GjCZVCgJZPPtSUcsZmCtOVLj3fr+JrMIqgR1PolxN5rynmMnmvwvka
         gZC3/CtLM75Y7RproYC2PZ8pXYgBEBmZMPRLo3L1I0oBqUlDqYbMXt5rXLfwOtVVsMtg
         Fd/A==
X-Gm-Message-State: AOJu0YxUi8NqtNMIiB4yT4eBWi3doFUJs/rBScBKmwIemaDCj+xPdh+L
        ZXcstv/8dMMokdXWVjRFczq/iSkEM4wuwC6HygWz+g==
X-Google-Smtp-Source: AGHT+IEav7dN4J1tbxq270gQr21OUdOI/OzhRL/Fj+MO9+aGIUvI0pmuomVUy01V4Pm1AgAu/Z5uFjwYOSVEBvNYfZE=
X-Received: by 2002:a25:ad4a:0:b0:d81:b9f0:455e with SMTP id
 l10-20020a25ad4a000000b00d81b9f0455emr163134ybe.51.1694699986474; Thu, 14 Sep
 2023 06:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230913185735.459661-1-beanhuo@iokpp.de>
In-Reply-To: <20230913185735.459661-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:59:10 +0200
Message-ID: <CAPDyKFrt4r88RhCg1XigFtd8xSrLLbHeD31ZAEA0aUDkNzRxGQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Sept 2023 at 20:57, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.

This needs some more explanation I think. What does "after a write" really mean?

According to the changes below, we are tracking only whether a write
has been done and then we set host->card->written_flag = true - keep
it like that forever.

What happens beyond a power cycle for example? Like in the recovery
path or in the system wide suspend/resume path? Does the flag need to
be reset in those cases too?

Kind regards
Uffe

>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/core/core.c   | 6 ++++++
>  drivers/mmc/core/mmc.c    | 5 +++++
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  4 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 3d3e0ca52614..5f858eb5f62c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -259,6 +259,12 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>                 host->cqe_ops->cqe_off(host);
>
>         host->ops->request(host, mrq);
> +
> +       if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH && !host->card->written_flag) {
> +               if (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
> +                   mrq->cmd->opcode == MMC_WRITE_BLOCK)
> +                       host->card->written_flag = true;
> +       }
>  }
>
>  static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..a2edd065fa1b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>         if (!oldcard)
>                 host->card = card;
>
> +       card->written_flag = false;
> +
>         return 0;
>
>  free_card:
> @@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH && !host->card->written_flag)
> +               return err;
> +
>         if (_mmc_cache_enabled(host)) {
>                 err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_FLUSH_CACHE, 1,
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..5e68c8b4cdca 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>                   MMC_QUIRK_TRIM_BROKEN),
>
>         /*
> -        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> -        * support being used to offload WRITE_ZEROES.
> +        * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
> +        * WRITE_ZEROES offloading. It also supports caching, but the cache can
> +        * only be flushed after a write has occurred.
>          */
>         MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> -                 MMC_QUIRK_TRIM_BROKEN),
> +                 MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
>
>         /*
>          * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..7b12eebc5586 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -295,7 +295,9 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
> +#define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>
> +       bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>
>         unsigned int            erase_size;     /* erase size in sectors */
> --
> 2.34.1
>
