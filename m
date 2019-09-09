Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65521AD311
	for <lists+linux-mmc@lfdr.de>; Mon,  9 Sep 2019 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfIIGZp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 02:25:45 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34037 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfIIGZp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 02:25:45 -0400
Received: by mail-ed1-f53.google.com with SMTP id c20so2849002eds.1
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwsGj9+xuJuYBJgScqyFgqrBWkUeQbYZSWkNUSVly3M=;
        b=CjVahCS81fEFGzRgUon0jMYeTA9VLsLeHnwWK3wXBziFx1aVOLmii0dfIa6/+3Z33z
         ixS8P8nSxrUm3h49gEjwSu+bZ2A33x+odKdihFccBy1T+MDQHAmr/tRt/eIrdM6Q0BJb
         zS6CnpU1t+NwyS6dGRSaQwmHcu9qcx/miwH5HX8sMWstYF2e3XdKCgYsW9Zy9DZ3/ffH
         AKg3QC8Tfj1evTlZNkiGmXGYQPu0yHwAuezGVuaDYcOMOea2GG4yvzoV+oJ64grcOZk3
         jgH6xiij+1SqhDqQpG2zubWjJJEDQE51vjm0i1+MPW3kRi/ZGXNrapQ/OhVz1ni5KWrW
         lfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwsGj9+xuJuYBJgScqyFgqrBWkUeQbYZSWkNUSVly3M=;
        b=JzBKGCrYJH6Uh2EHiZ0qZ8wOLBTTr0Xz+IOGFHHaCK4c+mmR0iz+3xWDtwQ6vYHXn3
         MW8KLeEWBbLHbQaRqFbMHOQOekh8BsvtjiQQlhugprbakdeCqRRxZaXOdTI0EYLUjEDV
         3d5ribT8Bz02MPqVfVjhqriU+faPsX5il8jbnkuFp/FAj40TE6nVgjcT5/9UOciSJ+Fg
         XSFVpaOe7A6Gm8EFH7zFtPA3Bfoi0kZcXV4UfHKf+fSXjV8kcpvmhhhuM6ahdECfYvSO
         wDrMZcSkWfjiIOxDds0ZcuUTdGqxNsgwXRHwtwcgnv4v+WEid2uXa5OKYoc1r1EOpEBJ
         fN3g==
X-Gm-Message-State: APjAAAW4W/N8D2RZF82PEYvuZ1eNS6zGh5/Ts8rboXxuhLecZeHJcTLb
        5eptyFkdYVq91XYNjyXJt0LJtMP4jfchGDp3b+Y=
X-Google-Smtp-Source: APXvYqxScqdA0F9kVniNOAqLet6UQ0cI3eQ0jtgNWPUb03zlWXGEiKjy6OJGK26hO8B6qLyFoyHXwVz5KQ6oBRJSQcc=
X-Received: by 2002:a50:ba0e:: with SMTP id g14mr23037820edc.241.1568010343702;
 Sun, 08 Sep 2019 23:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
 <CAPDyKFo5E3a0w6YKReMNrU_Z1td6jTbgKH-d+shOynhyPsGGHA@mail.gmail.com>
 <CAAfyv34JHtLHRrCnF-5qg+odUvy_2PqRFfXwYK3xjDSN9TA7gg@mail.gmail.com> <CAPDyKFoU5zVEKRmbR-uJPdKpJJKW51BJG1k1DsdxAareEu2Nbg@mail.gmail.com>
In-Reply-To: <CAPDyKFoU5zVEKRmbR-uJPdKpJJKW51BJG1k1DsdxAareEu2Nbg@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Mon, 9 Sep 2019 08:25:32 +0200
Message-ID: <CAAfyv36nFnRtFnk5cAYy+GesGyDbSQOukFzL=U-01NfJZW+N=g@mail.gmail.com>
Subject: Re: slow emmc speed 4.12 am437x
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 6, 2019 at 2:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 6 Sep 2019 at 14:26, Belisko Marek <marek.belisko@gmail.com> wrote:
> >
> > On Fri, Sep 6, 2019 at 2:19 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Fri, 6 Sep 2019 at 11:14, Belisko Marek <marek.belisko@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I'm trying to get some insights about how to debug emmc speed issue.
> > > > We're using board with am437x CPU using mainline 4.12 kernel (added
> > > > only devicetree for our custom board). eMMC is 8bit connect (using
> > > > sandisk SDINBDG4-8G-I1 chip).
> > > >
> > > > Issue is that when copying data from SD card to eMMC we get throughput
> > > > only ~300kB/s (it should be bit higher IIRC). I'm just looking for
> > > > some advice what to check and how to find out where issue can be
> > > > (still unsure if SW or HW). Thanks a lot.
> > >
> > > Mount debugfs and look at the ios node for the mmc host in question.
> > > There is information about clocks, busdwidth, etc.
> > Thanks for info. From below it looks quite ok:
> > clock:          52000000 Hz
> > vdd:            21 (3.3 ~ 3.4 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    1 (mmc high-speed)
> > signal voltage: 0 (3.30 V)
> > driver type:    0 (driver type B)
> >
> > compared to gumstix poblano (same cpu):
> > cat /sys/kernel/debug/mmc1/ios
> > clock:          50000000 Hz
> > vdd:            21 (3.3 ~ 3.4 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      2 (4 bits)
> > timing spec:    2 (sd high-speed)
> > signal voltage: 0 (3.30 V)
> > driver type:    0 (driver type B)
> >
> > difference is in bus width (I'm confused as poblano according dts +
> > schematics should also have 8 bit interface) and timing spec are
> > different for my case. Anything else I can check? Thanks.
>
> This looks fine to me. I think you need to do some deeper debug to
> find out what the issue is, sorry for not being able to help any more
> than this.
Isn't timing spec doing any difference in speed? Just curious.
>
> Of course you already tried reading/writing to the eMMC and SD
> independently, so you have a reference of the throughput values?
For poblano I have with bs=4096 throughput ~ 10MB/sec while on my
platform only 1,6MB/s when copying same file to eMMC.
So trying to understand what can be an issue. AFAIK on my platform I
have some new Sandisk eMMC (5.2). Could be possible that support for
that needs to be added or interface to eMMC is still the same?
Thanks.
>
> Kind regards
> Uffe

BR,

marek
