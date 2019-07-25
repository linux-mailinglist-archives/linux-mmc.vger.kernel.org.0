Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6174F37
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Jul 2019 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfGYNXw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 09:23:52 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41913 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfGYNXv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 09:23:51 -0400
Received: by mail-ua1-f68.google.com with SMTP id 34so19843102uar.8
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FO+uLJoSuAxi+43r+XChAV6bGShjC1QQJr5a1Z10WA4=;
        b=SAUoMUsSsOPwFEbODyYvbm0qMvAsZOalIvn8b5uw+acudLMMu9vygqpFvYjIJ7v7I9
         DEfkoFimLuT9tH2qezkGjWP6KTnG6GK5CZNqoSP/6zUJMPIABBvtn9MlIPSI+5ccr3aZ
         qEWB67oXNmMAOoPhko2gALVxZmmVMN0tygy080v6i5iHSMtnIJqCtp2YJPdrTY7uMGvQ
         N53GfmIT+PdqasYZGMRI9R/s3QzGqObJm1QjeVCHced1Ly4fbVz8rheZdQzRNvkfxCXK
         vrenlO6gbMi9+RLGXQSoM57X3UZsFZYpUEMYlTcichzx5w/aRtwqTcCPoTfHPz6iK/6w
         znzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO+uLJoSuAxi+43r+XChAV6bGShjC1QQJr5a1Z10WA4=;
        b=i6DTbmDQSivie1Po/5Ms/0bBBlUryaStFMiGM1d7iJ+KpGvkeLK5EEZlU7TFodHqYu
         C3dF+iFIQ7wBoOdonZRciJmGDrGnCriZVzYRnfUHBmfmYy66WYAH05dFHKmD3R0QxeLA
         KPVDCXcyxdToZy8lzbBfihCL2CSqZbomUqd38eCRSLwr9L78fErAdOo/yU+m7pK9SQDy
         6iEqrRvJcqxOsrzyE82ekyZ5veJUMgyq7P4jHVNBwSP5vwdeTLk6iB/o8VpXrX6P1wQM
         UNWrsT5c0kDe3rU7KYEqQlJBLPrrDtgP/ypXf/EcEuvDBhWiXcKmLxIZzjlU9/D9PWWK
         pA0w==
X-Gm-Message-State: APjAAAWXKaIVfBSSNsB5D/pOf2q0YGUyyJ29hhxeKV1bZYtO5/HgRyrA
        e2t93JOny2ZlUCvT25DKX1g9thjNXycBToR+kNJUmg==
X-Google-Smtp-Source: APXvYqzaDFTzSxZuWbXn/auySeCIUcUcxXajq3YH1eaAMunNEBK04WM5xvy21BN7eG0KHX0O/0i+oo6dN036NrOJmUE=
X-Received: by 2002:ab0:5973:: with SMTP id o48mr45127023uad.19.1564060529602;
 Thu, 25 Jul 2019 06:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
In-Reply-To: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:14:53 +0200
Message-ID: <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: host: sdhci: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- Trimmed cc list

On Thu, 25 Jul 2019 at 05:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> The SD host controller specification defines 3 types software reset:
> software reset for data line, software reset for command line and
> software reset for all. Software reset for all means this reset affects
> the entire Host controller except for the card detection circuit.
>
> In sdhci_runtime_resume_host() function, now we will always do software
> reset for all, which will cause Spreadtrum host controller work abnormally
> after resuming. For Spreadtrum platform that will not power down the SD/eMMC
> card during runtime suspend, we should just do software reset for data
> and command instead doing reset for all.
>
> To fix this issue, this patch introduces a new parameter of
> sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
> be done or not. Meanwhile changes other host drivers to issue a software
> reset for all to keep the original logic.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied for next, with a little change (renaming the "soft"
in-parameter to soft_reset), thanks!

Adrian, if there is anything you want to change, please tell.

BTW, perhaps this should be applied for fixes and tagged for stable?
Baolin, if so, can point me the commit (or stable tag) the patch
fixes?

Kind regards
Uffe



> ---
> Changes from v4:
>  - Update the commit message.
>  - Add a new parameter to decide if a 'reset for all' shall be done or not.
>
> Changes from v3:
>  - Use ios.power_mode to validate if the card is power down or not.
>
> Changes from v2:
>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
>
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-acpi.c      |    2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
>  drivers/mmc/host/sdhci-of-at91.c   |    2 +-
>  drivers/mmc/host/sdhci-pci-core.c  |    4 ++--
>  drivers/mmc/host/sdhci-pxav3.c     |    2 +-
>  drivers/mmc/host/sdhci-s3c.c       |    2 +-
>  drivers/mmc/host/sdhci-sprd.c      |    2 +-
>  drivers/mmc/host/sdhci-xenon.c     |    2 +-
>  drivers/mmc/host/sdhci.c           |    4 ++--
>  drivers/mmc/host/sdhci.h           |    2 +-
>  10 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b3a130a..1604f51 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -883,7 +883,7 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>
>         sdhci_acpi_byt_setting(&c->pdev->dev);
>
> -       return sdhci_runtime_resume_host(c->host);
> +       return sdhci_runtime_resume_host(c->host, 0);
>  }
>
>  #endif
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c391510..776a942 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1705,7 +1705,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>                 esdhc_pltfm_set_clock(host, imx_data->actual_clock);
>         }
>
> -       err = sdhci_runtime_resume_host(host);
> +       err = sdhci_runtime_resume_host(host, 0);
>         if (err)
>                 goto disable_ipg_clk;
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index e377b9b..d4e7e8b 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -289,7 +289,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>         }
>
>  out:
> -       return sdhci_runtime_resume_host(host);
> +       return sdhci_runtime_resume_host(host, 0);
>  }
>  #endif /* CONFIG_PM */
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4041878..7d06e28 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -167,7 +167,7 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
>
>  err_pci_runtime_suspend:
>         while (--i >= 0)
> -               sdhci_runtime_resume_host(chip->slots[i]->host);
> +               sdhci_runtime_resume_host(chip->slots[i]->host, 0);
>         return ret;
>  }
>
> @@ -181,7 +181,7 @@ static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
>                 if (!slot)
>                         continue;
>
> -               ret = sdhci_runtime_resume_host(slot->host);
> +               ret = sdhci_runtime_resume_host(slot->host, 0);
>                 if (ret)
>                         return ret;
>         }
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3ddecf4..e55037c 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -554,7 +554,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>         if (!IS_ERR(pxa->clk_core))
>                 clk_prepare_enable(pxa->clk_core);
>
> -       return sdhci_runtime_resume_host(host);
> +       return sdhci_runtime_resume_host(host, 0);
>  }
>  #endif
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e4a8ba..f5753ae 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -745,7 +745,7 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
>         clk_prepare_enable(busclk);
>         if (ourhost->cur_clk >= 0)
>                 clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
> -       ret = sdhci_runtime_resume_host(host);
> +       ret = sdhci_runtime_resume_host(host, 0);
>         return ret;
>  }
>  #endif
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..83a4767 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -696,7 +696,7 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
>         if (ret)
>                 goto clk_disable;
>
> -       sdhci_runtime_resume_host(host);
> +       sdhci_runtime_resume_host(host, 1);
>         return 0;
>
>  clk_disable:
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 8a18f14..1dea1ba 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -638,7 +638,7 @@ static int xenon_runtime_resume(struct device *dev)
>                 priv->restore_needed = false;
>         }
>
> -       ret = sdhci_runtime_resume_host(host);
> +       ret = sdhci_runtime_resume_host(host, 0);
>         if (ret)
>                 goto out;
>         return 0;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e..4e9ebc8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3320,7 +3320,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
>
> -int sdhci_runtime_resume_host(struct sdhci_host *host)
> +int sdhci_runtime_resume_host(struct sdhci_host *host, int soft)
>  {
>         struct mmc_host *mmc = host->mmc;
>         unsigned long flags;
> @@ -3331,7 +3331,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>                         host->ops->enable_dma(host);
>         }
>
> -       sdhci_init(host, 0);
> +       sdhci_init(host, soft);
>
>         if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
>             mmc->ios.power_mode != MMC_POWER_OFF) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 89fd965..f3cd516 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -781,7 +781,7 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
>  int sdhci_runtime_suspend_host(struct sdhci_host *host);
> -int sdhci_runtime_resume_host(struct sdhci_host *host);
> +int sdhci_runtime_resume_host(struct sdhci_host *host, int soft);
>  #endif
>
>  void sdhci_cqe_enable(struct mmc_host *mmc);
> --
> 1.7.9.5
>
