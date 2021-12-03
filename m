Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B776E467958
	for <lists+linux-mmc@lfdr.de>; Fri,  3 Dec 2021 15:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381446AbhLCOYV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 Dec 2021 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381443AbhLCOYT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 09:24:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B3DC08EB3F
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 06:20:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bi37so6914382lfb.5
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 06:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUVfmGkmovK3X5bCVt5XzBdso2e0uiUNFVnOWF+L4EQ=;
        b=Yxh3xRGIbUv7iK8YCpl5ysViE8bOC72I3Z6twzEy7G0dfA+cDGlEXD0ey7VSCdWsdr
         we65wQQloEuYimxwWIM+dDUzsCkmVEY275Neum+kUgg0SKjfmTwyx8X+muiRtYm9SwOI
         JQgrZGF3LG4NZSdpJcwlBWfhsrT0pmkcZJ5dlQsEE105ovuVfq/QT8ROrGvfwiiBJo6x
         IcsVZMjrtgC/c2O/K3u0EWX0UKK70/+Q/cKR3da5/kvWuKFdsIWzRe/rmRAsMwkWpLjx
         OLjjcC3UsLoSgSbg8A8UrMiGcGaj7+YXVSIRfDZUE6LGELuMWCrSwr4mOtHzhAxlbtzC
         Wm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUVfmGkmovK3X5bCVt5XzBdso2e0uiUNFVnOWF+L4EQ=;
        b=AX0uxi1KJEn4tVMZkWFZSMsmS92OcfxGMBII5S4tX4Tn6t/zogF0ocbj2t4qfuJbUX
         I/91Fk+dDJUABoSTzCWvGMxONyjOF5EaI1+vepa4a4GyqqSDeSqP+bxBFMlJsUdxgj+U
         dJgb2ekcQMUvdv/ICySvEPk6VWexAOvhgN3Y21mSMI0YJ5/o6RjcstA/UfjMylPpu6ti
         VIsBFMdr3rjTAGjcQv7ESgdLVcMULtY2/8eT5hi7o2u8YZVykiPNobh3TMgYJr82N11q
         dXV/dYM/CEiedB0sNZZwZtyidHCe6pQbOHOpFepg+DexhknPmMCWpIIt9fTEzLJ1ODet
         tACA==
X-Gm-Message-State: AOAM53134T711y4oWvg7bHHBB2upb/6v0DlAeGV1eGhNwdFA/JBihby0
        OEN7AQwfxwhnxH0+ugHeCFPazqM4LR5fmNt+BFTo326eCSA=
X-Google-Smtp-Source: ABdhPJwujTHmyhdnomzns1uoMe33veob2nJSNPHMBv9qJU29yuIEh6upOdPHqEPNNaZN5kPY/q/33zUhOyc63pcR408=
X-Received: by 2002:a05:6512:3e04:: with SMTP id i4mr18723869lfv.167.1638541252916;
 Fri, 03 Dec 2021 06:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20211203141555.105351-1-ulf.hansson@linaro.org>
In-Reply-To: <20211203141555.105351-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Dec 2021 15:20:16 +0100
Message-ID: <CAPDyKFqGSq=OMd_0N=okQk12Tiy=eyW+S26=tSx8r4poSStdcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Disable card detect during shutdown
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Dec 2021 at 15:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's seems prone to problems by allowing card detect and its corresponding
> mmc_rescan() work to run, during platform shutdown. For example, we may end
> up turning off the power while initializing a card, which potentially could
> damage it.
>
> To avoid this scenario, let's add ->shutdown_pre() callback for the mmc host
> class device and then turn of the card detect from there.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Sorry, I was intending to make this a "Reported-by:" tag.

And I should have added Adrian's suggested-by tag too. Sorry.

> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c | 7 ++++++-
>  drivers/mmc/core/core.h | 1 +
>  drivers/mmc/core/host.c | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 240c5af793dc..368f10405e13 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2264,7 +2264,7 @@ void mmc_start_host(struct mmc_host *host)
>         _mmc_detect_change(host, 0, false);
>  }
>
> -void mmc_stop_host(struct mmc_host *host)
> +void __mmc_stop_host(struct mmc_host *host)
>  {
>         if (host->slot.cd_irq >= 0) {
>                 mmc_gpio_set_cd_wake(host, false);
> @@ -2273,6 +2273,11 @@ void mmc_stop_host(struct mmc_host *host)
>
>         host->rescan_disable = 1;
>         cancel_delayed_work_sync(&host->detect);
> +}
> +
> +void mmc_stop_host(struct mmc_host *host)
> +{
> +       __mmc_stop_host(host);
>
>         /* clear pm flags now and let card drivers set them as needed */
>         host->pm_flags = 0;
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 7931a4f0137d..f5f3f623ea49 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -70,6 +70,7 @@ static inline void mmc_delay(unsigned int ms)
>
>  void mmc_rescan(struct work_struct *work);
>  void mmc_start_host(struct mmc_host *host);
> +void __mmc_stop_host(struct mmc_host *host);
>  void mmc_stop_host(struct mmc_host *host);
>
>  void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d4683b1d263f..cf140f4ec864 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -80,9 +80,18 @@ static void mmc_host_classdev_release(struct device *dev)
>         kfree(host);
>  }
>
> +static int mmc_host_classdev_shutdown(struct device *dev)
> +{
> +       struct mmc_host *host = cls_dev_to_mmc_host(dev);
> +
> +       __mmc_stop_host(host);
> +       return 0;
> +}
> +
>  static struct class mmc_host_class = {
>         .name           = "mmc_host",
>         .dev_release    = mmc_host_classdev_release,
> +       .shutdown_pre   = mmc_host_classdev_shutdown,
>         .pm             = MMC_HOST_CLASS_DEV_PM_OPS,
>  };
>
> --
> 2.25.1
>
