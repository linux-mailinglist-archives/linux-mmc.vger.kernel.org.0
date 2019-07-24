Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1473070
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfGXOAT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 10:00:19 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46038 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGXOAT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 10:00:19 -0400
Received: by mail-vs1-f66.google.com with SMTP id h28so31394805vsl.12
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaHdBALCCZjR8U+ad9l2IMJ9v+TyugpAHKq765/Dh+c=;
        b=jWCL7XuZzSmBFZP4HBZLxqB0yj4NpnPwGaauTr8j++WldFJN/145oFaq1+gflCfaRU
         uwspY0Jayf8gzldyPQ2a18kJSgYf2yybdF1xIMZsF5uAUbzc+IWS0jpoefVT5vxITMWY
         +Fe8USgXwbclJAxVwjPxJZnJ7Si8QQnDWstHgRFPeKKq78AdqFGS5ZMmthB3yV+jN9Iz
         Ru7lD+b0AMHM2nnRUBb++oO09ilvscXWExuGbOnv/ductvfL7nruZNMnTFcjEYdUWJse
         noR39nVws61k4/13XO/AnrFMlCVeka6JQG4TbnhnbfjC9rmx5YfV5za7W450JF2GYmYL
         iDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaHdBALCCZjR8U+ad9l2IMJ9v+TyugpAHKq765/Dh+c=;
        b=VccSeda2lIkSNskVC79tcZ/k/8QsLIcKZo9ZiByA3H4vmMb9HFG73ygitZzamEE3Py
         fQNc9PwWSRuCrKcIVV2RfmQFp/BrR6+lAAtgmNcF45Jvs6COIOzIVhLmNzJ4i7bJjNjQ
         LH7kPBmj/iZHjgag0ffDESawF0RMaaGSMncVgyQGZiB7YuZ2ZcNmsGx1dvbQSQmDYW4U
         V1nev0B1mzxZSy/MWevgha9ETsz2MOhCCkJG42Ey0Rl2+MVmtTfmVklY3fXDqjXk44FP
         vyERJ7DnwCGwOG+rWeZ/fmcm2yoeWZxvP56nx/0oqR3rqwfMcvulyzhz7N2FRoTlpabA
         s3yA==
X-Gm-Message-State: APjAAAWeOCksSpH68xSQQmDFYz2w2HLyQgL1t/BSstjHeKlVlaCnZivU
        EEaBGrqCygK5nNiw8MES3kD5hq4dGkVKpk1pHsJx8g==
X-Google-Smtp-Source: APXvYqzNdcoBYd2VKU01jJKfCuafOk5ORBz7nxBpjQVbKJnE5WK7eyO6wKhCf1NblQHT/RNTnP81afIiwgXtHFvydyA=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr51736015vsp.191.1563976817470;
 Wed, 24 Jul 2019 07:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR16MB14556F1A5D538D7218E5B64F8BC90@MWHPR16MB1455.namprd16.prod.outlook.com>
In-Reply-To: <MWHPR16MB14556F1A5D538D7218E5B64F8BC90@MWHPR16MB1455.namprd16.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 15:59:40 +0200
Message-ID: <CAPDyKFoVX04RQtx3b1Jc5WEFkAr3A=DkN0GRyCwkdSvn6TKSrQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock
 phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 20:04, Shirley Her (SC)
<shirley.her@bayhubtech.com> wrote:
>
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift.
>
>
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com

Looks like the patch was treated as being in in-correct format,
probably because of the missing ">" in the email address above.

Can you try to repost so the patchtracker accepts it?

Kind regards
Uffe

> ---
>
> Change in V1:
>
> 1. Add error recovery function to relock the DLL with correct phase
>
> 2. Retuning HS200 after DLL locked
>
> ---
>
> drivers/mmc/host/sdhci-pci-o2micro.c | 154 +++++++++++++++++++++++++++++------
>
> drivers/mmc/host/sdhci.h             |   3 +
>
> 2 files changed, 133 insertions(+), 24 deletions(-)
>
>
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>
> index 9dc4548..5a9011e 100644
>
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>
> @@ -51,13 +51,59 @@
>
> #define O2_SD_VENDOR_SETTING2      0x1C8
>
> #define O2_SD_HW_TUNING_DISABLE               BIT(4)
>
> -#define O2_PLL_WDT_CONTROL1         0x1CC
>
> +#define O2_PLL_DLL_WDT_CONTROL1               0x1CC
>
> #define  O2_PLL_FORCE_ACTIVE             BIT(18)
>
> #define  O2_PLL_LOCK_STATUS              BIT(14)
>
> #define  O2_PLL_SOFT_RESET  BIT(12)
>
> +#define  O2_DLL_LOCK_STATUS            BIT(11)
>
>  #define O2_SD_DETECT_SETTING 0x324
>
> +u32 dmdn_table[5] = {0x25100000, 0x2B1C0000,
>
> +             0x2C1A0000, 0x371B0000, 0x35100000};
>
> +static int sdhci_o2_get_cd(struct mmc_host *mmc);
>
> +
>
> +static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>
> +{
>
> +             u32 scratch_32;
>
> +
>
> +             pci_read_config_dword(chip->pdev,
>
> +                                                   O2_SD_PLL_SETTING, &scratch_32);
>
> +
>
> +             scratch_32 &= 0x0000FFFF;
>
> +             scratch_32 |= value;
>
> +
>
> +             pci_write_config_dword(chip->pdev,
>
> +                                                    O2_SD_PLL_SETTING, scratch_32);
>
> +}
>
> +
>
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
>
> +{
>
> +             ktime_t timeout;
>
> +             u32 scratch32;
>
> +
>
> +             mdelay(5);
>
> +             scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>
> +             if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
>
> +                             pr_warn("%s: DLL is still unlocked after wait 5ms\n",
>
> +                                             mmc_hostname(host->mmc));
>
> +             }
>
> +
>
> +             /* Detect 500 ms */
>
> +             timeout = ktime_add_ms(ktime_get(), 500);
>
> +             while (1) {
>
> +                             bool timedout = ktime_after(ktime_get(), timeout);
>
> +
>
> +                             scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>
> +                             if (!(scratch32 & O2_DLL_LOCK_STATUS))
>
> +                                             return 0;
>
> +
>
> +                             if (timedout)
>
> +                                             return 1;
>
> +                             udelay(10);
>
> +             }
>
> +}
>
> +
>
> static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>
> {
>
>                u16 reg;
>
> @@ -95,6 +141,73 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>
>                sdhci_reset_tuning(host);
>
> }
>
> +static int sdhci_o2_error_recovery(struct sdhci_pci_chip *chip,
>
> +                                                             struct sdhci_host *host)
>
> +{
>
> +             int ret = 0;
>
> +             u8 scratch_8 = 0;
>
> +             u32 scratch_32 = 0;
>
> +             /* Disable clock */
>
> +             sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
>
> +
>
> +DLL_ADJUST:
>
> +             if (host->dll_adjust_count >= 5) {
>
> +                             host->dll_adjust_count = 4;
>
> +                             pr_warn("%s: error recovery failed with the dll_adjust_count over max value.\n",
>
> +                                             mmc_hostname(host->mmc));
>
> +             }
>
> +
>
> +             /* UnLock WP */
>
> +             ret = pci_read_config_byte(chip->pdev,
>
> +                                             O2_SD_LOCK_WP, &scratch_8);
>
> +             if (ret)
>
> +                             return ret;
>
> +
>
> +             scratch_8 &= 0x7f;
>
> +             pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>
> +
>
> +             /* PLL software reset */
>
> +             scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>
> +             scratch_32 |= O2_PLL_SOFT_RESET;
>
> +             sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
>
> +
>
> +             ret = pci_read_config_dword(chip->pdev,
>
> +                                                                 O2_SD_FUNC_REG4,
>
> +                                                                 &scratch_32);
>
> +             /* Enable Base Clk setting change */
>
> +             scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
>
> +             pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
>
> +             o2_pci_set_baseclk(chip, dmdn_table[host->dll_adjust_count]);
>
> +
>
> +
>
> +             /* Enable internal clock */
>
> +             scratch_8 = SDHCI_CLOCK_INT_EN;
>
> +             sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
>
> +
>
> +             if (sdhci_o2_get_cd(host->mmc)) {
>
> +                             if (sdhci_o2_wait_dll_detect_lock(host)) {
>
> +                                             scratch_8 |= SDHCI_CLOCK_CARD_EN;
>
> +                                             sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
>
> +                                             ret = 1;
>
> +                             } else {
>
> +
>
> +                                             pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
>
> +                                             mmc_hostname(host->mmc), host->dll_adjust_count);
>
> +                                             host->dll_adjust_count++;
>
> +                                             goto DLL_ADJUST;
>
> +                             }
>
> +             }
>
> +
>
> +                             /* Lock WP */
>
> +             ret = pci_read_config_byte(chip->pdev,
>
> +                                                                O2_SD_LOCK_WP, &scratch_8);
>
> +             if (ret)
>
> +                             return ret;
>
> +             scratch_8 |= 0x80;
>
> +             pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>
> +             return ret;
>
> +}
>
> +
>
> static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
> {
>
>                struct sdhci_host *host = mmc_priv(mmc);
>
> @@ -110,6 +223,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>                if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
>
>                                return -EINVAL;
>
> +             if (host->dll_adjust_count)
>
> +                             sdhci_o2_error_recovery(host->chip, host);
>
> +
>
> +             host->dll_adjust_count++;
>
> +
>
>                /*
>
>                 * o2 sdhci host didn't support 8bit emmc tuning
>
>                 */
>
> @@ -131,23 +249,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>                                mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>
>                                sdhci_set_bus_width(host, current_bus_width);
>
>                }
>
> -
>
>                host->flags &= ~SDHCI_HS400_TUNING;
>
>                return 0;
>
> }
>
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>
> -{
>
> -              u32 scratch_32;
>
> -              pci_read_config_dword(chip->pdev,
>
> -                                                    O2_SD_PLL_SETTING, &scratch_32);
>
> -
>
> -              scratch_32 &= 0x0000FFFF;
>
> -              scratch_32 |= value;
>
> -              pci_write_config_dword(chip->pdev,
>
> -                                                     O2_SD_PLL_SETTING, scratch_32);
>
> -}
>
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>
> {
>
> @@ -316,23 +422,23 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>
>                u32 scratch32;
>
>                 /* PLL software reset */
>
> -              scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
>
> +             scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>
>                scratch32 |= O2_PLL_SOFT_RESET;
>
> -              sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
>
> +             sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
>                udelay(1);
>
>                scratch32 &= ~(O2_PLL_SOFT_RESET);
>
> -              sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
>
> +             sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
>                 /* PLL force active */
>
>                scratch32 |= O2_PLL_FORCE_ACTIVE;
>
> -              sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
>
> +             sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
>                 /* Wait max 20 ms */
>
>                timeout = ktime_add_ms(ktime_get(), 20);
>
>                while (1) {
>
>                                bool timedout = ktime_after(ktime_get(), timeout);
>
> -                              scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
>
> +                             scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
>
>                                if (scratch & O2_PLL_LOCK_STATUS)
>
>                                                break;
>
>                                if (timedout) {
>
> @@ -350,16 +456,16 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>
>  out:
>
>                /* Cancel PLL force active */
>
> -              scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
>
> +             scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>
>                scratch32 &= ~O2_PLL_FORCE_ACTIVE;
>
> -              sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
>
> +             sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
> }
>
>  static int sdhci_o2_get_cd(struct mmc_host *mmc)
>
> {
>
>                struct sdhci_host *host = mmc_priv(mmc);
>
> -
>
> -              sdhci_o2_enable_internal_clock(host);
>
> +             if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
>
> +                             sdhci_o2_enable_internal_clock(host);
>
>                 return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>
> }
>
> @@ -369,7 +475,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>
>                /* Enable internal clock */
>
>                clk |= SDHCI_CLOCK_INT_EN;
>
>                sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> -
>
> +             sdhci_o2_enable_internal_clock(host);
>
>                if (sdhci_o2_get_cd(host->mmc)) {
>
>                                clk |= SDHCI_CLOCK_CARD_EN;
>
>                                sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> @@ -400,7 +506,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>
>                 chip = slot->chip;
>
>                host = slot->host;
>
> -
>
> +             host->chip = chip;
>
>                caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>
>                 /*
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>
> index 89fd965..bc7c720 100644
>
> --- a/drivers/mmc/host/sdhci.h
>
> +++ b/drivers/mmc/host/sdhci.h
>
> @@ -562,6 +562,8 @@ struct sdhci_host {
>
>                struct timer_list timer;   /* Timer for timeouts */
>
>                struct timer_list data_timer;       /* Timer for data timeouts */
>
> +             struct sdhci_pci_chip *chip; /* Store the info of chip */
>
> +
>
>                u32 caps;                             /* CAPABILITY_0 */
>
>                u32 caps1;                           /* CAPABILITY_1 */
>
>                bool read_caps;                                /* Capability flags have been read */
>
> @@ -588,6 +590,7 @@ struct sdhci_host {
>
>                unsigned int                       tuning_count;   /* Timer count for re-tuning */
>
>                unsigned int                       tuning_mode;   /* Re-tuning mode supported by host */
>
>                unsigned int                       tuning_err;         /* Error code for re-tuning */
>
> +             u8 dll_adjust_count;      /* Timer count for dll adjust */
>
> #define SDHCI_TUNING_MODE_1         0
>
> #define SDHCI_TUNING_MODE_2         1
>
> #define SDHCI_TUNING_MODE_3         2
>
> --
>
> 2.7.4
>
>
>
>
