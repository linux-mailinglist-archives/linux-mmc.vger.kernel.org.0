Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0399E359
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfH0Izu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 04:55:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43650 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH0Izu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 04:55:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id y7so6723367uae.10
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE1vxwmb0wJk7euHS77/2aYZOd8W3NYywy3hnx9W6dE=;
        b=vyci9hSyKJvHScoP8jzEioy8EeO6Zsl62MqHWvtS1/xyhkd2E06dpyMXzlEbFHaiAt
         5VnYE0lFlNbfdxnBk7hd2Oo870zBLoHxA8FkXluEAiGFdLZo7XoOp+TTVwn0K2U/Z/V6
         Od734OhPsRklbQPtjRYsZmOuWxVJBiRHE635dLn5S0xfEA0DLQkIH91IwkYEVn2zUlyn
         1LOz1xlrS4GmiY3ydm2rqoVwExj/fiejYOX0/ppe8QSN0Com75r9k/DHsbYUrn9CQKA4
         juwp+gpf+wgHL2s5wjYH5DOxHWeXCc9Du+f6u50WMdOgD5zyTzuyowFOd/NMOP6jqm3I
         IwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE1vxwmb0wJk7euHS77/2aYZOd8W3NYywy3hnx9W6dE=;
        b=Hs+4fJ5ON+kX5ClSwPDm7DorBxlgUMYt47XDE2hxwGRl3Q9u38jjkkjWGZOfEc+o54
         GQ//L3Yc/bRGE5BU8tjTLUCsiu5+TIQAFNQSYd8u+1Xe/uG1Ae+MoKKiqMalaSv5jxia
         +wEts/gnyXu8KFIHdi5RY2zZ+XRAqK/VewJSM0xAXwNsZInS+wTgPK4FvkXuJcxjT4Aw
         84HVSmYeDHNjnfHzMs15vJaO2n5FzlKJxW5XALeHXDXOfnLxOnugagH2FqHCLq0tpn6+
         io6igcDDicZoVi/jprt8CuRsPEDVq41SZGTmY6uEwmdir3wX7PrzKFZVl2YfewmnNgXZ
         /VyA==
X-Gm-Message-State: APjAAAVApzksXiUbYymC4yXbNwWX6IJDiuOlqNLI/0Ow9Du6xiub7TEc
        pDczXK1Abq+32HYovxnSRg1bKuWakoCJyYrmF2kl/VKf7UQ=
X-Google-Smtp-Source: APXvYqz81egUFeE3McVoqKtuZSLjW8kASmF/ftKS1j6j53DP0AYFhBaMIqNdAaQ4+E1t0JSViZ6o7Ve7oXEr7fJC1Kc=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr10606720uar.104.1566896149137;
 Tue, 27 Aug 2019 01:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180222.15960-1-philipl@overt.org>
In-Reply-To: <20190826180222.15960-1-philipl@overt.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 10:55:12 +0200
Message-ID: <CAPDyKFoPcEMmXzoetdNe=8YLixSswtnkf5AreXJDjNJfaWOZpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Don't attempt to use 'Low-Voltage' VDD for SD cards
To:     Philip Langdale <philipl@overt.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 at 20:02, Philip Langdale <philipl@overt.org> wrote:
>
> There have been multiple reports of failures for newer SD cards
> with Realtek readers using the rtsx_pci_sdmmc driver in recent
> months, including myself.
>
> One common theme was that Sandisk A2 cards all failed while older
> cards worked fine. The first reports in bugzilla showed up in late
> 2018 corresponding with the availabilty of these cards.
>
> After some false starts, what I realised was that these new cards
> have bit 7 set in OCR which means they claim to support the 'Low
> Voltage Range' for VDD. This is an incompletely defined concept
> in the SD spec - in fact, there is no precise voltage associated
> with the 'Low Voltage Range'. We have to go to the MMC spec to
> see that it is 1.65-1.95V.
>
> So, I believe there is currently no legitimate way for an SD
> card to operate in the low voltage range, and a card that claims
> support by setting bit 7 is simply wrong, although technically
> not out of spec. Because the spec doesn't cover how to handle a
> card that sets this bit, we really need to act as if the bit is
> not set and do normal VDD initialisation.
>
> And, in fact, this is exactly what happens in the sdhci driver.
> By default, it elides MMC_VDD_165_195 for SD cards, and there is
> core logic that allows different values of ocr_avail for SD and
> MMC (and SDIO, even).
>
> As such, an equivalent change should be made in the two rtsx
> drivers (pci and usb) to explicitly set ocr_avail_sd, leaving
> out the low voltage range.
>
> There's a valid question about whether this elidation should be
> moved into the core logic, so that we never try and bring up an
> SD card in the low voltage range, for all host controllers.
>
> For now, at least, I'm going to punt on that question and use
> the existing infrastructure to fix the driver I can test.
>
> I considered setting ocr_avail_sdio as well, but I noted that
> the sdhci driver does not do this implicit elidation in that
> case, and so didn't want to make the change blindly; I am not
> in a position to test it.
>
> Needless to say, after this change, the Sandisk A2 card works
> correctly.

Thanks for all the details in the changelog, much appreciated!

To put it simple. mmc->ocr_avail_sd|sdio|mmc should never have been
introduced in the first place. It's a workaround to something that
should have been taken care of better by the core layer, which you
also suggests.

>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201447
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=202473

Ah, I forgot to add these links in my just posted patch. Will do when
I apply, if the tests works as expected, of course.

Kind regards
Uffe

> Signed-off-by: Philip Langdale <philipl@overt.org>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++++
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index bd50935dc37d..ff78b2abfe8b 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1342,6 +1342,10 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>         mmc->f_min = 250000;
>         mmc->f_max = 208000000;
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
> +       /* MMC_VDD_165_195 is not really defined for SD cards. Ensure we
> +        * never attempt to initialise a card with the bit set in OCR.
> +        */
> +       mmc->ocr_avail_sd = MMC_VDD_32_33 | MMC_VDD_33_34;
>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 81d0dfe553a8..590c7c4c189b 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1311,6 +1311,10 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>         mmc->f_min = 250000;
>         mmc->f_max = 208000000;
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
> +       /* MMC_VDD_165_195 is not really defined for SD cards. Ensure we
> +        * never attempt to initialise a card with the bit set in OCR.
> +        */
> +       mmc->ocr_avail_sd = MMC_VDD_32_33 | MMC_VDD_33_34;
>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
> --
> 2.20.1
>
