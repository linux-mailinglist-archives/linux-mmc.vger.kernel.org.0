Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DFC37924F
	for <lists+linux-mmc@lfdr.de>; Mon, 10 May 2021 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhEJPRD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 May 2021 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbhEJPQA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 May 2021 11:16:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296FC08E9A3
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 07:42:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t11so23660319lfl.11
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGZx3IHlZolc8cpiUp7UZIMaVX9aP3c8CsMB4Q5ljJQ=;
        b=QQ51fpoXpyNz4qMgniyay13YXJ5B8HSlgu7JIjxKmsIZ+udNaVEPDeEocaZNmn+d9m
         OdNcQWPnKD+TFmlwf+gA2nmWPYTnm32vb/fSV8YGs8EFYv9VrVQ4FaDm8pGRydg/22fd
         Imn0FMzKzzfwxv+UHRncvPvwAdUWxgGkzScrQrbMq8zaGdfIqCcg4VHpMqvnIO3I0nAa
         Tb6eJP8DPzFkIRBYglU7NjATrZtQ4YYG2wNFMnH2d5CzHWSLwlWMjzg5/YF0C2gCe3H2
         raUHkfi/Z0VuD3JldFYqp9BSWbtqyZ9HBNLYWZ02P2acCIyLcPO/OyPp6HIqgs5Uzy7C
         BDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGZx3IHlZolc8cpiUp7UZIMaVX9aP3c8CsMB4Q5ljJQ=;
        b=XW5slPnLZiIMaL0UzDi0D005uKz2nrK9kDj+xiHk/lUFbpg9uXOZ6r1LA34qSqwwGP
         R0VzMtSLnQVTryhbSB/Rj/3Ygsgd9ct9VaSy4znpnN5Gas7vLc+C1uJYGAK19FbbhbGP
         Al2fz/xtSpbALbQZ+GjcIWcPx8nrg86wWoLOuho1B02qdAvvN7pcPr2vonze7BDEfkXe
         XAXr4h4XtBujbvYsFcPMjuNNwVgrEgxCQNlvs2Hum4BPpGA+xjovmrSqEPS7TPt93Ow/
         Di4YDKeAsugcDIst8rKO8/PHTt1yOZjIcatBKz0M6wUyGAb1f5SoTaXxU1BSVCBaFpL2
         UZkQ==
X-Gm-Message-State: AOAM532qBGTN7PCrpoNXd/CuvZdjBxe1+tS7Y3ie8/sczI2GtkXwk8uY
        GC0KHa8TkwomqCWXWU4u1vKYzQPOLw6nD6iTs8ua0Q==
X-Google-Smtp-Source: ABdhPJyfG7JHyVEwZrQS2Vo/RcFCtBOHS0tLDhi9jJ1UCOrRbqTpbVKYkmsNQnjRFS/cLprDT3ykeyzmBFpXfguHMvY=
X-Received: by 2002:a05:6512:3e14:: with SMTP id i20mr16631717lfv.142.1620657739885;
 Mon, 10 May 2021 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org> <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 16:41:43 +0200
Message-ID: <CAPDyKFrvhNntCAWdyN5Kw8znq4RKE6yQS5G38XYY5iBhqMW0Pw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 May 2021 at 11:10, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > +static int sd_enable_cache(struct mmc_card *card)
> > +{
> > +       u8 *reg_buf;
> > +       int err;
> > +
> > +       reg_buf = kzalloc(512, GFP_KERNEL);
> > +       if (!reg_buf)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * Set the Cache Enable bit in the performance enhancement register at
> > +        * 260 bytes offset.
> > +        */
> > +       err = sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf.page,
> > +                              card->ext_perf.offset + 260, 0x1);
> > +       if (err) {
> > +               pr_warn("%s: error %d writing Cache Enable bit\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto out;
> > +       }
> > +
> > +       err = mmc_poll_for_busy(card,
> > SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> > +                               MMC_BUSY_EXTR_SINGLE);
> I think 1sec is for flush cache, but I guess it makes sense to use it here as well.

The spec talks about generic busy signaling time for CMD49 of one
second. That's why I added this here.

>
> > +       if (!err)
> > +               card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
> Maybe
> If (err)
>     card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
>
> and move to out: to catch the sd_write_ext_reg err ?
>
> > +
> > +out:
> > +       kfree(reg_buf);
> > +       return err;
> > +}
> > +
> >  /*
> >   * Handle the detection and initialisation of a card.
> >   *
> > @@ -1442,6 +1531,13 @@ static int mmc_sd_init_card(struct mmc_host
> > *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       /* Enable internal SD cache if supported. */
> > +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> > +               err = sd_enable_cache(card);
> > +               if (err)
> > +                       goto free_card;
> If cache enablement failed, is it worthwhile to bail out?
> Maybe disabling the cache with the appropriate message is enough?

Right, good point.

Let me also think about how we best reset the .feature_enabled field
after a power cycle. Theoretically we could fail to enable a feature
after the system has resumed, but then we would still have the
correspond bits set.

>
> > +       }
> > +
> >         if (host->cqe_ops && !host->cqe_enabled) {
> >                 err = host->cqe_ops->cqe_enable(host, card);
> >                 if (!err) {
> > @@ -1694,6 +1790,8 @@ static const struct mmc_bus_ops mmc_sd_ops = {
> >         .alive = mmc_sd_alive,
> >         .shutdown = mmc_sd_suspend,
> >         .hw_reset = mmc_sd_hw_reset,
> > +       .cache_enabled = sd_cache_enabled,
> > +       .flush_cache = sd_flush_cache,
> >  };
>
> I would expect 2 more patches in this series:
>  - flush cache on power down

According to the spec that should not be needed, because that should
be managed internally in the SD card when we send a poweroff
notification.

Did I get that wrong? Do you prefer to send a flush cache as well
before the poweroff notification?

>  - cache disablement events?

This I don't know about. Can you elaborate?

>
> Thanks,
> Avri

Kind regards
Uffe
