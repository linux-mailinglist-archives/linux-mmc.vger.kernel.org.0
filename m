Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171607021B
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfGVOT6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 10:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbfGVOT6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Jul 2019 10:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25C563C91A;
        Mon, 22 Jul 2019 14:19:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C31360BF1;
        Mon, 22 Jul 2019 14:19:48 +0000 (UTC)
Date:   Mon, 22 Jul 2019 22:19:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Message-ID: <20190722141940.GA26528@ming.t460p>
References: <cover.1563782844.git.baolin.wang@linaro.org>
 <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 22 Jul 2019 14:19:58 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
> Some SD/MMC host controllers can support packed command or packed request,
> that means we can package several requests to host controller at one time
> to improve performence. And this patch set will introduce MMC packed function
> to support this feature by following patches.
> 
> To support MMC packed function, the MMC layer need to know if there are
> requests are pending now in hardware queue to help to combine requests
> as much as possible. If we know there are requests pending in hardware
> queue, then we should not package requests to host controller immediately,
> instead we should collect more requests into MMC packed queue to be packed
> to host controller with packed condition.
> 
> Thus export this function for MMC packed function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  block/blk-mq.c         |    3 ++-
>  include/linux/blk-mq.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b038ec6..5bd4ef9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
>   * Check if any of the ctx, dispatch list or elevator
>   * have pending work in this hardware queue.
>   */
> -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>  {
>  	return !list_empty_careful(&hctx->dispatch) ||
>  		sbitmap_any_bit_set(&hctx->ctx_map) ||
>  			blk_mq_sched_has_work(hctx);
>  }
> +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);

Just wondering why you don't use the 'last' field of 'struct blk_mq_queue_data',
which is passed to .queue_rq(), and supposed for implementing batch submission.
	

Thanks,
Ming
