Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEB7127B
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfGWHPX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 03:15:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43690 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbfGWHPX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 03:15:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so18762697otp.10
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l8ikddQeaKpRv73RcpRnjhbVGDZiHul3jH+N9vzFDo0=;
        b=RY++HW4S6YvluB3ykZ83EnXbkxdRn0XGH/M6sHwl0pXMKHpPhZYXssPidQ+Mk6BwUU
         hWb+4ljjVQo6lbPZf/R0uVj+O6yVvuDNPJp/A6YWXTlNvtMRSNByXd6TWJJQYjKyH0sg
         P6arGJ5bHvMAO/bBtzVTYc3ypt0tF6QA91Qbbjd5Uhwc7n5TRl9ynpygqiv9Aeue2vmO
         Y/pOGxpZfT8bedkrbPBizevmTfZTBlUUYGB3xJWMcC8W5oLes/32Zl6ZZn+pj8len4Bc
         qp4E7r38ihani7d4VzCZWoephD1iHCzBQ03daY7c/EksFK9d6GApKWW61k+Ljpw4yu/9
         BnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l8ikddQeaKpRv73RcpRnjhbVGDZiHul3jH+N9vzFDo0=;
        b=mJUHrv2VNTE6n7XnEW8NCjTb6k+gB7ft0WqXgErCR81sCQpdsQphN/fcCLtqp59l9z
         tnUobVFu5Sr2NIhkswaHCr3cqIugj56qvqDGxDwwvpc7e6PqEklfJTa1+EuLQMa0plPw
         T56YPSVH68txoLBrJ3aXHyZtFAiEf2w82LpIaD7REQB2/zEBROEKLfNMk0h7rsXfo+qa
         AgEuscL3gGwFKQ9AK09KyZohy4BqthUHOKwnThobinm61eFaZT7++Rn5ZGd/fUkpVZVv
         fGE6PnXo+2Mv0OzrRVHTK0CTLQk66bfmBbJZRT7PAw8bCzRh24XCzt07KgUKCHBDWcbw
         8CFw==
X-Gm-Message-State: APjAAAVcj6v6asUefTgMCDtLJyY/bqA9S2OB05+Ljl4DTPFWrtjmqxo2
        mx44z3ckKiUsQQfqsQSOe7fjm2ZZJX0hHxfmLPRw/g==
X-Google-Smtp-Source: APXvYqyp8TgTe2khLJdrQYV8bgnp91uAA8cka2Kr5b2hVsvEQfFjYhJXGxWzPoz1jz7B+clUCkkZOlaqP3pKxWeAyIY=
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr55602193otq.123.1563866121892;
 Tue, 23 Jul 2019 00:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7541:0:0:0:0:0 with HTTP; Tue, 23 Jul 2019 00:15:21
 -0700 (PDT)
In-Reply-To: <20190723033103.GA13829@ming.t460p>
References: <cover.1563782844.git.baolin.wang@linaro.org> <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
 <20190722141940.GA26528@ming.t460p> <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
 <20190723033103.GA13829@ming.t460p>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 15:15:21 +0800
Message-ID: <CAMz4ku+4z6LiREAWc0KN06=yxUjqoH6GM33S9qeGHOg2aAwyLQ@mail.gmail.com>
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

On 23/07/2019, Ming Lei <ming.lei@redhat.com> wrote:
> On Tue, Jul 23, 2019 at 11:12:57AM +0800, Baolin Wang wrote:
>> Hi Ming,
>>
>> On Mon, 22 Jul 2019 at 22:19, Ming Lei <ming.lei@redhat.com> wrote:
>> >
>> > On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
>> > > Some SD/MMC host controllers can support packed command or packed
>> > > request,
>> > > that means we can package several requests to host controller at one
>> > > time
>> > > to improve performence. And this patch set will introduce MMC packed
>> > > function
>> > > to support this feature by following patches.
>> > >
>> > > To support MMC packed function, the MMC layer need to know if there
>> > > are
>> > > requests are pending now in hardware queue to help to combine
>> > > requests
>> > > as much as possible. If we know there are requests pending in
>> > > hardware
>> > > queue, then we should not package requests to host controller
>> > > immediately,
>> > > instead we should collect more requests into MMC packed queue to be
>> > > packed
>> > > to host controller with packed condition.
>> > >
>> > > Thus export this function for MMC packed function.
>> > >
>> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> > > ---
>> > >  block/blk-mq.c         |    3 ++-
>> > >  include/linux/blk-mq.h |    1 +
>> > >  2 files changed, 3 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
>> > > index b038ec6..5bd4ef9 100644
>> > > --- a/block/blk-mq.c
>> > > +++ b/block/blk-mq.c
>> > > @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct
>> > > request *rq)
>> > >   * Check if any of the ctx, dispatch list or elevator
>> > >   * have pending work in this hardware queue.
>> > >   */
>> > > -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>> > > +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>> > >  {
>> > >       return !list_empty_careful(&hctx->dispatch) ||
>> > >               sbitmap_any_bit_set(&hctx->ctx_map) ||
>> > >                       blk_mq_sched_has_work(hctx);
>> > >  }
>> > > +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
>> >
>> > Just wondering why you don't use the 'last' field of 'struct
>> > blk_mq_queue_data',
>> > which is passed to .queue_rq(), and supposed for implementing batch
>> > submission.
>>
>> The 'last' field of 'struct blk_mq_queue_data' does not indicate the
>> last request in the hardware queue, since we want to collect more
>> requests from block layer as much as possible to be packed later.
>>
>> And from blk_mq_do_dispatch_sched()--->blk_mq_dispatch_rq_list()--->
>> queue_rq(), I always get 'bd.last = true', which is not useful to
>> combine requests for MMC packed queue. Maybe I missed anything?
>
> That is one flaw of current implementation, and we may improve it,
> so other drivers(virtio-io, ...) can benefit from it too.
>

OK. I am not sure can I add a new flag to indicate if there are
requests are pending in the hardware queue? That will help MMC driver
to combine more requests.

Or do you have any other good suggestion? Thanks.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5bd4ef9..cb240f4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1257,6 +1257,8 @@ bool blk_mq_dispatch_rq_list(struct
request_queue *q, struct list_head *list,
                        bd.last = !blk_mq_get_driver_tag(nxt);
                }

+               bd.rq_pending = blk_mq_hctx_has_pending(hctx);
+
                ret = q->mq_ops->queue_rq(hctx, &bd);
                if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
                        /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15a2b7b..9b06fe0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -118,6 +118,7 @@ struct blk_mq_tag_set {
 struct blk_mq_queue_data {
        struct request *rq;
        bool last;
+       bool rq_pending;
 };

-- 
Baolin Wang
Best Regards
