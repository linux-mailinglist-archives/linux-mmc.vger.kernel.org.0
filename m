Return-Path: <linux-mmc+bounces-1071-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B3856A9F
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Feb 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390D4B275AA
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Feb 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245413848D;
	Thu, 15 Feb 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pre7Mcfz"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81753138482
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016062; cv=none; b=iG31HZ7JY+wC0gvoVZ87i/F3Vy+mRA7gxIQFOcAnxG884FC66KP9r9APCJoAJP1B3p5Yhr1MXWzRNXncDSLLG2RPWEvF7k1HG47idCvc2l9fZ6wB7elY3PPkoxHOJhGhD4r5bgFIvIBJlLKrCwRjYx+euuztpAdHMobYYpm93G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016062; c=relaxed/simple;
	bh=Qz4PPFUkifJGyaRWPKT8EHaiOM/kn2UbDqOefUgZCmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFOyJ8RVf3Ed22sm3UqoCtcFFphUOtTaUGa8FbTvwzQpO/7dS4RDln3du/3KRNGpwtqO3kYZOtp9dLkh6XgNxXzVPHGYJI45Z3kHS+mmnqXizAJY3s2NCm6LwXa3qQ/DjPwcI1RdGqyC4LNqAMJz19HeTIB5YeMah9H9nj6mScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pre7Mcfz; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1599662276.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708016059; x=1708620859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEQiCmvhKfS0/A0znECfTzFjRTV/dZsqotvM6rEKanU=;
        b=pre7McfzotVVLA5sRjwMy2EQnVCLSkXeRtOFWwJdhon6KseboIF957xeL8jvjEQbuC
         83P48RFGgvSLKtcvW8Faxk/3+hpwiNc2E26f2oM4oWWVgW3yqy3FzsPRqi8rklqZ8il5
         sJIBJmfC476mwH3QuRT2sx6zo8YzUeqiHTOsz+EczCsA++VJX3CWBTFTNfWnLJlK49X+
         vyfS4aEYNO5eYd4NGkBL1YEHDiCJW1LdR4RR/xaWNpFHmvQXIwH0x6bC0wB2Wnu5NgvM
         MXu9+6r6mlPvmIBWs9oNpChgrhT0C0Xmob4klZmQRrjjNdemKJNRieQFabOeTfbbhU/v
         yyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016059; x=1708620859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEQiCmvhKfS0/A0znECfTzFjRTV/dZsqotvM6rEKanU=;
        b=Lg0qa02Jk22zAVAhzzK30TP6tu4pfI8xxr3EX/YtKYeC9gBj8oGns5PEIj5c4AAn61
         06UiVm5BctNJV2u0FSXBt9ZGr4kLPvRk0BdBkp7kg6YCRiBpgwjtJL/ar1J812JCqrHP
         +CdC6c8acrSCQbxF05WNpxXC5bczcqINZWeCtk826uGXZyqIsm9tKoxRfY5bLgwUefAc
         G2VK3sXU8yMeYFmrsIGfycUrw0kd7ZWIv4306ExzbZjXlJTTCGUWMKwbQecG36g55Pth
         erYXYZUGuiacJIyyBXz9iAr3ewAqEo1lwS+A9Fe/wgZ3COO6JvFzUKF1HwBfId5nmacj
         7oow==
X-Forwarded-Encrypted: i=1; AJvYcCXJ83yOp2A/CeW2ZiLcnC8GrMYnqdipcGOTR5jsj/yW/AJqDOjwSpyS3QRCyf3j4aPJ7GNUcHpZQLTGL3/j+hV/6H4nO6j85nGL
X-Gm-Message-State: AOJu0Yy2qobeFIEwd92qB1K3i9uqHvx6KC52TccxZyX9Hgg0Hv2U8TF0
	7+0zYn7DX4GCfSrezEYJ2bxzx/HleMhZAHO5PHbpd467ThqXDCAeGW3uHHQS0oG7aOC2wNwcedI
	P9sUafswbjXWfOCHB5rkFJ91Yl/ukENF7JtXWpw==
X-Google-Smtp-Source: AGHT+IF28WiAUAxb9BXDQ9j656YBYmKEubg2qRwCcoIKEiRoMN+j/rX1+ioqB8yOfGTSrxa8mYZDRwHKLR7BN/dl2kA=
X-Received: by 2002:a81:b717:0:b0:607:c65a:ba02 with SMTP id
 v23-20020a81b717000000b00607c65aba02mr1752372ywh.17.1708016059449; Thu, 15
 Feb 2024 08:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215070300.2200308-1-hch@lst.de> <20240215070300.2200308-18-hch@lst.de>
 <CAPDyKFqPnC9jwWnoVz+UVJJ_SGYnB4CrB8jmJOSxCnT7AYQrKg@mail.gmail.com> <20240215164942.GA19722@lst.de>
In-Reply-To: <20240215164942.GA19722@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 17:53:43 +0100
Message-ID: <CAPDyKFpSNL28sWqNMY9Y2+tP9VMd_Wabnw1hVjQ-g0RfKCUVgQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] mmc: pass queue_limits to blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Justin Sanders <justin@coraid.com>, Denis Efremov <efremov@linux.com>, 
	Josef Bacik <josef@toxicpanda.com>, Geoff Levand <geoff@infradead.org>, 
	Ilya Dryomov <idryomov@gmail.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Ming Lei <ming.lei@redhat.com>, 
	Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	ceph-devel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 17:49, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Feb 15, 2024 at 05:40:37PM +0100, Ulf Hansson wrote:
> > Looks like $subject patch, patch11 and patch12  have already been
> > queued up as they are cooking linux-next. Normally I prefer to funnel
> > these via my mmc tree, to avoid potential conflicts (mostly for mmc,
> > where more active developments are ongoing).
>
> None of this is in my fresh linux-next pull, which would be rather
> surprising anyway as I've just sent them out and Jens isn't that
> quick to merge unreviewed series :)

Weird. :-)

>
> That being said it depends on prep patches in the block tree and thus
> I'd prefer merging this entire series through that tree.

Okay, in that case, np! Next time, it would be nice to get that
information upfront in a cover-letter or similar.

If not too late, feel free to add my acks on the three patches for mmc
and memstick.

Kind regards
Uffe

