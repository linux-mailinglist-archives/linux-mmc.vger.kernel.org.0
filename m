Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031A7AB4C8
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392868AbfIFJUV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 05:20:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42230 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbfIFJUU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 05:20:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so3594971vsl.9
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfmOoOmFYh7I5gmi1hAZ3xAsmvHB1oYcvXJ92oCi5CI=;
        b=hwh8WPP/EyLuCc3RxOgw8KcrKBmU4FqYJXq/gu5wKcnLVvYc3EAn42EFFhq0D46amq
         uRNMMoQly5Pe+yQcxR+7SUmaQsSdAHwXTjSwCdPLOKJkgfd1Yb708xXxGQuso3OrFml1
         HnyYUT7RyCDTUkzFeATysMRk7gXlxekmi19rAhozRKs/vvh8mBaiC9jl6pKrlchjIWOA
         MnxZm6elAvFto2/xxeuzfrnRchXuOoax/9Jdz6v03rGFL/LzlNjclZs02m/jUbBTWtIU
         OD7R9sLvnPleowL6SzyUiHp2Utb76xllA9GAIUl0rOqo8QBGbbMEf/3tx/SHA0gWSv+5
         H/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfmOoOmFYh7I5gmi1hAZ3xAsmvHB1oYcvXJ92oCi5CI=;
        b=cuZ4dxtChtySUM2l4yTyoFWppBdl9NKoFdwJuO6Gyiw8KaQsOnMvnln4I/fZ/Dh6nk
         YYaOTW2mkOeOH4644y3p31Mgq6qKG+v9xgWL7Pq3gCPbjrbZPAiFUWqAeBtcwbk8U/BQ
         x2nhRFpVzwJ5PCu1IHshtpDyjRw3YeJt9sKDiJ1CDPnmQ92JcLOK1yZYmpShVZ61TOGz
         qw3xpPrzoQBkSP+7RkTmHTzJXkTpZqFxj6O/O8C76LkBgKPtAeug2/Hx5b9xe/bvQTX4
         QKIxxjjZyIB2Hr9RodFEV52+19VPUSJRaQ+H8GXmA22nCKeVmGee+oMvYdWGzeIKkfKz
         SvPw==
X-Gm-Message-State: APjAAAVWvsrKb8EjRLGnuGtwWP3iwrNtUAFO19TJcW7o25+Dj0rKf1I/
        l+73Eo5fhosgg7OnqKCS6FMTr3LFViH564KUEXZE67QG
X-Google-Smtp-Source: APXvYqzbGcG5XDQ1v9EQGKBd5d/G9M+tCfIB8y08cnPsK9kHA178qGxnrZVH3QqvTokbOLHEUa9rJmO1Re6gk6GEH8U=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr4312569vsm.165.1567761619092;
 Fri, 06 Sep 2019 02:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
 <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
In-Reply-To: <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 11:19:42 +0200
Message-ID: <CAPDyKFo7j=m0OWuhspzY-viU0cg1xdYqu83D1sfDsqz54YngQw@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 01:47, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> > This means during system suspend/resume, the register context of the dw_mmc
> > device most likely loses its register context, even in cases when SDIO IRQs
> > have been enabled.
>
> Even if they weren't lost the resume code currently has this statement:
>
> mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>    SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>    DW_MCI_ERROR_FLAGS);
>
> ...so that would have clobbered any existing state even if register
> state wasn't lost.  ;-)
>
> > To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> > currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> > the SDIO card, but this isn't the recommended solution. Instead, it's
> > better to deal with this locally in the dw_mmc driver, so let's do that.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/dw_mmc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index eea52e2c5a0c..f114710e82b4 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
> >         /* Force setup bus to guarantee available clock output */
> >         dw_mci_setup_bus(host->slot, true);
> >
> > +       /* Re-enable SDIO interrupts. */
> > +       if (sdio_irq_enabled(host->slot->mmc))
> > +               __dw_mci_enable_sdio_irq(host->slot, 1);
> > +
>
> There's a slight bit of subtleness here and I guess we need to figure
> out if it matters.  From testing things seem to work OK so maybe we're
> fine, but just to explain what's bugging me:
>
> If we got an SDIO interrupt that was never ACKed then this is going to
> act like an implicit ACK.  Notice that dw_mci_ack_sdio_irq() is
> exactly this call because when the SDIO IRQ fires we mask it out.
> ...then unmask when Acked.
>
> Specifically after your series is applied, I think this is what
> happens if an interrupt fires while the SDIO bus is officially
> suspended:
>
> 1. dw_mci_interrupt() will get called which will mask the SDIO IRQ and
> then call sdio_signal_irq()
>
> 2. sdio_signal_irq() will queue some delayed work.
>
> 3. The work will call sdio_run_irqs()
>
> 4. sdio_run_irqs() _won't_ ack the IRQ, so it will stay disabled.
>
> 5. When we get to the resume we'll re-enable the interrupt.

Correct.

>
> I guess that's fine, but it is a little weird that we might not really
> be restoring it simply because it got disabled due to the clobbering
> of INTMASK but also because we implicitly skipped Acking an interrupt
> that fired.

Let me comment on that, because there is actually two cases that are
relevant here to be covered.

1. After the SDIO card has been system suspended, sdio_run_irqs()
doesn't call the ->ack_sdio_irq() callback, as to prevents the host
driver from re-enabling the SDIO irq (acking). This is to avoid the
host from re-signalling the same SDIO IRQ over and over again when the
SDIO card is suspended.

2. Dealing with the SDIO IRQ bit-mask when the host driver system
suspends/resumes. This is host specific, but a common behavior is that
the driver can't allow any IRQ to be managed by its IRQ handler in a
suspended state. This is because the device (MMC controller) may be
put into a low power state (no clocks enabled, register context is
lost and not accessible, etc), which makes the device non-functional.

>
>
> I wonder if the correct fix is to just add an explit zeroing of the
> INTMASK (so mask all interrupts) in dw_mmc's suspend callback.  Then
> there's no possible way we could get an interrupt during suspend...

Exactly. Other host drivers do this as well.

Although note that the host device gets system suspended after the
sdio card device, so there is still a window when an SDIO IRQ can be
signaled. This is covered by 1) above.

Also note that, in general it also depends on whether there is wakeup
IRQ configured and how that wakeup might be handled. This is another
story, which doesn't seem relevant for dw_mmc, at least not at this
point.

Kind regards
Uffe
