Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE94CF3C
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfFTNo2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Jun 2019 09:44:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33752 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfFTNo1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2019 09:44:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id f20so1692752ual.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+YnV+oMLjW0P6RTstiqshtqFt17bIjNkv5P4D2/OJQ=;
        b=kw2ibHZqbYYW6AOPgpeVK1PXjnI96q4un0/OwJcq5Hc4oeQSDx08U22rkLVEcwO7ZX
         CaZGEA5xQ5mfUL+umGw5LMfqwJcFrSePc2txOy9lv8Rkt8ldgvHRhGNDhU5RaOmQ85iC
         rKaI0H47I2XBhdmuPiHUW5Y9bHOQw8f94SJCC4kFnM83QckUUTh3/Mqz79FpB/gDs32M
         iDpj8Gus6WlDYWAfSygtr0Vl8WyLbplJa62MiS4ajYO3CizRKwrPCaRAmlafxbAzQUEc
         KWUq/fcmhA4c4FfR1XdJwrJo0dbwoxsYDaRtzNIRMt/THmrnCRwpAtf1fHBvlNyn+O6t
         NKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+YnV+oMLjW0P6RTstiqshtqFt17bIjNkv5P4D2/OJQ=;
        b=eWrlX1F8FaYfDgPqCnP1TzHkka1sD8thAPEB8M/wUnr3umkT6UWquZ+mMYsGfSWkhN
         rHL+SefReoo1eIsPWFy3No8ryj5COLbeRLR2B7uN9VgcrZcuUg9GVKuW8YqhhPrDd87j
         dWAmYWyVXwU1E7lsRY92Amt213hvEfCOFQRp8LPiCV1sQuTuRlv/kOeB+QWNRzmZt4qh
         OlMN2ijnU1JHm711hq8MbfeHroTJP77ZS2G9nL45AErwMZBrl5XoCl0wlwgxcmKNfUaP
         tZ+h6Ix3NQBacrei98srk58uL4s+QV3qgHf7n1BsW0KEu2MpxHbec6KJHACxxymBnxQt
         79wA==
X-Gm-Message-State: APjAAAW4GUCcmZaKQBIf97RLOwieqRC2sJOlP05ty69P6rhCoA5BMZeB
        wCTygnVlTmJb0IqjxS/0RSDuaS1OHzaUjixTYJu4mw==
X-Google-Smtp-Source: APXvYqydm7KQW859SeL1dcMFLOlN61GULbDzhio3/AV2espp0iXHdT0wbIQQaVOvKtBJD2Q4pe2SEMDCFEKY4A19u4g=
X-Received: by 2002:a9f:242e:: with SMTP id 43mr8130620uaq.100.1561038266852;
 Thu, 20 Jun 2019 06:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190620094901.8539-1-adrian.hunter@intel.com>
In-Reply-To: <20190620094901.8539-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 15:43:50 +0200
Message-ID: <CAPDyKFpH_dbQGOPXuHj6ZPOciWL_pA--AJ9kQCaPEojxUViQSA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel EHL
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Jun 2019 at 11:50, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add PCI Ids for Intel EHL.
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
> index fa6a8fa560c3..4041878eb0f3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1668,6 +1668,8 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(INTEL, CNPH_SD,   intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, ICP_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, ICP_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, EHL_EMMC,  intel_glk_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, EHL_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e5dc6e44c7a4..cdd15f357d01 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -50,6 +50,8 @@
>  #define PCI_DEVICE_ID_INTEL_CNPH_SD    0xa375
>  #define PCI_DEVICE_ID_INTEL_ICP_EMMC   0x34c4
>  #define PCI_DEVICE_ID_INTEL_ICP_SD     0x34f8
> +#define PCI_DEVICE_ID_INTEL_EHL_EMMC   0x4b47
> +#define PCI_DEVICE_ID_INTEL_EHL_SD     0x4b48
>  #define PCI_DEVICE_ID_INTEL_CML_EMMC   0x02c4
>  #define PCI_DEVICE_ID_INTEL_CML_SD     0x02f5
>
> --
> 2.17.1
>
