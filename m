Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00473181C6E
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgCKPfS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Mar 2020 11:35:18 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43885 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgCKPfR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 11:35:17 -0400
Received: by mail-vk1-f195.google.com with SMTP id t3so640990vkm.10
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44KMhJHWm8HZn3OxGvi82dZNfs9ed2LpZdiM7LdpP/Y=;
        b=VPPIlhV3Af2X+JuRVM1wrhOFW3BuR87y+SfDe+sg4rTNkuDJL02wgw5a96Vtcg4AP8
         2sryc0lZrN0wiaWVeBKRU0h2IuNoFIoBdBN/c2ZxqfpcVTj3QtONeBmk7dFo/K32qPh0
         lPQodtTyBk7qGA0neWHyPWREzx9wWetbqu5sTNrZmapw88PSuUthTqb0q87gL9z9dZx7
         PwLdfmNcvfmB3lH7I6BbtQ0vEnG+mrLbOc8xGgOdFYMsbQ6EeMQ5xR8YbdP3KTpiuLpQ
         2XNaiqg7+zxt7iRgu/pKBy90kRGUbNtLNyGYHD02Z4Yu53C98MnU9vtD/pRuR/YYOyR4
         ARdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44KMhJHWm8HZn3OxGvi82dZNfs9ed2LpZdiM7LdpP/Y=;
        b=KZRNS9gH1XUqCXlQW3mxpnnTuFTjem4d5/KA0LoiC3BpLeP9EGTnM+0ZbOfFDd5i6h
         UodSse4v2yc1+v98jOou2wSe9zKohqQu3SMABATvI+gxm0b3idUfa37Ewqst5QJpVGm5
         TdJV194OKSruDGxXT/tUzma7FgeEA5usy8i1ai82LEC1mxZTrSY5/laz6g2+C+TnoS0i
         NG6DgLwj2r+PBOM3I2OF4UJeoMmtufa0VJUhflaPcsa4GQe1AxaEKsoT75DMzncc4vXw
         k8UtVKVw5uafq4rkEwBkbYKGND1Z1wCrSYDeVfrQfxpHl5PaCGbGeMRCHYB2tpT7BOJ9
         SjEQ==
X-Gm-Message-State: ANhLgQ30Jzp6pYLNblazvzlh7Z/Wnq05stfbbJ1zj6J7/pWMRaHtqrHA
        wriRuE0+88CNdRfKpXN6Xed7ThwxMwALDAGolvdlyw==
X-Google-Smtp-Source: ADFU+vuh8H/6ItX+lmltncMiOZy1e8lV20DlYIwXecECEf4+QeuEY3mWGDBOB7VJvWftDS8S+POR92TGfS5nFTchfuA=
X-Received: by 2002:a1f:b695:: with SMTP id g143mr2366350vkf.59.1583940916897;
 Wed, 11 Mar 2020 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200305151228.24692-1-faiz_abbas@ti.com>
In-Reply-To: <20200305151228.24692-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 16:34:40 +0100
Message-ID: <CAPDyKFrRcCzLs=Oab_ct_1yLkfCAT9mB4exT3er-UyFUKK_ePw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-omap: Add Support for Suspend/Resume
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Mar 2020 at 16:10, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add power management ops which save and restore the driver context and
> facilitate a system suspend and resume.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
> 1. Save and restore only those registers which are not written to by
>    core
> 2. Use force_suspend()/resume() APIs instead of runtime_resume()/suspend()
>    as the driver has no runtime PM support.
>  drivers/mmc/host/sdhci-omap.c | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 882053151a47..989133ec74d6 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -108,6 +108,11 @@ struct sdhci_omap_host {
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    **pinctrl_state;
>         bool                    is_tuning;
> +       /* Omap specific context save */
> +       u32                     con;
> +       u32                     hctl;
> +       u32                     sysctl;
> +       u32                     capa;
>  };
>
>  static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
> @@ -1232,12 +1237,64 @@ static int sdhci_omap_remove(struct platform_device *pdev)
>
>         return 0;
>  }
> +#ifdef CONFIG_PM_SLEEP
> +static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
> +{
> +       omap_host->con = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +       omap_host->hctl = sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL);
> +       omap_host->capa = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA);
> +}
> +
> +static void sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
> +{
> +       sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, omap_host->con);
> +       sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, omap_host->hctl);
> +       sdhci_omap_writel(omap_host, SDHCI_OMAP_CAPA, omap_host->capa);
> +}
> +
> +static int __maybe_unused sdhci_omap_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       sdhci_suspend_host(host);
> +
> +       sdhci_omap_context_save(omap_host);
> +
> +       pinctrl_pm_select_idle_state(dev);
> +
> +       pm_runtime_force_suspend(dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused sdhci_omap_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       pm_runtime_force_resume(dev);
> +
> +       pinctrl_pm_select_default_state(dev);
> +
> +       sdhci_omap_context_restore(omap_host);
> +
> +       sdhci_resume_host(host);
> +
> +       return 0;
> +}
> +#endif
> +static SIMPLE_DEV_PM_OPS(sdhci_omap_dev_pm_ops, sdhci_omap_suspend,
> +                        sdhci_omap_resume);
>
>  static struct platform_driver sdhci_omap_driver = {
>         .probe = sdhci_omap_probe,
>         .remove = sdhci_omap_remove,
>         .driver = {
>                    .name = "sdhci-omap",
> +                  .pm = &sdhci_omap_dev_pm_ops,
>                    .of_match_table = omap_sdhci_match,
>                   },
>  };
> --
> 2.19.2
>
