Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391B898DD4
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfHVIfx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 04:35:53 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38936 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbfHVIfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 04:35:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id k7so1728066uao.6
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOEkRYPATcgB1yCjMacSqNwJ3U82U8mp5KIsLfcMY28=;
        b=iTQO3e13zf/MUzDd9p+wT0xyZnSZJKmpc0MO+3AmwLOcd5XqVRyj/uHashtUC1tU8S
         VfcMWwzjjYjze7X81DYBknIVOrTBAR85/xT5lIMn/JESsw4un2OefwsnSL4eCdfHmncN
         SMG0X1PnqlDVCqSeyVlFe9kmMbqXfXMZQfLtgvoxXVjaWVbwwyK2U0OqkIddQFjXCR3D
         wQp6DY3BNBvKrkDEcla2qFca3TWKlMWgE5TKYB8PHtcG1MBFKKU1mo22p+VeCmjmWOJM
         5U6+dVUVe737TR9yRHCrPGN8aJ8rTReO768saNGE5IclkVhs0ZKBCyZWi4I4GNXX5Tvy
         7xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOEkRYPATcgB1yCjMacSqNwJ3U82U8mp5KIsLfcMY28=;
        b=cFpWQdyvwZnWeAwAfZZuOhd26X7Zda/bqSLlbNWMw/febWl2dTlqmHTqCZca7wCz77
         zFwbDRyP9jQHagxz3PZ0nPBWWVnkM/6Mv8+JpdcjLYEFQ9E50yNUS3bO8chNaj4K0brH
         EmOhGKQJKHQ64P9CQyVd8vziNea+Ete0RZdExmiZlqq1U/zTTcJ+H3XFlQmLkset3QOu
         md00KC2Xs1xZvt6nT1NfLhJOY1MVQSbPbaBGFuAaDbiZ4uHPdD38ofIU7wX/eXMcgCgj
         yp1Sr9JtKSJKO60hlNE/tcFElS6pHuIoxdVxcLZQw/dUHOjBJFvRiMbty85EbRZazYPC
         ghIA==
X-Gm-Message-State: APjAAAWlCjLMKAQ295BQUMWiQOVRSdGNIflh0D1o31KowXmPi/Q26OPL
        84g8VnONrJq/UlY7hhL69hHIgYojZ7kTZo6Yy3IzYA==
X-Google-Smtp-Source: APXvYqxApB1a+cb8c50HcqZa7xYJZKxOx4T84a6uO6f8g8cBZtHgycmeb1sd+ZFicLbC8UvxjQxcm+7ppRBztINV5/M=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr4931543ual.129.1566462951621;
 Thu, 22 Aug 2019 01:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
In-Reply-To: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 10:35:15 +0200
Message-ID: <CAPDyKFoyvT-nvU+rng7y=MitzuPfd3HdJ+SZNm4tPhkb-ER=nA@mail.gmail.com>
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

It seems like you managed to post the version 8, two times. Is there
any difference? Which one should we review?

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
