Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B16AA987
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbfIERBO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 13:01:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390887AbfIERBO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 13:01:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so1579271plb.6
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pWzNKsO9zb4GfvkoVMf49hr5/cgM+ei8Wv313+DROpk=;
        b=LzNGTOauQrHL8MgHfATX9kP+LQnVabOjtX19bA41tJYj7E/AQDKVK3Mw7SgrDXfrPk
         pR1gYD9RPWuGNNNFkvCQBUcuHzYj/FTESTp/6MgslZKgafzGZ1r1kVQnZmzLJkPsiwq2
         gEFW10B/Otte/51sBE0aheCGTCtVkXOLNxN8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWzNKsO9zb4GfvkoVMf49hr5/cgM+ei8Wv313+DROpk=;
        b=nS2jT2GbXeovxNuAKMkPwiNxUCSBxJ/5n5a89d15yX0H4vaap5tJQ4EE8hIdKMHDP9
         /gwFAW9iRoUXilOuJaK3pRiDCsGxd5ikRR8Bs7nGTN98xEP9pxp9sV1Rb7sglOmZ7oTQ
         IriqW0OI0V0Oo2SPtE19uCUC1FRqLlSKb+Y/UKmUPhsQAzBaXKN4+s+3fW3calkSJQKt
         sERseF3ZoOuCpvRHMzrPk64v7fuOL6jZaJ9DI7jlOVLBDdYauAM+kjGGn96IwcMWtIEw
         u/fW4qSfQdERJ7kZfL7uFIsUfnX7sWyD+wImdvn7LfYkuEOxy7r05ndxp9TxZM2Tf9P5
         bWlw==
X-Gm-Message-State: APjAAAWDoLcpbnnvU8UMkdXI3NrtamTcpZUKz/LNHljbDIcYitZM/J+9
        FECacjmAmKaW9hEi09zD8it8tA==
X-Google-Smtp-Source: APXvYqzqBP0/xDOKZMoJ1A0W/FYXyPFuwldBZjTH7Fwg0uT3cNgFMlhwfEzDkrzdSQwzhipHzrqD7w==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr4529187pln.343.1567702873480;
        Thu, 05 Sep 2019 10:01:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q20sm7207195pfg.85.2019.09.05.10.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:01:12 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:01:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system
 resume
Message-ID: <20190905170110.GJ70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-3-ulf.hansson@linaro.org>
 <20190905001422.GH70797@google.com>
 <CAPDyKFryCPu+VWGoc2CV3dgUN+aLNjH8BC5qPjsbCBpUKN=GqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFryCPu+VWGoc2CV3dgUN+aLNjH8BC5qPjsbCBpUKN=GqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 05, 2019 at 09:29:04AM +0200, Ulf Hansson wrote:
> On Thu, 5 Sep 2019 at 02:14, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> > > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > > the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> > > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> > > This means during system suspend/resume, the register context of the dw_mmc
> > > device most likely loses its register context, even in cases when SDIO IRQs
> > > have been enabled.
> > >
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
> > >       /* Force setup bus to guarantee available clock output */
> > >       dw_mci_setup_bus(host->slot, true);
> > >
> > > +     /* Re-enable SDIO interrupts. */
> > > +     if (sdio_irq_enabled(host->slot->mmc))
> > > +             __dw_mci_enable_sdio_irq(host->slot, 1);
> > > +
> > >       /* Now that slots are all setup, we can enable card detect */
> > >       dw_mci_enable_cd(host);
> >
> > Looks reasonable to me, besides the bikeshedding over
> > 'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
> > if SDIO IRQs is enabled").
> >
> > One thing I wonder is why this change is only needed for dw_mmc and
> > mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
> > newb?
> 
> mtk-sd and dw_mmc is using MMC_CAP2_SDIO_IRQ_NOTHREAD and
> sdio_signal_irq(). This is also the case for sdhci, but sdhci is
> already internally dealing restoring SDIO IRQs during system resume.
> 
> The other host drivers haven't yet converted to
> MMC_CAP2_SDIO_IRQ_NOTHREAD. I have a series for that, not yet
> completed and thus not ready to be posted. Once that happens, all host
> drivers needs to care about re-enabling SDIO IRQs durings system
> resume as well.
> 
> For those host that currently doesn't use MMC_CAP2_SDIO_IRQ_NOTHREAD,
> the core wakes up the sdio_irq_thread from mmc_sdio_resume(), which
> later will calls the ->enable_sdio_irq().
> 
> Perhaps I should add some information about this in the changelog, let
> me think about it for the next version.

It makes sense now, thanks for the clarification!
