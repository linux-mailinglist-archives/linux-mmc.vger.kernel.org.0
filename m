Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37BAD891
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Sep 2019 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfIIMLu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 08:11:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44864 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfIIMLt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 08:11:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id y4so10262627lfe.11
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+Nuw6Os0WLSEwpWKFno+g2UOwdVDp3JMqLLE2u1BHk=;
        b=tH6aQ2nCdR/kKTtxRLZKY+JRdhLrLO74UFRvlfGrvL8AkXDCDPwknAk5qQz+eQ1QhE
         dCDh1WPrLquvWJ0ExxXX8CNkZhuS1rFh1Z9/Qi/amQ2zDPqAwSO4dfnLLjPWo1fK5kBr
         QjdNHIIKnToUPqYpE5SiK+EGQufqoGAlRuqXKwsLoCZbCqCdsInBbhHZtHnYyTiQ2F5H
         uXdRx3YnlOmhMCpbB92K/TxQNaEtTK2WXlZttrEurxyVbPTGJBFH0zUS7Optzle3xGQp
         hXfxPnkbB2DEr1NhbfnRGqKBBsO8ib/QPLDa7ljGhrmGsvAF4kSAhBuIIzVwuuwkQcor
         +jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+Nuw6Os0WLSEwpWKFno+g2UOwdVDp3JMqLLE2u1BHk=;
        b=CWOjKLXityAcc5ZgIi207JDfl5GFH+nmyRs33GxgHrTtPmF+/roWMs4Oq5MumrRllg
         7k4F1gaRwPU58vifc4/V4dylgvSz2pi7x99cCp6q6SqBNZ6mIdK0XDVy3qTJfL2Um/5E
         1RcLg5MZHInvzmflKGuKoxH2+MbzRza2e8bKhZ25j7Fmx3qAYQxxEB/7fzpGgfRin/W+
         iXLCv/QmTxWCbuYjbCyuP+IceDma3d32VJeYkZvvw08eqOkfdslE5E2FYCs6X8YwXajS
         uThGVHFreYbleRxeqsKs2SVQKHGvD+39llU/f8+l1doOVQpXhirxg8M2UjVD1Y+LMF/Q
         9Jcw==
X-Gm-Message-State: APjAAAXbIaSTuJ9pqrBlx2mYK01HxrO12mU2y6alfSbZM0SpoXGqD93s
        vhDWZ7w84Ws7r0tlrpE6hV/9sJG4p1iRPzo0foqg/g==
X-Google-Smtp-Source: APXvYqwM8k/Y/CHwm/ldUlNUtOmUxd9VtM7uinfVYStfifFNnaCh+8zzZibX128c7cTTZIWzolBcQRI2Q+w1aYAxP2U=
X-Received: by 2002:ac2:5bde:: with SMTP id u30mr15632980lfn.59.1568031107874;
 Mon, 09 Sep 2019 05:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
 <5594efd0-6076-bbb5-5aec-a6b3a21dd7ca@intel.com>
In-Reply-To: <5594efd0-6076-bbb5-5aec-a6b3a21dd7ca@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Sep 2019 20:11:35 +0800
Message-ID: <CAMz4kuJp38Y20XHpF5vm0bwFK3MQK8bqJNtgwgqeXu_FcdpikQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 9 Sep 2019 at 20:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/09/19 6:52 AM, Baolin Wang wrote:
> > Add cqhci_virt_finalize_request() to help to complete a request
> > from virtual command queue.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 4e9ebc8..fb5983e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mmc/slot-gpio.h>
> >
> >  #include "sdhci.h"
> > +#include "cqhci.h"
> >
> >  #define DRIVER_NAME "sdhci"
> >
> > @@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >
> >       spin_unlock_irqrestore(&host->lock, flags);
> >
> > -     mmc_request_done(host->mmc, mrq);
> > +     if (!cqhci_virt_finalize_request(host->mmc, mrq))
> > +             mmc_request_done(host->mmc, mrq);
>
> Please add a sdhci_ops callback for request->done then:
>
>         if (host->ops->request_done)
>                 host->ops->request_done(host, mrq);
>         else
>                 mmc_request_done(host->mmc, mrq);

Sure, will do.

>
> >
> >       return false;
> >  }
> > @@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >
> >       /* Process mrqs ready for immediate completion */
> >       for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> > -             if (mrqs_done[i])
> > +             if (mrqs_done[i] &&
> > +                 !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))
>
> sdhci does not support calling mmc->ops->request in interrupt context.
> So probably, you should avoid immediate completion.

Yes, I missed this, will remove. Thanks.

-- 
Baolin Wang
Best Regards
