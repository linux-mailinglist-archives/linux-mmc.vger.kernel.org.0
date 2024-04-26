Return-Path: <linux-mmc+bounces-1975-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7B8B37F2
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Apr 2024 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1801F22EF7
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Apr 2024 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFD146D49;
	Fri, 26 Apr 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+N6Y1Zh"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6D13A41D
	for <linux-mmc@vger.kernel.org>; Fri, 26 Apr 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136902; cv=none; b=NDPoKkgGGdITQwMHwGDgFqbs5QJ6o5IILIZxHctX0HYVNFWSee/4OUtRQgIwTd0lja/wvXiJ5LvYVT+OEaCuN1rzFS1o0f2buvjcZnWUX3UuN2ZgpXAsP3w2HleEK41CpgzYhjunvdUURQ5CDcx4Q2mTOEIzQlIK8Tv02zXMD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136902; c=relaxed/simple;
	bh=9QscQIeNlQOp6FRyOQTocCE1OoKiIXfMF2HncBHOV0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JV54cAQ4JQq+sdU/I8Yu2oaDwfC58UsERjRoJWo79ZJTmtBFi13u5A2oOl4HyA6M/Eszbo36q3KlgWmqrGn3oNUcxhBSvIdYiG0hw3K41fBIR3lFUv93BPWWNA1oBAqpUxRCXmzufpUtdCQj9K4trRru6to07JXpXiwkjoWbdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+N6Y1Zh; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23981fd7947so1240439fac.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 Apr 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714136898; x=1714741698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKDqJ2Iy67r0/04McLSBQtbg7QGH++8ZK48LUb4Ai+8=;
        b=X+N6Y1ZhWIrUBGqd52+UPfnYcBpeZqVfUFZ7iH8W3JUvNAw8iLi5o2Bwq600803KKZ
         tXSeEGyEYfrw6V1RSXKS0x/nMTyHph1bwPlOrD9Uu0KwWKG0iYacZwcHFZ4UzjRaHkNt
         MIKFGKVH+5BSAvCrDgd3m9tMHF7+OYQHftbj/oIAeC2nnlKrTmpK5lh0W+j044BzZDjy
         TNzKOdgDEDkEyv6W8snFH09bu8rP7Q/hjcFAmTe87lrekzVxKSrhl6PatzdaNWjvaJrQ
         NPqczcnmgm5fkF0R6D+l36XU3f9HZVu6lQTmmp4HtH6E5bOAugaVd0UMmgKaxY5U31TE
         3voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714136898; x=1714741698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKDqJ2Iy67r0/04McLSBQtbg7QGH++8ZK48LUb4Ai+8=;
        b=PhPeDeiEhr1eEEiDNMjzc5YZ2Tks7dZC+3V1Zz7K1BJI3CeCfC8JYHa5WdZff2tLVp
         fOf9EiPQhvNbWoIpLVdcb7laOjWkyGJBH9ODdXg5KivWFe/eIyxT/orW7HED2mtPUw53
         Qrn5PbibZ6O9BUOzCQpXk8njk0kY9pW2F3v0HblpY9srchHJqtFdSQAxaJeWqUwZsYJb
         03qTvkPQt4fH38o5L1v9aIbmwcXb9FDN8a0b7ixeU2hmfss0eGlvUrKCVJYNptr5bxCB
         nhR1WVcYuTSxGCist4Of2qvDywxKP4wKhlUgYxVA0QxQ0nsxiJgtBt2xhEo9+e3TkxJb
         SXHA==
X-Forwarded-Encrypted: i=1; AJvYcCUJtDa2z/CswUvVJXeFQKhmZyFtW3WzwNuWFxG5r3LZHje5PQKClnNwQ0QheAW3w4Mymp/t2STU6iI0SCgjT1h60UTYwgJmRrWY
X-Gm-Message-State: AOJu0YyiU8fcDlDYulfsWrz+dkZElTXYkC+w5ddgJDPboCKUZw7trZrf
	y+eLtLIhmGiiVmvPSAHMsLZ+zTvYDxVUcWir02N2gqIJUFL+/0pwVlUsa094ZNCJAXf5pXv9LNu
	sFx4iU1PffQlls7o0zRaPFW2e7MjErZ9zbJDodg==
X-Google-Smtp-Source: AGHT+IEKq/8GFPYIuqy4rBivIIKKIIu3DhQ+5ZeHZXiraP9KB/rXTGQYaO0n0mtwRCfjOLqG8pL22JCKugRO8+NE1bw=
X-Received: by 2002:a05:6870:558c:b0:239:726:7460 with SMTP id
 qj12-20020a056870558c00b0023907267460mr2706578oac.30.1714136898414; Fri, 26
 Apr 2024 06:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-2-jens.wiklander@linaro.org> <ZioWLgVJ7Ky4nUxC@mecka.net>
In-Reply-To: <ZioWLgVJ7Ky4nUxC@mecka.net>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 26 Apr 2024 15:08:07 +0200
Message-ID: <CAHUa44EsO9rr2_KsmNcwoUuL_OAO-Oh8gqepUn5Bmo1dfP_LUA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:37=E2=80=AFAM Manuel Traut <manut@mecka.net> wro=
te:
>
> On Mon, Apr 22, 2024 at 11:19:34AM +0200, Jens Wiklander wrote:
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands. Such a partition provides authenticated and replay
> > protected access, hence suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |  10 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 232 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> >  5 files changed, 386 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-=
rotate.yaml
> >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Supported
> > +F:   drivers/misc/rpmb-core.c
> > +F:   include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:   linux-remoteproc@vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,16 @@ config PHANTOM
> >         If you choose to build module, its name will be phantom. If uns=
ure,
> >         say N here.
> >
> > +config RPMB
> > +     tristate "RPMB partition interface"
> > +     depends on MMC
> > +     help
> > +       Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> > +       UFS. Provides interface for in-kernel security controllers to a=
ccess
> > +       RPMB unit.
> > +
> > +       If unsure, select N.
> > +
> >  config TIFM_CORE
> >       tristate "TI Flash Media interface support"
> >       depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)              +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)              +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)                +=3D phantom.o
> > +obj-$(CONFIG_RPMB)           +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)  +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)   +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770) +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..5479469c26f3
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rpmb.h>
> > +#include <linux/slab.h>
> > +
> > +static struct list_head rpmb_dev_list;
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +static struct blocking_notifier_head rpmb_interface =3D
> > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +     if (rdev)
> > +             get_device(rdev->parent_dev);
> > +     return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +     if (rdev)
> > +             put_device(rdev->parent_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:    rpmb device
> > + * @req:     rpmb request frames
> > + * @req_len: length of rpmb request frames in bytes
> > + * @rsp:     rpmb response frames
> > + * @rsp_len: length of rpmb response frames in bytes
> > + *
> > + * Returns: < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                   unsigned int req_len, u8 *rsp, unsigned int rsp_len=
)
> > +{
> > +     if (!req || !req_len || !rsp || !rsp_len)
> > +             return -EINVAL;
> > +
> > +     return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
> > +                                     rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
> > +
> > +/**
> > + * rpmb_dev_find_device() - return first matching rpmb device
> > + * @data: data for the match function
> > + * @match: the matching function
> > + *
> > + * Iterate over registered RPMB devices, and call @match() for each pa=
ssing
> > + * it the RPMB device and @data.
> > + *
> > + * The return value of @match() is checked for each call. If it return=
s
> > + * anything other 0, break and return the found RPMB device.
> > + *
> > + * It's the callers responsibility to call rpmb_dev_put() on the retur=
ned
> > + * device, when it's done with it.
> > + *
> > + * Returns: a matching rpmb device or NULL on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                   const struct rpmb_dev *start,
> > +                                   int (*match)(struct rpmb_dev *rdev,
> > +                                                const void *data))
> > +{
> > +     struct rpmb_dev *rdev;
> > +     struct list_head *pos;
> > +
> > +     mutex_lock(&rpmb_mutex);
> > +     if (start)
> > +             pos =3D start->list_node.next;
> > +     else
> > +             pos =3D rpmb_dev_list.next;
> > +
> > +     while (pos !=3D &rpmb_dev_list) {
> > +             rdev =3D container_of(pos, struct rpmb_dev, list_node);
> > +             if (match(rdev, data)) {
> > +                     rpmb_dev_get(rdev);
> > +                     goto out;
> > +             }
> > +             pos =3D pos->next;
> > +     }
> > +     rdev =3D NULL;
> > +
> > +out:
> > +     mutex_unlock(&rpmb_mutex);
> > +
> > +     return rdev;
> > +}
>
> EXPORT_SYMBOL_GPL missing?

You're right, I'll add it.

Thanks,
Jens

