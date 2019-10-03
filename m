Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C406C9B5E
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfJCKBL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:01:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41478 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfJCKBL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:01:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id l2so1269226vsr.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bakFfnlZF09kbsnlbZ07B9DU8D4j1dfMyTsDOBOw2b8=;
        b=DbrLz0wQAjSavOeMSjXt6eLcI/arNBJcEW7EqIxXilGcd6duieosUwjnEechJgMeH7
         18RjqkDYewx/zBv9IGUvFGpUds/tl49c9hfWciwEuGBba4pWy62tAR8NCUM4p8ogG+wc
         HqA3NSL9G57C/gnKsSrIYJSLYZ6BTWcKJDBa6j7QPZJ5OPl2kdQDYj0QrxOnaFAFe1MH
         lGpTBxh1NcxLD0pQ+igDcNKLUVQ4zMB4kobOhXiZeHmBWHmvNmt8gVxnLsQqFtpt0rYO
         Pke0fAcACw5+OYHeLmBwLpaynCvkSA5DzORKx9kmZxDi8/8T0Hm2pGCHPoCBr7iLXoxq
         v56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bakFfnlZF09kbsnlbZ07B9DU8D4j1dfMyTsDOBOw2b8=;
        b=lYlddNY5ZJMPqZ3fgxIx7IAETiXYbIeJ+6d1DJX6hL3ce/QmlT+kbBVREicEjXJDzT
         yJ/V5aLKNaNIc/liys5j6Xy/iZ2GNlvteI42qH827P2A2Rpqb6eluY1icqXTVQhzp9+/
         9IzBSUXib1IJEDRN9iBYddlTcWvTIDS3jFPiy1gwNMJaRGUYhLw8cOT1sn36UBt+efP7
         byz2FNNZ3e6402L/9jXbeyKu+ZgM0J6XhEkh+esvqdf4JcnEZL+fMBwD3CJMuJqAyNvR
         trgTJV/PpMvymXEVtyDuNm9CtIexLrpqa80GyqYTu8CLrDExj8Edktff04o6Hk5hoK7X
         QNqg==
X-Gm-Message-State: APjAAAWlKPE4nS4Vg4ZqGSnupVhBkB9p69057Scwfh24qOQmAEIWwBla
        YGuBjRF89gbQFagNvA/qwt3fNRHYPhWmZBJuN0NhRQ==
X-Google-Smtp-Source: APXvYqwAIMhOZpRi89+0NzMxZmnhLFx+VXEtGsfYDPPYmE6C974D2DxOHSxiXkhQa9E5JLVtEI71WvXwE7Xnttyw/eA=
X-Received: by 2002:a67:e414:: with SMTP id d20mr4531692vsf.191.1570096869917;
 Thu, 03 Oct 2019 03:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164625.236978-1-rrangel@chromium.org>
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:00:33 +0200
Message-ID: <CAPDyKFpy_bC=pngV8c6PuTYm4UGeH0FtQxGPSydCf8VB9MvH9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 18:46, Raul E Rangel <rrangel@chromium.org> wrote:
>
> In sdhci_do_reset we call the reset callback which is typically
> sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
> controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
> controller will clear the IRQ mask. If during that 100ms the card is
> removed there is no notification to the MMC system that the card was
> removed. So from the drivers point of view the card is always present.
>
> By making sdhci_reinit compare the present state it can schedule a
> rescan if the card was removed while a reset was in progress.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Sorry this took me so long to send out. I tested out the patch set on
> 5.3-rc5 with multiple devices.
>
> This patch was proposed here by Adrian: https://patchwork.kernel.org/patch/10925469/#22691177
>
>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..b0045880ee3d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -337,8 +337,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> +       u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +
>         sdhci_init(host, 0);
>         sdhci_enable_card_detection(host);
> +
> +       /*
> +        * A change to the card detect bits indicates a change in present state,
> +        * refer sdhci_set_card_detection(). A card detect interrupt might have
> +        * been missed while the host controller was being reset, so trigger a
> +        * rescan to check.
> +        */
> +       if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
> +               mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>
>  static void __sdhci_led_activate(struct sdhci_host *host)
> --
> 2.23.0.187.g17f5b7556c-goog
>
