Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296FE45D958
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Nov 2021 12:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhKYLk5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Nov 2021 06:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhKYLiz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 06:38:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D00C061756
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 03:31:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y26so15464137lfa.11
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJFn0MvzMtUw2RZqxKnhVnDJf1Gy7euKexknLIMbDjA=;
        b=QNWJeRBkm5TcJiuqJTd9gA17/3TIbmbVCjNrCx0rmaV6M+YJipw5kScaJNVabqVIl2
         68SYeSAWXCl6S4tq863q9vDjj4umKwJLFGcgIrHw+dMA+Pbmcw6JbObMuHRFsRit6yg6
         bXzeXu3UzPXPNFTe/IfukBZ21+X9ERuR9BzX+7rwrfAsef0qqe764zO72ZRIG2lDk2JK
         FFVAhrOsClr1W5RuhFvsvWyNZ0BfrLbkl3vzgsmntBpA2rUhMuDb4UwLzu2ZFcukWsvW
         bNaOuVKceTfZd0Epl4EdIxu0Ae2eHheDzGTI3NE3LIe+Qw66I/N/jLTPTs4Jt8nN2uZe
         OtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJFn0MvzMtUw2RZqxKnhVnDJf1Gy7euKexknLIMbDjA=;
        b=RT4OPmmm5+ZAszJMHqIFCTmeGS6HbOqAcS1KV2uGZK6bfdyMIkbnh3AtA+qvOFV2m8
         VZf9G3Krcg4scst6lAAq8iTGmEpSzLiE4aGjL1opdAKaI0p4vieB4DkrLyswytywOqbQ
         HXxNb2gmm5SFnbBfBskcAml5bKOBROiQcvPjNk8FrbARLuH/EC/jkiicfJCy4CTLWR/+
         NQaaJwduvL9k0MeKqvcrVaJQAhk5DuC9FPLSQLb9DgI4DLCm02XtIJKnZRVL+qOABg87
         BoDLWjm6tG33MjuxwwXRTNpvwchgJnYHNHjFKGtp1Bo9IYdGS8/pTTGMLzhlgJJ8i8no
         NUdQ==
X-Gm-Message-State: AOAM530QyNWDq81OGUYDZ6qoh/oHmMSEc4sratQ8OgRSJ2/RvRyvKLdU
        1trgFAXZ9WI5ZRPGOSQRwuU1nBZ8NGz1tYirBt0KSVIS/tU=
X-Google-Smtp-Source: ABdhPJxmU4TUYW+1a1EBDZRofh4LRzrij9EDzxwDFXib/nxP1KohqzRScSWY5+8hMxWsdG5SdIklK9cwNdfSeMzQ6Pc=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr23077809lfv.233.1637839876270;
 Thu, 25 Nov 2021 03:31:16 -0800 (PST)
MIME-Version: 1.0
References: <1637130012-21846-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1637130012-21846-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Nov 2021 12:30:39 +0100
Message-ID: <CAPDyKFqd9ThDUPAYom32w4D8nZYxbvYnJgA9dmQnFu2qEhhMig@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat sysfs entry
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Nov 2021 at 07:20, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add sysfs entry to query eMMC and SD card errors statistics.
> This feature is useful for debug and testing.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/host/cqhci.h     |   1 +
>  drivers/mmc/host/sdhci-msm.c | 192 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c     |  17 ++++
>  drivers/mmc/host/sdhci.h     |   1 +
>  include/linux/mmc/host.h     |   1 +
>  5 files changed, 212 insertions(+)

To allow an easier review, I strongly suggest splitting up the changes
in smaller pieces. Maybe in three steps: add interfaces, implement
them, add sysfs - or something along those lines.

I am also trying to understand the benefit of having these stats
available. Can you perhaps share a little bit of background on how
they are usable for you? Is it for debug purpose or does it have other
purposes too?

If it turns out that we agree on finding these stats valuable for us,
then I am inclined to think that this should be integrated closer with
the mmc core.

The error codes that are propagated to the core from failed requests
are common error codes, so we should be able to use that information
from the core itself, I think.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387e..f72a1d6 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -286,6 +286,7 @@ struct cqhci_host_ops {
>                                  u64 *data);
>         void (*pre_enable)(struct mmc_host *mmc);
>         void (*post_disable)(struct mmc_host *mmc);
> +       void (*err_stats)(struct mmc_host *mmc, unsigned long flags);
>  #ifdef CONFIG_MMC_CRYPTO
>         int (*program_key)(struct cqhci_host *cq_host,
>                            const union cqhci_crypto_cfg_entry *cfg, int slot);
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..e1dcd2d 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -242,6 +242,23 @@ struct sdhci_msm_variant_ops {
>                         u32 offset);
>  };
>
> +enum {
> +       MMC_ERR_CMD_TIMEOUT,
> +       MMC_ERR_CMD_CRC,
> +       MMC_ERR_DAT_TIMEOUT,
> +       MMC_ERR_DAT_CRC,
> +       MMC_ERR_AUTO_CMD,
> +       MMC_ERR_ADMA,
> +       MMC_ERR_TUNING,
> +       MMC_ERR_CMDQ_RED,
> +       MMC_ERR_CMDQ_GCE,
> +       MMC_ERR_CMDQ_ICCE,
> +       MMC_ERR_REQ_TIMEOUT,
> +       MMC_ERR_CMDQ_REQ_TIMEOUT,
> +       MMC_ERR_ICE_CFG,
> +       MMC_ERR_MAX,
> +};
> +
>  /*
>   * From V5, register spaces have changed. Wrap this info in a structure
>   * and choose the data_structure based on version info mentioned in DT.
> @@ -285,6 +302,8 @@ struct sdhci_msm_host {
>         u32 dll_config;
>         u32 ddr_config;
>         bool vqmmc_enabled;
> +       bool err_occurred;
> +       u32  err_stats[MMC_ERR_MAX];
>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -2106,9 +2125,20 @@ static void sdhci_msm_set_timeout(struct sdhci_host *host, struct mmc_command *c
>                 host->data_timeout = 22LL * NSEC_PER_SEC;
>  }
>
> +void sdhci_msm_cqe_err_stats(struct mmc_host *mmc, unsigned long flags)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (flags & BIT(0))
> +               msm_host->err_stats[MMC_ERR_CMDQ_REQ_TIMEOUT]++;
> +}
> +
>  static const struct cqhci_host_ops sdhci_msm_cqhci_ops = {
>         .enable         = sdhci_msm_cqe_enable,
>         .disable        = sdhci_msm_cqe_disable,
> +       .err_stats      = sdhci_msm_cqe_err_stats,
>  #ifdef CONFIG_MMC_CRYPTO
>         .program_key    = sdhci_msm_program_key,
>  #endif
> @@ -2403,6 +2433,46 @@ static void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
>                 readl_relaxed(host->ioaddr +
>                         msm_offset->core_vendor_spec_func2),
>                 readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec3));
> +       msm_host->err_occurred = true;
> +}
> +
> +void sdhci_msm_err_stats(struct sdhci_host *host, u32 intmask)
> +{
> +       int command;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (!msm_host->err_occurred)
> +               msm_host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
> +
> +       if (host && host->mmc && host->mmc->timer) {
> +               msm_host->err_stats[MMC_ERR_REQ_TIMEOUT]++;
> +               host->mmc->timer = false;
> +       }
> +
> +       if (intmask & SDHCI_INT_CRC) {
> +               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +               if (command != MMC_SEND_TUNING_BLOCK ||
> +                   command != MMC_SEND_TUNING_BLOCK_HS200)
> +                       msm_host->err_stats[MMC_ERR_CMD_CRC]++;
> +       } else if ((intmask & SDHCI_INT_TIMEOUT) ||
> +               (intmask & SDHCI_INT_DATA_TIMEOUT))
> +               msm_host->err_stats[MMC_ERR_CMD_TIMEOUT]++;
> +       else if (intmask & SDHCI_INT_DATA_CRC) {
> +               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +               if (command != MMC_SEND_TUNING_BLOCK ||
> +                   command != MMC_SEND_TUNING_BLOCK_HS200)
> +                       msm_host->err_stats[MMC_ERR_DAT_CRC]++;
> +       } else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +               msm_host->err_stats[MMC_ERR_DAT_TIMEOUT]++;
> +       else if (intmask & CQHCI_IS_RED)
> +               msm_host->err_stats[MMC_ERR_CMDQ_RED]++;
> +       else if (intmask & CQHCI_IS_GCE)
> +               msm_host->err_stats[MMC_ERR_CMDQ_GCE]++;
> +       else if (intmask & CQHCI_IS_ICCE)
> +               msm_host->err_stats[MMC_ERR_CMDQ_ICCE]++;
> +       else if (intmask & SDHCI_INT_ADMA_ERROR)
> +               msm_host->err_stats[MMC_ERR_ADMA]++;
>  }
>
>  static const struct sdhci_msm_variant_ops mci_var_ops = {
> @@ -2456,6 +2526,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
>         .dump_vendor_regs = sdhci_msm_dump_vendor_regs,
>         .set_power = sdhci_set_power_noreg,
>         .set_timeout = sdhci_msm_set_timeout,
> +       .err_stats = sdhci_msm_err_stats,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> @@ -2482,6 +2553,125 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>         of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>  }
>
> +static ssize_t err_state_show(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (!host || !host->mmc)
> +               return -EINVAL;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", !!msm_host->err_occurred);
> +}
> +
> +static ssize_t err_state_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       unsigned int val;
> +
> +       if (kstrtouint(buf, 0, &val))
> +               return -EINVAL;
> +       if (!host || !host->mmc)
> +               return -EINVAL;
> +
> +       msm_host->err_occurred = !!val;
> +       if (!val)
> +               memset(msm_host->err_stats, 0, sizeof(msm_host->err_stats));
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RW(err_state);
> +
> +static ssize_t err_stats_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       char tmp[100];
> +
> +       if (!host || !host->mmc)
> +               return -EINVAL;
> +
> +       scnprintf(tmp, sizeof(tmp), "# Command Timeout Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMD_TIMEOUT]);
> +       strlcpy(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Command CRC Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMD_CRC]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Data Timeout Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_DAT_TIMEOUT]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Data CRC Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_DAT_CRC]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Auto-Cmd Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_ADMA]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# ADMA Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_ADMA]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Tuning Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_TUNING]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# CMDQ RED Errors: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMDQ_RED]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# CMDQ GCE Errors: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMDQ_GCE]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# CMDQ ICCE Errors: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMDQ_ICCE]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# CMDQ Request Timedout: %d\n",
> +               msm_host->err_stats[MMC_ERR_CMDQ_REQ_TIMEOUT]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       scnprintf(tmp, sizeof(tmp), "# Request Timedout Error: %d\n",
> +               msm_host->err_stats[MMC_ERR_REQ_TIMEOUT]);
> +       strlcat(buf, tmp, PAGE_SIZE);
> +
> +       return strlen(buf);
> +}
> +static DEVICE_ATTR_RO(err_stats);
> +
> +static struct attribute *sdhci_msm_sysfs_attrs[] = {
> +       &dev_attr_err_state.attr,
> +       &dev_attr_err_stats.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group sdhci_msm_sysfs_group = {
> +       .name = "qcom",
> +       .attrs = sdhci_msm_sysfs_attrs,
> +};
> +
> +static int sdhci_msm_init_sysfs(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       ret = sysfs_create_group(&pdev->dev.kobj, &sdhci_msm_sysfs_group);
> +       if (ret)
> +               dev_err(&pdev->dev, "%s: Failed sdhci_msm sysfs group err=%d\n",
> +                       __func__, ret);
> +       return ret;
> +}
>
>  static int sdhci_msm_probe(struct platform_device *pdev)
>  {
> @@ -2734,6 +2924,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (ret)
>                 goto pm_runtime_disable;
>
> +       sdhci_msm_init_sysfs(pdev);
> +
>         pm_runtime_mark_last_busy(&pdev->dev);
>         pm_runtime_put_autosuspend(&pdev->dev);
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 07c6da1..f82a3eff 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3159,6 +3159,13 @@ static void sdhci_timeout_timer(struct timer_list *t)
>         spin_lock_irqsave(&host->lock, flags);
>
>         if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
> +               if (host->ops->err_stats) {
> +                       u32 intmask;
> +
> +                       host->mmc->timer = true;
> +                       intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +                       host->ops->err_stats(host, intmask);
> +               }
>                 pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>                        mmc_hostname(host->mmc));
>                 sdhci_dumpregs(host);
> @@ -3181,6 +3188,13 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>
>         if (host->data || host->data_cmd ||
>             (host->cmd && sdhci_data_line_cmd(host->cmd))) {
> +               if (host->ops->err_stats) {
> +                       u32 intmask;
> +
> +                       host->mmc->timer = true;
> +                       intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +                       host->ops->err_stats(host, intmask);
> +               }
>                 pr_err("%s: Timeout waiting for hardware interrupt.\n",
>                        mmc_hostname(host->mmc));
>                 sdhci_dumpregs(host);
> @@ -3466,6 +3480,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>         }
>
>         intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +       if (host->ops->err_stats)
> +               host->ops->err_stats(host, intmask);
> +
>         if (!intmask || intmask == 0xffffffff) {
>                 result = IRQ_NONE;
>                 goto out;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d7929d7..a1546b3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -658,6 +658,7 @@ struct sdhci_ops {
>         void    (*request_done)(struct sdhci_host *host,
>                                 struct mmc_request *mrq);
>         void    (*dump_vendor_regs)(struct sdhci_host *host);
> +       void    (*err_stats)(struct sdhci_host *host, u32 intmask);
>  };
>
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7afb57c..33186ff 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -492,6 +492,7 @@ struct mmc_host {
>         int                     cqe_qdepth;
>         bool                    cqe_enabled;
>         bool                    cqe_on;
> +       bool                    timer;
>
>         /* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
