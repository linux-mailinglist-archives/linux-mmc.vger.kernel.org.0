Return-Path: <linux-mmc+bounces-603-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223E8251C5
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C67285352
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830812D045;
	Fri,  5 Jan 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDHtesv+"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6862C869
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jan 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbd739853easo1214625276.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2024 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704449969; x=1705054769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eN3mm0CyL5f2TZeRq2cvai8N3s8ehzSOlLnk4WHpwLs=;
        b=JDHtesv+1x7Fu0jpky3GGD1tqZ9oHUCErljDRVfPJwdFoaYmVX0QxqUqS/TipDQA05
         IZycT3uIZmJuXjwfOXMu9t8FMcV+MlLxtb9BUHUsHzy5zILuVlmTK3zPLAjOA/r+KBik
         FVj7Hf9GpW1z9BmuGfU25GtMDmk1s1VHWC0PBnSFd5BHBuPNcq/tja8kpamuEcUz/HrZ
         Yi4pBRjb4b07DjBHp3nh9T40GkBVSDehlrftfrcDOHu2VqDF4nX3Yd1n8rqQ7gPDnmbK
         uekCM+gnYVKbmDf/U4k7F9lBAoEy5CbpzaadWjbUOlhP3IP3KsM2JkJW39ZWY/GjAoGg
         peZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449969; x=1705054769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN3mm0CyL5f2TZeRq2cvai8N3s8ehzSOlLnk4WHpwLs=;
        b=sjSLAbq+9OkLXzxnRoIy1NCV+6H9L4/UOKvR9oOWNBiQJETigdW0PUtOryQOVLobv+
         y7VKxC6daQkM7qQlpV4xi1jOc7OqHk2tBW2QDsx4hB814mNLHZ7jd9W0o/bweWnOpKNI
         k58UWiAspnQSf8Lnp27ToljrosinaQG4d0GoyRjkplyQJT3vm+bCRkUnKg/xDBMB8d/A
         aiTvvKnD1uxKasar0wAlVDFG6p4VuZ05rB4OdrVvH7rkn+TBrl3a5ea6pObl91ttXknN
         LMcCI8IhRLF9pdn0atNYr4qlgD+yuiHWxWcM/CTb6oMibIXfdwip8ZlSeYYryi71b6HW
         H5Rw==
X-Gm-Message-State: AOJu0Yxh8TIVG5qEtbM47xPjXWu0758UZYpWbd+AdOqdPmF41uTwfTod
	OhCn+av+IXHPV0L4xum1XMuuoJIPW7LmD2R/7Pz0XEx0Qz4yh0HHyNJ4Ni5Z
X-Google-Smtp-Source: AGHT+IHCvMu4Pe3bJppU23iOJDYwvcbQ7DD/NNMVSoWGtk4WWytfur5c/bhfaMYzPR5HC1C9H1Ycpj4Ow2Fc5Y15Rkg=
X-Received: by 2002:a05:6902:3c9:b0:db5:9004:cf5b with SMTP id
 g9-20020a05690203c900b00db59004cf5bmr1578144ybs.64.1704449968904; Fri, 05 Jan
 2024 02:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104173033.2836110-1-enachman@marvell.com>
In-Reply-To: <20240104173033.2836110-1-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Jan 2024 11:18:53 +0100
Message-ID: <CAPDyKFoJffGOu1cBeUi=Lg5u+MNxg6Xbp5qpjisHWM5oxXW6BA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: xenon: Add ac5 support via bounce buffer
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 18:31, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> AC5/X/IM SOCs has a variant of the Xenon eMMC controller,
> in which only 31-bit of addressing pass from the controller
> on the AXI bus.
> Since we cannot guarantee that only buffers from the first 2GB
> of memory will reach the driver, the driver is configured for
> SDMA mode, without 64-bit mode, overriding the DMA mask to 34-bit
> to support the DDR memory mapping, which starts at offset 8GB.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-xenon.c | 31 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 25ba7aecc3be..0e52867f6e91 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -18,6 +18,8 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -422,6 +424,7 @@ static int xenon_probe_params(struct platform_device *pdev)
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         u32 sdhc_id, nr_sdhc;
>         u32 tuning_count;
> +       struct sysinfo si;
>
>         /* Disable HS200 on Armada AP806 */
>         if (priv->hw_version == XENON_AP806)
> @@ -450,6 +453,23 @@ static int xenon_probe_params(struct platform_device *pdev)
>         }
>         priv->tuning_count = tuning_count;
>
> +       /*
> +        * AC5/X/IM HW has only 31-bits passed in the crossbar switch.
> +        * If we have more than 2GB of memory, this means we might pass
> +        * memory pointers which are above 2GB and which cannot be properly
> +        * represented. In this case, disable ADMA, 64-bit DMA and allow only SDMA.
> +        * This effectively will enable bounce buffer quirk in the
> +        * generic SDHCI driver, which will make sure DMA is only done
> +        * from supported memory regions:
> +        */
> +       if (priv->hw_version == XENON_AC5) {
> +               si_meminfo(&si);
> +               if (si.totalram * si.mem_unit > SZ_2G) {
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +                       host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
> +               }
> +       }
> +
>         return xenon_phy_parse_params(dev, host);
>  }
>
> @@ -562,6 +582,16 @@ static int xenon_probe(struct platform_device *pdev)
>                 goto remove_sdhc;
>
>         pm_runtime_put_autosuspend(&pdev->dev);
> +       /*
> +        * If we previously detected AC5 with over 2GB of memory,
> +        * then we disable ADMA and 64-bit DMA.
> +        * This means generic SDHCI driver has set the DMA mask to
> +        * 32-bit. Since DDR starts at 0x2_0000_0000, we must use
> +        * 34-bit DMA mask to access this DDR memory:
> +        */
> +       if (priv->hw_version == XENON_AC5 &&
> +           host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
> +               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>
>         return 0;
>
> @@ -680,6 +710,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>         { .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>         { .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>         { .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +       { .compatible = "marvell,ac5-sdhci",         .data =  (void *)XENON_AC5},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 3e9c6c908a79..0460d97aad26 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -57,7 +57,8 @@ enum xenon_variant {
>         XENON_A3700,
>         XENON_AP806,
>         XENON_AP807,
> -       XENON_CP110
> +       XENON_CP110,
> +       XENON_AC5
>  };
>
>  struct xenon_priv {
> --
> 2.25.1
>

