Return-Path: <linux-mmc+bounces-231-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF147FA012
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Nov 2023 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09F61C20DB0
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Nov 2023 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F5288B0;
	Mon, 27 Nov 2023 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNdWPsxR"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129899B;
	Mon, 27 Nov 2023 04:54:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso5956178e87.1;
        Mon, 27 Nov 2023 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701089674; x=1701694474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oFnC0b1PtxuN5vYy6tuSprXuKKzLkI41CJlzuYtP+s=;
        b=JNdWPsxRjsb8kSuM1S/nMIW3C1wYTjQtiKLEzJ5JYrvZhX06gJndPX/JLCr5y4fi/l
         UidILhqEVxi8sBXquE/D7T4Z6u8qtwEXmTwy2I01vS0hF9xFQheQCyh/QNaEbWZKglXQ
         zH03Oel/hT4xibOOyzFA89Lqr5UFMHY5CvaMWMojSZB1NtU7MoZBr9aK2YWJdvUu8IV1
         XXm0ujufE1vsqf7rOR5SV730YJHvaLoAP5n2oAf9ynfhub64MBui+O/vfWrl9yTdw+Mg
         ItAB0Xqk0lQ/pNRCKojfmuJzGyGXtG5fLBin5AREl8x/oS+9lnjF2vXnzvXtKCeiP/iY
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089674; x=1701694474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oFnC0b1PtxuN5vYy6tuSprXuKKzLkI41CJlzuYtP+s=;
        b=S4up0S4wqm+9obAP6QL2weHCVySfXpwJ+7PjYQdMdMEQSkSzQ1nUsCvk1Gi/DYXDnu
         OOhEhpZmBKE5Op/CEZCV9/O367giCT4fddqy++MTNW8WRkeRP55GH9G1D3Bp0oV/8Hhr
         mhZkRMrz6tVHdH4jRlW2X3XcwxpfSTQtqtf/Y/Ekthv7gow/YAG36Byy0m2W3Mh4neQS
         y8GcN1J1HKX1dCDhGC/9S0j/hA5xeEtSAkc1RAjtefXf4ANtDwwuFCFdo1R2egjOnFPs
         e619weIlfp70Ref+keUdCboEKJR+r3d/ApPIjsKxdy06cxQSyiIJEjmsyO7kjY1vWo66
         6BjA==
X-Gm-Message-State: AOJu0Yyhy3y5L4TtMj32DvNjk6tf7d9R1rzlTwwfUwe2S154gCgUzPQz
	1yzHgR3hhqmdj9Wf99/WY8pZuAksUc156iZDKuM=
X-Google-Smtp-Source: AGHT+IHbsz5S9GLjXVukyag7Z7DqnM31noufEXbZPS6p8+i8JuLaqElqH9fFPTvKQ0432SkhUuKRBupl7x546NUDWlA=
X-Received: by 2002:a05:6512:2242:b0:50b:a995:24e2 with SMTP id
 i2-20020a056512224200b0050ba99524e2mr5598790lfu.21.1701089674015; Mon, 27 Nov
 2023 04:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh> <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh> <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh> <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
In-Reply-To: <2023112453-flagstick-bullring-8511@gregkh>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 27 Nov 2023 14:54:21 +0200
Message-ID: <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-pm@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
Content-Type: text/plain; charset="UTF-8"

pe 24. marrask. 2023 klo 19.26 Greg Kroah-Hartman
(gregkh@linuxfoundation.org) kirjoitti:
>
> On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
> > On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> > > > On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > > > > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> > > >
> > > > > > This came out of some discussions about trying to handle emergency power
> > > > > > failure notifications.
> > > >
> > > > > I'm sorry, but I don't know what that means.  Are you saying that the
> > > > > kernel is now going to try to provide a hard guarantee that some devices
> > > > > are going to be shut down in X number of seconds when asked?  If so, why
> > > > > not do this in userspace?
> > > >
> > > > No, it was initially (or when I initially saw it anyway) handling of
> > > > notifications from regulators that they're in trouble and we have some
> > > > small amount of time to do anything we might want to do about it before
> > > > we expire.
> > >
> > > So we are going to guarantee a "time" in which we are going to do
> > > something?  Again, if that's required, why not do it in userspace using
> > > a RT kernel?
> >
> > For the HW in question I have only 100ms time before power loss. By
> > doing it over use space some we will have even less time to react.
>
> Why can't userspace react that fast?  Why will the kernel be somehow
> faster?  Speed should be the same, just get the "power is cut" signal
> and have userspace flush and unmount the disk before power is gone.  Why
> can the kernel do this any differently?
>
> > In fact, this is not a new requirement. It exist on different flavors of
> > automotive Linux for about 10 years. Linux in cars should be able to
> > handle voltage drops for example on ignition and so on. The only new thing is
> > the attempt to mainline it.
>
> But your patch is not guaranteeing anything, it's just doing a "I want
> this done before the other devices are handled", that's it.  There is no
> chance that 100ms is going to be a requirement, or that some other
> device type is not going to come along and demand to be ahead of your
> device in the list.
>
> So you are going to have a constant fight among device types over the
> years, and people complaining that the kernel is now somehow going to
> guarantee that a device is shutdown in a set amount of time, which
> again, the kernel can not guarantee here.
>
> This might work as a one-off for a specific hardware platform, which is
> odd, but not anything you really should be adding for anyone else to use
> here as your reasoning for it does not reflect what the code does.

I was (am) interested in knowing how/where the regulator error
notifications are utilized - hence I asked this in ELCE last summer.
Replies indeed mostly pointed to automotive and handling the under
voltage events.

As to what has changed (I think this was asked in another mail on this
topic) - I understood from the discussions that the demand of running
systems with as low power as possible is even more
important/desirable. Hence, the under-voltage events are more usual
than they were when cars used to be working by burning flammable
liquids :)

Anyways, what I thought I'd comment on is that the severity of the
regulator error notifications can be given from device-tree. Rationale
behind this is that figuring out whether a certain detected problem is
fatal or not (in embedded systems) should be done by the board
designers, per board. Maybe the understanding which hardware should
react first is also a property of hardware and could come from the
device-tree? Eg, instead of having a "DEVICE_SHUTDOWN_PRIO_STORAGE"
set unconditionally for EMMC, systems could set shutdown priority per
board and per device explicitly using device-tree?

Yours,
    -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

