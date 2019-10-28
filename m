Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F96E6E2D
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2019 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfJ1I1Y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Oct 2019 04:27:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35610 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbfJ1I1X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2019 04:27:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so10308113lji.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2019 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/zfjSlN7u+hfp01M44eaJLCnlc5zQ4qw+KWC99u9BM=;
        b=sytDF/LpIKW8EXGur4LbXrE+yh/7bGUeOhM7ESSOCmAeRXGFamQM2GqvB/dnrnhOOz
         HJ1oawodXFoA4G9SydsaWIwhhP5dUu4+2FLWegqBQIRpUPaGHS/J45+LmfVtYndtu/2U
         SOycRGXSLdPZ3Y/M3qEMaCUHMPn3Q+v2bJoADHxDuRiLE/lDAkyLmefqDArHLxZTnDLL
         QXFvKSwImjfWrIldauQ3y6ybc/8trdmlTlBijYZoR9FlTEbUoJGU04JuPkhn0irc6mSF
         VSppXpahjxIP7jMZgJLfy5Avdx+ofpu3y3PJ5q/P+3lTW1o2JRQ3uFL3RWbeR6hf6gpy
         WbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/zfjSlN7u+hfp01M44eaJLCnlc5zQ4qw+KWC99u9BM=;
        b=pQaRVHDxSaVyES9K+Bdn8IKLl4YIg5QU4uFbt8mG8VA1XaHyIlzkr9+2T6h6VaxyJQ
         NAPEgKSuXouVI4QIalPaIZH7wCo2z1aYwPjl0PdkWyV9beBHY4W8M3HiOdezeXoBrAii
         jpK0pk55P4ICciCpxnOlIeFcR91XuVbkbbrfVOBMoFSeop/w9DyNyN+zLkhYi9JdCPr0
         mfDVBC6tZLeREnNmdU/NUha1jFbJc047i1SIvMDKVBSyDh9aADIfvGweq/xu8fUrqbzw
         lzoliU+bzDA9yB6hPg9Px7nJNlo51XYyG628DggYJCkSR6N0jKutvX0HHzUiSOWt9ijm
         DqwQ==
X-Gm-Message-State: APjAAAXBNp/j9a74a6Kn4MdT9Tr5iVkLXbgzpx7WP3iSQZqKvEaFWjRX
        GoYS+MkyNU3LbHK8teLykGCHPGv4RFKK/esPqGswly6ndNN+uA==
X-Google-Smtp-Source: APXvYqzExEgAonVIK0s8drjd9/+rKx6/flub9iWkh6nWmYDyeMrqk42lhkg/vgs25eYx/quu0eDOEroi+OfIFTN5TNA=
X-Received: by 2002:a2e:a415:: with SMTP id p21mr10848136ljn.59.1572251241736;
 Mon, 28 Oct 2019 01:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571722391.git.baolin.wang@linaro.org> <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
 <50696230-75f4-3de4-7424-c33d531ee159@intel.com>
In-Reply-To: <50696230-75f4-3de4-7424-c33d531ee159@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 28 Oct 2019 16:27:09 +0800
Message-ID: <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 28 Oct 2019 at 16:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 22/10/19 8:58 AM, Baolin Wang wrote:
> > Add request_done ops for struct sdhci_ops as a preparation in case some
> > host controllers have different method to complete one request, such as
> > supporting request completion of MMC software queue.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c |   12 ++++++++++--
> >  drivers/mmc/host/sdhci.h |    2 ++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index b056400..850241f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >
> >       spin_unlock_irqrestore(&host->lock, flags);
> >
> > -     mmc_request_done(host->mmc, mrq);
> > +     if (host->ops->request_done)
> > +             host->ops->request_done(host, mrq);
>
> For hsq, couldn't this result in sdhci_request() being called interrupt
> context here.

Right, now it did not support.

>
> To prevent that you would need to add a condition to sdhci_defer_done() so
> it always defers when using hsq.

Yes, but now the condition can be matched in sdhci_defer_done()  when
using hsq. So no need to worry that the sdhci_request() will be called
in interrupt
context in this patch set. Thanks.

-- 
Baolin Wang
Best Regards
