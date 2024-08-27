Return-Path: <linux-mmc+bounces-3556-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E69614D2
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4848284163
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449451C9EAD;
	Tue, 27 Aug 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K82UE5l7"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD0DDAB
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778034; cv=none; b=gPZQrscHpyH6iGJxPDLn5HnWygKtvWnUMeQh5ECqcEvHHPzbZ+Trjk1WlGgBMqSnKY1J1synSpMystRSFuXBtY8bNDq2iWc0TG5wfR5TV/rswQVnBJaSAtirKbVJVczsbdyPpLTTvIdzwN0sO1OlqHP8ZH1M09/HUK9tbHs+8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778034; c=relaxed/simple;
	bh=o/36KuuzkZWjaEASkl/Ljq0NVD2Apf8lC7arMzKvLdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be2OyVyBlX59mJ0fx2QCXsMn+qI5/wu7gGi05mIuJsI2FUnV9FgpJ9KULRmrAI/gBfohCSW3lfU6YGE1DcUOU05LTDEtGhQlSkPClozkO0gNRgCCb31lpsTsmr+R/Ag9yi47/cvJfdDJXsHZt94PNExzDxcHi+ErxHR17I3DIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K82UE5l7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b6b9867f81so48210567b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724778031; x=1725382831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fi8ox7pRszODxLsH//F7Js7GnpcRgiT9DScTVMAqaM=;
        b=K82UE5l7iOzQfRIj/a8X5mfQkUgLuRuiakHC8mgINbsnVkPQMLPgyv7ULZ4BR5Y69f
         LQ/7RACJZBLCLBHqKeTEkumz3mzBY9/+SDGrFzy/CY5vjcfduX+5Wm2z+ki37xDC5sQ8
         JZcAreHpfYe8qXZqgL7UdTaCEABFEtpnrE+6PG0VdncqjyU7D2O5K8iBA7ck+ZsXkSci
         1SUb5VIHagw8I5evwffWxifzO7UxnFjnf0se2j3vtIdRiTNxNqA51eblclvHnRAXKmLE
         dqwMX4v9iu8m4zjB0t/bge9I4TVdlM///YdQ6pYs3koI8wWPRxlDpoGlkE2slYMCmug4
         lCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778031; x=1725382831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fi8ox7pRszODxLsH//F7Js7GnpcRgiT9DScTVMAqaM=;
        b=l3CyAdIPiKqev0YoTr4GxQ+1+Cfz2j7872g6oPhnVsjLpJ3aF+JqvSUDOa682IZu/x
         sMpZ+BAmG9KFnSbOLtft7jXJpAdIB10lc10uPeDsObTboDpbpRX3C2OFIcPpfRGpGU66
         cUhav0lnoFTjsBgD+qvolFOPa4JnurCByiPXYDL3c0RjJtgC6MfWaiAfevxt4IBapY+9
         9BX5jY2lzDVDTRsDP5xH1Wi++CiQndR/zRhkfHFtxlHwIc4ZW9BzlALPZG47fI1h3TEB
         4a8wunCuZTx/idgbwKqHczpbhJdBbN5tZRcVI3OJTR55U09hscWkIwLca8UDzZ79RkB7
         xTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCa3BP0mZ/E+ri82H/qVB247LomqhvS5M7OlJBWjcP0JMCVVDnMy+NQJz7JKZipjzNknNYWCpWoqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYn61SLstluDPoD+Z1Mg0tCj8TcBpdZr83BpPrscwY4JXKvyHL
	SjYxDxadX4US2Ccd098W9594VnVTp36u4whzWNBOwnUmlAraOMincFH6AvaHnZHlmzfBe2c9Mo4
	37pnu6NUjnf2acUmxXedWRUTZPT3+l7xkHCTLPA==
X-Google-Smtp-Source: AGHT+IGmbSYxYyIspbSsfa9hoBtIp7ns0PaGV0NrZpzLhufVXheexcEWJMYHo0i/aJn3LcDf04Blwkm+zF5thUq4N8k=
X-Received: by 2002:a05:690c:fd1:b0:6be:28ab:d874 with SMTP id
 00721157ae682-6c6249dd326mr160767197b3.2.1724778031329; Tue, 27 Aug 2024
 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
 <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com> <CAPLW+4=NcjOFRd14ecYd8sMsiJXH9c+ZXse7BVMCWe5ZbMmKMQ@mail.gmail.com>
 <bd334314-25f7-4e87-bcab-e3baed9a7ab5@app.fastmail.com>
In-Reply-To: <bd334314-25f7-4e87-bcab-e3baed9a7ab5@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 27 Aug 2024 12:00:20 -0500
Message-ID: <CAPLW+4=EJ4qw4u34bvJ2KPhkEObodB5y-YjnsQmLwHhKpfPvsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "jh80.chung" <jh80.chung@samsung.com>, Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, 
	Will Newton <will.newton@gmail.com>, Matt Fleming <matt@console-pimps.org>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, Aug 27, 2024 at 2:27=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Aug 27, 2024, at 03:28, Sam Protsenko wrote:
> > On Thu, Mar 7, 2024 at 1:52=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
>
> >>
> >> The change looks good to me.
> >>
> >> I see that the host->ring_size depends on PAGE_SIZE as well:
> >>
> >> #define DESC_RING_BUF_SZ        PAGE_SIZE
> >> host->ring_size =3D DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr=
);
> >> host->sg_cpu =3D dmam_alloc_coherent(host->dev,
> >>                DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);
> >>
> >> I don't see any reason for the ring buffer size to be tied to
> >> PAGE_SIZE at all, it was probably picked as a reasonable
> >> default in the initial driver but isn't necessarily ideal.
> >>
> >> From what I can see, the number of 4KB elements in the
> >> ring can be as small as 128 (4KB pages, 64-bit addresses)
> >> or as big as 4096 (64KB pages, 32-bit addresses), which is
> >> quite a difference. If you are still motivated to drill
> >> down into this, could you try changing DESC_RING_BUF_SZ
> >> to a fixed size of either 4KB or 64KB and test again
> >> with the opposite page size, to see if that changes the
> >> throughput?
> >>
> >
> > Sorry for the huge delay. Just ran the tests:
> >
> > - 4K pages, DESC_RING_BUF_SZ =3D 4K: 97 MB/s
> > - 4K pages, DESC_RING_BUF_SZ =3D 16K: 98 MB/s
> > - 4K pages, DESC_RING_BUF_SZ =3D 64K: 97 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 4K: 123 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 16K: 125 MB/s
> > - 16K pages, DESC_RING_BUF_SZ =3D 64K: 124 MB/s
> > - 64K pages, DESC_RING_BUF_SZ =3D 4K: 137 MB/s
> > - 64K pages, DESC_RING_BUF_SZ =3D 16K: 135 MB/s
> > - 64K pages, DESC_RING_BUF_SZE =3D 64K: 138 MB/s
>
> Thanks!
>
> > From what you said, it looks like it may make a sense to reduce
> > DESC_RING_BUF_SZ down to 4 KiB? If so, I'd suggest we do that in a
> > separate patch, as this one actually fixes kernel panic when 16k/64k
> > pages are enabled. Please let me know what you think.
>
> Agreed, sounds good to me.
>

Can you please take this patch? It should apply fine without the need
to rebase it. It fixes a kernel panic when big pages are enabled, so
it's an important fix for us. As discussed with Arnd, the
DESC_RING_BUF_SZ change can be made later as a separate patch.

Thanks!

