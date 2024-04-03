Return-Path: <linux-mmc+bounces-1676-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B917A895FBA
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Apr 2024 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF3B1C2368C
	for <lists+linux-mmc@lfdr.de>; Tue,  2 Apr 2024 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0C22EF5;
	Tue,  2 Apr 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZDYQxIk"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F22260B
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097825; cv=none; b=aFAN1b6JhpfBYi5a7Jf+IKcFdMSVYmA/cWIREdDEhrOlB7ByCymO7Cf7jOWc31q8fp6yS/wFF5QhK1/GOYtedR6Pa3cx5+qPyY2C4WGKT8kd+Ii66TWUC3jL4PfiaepvuSWpysT8D02oIiCWkjGtFPJbmqxkSpECpDiBb6RYGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097825; c=relaxed/simple;
	bh=GFiAxf8pniOzwSAvuUeMYccfrTRaFyoxF8AIEedOUNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPMSZtAnlua/xK7+IMyvWNviQO5ADUvYNpesUr7doomFuLUCmdiTVr7Jkz/WuNRiRYYak1Mu/FWGSoa1aWRaxgRqfjAwXwu67O0MoyebXOcPoRRyhgfZcp5pFAjpUUQiaRctnZv0UfDMsakC1n0ey6dHEWx8/LXoIDtnzdzfMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZDYQxIk; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc236729a2bso5330421276.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712097822; x=1712702622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhKj52ntP3jIznJn9tpCxnFtv47wZoK6aLt2OwfcE7g=;
        b=JZDYQxIkc+vY2vBc6EpgU4T1A37Yb7IyxHTd23xr1zhuV4DV4Vyk9+LocUIkjaeoqC
         8ROSp0XsfS0sS1Q1ZJuD+kh9VHk0lDqjrXyYIuxllxdI3Xy1DAC5Ur373JoFe6i/iFkN
         BjXbYpr5OQSblBCt6HMpS4oSXesGm6CnShK5U4u8gTRA0WAbOuOs3z38FIjvLLt+mACJ
         kptdYwYzrlpUhzRUJK1bfkINcb0YK+ZF9MU/+KFs4ukDK7HxI+FFokHFKxKkpIXp1tzQ
         K9ZPDquP0CmonCUenbC2Eg/rOxllUPhnUYJQMr+GTcCvfhe0BV1gcKtiqH6Dsyh+bsh1
         U3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097822; x=1712702622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhKj52ntP3jIznJn9tpCxnFtv47wZoK6aLt2OwfcE7g=;
        b=Pwf1ohox0+Q9D+0o1FPabs/4MPWNLJustUWeB8MeGWfngCXGTFTJPgpru8lONA0zq6
         f60WlgyV00Vo47Kct/vVh2WdYtpIpOyOo/nLGPqCv6nEfRJDlWkO4WnSfM+uPK+Sb1By
         EvzCgyZ7WNDdNefGVP8blKQZ2OgntncF/1rizHJhdz9GNsm/QBiwcypDaHbBTgrMtuRU
         qkhF+5t8pxLXj2acbBvt+ADBdLHdxfxEmLHv5cqqkww21ewfX7vANw+wUmEH8XNln0+P
         0HISaoYJ7IHWqEi3NKkNIwLaJMbXUYFzveRM8vpRvRCs93sr7I/KY2u3+Njx9r+p8495
         t4tg==
X-Forwarded-Encrypted: i=1; AJvYcCUdvBEWqjM36iZTmy8uWmrc0Z9jMth9WQbfzwkL6/UL6/X3ZIje6MC1mBxOwXrsiEApEO/icGgnad2SHfvsAJW1sNm5WFXSmkLe
X-Gm-Message-State: AOJu0Yxx2kFBaDswxciuY1FCjT1mxBAUCXEP8U6QK3PSSWQcDpiG1yo4
	knQ/2TCb3bF+lghvFZ1Pr0DFdtmw09bnltu4Iba3hdeg2cBrOOnr+EOcVYKfR0pw/8lgsaq5oOZ
	MILU8e7ZrQxBaxG8SNdP3nPgEswBXVF1buNNmuA==
X-Google-Smtp-Source: AGHT+IGlgswx8znnfO3JxpaKsCVBFLcxqzWxCF2p/CGD6pZpo4KXa3L3gnmft1HCkz80Blu4QCQq/VSoRuINJuFvafs=
X-Received: by 2002:a05:6902:f8a:b0:dc6:4d0c:e9de with SMTP id
 ft10-20020a0569020f8a00b00dc64d0ce9demr1276842ybb.0.1712097821924; Tue, 02
 Apr 2024 15:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org> <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
In-Reply-To: <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 2 Apr 2024 17:43:31 -0500
Message-ID: <CAPLW+4mu3K38_sPnTDj-gkvdsnfN3OKXwfDSBUg_jUj+f122cA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, 
	Matt Fleming <matt@console-pimps.org>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 7, 2024, at 00:20, Sam Protsenko wrote:
> > Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
> > revealed the long living issue in dw_mmc.c driver, existing since the
> > time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
> > Add Synopsys DesignWare mmc host driver."), also making kernel boot
> > broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
> > with this message in dmesg:
> >
> >     mmcblk: probe of mmc0:0001 failed with error -22
> >
> > That's happening because mmc_blk_probe() fails when it calls
> > blk_validate_limits() consequently, which returns the error due to
> > failed max_segment_size check in this code:
> >
> >     /*
> >      * The maximum segment size has an odd historic 64k default that
> >      * drivers probably should override.  Just like the I/O size we
> >      * require drivers to at least handle a full page per segment.
> >      */
> >     ...
> >     if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> >         return -EINVAL;
> >
> > In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> > sets .max_seg_size to 4 KiB:
> >
> >     mmc->max_seg_size =3D 0x1000;
> >
> > The comment in the code above explains why it's incorrect. Arnd
> > suggested setting .max_seg_size to .max_req_size to fix it, which is
> > also what some other drivers are doing:
> >
> >    $ grep -rl 'max_seg_size.*=3D.*max_req_size' drivers/mmc/host/ | \
> >      wc -l
> >    18
>
> Nice summary!
>
> > This change is not only fixing the boot with 16K/64K pages, but also
> > leads to a better MMC performance. The linear write performance was
> > tested on E850-96 board (eMMC only), before commit [1] (where it's
> > possible to boot with 16K/64K pages without this fix, to be able to do
> > a comparison). It was tested with this command:
> >
> >     # dd if=3D/dev/zero of=3Dsomefile bs=3D1M count=3D500 oflag=3Dsync
> >
> > Test results are as follows:
> >
> >   - 4K pages,  .max_seg_size =3D 4 KiB:                   94.2 MB/s
> >   - 4K pages,  .max_seg_size =3D .max_req_size =3D 512 KiB: 96.9 MB/s
> >   - 16K pages, .max_seg_size =3D 4 KiB:                   126 MB/s
> >   - 16K pages, .max_seg_size =3D .max_req_size =3D 2 MiB:   128 MB/s
> >   - 64K pages, .max_seg_size =3D 4 KiB:                   138 MB/s
> >   - 64K pages, .max_seg_size =3D .max_req_size =3D 8 MiB:   138 MB/s
>
> Thanks for sharing these results. From what I can see here, the
> performance changes significantly with the page size, but barely
> with the max_seg_size, so this does not have the effect I was
> hoping for. On a more positive note this likely means that we
> don't have to urgently backport your fix.
>
> This could mean that either there is not much coalescing across
> pages after all, or that the bottleneck is somewhere else.
>
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 8e2d676b9239..cccd5633ff40 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
> >       if (host->use_dma =3D=3D TRANS_MODE_IDMAC) {
> >               mmc->max_segs =3D host->ring_size;
> >               mmc->max_blk_size =3D 65535;
> > -             mmc->max_seg_size =3D 0x1000;
> > -             mmc->max_req_size =3D mmc->max_seg_size * host->ring_size=
;
> > +             mmc->max_req_size =3D DW_MCI_DESC_DATA_LENGTH * host->rin=
g_size;
> > +             mmc->max_seg_size =3D mmc->max_req_size;
>
> The change looks good to me.
>
> I see that the host->ring_size depends on PAGE_SIZE as well:
>
> #define DESC_RING_BUF_SZ        PAGE_SIZE
> host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
> host->sg_cpu =3D dmam_alloc_coherent(host->dev,
>                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
>
> I don't see any reason for the ring buffer size to be tied to
> PAGE_SIZE at all, it was probably picked as a reasonable
> default in the initial driver but isn't necessarily ideal.
>
> From what I can see, the number of 4KB elements in the
> ring can be as small as 128 (4KB pages, 64-bit addresses)
> or as big as 4096 (64KB pages, 32-bit addresses), which is
> quite a difference. If you are still motivated to drill
> down into this, could you try changing DESC_RING_BUF_SZ
> to a fixed size of either 4KB or 64KB and test again
> with the opposite page size, to see if that changes the
> throughput?
>

Hi Arnd,

Sorry for the late reply. I'm a bit of busy with something else right
now (trying to enable this same driver for Exynos850 in U-Boot, hehe),
I'll try to carve out some time later and tinker with
DESC_RING_BUF_SZ. But for now, can we just apply this patch as is? As
I understand, it's fixing quite a major issue (at least from what I
heard), so it would be nice to have it in -next and -stable. Does that
sound reasonable?

Thanks!

> If a larger ring buffer gives us significantly better
> throughput, we may want to always use a higher number
> independent of page size. On the other hand, if the
> 64KB number (the 138MB/s) does not change with a smaller
> ring, we may as well reduce that in order to limit the
> maximum latency that is caused by a single I/O operation.
>
>      Arnd

