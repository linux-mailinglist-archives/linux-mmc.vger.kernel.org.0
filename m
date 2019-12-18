Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31DF1248F2
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Dec 2019 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLROCB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Dec 2019 09:02:01 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37734 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLROCA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:00 -0500
Received: by mail-vk1-f193.google.com with SMTP id b129so657523vka.4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz1h19VzIeNwnKhx3nD1VcRQdpafrozL28SaKmNOgvI=;
        b=AoCpwljcTKY1+JsxJ3rzOuOnovxbvk/PwRYVCN8POZcKPsc81pECcwSY493WwyYwPP
         D+A2b+H7gNT3er3zCECM28q4I+jplS44sp8pLg9fe098P+QkJP/JvMbNRXVo7ZNpzUAp
         6IRSUfmXeGUtjqqUT2KwAHiATyoosLtbUdpS+j1SPHXt2767N9n+JLwNfMBKPeK+LuJw
         bNPotznK/hqtiOvJQjR6gGewUX0MkTXlLe4ENqYLqYH6prLs0PG94VkTS74fTVbkZutM
         5OBBKbnrHbRinBlVum13RBoZk6U7w0XAN+YfUHPXNUaOuYkVJ3bu3/vNYrYbxFgFHSpS
         se5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz1h19VzIeNwnKhx3nD1VcRQdpafrozL28SaKmNOgvI=;
        b=MnqpKYafJYVjgfInhX6n+ANGgGj4XeiFpHRjHCjRfagju1CKtGsDzWvlS3lIYc19j1
         M4ueG9G428Xakjhhfk7n1pmDKNaiVmS5Xr67K4z+9QHJVkdQPATFKmyuNScy/6ZkGvXz
         HsHKwsX3IhrVkfYe7ENIdxGGaot7+HXtvOsEF35joSOnAC43gIWsrIHO9uPMU5hFn3fS
         zI3B1onGfrJpl6iGrlXYaXWls477nEOY/fX5B1Ydrk9/wTgEscGV3B8YY25bQwJrdlBU
         w2frig524WkzuNs/lKXIy5YJiDF+sGe2RhFYNdHyXp2nl7VN3uIxbsGCZ6XZKI3CfELS
         x/Tw==
X-Gm-Message-State: APjAAAWg9wEZk4Pbf0tPjUIGZ0aALiI7idocRq5CYN8tQeNjdei0Wjul
        UK2h8mxwWJ/fjyvf3/pBMz8OkisZNhfqFjpFVCEWvQ==
X-Google-Smtp-Source: APXvYqxH8Bay2DVEoQMDLV7S7ENw/4AIDy+INaNMvJmHVfUej0oDy6jnlhUcTRExrkkqxKNmkF84m+IOmWcwyE6D/JU=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr1841084vka.53.1576677719887;
 Wed, 18 Dec 2019 06:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20191216031842.40068-1-yangbo.lu@nxp.com>
In-Reply-To: <20191216031842.40068-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:23 +0100
Message-ID: <CAPDyKFp3bMAyoxzRH9E5CFpBvV-yhoqQs2XrNy5e3MmzxONczw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fix P2020 errata handling
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Dec 2019 at 04:19, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> Two previous patches introduced below quirks for P2020 platforms.
> - SDHCI_QUIRK_RESET_AFTER_REQUEST
> - SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>
> The patches made a mistake to add them in quirks2 of sdhci_host
> structure, while they were defined for quirks.
>         host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>         host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> This patch is to fix them.
>         host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>         host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> Fixes: 05cb6b2a66fa ("mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358 support")
> Fixes: a46e42712596 ("mmc: sdhci-of-esdhc: add erratum eSDHC5 support")
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7f87a90..4ca640e 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1300,8 +1300,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
>
>         if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
> -               host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
> -               host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +               host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
> +               host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>         }
>
>         if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
> --
> 2.7.4
>
