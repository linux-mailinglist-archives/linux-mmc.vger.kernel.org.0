Return-Path: <linux-mmc+bounces-69-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9CD7EB56F
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Nov 2023 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D7CB20B25
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Nov 2023 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5041773;
	Tue, 14 Nov 2023 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sO9ZW6H2"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651E4123E
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 17:18:49 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB911D
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 09:18:47 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5ac376d311aso65353357b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699982326; x=1700587126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FH+bInT8O5yMFpdha7RjrbDTQ4OS2P/m2kPMDCH48QU=;
        b=sO9ZW6H2AHekzSgvYFXB6/4Ld1FOUG5aVMKAOmFB2uA5m6uMw/2vFNb+gaHYF94ngl
         qoZ6GSeFW6ZjCRXmvbq3swyoFMCxAyUIgMiwvWP6sUFlV+Rl2yWO5x8ZZIQGJwHn8hiD
         EE2Y8usM3KvbzEyKJhTM3/f++6Gosh4mj9a0N6hXCqsfUWQW7yW5EVNkGo9KLr0mLAxB
         P3ubZ0UWaiR3M8vfyAgJ43R4v2wAbOqAXNC11dkiuMqcOpmtNtFcStACV96ICy/WmBpQ
         oZ4eLP43XDn2HAmrKl8lyOvsvAfqau6NDZurw+zhD1GMmXF1j5kO+nANi5EVjUi6oSmx
         x0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982326; x=1700587126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH+bInT8O5yMFpdha7RjrbDTQ4OS2P/m2kPMDCH48QU=;
        b=w4mIzUIeexjFsv0hbpCf+WUW90i0JnLuYYYwHcPMoEtuby88cwstx9L+6CMru+6ftO
         T9Lyambg4h5DXYS8FhpsJbIW+xy+N9s0OwQo4/kvernARWZpi84lMp/AFjHFP7sPvxDz
         DFuRNiPaT7MydJECvh+CeQF0bD/HejwQvF5FZThZUUtTLwW1t6B5ykl0iJomrQGry43t
         s1vzcskD44Gj6PEAL2Iqve0twKmfVCBNBLPX7Fb+9t7seHPfUN7qI9HLWg1gEmz9ED5B
         QvHiNHSJpJ7lij/mYGdJuORd0QetaQwC7tYfq/w5vmva9u4hd7kJW+TKHRNkNCMi+Ip3
         hxpQ==
X-Gm-Message-State: AOJu0YwapFzH6pGGF8XP/feMw2TyovwCmG6JUDTRlwkgQeibb5Oc8xq2
	kgE38zptxppSZDuAjTHwXv/pNsOO9Z91ahyo6oq8Tg==
X-Google-Smtp-Source: AGHT+IFvK/BC/Lg7Pj0tI79a4YZFYbIAnLiUk+iVYQYhGlp7qy4A+W98Ty5NFIgZq1nh9Wbbu/KCNHe21JQ80hwEkJs=
X-Received: by 2002:a0d:e2c7:0:b0:5ad:47ba:fa3a with SMTP id
 l190-20020a0de2c7000000b005ad47bafa3amr10518169ywe.43.1699982326635; Tue, 14
 Nov 2023 09:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109063718.316-1-wenchao.chen@unisoc.com>
In-Reply-To: <20231109063718.316-1-wenchao.chen@unisoc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 14 Nov 2023 18:18:10 +0100
Message-ID: <CAPDyKFpMACAn2iSbmU8oxwhSu+yKEkP7qvh0hiMZSq1CAf44rg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sprd: Fix vqmmc not shutting down after the card was pulled
To: Wenchao Chen <wenchao.chen@unisoc.com>
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 07:37, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> With cat regulator_summary, we found that vqmmc was not shutting
> down after the card was pulled.
>
> cat /sys/kernel/debug/regulator/regulator_summary
> 1.before fix
> 1)Insert SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2.after fix
> 1)Insert SD cardt
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                0    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 62 +++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6b84ba27e6ab..b5f22e48e571 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -90,6 +90,7 @@ struct sdhci_sprd_host {
>         u32 base_rate;
>         int flags; /* backup of host attribute */
>         u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> +       u8 power_mode;
>  };
>
>  enum sdhci_sprd_tuning_type {
> @@ -416,12 +417,71 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>         mmc_request_done(host->mmc, mrq);
>  }
>
> +static void sdhci_sprd_signal_voltage_switch(struct sdhci_host *host, bool enable)
> +{
> +       const char *name = mmc_hostname(host->mmc);
> +       bool on;
> +
> +       if (IS_ERR(host->mmc->supply.vqmmc))
> +               return;
> +
> +       on = regulator_is_enabled(host->mmc->supply.vqmmc);
> +       if (!(on ^ enable))
> +               return;
> +
> +       if (enable) {
> +               if (regulator_enable(host->mmc->supply.vqmmc))
> +                       pr_err("%s: signal voltage enable fail!\n", name);
> +               else if (regulator_is_enabled(host->mmc->supply.vqmmc))
> +                       pr_debug("%s: signal voltage enable success!\n", name);
> +               else
> +                       pr_err("%s: signal voltage enable hw fail!\n", name);
> +       } else {
> +               if (regulator_disable(host->mmc->supply.vqmmc))
> +                       pr_err("%s: signal voltage disable fail\n", name);
> +               else if (!regulator_is_enabled(host->mmc->supply.vqmmc))
> +                       pr_debug("%s: signal voltage disable success!\n", name);
> +               else
> +                       pr_err("%s: signal voltage disable hw fail\n", name);
> +       }

This looks rather noisy to me.

How about converting into using mmc_regulator_enable|disable_vqmmc()
instead - and then simply drop the entire function above.

> +}
> +
> +static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
> +                                unsigned short vdd)
> +{
> +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +       struct mmc_host *mmc = host->mmc;
> +
> +       if (sprd_host->power_mode == mmc->ios.power_mode)
> +               return;
> +
> +       switch (mode) {
> +       case MMC_POWER_OFF:
> +               sdhci_sprd_signal_voltage_switch(host, false);
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
> +               break;
> +       case MMC_POWER_ON:
> +       case MMC_POWER_UP:

This means that a usleep_range() below is being executed for both
MMC_POWER_ON and MMC_POWER_UP, even if we actually didn't change the
regulators. I assume that isn't needed and nor the intent, right?

> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
> +
> +               /* waiting for mmc->supply.vmmc to stabilize */
> +               usleep_range(200, 250);
> +               sdhci_sprd_signal_voltage_switch(host, true);
> +               break;
> +       }
> +
> +       sprd_host->power_mode = mmc->ios.power_mode;

If we convert to use the helper functions
mmc_regulator_enable|disable_vqmmc(), you shouldn't need to use
sprd_host->power_mode, as that is already taken care of by the
helpers.

> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
>         .write_w = sdhci_sprd_writew,
>         .write_b = sdhci_sprd_writeb,
>         .set_clock = sdhci_sprd_set_clock,
> +       .set_power = sdhci_sprd_set_power,
>         .get_max_clock = sdhci_sprd_get_max_clock,
>         .get_min_clock = sdhci_sprd_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
> @@ -805,6 +865,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
>                                SDHCI_VENDOR_VER_SHIFT);
>
> +       sprd_host->power_mode = MMC_POWER_OFF;
> +
>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);

Kind regards
Uffe

