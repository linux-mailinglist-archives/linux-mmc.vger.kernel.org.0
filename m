Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F57FD53
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfHBPQw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 11:16:52 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44019 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfHBPQv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 11:16:51 -0400
Received: by mail-ua1-f66.google.com with SMTP id o2so29825885uae.10
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzCmRSUD3Yw1j95NclpJTRSw/F1wkFgd+JZBAOUBf9w=;
        b=F8qhnZDFaGwCeX2/KlWpfLC+Fz+xFcyQK1mofcCzrZqwa+KjQiRZIIjSKObVIaXxSG
         lBW9x70Idy5Be6ivrRAwDjO6YIjJKb39hbjwMXx0YtXnPeID4WuVd6JnMg9f3Pu80hda
         yleZOkcZoUbA8JQZgMEFHvMymU3NDPknsC2FADMgYFn4ScxWU1K1b3ZYGNFkYXKcI+Bj
         IXFjAjdDv99kVCp2qWyHrcd8FTQtDl+Qrjjejo52WeSf3HgzGMY1cqLibvRiJ97vPhRq
         hsm0Z5fbsEUn4Tiq9RaPfM5d++sMUMVyI/wlO0XJNAlbkbCVwxAZx65Z99QXbxvsXL2Z
         llaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzCmRSUD3Yw1j95NclpJTRSw/F1wkFgd+JZBAOUBf9w=;
        b=O1x68g1n34NjsSqcTEbrGj4snRs5eUOPAsF/xOdRrC08ar07KV7XRorInOhIUfOJS9
         PmIXxZlSVLpLaw8TAq1i+RXViPGEL/dJH1MxOL2rNv7hGCGay0jqQqD+rgzjqEVJPhZd
         hPL9uQlwoY28pgZcrjdJ/4kPhmQVl3mtbs+FwsD/P9vQMVAGCtH/LW49IBr8Qt/tg1mh
         aXpKhaa/LDLqJVM8C4l6hxgA7GBLesfQDW4Nx0DvcRKv76ivNj2DCA4rr7Mh4be2MdKg
         QAjK/MuhpvQnAK7PhOxzKc/RYmHjgVfJETgT/1Ew6wmTLfH6h+/9IuNPUiQKtZvEhVPO
         DazQ==
X-Gm-Message-State: APjAAAX7z616GHDre/cvnviSoP/S4esCfhMprtMqNoCbJzZmtROix+U8
        nLoUhMScAtfc7Wb3SWTDWmOgv/ePiXmsmCLqvvjjyQ==
X-Google-Smtp-Source: APXvYqydOkSz0W91aws3vkgzA8b65rxBdM8mAAgkpODpZ9gacEoI0vSG2lwH3xqYupJGRINzmn9jZ3fSLz5mNT6NaQc=
X-Received: by 2002:ab0:5973:: with SMTP id o48mr7366761uad.19.1564759010814;
 Fri, 02 Aug 2019 08:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190730060723.21715-1-adrian.hunter@intel.com>
In-Reply-To: <20190730060723.21715-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:14 +0200
Message-ID: <CAPDyKFqKQw95aP+dDEz_EWW6AGa1NPQcMpm8xJb0LSFsRiXr6g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add another Id for Intel CML
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Jul 2019 at 08:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add another PCI Id for Intel CML.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>  drivers/mmc/host/sdhci-pci.h      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 30d6051cd1d5..e1ca185d7328 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1672,6 +1672,7 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(INTEL, EHL_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
>         SDHCI_PCI_DEVICE(O2, 8220,     o2),
>         SDHCI_PCI_DEVICE(O2, 8221,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index cdd15f357d01..1abc9d47a4c0 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -54,6 +54,7 @@
>  #define PCI_DEVICE_ID_INTEL_EHL_SD     0x4b48
>  #define PCI_DEVICE_ID_INTEL_CML_EMMC   0x02c4
>  #define PCI_DEVICE_ID_INTEL_CML_SD     0x02f5
> +#define PCI_DEVICE_ID_INTEL_CMLH_SD    0x06f5
>
>  #define PCI_DEVICE_ID_SYSKONNECT_8000  0x8000
>  #define PCI_DEVICE_ID_VIA_95D0         0x95d0
> --
> 2.17.1
>
