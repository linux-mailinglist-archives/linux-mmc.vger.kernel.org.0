Return-Path: <linux-mmc+bounces-1085-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D98576FD
	for <lists+linux-mmc@lfdr.de>; Fri, 16 Feb 2024 08:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9411F2384F
	for <lists+linux-mmc@lfdr.de>; Fri, 16 Feb 2024 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB81773D;
	Fri, 16 Feb 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MYeVffNE"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E5EAFA
	for <linux-mmc@vger.kernel.org>; Fri, 16 Feb 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069787; cv=none; b=iSTsxUYv2CO/9azXL8qvbxf3ZpPteaX7/IpEf7nzTo/bfdnt6unAAZeKbNU/C6wPKGRX/fcLlFochGHUR+QYnEprMRVS7lAGkn3rXcB/RDeKo91s4394kE5hhwS0QJoYUV+DjC+IryhHm+D90M7PkpZnr53BUdgpac8hyP9wmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069787; c=relaxed/simple;
	bh=V2EdJjvqxAqCtw18lO2fEH+iEeksTk/mBimlO53/O40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAYxGEL0VCkYpBMoCK1ZFC8Ns/JbcUnKSd9t9zO1G0VnjKjs2/eW72GftSg7pN9xkrWd+PBboDF9ORh9l8YohuMOpsQOTciYebbsTc1GGs8ndMHeyK484Yo70jrQpPeH6f4xIiDmQvTtJDYIJh6O4HVfoYy75fQcicgXHBhOY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MYeVffNE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso131361a12.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 23:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708069782; x=1708674582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKtrR0GptUvN+scEUpBPwjTH5qrhKCgtCeXIuRBm1rE=;
        b=MYeVffNEmZUTahVi/A4kJeB/m1pFJlznUyhAFsFFTT5b3esiD5FrC0EuBHJX4QvWC1
         KER7CWomH96ZhR3MwL5pZhZ5w+iv51BNlP44YJ+LsFRY+MOcsDG93lGCieDX0BsmX7hk
         1eVrAXEWh+/bx1SZ4E2l61VXyvBBfDXLm3VfWpSg23XQjwpHqbhcd2iKWdDsshoKIuSF
         8pbfeKkfasgl78V7yN71gUlLlwaBG2nfG3LsS0fKTj4s0+N1I5Z477pTdvbBcnFBYpJD
         O8TpvrEOMZlpnK+WV/mXfz5uOfVFs6IqHSJqQZd55NVhu14JcDxy/0jl2B46EPtF2v5t
         VjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708069782; x=1708674582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKtrR0GptUvN+scEUpBPwjTH5qrhKCgtCeXIuRBm1rE=;
        b=AE/GRxokdwj377vWDAsH5OsrohVOQkx2PJPnolCdN7MC6AHjUhrqwEXUey4xRplv5j
         dupTWCJ+zKBdZA/3srTxQVvBTANE+bxs6aZ5cA4h1Q1qFxcSULosysUioz9pLGVRqdBs
         UsdgO9Mw9BCoa/JwGwevU05x+TATwAD66GfExn76d+tLcUy/yIxQ+q5w+X2vruJXgt2l
         oE/5XiPXSsu5zpmMV4XQRQWW9XZWHhaPYS2cLG2r+wjfWFoVgFGMi+Rdd4AxLlE6gCZc
         B45apIR0UGO6XXS1POZmNlCXrTpZCFLxx9tQd0NCMeF6NnNGMpbVFEOITfza6LsWYJbM
         t9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/S4dX13Mg98WXd22kunaGBFP/iObRIt3bHHz36/DshbKrnZh7ACXbQlRdVmCzQKFN7zRASdmqfYElSFTlcXPg3dk81NB16XpT
X-Gm-Message-State: AOJu0Yx3l+Ec4mn4ofONX7CFUyZ7T/TtCLEvIGMsmw2kw9HXPsHQQb+2
	PUQ+/RSHH4ytV8wrOWaiKnSEF0xdwm9IPwC28yE9VNTAyUNEldVssglIrSsjcDmqQVchGjNIpgu
	bmOAn8iJnXPvpzfM7CZj6/pOKUa/j7aD08jsPVA==
X-Google-Smtp-Source: AGHT+IEz+DOqbldxdx8VWXCWP6/6fTdJY+pnjm4uq4NWwzDh2gUwnQ0y3y2rNodnC/dPtB2uhZ02GJwHr8oI/OyBPSQ=
X-Received: by 2002:a05:6402:3593:b0:563:fc1d:4568 with SMTP id
 y19-20020a056402359300b00563fc1d4568mr440920edc.10.1708069782007; Thu, 15 Feb
 2024 23:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215070300.2200308-1-hch@lst.de> <20240215070300.2200308-9-hch@lst.de>
In-Reply-To: <20240215070300.2200308-9-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 16 Feb 2024 08:49:30 +0100
Message-ID: <CAMGffE=cpyWvxWwdmhyxhgBr7zxvqHS2BQwx-zm2=cm3VjRFxQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] rnbd-clt: pass queue_limits to blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Justin Sanders <justin@coraid.com>, Denis Efremov <efremov@linux.com>, 
	Josef Bacik <josef@toxicpanda.com>, Geoff Levand <geoff@infradead.org>, 
	Ilya Dryomov <idryomov@gmail.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Ming Lei <ming.lei@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, 
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	ceph-devel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:03=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Pass the limits rnbd-clt imposes directly to blk_mq_alloc_disk instead
> of setting them one at a time.
>
> While at it don't set an explicit number of discard segments, as 1 is
> the default (which most drivers rely on).
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 64 ++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index d51be4f2df61a3..b7ffe03c61606d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1329,43 +1329,6 @@ static void rnbd_init_mq_hw_queues(struct rnbd_clt=
_dev *dev)
>         }
>  }
>
> -static void setup_request_queue(struct rnbd_clt_dev *dev,
> -                               struct rnbd_msg_open_rsp *rsp)
> -{
> -       blk_queue_logical_block_size(dev->queue,
> -                                    le16_to_cpu(rsp->logical_block_size)=
);
> -       blk_queue_physical_block_size(dev->queue,
> -                                     le16_to_cpu(rsp->physical_block_siz=
e));
> -       blk_queue_max_hw_sectors(dev->queue,
> -                                dev->sess->max_io_size / SECTOR_SIZE);
> -
> -       /*
> -        * we don't support discards to "discontiguous" segments
> -        * in on request
> -        */
> -       blk_queue_max_discard_segments(dev->queue, 1);
> -
> -       blk_queue_max_discard_sectors(dev->queue,
> -                                     le32_to_cpu(rsp->max_discard_sector=
s));
> -       dev->queue->limits.discard_granularity =3D
> -                                       le32_to_cpu(rsp->discard_granular=
ity);
> -       dev->queue->limits.discard_alignment =3D
> -                                       le32_to_cpu(rsp->discard_alignmen=
t);
> -       if (le16_to_cpu(rsp->secure_discard))
> -               blk_queue_max_secure_erase_sectors(dev->queue,
> -                                       le32_to_cpu(rsp->max_discard_sect=
ors));
> -       blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
> -       blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
> -       blk_queue_max_segments(dev->queue, dev->sess->max_segments);
> -       blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
> -       blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
> -       blk_queue_write_cache(dev->queue,
> -                             !!(rsp->cache_policy & RNBD_WRITEBACK),
> -                             !!(rsp->cache_policy & RNBD_FUA));
> -       blk_queue_max_write_zeroes_sectors(dev->queue,
> -                                          le32_to_cpu(rsp->max_write_zer=
oes_sectors));
> -}
> -
>  static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
>                                    struct rnbd_msg_open_rsp *rsp, int idx=
)
>  {
> @@ -1403,18 +1366,41 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_cl=
t_dev *dev,
>  static int rnbd_client_setup_device(struct rnbd_clt_dev *dev,
>                                     struct rnbd_msg_open_rsp *rsp)
>  {
> +       struct queue_limits lim =3D {
> +               .logical_block_size     =3D le16_to_cpu(rsp->logical_bloc=
k_size),
> +               .physical_block_size    =3D le16_to_cpu(rsp->physical_blo=
ck_size),
> +               .io_opt                 =3D dev->sess->max_io_size,
> +               .max_hw_sectors         =3D dev->sess->max_io_size / SECT=
OR_SIZE,
> +               .max_hw_discard_sectors =3D le32_to_cpu(rsp->max_discard_=
sectors),
> +               .discard_granularity    =3D le32_to_cpu(rsp->discard_gran=
ularity),
> +               .discard_alignment      =3D le32_to_cpu(rsp->discard_alig=
nment),
> +               .max_segments           =3D dev->sess->max_segments,
> +               .virt_boundary_mask     =3D SZ_4K - 1,
> +               .max_write_zeroes_sectors =3D
> +                       le32_to_cpu(rsp->max_write_zeroes_sectors),
> +       };
>         int idx =3D dev->clt_device_id;
>
>         dev->size =3D le64_to_cpu(rsp->nsectors) *
>                         le16_to_cpu(rsp->logical_block_size);
>
> -       dev->gd =3D blk_mq_alloc_disk(&dev->sess->tag_set, NULL, dev);
> +       if (rsp->secure_discard) {
> +               lim.max_secure_erase_sectors =3D
> +                       le32_to_cpu(rsp->max_discard_sectors);
> +       }
> +
> +       dev->gd =3D blk_mq_alloc_disk(&dev->sess->tag_set, &lim, dev);
>         if (IS_ERR(dev->gd))
>                 return PTR_ERR(dev->gd);
>         dev->queue =3D dev->gd->queue;
>         rnbd_init_mq_hw_queues(dev);
>
> -       setup_request_queue(dev, rsp);
> +       blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
> +       blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
> +       blk_queue_write_cache(dev->queue,
> +                             !!(rsp->cache_policy & RNBD_WRITEBACK),
> +                             !!(rsp->cache_policy & RNBD_FUA));
> +
>         return rnbd_clt_setup_gen_disk(dev, rsp, idx);
>  }
>
> --
> 2.39.2
>

