Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054D718F17D
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Mar 2020 10:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCWJNn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Mar 2020 05:13:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41181 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgCWJNn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2020 05:13:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id z22so9591823lfd.8;
        Mon, 23 Mar 2020 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGDFm3nnObU1qnSEL0ZjLRRIteoo9pq6mn3EACs6vPI=;
        b=LSV/jgtR6k4RO8vGauAAYTGcSQpuGjq+5uJPHvCBuxzx0UulWA4wflYu9TwJvH3rER
         AeVu7OcjRqUs53YiETaiAlSqsG9GxWqWduFdvp0AcQyN+ggIrHoo0Uc7jbBghRkZhzSv
         9JIwrXz4of+HNqyK37oNptgWoklxV7aCN/0e736VPUoP3RRIQFvYH6YgPY4Xp5snexHs
         rBDEAG+HuodHSFo0kQqs4LIF5VI6bRVv7+pDpvMO5Am36Up5ezbtdu/khAW4TrryNFtV
         JA2t3JPv7aJpLrwX2C14oBd48LqzsDg6U1i78MEb3o9g6UPts35dCERmTXabIRBPXytW
         l1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGDFm3nnObU1qnSEL0ZjLRRIteoo9pq6mn3EACs6vPI=;
        b=innDvZSFWumkpqeDgC9sO5JcN1aUWmrqZjDN3OqAWEwyQirEAwZzzSCnUdJS0stm92
         actymzEwsbBPHkEQwuGzfPco4uiN/tOJhvtsSXIkLSPknaPrwUv0hAaIBEpcpb7MmA0d
         nPwZ4oCR7y9XykWXlLg5taXZJgxXChw+8yHsXQg+Z0DuvYdbCzSPPtETaeP16DMyD3jn
         j1+ICogOYrB83iNMu46lJaGsuJ67y/o9oztwdkqBBNUbBdcaBrq01a7pjBfxuwNKGWOk
         o8SfWhD49jy1LmA6CzfYxb6y8RpiJ5Os5ZhfuRtt3rtKVVSftgDWQpQn3YxCTdxh8qKD
         hUtA==
X-Gm-Message-State: ANhLgQ2csN2ZGj+r4Qasr/yYHeOvHM1lGqaHeLoUMgmYBGGbs939hBwc
        xEl12P2SGEyZ4KIGBEhW4uMIVnYo7FaTmgUgf3c=
X-Google-Smtp-Source: ADFU+vv3f8BsVmyZj4IiQrQldMgtErEwIH2IGIJcmV0tvtwI6KTqqG6H0+T0TF4eMJp/dKU+0a8NmyW9o5Nyis2IMZs=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr12824675lfh.90.1584954819446;
 Mon, 23 Mar 2020 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584350380.git.baolin.wang7@gmail.com> <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
 <20200318100123.GA27531@ming.t460p> <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
 <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
 <20200323034432.GA27507@ming.t460p> <CADBw62rxFdriCSEo78M7_xnS3UiaDPN9CwURtiDOTxGVCevbsg@mail.gmail.com>
 <20200323072640.GA4767@ming.t460p> <CADBw62rDOUUpEdOKxoC3J5R=noSGMLzkJZjjjFa1Mv6J7FX_Aw@mail.gmail.com>
 <20200323082830.GB5616@ming.t460p>
In-Reply-To: <20200323082830.GB5616@ming.t460p>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 23 Mar 2020 17:13:27 +0800
Message-ID: <CADBw62rd4Ro2VbfFZqev6ou7jY+sLtn6b9Z6HCcZAigHngj9Fw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 2/8] block: Allow sending a batch of requests
 from the scheduler to hardware
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, Paolo Valente <paolo.valente@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 23, 2020 at 4:29 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 04:22:38PM +0800, Baolin Wang wrote:
> > On Mon, Mar 23, 2020 at 3:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Mon, Mar 23, 2020 at 01:36:34PM +0800, Baolin Wang wrote:
> > > > On Mon, Mar 23, 2020 at 11:44 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > On Fri, Mar 20, 2020 at 06:27:41PM +0800, Baolin Wang wrote:
> > > > > > Hi Ming,
> > > > > >
> > > > > > On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Ming,
> > > > > > >
> > > > > > > On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > > > > > > > As we know, some SD/MMC host controllers can support packed request,
> > > > > > > > > that means we can package several requests to host controller at one
> > > > > > > > > time to improve performence. So the hardware driver expects the blk-mq
> > > > > > > > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > > > > > > > to indicate if it is the last request in the batch to help to combine
> > > > > > > > > requests as much as possible.
> > > > > > > > >
> > > > > > > > > Thus we should add batch requests setting from the block driver to tell
> > > > > > > > > the scheduler how many requests can be dispatched in a batch, as well
> > > > > > > > > as changing the scheduler to dispatch more than one request if setting
> > > > > > > > > the maximum batch requests number.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I feel this batch dispatch style is more complicated, and some other
> > > > > > > > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > > > > > > > .queue_rq().
> > > > > > > >
> > > > > > > > So what about the following way by extending .commit_rqs() to this usage?
> > > > > > > > And you can do whatever batch processing in .commit_rqs() which will be
> > > > > > > > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
> > > > > > >
> > > > > > > I'm very appreciated for your good suggestion, which is much simpler than mine.
> > > > > > > It seems to solve my problem, and I will try it on my platform to see
> > > > > > > if it can work and give you the feadback. Thanks again.
> > > > > >
> > > > > > I tried your approach on my platform, but met some problems, see below.
> > > > > >
> > > > > > >
> > > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > > index 856356b1619e..cd2bbe56f83f 100644
> > > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > >   */
> > > > > > > > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > >  {
> > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > +       bool ret = false;
> > > > > > > >
> > > > > > > >         do {
> > > > > > > >                 struct request *rq;
> > > > > > > > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > > >                  * in blk_mq_dispatch_rq_list().
> > > > > > > >                  */
> > > > > > > >                 list_add(&rq->queuelist, &rq_list);
> > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > +       } while (ret);
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > > > > >   */
> > > > > > > > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > >  {
> > > > > > > >         struct request_queue *q = hctx->queue;
> > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > > > > > > +       bool ret = false;
> > > > > > > >
> > > > > > > >         do {
> > > > > > > >                 struct request *rq;
> > > > > > > > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > > > >
> > > > > > > >                 /* round robin for fair dispatch */
> > > > > > > >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > > > > > > -
> > > > > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > > > > +       } while (ret);
> > > > > > > >
> > > > > > > >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > > > > > > > +
> > > > > > > > +       return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > >         struct elevator_queue *e = q->elevator;
> > > > > > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > > > > > >         LIST_HEAD(rq_list);
> > > > > > > > +       bool dispatch_ret;
> > > > > > > >
> > > > > > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > > > > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > > > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > > > >          */
> > > > > > > >         if (!list_empty(&rq_list)) {
> > > > > > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > > > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > > > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > > > > > > +               if (dispatch_ret) {
> > > > > > > >                         if (has_sched_dispatch)
> > > > > > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > > > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > > > > >
> > > > > > If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
> > > > > > and got dispatch_ret = true now. Then we will try to dispatch more
> > > > > > reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
> > > > > > more requests in scheduler, then we will got dispatch_ret = false. In
> > > > >
> > > > > 'dispatch_ret' always holds result of the last blk_mq_do_dispatch_sched().
> > > > > When any one request has been dispatched successfully, 'dispatch_ret'
> > > > > is true. New request is always added to list before calling
> > > > > blk_mq_do_dispatch_sched(), so once blk_mq_do_dispatch_sched() returns
> > > > > false, it means that .commit_rqs() has been called.
> > > >
> > > > Not really, if no requests int the IO cheduler, we will break the loop
> > > > in blk_mq_do_dispatch_sched() and return false without calling
> > > > .commit_rqs().
> > >
> > > If there isn't any request to dispatch, false is returned. Otherwise,
> > > always return the return value of last 'blk_mq_dispatch_rq_list'.
> > >
> > > >
> > > > So in this case, blk_mq_do_dispatch_sched() will return 'false', which
> > > > overlapped the return value of 'true' from blk_mq_dispatch_rq_list(),
> > > > and did not call .commit_rqs(). Then the IO processing will be stuck.
> > >
> > > See below.
> > >
> > > >
> > > > static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > {
> > > >         struct request_queue *q = hctx->queue;
> > > >         struct elevator_queue *e = q->elevator;
> > > >         LIST_HEAD(rq_list);
> > > >         bool ret = false;
> > >
> > > The above initialization is just done once.
> > >
> > > >
> > > >        do {
> > > >               struct request *rq;
> > > >
> > > >               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> > > >                      break;
> > > >
> > > >               .......
> > >                             ret = blk_mq_dispatch_rq_list(q, list, ...);
> > >
> > > list includes one request, so blk_mq_dispatch_rq_list() won't return
> > > false in case of no request in list.
> > >
> > > >        } while (ret);
> > > >
> > > >        return ret;
> > >
> > > 'ret' is always updated by return value of last blk_mq_dispatch_rq_list()
> > > if at least one request is dispatched. So if it becomes false, the loop
> > > breaks, that means .commit_rqs() has been called cause 'list' does
> > > include one request for blk_mq_dispatch_rq_list(). Otherwise, true is
> > > still returned.
> >
> > Sorry for my confusing description, let me try again to describe the problem.
> > When I try to mount the block device, I got the IO stuck with your
> > patch, and I did some debugging. I found we missed calling
> > commit_rqs() for one case:
> >
> > void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct
> > blk_mq_hw_ctx *hctx)
> >         struct elevator_queue *e = q->elevator;
> >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> >         LIST_HEAD(rq_list);
> > +       bool dispatch_ret;
> >
> >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct
> > blk_mq_hw_ctx *hctx)
> >          */
> >         if (!list_empty(&rq_list)) {
> >                 blk_mq_sched_mark_restart_hctx(hctx);
> > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> >
> > Suppose we dispatch one request to block driver, and return 'true' here.
> >
> > +               if (dispatch_ret) {
> >                         if (has_sched_dispatch)
> > -                               blk_mq_do_dispatch_sched(hctx);
> > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> >
> > Then we will continue to try to dispatch more requests from IO
> > scheduler, but if there are no requests in IO scheduler now, it will
> > return 'false' here, and set dispatch_ret as false.
> >
> >                         else
> > -                               blk_mq_do_dispatch_ctx(hctx);
> > +                               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
>
> OK, this one is an issue, but it can be fixed simply by not updating
> 'dispatch_ret' for the following dispatch, something like the below
> way:
>
>         if (dispatch_ret) {
>                 if (has_sched_dispatch)
>                         blk_mq_do_dispatch_sched(hctx);
>                 else
>                         blk_mq_do_dispatch_ctx(hctx);
>         }

Yes, this can work.

But I found your patch will drop some performance comparing with my
method in patch 1/2. My method can fetch several requests from IO
scheduler and dispatch them to block driver at one time, but in your
patch we still need dispatch request one by one, which will drop some
performance I think.
What do you think? Thanks.

-- 
Baolin Wang
