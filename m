Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5BA9BC3
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfIEH3m (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 03:29:42 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46667 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfIEH3l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 03:29:41 -0400
Received: by mail-vk1-f193.google.com with SMTP id 130so251196vkn.13
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBfs4YkHZgtMLprfzNd0i3dDb2iTuL+OjOCmqmK9w1M=;
        b=vvlTxI5a5SLMaTrqP9ZEdG5a/NyJ9OtSDs05uwqN9iYWj8F4/xZeN2pHdwBofFvxtR
         FE1p1toqXbV8+T75o7w/W4d0rsxQcKhddqNHveuteEB7kS5IjLaQEypmYCPAk7Awz+uk
         UOawqVHAkxsO+dMNUDlcq6x2Oews9PvEHKbx2BRNDFXQ7SaMyYsGM5LwL87JcEhDCf11
         uyZaRdBAb0jCOkNnMz3N38yYr1eeCU4W3RNwBT+6Ag+YmhqJ9GhByE51mtuR8KG/g9NQ
         aSHUa5uMHWUpSbNKXC1kVcdEwAkxg94H9PYUmILtSkJIgSPMBLAQlQ0ZneIwB8r3LX7u
         aEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBfs4YkHZgtMLprfzNd0i3dDb2iTuL+OjOCmqmK9w1M=;
        b=ibaeK7qg4Rv7nrXPgY4IurICYq85LpdLPwe7ipsd7xVvmt9yd03lzLwZq2X5E354LW
         rbMPW1QS0V9xiN2/92rPkTecknjAmknVz+Hq9en7nfdtTZbBqEYEWXsArrxRo07ACDBx
         UOzvmX1E5ex76ye6MvX0s+77akmBzVCuLTu4jP8qZQ2+OwF1LVeoTDUwsduiRXIwTeqQ
         IRNt6FLNdm2sO3wUXjUc8CBb1Rb9e0vsjGT0Y3O0F4c/iBPelKm+e7a8MIvb5I1KPuxb
         JcVCF2cIQYO9SLpaRsEnBrUtolIh2f9iFZ+PAvAqp1UILuyGQIgeN7ZPNFcQ5xlkSkPZ
         0kaQ==
X-Gm-Message-State: APjAAAW6kRq2O79x0gRTfTy8e+o0n2lu7OrcCwje9/OIeOh028+s+HRa
        IqJP643OMbR6KwS8YrZkdjXc+cfZLzjvkEYNSvOEgA==
X-Google-Smtp-Source: APXvYqwcWUJBRRXfpd2mPOlpgDJEpvpFsrXG9kvj6xlKXECr6mPtD638auCxApkUIpWoI7nQ2nUt1SJsJaHOl04CPlc=
X-Received: by 2002:a1f:5602:: with SMTP id k2mr755971vkb.36.1567668580847;
 Thu, 05 Sep 2019 00:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
 <20190905001422.GH70797@google.com>
In-Reply-To: <20190905001422.GH70797@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:29:04 +0200
Message-ID: <CAPDyKFryCPu+VWGoc2CV3dgUN+aLNjH8BC5qPjsbCBpUKN=GqQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 02:14, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> > This means during system suspend/resume, the register context of the dw_mmc
> > device most likely loses its register context, even in cases when SDIO IRQs
> > have been enabled.
> >
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
> >       /* Force setup bus to guarantee available clock output */
> >       dw_mci_setup_bus(host->slot, true);
> >
> > +     /* Re-enable SDIO interrupts. */
> > +     if (sdio_irq_enabled(host->slot->mmc))
> > +             __dw_mci_enable_sdio_irq(host->slot, 1);
> > +
> >       /* Now that slots are all setup, we can enable card detect */
> >       dw_mci_enable_cd(host);
>
> Looks reasonable to me, besides the bikeshedding over
> 'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
> if SDIO IRQs is enabled").
>
> One thing I wonder is why this change is only needed for dw_mmc and
> mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
> newb?

mtk-sd and dw_mmc is using MMC_CAP2_SDIO_IRQ_NOTHREAD and
sdio_signal_irq(). This is also the case for sdhci, but sdhci is
already internally dealing restoring SDIO IRQs during system resume.

The other host drivers haven't yet converted to
MMC_CAP2_SDIO_IRQ_NOTHREAD. I have a series for that, not yet
completed and thus not ready to be posted. Once that happens, all host
drivers needs to care about re-enabling SDIO IRQs durings system
resume as well.

For those host that currently doesn't use MMC_CAP2_SDIO_IRQ_NOTHREAD,
the core wakes up the sdio_irq_thread from mmc_sdio_resume(), which
later will calls the ->enable_sdio_irq().

Perhaps I should add some information about this in the changelog, let
me think about it for the next version.

Kind regards
Uffe
