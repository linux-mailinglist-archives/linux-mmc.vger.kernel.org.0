Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E1AB7EE
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391899AbfIFMQH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 08:16:07 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46164 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbfIFMQH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 08:16:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id k12so1953950uan.13
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/zpb8mats7+Tv4fVkl9qIebYzNK8a9N8FTdZdR4Rn0=;
        b=dEtRRNu65Pt5+v/2LT8aSSnLyT8O93IntGuVDaxVMDY8AFdp10j80fFUpgUKwbNfop
         vN6yOQVk9b2s0d58ZnDk2Lr1vln21lc4N3FQw4G2+WeIEmrcKBHNBY8nCkaSsE+xmfbQ
         t0Pi0IsweUHixrt0kScCPGvOrpRODxm9+gNRTn2PSLhlz66msVjVaVHgCW7PBIMS2LyO
         jk4hroKk6mTWPZ91l4O20P6SilLthsgnmvG0JE8NTHvDsCoq/PwSA8+oHNhxW0nwhCiz
         +rY1yIQn5yqV52gKIJyROKstrKneGjVB/AcqBkNlRHLKi8TcBrcGradf+YVLB7GmeZWE
         rLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/zpb8mats7+Tv4fVkl9qIebYzNK8a9N8FTdZdR4Rn0=;
        b=KWIMB288tcEo2qfxSmMZ1th/N1hoPW050UWmj3rlpmJaZezveeBc6bgI35B7I6TIT/
         HSF4C/3Uj3DKzw98Yt3m9vifIuYkWzfRWC+XyVvhpIQC3rVIzUQA6uiNGK/gGcgxdcoO
         KbGZnGg8s7F6gdB5S4MKiuzBXu6suovkpI8jT0Bof8JFhHEYyKbxkvjzdlaUJ5MmTzMD
         QfE8ge/GA6+fkb4dEEyOe2MLvdnkPRxlRCmaMf/6kGq/OmIWAygwcptRNxAv1TOva615
         lTz/HAc8beWkJnByE9WUZCD0HIZwvN1pDG7jwJ62/YbHg6kv4NFmlJpfqwMsSXn9OxiJ
         AA6g==
X-Gm-Message-State: APjAAAXmLrhfX5GT6ZNmrrJhF90Xo6QHPdAwDKLCD5PUAZLX829ACJn1
        AKMlURtD97qRUgxsGh4XZTv3ufagjdIZ3jwqez1GFQ==
X-Google-Smtp-Source: APXvYqxoeNmW6MapUd6kZvK5ApdXTX6MDXsDnU3/fU6Qf3/Sg3kbc4tbwwe/BcjrQE70EK7rc2gE7G46JgewVB5XF/Y=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr4142547ual.129.1567772166306;
 Fri, 06 Sep 2019 05:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190905200138.GA19037@impa.localdomain>
In-Reply-To: <20190905200138.GA19037@impa.localdomain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Sep 2019 14:15:30 +0200
Message-ID: <CAPDyKFqo-LecRE5R4T+vrGgNs83WFmQr84oaieEUTCjLFOLXoA@mail.gmail.com>
Subject: Re: Black screen while resuming a SDXC (UHS) card (_mmc_sd_resume)
To:     Tim Schumacher <tim@timakro.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        pher1989@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 22:01, Tim Schumacher <tim@timakro.de> wrote:
>
> Hi,
>
> I'm sending this old bug by mail since a lot of developers don't use
> bugzilla.
>
> Original bug report on bugzilla by Pedro Rodrigues from 2019-01-30:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202459
>
> > This bug can be found on a Lenovo Miix 320-10ICR
> >
> > When using a SDXC (UHS) card, the screen becomes black if
> > _mmc_sd_resume() is called. After some investigation, I found that an
> > UHS card uses 1.8 V for signalling while a normal SD card uses 3.3 V. B=
y
> > forcing the SDXC to use 3.3 V the black screen does not appear. It seem=
s
> > that during a _mmc_sd_resume function call, while claiming the host, an
> > I2C resume function is called based on an existing supplier link betwee=
n
> > the I2C bus and the card device.  The problem is that if the signalling
> > voltage is configured to 1.8 V, during the I2C resume call, the screen
> > turns black.  I was able to fix this issue by setting the initial signa=
l
> > voltage (3.3 V) before suspending the card, so that when the card is
> > resumed, the voltage is in the original state. To do this I added a
> > function call to mmc_set_initial_signal_voltage() during mmc_power_off
> > routine (drivers/mmc/core/core.c).  As I=E2=80=99m not an expert on Lin=
ux,  I=E2=80=99m
> > posting the issue and possible solution so that it could be implemented
> > on a future release.
> >
> > Please, share your thoughts :)
>
> I can't provide further insight but I'm interested if this is possibly
> the cause for the general issues people are having with the SD card
> reader on Lenovo Miix 320 devices.
>
> Those issues described in posts like
>
> https://vincent-ventures.com/2018/12/arch-linux-on-lenovo-ideapad-miix-32=
0/
> https://esc.sh/blog/linux-on-lenovo-miix-320/
>
> are (1) black screen when booting with an SD card installed and (2) when
> inserting an SD card after booting it shows up but upon trying to access
> it the screen turns black until the card is removed again.
>
> I can confirm (1) on my Lenovo Miix 320-10ICR with kernel version
> 5.2.11. I can also confirm that only SDXC cards are affected, SD and
> SDHC cards work as expected.

For the mmc community to help, you need to provide some kernel logs,
output from lspci, figure out what mmc host driver that is being used,
etc - in general collect more data. Then re-post the data to
linux-mmc, me and a potential mmc host driver maintainer (if there is
one). Yes, we can look into bugzilla as well, but first we need some
more overall info in an email.

Most likely, if there is any response, you will be asked to test
patches. So you need to be able build and boot a new kernel, but I
guess you already know that part.

Kind regards
Uffe
