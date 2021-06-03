Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC35639A4AF
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Jun 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFCPjF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Jun 2021 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFCPjE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jun 2021 11:39:04 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8EC061756
        for <linux-mmc@vger.kernel.org>; Thu,  3 Jun 2021 08:37:19 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x2so3212803vss.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jun 2021 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+W0QahdA5jm5lLp4qGqziVkevJrOYYIsAeli4hbSoMY=;
        b=Sczm7Uhat9CAttKCKONsBvTvpdWX5VANaO58Cd0mJFcJ+A28Gj9YspGmhSWIpVtNS9
         gufvY+CGT5FXDIQfjOQ4ExwQIrmSjUqzpGxTG/ZkK/nXRMIOjYsW6gd0+0ljDlvbLbq6
         AyHgMcG1V7VrDrAancwHixbwlfPPPcOtQ/Us++pps4NpXbaz33l8+avCCapAkCFya/10
         FcaqevmvQJz8RurkVjboQlMdJ4KLmCFgJ9aWml7eHxoV4e7eWIKwWiCmbJjrhvsDE5K2
         PLLnqagHSU8ORkIhfE1C9Sx6ZNkln7FGogf+yyT7tKXsIRL7oAHDTXDC0cZ4GcZV2dc7
         4ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W0QahdA5jm5lLp4qGqziVkevJrOYYIsAeli4hbSoMY=;
        b=Jf5vN1VoNEBdCl3QuZBiP3GBTU0v1MFS5ZnzWO5jfYCQyvarLi4Dm+LNtgkOX3ec1Q
         6+J8nPPNYUY8/OHN216V4avHhLBZ2mmOf/X7h82LElqcbmIOYp1m2RJArF2vFd04P5UL
         OfGGWgnz+9H3l2iK2IGORwsfJlNLphvMKNcoq5FQ1ZOPQTlN4dMtlyt7UhuNJyHuw3Uv
         x1znpKy0e2yOaGrSd7OIcTA1hVLY9LW6NiDq3RclIP9CS3c0QutVD2xM9+uKsX+ArPtZ
         tS47lk9yezTLvpWvvi8HQCDkPEhDxQI42k+Unz5U9bCV0lRdRWBInrbQaQX3Y76bqStQ
         M5Dg==
X-Gm-Message-State: AOAM532v7wdokrSqPm25aJPfusMZx0RuM6O1ZKGrq/DFHQl0PIgt9AW8
        JQ9znQiHgjkx0xKSdV6dK+2u469lp6VeMGTSr2KxrA==
X-Google-Smtp-Source: ABdhPJzM3LSrPJI4FkB0laodTTeEei+m50SowhpqaGtsNgUdvieHcvbYUQloJUD/a79xzNmd816023E4d1PORKHhPJg=
X-Received: by 2002:a05:6102:3023:: with SMTP id v3mr756919vsa.19.1622734639015;
 Thu, 03 Jun 2021 08:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210602065345.355274-1-hch@lst.de> <20210602065345.355274-8-hch@lst.de>
In-Reply-To: <20210602065345.355274-8-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 17:36:42 +0200
Message-ID: <CAPDyKFoJssCnHv5tmG4vJJ9m0Zj5HkMEVYvnsjamvyemusZaUg@mail.gmail.com>
Subject: Re: [PATCH 07/30] ms_block: use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        nbd@other.debian.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Jun 2021 at 08:54, Christoph Hellwig <hch@lst.de> wrote:
>
> Use the blk_mq_alloc_disk API to simplify the gendisk and request_queue
> allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 0bacf4268f83..dac258d12aca 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2110,21 +2110,17 @@ static int msb_init_disk(struct memstick_dev *card)
>         if (msb->disk_id  < 0)
>                 return msb->disk_id;
>
> -       msb->disk = alloc_disk(0);
> -       if (!msb->disk) {
> -               rc = -ENOMEM;
> +       rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &msb_mq_ops, 2,
> +                                    BLK_MQ_F_SHOULD_MERGE);
> +       if (rc)
>                 goto out_release_id;
> -       }
>
> -       msb->queue = blk_mq_init_sq_queue(&msb->tag_set, &msb_mq_ops, 2,
> -                                               BLK_MQ_F_SHOULD_MERGE);
> -       if (IS_ERR(msb->queue)) {
> -               rc = PTR_ERR(msb->queue);
> -               msb->queue = NULL;
> -               goto out_put_disk;
> +       msb->disk = blk_mq_alloc_disk(&msb->tag_set, card);
> +       if (IS_ERR(msb->disk)) {
> +               rc = PTR_ERR(msb->disk);
> +               goto out_free_tag_set;
>         }
> -
> -       msb->queue->queuedata = card;
> +       msb->queue = msb->disk->queue;
>
>         blk_queue_max_hw_sectors(msb->queue, MS_BLOCK_MAX_PAGES);
>         blk_queue_max_segments(msb->queue, MS_BLOCK_MAX_SEGS);
> @@ -2135,7 +2131,6 @@ static int msb_init_disk(struct memstick_dev *card)
>         sprintf(msb->disk->disk_name, "msblk%d", msb->disk_id);
>         msb->disk->fops = &msb_bdops;
>         msb->disk->private_data = msb;
> -       msb->disk->queue = msb->queue;
>
>         capacity = msb->pages_in_block * msb->logical_block_count;
>         capacity *= (msb->page_size / 512);
> @@ -2155,8 +2150,8 @@ static int msb_init_disk(struct memstick_dev *card)
>         dbg("Disk added");
>         return 0;
>
> -out_put_disk:
> -       put_disk(msb->disk);
> +out_free_tag_set:
> +       blk_mq_free_tag_set(&msb->tag_set);
>  out_release_id:
>         mutex_lock(&msb_disk_lock);
>         idr_remove(&msb_disk_idr, msb->disk_id);
> --
> 2.30.2
>
