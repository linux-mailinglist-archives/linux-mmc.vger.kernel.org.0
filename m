Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD2DC340
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442495AbfJRK6z (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:58:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42083 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfJRK6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:58:54 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so3712456vsl.9
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xq0XeTp8rSB79QpebJebhP6Tobxg4wlnOahYdd9Ri0=;
        b=NSRAF8gD6DjPUCTulcWEbLYKTVhX/Qad1bhE82cX3GIis/FLXljk3wixTqgL1VioHP
         COLPrxqMD1jv2IhDUWpSpb4O7i4EkMW8t3oPH5QZ1GNTdO2B8RnNNqjNpkyltuD+k0QL
         vQzuMdmsl4bK3NfMDbue8jS5fCQ5y27y7bISpapIE/TzUpjmNiE8QH+T4/tGdmmW4eY7
         Lx7OMxafTLgojZJgUe3uK3eDreNDGde+E8c70Dp/yRnlNNQaYF141CV51P4HMXwtPLKl
         GPaX2PsYccIQCdOddL4ZZny10AJZEaUMOAbzrPFSCki7qnnmwgkjOCq9csXF2OTiqXJQ
         svaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xq0XeTp8rSB79QpebJebhP6Tobxg4wlnOahYdd9Ri0=;
        b=uOrlb4wlQeQ0vfJB32r74vRtrU10wLZ5ISKi1RgSCYNH8RcJE+0eWw2uV8mHs9TFl9
         ASHr5waZ5JHrZ3F/Kdrjk+/Oh5zDy/mUfHAY/OR+TG2iOAgiXLCUIgV5Hh3bD4QNzeNh
         TUDB4dMPLpb5s3Cnc4ue5NriLU8c3vEBXfthS2/vp8F7LLxEgLSKiajav7sgqsRtlBD3
         jpVBEzEsffZBL8K+pVvcmQtH13RKs5+cPlbjUjOKAdkCND03CL/tHz2i7Ik9M1NznxYL
         Oz7XDwwa3PDzTJMvbchqcAp5QhWHqQZ/FF/Qaz/cDXXe96jc31ooCTcasW9H1tP63hGU
         lgfQ==
X-Gm-Message-State: APjAAAWzdRj/+dCxgmqYkwU2mDxqkT9Sm+c6ypcqcZIeeWP/rWWnc/A/
        FXIexT0Hl2bE3srqJaOsN7zxaE0+sTQNOPk1NRlD6Q==
X-Google-Smtp-Source: APXvYqyZjY4ktBcsY1JQPHY8G3PSOJbxGfuQLb74HEcqU0HVx6AJ5Yeta2j0BJse8p7LdcSWZBarbSTu7EFKIZgNfV4=
X-Received: by 2002:a05:6102:104d:: with SMTP id h13mr5172480vsq.165.1571396333491;
 Fri, 18 Oct 2019 03:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191010124630.30977-1-adrian.hunter@intel.com>
In-Reply-To: <20191010124630.30977-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:17 +0200
Message-ID: <CAPDyKFpgSyf6ovVJKzj=w-=0+n=P30930p-N+=uzRqo0fxzf1g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel JSL
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Oct 2019 at 14:47, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add PCI Ids for Intel JSL.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 ++
>  drivers/mmc/host/sdhci-pci.h      | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 659878a8efb2..6534b4dc3466 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1722,6 +1722,8 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, JSL_EMMC,  intel_glk_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
>         SDHCI_PCI_DEVICE(O2, 8220,     o2),
>         SDHCI_PCI_DEVICE(O2, 8221,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 558202fe64c6..981bbbe63aff 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -55,6 +55,8 @@
>  #define PCI_DEVICE_ID_INTEL_CML_EMMC   0x02c4
>  #define PCI_DEVICE_ID_INTEL_CML_SD     0x02f5
>  #define PCI_DEVICE_ID_INTEL_CMLH_SD    0x06f5
> +#define PCI_DEVICE_ID_INTEL_JSL_EMMC   0x4dc4
> +#define PCI_DEVICE_ID_INTEL_JSL_SD     0x4df8
>
>  #define PCI_DEVICE_ID_SYSKONNECT_8000  0x8000
>  #define PCI_DEVICE_ID_VIA_95D0         0x95d0
> --
> 2.17.1
>
