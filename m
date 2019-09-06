Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F9AB81D
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbfIFM1A (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 08:27:00 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37585 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfIFM1A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 08:27:00 -0400
Received: by mail-ed1-f45.google.com with SMTP id i1so6150588edv.4
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQuJiEh4HaFqmVgcgG3qaFaYNzVOg6YNKMfECG8UoPs=;
        b=q4io/8UiyxsgfnH5qrXhNTVFKjH2HkXki8vQfSM6OrS6ZO8Sw3bEvHCBQRKfoqzwpX
         1O+8NYnquQzCX8qeKJxYVQFowPeepijXzs10y2UxgSMOqZykiI3EIhps9vhkEsQQbD8H
         7T2uBk9U1vBxNDtpnC9lJe9kfur4lDtKSGH5LkDDIKJmgMO1LSTbtk0W9QY+NpEeoaPb
         OH1LJ24fagNIiuBM+cgvGVY1+4X0tE1BPFhBWC0fv5pYbDLEuJXp0uR5uNDb5ym843YJ
         wgNSMFeXREOQtk4rOsL1q3s39wMVGofHZMpOqPnZEhJ9C0WPLeY8ReigK9fEWX6lM2e5
         VN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQuJiEh4HaFqmVgcgG3qaFaYNzVOg6YNKMfECG8UoPs=;
        b=M8n6h3aGCCaRt1YvZLd+ILzQMOpFIfBsA3Wixz7LiIDc+lB0QaDlq6vvM2SaNKIalU
         KPW5vZCnZXqHA5n6dAecnOkSvgwJm3Lr+XWVbaH+qNRxSVKToBOAhYaJf9zdxDdkCPG0
         ZLyhkEmkvN7Q01DjfBguT4YfefBYzySXkxFTSyGrmuY5pG0eGymkCMamfob9dJBlP1y3
         EHkRJKqnBgm0sX10LO+29VAJp95NZARKJVaboZG0KOigWkAwceq03BfSSYTuRrd0bL+W
         fEwnqpu+1/Sk+z5SIh3LnYu5Z6subeGrJWpzOhq426//2bTqEIMyYCPx1w3p0G54nd3I
         TgYA==
X-Gm-Message-State: APjAAAX+kzgVL6zUqr19OFkMEArb+B9LBlQxn1lQSphynW/HxhsemEh4
        NJK2Qjqa+2Z9Gg5gFUGQycH2I6Z6yJEe0QHsvKw=
X-Google-Smtp-Source: APXvYqxQvnLiE6NaDFRkDNMKntjrBNxDgP3lJiCViU9eeDX89Hw66FgtYI/wFfyJGNSsBKZ+w7SScI+Fz008UFozc3k=
X-Received: by 2002:a50:ad14:: with SMTP id y20mr7588340edc.9.1567772818865;
 Fri, 06 Sep 2019 05:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
 <CAPDyKFo5E3a0w6YKReMNrU_Z1td6jTbgKH-d+shOynhyPsGGHA@mail.gmail.com>
In-Reply-To: <CAPDyKFo5E3a0w6YKReMNrU_Z1td6jTbgKH-d+shOynhyPsGGHA@mail.gmail.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Fri, 6 Sep 2019 14:26:47 +0200
Message-ID: <CAAfyv34JHtLHRrCnF-5qg+odUvy_2PqRFfXwYK3xjDSN9TA7gg@mail.gmail.com>
Subject: Re: slow emmc speed 4.12 am437x
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 6, 2019 at 2:19 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 6 Sep 2019 at 11:14, Belisko Marek <marek.belisko@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm trying to get some insights about how to debug emmc speed issue.
> > We're using board with am437x CPU using mainline 4.12 kernel (added
> > only devicetree for our custom board). eMMC is 8bit connect (using
> > sandisk SDINBDG4-8G-I1 chip).
> >
> > Issue is that when copying data from SD card to eMMC we get throughput
> > only ~300kB/s (it should be bit higher IIRC). I'm just looking for
> > some advice what to check and how to find out where issue can be
> > (still unsure if SW or HW). Thanks a lot.
>
> Mount debugfs and look at the ios node for the mmc host in question.
> There is information about clocks, busdwidth, etc.
Thanks for info. From below it looks quite ok:
clock:          52000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

compared to gumstix poblano (same cpu):
cat /sys/kernel/debug/mmc1/ios
clock:          50000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    2 (sd high-speed)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

difference is in bus width (I'm confused as poblano according dts +
schematics should also have 8 bit interface) and timing spec are
different for my case. Anything else I can check? Thanks.

>
> Kind regards
> Uffe

BR,

marek
