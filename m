Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3961318EE9A
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Mar 2020 04:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCWDpE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 22 Mar 2020 23:45:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43992 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgCWDpE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Mar 2020 23:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584935102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+GrDyOrCD21iKFNlG2dpPR5xnUhMJ4A9olQC66AaHA=;
        b=Jnq9i+PmITmEBtJsCmbEQUcMdal6gHqkibBZfET35Hl6I79fD3IrdZXOla15AL5Zfw9E2m
        4V+ld7bJ7UATgB1UhksOv7Jl7vGLf27Y+bJUla/JIVN0yx4Is63m2ppKlmxYli1fqmpj94
        B912Msxsvt4M+GzSDT7cwe/M+DAAMEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-I-ah-cjMNJqVPiTlPvr9ig-1; Sun, 22 Mar 2020 23:44:50 -0400
X-MC-Unique: I-ah-cjMNJqVPiTlPvr9ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152DF107ACC4;
        Mon, 23 Mar 2020 03:44:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDA4E5C3FD;
        Mon, 23 Mar 2020 03:44:37 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:44:32 +0800
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
Message-ID: <20200323034432.GA27507@ming.t460p>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
 <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
 <20200318100123.GA27531@ming.t460p>
 <CADBw62qbdpoyPZd+_np6f0L+83Ah8B218EYKmi8xiUbBf5c6+A@mail.gmail.com>
 <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62rWWk=Jeg7=3nEBqK2prQjLzCGcFyJ+WkZ0D6_grcETHA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 20, 2020 at 06:27:41PM +0800, Baolin Wang wrote:
> Hi Ming,
> 
> On Wed, Mar 18, 2020 at 6:26 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Ming,
> >
> > On Wed, Mar 18, 2020 at 6:01 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Mon, Mar 16, 2020 at 06:01:19PM +0800, Baolin Wang wrote:
> > > > As we know, some SD/MMC host controllers can support packed request,
> > > > that means we can package several requests to host controller at one
> > > > time to improve performence. So the hardware driver expects the blk-mq
> > > > can dispatch a batch of requests at one time, and driver can use bd.last
> > > > to indicate if it is the last request in the batch to help to combine
> > > > requests as much as possible.
> > > >
> > > > Thus we should add batch requests setting from the block driver to tell
> > > > the scheduler how many requests can be dispatched in a batch, as well
> > > > as changing the scheduler to dispatch more than one request if setting
> > > > the maximum batch requests number.
> > > >
> > >
> > > I feel this batch dispatch style is more complicated, and some other
> > > drivers(virtio blk/scsi) still may get benefit if we can pass real 'last' flag in
> > > .queue_rq().
> > >
> > > So what about the following way by extending .commit_rqs() to this usage?
> > > And you can do whatever batch processing in .commit_rqs() which will be
> > > guaranteed to be called if BLK_MQ_F_FORCE_COMMIT_RQS is set by driver.
> >
> > I'm very appreciated for your good suggestion, which is much simpler than mine.
> > It seems to solve my problem, and I will try it on my platform to see
> > if it can work and give you the feadback. Thanks again.
> 
> I tried your approach on my platform, but met some problems, see below.
> 
> >
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index 856356b1619e..cd2bbe56f83f 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> > >   * its queue by itself in its completion handler, so we don't need to
> > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > >   */
> > > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >         struct request_queue *q = hctx->queue;
> > >         struct elevator_queue *e = q->elevator;
> > >         LIST_HEAD(rq_list);
> > > +       bool ret = false;
> > >
> > >         do {
> > >                 struct request *rq;
> > > @@ -112,7 +113,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >                  * in blk_mq_dispatch_rq_list().
> > >                  */
> > >                 list_add(&rq->queuelist, &rq_list);
> > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > +       } while (ret);
> > > +
> > > +       return ret;
> > >  }
> > >
> > >  static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > @@ -131,11 +135,12 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > >   * its queue by itself in its completion handler, so we don't need to
> > >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> > >   */
> > > -static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > > +static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >         struct request_queue *q = hctx->queue;
> > >         LIST_HEAD(rq_list);
> > >         struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > +       bool ret = false;
> > >
> > >         do {
> > >                 struct request *rq;
> > > @@ -161,10 +166,12 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
> > >
> > >                 /* round robin for fair dispatch */
> > >                 ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > -
> > > -       } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > > +               ret = blk_mq_dispatch_rq_list(q, &rq_list, true);
> > > +       } while (ret);
> > >
> > >         WRITE_ONCE(hctx->dispatch_from, ctx);
> > > +
> > > +       return ret;
> > >  }
> > >
> > >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > > @@ -173,6 +180,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > >         struct elevator_queue *e = q->elevator;
> > >         const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> > >         LIST_HEAD(rq_list);
> > > +       bool dispatch_ret;
> > >
> > >         /* RCU or SRCU read lock is needed before checking quiesced flag */
> > >         if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
> > > @@ -206,20 +214,26 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> > >          */
> > >         if (!list_empty(&rq_list)) {
> > >                 blk_mq_sched_mark_restart_hctx(hctx);
> > > -               if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
> > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > +               if (dispatch_ret) {
> > >                         if (has_sched_dispatch)
> > > -                               blk_mq_do_dispatch_sched(hctx);
> > > +                               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> 
> If we dispatched a request successfully by blk_mq_dispatch_rq_list(),
> and got dispatch_ret = true now. Then we will try to dispatch more
> reuqests from scheduler by blk_mq_do_dispatch_sched(), but if now no
> more requests in scheduler, then we will got dispatch_ret = false. In

'dispatch_ret' always holds result of the last blk_mq_do_dispatch_sched().
When any one request has been dispatched successfully, 'dispatch_ret'
is true. New request is always added to list before calling
blk_mq_do_dispatch_sched(), so once blk_mq_do_dispatch_sched() returns
false, it means that .commit_rqs() has been called.

> this case, we will not issue commit_rqs() to tell the hardware to
> handle previous request dispatched from &rq_list.
> 
> So I think we should not overlap the 'dispatch_ret'? Or do you have
> any other thoughts to fix?
> 
> > >                         else
> > > -                               blk_mq_do_dispatch_ctx(hctx);
> > > +                               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> > >                 }
> > >         } else if (has_sched_dispatch) {
> > > -               blk_mq_do_dispatch_sched(hctx);
> > > +               dispatch_ret = blk_mq_do_dispatch_sched(hctx);
> > >         } else if (hctx->dispatch_busy) {
> > >                 /* dequeue request one by one from sw queue if queue is busy */
> > > -               blk_mq_do_dispatch_ctx(hctx);
> > > +               dispatch_ret = blk_mq_do_dispatch_ctx(hctx);
> > >         } else {
> > >                 blk_mq_flush_busy_ctxs(hctx, &rq_list);
> > > -               blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > +               dispatch_ret = blk_mq_dispatch_rq_list(q, &rq_list, false);
> > > +       }
> > > +
> > > +       if (dispatch_ret) {
> > > +               if (hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)
> > > +                       hctx->queue->mq_ops->commit_rqs(hctx);
> > >         }
> > >  }
> > >
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 87c6699f35ae..9b46f5d6c7fd 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1238,11 +1238,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> > >                  * Flag last if we have no more requests, or if we have more
> > >                  * but can't assign a driver tag to it.
> > >                  */
> > > -               if (list_empty(list))
> > > -                       bd.last = true;
> > > -               else {
> > > -                       nxt = list_first_entry(list, struct request, queuelist);
> > > -                       bd.last = !blk_mq_get_driver_tag(nxt);
> > > +               if (!(hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)) {
> > > +                       if (list_empty(list))
> > > +                               bd.last = true;
> > > +                       else {
> > > +                               nxt = list_first_entry(list, struct request, queuelist);
> > > +                               bd.last = !blk_mq_get_driver_tag(nxt);
> > > +                       }
> > > +               } else {
> > > +                       bd.last = false;
> 
> If we enabled BLK_MQ_F_FORCE_COMMIT_RQS flag, we will always get
> bd.last = false even for the real last request in the IO scheduler. I
> know you already use commit_irqs() to help to kick driver. But I
> worried if it is reasonable that drivers always get bd.last = false.
> 

BLK_MQ_F_FORCE_COMMIT_RQS means the .last flag is ignored, and we can
document this usage.


Thanks, 
Ming

