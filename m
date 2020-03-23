Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0B18F034
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Mar 2020 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCWH1f (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Mar 2020 03:27:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22929 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbgCWH1f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2020 03:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584948454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ltwtkd73erXYh5KTAgz8fGitRPodOxM8n4dck2JV1fs=;
        b=DuNbelDGIOmI6DocKnGWS8vmB0K9mYOJavK20cnt9JppSOQkrOHt/AhGvd7FmK+PcpUmJu
        CwP7gU/+5ir45r/TeOpeXob0J7e4ij1D9tNDZFgR5v9pM2fWcGBj94S6PYok8mwWcNcGVr
        Zz+plEHiBR9vRXwTmsZtUkmaCh8i1gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WwCStCK7Ol2aFoK0F6dkwQ-1; Mon, 23 Mar 2020 03:27:32 -0400
X-MC-Unique: WwCStCK7Ol2aFoK0F6dkwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0764DB60;
        Mon, 23 Mar 2020 07:27:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-41.pek2.redhat.com [10.72.8.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E61FF60BF1;
        Mon, 23 Mar 2020 07:26:53 +0000 (UTC)
Date:   Mon, 23 Mar 2020 15:26:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang7@gmail.com>
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
Subject: Re: [RESEND RFC PATCH 2/8] block: Allow sending a batch of requests
 from the scheduler to hardware
Message-ID: <20200323072640.GA4767@ming.t460p>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
 <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
 <20200318100123.GA27531@ming.t460p>
 <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
 <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
 <20200323034432.GA27507@ming.t460p>
 <CADBw62rxFdriCSEo78M7_xnS3UiaDPN9CwURtiDOTxGVCevbsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62rxFdriCSEo78M7_xnS3UiaDPN9CwURtiDOTxGVCevbsg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 23, 2020 at 01:36:34PM +0800, Baolin Wang wrote:
> On Mon, Mar 23, 2020 at 11:44 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Mar 20, 2020 at 06:27:41PM +0800, Baolin Wang wrote:
> > > Hi Ming,
> > >
> > > On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi Ming,
> > > >
> > > > On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > > > > As we know, some SD/MMC host controllers can support packed request,
> > > > > > that means we can package several requests to host controller at one
> > > > > > time to improve performence. So the hardware driver expects the blk-mq
> > > > > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > > > > to indicate if it is the last request in the batch to help to combine
> > > > > > requests as much as possible.
> > > > > >
> > > > > > Thus we should add batch requests setting from the block driver to tell
> > > > > > the scheduler how many requests can be dispatched in a batch, as well
> > > > > > as changing the scheduler to dispatch more than one request if setting
> > > > > > the maximum batch requests number.
> > > > > >
> > > > >
> > > > > I feel this batch dispatch style is more complicated, and some other
> > > > > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > > > > .queue_rq().
> > > > >
> > > > > So what about the following way by extending .commit_rqs() to this usage?
> > > > > And you can do whatever batch processing in .commit_rqs() which will be
> > > > > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
> > > >
> > > > I'm very appreciated for your good suggestion, which is much simpler than mine.
> > > > It seems to solve my problem, and I will try it on my platform to see
> > > > if it can work and give you the feadback. Thanks again.
> > >
> > > I tried your approach on my platform, but met some problems, see below.
> > >
> > > >
> > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > index 856356b1619e..cd2bbe56f83f 100644
> > > > > --- a/block/blk-mq-sched.c
> > > > > +++ b/block/blk-mq-sched.c
> > > > > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > >   */
> > > > > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >         struct request_queue *q = hctx->queue;
> > > > >         struct elevator_queue *e = q->elevator;
> > > > >         LIST_HEAD(rq_list);
> > > > > +       bool ret = false;
> > > > >
> > > > >         do {
> > > > >                 struct request *rq;
> > > > > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > >                  * in blk_mq_dispatch_rq_list().
> > > > >                  */
> > > > >                 list_add(&rq->queuelist, &rq_list);
> > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > +       } while (ret);
> > > > > +
> > > > > +       return ret;
> > > > >  }
> > > > >
> > > > >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > >   * its queue by itself in its completion handler, so we don't need to
> > > > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > > > >   */
> > > > > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >         struct request_queue *q = hctx->queue;
> > > > >         LIST_HEAD(rq_list);
> > > > >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > > > +       bool ret = false;
> > > > >
> > > > >         do {
> > > > >                 struct request *rq;
> > > > > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > > >
> > > > >                 /* round robin for fair dispatch */
> > > > >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > > > -
> > > > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > > > +       } while (ret);
> > > > >
> > > > >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > > > > +
> > > > > +       return ret;
> > > > >  }
> > > > >
> > > > >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > >         struct elevator_queue *e = q->elevator;
> > > > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > > > >         LIST_HEAD(rq_list);
> > > > > +       bool dispatch_ret;
> > > > >
> > > > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > > > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > > >          */
> > > > >         if (!list_empty(&rq_list)) {
> > > > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > > > +               if (dispatch_ret) {
> > > > >                         if (has_sched_dispatch)
> > > > > -                               blk_mq_do_dispatch_sched(hctx);
> > > > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > >
> > > If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
> > > and got dispatch_ret = true now. Then we will try to dispatch more
> > > reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
> > > more requests in scheduler, then we will got dispatch_ret = false. In
> >
> > 'dispatch_ret' always holds result of the last blk_mq_do_dispatch_sched().
> > When any one request has been dispatched successfully, 'dispatch_ret'
> > is true. New request is always added to list before calling
> > blk_mq_do_dispatch_sched(), so once blk_mq_do_dispatch_sched() returns
> > false, it means that .commit_rqs() has been called.
> 
> Not really, if no requests int the IO cheduler, we will break the loop
> in blk_mq_do_dispatch_sched() and return false without calling
> .commit_rqs().

If there isn't any request to dispatch, false is returned. Otherwise,
always return the return value of last 'blk_mq_dispatch_rq_list'.

> 
> So in this case, blk_mq_do_dispatch_sched() will return 'false', which
> overlapped the return value of 'true' from blk_mq_dispatch_rq_list(),
> and did not call .commit_rqs(). Then the IO processing will be stuck.

See below.

> 
> static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> {
>         struct request_queue *q = hctx->queue;
>         struct elevator_queue *e = q->elevator;
>         LIST_HEAD(rq_list);
>         bool ret = false;

The above initialization is just done once.

> 
>        do {
>               struct request *rq;
> 
>               if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
>                      break;
> 
>               .......
			    ret = blk_mq_dispatch_rq_list(q, list, ...);

list includes one request, so blk_mq_dispatch_rq_list() won't return
false in case of no request in list.

>        } while (ret);
> 
>        return ret;

'ret' is always updated by return value of last blk_mq_dispatch_rq_list()
if at least one request is dispatched. So if it becomes false, the loop
breaks, that means .commit_rqs() has been called cause 'list' does
include one request for blk_mq_dispatch_rq_list(). Otherwise, true is
still returned.

thanks, 
Ming

