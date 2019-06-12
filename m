Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB142A26
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFLPBV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 11:01:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36182 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfFLPBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2019 11:01:21 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so13224721ioh.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jun 2019 08:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shuAyQ1I56gj94KbjmRqaQ587FUaZO/1wGxqCAR2L5g=;
        b=PlV+nMutToRv04OH2F+XLtbhnslyOfEcI8J0bRHS8WmQi/VtgDhkhBr9A2CgPB6mMB
         NNZCT32sR0S3b5+qbq3xi7nRghZbOUskv6vIYDE5pxWaIKxziX13ESMGId+QSm2iQ/Qm
         JV3tciBYTvvujnJqBE431AfQJwUCf22B3lKqvz0Uor4e9Mpe30Joq8Tf1AbRyk6qOQFa
         V5iH9PooJ92pUju+6fiIDSDJ9jJIiSSQG89NeK/zqjxav0CXOwniNTPZIBeHofpsrmll
         H134GDEU7+4Vk5J8BxkIPbr0CUPD0DQ1n6ZiLlK3ehg6VaV/YLQ3MsGwbzIbCH5trDgx
         ztNA==
X-Gm-Message-State: APjAAAWVj2sAn56Ax1bBiKuMgtpoyD4e9DTg51vda41M++7GfT65KEMq
        IdtjChONfUnP/j75fvIDUdkP4A==
X-Google-Smtp-Source: APXvYqxvIw+gJmjqKDyUCtIwpfzNKI1enkSa94j5cWvjhBtpZNh9a80WqyvkTu1WUeUpW3gtHtseKQ==
X-Received: by 2002:a5e:820a:: with SMTP id l10mr33701840iom.283.1560351680686;
        Wed, 12 Jun 2019 08:01:20 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id n7sm5939759ioo.79.2019.06.12.08.01.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 08:01:19 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:01:15 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
Message-ID: <20190612150115.GA27989@google.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 12, 2019 at 03:36:25PM +0200, Ulf Hansson wrote:
> On Mon, 10 Jun 2019 at 20:54, Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> > Without this patch the block size would be set incorrectly when the
> > bus_width == 8 which results in tuning failing.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> > index b29bf4e7dcb48..dd21315922c87 100644
> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >          */
> >         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> >                 current_bus_width = mmc->ios.bus_width;
> > +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
> 
> This looks wrong.
> 
> mmc->ios.bus_width is not supposed to be updated by a host driver, but
I guess I left this part out: The O2Micro controller only supports
tuning at 4-bits. So the host driver needs to change the bus width while
tuning and then set it back when done. Ideally I would have used
`mmc_set_bus_width()`, but that is a core only function.

If `sdhci_send_tuning()` didn't rely on mmc->ios.bus_width to determine
the bus width, but instead read the HOST_CONTROL register then this
patch wouldn't be needed.
> rather the value should only be read.
> 
> >                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> >         }
> >
> > @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >
> >         sdhci_end_tuning(host);
> >
> > -       if (current_bus_width == MMC_BUS_WIDTH_8)
> > +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> > +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
> 
> Ditto.
> 
> >                 sdhci_set_bus_width(host, current_bus_width);
> > +       }
> >
> >         host->flags &= ~SDHCI_HS400_TUNING;
> >         return 0;
> > --
> > 2.22.0.rc2.383.gf4fbbf30c2-goog
> >
> 
> Kind regards
> Uffe
Thanks for the review!
