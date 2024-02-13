Return-Path: <linux-mmc+bounces-1029-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286DA853FE9
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Feb 2024 00:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDAD1F2A861
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Feb 2024 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999136312B;
	Tue, 13 Feb 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kys4IbvQ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2326310B
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866204; cv=none; b=S+veGMeZcDWyvWbLEp0b9YIIjiNjoiyM8/ZHht+3Ha5wyqf0qD8zZP/vRDmM4UsIDLFZmicrmU2bIGNHIuih6zUGl2TtVFKFlqeaG6FD6aC+18JwNvfPkoBD+P5u9xzICi/nMtPBvYbfGAg0zFDnNG0I1qrn7kprHHsqxIxHk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866204; c=relaxed/simple;
	bh=rogsonCUUROhfNG0WfLmpI4i3Hmd54Nf1t6VPyqZI78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOePqO3MscgXxtsoXxs3maGhS9JTf0aK3Nc1v+EaV0Fs32uShDgx0fKn0dsx0ibBSbkrOi6ysB1fqVxznTDSsIqQrc2KQq/O2F/BsedwJm7Nowe7y8epWxyx72aLagWJP+hDRA/naTnnqjzq6gVt+WbUa3OG9VM3lcwfPraPLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kys4IbvQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60778cd55caso16829987b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707866201; x=1708471001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rogsonCUUROhfNG0WfLmpI4i3Hmd54Nf1t6VPyqZI78=;
        b=Kys4IbvQ9Cj0dY2PpINAhwhV6Bn5wlFoCX2uZDIs3qDQGqtJWlB6wTes5jALxCBj2s
         zKxI9zcuHOfW9M7oGb/bdWa6AFPIrzUj4T/os1HcNXju/R/BliUHXkpuhga1hA0W0RcC
         bth3OU63sJ1eXQIQKg3SNxw7eVwZdw3xTSgBgilsFpQK/CR3cn81ifzZ33qhoXGOakKh
         9CTL7g3JQiQ0mzx9Lg4sYwRxvkR4SRnjQbYY466aZ0VG800gWkTXhmQaD70T6nYiq2rH
         N3/RaD5IJlI4/TeU8D5ENKJ515U37Qvjsi5UYlgVPIIWl+cq54+6qoFFScQJgydkuXBg
         cVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866201; x=1708471001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rogsonCUUROhfNG0WfLmpI4i3Hmd54Nf1t6VPyqZI78=;
        b=LHJNVQLbezUlz/sZGhG0I2pAaxvApkFDH6/m6ePrRNP6BTaV6felNfS5fNqO+D7f3i
         EpNjgMoDJYWd/GG36QLCi94CHDKjuX0oxqZLG3DsW1EFC2fmFptIluYss6ZH3cJYJn74
         zk8Z1yAaBsEE9baoViaLVmpnaPtSonywEV3N8+mqrFGprDQOdnfu01asQvytq03fYsWE
         /2AJ++boxdLJQI5NjHQSHE0+oUR1BIGmGXhQBh8xiTKL9hHloBQAhC13n3AAaYf7dEzm
         SOHtpEWeJyY6hz7E0MyyeHNf8Ssd1rsWk0CHXjAfJRsGUA1GmnNNcB2q2tpDHQOWmnPD
         aKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mXUkPoXSTyUFLMZtCmDTeIPmqlMbVEdzF+f12hSwS5w1hxLWF7MkkEubRjRbbRM0RH3ZwYXk03KN5YAT6zXsGKY6IZggJLa9
X-Gm-Message-State: AOJu0YzR29WfUvEmB3BI+pLeIzqV+EcvUswbq/arGKZ26XEJlwCUVigw
	4iabi3KWvo9ZSvzuYYB6pOZStugjqApPS8FM3wbE2drxtEeVoVB8EfsBZ9ofEcv9w/2jpa3/6d0
	NDI6dibrT4+8nlQbt68QzzWw6bI8kQtWN2RWuD3GbTh6L5AKW
X-Google-Smtp-Source: AGHT+IHXecmjsyFf+7fmZuYGNgbhtE+vU+Q8pPSjyt8LdOPtfSzvh1RTzmkos/2D+vrdM9YHQZQiiHXseE/f0liHVCU=
X-Received: by 2002:a0d:eb83:0:b0:5f8:c3a:6989 with SMTP id
 u125-20020a0deb83000000b005f80c3a6989mr850068ywe.34.1707866201624; Tue, 13
 Feb 2024 15:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
 <CAHUa44Ht93U2Q78Xx91J_Xq=dBrhwjy2tERO4BntfNywewxVAg@mail.gmail.com>
In-Reply-To: <CAHUa44Ht93U2Q78Xx91J_Xq=dBrhwjy2tERO4BntfNywewxVAg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2024 00:16:05 +0100
Message-ID: <CAPDyKFr3QfDOhXkXQ7PTBDBviepQZsv05UmOiw=cn-QbS+xsnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 at 09:06, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> On Tue, Feb 6, 2024 at 1:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such =
a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB Driver whic=
h
> > > can be accessed by the optee driver to facilitate early RPMB access t=
o
> > > OP-TEE OS (secure OS) during the boot time.
> >
> > How early do we expect OP-TEE to need RPMB access?
> >
> > The way things work for mmc today, is that the eMMC card gets
> > discovered/probed via a workqueue. The work is punted by the mmc host
> > driver (typically a module-platform-driver), when it has probed
> > successfully.
> >
> > The point is, it looks like we need some kind of probe deferral
> > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > know.
>
> As I wrote in another reply. I'd like to probe the OP-TEE driver
> without touching RPMB first, and then as the devices start to appear
> we discover the one to use. In this patchset I'm relying on the OP-TEE
> client to wait until the RPMB device is available. That's probably
> good enough for user space client, but I guess not for kernel clients
> (drivers).

Right, I understand.

Obviously we don't need to solve all problems (use-cases) at once, but
it sure sounds like we at least need to make some additional thinking
around this part.

>
> >
> > >
> > > A TEE device driver can claim the RPMB interface, for example, via
> > > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > > provides a callback to route RPMB frames to the RPMB device accessibl=
e
> > > via rpmb_route_frames().
> >
> > By looking at the design of the interface, I do like it. It's simple
> > and straightforward.
> >
> > However, I wonder if you considered avoiding using a class-device
> > altogether? Even if it helps with lifecycle problems and the
> > ops-lookup, we really don't need another struct device with a sysfs
> > node, etc.
>
> Yes, the class-device might be more of a leftover from earlier
> versions with a user space interface too. Let's try to do this without
> a class-device. I was considering using class_interface_register() for
> the optee driver to get notified of an eventual RPMB device, but if we
> don't have an RPMB class device we'll need some other mechanism for
> that. Perhaps a rpmb_interface_register() with similar callbacks as
> class_interface_register().

Okay, sounds like you want to make it a try. I am happy to look at the
code, ofcourse. Although, honestly - I don't know what's the preferred
option here.

>
> >
> > To deal with the lifecycle issue, we could probably just add reference
> > counting for the corresponding struct device that we already have at
> > hand, which represents the eMMC/UFS/NVME card. That together with a
> > simple list that contains the registered rpmb ops. But I may be
> > overlooking something, so perhaps it's more complicated than that?
>
> I could try to call mmc_blk_get() in mmc_blk_alloc_rpmb_part() when
> storing the md pointer in the newly created struct mmc_rpmb_data. If
> that works as I hope, then I can get rid of the two get_resources()
> and put_resources() callbacks. We should probably update
> mmc_rpmb_chrdev_open() and mmc_rpmb_chrdev_release() to match this.

Something like that. But I need to have a closer look at this
(probably easier to review another version of the patchseries), to
really tell what works best.

Do note that mmc/sd cards are hot-pluggable (removable) from the mmc
block device point of view.

[...]

Kind regards
Uffe

