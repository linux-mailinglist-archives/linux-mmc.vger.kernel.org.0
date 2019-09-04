Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0139A7FD0
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDJxn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 05:53:43 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38872 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfIDJxn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 05:53:43 -0400
Received: by mail-vk1-f196.google.com with SMTP id s72so2970507vkh.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ic2iplPfdO7i3uRgJ0Hzu/GUIO9NNXy57n+W3sRS8Q=;
        b=QJ5CGHcFRjYb9B/afscI/MJR6FxKrBrwBHu1SWZC9lErxDcCUzUUxWbh5d7IfZrDdc
         8yA+YhbEfm5ztUijHNijntUBFxiFU4YBTG6s0lv+SrvYrnLHkC8BDcnzibZFYKHEaXq6
         EUsqfd9g6Hhww9TG3K1TSZTPI3R5bh4dCLHZiPYNVOiYmwtsNNoLwgR0t5a80DIFCFOU
         vB7pUZbaJlhYUr8WwM7axgrHfARVB7/Y5QzVC2Z39iz4srC530nFW7ZUxy8HsOi8CPm+
         FavzOP+jPQFykSZbRWv46yqjxN3q42b0GM4Clp7Ao8Y8C6Ocoy/XHMoObHgnVC1nRlQe
         vNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ic2iplPfdO7i3uRgJ0Hzu/GUIO9NNXy57n+W3sRS8Q=;
        b=I+O4AMHwhIWjJ948k+p4UEaV1BUMODv8ghVsxvuzL4U9lPyMT9ZN4zL2NapMYtMwCf
         Du3/9wQUw3GMZHUVVWlGDoabi/dxa6nsE9SpKzuXbisTk1k4whkERQjEjwcWrcSKAfIT
         0OX2Wsrbqiw3ypyL7dveRDagEKS0gSkd7LtRfwHSoCNAe7pEshpadoQBLX2JEuwS7H6u
         Hnf2JhITmGj3ARWaOVxvOggOvUhsrXXzpii8wM1o6waLrQKAN8XVIQum+VoB9YlCZMEg
         4/Ps1KpQnJsJGpboug5Mo0wNIUkwejR/i5xVN2rr8IKu66ML7zkcF26+qnZTwauz1mz0
         I5yQ==
X-Gm-Message-State: APjAAAXgX3rjcxVIkvh3lUQHkgEOTb71gp+g0lZygVj4fEGSeR0XSTQv
        PnTGJyJfADMxlHPpHyolzVlThrmugcT7l8hadWMUsQ==
X-Google-Smtp-Source: APXvYqwt7KpAKu5/7RBS0w/rPWQf1BbBuCYSbx9k4jsBcvAiY+KK2EBHuo3YbjRDQvvsQLj4hmX2eYlURiEJLqDlthk=
X-Received: by 2002:a1f:5185:: with SMTP id f127mr19014735vkb.52.1567590821000;
 Wed, 04 Sep 2019 02:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <1567100454-5905-1-git-send-email-shirley.her@bayhubtech.com>
In-Reply-To: <1567100454-5905-1-git-send-email-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 11:53:03 +0200
Message-ID: <CAPDyKFp+7OG=aV=tMtnhffmycx5_j8hs4vfCsKNBr7jJGGxQfg@mail.gmail.com>
Subject: Re: [PATCH V9 2/3] mmc: sdhci-pci-o2micro: Move functions in
 preparation to fix DLL lock phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 19:41, Shirley Her (SC)
<shirley.her@bayhubtech.com> wrote:
>
> Move functions in preparation to fix DLL lock phase shift issue
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> change in V9:
>  1. modify subject and commit message to match the patch
>
> change in V8:
>  1. fix patch format error
>
> change in V7:
>  1. change subject to match the patch
>  2. move functions in preparation to fix DLL lock phase shift issue
>
> change in V6:
>  1. change subject and commit message to match the patch
>  2. modify the get CD status function
>  3. re-arrange the order of some functions
>
> change in V5:
>  1. split 2 patches into 3 patches
>  2. make dll_adjust_count start from 0
>  3. fix ret overwritten issue
>  4. use break instead of goto
>
> change in V4:
>  1. add a bug fix for V3
>
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
>
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
>
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 187 ++++++++++++++++++-----------------
>  1 file changed, 94 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b3a33d9..57c8b83 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -58,6 +58,100 @@
>
>  #define O2_SD_DETECT_SETTING 0x324
>
> +static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> +{
> +       ktime_t timeout;
> +       u32 scratch32;
> +
> +       /* Wait max 50 ms */
> +       timeout = ktime_add_ms(ktime_get(), 50);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +               if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> +                   == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> +                       break;
> +
> +               if (timedout) {
> +                       pr_err("%s: Card Detect debounce never finished.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +               udelay(10);
> +       }
> +}
> +
> +static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> +{
> +       ktime_t timeout;
> +       u16 scratch;
> +       u32 scratch32;
> +
> +       /* PLL software reset */
> +       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +       scratch32 |= O2_PLL_SOFT_RESET;
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +       udelay(1);
> +       scratch32 &= ~(O2_PLL_SOFT_RESET);
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +       /* PLL force active */
> +       scratch32 |= O2_PLL_FORCE_ACTIVE;
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +       /* Wait max 20 ms */
> +       timeout = ktime_add_ms(ktime_get(), 20);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> +               if (scratch & O2_PLL_LOCK_STATUS)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: Internal clock never stabilised.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       goto out;
> +               }
> +               udelay(10);
> +       }
> +
> +       /* Wait for card detect finish */
> +       udelay(1);
> +       sdhci_o2_wait_card_detect_stable(host);
> +
> +out:
> +       /* Cancel PLL force active */
> +       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +       scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +static int sdhci_o2_get_cd(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       sdhci_o2_enable_internal_clock(host);
> +
> +       return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> +}
> +
> +static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> +{
> +       u32 scratch_32;
> +
> +       pci_read_config_dword(chip->pdev,
> +                             O2_SD_PLL_SETTING, &scratch_32);
> +
> +       scratch_32 &= 0x0000FFFF;
> +       scratch_32 |= value;
> +
> +       pci_write_config_dword(chip->pdev,
> +                              O2_SD_PLL_SETTING, scratch_32);
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>         u16 reg;
> @@ -136,19 +230,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return 0;
>  }
>
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> -{
> -       u32 scratch_32;
> -       pci_read_config_dword(chip->pdev,
> -                             O2_SD_PLL_SETTING, &scratch_32);
> -
> -       scratch_32 &= 0x0000FFFF;
> -       scratch_32 |= value;
> -
> -       pci_write_config_dword(chip->pdev,
> -                              O2_SD_PLL_SETTING, scratch_32);
> -}
> -
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>  {
>         int ret;
> @@ -284,86 +365,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>         host->irq = pci_irq_vector(chip->pdev, 0);
>  }
>
> -static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> -{
> -       ktime_t timeout;
> -       u32 scratch32;
> -
> -       /* Wait max 50 ms */
> -       timeout = ktime_add_ms(ktime_get(), 50);
> -       while (1) {
> -               bool timedout = ktime_after(ktime_get(), timeout);
> -
> -               scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -               if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> -                   == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> -                       break;
> -
> -               if (timedout) {
> -                       pr_err("%s: Card Detect debounce never finished.\n",
> -                              mmc_hostname(host->mmc));
> -                       sdhci_dumpregs(host);
> -                       return;
> -               }
> -               udelay(10);
> -       }
> -}
> -
> -static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> -{
> -       ktime_t timeout;
> -       u16 scratch;
> -       u32 scratch32;
> -
> -       /* PLL software reset */
> -       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -       scratch32 |= O2_PLL_SOFT_RESET;
> -       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -       udelay(1);
> -       scratch32 &= ~(O2_PLL_SOFT_RESET);
> -       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -       /* PLL force active */
> -       scratch32 |= O2_PLL_FORCE_ACTIVE;
> -       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -       /* Wait max 20 ms */
> -       timeout = ktime_add_ms(ktime_get(), 20);
> -       while (1) {
> -               bool timedout = ktime_after(ktime_get(), timeout);
> -
> -               scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> -               if (scratch & O2_PLL_LOCK_STATUS)
> -                       break;
> -               if (timedout) {
> -                       pr_err("%s: Internal clock never stabilised.\n",
> -                              mmc_hostname(host->mmc));
> -                       sdhci_dumpregs(host);
> -                       goto out;
> -               }
> -               udelay(10);
> -       }
> -
> -       /* Wait for card detect finish */
> -       udelay(1);
> -       sdhci_o2_wait_card_detect_stable(host);
> -
> -out:
> -       /* Cancel PLL force active */
> -       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -       scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -}
> -
> -static int sdhci_o2_get_cd(struct mmc_host *mmc)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -
> -       sdhci_o2_enable_internal_clock(host);
> -
> -       return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> -}
> -
>  static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  {
>         /* Enable internal clock */
> --
> 2.7.4
>
