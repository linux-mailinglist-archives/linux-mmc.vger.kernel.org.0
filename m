Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23029E7DA
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Oct 2020 10:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgJ2Jxf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Oct 2020 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2Jxc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2020 05:53:32 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FCC0613D6
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 02:53:30 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id r9so523757uat.12
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2020 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnrKSKkOd3PJq8sa7PNuWLKbWNz1kFCtpp1IIy9Zp5U=;
        b=L+0o2LdNCzOsLm9aIa4wuFZu9HKG7I8p+r9jAjS5/hR3L2NZjXdZKPp/+6La67UJQV
         dbwdXmRfKPW7hxolZutW3YnAyFt2h36/EGY9XRO04faerAl2Q+ximd6Xwv4uKqL8q4qc
         rANtOyjgLj7YCBK5i1ICQfHMw8KL/xcGMT+y1dBhxe0mCtnMKOxNXQRH0eNxhMMHPuhu
         N4xaW/rcW9mDy2di34mmbvCIJ23GGX7x2bFSuYTdLsqLWQe229fsNAodaqzqBouB2bdE
         F6epzyJviv94qvoeU3WzRB0oJN8nspTvxrSjqmCZTv9DELrVuUxnV9n9OOkbvxpKDqt+
         /kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnrKSKkOd3PJq8sa7PNuWLKbWNz1kFCtpp1IIy9Zp5U=;
        b=Bnu+GZc/4vPPrcASydD5y1E67YEpUsnvtnvcM6fb4G0sdYw84i+DDuF54wbFQIuM/e
         WcH5qq00MCzhx/BGIVryaLIHN7kqoZjLi0YsfiLNbKprjsygw+cIs1SXc/BUru51FRRh
         5jUdqs6blOMY1ncAxeTl0j+sRXVOxz6vIBZhQOfMZzSxJRsxJW+5PM/r6iAh8BlcV5ud
         SnNyxFyg9VHmEPTkEU1fILhbd4lk606MKI/v3vfTlcbmw0I8/fB+dfNJRnr3XaBZv22L
         +d2ZPc3InUvRnil291QGW0hYgHXcN89QJb55TazuyqZDKKmBA0QdMKBFkdqwUhlXRRtN
         YwPg==
X-Gm-Message-State: AOAM531iTUC8bKWKT7m5xXdC5FqD7Uv9uIou3CVn+o9rnmvz4qqkxcBz
        djKUwofYg3FdR2Qc8siFmObuUIpNPcelmccOSU/CXg==
X-Google-Smtp-Source: ABdhPJzOH8r0nrea1GfqrofAEU0i6TzqwtbunXHpSV5biZaLqLAHNHDUPRcc5aoY02VPlCjUEKIERilOE4XhwfhLoE0=
X-Received: by 2002:ab0:140e:: with SMTP id b14mr2281397uae.100.1603965209472;
 Thu, 29 Oct 2020 02:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <1603936668-3363-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1603936668-3363-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Oct 2020 10:52:53 +0100
Message-ID: <CAPDyKFoKhxdx0BqcWgKr36riesEt_7qvNd8up5PrV07K+XD=fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] misc: rtsx: Add SD Express mode support for RTS5261
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Oct 2020 at 02:57, <rui_feng@realsil.com.cn> wrote:
>
> From: Rui Feng <rui_feng@realsil.com.cn>
>
> RTS5261 support SD mode and PCIe/NVMe mode. The workflow is as follows.
> 1.RTS5261 work in SD mode and set MMC_CAPS2_SD_EXP flag.
> 2.If card is plugged in, Host send CMD8 to ask card's PCIe availability.
> 3.If the card has PCIe availability and WP is not set, init_sd_express() will be invoked,
> RTS5261 switch to PCIe/NVMe mode.
> 4.Mmc driver handover it to NVMe driver.
> 5.If card is unplugged, RTS5261 will switch to SD mode.
>
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>

Greg, Arnd, I think I am ready to queue up this series now, may I have
your ack to pick this one via my mmc tree?

Kind regards
Uffe

> ---
> v2:remove duplicate define
> ---
>  drivers/misc/cardreader/rts5261.c  |  4 ++++
>  drivers/misc/cardreader/rts5261.h  | 23 -----------------------
>  drivers/misc/cardreader/rtsx_pcr.c |  5 +++++
>  include/linux/rtsx_pci.h           | 23 +++++++++++++++++++++++
>  4 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 471961487ff8..536c90d4fd76 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -738,8 +738,12 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
>  {
>         struct rtsx_cr_option *option = &pcr->option;
>         struct rtsx_hw_param *hw_param = &pcr->hw_param;
> +       u8 val;
>
>         pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
> +       rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
> +       if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
> +               pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
>         pcr->num_slots = 1;
>         pcr->ops = &rts5261_pcr_ops;
>
> diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
> index ebfdd236a553..8d80f0d5d5d6 100644
> --- a/drivers/misc/cardreader/rts5261.h
> +++ b/drivers/misc/cardreader/rts5261.h
> @@ -65,23 +65,6 @@
>  #define RTS5261_FW_EXPRESS_TEST_MASK   (0x01<<0)
>  #define RTS5261_FW_EA_MODE_MASK                (0x01<<5)
>
> -/* FW config register */
> -#define RTS5261_FW_CFG0                        0xFF54
> -#define RTS5261_FW_ENTER_EXPRESS       (0x01<<0)
> -
> -#define RTS5261_FW_CFG1                        0xFF55
> -#define RTS5261_SYS_CLK_SEL_MCU_CLK    (0x01<<7)
> -#define RTS5261_CRC_CLK_SEL_MCU_CLK    (0x01<<6)
> -#define RTS5261_FAKE_MCU_CLOCK_GATING  (0x01<<5)
> -/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
> -#define RTS5261_MCU_BUS_SEL_MASK       (0x01<<4)
> -/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
> -/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
> -#define RTS5261_MCU_CLOCK_SEL_MASK     (0x03<<2)
> -#define RTS5261_MCU_CLOCK_SEL_16M      (0x01<<2)
> -#define RTS5261_MCU_CLOCK_GATING       (0x01<<1)
> -#define RTS5261_DRIVER_ENABLE_FW       (0x01<<0)
> -
>  /* FW status register */
>  #define RTS5261_FW_STATUS              0xFF56
>  #define RTS5261_EXPRESS_LINK_FAIL_MASK (0x01<<7)
> @@ -121,12 +104,6 @@
>  #define RTS5261_DV3318_19              (0x04<<4)
>  #define RTS5261_DV3318_33              (0x07<<4)
>
> -#define RTS5261_LDO1_CFG0              0xFF72
> -#define RTS5261_LDO1_OCP_THD_MASK      (0x07<<5)
> -#define RTS5261_LDO1_OCP_EN            (0x01<<4)
> -#define RTS5261_LDO1_OCP_LMT_THD_MASK  (0x03<<2)
> -#define RTS5261_LDO1_OCP_LMT_EN                (0x01<<1)
> -
>  /* CRD6603-433 190319 request changed */
>  #define RTS5261_LDO1_OCP_THD_740       (0x00<<5)
>  #define RTS5261_LDO1_OCP_THD_800       (0x01<<5)
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 37ccc67f4914..6e5c16b4b7d1 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -990,6 +990,11 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
>                 } else {
>                         pcr->card_removed |= SD_EXIST;
>                         pcr->card_inserted &= ~SD_EXIST;
> +                       if (PCI_PID(pcr) == PID_5261) {
> +                               rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
> +                                       RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
> +                               pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
> +                       }
>                 }
>                 pcr->dma_error_count = 0;
>         }
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 745f5e73f99a..b47959f48ccd 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -658,6 +658,19 @@
>  #define   PM_WAKE_EN                   0x01
>  #define PM_CTRL4                       0xFF47
>
> +#define RTS5261_FW_CFG0                        0xFF54
> +#define   RTS5261_FW_ENTER_EXPRESS     (0x01 << 0)
> +
> +#define RTS5261_FW_CFG1                        0xFF55
> +#define   RTS5261_SYS_CLK_SEL_MCU_CLK  (0x01 << 7)
> +#define   RTS5261_CRC_CLK_SEL_MCU_CLK  (0x01 << 6)
> +#define   RTS5261_FAKE_MCU_CLOCK_GATING        (0x01 << 5)
> +#define   RTS5261_MCU_BUS_SEL_MASK     (0x01 << 4)
> +#define   RTS5261_MCU_CLOCK_SEL_MASK   (0x03 << 2)
> +#define   RTS5261_MCU_CLOCK_SEL_16M    (0x01 << 2)
> +#define   RTS5261_MCU_CLOCK_GATING     (0x01 << 1)
> +#define   RTS5261_DRIVER_ENABLE_FW     (0x01 << 0)
> +
>  #define REG_CFG_OOBS_OFF_TIMER 0xFEA6
>  #define REG_CFG_OOBS_ON_TIMER 0xFEA7
>  #define REG_CFG_VCM_ON_TIMER 0xFEA8
> @@ -701,6 +714,13 @@
>  #define   RTS5260_DVCC_TUNE_MASK       0x70
>  #define   RTS5260_DVCC_33              0x70
>
> +/*RTS5261*/
> +#define RTS5261_LDO1_CFG0              0xFF72
> +#define   RTS5261_LDO1_OCP_THD_MASK    (0x07 << 5)
> +#define   RTS5261_LDO1_OCP_EN          (0x01 << 4)
> +#define   RTS5261_LDO1_OCP_LMT_THD_MASK        (0x03 << 2)
> +#define   RTS5261_LDO1_OCP_LMT_EN      (0x01 << 1)
> +
>  #define LDO_VCC_CFG1                   0xFF73
>  #define   LDO_VCC_REF_TUNE_MASK                0x30
>  #define   LDO_VCC_REF_1V2              0x20
> @@ -741,6 +761,8 @@
>
>  #define RTS5260_AUTOLOAD_CFG4          0xFF7F
>  #define   RTS5260_MIMO_DISABLE         0x8A
> +/*RTS5261*/
> +#define   RTS5261_AUX_CLK_16M_EN               (1 << 5)
>
>  #define RTS5260_REG_GPIO_CTL0          0xFC1A
>  #define   RTS5260_REG_GPIO_MASK                0x01
> @@ -1191,6 +1213,7 @@ struct rtsx_pcr {
>  #define EXTRA_CAPS_MMC_HS200           (1 << 4)
>  #define EXTRA_CAPS_MMC_8BIT            (1 << 5)
>  #define EXTRA_CAPS_NO_MMC              (1 << 7)
> +#define EXTRA_CAPS_SD_EXPRESS          (1 << 8)
>         u32                             extra_caps;
>
>  #define IC_VER_A                       0
> --
> 2.17.1
>
