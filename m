Return-Path: <linux-mmc+bounces-600-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DC8251B8
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB4C284424
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65424B35;
	Fri,  5 Jan 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1ppLLM/"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B824B54
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jan 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e54d40cca2so12774797b3.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2024 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704449849; x=1705054649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RhTPtiU3ebbMMUs+zK0c151tFKxnFYC6rMwGCcNmmuI=;
        b=P1ppLLM/4BVEJepjLPbdzolZo65gPkWdkol7g/CZ87xhVuBnxsOJbArN3tpx2Z+CSn
         t0g40p2y1+pQRBBBYhVbXsYezGPf6EZk7Of/+W8ZafAlcWES2fItTVSVZQweUJhOAXCg
         053HTeAV2oGSWeQAbsED7wx1ZAIKAxscCwXqefs8rUzmG8UPkCAwOcc5pQUEeUOkT0DQ
         C+YMKGsdA2+arSqUsCyAMo+lW9VXIdozFu/nz6p+Hy64bev2wjpsyRtBNk6dYg8QiXEz
         ShxytcF6L4DJgl8Nwy/zOaqERqvIpaYxZzM17f6n8tgyIVZdB1H9vzvl7je+3gK2wWUG
         ZBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704449849; x=1705054649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhTPtiU3ebbMMUs+zK0c151tFKxnFYC6rMwGCcNmmuI=;
        b=T4fn/33j6faqeaFMlp5ArO4DtFZmi+Obnc8MCc1MZdVhDovPsFGvfb0+gM7yGAr45Q
         kjzTvL/I2DNbpQ6rrmafJSy54+g1m4yL/fBPgsvSivM+rMfR86SHrL7y/7Pv1n4Vl8XD
         c3ZqIycBcfQVvABuXA3ug0IusjLz9KV0MxGegV0XZJGqygXH5fP3tnHck+HbD2xFpdbx
         /Wi/+XyYfkEccf5EKm0b+Qtpu3BbSawaz0VjjEWqmW1XlnsaZRpmY/R4JlLv9jMHuehn
         oQ4vJ9+0E6OU17/SHe+PnnREg+Nsvmr9TXUpyyPVufAQdzdxM0Bh996ZiU21lB/Qi7n4
         SsXw==
X-Gm-Message-State: AOJu0YxETTVBwg8vT15EfwXii00riF5434GNw7TcK3jV5NrzpJ5U4giq
	WwyUXdjKW1VLz9dI0RdhTDILSzIO0YEttdweGcWpWc1LGZwazA==
X-Google-Smtp-Source: AGHT+IGKL1ZE/btE1pbZWUoVkU6B5UzlJPmzxOF6Klg0Ce9+oqf2cNXwRxwkKPLOwFRjsyv1s0XB0EvHD3md0oZ192k=
X-Received: by 2002:a05:690c:4287:b0:5f5:6038:bebe with SMTP id
 gj7-20020a05690c428700b005f56038bebemr1311343ywb.53.1704449848844; Fri, 05
 Jan 2024 02:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208032145.2143580-1-ricky_wu@realtek.com> <20231208032145.2143580-4-ricky_wu@realtek.com>
In-Reply-To: <20231208032145.2143580-4-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Jan 2024 11:16:52 +0100
Message-ID: <CAPDyKFrcUPtPrENW_0_H9F8Hq4YBuK_MTpMSi+CdnNycQ6LDFw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] mmc: rtsx: add rts5264 to support sd express card
To: Ricky Wu <ricky_wu@realtek.com>, gregkh@linuxfoundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, frank.li@vivo.com, 
	u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 04:22, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> rts5264 can support sd express card, so add the id in sd express card init
> to do rts5264 register setting when the sd express card insert
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Greg, unless you think it's too late to get this in for v6.8, feel
free to pick this mmc patch too as a part of the series.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v3: split up mmc part from v2 patch
> v4: split new definition up from v3
> ---
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 87d78432a1e0..7dfe7c4e0077 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -7,6 +7,7 @@
>   *   Wei WANG <wei_wang@realsil.com.cn>
>   */
>
> +#include <linux/pci.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
> @@ -947,7 +948,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
>         /* send at least 74 clocks */
>         rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
>
> -       if (PCI_PID(pcr) == PID_5261) {
> +       if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
>                 /*
>                  * If test mode is set switch to SD Express mandatorily,
>                  * this is only for factory testing.
> @@ -1364,6 +1365,14 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>         struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>         struct rtsx_pcr *pcr = host->pcr;
>
> +       if (PCI_PID(pcr) == PID_5264) {
> +               pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
> +                               PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_2_5GT);
> +               pci_write_config_byte(pcr->pci, 0x80e, 0x02);
> +               pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
> +                               PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_5_0GT);
> +       }
> +
>         /* Set relink_time for changing to PCIe card */
>         relink_time = 0x8FFF;
>
> @@ -1379,6 +1388,12 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (pcr->ops->disable_auto_blink)
>                 pcr->ops->disable_auto_blink(pcr);
>
> +       if (PCI_PID(pcr) == PID_5264) {
> +               rtsx_pci_write_register(pcr, RTS5264_AUTOLOAD_CFG2,
> +                       RTS5264_CHIP_RST_N_SEL, RTS5264_CHIP_RST_N_SEL);
> +               rtsx_pci_write_register(pcr, GPIO_CTL, 0x02, 0x00);
> +       }
> +
>         /* For PCIe/NVMe mode can't enter delink issue */
>         pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
>         rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
> --
> 2.25.1
>

