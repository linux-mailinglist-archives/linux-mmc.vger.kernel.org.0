Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8D8F8BD
	for <lists+linux-mmc@lfdr.de>; Fri, 16 Aug 2019 04:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHPCJm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 22:09:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44732 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfHPCJm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Aug 2019 22:09:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so8200813ote.11
        for <linux-mmc@vger.kernel.org>; Thu, 15 Aug 2019 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8WQgNY5edhjwIqgfRMLNlVr4U5tJU1UH3nKwYXzjT4=;
        b=K5rChutE1LOVfl8lVOYPCcQRrsGycuJiuwP8o8Yim2bCILlJp/qIdct8eScIINZsG5
         ly0tK2EgYkT6CLo7Hib5qKN1CCDDeVAKux8ivrP0CVXte4vkqmXUz/NHWAZ0D1Ehr0K9
         Ooyl6OEWXHImu/KtvHU0Omq+feNqp0TyZze6rZfl2V/4stmpHbCFv28tc745KX5aADpv
         iW5tOn8GLWGOacTQ+6d+xG3kmWDY5wE2KbvqNc97W8F3aOsTuMiCorxMx5ngOInE0ci5
         JLQBjVtCQImO4z6HJMeWh8Lb3bwPdRgEUyvVJEUbXgoN5Nmqcz7h+T22iSxim5eCbyy7
         jA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8WQgNY5edhjwIqgfRMLNlVr4U5tJU1UH3nKwYXzjT4=;
        b=G+PvDfXuNuUIqcgYvHdNbZ97wYf2zVuI4DgtO1mtI7lMjecPXETfysb5jxK4fyyH90
         nDIExm9PfcbPKA+ecOmVN0kTFsD27o//z92t9uqhst5OcjYHpol63wxCPHwuxdZtNLHg
         FW4hshcZKJHsZDu6IoWPis3NnlHJJRPy62Eip1EoZChof2znGfU7PYfQj8Kcb7gxfaaO
         5gRG5PuqbHvzl1+QHrJX5zZe/zmdGtunmt28h8UjqKYU5ykYjG80YtplCxGBSTFNjUCc
         ttgID1pta5D1Zczs7nPxiVNYNMT+cIyF3/gOTKJobcy+Mm06WifzkV4wb0IS6KMXCF10
         Kcxw==
X-Gm-Message-State: APjAAAUEmy69eMy/JULqJ1IUMBdMNXX/tAf44StwxVtlwZa+fjKX7eXe
        1tCmOMd10u4DxLP2fDaxyQI7uM0vFiD7z+xrIhqNBA==
X-Google-Smtp-Source: APXvYqzuEecn8qJqzdau/wXa7yQRXNl6OyVal2e006npCodfhJTAF66Aog58xJUh64CFgwA/CPR4R5O2/ZMtqGPx7tI=
X-Received: by 2002:a05:6830:42:: with SMTP id d2mr5893515otp.123.1565921381240;
 Thu, 15 Aug 2019 19:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563782844.git.baolin.wang@linaro.org> <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
 <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com> <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
In-Reply-To: <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 16 Aug 2019 10:09:29 +0800
Message-ID: <CAMz4kuLNtHVzieJpD_etB3n4aa1sR3RiM6_KHLhC2QXCKGBzBA@mail.gmail.com>
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

Hi Adrian,

On Mon, 12 Aug 2019 at 17:44, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Adrian,
>
> On Mon, 12 Aug 2019 at 16:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 12/08/19 8:20 AM, Baolin Wang wrote:
> > > Hi,
> > >
> > > On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >>
> > >> Hi All,
> > >>
> > >> Now some SD/MMC controllers can support packed command or packed request,
> > >> that means it can package multiple requests to host controller to be handled
> > >> at one time, which can improve the I/O performence. Thus this patchset is
> > >> used to add the MMC packed function to support packed request or packed
> > >> command.
> > >>
> > >> In this patch set, I implemented the SD host ADMA3 transfer mode to support
> > >> packed request. The ADMA3 transfer mode can process a multi-block data transfer
> > >> by using a pair of command descriptor and ADMA2 descriptor. In future we can
> > >> easily expand the MMC packed function to support packed command.
> > >>
> > >> Below are some comparison data between packed request and non-packed request
> > >> with fio tool. The fio command I used is like below with changing the
> > >> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
> > >> transfer speed.
> > >>
> > >> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
> > >>
> > >> My eMMC card working at HS400 Enhanced strobe mode:
> > >> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > >> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > >> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > >> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > >> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> > >>
> > >> 1. Non-packed request
> > >> I tested 3 times for each case and output a average speed.
> > >>
> > >> 1) Sequential read:
> > >> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
> > >> Average speed: 28.7MiB/s
> >
> > This seems surprising low for a HS400ES card.  Do you know why that is?
>
> I've set the clock to 400M, but it seems the hardware did not output
> the corresponding clock. I will check my hardware.

I've checked my hardware and did not find any problem.

The reason of low speed is that I set the bs = 4k, when I changed the
bs=1M, and the speed can go up to 251MiB/s.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read
--bs=1M --size=512M --group_reporting --numjobs=20 --name=test_read
READ: bw=251MiB/s (263MB/s), 251MiB/s-251MiB/s (263MB/s-263MB/s),
io=10.0GiB (10.7GB), run=40826-40826msec

-- 
Baolin Wang
Best Regards
