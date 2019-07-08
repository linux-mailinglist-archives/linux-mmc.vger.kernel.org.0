Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3761E05
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Jul 2019 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfGHL41 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jul 2019 07:56:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37313 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfGHL4Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2019 07:56:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id v6so7989053vsq.4
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2019 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
        b=n2aOuh4+2HfLrrQ/AerkGk8nPcV0a9lHD1biMG5L8xAvYkxmgeLA8NS7F25S5q3m4/
         PCxVdgp2Jf8w+c1ts10xe7qmXFh+7oane/qyxsSzTyhYVjYlUWbx7mj0ICC6+bojcHJI
         0SINwngWRJuBqkIGoFi8LSLM9AAf4cWCut+tz8LeJrgv1RvYMMYGzCJDEIEEotA8Lx4T
         ExMvH2gvUGRMH8HhXJ4gQBnh9YRG72rx3rbZCAk4XKuIF2dvHFVtWbEZbGdLt8u1/62E
         wvQoT932jJjfBcNytTV6L5O68aaoqrXemfhwy6DrUlk5jFD5bypBb8QcMyuWa0IaOma9
         Ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
        b=AyXPjp940x8yQsf/jr4fhzFjNYLze1njs+U2g6gbDW8xuYN2paGhiKJaRv/VV+VJjc
         N1BjoMtgr7HyzgQxVEE48zRFryM4tO38+GSSdx8sFF9dfekclljyBLuUE5BXjb0gwp37
         /Y7G4EMr1esPiWm788fcapzppH6QH1K53T/QXLP1Q3/fV96Er462UaKCzX33Z0ZQIis1
         jF2u5fvATmbsy8Vjxg201yeEY1j8OS/Pa8fnHkENkzuYFD081q+e23jtHr04YW8ozgm2
         gUxfLHHenDeXZCc6KsUozhdPOMGF8bXP3pxtjC2yoUbOsMCwonGX+yIXwMUyIwYsakKI
         6pTg==
X-Gm-Message-State: APjAAAVfAGCIrrGiFYnIa6Wv0HDQ+CBa+dvP86v9R6d+qNst1VcPML9u
        MOLEdDgLB7lupCPtqRh9bGmbcr5SXp9tytQYc6TjiQ==
X-Google-Smtp-Source: APXvYqzuMQxu5Q5w1+tmz7XnrX4NkraXYwW+cB7xG+jvVxMPoX8GHek6Jxl9SAJweTu5ja02CrA++IPVX9ipqF+7hMA=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9881440vsp.165.1562586984367;
 Mon, 08 Jul 2019 04:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-2-hch@lst.de>
In-Reply-To: <20190625092042.19320-2-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:48 +0200
Message-ID: <CAPDyKFotnDCpt9k-r3D2uYRAzpFVA3woRQENLcNcDY0q8+8SVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

From your earlier reply, I decided to fold in the following
information to the changelog, as to clarify things a bit:

"This also means we are not going to set a bounce limit for the queue, in
case we have a dma mask. On most architectures it was never needed, the
major hold out was x86-32 with PAE, but that has been fixed by now."

Please tell, if you want me to change something.

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 3557d5c51141..e327f80ebe70 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -350,18 +350,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       u64 limit = BLK_BOUNCE_HIGH;
>         unsigned block_size = 512;
>
> -       if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> -               limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> -
>         blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
>         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       blk_queue_bounce_limit(mq->queue, limit);
> +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>
