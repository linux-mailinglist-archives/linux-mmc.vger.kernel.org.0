Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE70A7FCD
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfIDJxh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 05:53:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42303 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDJxg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 05:53:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so4792937vsl.9
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EBgbCuBQmwJw3c0KzWyXPiGxZ+LZk1J5Qq98Q0y1Rg=;
        b=Ee5A1aWLCsbyGGzkjTb7nQ4sGxkRejpT4vfKZOuLJ/fuCfE+m4T4xfRzOnHFpJfUJo
         yXW8KuknGFoCW003Yuj0MppGtZwyJekuDJ26xLfmX8nM/SPLqDSUOZC+ABOykmulOwpS
         Xl/jFXKX4N+UF5D2PujYQZ7kX6IwbsLtjoCEfaOWZnfIxM7ecq/6yLHfJjZ8unWhk/+j
         43QK1fmeHeWyk0+5DRYV6gzf30cCDAx4MRDcRwVDHBhfdmrlWJv64aWjbBWubr/t4+ta
         Hj2AZMerNI9W4bPajbr7JdpRknfFTsqR9r6mQ27qWDw1HnvA4hz03fnVj0JaeIqXOsqB
         iKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EBgbCuBQmwJw3c0KzWyXPiGxZ+LZk1J5Qq98Q0y1Rg=;
        b=F6hZjZA9Eh33Ij0dTpQ0cp2WLIVWVhz/4HcKRzoF/zqdU83JJ24ZgFHsEV/r+Pm6eo
         2rUzlI1WlyPoCH2kv+iCSAAk7AD6Dm0OH7mbAl+xiahWlexSzaivpZhsdj9I4snPgwCT
         fiMk7lDsCzOGhjPRuHJToWEZQChAMr1xj8Ht44mf/P0rkoYzC0LBNwgjoRshxBnbbV4N
         x0V+/r4eEkgEDIYHYc0LuN4MfmAdP1X6lc6pczxpD/yk986OV7Uq4OXM9wcfBuKj52fL
         MojIFeX4yl1QZeKxWnkYzYzuIPh6nRZQGiJ6iskIfDuOQiktpn+WBJ5gzUn5yqB/Ee+d
         oUOQ==
X-Gm-Message-State: APjAAAVtJ0JHnJ44568AZ+cDaGXpYxoX/BzECAUckfq84xuAZfR6HxCh
        CZg7Co8Xo6dr+hb4N4evEql9ha80basAf3SaX/xzoEcw
X-Google-Smtp-Source: APXvYqxYyISYJgjAKMkK5Km5L6Ab6HlnxxbR4PPKBd9SqnHm+XzalIf+meWw+dqgWRxR8g/79cmNXgnbmFHnKeC3gAI=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr9188834vsm.165.1567590815885;
 Wed, 04 Sep 2019 02:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
In-Reply-To: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 11:52:58 +0200
Message-ID: <CAPDyKFouaWGBa8TjBRR78U5=gind7Ku2cqZ4fx-Hz5-O+ytjPQ@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL
 register name
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Aug 2019 at 20:38, Shirley Her (SC)
<shirley.her@bayhubtech.com> wrote:
>
> Change O2 Host PLL and DLL register name
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> change in V8:
>  1. fix patch format error
>
> change in V7:
>  1. change subject
>
> change in V6:
>  1. change subject and commit message to match the patch
>  2. change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548..b3a33d9 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -51,7 +51,7 @@
>  #define O2_SD_VENDOR_SETTING2  0x1C8
>  #define O2_SD_HW_TUNING_DISABLE        BIT(4)
>
> -#define O2_PLL_WDT_CONTROL1    0x1CC
> +#define O2_PLL_DLL_WDT_CONTROL1        0x1CC
>  #define  O2_PLL_FORCE_ACTIVE   BIT(18)
>  #define  O2_PLL_LOCK_STATUS    BIT(14)
>  #define  O2_PLL_SOFT_RESET     BIT(12)
> @@ -316,23 +316,23 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>         u32 scratch32;
>
>         /* PLL software reset */
> -       scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>         scratch32 |= O2_PLL_SOFT_RESET;
> -       sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>         udelay(1);
>         scratch32 &= ~(O2_PLL_SOFT_RESET);
> -       sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
>         /* PLL force active */
>         scratch32 |= O2_PLL_FORCE_ACTIVE;
> -       sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>
>         /* Wait max 20 ms */
>         timeout = ktime_add_ms(ktime_get(), 20);
>         while (1) {
>                 bool timedout = ktime_after(ktime_get(), timeout);
>
> -               scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> +               scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
>                 if (scratch & O2_PLL_LOCK_STATUS)
>                         break;
>                 if (timedout) {
> @@ -350,9 +350,9 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>
>  out:
>         /* Cancel PLL force active */
> -       scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +       scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>         scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -       sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +       sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  }
>
>  static int sdhci_o2_get_cd(struct mmc_host *mmc)
> --
> 2.7.4
>
