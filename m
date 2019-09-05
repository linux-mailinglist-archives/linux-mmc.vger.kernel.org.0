Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C073A9BD4
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfIEHap (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 03:30:45 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33996 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfIEHao (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 03:30:44 -0400
Received: by mail-vs1-f68.google.com with SMTP id r17so909086vso.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQ0/S8VZ4qMRw3JK6ZvbKs3F/tCm6SUhf9G5EivQXdc=;
        b=UYM/4pTaMPGMdyfvPuMOZOCgbDH/G0Ni+FJW6pxskSIFTL+aEsPWoZPKHIpZVYyllZ
         8yTuO/J7O03xjHJca6yzh94hK3SAWnbDyuL+c+5JQ7cYVyukh/LoPPlGshjdY95pf3Lq
         S8qSUsurOi3OQJ6x1qVP+pXjj73B20oAABO7B9nw8tC3RGD2F+gvDbok1aUi+f3amBTZ
         KfR7KrQ1rWUfmzOSuuqdErJ2r97mXqWON3aUo/7cZRpLy2zOHTDluZtK5/EOLt0pUHXg
         w5llS0QPgMmCjT94tvyi6jNoJWFq4UBg0G4nVD6BQE2pyUuDklWOeY1R4pAGkpcsGu5W
         8lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ0/S8VZ4qMRw3JK6ZvbKs3F/tCm6SUhf9G5EivQXdc=;
        b=LyQXtOsI5hh6bz8nTfgjmIu0Fvr36mkMFweBSqxNxBSO5vdXKde/XbarVenN4dt12T
         eDEdf32zdAF1C3XXfHHzHdAqq8/phZ3KQtlXRns5qldLTWIcAx88Tg79eK9PIOgx5afX
         V1vXlOaOvw7KH9U4bGG9hnzb5SJaytx4FqI6pKZBBpfnj8RbGjOnc1XbHDJlr2Ifl/MO
         kTK7/uvTmw39ZFgj/R9NpTLTrVKO+zwzLPRgAMzYeGcNTwT/xZxA+HhpJ3hDaagf1jKX
         4R65UMBESBmZtdmBaJ3MhogSump5XWS+CMscBvXoxY7CdhEfNwB5Mm2KyyCwfs3TdbuK
         nFVw==
X-Gm-Message-State: APjAAAWJLl4F+o7DU6/+LyLUFm2QShGXJxFEmxW20exmVPJFYzKhHsKa
        r8yU+vjC4F0Sn3G5ds/62rwV13TAb9K52rhJNu8b8A==
X-Google-Smtp-Source: APXvYqxllVsWEAV7tGPP3LJ4W5SKkNdoOGohNtI9UJQVSXkxZfNZ3BhfODbGFkD56GQJlowJrS1LQqlNWZhtmrW118o=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr969126vsm.165.1567668644030;
 Thu, 05 Sep 2019 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com> <CAD=FV=Vwmj=LehhLCN5OBbEfNNXp9gULLYRoVV86HtqZBxvEjw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vwmj=LehhLCN5OBbEfNNXp9gULLYRoVV86HtqZBxvEjw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:30:08 +0200
Message-ID: <CAPDyKFqbr9Q-aDOf3t+nftw=a1vR95yHHo=-ieoT1fnQ1S-HCQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Using 180 sample phase if all
 phases work
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 17:44, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 3, 2019 at 7:28 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >
> > default_sample_phase is used to make sure the cards are enumurated
> > properly and will be set to 0 if not assigned. However, the sample
> > phase should depends on the tuned phase if running higher clock rate.
> > If all phases work but default_sample_phase isn't assigned, driver
> > set sample phase to 0 for this case, which isn't the best choice,
> > because we always expect to set phase to the middle of window. To
> > solve the following continually issues we have seen in the test, we
> > need set phase to the more stable one, 180, if all phases work.
> >
> > mmcblk1: error -84 transferring data, sector 1735064, nr 8, cmd
> > response 0x900, card status 0xb00
> > mmcblk1: retrying using single block read
> > dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
> > mmcblk1: retrying because a re-tune was needed
> >
> > .....
> >
> > mmcblk1: error -84 transferring data, sector 1728672, nr 248, cmd
> > response 0x900, card status 0xb00
> > mmcblk1: retrying using single block read
> > dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >
> >  drivers/mmc/host/dw_mmc-rockchip.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > index d4d0213..9ef9723 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -209,9 +209,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
> >         }
> >
> >         if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
> > -               clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> > -               dev_info(host->dev, "All phases work, using default phase %d.",
> > -                        priv->default_sample_phase);
> > +               clk_set_phase(priv->sample_clk, 180);
> > +               dev_info(host->dev, "All phases work, using phase 180.");
>
> This violates what is documented in the device tree bindings, which says:
>
> * rockchip,default-sample-phase: The default phase to set ciu-sample at
>   probing, low speeds or in case where all phases work at tuning time.
>   If not specified 0 deg will be used.
>
> Specifically:
> * You don't use "default-sample-phase" at all when all phases pass.
> * You don't default to 0 if not specified.
>
> Personally I think we could change the bindings to say: "If not
> specified 180 deg will be used" and then change the code to do the
> same.  If we wanted to keep the "stable ABI" that is device tree we
> could also just do the "180 default" for new SoCs and then manually
> add the device tree fragment to all old dts files.
>

Thanks for spotting this! Let me drop the patch and wait for a new
version from Shawn.

Kind regards
Uffe
