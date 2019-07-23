Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F770FAF
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 05:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfGWDNK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 23:13:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43692 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfGWDNJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 23:13:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so18290163otp.10
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRk0XCUOOeLhkURXIsrcmBZYRHclzXxoMPAdT26EhIw=;
        b=x4Y4KhhmBcGhMNRZHlH8uiKQqB7vPuwd9a3vzI/zUfipkeumIIxotuiLo/omBUZo1V
         I4yEENG2NJUeqgWbP1S7e+ALHfprLJHn0HSpbkd3gTfSAJAhc7mDQvXrKA9zm1A2m786
         /cvOT/9UgYlY1auQIn+F0rRuWUy1Qdqd5ONcxYNl502flymtImq5ZwDi9EUAlsslM6FR
         +L5kCSnrHL8qYuXoSb8ERiW3n5QlIqnThtyaAS1MAm7K+zC/omTtboVBCT/izDVm35/7
         6cdpMss5uZ4caCUgvGkE+eHNrp1Kki6vY7MNrEXIPrHCfePxLgKg+ccP5BOClq03YZiN
         odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRk0XCUOOeLhkURXIsrcmBZYRHclzXxoMPAdT26EhIw=;
        b=DW5PVBYiXMWCU1kIap9mo6Tc37HCpq4dqCM1GDJ2L/2vWp4WqQtVAQU0hmQKaAb8D/
         HMJbu6QXdhlPGODCu/+8vYiaOr3OO+iUq/wPHhNeY6FP95s5UzY9CqtxzrZ7Q+hEEPg9
         Q3su1Zco3dc9uTYIPaf7/cDGOvPTvqNtaADR9WG1luGnCzh7IyCmUqRjXEaK0oHZTQgy
         hrjmTgmbK4luMgDDcU2ac0QxHKE9z+h7jjhKwWYGQiFIhPg3ZeqT0J4NssD36MK8UhSW
         sVZrbfwN+OhJqfIb4qVT92lm+GjKCfPacAT3I/BwI9AqO4juFuG8zh4ECZcNsSUg82ks
         J/dQ==
X-Gm-Message-State: APjAAAUkvOXIM0psKzgnB2NMhq4ac98i04f2S4YHPv8aJ2NyzlrRbxjf
        nq73xj2saGgtxSFexS0wVRbgtJmDAyjYqZM6NGZKJA==
X-Google-Smtp-Source: APXvYqy1vfQdOXDImruQOKc6WqzDViO9H0BO7gpFE3uIOrbEzPmKXH6lGJp5FeQx/o3OtwHJ/PUcvdKi5AteHgD6TkQ=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr38048922oth.281.1563851589136;
 Mon, 22 Jul 2019 20:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org> <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
 <20190722141940.GA26528@ming.t460p>
In-Reply-To: <20190722141940.GA26528@ming.t460p>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 11:12:57 +0800
Message-ID: <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ming,

On Mon, 22 Jul 2019 at 22:19, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
> > Some SD/MMC host controllers can support packed command or packed request,
> > that means we can package several requests to host controller at one time
> > to improve performence. And this patch set will introduce MMC packed function
> > to support this feature by following patches.
> >
> > To support MMC packed function, the MMC layer need to know if there are
> > requests are pending now in hardware queue to help to combine requests
> > as much as possible. If we know there are requests pending in hardware
> > queue, then we should not package requests to host controller immediately,
> > instead we should collect more requests into MMC packed queue to be packed
> > to host controller with packed condition.
> >
> > Thus export this function for MMC packed function.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  block/blk-mq.c         |    3 ++-
> >  include/linux/blk-mq.h |    1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b038ec6..5bd4ef9 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
> >   * Check if any of the ctx, dispatch list or elevator
> >   * have pending work in this hardware queue.
> >   */
> > -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> >  {
> >       return !list_empty_careful(&hctx->dispatch) ||
> >               sbitmap_any_bit_set(&hctx->ctx_map) ||
> >                       blk_mq_sched_has_work(hctx);
> >  }
> > +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
>
> Just wondering why you don't use the 'last' field of 'struct blk_mq_queue_data',
> which is passed to .queue_rq(), and supposed for implementing batch submission.

The 'last' field of 'struct blk_mq_queue_data' does not indicate the
last request in the hardware queue, since we want to collect more
requests from block layer as much as possible to be packed later.

And from blk_mq_do_dispatch_sched()--->blk_mq_dispatch_rq_list()--->
queue_rq(), I always get 'bd.last = true', which is not useful to
combine requests for MMC packed queue. Maybe I missed anything?

Thanks for your comments.

-- 
Baolin Wang
Best Regards
