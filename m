Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1C3AB06F
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Jun 2021 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhFQJ5y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Jun 2021 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFQJ5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2021 05:57:53 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC7C06175F
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:55:46 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id f1so1862663uaj.10
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjFXbUwZdM69ztcT9AcRv1Hn3FWXXKyc+J0Uj0oNjDc=;
        b=O1sM7f0zEO6vRAY8YQGOlhPt9dHd1/Aco0jAT+B7g2nAnZOeIWKaS0Sou+jIwYbFJR
         Nq2I6PPT7UVDJ5y3lfE8PLa37/F7WMwbtsPf8y3UaqqdejYA58XBtRYVIrcJDL43d0kL
         jd0FHMeFXxSQ/e6hZzFCB+Jxx1FKhAcQWvkvOMIostToVlLMqLISIJHkD5kadYe2jdTF
         qVpOLZ35FAAGTSKAaPkOIOC1ayxbg3EGbnbgebZ6voHbhtNbWa4UnioMOa1HgbqCEJs8
         8QcZHPiBFk4oK0T6t3o7rUaoQ2iIH6VbU/QvI9K6qOcAYrKVLcy7BFpV4xYanTB/sk9s
         ddaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjFXbUwZdM69ztcT9AcRv1Hn3FWXXKyc+J0Uj0oNjDc=;
        b=rv14NCBWI1YFvx7m1T3CsN0VA0i3V7n+W3DX1AJqEEzj3qJMiqe213RPiP5NU2fxtF
         3KzNOlGghZ0UJGaNdg16MqD0fLOnotBclpFxd7m7zTdebK0H5rB0yor7dmBqdIfHHizm
         +Mt+dVpvPvlbiEkz+BmqR/jWNhXmTAJ99ZdEEYDZwIqvI1K/n8c7SFIa1JeCCOK90pQr
         jsmAFjimPZPMuZ//uYTAd/sgOIPYUratW9i25KL7auAz2GQQ3yDlg54SgpFUZ+uZs8+H
         RUx0m8PS2RN2vUMMQ46ZZ1CqPSPhZ7R3e7c1L0ML18YnDulBp62M7875MWZVeC8M+dLO
         doSQ==
X-Gm-Message-State: AOAM531RjARtYGYcTS3ZsCJIzhl37nMaMwTKajchKVffYnU+UpoETgWx
        EF1tIOnAUwyT1ieEZuJXD2cem++zrnZJ7s9UoMzyjw==
X-Google-Smtp-Source: ABdhPJxP1+HcBZP804uah7xfMMKsUK+ElLqb+W3pT/zaOiuVtYjBDI58XSdpf+GutFB0SWRYZgE4gumYDpYrOBBjzy0=
X-Received: by 2002:ab0:4d49:: with SMTP id k9mr4066217uag.129.1623923745309;
 Thu, 17 Jun 2021 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053934.880951-1-hch@lst.de> <20210616053934.880951-3-hch@lst.de>
In-Reply-To: <20210616053934.880951-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 11:55:08 +0200
Message-ID: <CAPDyKFq6CsVf7_0CgddcZTQDwBbbGLqU4WGMg+es6YRhNQmomA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: switch to blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Jun 2021 at 07:40, Christoph Hellwig <hch@lst.de> wrote:
>
> Use the blk_mq_alloc_disk to allocate the request_queue and gendisk
> together.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 14 +++-----------
>  drivers/mmc/core/queue.c | 23 ++++++++++-------------
>  drivers/mmc/core/queue.h |  2 +-
>  3 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 947624e76c33..6652e1f1d4b2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2310,27 +2310,21 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>          */
>         md->read_only = mmc_blk_readonly(card);
>
> -       md->disk = alloc_disk(perdev_minors);
> -       if (md->disk == NULL) {
> -               ret = -ENOMEM;
> +       md->disk = mmc_init_queue(&md->queue, card);
> +       if (IS_ERR(md->disk)) {
> +               ret = PTR_ERR(md->disk);
>                 goto err_kfree;
>         }
>
>         INIT_LIST_HEAD(&md->part);
>         INIT_LIST_HEAD(&md->rpmbs);
>         md->usage = 1;
> -
> -       ret = mmc_init_queue(&md->queue, card);
> -       if (ret)
> -               goto err_putdisk;
> -
>         md->queue.blkdata = md;
>
>         md->disk->major = MMC_BLOCK_MAJOR;
>         md->disk->first_minor = devidx * perdev_minors;
>         md->disk->fops = &mmc_bdops;
>         md->disk->private_data = md;
> -       md->disk->queue = md->queue.queue;
>         md->parent = parent;
>         set_disk_ro(md->disk, md->read_only || default_ro);
>         md->disk->flags = GENHD_FL_EXT_DEVT;
> @@ -2379,8 +2373,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>
>         return md;
>
> - err_putdisk:
> -       put_disk(md->disk);
>   err_kfree:
>         kfree(md);
>   out:
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d600e0a4a460..cc3261777637 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -424,9 +424,10 @@ static inline bool mmc_merge_capable(struct mmc_host *host)
>   *
>   * Initialise a MMC card request queue.
>   */
> -int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
> +struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> +       struct gendisk *disk;
>         int ret;
>
>         mq->card = card;
> @@ -464,26 +465,22 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>
>         ret = blk_mq_alloc_tag_set(&mq->tag_set);
>         if (ret)
> -               return ret;
> +               return ERR_PTR(ret);
> +
>
> -       mq->queue = blk_mq_init_queue(&mq->tag_set);
> -       if (IS_ERR(mq->queue)) {
> -               ret = PTR_ERR(mq->queue);
> -               goto free_tag_set;
> +       disk = blk_mq_alloc_disk(&mq->tag_set, mq);
> +       if (IS_ERR(disk)) {
> +               blk_mq_free_tag_set(&mq->tag_set);
> +               return disk;
>         }
> +       mq->queue = disk->queue;
>
>         if (mmc_host_is_spi(host) && host->use_spi_crc)
>                 blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
> -
> -       mq->queue->queuedata = mq;
>         blk_queue_rq_timeout(mq->queue, 60 * HZ);
>
>         mmc_setup_queue(mq, card);
> -       return 0;
> -
> -free_tag_set:
> -       blk_mq_free_tag_set(&mq->tag_set);
> -       return ret;
> +       return disk;
>  }
>
>  void mmc_queue_suspend(struct mmc_queue *mq)
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 3319d8ab57d0..9ade3bcbb714 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -94,7 +94,7 @@ struct mmc_queue {
>         struct work_struct      complete_work;
>  };
>
> -extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *);
> +struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card);
>  extern void mmc_cleanup_queue(struct mmc_queue *);
>  extern void mmc_queue_suspend(struct mmc_queue *);
>  extern void mmc_queue_resume(struct mmc_queue *);
> --
> 2.30.2
>
