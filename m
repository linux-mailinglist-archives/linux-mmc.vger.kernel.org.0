Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B09339CD
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFCUeP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 16:34:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38679 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFCUeP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 16:34:15 -0400
Received: by mail-io1-f68.google.com with SMTP id x24so15478821ion.5
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 13:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05jpxIqovpSHGISvkH2VBhPPry9q9KrYsniszI/AFeQ=;
        b=NSJRNWlSXUWmI9DTHo12sP4136LMvdrVd0UbQLfN+rcVLuQ5pOzrq8Z1eiOhgY1cRu
         p5zz4U4SmcaQI6Wop06cZFq10Rl4CyOhXyTu19g/yEiTUz3OVMym0uboWluFmO8D9ULm
         9Gxwe+ZBnVzilVUx5p0FC9bZGl63xtKiZb1J9I9clW/RSD23NkVvOxCy3C0dKq6sQh0X
         gasuKXD2JAABc23HpcK+jJEsGEkoTqbohap5OXHz/3SV7TZbCcdaMZJXAlOmzI0J8il3
         gQ8eFSoNy90johApn2R/7j2YPOQiMkD0AQxfoPXP8weyToaZ3mtMKSsSYu063bllQtx8
         /ylQ==
X-Gm-Message-State: APjAAAU/V/vvmD6P8Gi5G/4QiapmgXjpZZ+WAn22ewyp/u5doJ2oUmzf
        QPezFOKifZk4onqrbPM1Y/vskA==
X-Google-Smtp-Source: APXvYqwSgnPCgLyJ/HOQQGXXZVVQa5hxXZxtgaD5o9IDsPNb9iiqrWWPKrRIDJFED5rn4INcgc2dYg==
X-Received: by 2002:a5d:8f99:: with SMTP id l25mr16677015iol.92.1559594053795;
        Mon, 03 Jun 2019 13:34:13 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id r139sm7147741ita.22.2019.06.03.13.34.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 13:34:12 -0700 (PDT)
Date:   Mon, 3 Jun 2019 14:34:08 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Message-ID: <20190603203408.GB182838@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <CAPDyKFq8T0kdJsPfk6ue2OaQUO9L_oOwnxDw=-FVboZRyKJPdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq8T0kdJsPfk6ue2OaQUO9L_oOwnxDw=-FVboZRyKJPdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 28, 2019 at 09:41:07AM +0200, Ulf Hansson wrote:
> On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> > Otherwise it can get into a bad state where the DATA lines are always
> > read as zeros.
> >
> > This change requires firmware that can transition the device into
> > D3Cold for it to work correctly. If the firmware does not support
> > transitioning to D3Cold then the power state transitions are a no-op.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> 
> Does this also solve the problem you tried to fix in patch1, without patch1?
Patch one is required. Otherwise there is a possible race condition
where the card remove is not detected. I'll go through the comments you
added on the first patch.

> 
> Should this have a stable tag?
I would not put a stable tag on this patch series yet because there is a
possible resource leak in 4.14. See https://lkml.org/lkml/2019/5/13/763
If we can get those patched merged then I think it's fine to backport
the patch set. 4.19 doesn't suffer from the resource leak. I haven't
audited anything before 4.14 though.

Thanks,
Raul

> 
> Kind regards
> Uffe
> 
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 99b0fec2836b..532fbcbd373b 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/gpio.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/mmc/slot-gpio.h>
> > @@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> >         return 0;
> >  }
> >
> > +static u32 sdhci_read_present_state(struct sdhci_host *host)
> > +{
> > +       return sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +}
> > +
> > +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> > +       struct pci_dev *pdev = slot->chip->pdev;
> > +       u32 present_state;
> > +
> > +       /*
> > +        * SDHC 0x7906 requires a hard reset to clear all internal state.
> > +        * Otherwise it can get into a bad state where the DATA lines are always
> > +        * read as zeros.
> > +        */
> > +       if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> > +               pci_clear_master(pdev);
> > +
> > +               pci_save_state(pdev);
> > +
> > +               pci_set_power_state(pdev, PCI_D3cold);
> > +               pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> > +                       pdev->current_state);
> > +               pci_set_power_state(pdev, PCI_D0);
> > +
> > +               pci_restore_state(pdev);
> > +
> > +               /*
> > +                * SDHCI_RESET_ALL says the card detect logic should not be
> > +                * reset, but since we need to reset the entire controller
> > +                * we should wait until the card detect logic has stabilized.
> > +                *
> > +                * This normally takes about 40ms.
> > +                */
> > +               readx_poll_timeout(
> > +                       sdhci_read_present_state,
> > +                       host,
> > +                       present_state,
> > +                       present_state & SDHCI_CD_STABLE,
> > +                       10000,
> > +                       100000
> > +               );
> > +       }
> > +
> > +       return sdhci_reset(host, mask);
> > +}
> > +
> >  static const struct sdhci_ops amd_sdhci_pci_ops = {
> >         .set_clock                      = sdhci_set_clock,
> >         .enable_dma                     = sdhci_pci_enable_dma,
> >         .set_bus_width                  = sdhci_set_bus_width,
> > -       .reset                          = sdhci_reset,
> > +       .reset                          = amd_sdhci_reset,
> >         .set_uhs_signaling              = sdhci_set_uhs_signaling,
> >  };
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
