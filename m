Return-Path: <linux-mmc+bounces-2004-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2038B563A
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C43285C34
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8623E493;
	Mon, 29 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9e8sZ/L"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC103D55B
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389252; cv=none; b=FdFR5jzSLufiPC3zg57kLg5vvWtt/eBQFDMc5on8MR3k1/IuSRevPhaZCFXsSlyy5RDa5gb01ZUGFfgt9WkNBDNIa8JzD4NWVdjcFQ/yqthlAEtxCX2mtypWwLwNG1PQfH5dysi0ZWkeXChDiJUa+enIXaaNVpBSBAfeID7ihAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389252; c=relaxed/simple;
	bh=VJB3XtpKsMeidKLa9MlkFGIvAwCSFeeeCNDFgrIklH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzqX8eshExaZXHNl+0H40H47wcAWuyzPdm7mr7ZOxBygmcXADwvKKcnY+v5A/Ac8K5N1ODEzv+7/v+z9yqGkhQK/pas1l1CmXJsAT7FXyYejI4xTalJCO8JpBj2CD7IteFCQgneylqHMdyuid0zkYd0b43v0aM4HBpFBPZ2PGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9e8sZ/L; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23cd15209fdso119877fac.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389249; x=1714994049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9DP9J7iPWxCL5kOfm2ENQN3TRKnqGagxTY2cYMKEiw=;
        b=y9e8sZ/L4eRY+SNS6LqfWJb14RyEq5kWl/Hke9v9OtEI0MgiTxJ+X4JwQ8VK9yplR6
         xHhyNLpQDwQodTp/lhXMW92CO002KBIuiTe9h9rw+pTE8Zk6pCzsquVDE4ib3wvDq9wy
         YGjkzR8dTqvmlBnzB7v9Darak/WXaBZMsberaLNLfyFU2C7Tt4DREhlKnPPA0By1dW2i
         1CmNht4v2Y2CAHX4CmQXRtjeUxpfqWhm8X+VfomT/Oo8x+ZECJWxoOoqp75YJiYwm5fx
         KLISPyCDmkxNkvsOmDwdGzHV8+hli/aDpAlUnL+9gy9s6l3mpZfH+xmJ8+wTXT1ic2+l
         8n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389249; x=1714994049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9DP9J7iPWxCL5kOfm2ENQN3TRKnqGagxTY2cYMKEiw=;
        b=CPMOJFcI2GjxCGbpxDMJiXaVhbW4/zqJ1Sdrk6Hgb/BrB31Acbo4psRtnYdRNXh46z
         0IN0UZN2scNRDZVqw/zfmroLrhgxeN79Pwe/ns6ZJVpvixny7npKuefIAvcB4RHN24q5
         M3Cm1M3EKu31HXzfp1l/wMPPYPn6K5kl+uOLJzCa8yFZEniIC98eDKbmOVkGZcipN7Nt
         mksIXJx2u84daiyahZir6CvFudrlTRdbHGLOW9AC159XDu5SqNEyBqtcuqPIa1S+jGe5
         xGe8jzdsYrx+MYPxG8dLiMcNN6r1/wqI1oWfRs+YXIyxQ7uP7jI/jV0LqI7wLwDCPNh9
         zYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvl8uTuzQdNNHbCOa4OlCcBhLPheDYC0F0/sb1eOgTb2odNqxESGsaOe/atihCDr/Of3XuIlRvvkjzIoMVh7JT/FihJqdXH8U
X-Gm-Message-State: AOJu0YxOEhV3c4QjiK7ufJjZowUbg8VOneZrAUIBJ0EHeA1aysbRjALu
	xVXUnz+wb0h5MawFzmvH+zm7HrekKrTFWJsVMFD+86eszdQVmU/QfUP5KWBBg7dQEUi6irD0AEo
	nRpO8cFZaz86CX9uTd2zkZPUD942KHietDDlloQ==
X-Google-Smtp-Source: AGHT+IF67DRiNiHLY4WQ/eDXvLNqYYC9N8SB52YmZ74MfzfEaVB62/a2e9VU/9nUbOX429oOvY9N3csLoqwWMqVSMCE=
X-Received: by 2002:a05:6870:c08e:b0:22d:f675:d525 with SMTP id
 c14-20020a056870c08e00b0022df675d525mr11542637oad.48.1714389249497; Mon, 29
 Apr 2024 04:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org> <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net> <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
 <Zi93_0aCq9mQ_6cD@mecka.net> <CAHUa44FG3ge3nyQVStKjfpeJvpjuQjNiZsxHjyRz+CUjHwkS=g@mail.gmail.com>
In-Reply-To: <CAHUa44FG3ge3nyQVStKjfpeJvpjuQjNiZsxHjyRz+CUjHwkS=g@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 29 Apr 2024 13:13:58 +0200
Message-ID: <CAHUa44EecehfyzE97z49e=-qA513um21JyJz_CNKweuctp=HoQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:45=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Mon, Apr 29, 2024 at 12:35=E2=80=AFPM Manuel Traut <manut@mecka.net> w=
rote:
> >
> > On Mon, Apr 29, 2024 at 12:08:45PM +0200, Jens Wiklander wrote:
> > > On Mon, Apr 29, 2024 at 11:41=E2=80=AFAM Manuel Traut <manut@mecka.ne=
t> wrote:
> > > >
> > > > On Fri, Apr 26, 2024 at 03:24:21PM +0200, Jens Wiklander wrote:
> > > > > On Thu, Apr 25, 2024 at 10:43=E2=80=AFAM Manuel Traut <manut@meck=
a.net> wrote:
> > > > > >
> > > > > > On Mon, Apr 22, 2024 at 11:19:35AM +0200, Jens Wiklander wrote:
> > > > > > > Register eMMC RPMB partition with the RPMB subsystem and prov=
ide
> > > > > > > an implementation for the RPMB access operations abstracting
> > > > > > > the actual multi step process.
> > > > > > >
> > > > > > > Add a callback to extract the needed device information at re=
gistration
> > > > > > > to avoid accessing the struct mmc_card at a later stage as we=
're not
> > > > > > > holding a reference counter for this struct.
> > > > > > >
> > > > > > > Taking the needed reference to md->disk in mmc_blk_alloc_rpmb=
_part()
> > > > > > > instead of in mmc_rpmb_chrdev_open(). This is needed by the
> > > > > > > route_frames() function pointer in struct rpmb_ops.
> > > > > > >
> > > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com=
>
> > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/mmc/core/block.c | 241 +++++++++++++++++++++++++++++=
+++++++++-
> > > > > > >  1 file changed, 239 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/bloc=
k.c
> > > > > > > index 32d49100dff5..a7f126fbc605 100644
> > > > > > > --- a/drivers/mmc/core/block.c
> > > > > > > +++ b/drivers/mmc/core/block.c
> > > > > > > @@ -33,6 +33,7 @@
> > > > > > >  #include <linux/cdev.h>
> > > > > > >  #include <linux/mutex.h>
> > > > > > >  #include <linux/scatterlist.h>
> > > > > > > +#include <linux/string.h>
> > > > > > >  #include <linux/string_helpers.h>
> > > > > > >  #include <linux/delay.h>
> > > > > > >  #include <linux/capability.h>
> > > > > > > @@ -40,6 +41,7 @@
> > > > > > >  #include <linux/pm_runtime.h>
> > > > > > >  #include <linux/idr.h>
> > > > > > >  #include <linux/debugfs.h>
> > > > > > > +#include <linux/rpmb.h>
> > > > > > >
> > > > > > >  #include <linux/mmc/ioctl.h>
> > > > > > >  #include <linux/mmc/card.h>
> > > > > > > @@ -76,6 +78,48 @@ MODULE_ALIAS("mmc:block");
> > > > > > >  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 1=
6)
> > > > > > >  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8=
)
> > > > > > >
> > > > > > > +/**
> > > > > > > + * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JE=
SD84-B51)
> > > > > > > + *
> > > > > > > + * @stuff        : stuff bytes
> > > > > > > + * @key_mac      : The authentication key or the message aut=
hentication
> > > > > > > + *                 code (MAC) depending on the request/respo=
nse type.
> > > > > > > + *                 The MAC will be delivered in the last (or=
 the only)
> > > > > > > + *                 block of data.
> > > > > > > + * @data         : Data to be written or read by signed acce=
ss.
> > > > > > > + * @nonce        : Random number generated by the host for t=
he requests
> > > > > > > + *                 and copied to the response by the RPMB en=
gine.
> > > > > > > + * @write_counter: Counter value for the total amount of the=
 successful
> > > > > > > + *                 authenticated data write requests made by=
 the host.
> > > > > > > + * @addr         : Address of the data to be programmed to o=
r read
> > > > > > > + *                 from the RPMB. Address is the serial numb=
er of
> > > > > > > + *                 the accessed block (half sector 256B).
> > > > > > > + * @block_count  : Number of blocks (half sectors, 256B) req=
uested to be
> > > > > > > + *                 read/programmed.
> > > > > > > + * @result       : Includes information about the status of =
the write counter
> > > > > > > + *                 (valid, expired) and result of the access=
 made to the RPMB.
> > > > > > > + * @req_resp     : Defines the type of request and response =
to/from the memory.
> > > > > > > + *
> > > > > > > + * The stuff bytes and big-endian properties are modeled to =
fit to the spec.
> > > > > > > + */
> > > > > > > +struct rpmb_frame {
> > > > > > > +     u8     stuff[196];
> > > > > > > +     u8     key_mac[32];
> > > > > > > +     u8     data[256];
> > > > > > > +     u8     nonce[16];
> > > > > > > +     __be32 write_counter;
> > > > > > > +     __be16 addr;
> > > > > > > +     __be16 block_count;
> > > > > > > +     __be16 result;
> > > > > > > +     __be16 req_resp;
> > > > > > > +} __packed;
> > > > > > > +
> > > > > > > +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authen=
tication Key */
> > > > > > > +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write cou=
nter */
> > > > > > > +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB =
partition */
> > > > > > > +#define RPMB_READ_DATA         0x4    /* Read data from RPMB=
 partition */
> > > > > > > +#define RPMB_RESULT_READ       0x5    /* Read result request=
  (Internal) */
> > > > > > > +
> > > > > > >  static DEFINE_MUTEX(block_mutex);
> > > > > > >
> > > > > > >  /*
> > > > > > > @@ -163,6 +207,7 @@ struct mmc_rpmb_data {
> > > > > > >       int id;
> > > > > > >       unsigned int part_index;
> > > > > > >       struct mmc_blk_data *md;
> > > > > > > +     struct rpmb_dev *rdev;
> > > > > > >       struct list_head node;
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -2672,7 +2717,6 @@ static int mmc_rpmb_chrdev_open(struct =
inode *inode, struct file *filp)
> > > > > > >
> > > > > > >       get_device(&rpmb->dev);
> > > > > > >       filp->private_data =3D rpmb;
> > > > > > > -     mmc_blk_get(rpmb->md->disk);
> > > > > > >
> > > > > > >       return nonseekable_open(inode, filp);
> > > > > > >  }
> > > > > > > @@ -2682,7 +2726,6 @@ static int mmc_rpmb_chrdev_release(stru=
ct inode *inode, struct file *filp)
> > > > > > >       struct mmc_rpmb_data *rpmb =3D container_of(inode->i_cd=
ev,
> > > > > > >                                                 struct mmc_rp=
mb_data, chrdev);
> > > > > > >
> > > > > > > -     mmc_blk_put(rpmb->md);
> > > > > > >       put_device(&rpmb->dev);
> > > > > > >
> > > > > > >       return 0;
> > > > > > > @@ -2703,10 +2746,165 @@ static void mmc_blk_rpmb_device_rele=
ase(struct device *dev)
> > > > > > >  {
> > > > > > >       struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
> > > > > > >
> > > > > > > +     rpmb_dev_unregister(rpmb->rdev);
> > > > > > > +     mmc_blk_put(rpmb->md);
> > > > > > >       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> > > > > > >       kfree(rpmb);
> > > > > > >  }
> > > > > > >
> > > > > > > +static void free_idata(struct mmc_blk_ioc_data **idata, unsi=
gned int cmd_count)
> > > > > > > +{
> > > > > > > +     unsigned int n;
> > > > > > > +
> > > > > > > +     for (n =3D 0; n < cmd_count; n++)
> > > > > > > +             kfree(idata[n]);
> > > > > > > +     kfree(idata);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb=
_data *rpmb,
> > > > > > > +                                          unsigned int cmd_c=
ount)
> > > > > > > +{
> > > > > > > +     struct mmc_blk_ioc_data **idata;
> > > > > > > +     unsigned int n;
> > > > > > > +
> > > > > > > +     idata =3D kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL=
);
> > > > > > > +     if (!idata)
> > > > > > > +             return NULL;
> > > > > > > +     for (n =3D 0; n < cmd_count; n++) {
> > > > > > > +             idata[n] =3D kcalloc(1, sizeof(**idata), GFP_KE=
RNEL);
> > > > > > > +             if (!idata[n]) {
> > > > > > > +                     free_idata(idata, n);
> > > > > > > +                     return NULL;
> > > > > > > +             }
> > > > > > > +             idata[n]->rpmb =3D rpmb;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return idata;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void set_idata(struct mmc_blk_ioc_data *idata, u32 op=
code,
> > > > > > > +                   int write_flag, u8 *buf, unsigned int buf=
_bytes)
> > > > > > > +{
> > > > > > > +     /*
> > > > > > > +      * The size of an RPMB frame must match what's expected=
 by the
> > > > > > > +      * hardware.
> > > > > > > +      */
> > > > > > > +     BUILD_BUG_ON(sizeof(struct rpmb_frame) !=3D 512);
> > > > > > > +
> > > > > > > +     idata->ic.opcode =3D opcode;
> > > > > > > +     idata->ic.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> > > > > > > +     idata->ic.write_flag =3D write_flag;
> > > > > > > +     idata->ic.blksz =3D sizeof(struct rpmb_frame);
> > > > > > > +     idata->ic.blocks =3D buf_bytes /  idata->ic.blksz;
> > > > > > > +     idata->buf =3D buf;
> > > > > >
> > > > > > I tested the series on a i.MX8MM with a eMMC connected via the =
imx-sdhci
> > > > > > controller. Reading from RPMB does not work. It ends in timeout=
s due to
> > > > > > no response from the SDHCI controller.
> > > > > >
> > > > > > If idata->buf is allocated here with kmalloc(buf_bytes, GFP_KER=
NEL) and
> > > > > > the content of buf is copied to the new allocated area, transfe=
rs succeed.
> > > > > >
> > > > > > Is it possible that idata->buf is not DMA capable? Any other id=
eas?
> > > > >
> > > > > Thanks for testing. I don't know, the idata->buf is allocated usi=
ng
> > > > > alloc_pages_exact(nr_pages * PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);=
 in
> > > > > optee_pool_op_alloc_helper().
> > > >
> > > > Is this really true for idata->buf or isnt the complete RPMB frame =
memory
> > > > allocated like this and therefore idata->buf not page aligned?
> > >
> > > You're right.
> > >
> > > >
> > > > For RPMB via tee-supplicant the idata->buf is allocated within memd=
up_user
> > > > and therefore page aligned.
> > >
> > > Yes, that's a difference. Have you tested with page-aligned buffers t=
o
> > > see if it helps?
> >
> > Yes, this helps. I tested with the following patch, but probably it can=
 also
> > be solved during frame allocation in optee?
>
> Great, thanks for confirming. Yes, we should fix that in the secure world=
.

I've pushed an update to
https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe

Cheers,
Jens

