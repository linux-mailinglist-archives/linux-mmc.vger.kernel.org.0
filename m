Return-Path: <linux-mmc+bounces-4400-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46129A3BE9
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2024 12:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95104281B35
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1D201101;
	Fri, 18 Oct 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auIbv2Vu"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD420102B;
	Fri, 18 Oct 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248450; cv=none; b=Gh9q1QiIkwLbCTJTRnoqFo2T/REVooqnUQnotl39p04S9vgg8QEQp7SBnunbydm/NDhCXT8LTuL2lS53xacnmUOA8LMsCTRM4xSJ01v3nUHah0y/4NKVNPJvuvXhiuRgBqD3ktjV6y1RQ7n/coKEIbWsd7S9aQfvxzaJTZAorgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248450; c=relaxed/simple;
	bh=juh36TT1186b+SJOG+cQ6laCm5rcaXfwYcG3ieX/WG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DayeFj4pxBzvnbZDddovd/uEPYAuebd9WSrcTioqlWqVp6RPeDM7H5s1H4f6TdG3t1uQo+dAUWp1RLp77qwEHZQVjsyFM9oBLqQLJQsBB+VbTtoy8tSDVfZjoCJsWQGVP0s2Knegp9SGyEvp+HZzmhiO6R/k3rmsTKoLSic/eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auIbv2Vu; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a4864b8f98so545337137.2;
        Fri, 18 Oct 2024 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248445; x=1729853245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLM2RAsp/2yZ0pzmfzyFnwiPeZj3S5TVWW6TsXnVd38=;
        b=auIbv2VuJjVhc6zaBOx1ikvKUZfLRKmPxxi9QQGkiEw2j/6BNbBKYSmaZ2Ovbw5Njt
         +8mtZRT/6JhEe/196Q0vzEr5OJyCRZSX8drZS0k2UoTkFsEQLxKcCKMJzzT6tB6p/sPB
         Ow1pJcx1uLbGM23on4RcsRc1VjQhClf4o9ZuXJyDDkqspTsY8nIXoWxdAQ6opRJazFWi
         Aag/tYnSVAk9b4s2yR2Ks0s3OwUXo+iAYBC0y6W9rbejs46L3e+hfzLvDR6DhbUKDqOX
         41BmOSxjuL9tVa80sj8j4lhDyT43afWG5QMAwvp38OXWODYwDJAfAFjYzEiTBXXbtVr4
         RGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248445; x=1729853245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLM2RAsp/2yZ0pzmfzyFnwiPeZj3S5TVWW6TsXnVd38=;
        b=GZUmMmuMh+8rPbBgk4mS9O5eguWhWujJ3n4O+W7draWbg12VGpmOQM9CUSdoCFwqqc
         UQ2jj3NdtDc69k2B2y3dp9BIlYCfUOTuGVSiuMFUsZQGs2W7iCRdKsN/QvQUd7BwYbEs
         jeM50MG4MBard662RC3PRg5/Xt63WqBMraldeF17TF+0DziYgbTRiBidZnfIOTt9yg4O
         L+QXGC0M4e8RBc9UEGGzaU4KcuCiOPMBR9y033OIX/vu2FtCky2SA+EQ9x+u1kRkaWF1
         A0A5yTEi5UWHEl9aWorfCUSfi2VPA5o+qcVS5IrpmRSA4OfzbUIl6mzRRJCdq0YLx+x2
         ITkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeMaykRuF3Po517RgJrDdB08YMm+rA28hmmXQWeWd+r9ySiKEfxB8IuOAfJKCKbVwjW98w3Vj8y+BaC0I=@vger.kernel.org, AJvYcCWiX4xl1D5yA/7YXT07pzZ2k1OE+aHURZLZf75Y6ap9x2IsyumRTSisBRfSkHerQZyNfhiPBtosDL6j@vger.kernel.org
X-Gm-Message-State: AOJu0YxdurJgRTVNoU/jJF94Z+aYteKVpO/jttcrHgwa7hxLmyZ1hZ4F
	hd97+YmD6FtY9ZnSm72nQM0fS0AyrIoXFqlab8qQ6x0EiMLm8kaLW5fdZD7pQmTrRRNKodzoCK+
	25+iKzcIRu2xAxfm48mIkto0iJcs=
X-Google-Smtp-Source: AGHT+IF1duHmkyl0w+8IXrMGRnvJnci5fuLPTKDeVvxmCkyjKrH0ZJsI5zIGrxqCi8+2g3RnP/u60tCVvClqsER7Ts4=
X-Received: by 2002:a05:6102:5120:b0:492:9e3a:9f48 with SMTP id
 ada2fe7eead31-4a5d6a8b20bmr1257800137.2.1729248444896; Fri, 18 Oct 2024
 03:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-8-victorshihgli@gmail.com> <CAPDyKFrbVY3OGmCn0wx8yv2n61ALAa54-vkUVqU8+bLo_=y=6w@mail.gmail.com>
In-Reply-To: <CAPDyKFrbVY3OGmCn0wx8yv2n61ALAa54-vkUVqU8+bLo_=y=6w@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 18 Oct 2024 18:47:12 +0800
Message-ID: <CAK00qKBgKyj8MoCUz6L6WJJTP3eO35B__oJaXEHQJjaaRpS0XQ@mail.gmail.com>
Subject: Re: [PATCH V22 07/22] mmc: core: Support UHS-II card control and access
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 13 Sept 2024 at 12:29, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Embed UHS-II access/control functionality into the MMC request
> > processing flow.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V16:
> >  - Separate the Error Recovery mechanism into a separate patch#8.
> >
> > Updates in V15:
> >  - Move struct uhs2_command uhs2_cmd to struct mmc_request and
> >    modify whatever other changers to make it work.
> >  - Refer the SD Host Controller Standard Specification Section 3.10
> >    to add Error Recovery mechanism to recover the command error.
> >
> > Updates in V13:
> >  - Separate __mmc_go_idle() into one patch for re-factorring the code.
> >  - Move mmc_decode_scr declaration to sd.h.
> >  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> >  - Drop unnecessary comment.
> >
> > Updates in V12:
> >  - Use mmc_op_multi() to check DCMD which supports multi read/write
> >    in mmc_uhs2_prepare_cmd().
> >
> > Updates in V10:
> >  - Move some definitions of PatchV9[02/23] to PatchV10[06/23].
> >  - Move some definitions of PatchV9[05/23] to PatchV10[06/23].
> >  - Drop do_multi in the mmc_blk_rw_rq_prep().
> >  - Use tmode_half_duplex to instead of uhs2_tmode0_flag.
> >  - Move entire control of the tmode into mmc_uhs2_prepare_cmd().
> >
> > Updates in V8:
> >  - Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >  - Modify return value in sd_uhs2_attach().
> >
> > Updates in V7:
> >  - Add mmc_uhs2_card_prepare_cmd helper function in sd_ops.h.
> >  - Drop uhs2_state in favor of ios->timing.
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/core/core.c    |    6 +-
> >  drivers/mmc/core/sd.c      |   10 +-
> >  drivers/mmc/core/sd.h      |    5 +
> >  drivers/mmc/core/sd_ops.c  |    9 +
> >  drivers/mmc/core/sd_ops.h  |   13 +
> >  drivers/mmc/core/sd_uhs2.c | 1100 ++++++++++++++++++++++++++++++++++--
> >  include/linux/mmc/core.h   |   17 +
> >  include/linux/mmc/host.h   |   15 +
> >  8 files changed, 1136 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 8b8aff131f8b..1841a2190571 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -351,6 +351,8 @@ int mmc_start_request(struct mmc_host *host, struct=
 mmc_request *mrq)
> >         if (err)
> >                 return err;
> >
> > +       mmc_uhs2_card_prepare_cmd(host, mrq);
> > +
> >         led_trigger_event(host->led, LED_FULL);
> >         __mmc_start_request(host, mrq);
> >
> > @@ -450,6 +452,8 @@ int mmc_cqe_start_req(struct mmc_host *host, struct=
 mmc_request *mrq)
> >         if (err)
> >                 goto out_err;
> >
> > +       mmc_uhs2_card_prepare_cmd(host, mrq);
> > +
> >         err =3D host->cqe_ops->cqe_request(host, mrq);
> >         if (err)
> >                 goto out_err;
> > @@ -1132,7 +1136,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32=
 ocr)
> >                 return 0;
> >         }
> >
> > -       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> > +       if (!mmc_card_uhs2(host) && host->caps2 & MMC_CAP2_FULL_PWR_CYC=
LE) {
> >                 bit =3D ffs(ocr) - 1;
> >                 ocr &=3D 3 << bit;
> >                 mmc_power_cycle(host, ocr);
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 12fe282bea77..d5576a2f4435 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -194,7 +194,7 @@ static int mmc_decode_csd(struct mmc_card *card)
> >  /*
> >   * Given a 64-bit response, decode to our card SCR structure.
> >   */
> > -static int mmc_decode_scr(struct mmc_card *card)
> > +int mmc_decode_scr(struct mmc_card *card)
> >  {
> >         struct sd_scr *scr =3D &card->scr;
> >         unsigned int scr_struct;
> > @@ -894,7 +894,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
> >         return 0;
> >  }
> >
> > -static int mmc_sd_get_ro(struct mmc_host *host)
> > +int mmc_sd_get_ro(struct mmc_host *host)
> >  {
> >         int ro;
> >
> > @@ -1623,7 +1623,7 @@ static void mmc_sd_detect(struct mmc_host *host)
> >         }
> >  }
> >
> > -static int sd_can_poweroff_notify(struct mmc_card *card)
> > +int sd_can_poweroff_notify(struct mmc_card *card)
> >  {
> >         return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIF=
Y;
> >  }
> > @@ -1651,7 +1651,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_da=
ta, bool *busy)
> >         return 0;
> >  }
> >
> > -static int sd_poweroff_notify(struct mmc_card *card)
> > +int sd_poweroff_notify(struct mmc_card *card)
> >  {
> >         struct sd_busy_data cb_data;
> >         u8 *reg_buf;
> > @@ -1699,7 +1699,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
> >         if (mmc_card_suspended(card))
> >                 goto out;
> >
> > -       if (sd_can_poweroff_notify(card))
> > +       if (mmc_sd_can_poweroff_notify(card))
>
> There is no need to change this. Please stick with sd_can_poweroff_notify=
().
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >                 err =3D sd_poweroff_notify(card);
> >         else if (!mmc_host_is_spi(host))
> >                 err =3D mmc_deselect_cards(host);
> > diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> > index fe6dd46927a4..49afaef269cd 100644
> > --- a/drivers/mmc/core/sd.h
> > +++ b/drivers/mmc/core/sd.h
> > @@ -11,10 +11,15 @@ struct mmc_card;
> >
> >  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr=
);
> >  int mmc_sd_get_csd(struct mmc_card *card);
> > +int mmc_decode_scr(struct mmc_card *card);
> > +int mmc_sd_get_ro(struct mmc_host *host);
> >  void mmc_decode_cid(struct mmc_card *card);
> >  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
> >         bool reinit);
> >  unsigned mmc_sd_get_max_clock(struct mmc_card *card);
> >  int mmc_sd_switch_hs(struct mmc_card *card);
> >
> > +int sd_can_poweroff_notify(struct mmc_card *card);
> > +int sd_poweroff_notify(struct mmc_card *card);
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index f93c392040ae..5cd1216edf0d 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -41,6 +41,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_ca=
rd *card)
> >         if (WARN_ON(card && card->host !=3D host))
> >                 return -EINVAL;
> >
> > +       /*
> > +        * UHS2 packet has APP bit so only set APP_CMD flag here.
> > +        * Will set the APP bit when assembling UHS2 packet.
> > +        */
> > +       if (host->uhs2_sd_tran) {
> > +               host->uhs2_app_cmd =3D true;
> > +               return 0;
> > +       }
> > +
> >         cmd.opcode =3D MMC_APP_CMD;
> >
> >         if (card) {
> > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > index 7667fc223b74..e3af68a52de8 100644
> > --- a/drivers/mmc/core/sd_ops.h
> > +++ b/drivers/mmc/core/sd_ops.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/types.h>
> >
> >  struct mmc_card;
> > +struct mmc_command;
> >  struct mmc_host;
> >
> >  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> > @@ -21,6 +22,18 @@ int mmc_send_relative_addr(struct mmc_host *host, un=
signed int *rca);
> >  int mmc_app_send_scr(struct mmc_card *card);
> >  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
> >  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> > +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *m=
rq);
> > +
> > +static inline void mmc_uhs2_card_prepare_cmd(struct mmc_host *host, st=
ruct mmc_request *mrq)
> > +{
> > +       if (host->uhs2_sd_tran)
> > +               mmc_uhs2_prepare_cmd(host, mrq);
> > +}
>
> Please remove this inline function and just check "host->uhs2_sd_tran"
> in mmc_start_request() and mmc_cqe_start_req(). If "uhs2_sd_tran" is
> set, then just call mmc_uhs2_prepare_cmd() directly.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> > +
> > +static inline int mmc_sd_can_poweroff_notify(struct mmc_card *card)
> > +{
> > +       return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIF=
Y;
> > +}
>
> This function is a copy of sd_can_poweroff_notify(). Please use
> sd_can_poweroff_notify() and remove mmc_sd_can_poweroff_notify().
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >
> >  #endif
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index beb2541338ff..85939a2582dc 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -1,23 +1,51 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * Copyright (C) 2021 Linaro Ltd
> > - *
> >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> >   *
> > + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + * Author: Yi Sun <yi.y.sun@intel.com>
> > + *
> > + * Copyright (C) 2020 Genesys Logic, Inc.
> > + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *
> > + * Copyright (C) 2020 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + *
> > + * Copyright (C) 2022 Genesys Logic, Inc.
> > + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> > + *
> > + * Copyright (C) 2023 Genesys Logic, Inc.
> > + * Authors: Victor Shih <victor.shih@genesyslogic.com.tw>
> > + *
> >   * Support for SD UHS-II cards
> >   */
> >  #include <linux/err.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> > +#include "card.h"
> >  #include "core.h"
> >  #include "bus.h"
> >  #include "sd.h"
> > +#include "sd_ops.h"
> >  #include "mmc_ops.h"
> >
> > +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
> > +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
> > +
> >  static const unsigned int sd_uhs2_freqs[] =3D { 52000000, 26000000 };
> >
> > +struct sd_uhs2_wait_active_state_data {
> > +       struct mmc_host *host;
> > +       struct mmc_command *cmd;
> > +};
> > +
> >  static int sd_uhs2_power_up(struct mmc_host *host)
> >  {
> >         int err;
> > @@ -42,12 +70,46 @@ static int sd_uhs2_power_off(struct mmc_host *host)
> >
> >         host->ios.vdd =3D 0;
> >         host->ios.clock =3D 0;
> > -       host->ios.timing =3D MMC_TIMING_LEGACY;
> > +       /* Must set UHS2 timing to identify UHS2 mode */
> > +       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A;
>
> The only code that seems to check for MMC_TIMING_UHS2_SPEED_A is
> __sdhci_uhs2_set_ios() (that is added later in the series). Moreover
> that code only cares about MMC_TIMING_UHS2_SPEED_A if "ios->power_mode
> !=3D MMC_POWER_OFF".
>
> In other words, I think it should be okay to keep MMC_TIMING_LEGACY here,=
 right?
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >         host->ios.power_mode =3D MMC_POWER_OFF;
> > +       host->uhs2_sd_tran =3D false;
> >
> >         return host->ops->uhs2_control(host, UHS2_SET_IOS);
> >  }
> >
>
> [...]
>
> >  /*
> >   * Allocate the data structure for the mmc_card and run the UHS-II spe=
cific
> >   * initialization sequence.
> >   */
> > -static int sd_uhs2_init_card(struct mmc_host *host)
> > +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *o=
ldcard)
> >  {
> >         struct mmc_card *card;
> >         u32 node_id;
> > @@ -131,9 +818,14 @@ static int sd_uhs2_init_card(struct mmc_host *host=
)
> >         if (err)
> >                 return err;
> >
> > -       card =3D mmc_alloc_card(host, &sd_type);
> > -       if (IS_ERR(card))
> > -               return PTR_ERR(card);
> > +       if (oldcard) {
> > +               card =3D oldcard;
> > +       } else {
> > +               card =3D mmc_alloc_card(host, &sd_type);
> > +               if (IS_ERR(card))
> > +                       return PTR_ERR(card);
> > +       }
> > +       host->card =3D card;
>
> Why do you need to assign the host->card at this point, isn't it okay
> to do that later where it was originally?
>
> Anyway, there is a more important comment a few lines below that also
> relates to this.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >
> >         card->uhs2_config.node_id =3D node_id;
> >         card->type =3D MMC_TYPE_SD;
> > @@ -146,18 +838,189 @@ static int sd_uhs2_init_card(struct mmc_host *ho=
st)
> >         if (err)
> >                 goto err;
> >
> > -       host->card =3D card;
> > +       /* If change speed to Range B, need to GO_DORMANT_STATE */
> > +       if (host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +           host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
> > +               err =3D sd_uhs2_go_dormant_state(host, node_id);
> > +               if (err)
> > +                       goto err;
> > +       }
> > +
> > +       host->uhs2_sd_tran =3D true;
> > +
> >         return 0;
> >
> >  err:
> > -       mmc_remove_card(card);
> > +       if (!oldcard)
> > +               mmc_remove_card(card);
> > +       else
> > +               sd_uhs2_remove(host);
>
> This doesn't work. If there is an "oldcard", that's because we are
> trying to re-initialize the card during a resume. If we fail to
> re-initialize it we must not remove the oldcard in this path, but
> rather just return/propagate an error code.
>
> Instead, the oldcard should be removed from the mmc_rescan() work when
> it realizes that the call to "host->bus_ops->detect(host)" fails (and
> it must fail then).
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >         return err;
> >  }
> >
> > -static void sd_uhs2_remove(struct mmc_host *host)
> > +/*
> > + * Initialize the UHS-II card through the SD-TRAN transport layer. Thi=
s enables
> > + * commands/requests to be backwards compatible through the legacy SD =
protocol.
> > + * UHS-II cards has a specific power limit specified for VDD1/VDD2, th=
at should
> > + * be set through a legacy CMD6. Note that, the power limit that becom=
es set,
> > + * survives a soft reset through the GO_DORMANT_STATE command.
> > + */
> > +static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card =
*card)
> >  {
> > -       mmc_remove_card(host->card);
> > -       host->card =3D NULL;
> > +       int err;
> > +       u32 cid[4];
> > +       u32 ocr;
> > +       u32 rocr;
> > +       u8  *status;
> > +       int ro;
> > +
> > +       /* Send CMD0 to reset SD card */
> > +       err =3D __mmc_go_idle(host);
> > +       if (err)
> > +               return err;
> > +
> > +       mmc_delay(1);
> > +
> > +       /* Send CMD8 to communicate SD interface operation condition */
> > +       err =3D mmc_send_if_cond(host, host->ocr_avail);
> > +       if (err) {
> > +               dev_warn(mmc_dev(host), "CMD8 error\n");
> > +               goto err;
> > +       }
> > +
> > +       /*
> > +        * Probe SD card working voltage.
> > +        */
> > +       err =3D mmc_send_app_op_cond(host, 0, &ocr);
> > +       if (err)
> > +               goto err;
> > +
> > +       card->ocr =3D ocr;
> > +
> > +       /*
> > +        * Some SD cards claims an out of spec VDD voltage range. Let's=
 treat
> > +        * these bits as being in-valid and especially also bit7.
> > +        */
> > +       ocr &=3D ~0x7FFF;
> > +       rocr =3D mmc_select_voltage(host, ocr);
> > +       /*
> > +        * Some cards have zero value of rocr in UHS-II mode. Assign ho=
st's
> > +        * ocr value to rocr.
> > +        */
> > +       if (!rocr)
> > +               rocr =3D host->ocr_avail;
> > +
> > +       rocr |=3D (SD_OCR_CCS | SD_OCR_XPC);
> > +
> > +       /* Wait SD power on ready */
> > +       ocr =3D rocr;
> > +
> > +       err =3D mmc_send_app_op_cond(host, ocr, &rocr);
> > +       if (err)
> > +               goto err;
> > +
> > +       err =3D mmc_send_cid(host, cid);
> > +       if (err)
> > +               goto err;
> > +
> > +       memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
> > +       mmc_decode_cid(card);
> > +
> > +       /*
> > +        * For native busses:  get card RCA and quit open drain mode.
> > +        */
> > +       err =3D mmc_send_relative_addr(host, &card->rca);
> > +       if (err)
> > +               goto err;
> > +
> > +       err =3D mmc_sd_get_csd(card);
> > +       if (err)
> > +               goto err;
> > +
> > +       /*
> > +        * Select card, as all following commands rely on that.
> > +        */
> > +       err =3D mmc_select_card(card);
> > +       if (err)
> > +               goto err;
> > +
> > +       /*
> > +        * Fetch SCR from card.
> > +        */
> > +       err =3D mmc_app_send_scr(card);
> > +       if (err)
> > +               goto err;
> > +
> > +       err =3D mmc_decode_scr(card);
> > +       if (err)
> > +               goto err;
> > +
> > +       /*
> > +        * Switch to high power consumption mode.
> > +        * Even switch failed, sd card can still work at lower power co=
nsumption mode, but
> > +        * performance will be lower than high power consumption mode.
> > +        */
> > +       status =3D kmalloc(64, GFP_KERNEL);
> > +       if (!status)
> > +               return -ENOMEM;
> > +
> > +       if (!(card->csd.cmdclass & CCC_SWITCH)) {
> > +               pr_warn("%s: card lacks mandatory switch function, perf=
ormance might suffer\n",
> > +                       mmc_hostname(card->host));
> > +       } else {
> > +               /* send CMD6 to set Maximum Power Consumption to get be=
tter performance */
> > +               err =3D mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1=
_80W, status);
> > +               if (!err)
> > +                       err =3D mmc_sd_switch(card, 1, 3, SD4_SET_POWER=
_LIMIT_1_80W, status);
> > +
> > +               err =3D 0;
> > +       }
> > +
> > +       /*
> > +        * Check if read-only switch is active.
> > +        */
> > +       ro =3D mmc_sd_get_ro(host);
> > +       if (ro < 0) {
> > +               pr_warn("%s: host does not support read-only switch, as=
suming write-enable\n",
> > +                       mmc_hostname(host));
> > +       } else if (ro > 0) {
> > +               mmc_card_set_readonly(card);
> > +       }
>
> Some of the above commands in sd_uhs2_legacy_init() are only needed
> during the first initialization of the card. When re-initializing a
> card during a resume, we can skip several of these steps as they are
> simply unnecessary.
>
> However, to validate that it's the same card that remains inserted
> during re-initialization, we need to read the CID register and compare
> it against the CID register that we have stored earlier in
> card->raw_cid. Please have a look at mmc_sd_init_card() to see how
> this works for legacy SD cards.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> > +
> > +       /*
> > +        * NOTE:
> > +        * Should we read Externsion Register to check power notificati=
on feature here?
> > +        */
>
> Yes, this is needed too.
>
> > +
> > +       kfree(status);
> > +
> > +       return 0;
> > +
> > +err:
> > +       sd_uhs2_remove(host);
>
> Again, this doesn't work if we are re-initializing the card during a
> resume. The card must only be removed if this is the first
> initialization of the card - otherwise the removal needs to be managed
> by the mmc_rescan() work.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> > +       return err;
> > +}
> > +
> > +static int sd_uhs2_reinit(struct mmc_host *host)
> > +{
> > +       struct mmc_card *card =3D host->card;
> > +       int err;
> > +
> > +       sd_uhs2_power_up(host);
> > +       err =3D sd_uhs2_phy_init(host);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D sd_uhs2_init_card(host, card);
> > +       if (err)
> > +               return err;
> > +
> > +       err =3D sd_uhs2_legacy_init(host, card);
> > +       if (err)
> > +               return err;
> > +
> > +       mmc_card_set_present(card);
>
> Drop this, it's already managed when calling mmc_add_card() and that
> should be sufficient.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> > +       return err;
> >  }
> >
> >  static int sd_uhs2_alive(struct mmc_host *host)
> > @@ -179,38 +1042,194 @@ static void sd_uhs2_detect(struct mmc_host *hos=
t)
> >                 mmc_claim_host(host);
> >                 mmc_detach_bus(host);
> >                 sd_uhs2_power_off(host);
> > +               /* Remove UHS2 timing to indicate the end of UHS2 mode =
*/
> > +               host->ios.timing =3D MMC_TIMING_LEGACY;
>
> If my earlier comment for sd_uhs2_power_off() was correct, this part
> should be dropped too.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >                 mmc_release_host(host);
> >         }
> >  }
> >
> > +static int _sd_uhs2_suspend(struct mmc_host *host)
> > +{
> > +       struct mmc_card *card =3D host->card;
> > +       int err =3D 0;
> > +
> > +       mmc_claim_host(host);
> > +
> > +       if (mmc_card_suspended(card))
> > +               goto out;
> > +
> > +       if (mmc_sd_can_poweroff_notify(card))
>
> Use sd_can_poweroff_notify() instead.
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> > +               err =3D sd_poweroff_notify(card);
> > +
> > +       if (!err) {
> > +               sd_uhs2_power_off(host);
> > +               mmc_card_set_suspended(card);
> > +       }
> > +
> > +out:
> > +       mmc_release_host(host);
> > +       return err;
> > +}
> > +
>
> [...]
>
> >
> > @@ -237,7 +1256,7 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >         if (err)
> >                 goto err;
> >
> > -       err =3D sd_uhs2_init_card(host);
> > +       err =3D sd_uhs2_init_card(host, NULL);
> >         if (err)
> >                 goto err;
> >
> > @@ -254,21 +1273,33 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >                 goto remove_card;
> >
> >         mmc_claim_host(host);
> > +
> >         return 0;
> >
> >  remove_card:
> > -       mmc_remove_card(host->card);
> > -       host->card =3D NULL;
> > +       sd_uhs2_remove(host);
> >         mmc_claim_host(host);
> > -       mmc_detach_bus(host);
> > +
> >  err:
> > +       mmc_detach_bus(host);
> >         sd_uhs2_power_off(host);
> > +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
> > +       host->ios.timing =3D MMC_TIMING_LEGACY;
>
> Again, see my earlier comment for sd_uhs2_power_off(). Can this part be d=
ropped?
>

Hi, Ulf

I will update it in the next version.

Thanks, Victor Shih

> >         return err;
> >  }
> >
> > +/**
> > + * mmc_attach_sd_uhs2 - select UHS2 interface
> > + * @host: MMC host
> > + *
> > + * Try to select UHS2 interface and initialize the bus for a given
> > + * frequency, @freq.
> > + *
> > + * Return:     0 on success, non-zero error on failure
> > + */
> >  int mmc_attach_sd_uhs2(struct mmc_host *host)
> >  {
> > -       int i, err =3D 0;
> > +       int i, err;
> >
> >         if (!(host->caps2 & MMC_CAP2_SD_UHS2))
> >                 return -EOPNOTSUPP;
> > @@ -283,6 +1314,9 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
> >          */
> >         for (i =3D 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
> >                 host->f_init =3D sd_uhs2_freqs[i];
> > +               pr_debug("%s: %s: trying to init UHS-II card at %u Hz\n=
",
> > +                        mmc_hostname(host), __func__, host->f_init);
> > +
>
> This looks like it belongs in patch 2 instead. I have amended patch 2
> with this before I applied it.
>
> >                 err =3D sd_uhs2_attach(host);
> >                 if (!err)
> >                         break;
>
> [...]
>
> Other than the above comments, I just wanted to highlight that I have
> just queued up a series from Avri that adds support for SD Ultra
> Capacity (SDUC) cards.
>
> There are some adjustments needed for your series for UHS-II to cope
> with SDUC, but I think those should be quite minor.
>
> Kind regards
> Uffe

Hi, Ulf

I will rebase the patches on the latest mmc/next branch.

Thanks, Victor Shih

