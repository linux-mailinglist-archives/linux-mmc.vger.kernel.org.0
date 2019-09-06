Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3587CAC216
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 23:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbfIFVhS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 17:37:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36753 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404402AbfIFVhS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 17:37:18 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so16138582iof.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NidIhVM02tPKbRZ5DwnVb5R6omkDxX7AIIG8GN/6+Rg=;
        b=ayHodLxvu5uXfkVz48qkl7kn1M+MpNK7uuaH1flUeiVMFQk7ng31rPd3uh2AfpTepG
         chBGLgs2Br+oSAnwcE1cCmKLe8GROWcN0n1LTELL7IjPu8w51PT8CGKFTzOM3a99m+2e
         4EFaAH4KvreE8+HxWyHpq210Z6IROH5khFlPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NidIhVM02tPKbRZ5DwnVb5R6omkDxX7AIIG8GN/6+Rg=;
        b=sRqUHOT+VR+gJqB72KXQUDqj918G8WxjjNLr8dYNm41oEZ5vUa0WXoKcKHVrJUEOyW
         b85Wxfl4aP93nf7vZGspbS5iVFF+Jgjjkdw/KenF1shWIg1xZYmBf2TevHe/vScz4WGm
         CCcSC0l7NnpThDTjea+uUyfc0rQ4VsiLW1B4jMUyzRF5Y2iGYs89D9eBA3aGcW7tb6dp
         Imk0IPfl7fRe1tgo/limu/7WRMy9mzjLsighBI62z75tJAVvjUnzRPdZ9We8Ufguzv/f
         w0LdMyRqh68Uz35lh8XdyoVR/XnUdRUSHwGrYuskxUpFhvFtTvltamox1g7PRErVFN86
         ScDw==
X-Gm-Message-State: APjAAAV7FVGBZQiKepy0G3HX2SXYL9IGrpo30Ctw/FgkgPWYMF1qQRqr
        Rz/cPEDUesxWVvg2t/mJpP1I+aWt3Wo=
X-Google-Smtp-Source: APXvYqw5NB5MRoH8SCzQusOeJwFB04z4+GWJchKAJw516M4pa52f647FlO+B6YzZYwDTVU3GLRJoOA==
X-Received: by 2002:a5e:8407:: with SMTP id h7mr13158078ioj.47.1567805837138;
        Fri, 06 Sep 2019 14:37:17 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id m67sm8595553iof.21.2019.09.06.14.37.16
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 14:37:16 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r26so16028648ioh.8
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 14:37:16 -0700 (PDT)
X-Received: by 2002:a6b:b445:: with SMTP id d66mr13600851iof.269.1567805836148;
 Fri, 06 Sep 2019 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
 <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com> <CAPDyKFo7j=m0OWuhspzY-viU0cg1xdYqu83D1sfDsqz54YngQw@mail.gmail.com>
In-Reply-To: <CAPDyKFo7j=m0OWuhspzY-viU0cg1xdYqu83D1sfDsqz54YngQw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Sep 2019 14:37:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsEYg8vKMwynNTH1uCo7bXhorG2ON2zjBhsBDBZeTYSw@mail.gmail.com>
Message-ID: <CAD=FV=XsEYg8vKMwynNTH1uCo7bXhorG2ON2zjBhsBDBZeTYSw@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi,

On Fri, Sep 6, 2019 at 2:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 6 Sep 2019 at 01:47, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > > the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> > > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> > > This means during system suspend/resume, the register context of the dw_mmc
> > > device most likely loses its register context, even in cases when SDIO IRQs
> > > have been enabled.
> >
> > Even if they weren't lost the resume code currently has this statement:
> >
> > mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> >    SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> >    DW_MCI_ERROR_FLAGS);
> >
> > ...so that would have clobbered any existing state even if register
> > state wasn't lost.  ;-)
> >
> > > To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> > > currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> > > the SDIO card, but this isn't the recommended solution. Instead, it's
> > > better to deal with this locally in the dw_mmc driver, so let's do that.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/mmc/host/dw_mmc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > index eea52e2c5a0c..f114710e82b4 100644
> > > --- a/drivers/mmc/host/dw_mmc.c
> > > +++ b/drivers/mmc/host/dw_mmc.c
> > > @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
> > >         /* Force setup bus to guarantee available clock output */
> > >         dw_mci_setup_bus(host->slot, true);
> > >
> > > +       /* Re-enable SDIO interrupts. */
> > > +       if (sdio_irq_enabled(host->slot->mmc))
> > > +               __dw_mci_enable_sdio_irq(host->slot, 1);
> > > +
> >
> > There's a slight bit of subtleness here and I guess we need to figure
> > out if it matters.  From testing things seem to work OK so maybe we're
> > fine, but just to explain what's bugging me:
> >
> > If we got an SDIO interrupt that was never ACKed then this is going to
> > act like an implicit ACK.  Notice that dw_mci_ack_sdio_irq() is
> > exactly this call because when the SDIO IRQ fires we mask it out.
> > ...then unmask when Acked.
> >
> > Specifically after your series is applied, I think this is what
> > happens if an interrupt fires while the SDIO bus is officially
> > suspended:
> >
> > 1. dw_mci_interrupt() will get called which will mask the SDIO IRQ and
> > then call sdio_signal_irq()
> >
> > 2. sdio_signal_irq() will queue some delayed work.
> >
> > 3. The work will call sdio_run_irqs()
> >
> > 4. sdio_run_irqs() _won't_ ack the IRQ, so it will stay disabled.
> >
> > 5. When we get to the resume we'll re-enable the interrupt.
>
> Correct.
>
> >
> > I guess that's fine, but it is a little weird that we might not really
> > be restoring it simply because it got disabled due to the clobbering
> > of INTMASK but also because we implicitly skipped Acking an interrupt
> > that fired.
>
> Let me comment on that, because there is actually two cases that are
> relevant here to be covered.
>
> 1. After the SDIO card has been system suspended, sdio_run_irqs()
> doesn't call the ->ack_sdio_irq() callback, as to prevents the host
> driver from re-enabling the SDIO irq (acking). This is to avoid the
> host from re-signalling the same SDIO IRQ over and over again when the
> SDIO card is suspended.
>
> 2. Dealing with the SDIO IRQ bit-mask when the host driver system
> suspends/resumes. This is host specific, but a common behavior is that
> the driver can't allow any IRQ to be managed by its IRQ handler in a
> suspended state. This is because the device (MMC controller) may be
> put into a low power state (no clocks enabled, register context is
> lost and not accessible, etc), which makes the device non-functional.

Yeah, if you look at dw_mci_runtime_suspend() you can actually see
that (at least in many cases) we actually disable the "BIU" clock.  I
believe this fully turns the clock off the controller and it can't
fire interrupts.

If I remember correctly the problem I actually saw before was that the
moment we turned the BIU back on in resume the SDIO interrupt fired.
:-P


> > I wonder if the correct fix is to just add an explit zeroing of the
> > INTMASK (so mask all interrupts) in dw_mmc's suspend callback.  Then
> > there's no possible way we could get an interrupt during suspend...
>
> Exactly. Other host drivers do this as well.
>
> Although note that the host device gets system suspended after the
> sdio card device, so there is still a window when an SDIO IRQ can be
> signaled. This is covered by 1) above.
>
> Also note that, in general it also depends on whether there is wakeup
> IRQ configured and how that wakeup might be handled. This is another
> story, which doesn't seem relevant for dw_mmc, at least not at this
> point.

I guess for now things will work OK so we can leave things as they
are.  If I see problems I can try masking all the interrupts at
suspend time, making sure that I don't mess up runtime suspend in
cases where we have a removable card using the builtin CD...

Thanks!

-Doug
