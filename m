Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A072D045
	for <lists+linux-mmc@lfdr.de>; Mon, 12 Jun 2023 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjFLUO4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 12 Jun 2023 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjFLUOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 16:14:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35781709
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 13:14:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b01d3bb571so25933595ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686600858; x=1689192858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMwtLSPPIrklGoAl5TC0+o5d5Wch+eMvHeWIXVxQc4=;
        b=a2k6r5pUro5yFPYxWWgRD+oVk/vCTJmL1dV549CZV3PUa0Fk4Oqm35wL+vZpbM4wNy
         6CAv6IRrEfeNjXm/fQogJv9a3sVyyvBhmOQ7ZbMETWLCn445Wfm3I42Jfymi+YsIMNSt
         Kkbzlw7brV2B2DVCWSeKGfG6i1id18aj7T/Em+2bKAX+0HBEhcxqcey/fickg3UGkCKs
         sfBRcTpvihAMp/5f+P+7bipCIC8EvEUptiqxWjPxIiI+LuzkEjn6W2RcAsCEse7Jbziq
         y16CpCEGSHNoPUpXSyrNol0eDJScQoHEtfJ08vCRCjmS/r1toOfkmIwCsrUqQYKj/LX+
         ZhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600858; x=1689192858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZMwtLSPPIrklGoAl5TC0+o5d5Wch+eMvHeWIXVxQc4=;
        b=cRwA0dBh6tj3V0wRQuwtfJZGezZnW2qOeiodLLkUOf4/qa2EGjSTQZwWSE1z2yd+AW
         9Ms3bz2W4V42Ilh+1JyDbs+qp+3NRotz8LnV7l61P+j6eJsklhbUXE+xH/Lwdjhqz44U
         nLg4kW1dknJBOm44Y9kJa0PtQa2tAQdr9B164YbDblTfFuFlGfOfO5/hEOwcz9tjUkpZ
         UL2F+gqMIvTVel5KfldjX14qyiZNwOa/rxPUfeYtUquqpLWIE/03WsH5QFtjJjR+7LQ7
         RQjXPvx7tbBxfV9s/zPmhUBRSdddRodu5cLwZ9hpplNSrKeW3Aytoms04ZHWUSxqHBSZ
         /Inw==
X-Gm-Message-State: AC+VfDy5wDt/OdSXaESXQcGCFlaG43N2dOoEqUp0P1NagAAXpoG/Ry1x
        FMiV3d32xtY1I24N4xRiWD1V3z5Q+eRN7Up/Oza9XQ==
X-Google-Smtp-Source: ACHHUZ66JGHwF2ovcR9Xc7ThTz21Oj65Z2kDgsy+tLGKlHDGdHtpvcsf7WU3B4T4tGjTF9jKXcUtSJzdaJZ+rPw89P0=
X-Received: by 2002:a17:902:e543:b0:1af:d19a:a67b with SMTP id
 n3-20020a170902e54300b001afd19aa67bmr8959396plf.33.1686600858016; Mon, 12 Jun
 2023 13:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230612192847.1599416-1-abel.vesa@linaro.org> <20230612192847.1599416-4-abel.vesa@linaro.org>
In-Reply-To: <20230612192847.1599416-4-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 22:13:41 +0200
Message-ID: <CAPDyKFo_3WF=vgo7cM4-ZiWF4CA7o7vHRdDyiZ5X3xEihVgbLg@mail.gmail.com>
Subject: Re: [RESEND v7 3/3] mmc: sdhci-msm: Switch to the new ICE API
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Jun 2023 at 21:28, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Now that there is a new dedicated ICE driver, drop the sdhci-msm ICE
> implementation and use the new ICE api provided by the Qualcomm soc
> driver ice. The platforms that already have ICE support will use the
> API as library since there will not be a devicetree node, but instead
> they have reg range. In this case, the of_qcom_ice_get will return an
> ICE instance created for the consumer's device. But if there are
> platforms that do not have ice reg in the consumer devicetree node
> and instead provide a dedicated ICE devicetree node, theof_qcom_ice_get
> will look up the device based on qcom,ice property and will get the ICE
> instance registered by the probe function of the ice driver.
>
> The ICE clock is now handle by the new driver. This is done by enabling
> it on the creation of the ICE instance and then enabling/disabling it on
> SDCC runtime resume/suspend.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

This should already be applied at my mmc tree earlier today, but
thanks for re-sending.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig     |   2 +-
>  drivers/mmc/host/sdhci-msm.c | 223 ++++++++---------------------------
>  2 files changed, 48 insertions(+), 177 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9f793892123c..159a3e9490ae 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -550,7 +550,7 @@ config MMC_SDHCI_MSM
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
> -       select QCOM_SCM if MMC_CRYPTO
> +       select QCOM_INLINE_CRYPTO_ENGINE if MMC_CRYPTO
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in Qualcomm SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 1877d583fe8c..1c935b5bafe1 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -13,12 +13,13 @@
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/iopoll.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>
> +#include <soc/qcom/ice.h>
> +
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -258,12 +259,14 @@ struct sdhci_msm_variant_info {
>  struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
> -       void __iomem *ice_mem;  /* MSM ICE mapped address (if available) */
>         int pwr_irq;            /* power irq */
>         struct clk *bus_clk;    /* SDHC bus voter clock */
>         struct clk *xo_clk;     /* TCXO clk needed for FLL feature of cm_dll*/
> -       /* core, iface, cal, sleep, and ice clocks */
> -       struct clk_bulk_data bulk_clks[5];
> +       /* core, iface, cal and sleep clocks */
> +       struct clk_bulk_data bulk_clks[4];
> +#ifdef CONFIG_MMC_CRYPTO
> +       struct qcom_ice *ice;
> +#endif
>         unsigned long clk_rate;
>         struct mmc_host *mmc;
>         bool use_14lpp_dll_reset;
> @@ -1804,164 +1807,51 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>
>  #ifdef CONFIG_MMC_CRYPTO
>
> -#define AES_256_XTS_KEY_SIZE                   64
> -
> -/* QCOM ICE registers */
> -
> -#define QCOM_ICE_REG_VERSION                   0x0008
> -
> -#define QCOM_ICE_REG_FUSE_SETTING              0x0010
> -#define QCOM_ICE_FUSE_SETTING_MASK             0x1
> -#define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK    0x2
> -#define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK    0x4
> -
> -#define QCOM_ICE_REG_BIST_STATUS               0x0070
> -#define QCOM_ICE_BIST_STATUS_MASK              0xF0000000
> -
> -#define QCOM_ICE_REG_ADVANCED_CONTROL          0x1000
> -
> -#define sdhci_msm_ice_writel(host, val, reg)   \
> -       writel((val), (host)->ice_mem + (reg))
> -#define sdhci_msm_ice_readl(host, reg) \
> -       readl((host)->ice_mem + (reg))
> -
> -static bool sdhci_msm_ice_supported(struct sdhci_msm_host *msm_host)
> -{
> -       struct device *dev = mmc_dev(msm_host->mmc);
> -       u32 regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_VERSION);
> -       int major = regval >> 24;
> -       int minor = (regval >> 16) & 0xFF;
> -       int step = regval & 0xFFFF;
> -
> -       /* For now this driver only supports ICE version 3. */
> -       if (major != 3) {
> -               dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> -                        major, minor, step);
> -               return false;
> -       }
> -
> -       dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> -                major, minor, step);
> -
> -       /* If fuses are blown, ICE might not work in the standard way. */
> -       regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_FUSE_SETTING);
> -       if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> -                     QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> -                     QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> -               dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> -               return false;
> -       }
> -       return true;
> -}
> -
> -static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
> -{
> -       return devm_clk_get(dev, "ice");
> -}
> -
>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>                               struct cqhci_host *cq_host)
>  {
>         struct mmc_host *mmc = msm_host->mmc;
>         struct device *dev = mmc_dev(mmc);
> -       struct resource *res;
> +       struct qcom_ice *ice;
>
>         if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>                 return 0;
>
> -       res = platform_get_resource_byname(msm_host->pdev, IORESOURCE_MEM,
> -                                          "ice");
> -       if (!res) {
> -               dev_warn(dev, "ICE registers not found\n");
> -               goto disable;
> -       }
> -
> -       if (!qcom_scm_ice_available()) {
> -               dev_warn(dev, "ICE SCM interface not found\n");
> -               goto disable;
> +       ice = of_qcom_ice_get(dev);
> +       if (ice == ERR_PTR(-EOPNOTSUPP)) {
> +               dev_warn(dev, "Disabling inline encryption support\n");
> +               ice = NULL;
>         }
>
> -       msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(msm_host->ice_mem))
> -               return PTR_ERR(msm_host->ice_mem);
> -
> -       if (!sdhci_msm_ice_supported(msm_host))
> -               goto disable;
> +       if (IS_ERR_OR_NULL(ice))
> +               return PTR_ERR_OR_ZERO(ice);
>
> +       msm_host->ice = ice;
>         mmc->caps2 |= MMC_CAP2_CRYPTO;
> -       return 0;
>
> -disable:
> -       dev_warn(dev, "Disabling inline encryption support\n");
>         return 0;
>  }
>
> -static void sdhci_msm_ice_low_power_mode_enable(struct sdhci_msm_host *msm_host)
> -{
> -       u32 regval;
> -
> -       regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
> -       /*
> -        * Enable low power mode sequence
> -        * [0]-0, [1]-0, [2]-0, [3]-E, [4]-0, [5]-0, [6]-0, [7]-0
> -        */
> -       regval |= 0x7000;
> -       sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> -}
> -
> -static void sdhci_msm_ice_optimization_enable(struct sdhci_msm_host *msm_host)
> +static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
>  {
> -       u32 regval;
> -
> -       /* ICE Optimizations Enable Sequence */
> -       regval = sdhci_msm_ice_readl(msm_host, QCOM_ICE_REG_ADVANCED_CONTROL);
> -       regval |= 0xD807100;
> -       /* ICE HPG requires delay before writing */
> -       udelay(5);
> -       sdhci_msm_ice_writel(msm_host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
> -       udelay(5);
> +       if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +               qcom_ice_enable(msm_host->ice);
>  }
>
> -/*
> - * Wait until the ICE BIST (built-in self-test) has completed.
> - *
> - * This may be necessary before ICE can be used.
> - *
> - * Note that we don't really care whether the BIST passed or failed; we really
> - * just want to make sure that it isn't still running.  This is because (a) the
> - * BIST is a FIPS compliance thing that never fails in practice, (b) ICE is
> - * documented to reject crypto requests if the BIST fails, so we needn't do it
> - * in software too, and (c) properly testing storage encryption requires testing
> - * the full storage stack anyway, and not relying on hardware-level self-tests.
> - */
> -static int sdhci_msm_ice_wait_bist_status(struct sdhci_msm_host *msm_host)
> +static __maybe_unused int sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
>  {
> -       u32 regval;
> -       int err;
> +       if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +               return qcom_ice_resume(msm_host->ice);
>
> -       err = readl_poll_timeout(msm_host->ice_mem + QCOM_ICE_REG_BIST_STATUS,
> -                                regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
> -                                50, 5000);
> -       if (err)
> -               dev_err(mmc_dev(msm_host->mmc),
> -                       "Timed out waiting for ICE self-test to complete\n");
> -       return err;
> +       return 0;
>  }
>
> -static void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
> +static __maybe_unused int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
>  {
> -       if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
> -               return;
> -       sdhci_msm_ice_low_power_mode_enable(msm_host);
> -       sdhci_msm_ice_optimization_enable(msm_host);
> -       sdhci_msm_ice_wait_bist_status(msm_host);
> -}
> +       if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +               return qcom_ice_suspend(msm_host->ice);
>
> -static int __maybe_unused sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
> -{
> -       if (!(msm_host->mmc->caps2 & MMC_CAP2_CRYPTO))
> -               return 0;
> -       return sdhci_msm_ice_wait_bist_status(msm_host);
> +       return 0;
>  }
>
>  /*
> @@ -1972,48 +1862,28 @@ static int sdhci_msm_program_key(struct cqhci_host *cq_host,
>                                  const union cqhci_crypto_cfg_entry *cfg,
>                                  int slot)
>  {
> -       struct device *dev = mmc_dev(cq_host->mmc);
> +       struct sdhci_host *host = mmc_priv(cq_host->mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         union cqhci_crypto_cap_entry cap;
> -       union {
> -               u8 bytes[AES_256_XTS_KEY_SIZE];
> -               u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> -       } key;
> -       int i;
> -       int err;
> -
> -       if (!(cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE))
> -               return qcom_scm_ice_invalidate_key(slot);
>
>         /* Only AES-256-XTS has been tested so far. */
>         cap = cq_host->crypto_cap_array[cfg->crypto_cap_idx];
>         if (cap.algorithm_id != CQHCI_CRYPTO_ALG_AES_XTS ||
> -           cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256) {
> -               dev_err_ratelimited(dev,
> -                                   "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
> -                                   cap.algorithm_id, cap.key_size);
> +               cap.key_size != CQHCI_CRYPTO_KEY_SIZE_256)
>                 return -EINVAL;
> -       }
>
> -       memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
> -
> -       /*
> -        * The SCM call byte-swaps the 32-bit words of the key.  So we have to
> -        * do the same, in order for the final key be correct.
> -        */
> -       for (i = 0; i < ARRAY_SIZE(key.words); i++)
> -               __cpu_to_be32s(&key.words[i]);
> -
> -       err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> -                                  QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> -                                  cfg->data_unit_size);
> -       memzero_explicit(&key, sizeof(key));
> -       return err;
> +       if (cfg->config_enable & CQHCI_CRYPTO_CONFIGURATION_ENABLE)
> +               return qcom_ice_program_key(msm_host->ice,
> +                                           QCOM_ICE_CRYPTO_ALG_AES_XTS,
> +                                           QCOM_ICE_CRYPTO_KEY_SIZE_256,
> +                                           cfg->crypto_key,
> +                                           cfg->data_unit_size, slot);
> +       else
> +               return qcom_ice_evict_key(msm_host->ice, slot);
>  }
> +
>  #else /* CONFIG_MMC_CRYPTO */
> -static inline struct clk *sdhci_msm_ice_get_clk(struct device *dev)
> -{
> -       return NULL;
> -}
>
>  static inline int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>                                      struct cqhci_host *cq_host)
> @@ -2025,11 +1895,17 @@ static inline void sdhci_msm_ice_enable(struct sdhci_msm_host *msm_host)
>  {
>  }
>
> -static inline int __maybe_unused
> +static inline __maybe_unused int
>  sdhci_msm_ice_resume(struct sdhci_msm_host *msm_host)
>  {
>         return 0;
>  }
> +
> +static inline __maybe_unused int
> +sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
> +{
> +       return 0;
> +}
>  #endif /* !CONFIG_MMC_CRYPTO */
>
>  /*****************************************************************************\
> @@ -2633,11 +2509,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 clk = NULL;
>         msm_host->bulk_clks[3].clk = clk;
>
> -       clk = sdhci_msm_ice_get_clk(&pdev->dev);
> -       if (IS_ERR(clk))
> -               clk = NULL;
> -       msm_host->bulk_clks[4].clk = clk;
> -
>         ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>                                       msm_host->bulk_clks);
>         if (ret)
> @@ -2830,7 +2701,7 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>
> -       return 0;
> +       return sdhci_msm_ice_suspend(msm_host);
>  }
>
>  static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
> --
> 2.34.1
>
