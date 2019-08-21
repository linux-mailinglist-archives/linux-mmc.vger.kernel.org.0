Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4176797DC1
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfHUO40 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 21 Aug 2019 10:56:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37928 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHUO40 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2019 10:56:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id 62so1564091vsl.5
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2019 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCMAZdMf+8+yInNA3Z0vIOOX/l/WvB2RS8h3Yib247A=;
        b=luCNmZvp4Ue4syKCQ9/cwLu/+Wx6g/u2eXpj2Sp8lm7dckdZ/5S7B0Y9iFgw1kEVIo
         iUJH7MxhMgPxvOuOGm6FoqyQX41FU3PzYYO+U6qNI495gL4rMVRdJ4IdNLN5WRpFCSNM
         qWMwMfn6EZzrykezLwsdnhsTk/LF4Y7cDT/ghNg0dqGJRqse3kGJTXdVA2onoL11cMCu
         XvEx9x587AmyJdS72slb6G9mQS7fUlI5HCJCHfV5SJjmUgTEpDHiA7JHOa9RtCN2Pfxx
         9qab7BLBYK8pzHJWMuInlcBpVW6a5KWJ1S0Bp49sKu/icqiDFH9BE1cViVJHT8X/fVaq
         6YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCMAZdMf+8+yInNA3Z0vIOOX/l/WvB2RS8h3Yib247A=;
        b=jOs4stVRXm+vS1coGUZCRkcQ9n9c0D1+eaax3AnfgNKrPuK1V70uZPlUpkx26sFp4y
         sFTH/87ioAqPegQ9uET9ZEI73v+sThJu/FoWpaMf+hmu8alTWd6h0lKH+EVZr+ObWz+y
         G+iF+0S4VGRnDJIOEL7ungNntm8htjSFCWCuO2SLDqGHQvZZX1VsgDAt+u2fOYW6lZKl
         ByF51mC9YWopyO/Nyw3onGfuv8WPnSE0SYCJQljX+02rznAO7dnAWDOo4F7F00/zGExu
         HlJEm7aax5/jfiKtOZU92sLM0eLrxpoNyInH7niurbWQUCtQOViHRgt/rO0kaOQdpZfI
         hNKA==
X-Gm-Message-State: APjAAAXCP+PrPvKXRLUM9AGOiPun1tqS6srBFGIhM9F1ktnKiioY/Uqu
        s2TiDn8a62sZFpgxydQ4In0OnrL9YHvcLxH1lhPoQpUbzzA=
X-Google-Smtp-Source: APXvYqyjDQcbeEyMFIC0exbWSfSiewJqYVMV6vOnbHuYQxi3II5kuXDri+0jB54YZQUFIe0H1yr8XPZyiNkMKlMQEkQ=
X-Received: by 2002:a67:347:: with SMTP id 68mr15690306vsd.35.1566399384540;
 Wed, 21 Aug 2019 07:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190811021917.29736-1-philipl@overt.org>
In-Reply-To: <20190811021917.29736-1-philipl@overt.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Aug 2019 16:55:48 +0200
Message-ID: <CAPDyKFr5z4YknbS4_9NmzQ0TMHf+SqGxd5HyMGi4oeXAWFeSHw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
To:     Philip Langdale <philipl@overt.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 11 Aug 2019 at 04:25, Philip Langdale <philipl@overt.org> wrote:
>
> There have been multiple reports of failures for newer SD cards
> with Realtek readers using the rtsx_pci_sdmmc driver in recent
> months, including myself.
>
> One common theme was that A2 cards all failed while older cards
> worked fine. The first reports in bugzilla showed up in late
> 2018 corresponding with the availabilty of these cards.
>
> I did some experiments and saw that removing the
> MMC_CAP2_FULL_PWR_CYCLE cap from the driver made the problem
> go away. That then causes us to ask why it helps. This cap was
> introduced to provide a way for a host controller to indicate it
> can fully power cycle a card. Then in ce69d37, we introduced
> power cycling a card as part of changing the operation voltage
> of the card.

First, let's align on the terminology.

"vmmc" is the power to the card. Normal range for SD cards is 2.7V to 3.6V.

"vqmmc" is the I/O voltage level. Legacy SD cards supports only 3.3V,
while UHS-I cards supports both 3.3V and 1.8V.

>
> Now, this is the part where I'm under-informed, but reading the
> SD spec, it says that the card will reset to 3.3V operations on
> a power cycle, which seems to make sense, as it always has to
> be negotiated.

To clarify, the vqmmc (I/O voltage level) internally expected by an SD
card after a reset (even after a soft reset with CMD0) is always 3.3V.

For vmmc, it's okay to stick to a pre-negotiated voltage level after a
reset. That's actually already what the mmc core does, during a system
resume.

>
> Then, we observe that A2 cards are _required_ to support low
> voltage signalling (1.8V) and this is, I think, the only host
> visible difference in A2 vs older cards. And in my testing
> (with a deficient set of cards, I admit - I'm away from my
> main collection), I see that the A2 card does indeed get
> switched to 1.8V while older (pre-UHS) cards always run at
> 3.3V. I unfortunately lack any UHS pre-A2 cards to test
> whether 1.8V capable pre-A2 cards fail or succeed, but I
> would expect them to fail (and maybe no one was making 1.8V
> cards routinely until A2).
>
> This leaves me slightly undercertain as to the root of the
> problem. Perhaps the issue is that the driver should not have
> ever set this flag, because the hardware doesn't actually support
> the functionality that the flag corresponds to. Or, perhaps the
> problem is that power cycling on setting the voltage is never
> correct for an SD card, or only correct for eMMC, etc.
>
> There are a handful of embedded controllers that the cap is set
> for in device tree and the rtsx controllers (pci & usb) are the
> only 'traditional' drivers that set the cap. As such, I think
> the most likely explaination is that the cap was incorrectly
> set in the first place, based on a misunderstanding of what
> it actually means.

I admit, it's a bit unclear of what MMC_CAP2_FULL_PWR_CYCLE means for SD cards.

For eMMC it's rather straight forward; it means the host supports to
power cycle *both* vmmc and vqmmc. This is needed to reset the
internal state of the eMMC (useful when another HW-reset option isn't
supported).

For SD cards, being able to power cycle vmmc is sufficient, as the
internal logic of the SD card should be reset by cutting vmmc.

In other words, if your host can power cycle vmmc, it seems correct to
use MMC_CAP2_FULL_PWR_CYCLE.

>
> So, let's stop setting the cap, and observe that A2 cards
> now work correctly.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201447
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=202473
> Signed-off-by: Philip Langdale <philipl@overt.org>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index bd50935dc37d..1d7c942fc7f3 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1345,7 +1345,7 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
> -       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
> +       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP;
>         mmc->max_current_330 = 400;
>         mmc->max_current_180 = 800;
>         mmc->ops = &realtek_pci_sdmmc_ops;
> --
> 2.20.1
>

I am not convinced that the patch is correct, but I may be wrong. A
few things that I wonder about.

1.
To support switch UHS-I SD cards into 1.8V I/O, the host should
implement the ->card_busy() host ops. This isn't the case for
rtsx_pci_sdmmc.c  (you should see a  warning printed to the log
"cannot verify signal voltage switch" during the card initialization),
but instead it internally tries to deal with the 1.8V I/O voltage
switch inside its ->start_signal_voltage_switch() ops.

It looks fragile to me. No matter what, I think it's a good idea to
convert into using the ->card_busy() ops.

2.
The mmc core expects hosts that supports 3.3V and 1.8V I/O, to be able
to move from 1.8V back to 3.3V. Perhaps that path isn't so well tested
for rtsx_pci_sdmmc.c and maybe it's a good idea to make sure this
works as expected.

Kind regards
Uffe
