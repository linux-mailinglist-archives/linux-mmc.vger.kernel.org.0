Return-Path: <linux-mmc+bounces-110-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06407EF103
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Nov 2023 11:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37C21C20954
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Nov 2023 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C181A5A8;
	Fri, 17 Nov 2023 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW14X5Ab"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877418B;
	Fri, 17 Nov 2023 02:50:04 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45d9d28142fso732360137.2;
        Fri, 17 Nov 2023 02:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218203; x=1700823003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojnMLz1u5e9squEQsZdKycI8y5MGVB4+Bk8ILM4M9Wo=;
        b=dW14X5AbaKKaIHkO6KgNfgZ7doUKVbNHc9CqHXAjtUgNDqSOwDNx+KLs2fTF1ApGNh
         EFdVKjctOhlVvUuQOIG8w0bfEsS729T4Thvr+LyKUJF80/hQlROQODy0lvQ2GJH4t9MU
         fN514+ERIGToOagOQWdruL5ZGdP4choi0Xc46YcMQ9yil1ZiUQKsdY5yLQvIXWXJ4aXt
         77IIL/42zAGWLrmed+gnBJ0g+cYGBkFrFzT4XaN0flpy6YcgpEiI4i78mSpZzT2zRJh+
         VQChIR/c+CvB1ESjYmkVSX3X22TOoSd8FWlALkgexFsuAOSWtGF+/kn0DuqOsAeO0Z/m
         z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218203; x=1700823003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojnMLz1u5e9squEQsZdKycI8y5MGVB4+Bk8ILM4M9Wo=;
        b=WDzr1LaoA0bjRmUcDWGJIbSWi7p8lHPDwXpOVobRgOCP+yl94ug42ms0pNYVTZLH+l
         eWgS/sb9fMF7Fl4k4IE6RCUfESA308y52Rg6+v4MWUofQBMVqvDze7QnkQal99cG0zH2
         Yed9X9dfXmDAtf5d2hKiPm6DYCMtMIUcSenHETf50JsUQ4wCxfgXN420fkNcPBJAtJXH
         asRSVyuMpQaMQRUWoTRKH5YyYFbbF0asheD2Mj7dxgXvWmuL9Oab6KVW0fX7gDfFSB/J
         +Q1TZ56/cMfoJeD0w9hZnldw2s81zN3noTe7ADwdjqWKzG1A2kjoOGbkpkqNXmovT7mZ
         i1eA==
X-Gm-Message-State: AOJu0YxFnqDco3fK7MVOEKqqJbIXCvy2yImtRSTMgm+TPBWuEH7EyAd+
	yS0uU843emn2Mq4ewTSYWPShckNiln4/HRcAOXM=
X-Google-Smtp-Source: AGHT+IHNVHFIODkgg+FftqjCeQzRxrtyW6f+Woupy+eQGj8E78/+XF9ZBPcXK0ZmTvF57PHhzudzDpLMwGsr1q7LE/c=
X-Received: by 2002:a67:e05d:0:b0:462:768f:db2c with SMTP id
 n29-20020a67e05d000000b00462768fdb2cmr3882761vsl.27.1700218203523; Fri, 17
 Nov 2023 02:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-12-victorshihgli@gmail.com> <CAPDyKFqpT3Z99gv=5W8sWquq8ogSjEuwyL97nqm8xZP2ce9QMw@mail.gmail.com>
In-Reply-To: <CAPDyKFqpT3Z99gv=5W8sWquq8ogSjEuwyL97nqm8xZP2ce9QMw@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 17 Nov 2023 18:49:51 +0800
Message-ID: <CAK00qKC8K7=_3247mv6AHBCgXqWYjJyL3++=kKdT4V7OHdnc-g@mail.gmail.com>
Subject: Re: [PATCH V12 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 5:46=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a UHS-II version of sdhci's set_power operation.
> > VDD2, as well as VDD, is handled here.
>
> Okay, but why?
>
> Please justify the change in the commit messages, don't just tell what
> is being done. This applied to the whole series - and I believe I have
> said this before too.
>

Hi, Ulf

I will try to update this in version 13.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> > Updates in V10:
> >  - Move some definitions of PatchV9[05/23] to PatchV10[11/23].
> >
> > Updates in V9:
> >  - Modify annotations in sdhci_get_vdd_value().
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets.
> >  - Add the initial value of the pwr in sdhci_uhs2_set_power().
> >
> > Updates in V7:
> >  - Add clear the power reg before setting a new value
> >    in sdhci_uhs2_set_power().
> >  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value=
().
> >  - Drop pwr variable in sdhci_get_vdd_value().
> >
> > Updates in V6:
> >  - Add mmc_opt_regulator_set_ocr().
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  include/linux/mmc/host.h      |  1 +
> >  4 files changed, 83 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index dfc80a7f1bad..fc37a34629c2 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> > +                                           struct regulator *supply,
> > +                                           unsigned short vdd_bit)
> > +{
> > +       return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, =
supply, vdd_bit);
> > +}
> > +
> >  bool sdhci_uhs2_mode(struct sdhci_host *host)
> >  {
> >         return host->mmc->flags & MMC_UHS2_SUPPORT;
> > @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 =
mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> >
> > +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned cha=
r mode, unsigned short vdd)
> > +{
> > +       struct mmc_host *mmc =3D host->mmc;
> > +       u8 pwr =3D 0;
> > +
> > +       if (mode !=3D MMC_POWER_OFF) {
> > +               pwr =3D sdhci_get_vdd_value(vdd);
> > +               if (!pwr)
> > +                       WARN(1, "%s: Invalid vdd %#x\n",
> > +                            mmc_hostname(host->mmc), vdd);
> > +               pwr |=3D SDHCI_VDD2_POWER_180;
> > +       }
> > +
> > +       if (host->pwr =3D=3D pwr)
> > +               return;
> > +       host->pwr =3D pwr;
> > +
> > +       if (pwr =3D=3D 0) {
> > +               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>
> We added mmc_regulator_set_vqmmc2() in patch4. Please use that instead.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +       } else {
> > +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> > +               /* support 1.8v only for now */
> > +               mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(M=
MC_VDD_165_195) - 1);
> > +
> > +               /* Clear the power reg before setting a new value */
> > +               sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +               /* vdd first */
> > +               pwr |=3D SDHCI_POWER_ON;
> > +               sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +               mdelay(5);
> > +
> > +               pwr |=3D SDHCI_VDD2_POWER_ON;
> > +               sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +               mdelay(5);
> > +       }
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 753b251179f2..eca54a16e7fc 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/of.h>
> > -
> > +#include <linux/bug.h>
> >  #include <linux/leds.h>
> >
> >  #include <linux/mmc/mmc.h>
> > @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_ho=
st *host, unsigned char mode,
> >                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >  }
> >
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> > +{
> > +       switch (1 << vdd) {
> > +       case MMC_VDD_165_195:
> > +       /*
> > +        * Without a regulator, SDHCI does not support 2.0v
> > +        * so we only get here if the driver deliberately
> > +        * added the 2.0v range to ocr_avail. Map it to 1.8v
> > +        * for the purpose of turning on the power.
> > +        */
> > +       case MMC_VDD_20_21:
> > +               return SDHCI_POWER_180;
> > +       case MMC_VDD_29_30:
> > +       case MMC_VDD_30_31:
> > +               return SDHCI_POWER_300;
> > +       case MMC_VDD_32_33:
> > +       case MMC_VDD_33_34:
> > +       /*
> > +        * 3.4V ~ 3.6V are valid only for those platforms where it's
> > +        * known that the voltage range is supported by hardware.
> > +        */
> > +       case MMC_VDD_34_35:
> > +       case MMC_VDD_35_36:
> > +               return SDHCI_POWER_330;
> > +       default:
> > +               return 0;
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> > +
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                            unsigned short vdd)
> >  {
> >         u8 pwr =3D 0;
> >
> >         if (mode !=3D MMC_POWER_OFF) {
> > -               switch (1 << vdd) {
> > -               case MMC_VDD_165_195:
> > -               /*
> > -                * Without a regulator, SDHCI does not support 2.0v
> > -                * so we only get here if the driver deliberately
> > -                * added the 2.0v range to ocr_avail. Map it to 1.8v
> > -                * for the purpose of turning on the power.
> > -                */
> > -               case MMC_VDD_20_21:
> > -                       pwr =3D SDHCI_POWER_180;
> > -                       break;
> > -               case MMC_VDD_29_30:
> > -               case MMC_VDD_30_31:
> > -                       pwr =3D SDHCI_POWER_300;
> > -                       break;
> > -               case MMC_VDD_32_33:
> > -               case MMC_VDD_33_34:
> > -               /*
> > -                * 3.4 ~ 3.6V are valid only for those platforms where =
it's
> > -                * known that the voltage range is supported by hardwar=
e.
> > -                */
> > -               case MMC_VDD_34_35:
> > -               case MMC_VDD_35_36:
> > -                       pwr =3D SDHCI_POWER_330;
> > -                       break;
> > -               default:
> > +               pwr =3D sdhci_get_vdd_value(vdd);
> > +               if (!pwr) {
> >                         WARN(1, "%s: Invalid vdd %#x\n",
> >                              mmc_hostname(host->mmc), vdd);
> > -                       break;
> >                 }
> >         }
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 43ad3f4b7672..f3bd558b337f 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsig=
ned char mode,
> >  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
> >                                      unsigned char mode,
> >                                      unsigned short vdd);
> > +unsigned short sdhci_get_vdd_value(unsigned short vdd);
> >  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode=
,
> >                            unsigned short vdd);
> >  int sdhci_get_cd_nogpio(struct mmc_host *mmc);
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 6c8258310641..610644a0ace5 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -363,6 +363,7 @@ struct mmc_pwrseq;
> >
> >  struct mmc_supply {
> >         struct regulator *vmmc;         /* Card power supply */
> > +       struct regulator *vmmc2;        /* UHS2 VDD2 power supply */
>
> In patch4 we added vqmmc2. Please use that instead.
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> >         struct regulator *vqmmc;        /* Optional Vccq supply */
> >         struct regulator *vqmmc2;       /* Optional supply for phy */
> >  };
> > --
> > 2.25.1
> >
>
> Kind regards
> Uffe

