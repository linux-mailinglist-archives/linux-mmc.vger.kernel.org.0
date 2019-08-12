Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5489D26
	for <lists+linux-mmc@lfdr.de>; Mon, 12 Aug 2019 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfHLLaJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 12 Aug 2019 07:30:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34325 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfHLLaG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2019 07:30:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so157471362otk.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2019 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+ux4MbUXgqf1gwWmYXXzaPeUghjvJ0johGkJTmaSek=;
        b=muzVqKcG1BVARehU8wDBShgz4+qNIYwWr3V0i7sNzT7g93wFTnbE5ojtrf4tEj1QFK
         cpTaupKUiOxTmh3rUz/giDmwdlanEajGLsziU/bhPZ2EM+VcLlfDXe6yNMERQkos7ukq
         JXhNxY8PJDL+S30el6Nr/udO4pBQ7Evmrv4V4fnmaReCzCjKEkEP1Vc1gmtd8q1D+2iL
         rESVICyrlBydcT7WlLDDM4EscppAn7WhIDWvlDftSfrE4LaQM6R4FTJjsRGNNUpfTFhu
         tAhpGIRK+SkkWD1/xYV+0GVxHXWi5/8tUS7WRUJOi8r+b6Hm9H//xZQpEtm5laVYzOCx
         l4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+ux4MbUXgqf1gwWmYXXzaPeUghjvJ0johGkJTmaSek=;
        b=CmiOdb8JAT9/ARej0RgvWLJ/EPXlNEoDvdaqTYkpNG7BdHsRL5w/otxMUB32oZDefg
         NybybL/jXYhbPrf+kXuM8ftAShS1uO7bEbI/3Pw5yk8zHzwp2XIDbnlikQ2r2BZSLLZP
         4moKwol/OUAlEjOLfAQfIfwUhWBmIJgLpdSd/epEXSo8l++DNIAZUbA2M++zgxrFt7bo
         1Wiz82/fzvOrwj+bh+HHAZXNzj6yYJF3ntU12JP3qraEnBQ+Mkf3YrA64gF81R7vqv3E
         vp8OH37jdF5NQ+RVbZego0B7/HjDYpBbG+KL8c+blnfhTkNkExPykyhCaCRpYHcvo2dQ
         SSrw==
X-Gm-Message-State: APjAAAVI4PMN+gK//pVWlYcqYqLKKQOOVU/Cov/7KtRr1BNcRaxzeFHu
        oPmm3Wq3S/79luS81cmUcYkt4+y9KlXlDFkrlUja2g==
X-Google-Smtp-Source: APXvYqx2hdYFlClE5xTrBJfVsVMoE3wagFVsPdRXLolehYThsXJOdGK2PuGHSw1hFoCVTbI7dlxF12oImWT98Y8rRXc=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr14601568otr.247.1565609404989;
 Mon, 12 Aug 2019 04:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org> <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
 <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com> <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
 <8e447a05-a859-5c71-911f-b5a0a907e8a0@intel.com>
In-Reply-To: <8e447a05-a859-5c71-911f-b5a0a907e8a0@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 19:29:47 +0800
Message-ID: <CAMz4ku+xEqwQWzHbLNhBp-f-s_Y11ik=3KqJhmpuzDdtsTemJA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Add MMC packed function
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Aug 2019 at 18:52, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/08/19 12:44 PM, Baolin Wang wrote:
> > Hi Adrian,
> >
> > On Mon, 12 Aug 2019 at 16:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 12/08/19 8:20 AM, Baolin Wang wrote:
> >>> Hi,
> >>>
> >>> On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>>>
> >>>> Hi All,
> >>>>
> >>>> Now some SD/MMC controllers can support packed command or packed request,
> >>>> that means it can package multiple requests to host controller to be handled
> >>>> at one time, which can improve the I/O performence. Thus this patchset is
> >>>> used to add the MMC packed function to support packed request or packed
> >>>> command.
> >>>>
> >>>> In this patch set, I implemented the SD host ADMA3 transfer mode to support
> >>>> packed request. The ADMA3 transfer mode can process a multi-block data transfer
> >>>> by using a pair of command descriptor and ADMA2 descriptor. In future we can
> >>>> easily expand the MMC packed function to support packed command.
> >>>>
> >>>> Below are some comparison data between packed request and non-packed request
> >>>> with fio tool. The fio command I used is like below with changing the
> >>>> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
> >>>> transfer speed.
> >>>>
> >>>> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
> >>>>
> >>>> My eMMC card working at HS400 Enhanced strobe mode:
> >>>> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> >>>> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> >>>> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> >>>> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> >>>> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> >>>>
> >>>> 1. Non-packed request
> >>>> I tested 3 times for each case and output a average speed.
> >>>>
> >>>> 1) Sequential read:
> >>>> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> >>>> Average speed: 28.7MiB/s
> >>
> >> This seems surprising low for a HS400ES card.  Do you know why that is?
> >
> > I've set the clock to 400M, but it seems the hardware did not output
> > the corresponding clock. I will check my hardware.
> >
> >>>>
> >>>> 2) Random read:
> >>>> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
> >>>> Average speed: 14.3MiB/s
> >>>>
> >>>> 3) Sequential write:
> >>>> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
> >>>> Average speed: 24.7MiB/s
> >>>>
> >>>> 4) Random write:
> >>>> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
> >>>> Average speed: 19.2MiB/s
> >>>>
> >>>> 2. Packed request
> >>>> In packed request mode, I set the host controller can package maximum 10
> >>>> requests at one time (Actually I can increase the package number), and I
> >>>> enabled read/write packed request mode. Also I tested 3 times for each
> >>>> case and output a average speed.
> >>>>
> >>>> 1) Sequential read:
> >>>> Speed: 165MiB/s, 167MiB/s, 164MiB/s
> >>>> Average speed: 165.3MiB/s
> >>>>
> >>>> 2) Random read:
> >>>> Speed: 147MiB/s, 141MiB/s, 144MiB/s
> >>>> Average speed: 144MiB/s
> >>>>
> >>>> 3) Sequential write:
> >>>> Speed: 87.8MiB/s, 89.1MiB/s, 90.0MiB/s
> >>>> Average speed: 89MiB/s
> >>>>
> >>>> 4) Random write:
> >>>> Speed: 90.9MiB/s, 89.8MiB/s, 90.4MiB/s
> >>>> Average speed: 90.4MiB/s
> >>>>
> >>>> Form above data, we can see the packed request can improve the performance greatly.
> >>>> Any comments are welcome. Thanks a lot.
> >>>
> >>> Any comments for this patch set? Thanks.
> >>
> >> Did you consider adapting the CQE interface?
> >
> > I am not very familiar with CQE, since my controller did not support
> > it. But the MMC packed function had introduced some callbacks to help
> > for different controllers to do packed request, so I think it is easy
> > to adapt the CQE interface.
> >
>
> I meant did you consider using the CQE interface instead of creating another
> one?

Sorry for misunderstanding. I think the core/core.c modification can
use the CQE interface, but there are some difference in core/block.c,
and I think they are different mechanisms, also I want to keep avoid
affecting CQE and normal transfer, so I think adding MMC packed
related interfaces will be easy to read and maintain.

-- 
Baolin Wang
Best Regards
