Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846F46A3D6
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfGPI3F (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 04:29:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46340 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbfGPI3F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 04:29:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so20115801ote.13
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAReaf3rIK7cjdNG/p1sH0aoz/zivoXItfETtanUzFI=;
        b=GylbGvQjevcMby7m1jmxXgt1he2d3TdFGOKlC06/ZL0yKsesMNofyKRjxUxvWLUZrH
         qoPnchqDL4UcXwmvCgWl0MFjV7GpoDwC4zhscGHO+rdLBaWWgGkTkOzO5I2jtBqxk+lu
         O9OFwwOPRUV1NmfFUF4GpPLHOmIbrFHiVrCpRtzMBz9oI1NY1o+OPOOACxr1sVGwwYIS
         jJNsQh/9iledp8Q9bKjwBsyYR5fY62KqMp/1C450DFk/E1zDnpm47uYafb5S/f5ig2dz
         yuSKAIIVlXcg4aZeuwrRn6JZoRYFX+LtibHW3LRdID+XlyTnVXhgVkwlHkV883zyWJHA
         SoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAReaf3rIK7cjdNG/p1sH0aoz/zivoXItfETtanUzFI=;
        b=t3ADTr0ogD5S+MERqrEvlS2kkHD8H7zvXH2OroSYupp1d4NaydZN0SL8rRyJYHLvhT
         awcagbqeRKiOjUS1V6wNNyj+ImmVsTjqQokGKL9/Ok696ZhYf9EWfcp8QU/JbpLEwSI6
         xxEw+x5cmAgXN6WzWvTPP/ar54nQcHiaNRLNbxHIQdGRAigT/cflHcPlQEHlV+tHOBYq
         yj3XEefaxW++nfjDRvG7NQSNXW6JpueDIqs9LgnjmJuhCOMPlmjdkDkyJkM/Fj60gFb6
         WSL6avTiYloUHOAzcjNqxs3TCNgCpHwajbqZ0njlJfHekcpJvc9r596y6J233y90X2ne
         HcCQ==
X-Gm-Message-State: APjAAAUtDHmoQ1yuvTBYph4EpsGcx4GaSrTNvAoroL+vM3NCwuS+zKqs
        xLHGvlJo14cLFlwi3jTLGSMILjy4tCiBSdZouo34Gw==
X-Google-Smtp-Source: APXvYqwuE4Wv2qF5DOBIyEzsKs55PgVwR5k1JI/tCcs06wJPbl14TlMa31Fvb0G8Jz64wW5exSFXZgiJbN/qQOS+IFs=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr15513286otn.247.1563265744191;
 Tue, 16 Jul 2019 01:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <b9cba2452c0166ef2fa69514d6ac8fbe7ee02883.1563259454.git.baolin.wang@linaro.org>
 <987d226b-5906-f403-d641-3c54430f1c9b@intel.com>
In-Reply-To: <987d226b-5906-f403-d641-3c54430f1c9b@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 16 Jul 2019 16:28:52 +0800
Message-ID: <CAMz4kuL0-2MNsU74b6gNaBA-mkfMOFGCdiffGc_GJiD4Xzzvdg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Jul 2019 at 16:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/07/19 10:31 AM, Baolin Wang wrote:
> > In sdhci_runtime_resume_host() function, we will always do software reset
> > for all, which will cause Spreadtrum host controller work abnormally after
> > resuming.
> >
> > Thus for Spreadtrum platform that do not power down the SD/eMMC card during
> > runtime suspend, we should not do software reset for all. To fix this
> > issue, adding a specific reset operation that add one condition to validate
> > the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
> > just reset command and data lines.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Add a specific reset operation instead of changing the core to avoid
> >  affecting other hardware.
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 603a5d9..174b566 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -373,6 +373,42 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >       return 1 << 31;
> >  }
> >
> > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +     struct mmc_host *mmc = host->mmc;
> > +     ktime_t timeout;
> > +
> > +     /*
> > +      * When try to reset controller after runtime suspend, we should not
> > +      * reset for all if the SD/eMMC card is not power down, just reset
> > +      * command and data lines instead. Otherwise will meet some strange
> > +      * behaviors for Spreadtrum host controller.
> > +      */
> > +     if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > +         !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))
> > +             mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> > +
>
> Here you could just call sdhci_reset(host, mask) instead of below.

Ah, right. Thanks for your comment.

>
> > +     sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> > +
> > +     /* Wait max 100 ms */
> > +     timeout = ktime_add_ms(ktime_get(), 100);
> > +
> > +     /* hw clears the bit when it's done */
> > +     while (1) {
> > +             bool timedout = ktime_after(ktime_get(), timeout);
> > +
> > +             if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> > +                     break;
> > +             if (timedout) {
> > +                     pr_err("%s: Reset 0x%x never completed.\n",
> > +                             mmc_hostname(host->mmc), (int)mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +             udelay(10);
> > +     }
> > +}
> > +
> >  static struct sdhci_ops sdhci_sprd_ops = {
> >       .read_l = sdhci_sprd_readl,
> >       .write_l = sdhci_sprd_writel,
> > @@ -381,7 +417,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >       .get_max_clock = sdhci_sprd_get_max_clock,
> >       .get_min_clock = sdhci_sprd_get_min_clock,
> >       .set_bus_width = sdhci_set_bus_width,
> > -     .reset = sdhci_reset,
> > +     .reset = sdhci_sprd_reset,
> >       .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> >       .hw_reset = sdhci_sprd_hw_reset,
> >       .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> >
>


-- 
Baolin Wang
Best Regards
