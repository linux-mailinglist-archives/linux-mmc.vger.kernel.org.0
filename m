Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941CC71851
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 14:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfGWMdv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 08:33:51 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39110 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGWMdv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 08:33:51 -0400
Received: by mail-vs1-f49.google.com with SMTP id u3so28640760vsh.6;
        Tue, 23 Jul 2019 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D0dIs1sQ5y8YZEU/+OCClL8Rpfn1hGrQQ6MN19phnZY=;
        b=UHzFkm4KmM40XZnyBUt6L75G6kQ1V4Vxhj5QVcclbrobZ4nDsjNL7pxFleAHvWXQnb
         8veYwp6mDL3q17/HxGf/JHREK4PSgrHwuqO0ST7c6Ueheu3oc1n8nrDtTb7K0f9A34WK
         zpwNIoUiExrtHMOSPmZaUBpvpAkeVs+mXtCzwBxR+mVs67oXbokZiOK/JxwMcVASPDUY
         i9MZEstk/fff4kgSPDMXpWL+LntJ6sazg/XH0gXQQyNTtXbaGtxPxyHfZJtsQV72NRrW
         gtj3ZNqDBjLcedmVtQGkV+Ccag+xUGh0MY9nC7CZfRGR0klZjoD96dtl94WbWPDvF0Yq
         PRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D0dIs1sQ5y8YZEU/+OCClL8Rpfn1hGrQQ6MN19phnZY=;
        b=dy7MCOUdDAxKzsLvSKnbUwU403B8erMonXsHxTjK+f+lpWP9+IvJcN79UehYOMGol/
         XKatQ3nK9CnEYrGiVwLrE+uyEBWvZwfdRHGSJ3v/ZubQHhnJLuUvuOT/qgj79F8CKdhl
         2VqUhlKz2WjyMsZk7oihfmu/xmxzXIabeygGQDarmYTnSmfXQrEPcQ9yDs06ojM71waN
         dCGcNMpelBuTSmQWzt10g7iFIIZKLUGQ7OTBYzCwX96JeML/FWGiBpzekKmCJSl2B2wj
         bT9uxIANVw4BhrIsM1yX/x/I5lIJC2CbxOt8CYlOuHW7v5WR0r1Lb2EfnFPngvS2UNOk
         AH4g==
X-Gm-Message-State: APjAAAUI9NMDU0izvgzbpxpZqqAVyrxp+i4Q7V08GvgDoxA2sgbdOl4W
        7G4QPF2KPtskw6OZMjfg8pgewG8y8vqMyZg4ihk=
X-Google-Smtp-Source: APXvYqzSwI6JXr33vGz1Zl73eg0VuLmYteeEtg8J0M2SAu5MYNWIXEzx/GDmHlFfIM5Fentm53RZyhjW/1UyEzL81nw=
X-Received: by 2002:a67:f8d4:: with SMTP id c20mr5929303vsp.239.1563885230278;
 Tue, 23 Jul 2019 05:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
 <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
In-Reply-To: <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 23 Jul 2019 08:34:21 -0400
Message-ID: <CAOGqxeVR3XzAQ-yTH35hyT3KpL11nTwMY1Ca96ZW=K=PiWMnHA@mail.gmail.com>
Subject: Re: Issue with sequence to switch to HS400
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jul 23, 2019 at 1:21 AM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 23/07/19 1:31 AM, Alan Cooper wrote:
> > I'm having a problem with a new SD/MMC controller and PHY in our
> > latest SoC's. The issue I'm seeing is that I can't switch into HS400
> > mode. This looks like something the driver is doing that doesn't meet
> > the JEDEC spec. In the "HS400 timing mode selection" section of the
> > JEDEC spec , in step 7 it states:
> >
> > 7) Set the =E2=80=9CTiming Interface=E2=80=9D parameter in the HS_TIMIN=
G [185] field
> > of the Extended CSD register to 0x1 to switch to High Speed mode and
> > then set the clock frequency to a value not greater than 52 MHz.
> >
> > In the function mmc_select_hs400() in mmc.c, I see that a switch
> > command is done to set the eMMC device to HS mode and then
> > mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
> > controller to HS mode. The problem is that the "SD Host Controller
> > Standard Specification" states that "UHS Mode Select" field of the
> > "Host Control 2 Register" controls the mode when the "1.8V Signaling
> > Enable" bit in the same register is set, so mmc_set_timing() is
> > actually leaving the controller in SDR12 mode and mmc_select_hs400()
> > will then set the clock to 52MHz. This causes our PHY to detect an
> > illegal combination and return an error.
> >
> > I think the easiest fix would be to change mmc_set_timing(card->host,
> > MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
> > MMC_TIMING_UHS_SDR25). The other possibility would be to change
> > mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
> > I'll submit a patch based on the feedback I get.
>
> eMMC is governed by JEDEC specs not SD specs.

My understanding is that JEDEC does not have a host controller spec so
this driver uses the "SD Host Controller Standard Specification".

>
> Please consider making a change in your driver instead.  For example, hoo=
k
> ->set_ios() and if 1.8V is enabled and timing is set to MMC_TIMING_MMC_HS
> then change it to MMC_TIMING_UHS_SDR25.

That's an easy fix, but it still leaves all other drivers/systems
temporarily using SDR12 at 52MHz during the switch to HS400.
