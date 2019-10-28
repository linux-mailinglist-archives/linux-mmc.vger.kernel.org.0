Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409F9E6E5D
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2019 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfJ1Iif (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Oct 2019 04:38:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJ1Iie (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2019 04:38:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so9446635ljj.10
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2019 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sJhXv+RSZzOsSYOJixMisy55xtTod89sHuqzMfjcn/8=;
        b=E2ktVfopWlTdW+GF2hnC8gVeuKOxzoN+mGuqRzwgDsiIR61NWbbtMhHssxueI/P7cR
         70+CDN1o2KfAkOXRO9DCcoIxrzWF00wBvnvQHPAtkIFfVhChRvWPfGiquyfHS3ZQe2xX
         SPhSzhsxp8yYjTOGxo7W4CTqMNJp2v/muWEg/HDoROaDbbSI91fPEIyQN4ZE5xGhThMV
         yxhQHK3Hrn7j8VO8NdTfRtr/bHYVx2nu1UyAfRSzdId24LwBhLNDPgghX4c5AJ/B72DL
         pdHWzhCFRFJdGOjR8ISlhw6EpX5DwKkOQ+ZuvbXAuDVRJZ4OScCbxBFNxfINv3HjaZma
         x8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sJhXv+RSZzOsSYOJixMisy55xtTod89sHuqzMfjcn/8=;
        b=bXQqvV0YIlMuMoftzO5z0fqCS0Ega6Cfn5xc0tUYgsekIW9LnDAjHqdItgyMFMKb7l
         ay6hKcwIVSCP0wZ9CNfcBXT6hDZK74uODc3MHG9NQeKoe4qPO/x5fl+sJS02EbjvvS2w
         XRsmLKFcnFJbijLR6i535Pn4B9TPFYrgfzx/SZYjSPjbfLlcyF/fC4oYrCGyG0v4SNac
         1FmJ9IksjXO+oGOvn7vt6l0GXQ7Ueg5zOR1WiH8y/UzlNi+F2DYDdLQvJu39rOu2uYiM
         Gm8bWUPcvPlkc4tIA4PdIL27Dowd+5rZX8VySU7yuPyBsPpaC+J2Yrq1A6WcKkxq7VQ6
         RFdg==
X-Gm-Message-State: APjAAAWo6na5ACwWY1fw3qEJl6UgYt5o2AekdmyJ8/D8UEIttWveub7W
        iPTbqCsDYSf5AB9mZ1sTKkBKXYfgYDJj+rkGlGhNMw==
X-Google-Smtp-Source: APXvYqxqcUVzt2fI4zR6ngehzX2Gi2fW+M3HJV6/QX7X+DMCv2OrHoqKchVwvCKTmH0zOpFHF+xZCXDzGJKOr192jKs=
X-Received: by 2002:a2e:9117:: with SMTP id m23mr11025548ljg.82.1572251911249;
 Mon, 28 Oct 2019 01:38:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:4296:0:0:0:0:0 with HTTP; Mon, 28 Oct 2019 01:38:30
 -0700 (PDT)
In-Reply-To: <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
References: <cover.1571722391.git.baolin.wang@linaro.org> <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
 <50696230-75f4-3de4-7424-c33d531ee159@intel.com> <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 28 Oct 2019 16:38:30 +0800
Message-ID: <CAMz4kuKfqMoM3WdaG8o0JHpXeUZHYpLt4P15BsOriU2h2OV--A@mail.gmail.com>
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

On Mon, 28 Oct 2019 at 16:27, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Adrian,
>
> On Mon, 28 Oct 2019 at 16:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 22/10/19 8:58 AM, Baolin Wang wrote:
> > > Add request_done ops for struct sdhci_ops as a preparation in case some
> > > host controllers have different method to complete one request, such as
> > > supporting request completion of MMC software queue.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/mmc/host/sdhci.c |   12 ++++++++++--
> > >  drivers/mmc/host/sdhci.h |    2 ++
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index b056400..850241f 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
> > >
> > >       spin_unlock_irqrestore(&host->lock, flags);
> > >
> > > -     mmc_request_done(host->mmc, mrq);
> > > +     if (host->ops->request_done)
> > > +             host->ops->request_done(host, mrq);
> >
> > For hsq, couldn't this result in sdhci_request() being called interrupt
> > context here.
>
> Right, now it did not support.
>
> >
> > To prevent that you would need to add a condition to sdhci_defer_done() so
> > it always defers when using hsq.
>
> Yes, but now the condition can be matched in sdhci_defer_done()  when
> using hsq. So no need to worry that the sdhci_request() will be called
> in interrupt
> context in this patch set. Thanks.
>

Wait, sorry, I realized some drivers may not select the
SDHCI_REQ_USE_DMA flag in sdhci_defer_done()  when using hsq. OK, So
how about below changes?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..6c7a396 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
sdhci_host *host,
 {
        struct mmc_data *data = mrq->data;

-       return host->pending_reset ||
+       return IS_ENABLED(CONFIG_MMC_HSQ) || host->pending_reset ||
               ((host->flags & SDHCI_REQ_USE_DMA) && data &&
                data->host_cookie == COOKIE_MAPPED);
 }

-- 
Baolin Wang
Best Regards
