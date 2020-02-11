Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FA158C0F
	for <lists+linux-mmc@lfdr.de>; Tue, 11 Feb 2020 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBKJrN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 11 Feb 2020 04:47:13 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44688 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgBKJrM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 04:47:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so5855516vsj.11
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2020 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qy2+V0FRDTJCkLb3sPwAojRAHrzyHLSBU8Qum5rVbKQ=;
        b=rLXTbF+TyLCIrDzIklAYurubr+/kR620N0rYqXSClQi5hQfHGUoAI8VHI63Wj1NgcX
         VWgQ8OBdEgklWY4wWA3TFO0D8iUVXkB8/+sMV5+2KyksboVMSVTyyHKp/XCdW3EgHpPu
         gABvVO2pfRkECF3B1X0o0Ma/8FmjgptVW76PF8R2lB+HQFDiSK2vbU11IVfzXEaWReWt
         Z8Id61Q5D9TwYrxsQjnOWW8zHI1Qh+oTp0r/KwNbaCo6iG6jjK0U9FYurnLBO34/IeJM
         GH9/Y2s6GxMs/iJBUyvz7j765C+riZFt1afPCts4Xoi/YDlMv/ZfQ8+PA1tBnyMl5/Rg
         uccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qy2+V0FRDTJCkLb3sPwAojRAHrzyHLSBU8Qum5rVbKQ=;
        b=MQWmGJNXwiFuTxvll2JvyfDm8V0HGNJYm+xMHWYJ1XYGTAe+2APBE8zNWGcVZ7YRQt
         ruPu7xpa7ufIepKKAozTkmdiP+M3bIgSj2KOdaJuKHrGAyNZwaAYQFawzAMP1/kbQrO+
         lJSnFRdGdDFG00CNjBWGkm3k0FGNggauEYImObSzl5YrclEtJNpqWmZKr9Wd8BZzau9e
         oiRTDC5RLO4Zqq0BE0zL/6pehdn5sYtfLhPhL14vsuEj4tLvc2xVS6+HRBBkcN0kzOH1
         2v/5mZ4mUz+ASzR6vJ9s8C/61dJJK4GMR8dNMtjp/yz6c5XPD+A6deRsjtbKXWZIaLfz
         t2pQ==
X-Gm-Message-State: APjAAAWtnhGVEmSs7z8RF+nvY6sWw1RffZB0XzUh7QA8VEFebm5mTo+D
        bzJlJEZmLNiWagUcILkXVgUZa3rXO4zKswCCeVnG/w==
X-Google-Smtp-Source: APXvYqwA4JjsCl5kB/MlZJBGOn9Zyx8nl7knYuPHbGH+a3RmtDyN/UECjm+qjoVu5Tt27yDtEs+N3y2j5CzjUaZZ7YI=
X-Received: by 2002:a05:6102:1268:: with SMTP id q8mr8509822vsg.34.1581414430311;
 Tue, 11 Feb 2020 01:47:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580894083.git.baolin.wang7@gmail.com> <CAPDyKFpqtCi4H7T99PguzsUi+-803EA-y+vXGK7C0cHVbzeJ6A@mail.gmail.com>
 <CADBw62rgoXjgoqaokhBqYCqAY-3vYnCq4iiVYaxZu_JJsufvDQ@mail.gmail.com>
 <CAPDyKFp6he4cvYGwyu8Jrdd5A-EDfdNOKahEE6zBU7VCb3TfTg@mail.gmail.com> <CADBw62rg8Ofmh0+9Pyy_SuC_4ugxkBGBgKSchS4u5JGJAYYdJw@mail.gmail.com>
In-Reply-To: <CADBw62rg8Ofmh0+9Pyy_SuC_4ugxkBGBgKSchS4u5JGJAYYdJw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Feb 2020 10:46:33 +0100
Message-ID: <CAPDyKFoeHh=y_SnHLxg3aDcA=ZLVx-XpzpzOBdYTu4f6wBZYJw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add MMC software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Feb 2020 at 05:47, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Mon, Feb 10, 2020 at 9:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 10 Feb 2020 at 09:41, Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Thu, Feb 6, 2020 at 11:00 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 5 Feb 2020 at 13:51, Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > Now the MMC read/write stack will always wait for previous request is
> > > > > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > > > > or queue a work to complete request, that will bring context switching
> > > > > overhead, especially for high I/O per second rates, to affect the IO
> > > > > performance.
> > > >
> > > > In the regular request path (non CQE), we call mmc_blk_card_busy() to
> > > > complete a request. For write I/O, this leads to calling
> > > > card_busy_detect(), which starts to poll the card by sending a CMD13.
> > > >
> > > > At least one CMD13 will be sent to the card, before we exit the
> > > > polling loop and a new I/O request can get submitted. However, in many
> > > > cases, depending on the controller/host/card/request-size, my best
> > > > guess is that *one* CMD13 might not be sufficient. At least, that is
> > > > what I have observed on those platforms I recently have been working
> > > > on.
> > > >
> > > > That said, I am wondering if you have done some measurement/profiling
> > > > on this particular behaviour for your controller/driver? For example,
> > > > how many CMD13 gets sent for random small writes during polling?
> > >
> > > Ah, I had not checked how many CMD13 for random small writes before.
> > > And I did a quick testing today, I found only 1 CMD13 gets sent for
> > > random writes on my platform.
> >
> > Thanks for sharing the result, very interesting!
> >
> > Would you mind running a "dd write operation", to test large
> > consecutive writes as those should cause longer busy times. Just to
> > make sure the HW busy detection really works as expected.
> >
> > For example:
> > dd of=/dev/mmcblk[n] if=/dev/zero bs=1M count=512 conv=fsync
>
> Sure. I've run the dd command and still got the same result. Only 1
> CMD13 for each write operation.

Great, thanks for confirming the behaviour.

>
> > > > Why am I asking this? Because, unless I am mistaken, when using the
> > > > new hsq path that you introduce in $subject series, based on the cqe
> > > > ops, then mmc_blk_card_busy() is not being called at all. In other
> > > > words, you rely on HW busy detection from the controller/driver,
> > > > rather than polling with CMD13. Is that correct?
> > >
> > > Right. I think so.
> >
> > A couple of follow up questions then.
> >
> > Normally, the mmc core adds the MMC_RSP_BUSY (part of MMC_RSP_R1B)
> > response flag, for those commands having busy signaling on DAT0, like
> > CMD6 for example. After the command has been sent, the core checks
> > whether the host supports HW busy signaling, via the
> > MMC_CAP_WAIT_WHILE_BUSY flag. If so the polling loop to detect when
> > the card stops signaling busy, is skipped by the core. See
> > __mmc_switch() and mmc_poll_for_busy(), for example.
>
> Make sense.
>
> > This makes me wonder, why doesn't your driver set the
> > MMC_CAP_WAIT_WHILE_BUSY, as it seems to support HW busy signaling?
>
> I think we should set this flag, but missed it before. And I did a
> quick testing with setting this flag, I did not find any problem.
> So I will post one patch to enable this flag with more stable testing.

Don't forget to also set .max_busy_timeout for the host, if you need
to set an upper limit of the busy timeout. Zero indicates, no limit.

>
> > Moreover, it also seems like your driver can support
> > MMC_CAP_DONE_COMPLETE. Or at least the part that requires HW busy
>
> No. Cause we will complete the request in the irq context, if we set
> this MMC_CAP_DONE_COMPLETE, we will call mmc_blk_mq_post_req()--->
> mmc_post_req() in the irq context, which is a time-consuming operation
> and not be allowed.

Ahh, I see. Thanks for clarifying this.

>
> > detection for I/O write operations. I guess we also need your series,
> > "[PATCH 0/3] Introduce the request_atomic() for the host"  as to
> > support it. What do you think, would it be possible to test this at
> > your side?
>
> Yes, we need  this series ("[PATCH 0/3] Introduce the request_atomic()
> for the host"), which is used to dispatch next request to the
> controller in the irq context directly, to remove context switching.
>
> > Note that, I haven't played with MMC_CAP_DONE_COMPLETE so far, but it
> > was invented to allow optimization for these kind of situations.
>
> I think the MMC_CAP_DONE_COMPLETE flag is used for this case: the host
> controller completes requests in the irq thread or a workqueue
> context, then we do not need queue the 'mq->complete_work' to complete
> requests, instead we can compelete requests in the current context.
>
> But now we will complete the requests in the irq context, so seems
> MMC_CAP_DONE_COMPLETE is not useful here.

Yes, I fully agree with you, now. Thanks again for clarifying.

>
> > Now, don't get me wrong, I still think we should move forward with
> > @subject series. I just want to make sure we don't have several
> > methods to implement the same thing. So perhaps, MMC_CAP_DONE_COMPLETE
> > and the corresponding code should be removed, in favor of the more
> > generic hsq interface?
>
> Yes, now no host controllers set the MMC_CAP_DONE_COMPLETE flag, I
> think we should remove this flag.

Yeah, let's consider that for later then.

If we should keep it, at least we should clarify with some
comments/documentation about when it makes sense to use it.

>
> > > > This seems like an additional reason to why you achieve significant
> > > > improvements for the random write case. Don't you think?
> > >
> > > Yes, agree wtih you.
> > >
> > > > >
> > > > > Thus this patch set will introduce the MMC software command queue support
> > > > > based on command queue engine's interfaces, and set the queue depth as 64
> > > > > to allow more requests can be be prepared, merged and inserted into IO
> > > > > scheduler, but we only allow 2 requests in flight, that is enough to let
> > > > > the irq handler always trigger the next request without a context switch,
> > > > > as well as avoiding a long latency.
> > > > >
> > > > > Moreover we can expand the MMC software queue interface to support
> > > > > MMC packed request or packed command instead of adding new interfaces,
> > > > > according to previosus discussion.
> > > > >
> > > > > Below are some comparison data with fio tool. The fio command I used
> > > > > is like below with changing the '--rw' parameter and enabling the direct
> > > > > IO flag to measure the actual hardware transfer speed in 4K block size.
> > > > >
> > > > > ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
> > > > >
> > > > > My eMMC card working at HS400 Enhanced strobe mode:
> > > > > [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > > > > [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > > > > [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> > > > > [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> > > > > [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
> > > > >
> > > > > 1. Without MMC software queue
> > > > > I tested 5 times for each case and output a average speed.
> > > > >
> > > > > 1) Sequential read:
> > > > > Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> > > > > Average speed: 59.66MiB/s
> > > > >
> > > > > 2) Random read:
> > > > > Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> > > > > Average speed: 27.04MiB/s
> > > > >
> > > > > 3) Sequential write:
> > > > > Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> > > > > Average speed: 69.68MiB/s
> > > > >
> > > > > 4) Random write:
> > > > > Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> > > > > Average speed: 35.96MiB/s
> > > > >
> > > > > 2. With MMC software queue
> > > > > I tested 5 times for each case and output a average speed.
> > > > >
> > > > > 1) Sequential read:
> > > > > Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> > > > > Average speed: 60.68MiB/s
> > > > >
> > > > > 2) Random read:
> > > > > Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> > > > > Average speed: 31.36MiB/s
> > > > >
> > > > > 3) Sequential write:
> > > > > Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> > > > > Average speed: 71.66MiB/s
> > > > >
> > > > > 4) Random write:
> > > > > Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> > > > > Average speed: 68.76MiB/s
> > > > >
> > > > > Form above data, we can see the MMC software queue can help to improve some
> > > > > performance obviously for random read and write, though no obvious improvement
> > > > > for sequential read and write.
> > > > >
> > > > > Any comments are welcome. Thanks a lot.
> > > > >
> > > > > Changes from v7:
> > > > >  - Add reviewed tag from Arnd.
> > > > >  - Use the 'hsq' acronym for varibles and functions in the core layer.
> > > > >  - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure the CQE
> > > > >  can work normally.
> > > > >  - Add a new patch to enable the host software queue for the SD card.
> > > > >  - Use the default MMC queue depth for host software queue.
> > > >
> > > > It would be nice to also have some measurements for an SD card, now
> > > > that the series supports this. Is that possible for you test as well?
> > >
> > > Yes, but my SD card works at high speed mode, and shows a low speed in
> > > 4k block size.
> > > [    2.941965] mmc0: new high speed SDHC card at address b368
> > > [    2.948325] mmcblk0: mmc0:b368 SD08G 7.42 GiB
> > > [    2.956554]  mmcblk0: p1
> > >
> > > And I did not see any obvious improvement or recession for my SD card
> > > in 4k block size from below data, I think the most of the time is
> > > spent in hardware. (But when I enabled the packed request based on
> > > hsq, I can see some obvious improvement.)
> > > Without hsq:
> > > read: bw=4347KiB/s
> > > randread: bw=3040KiB/s
> > > write: bw=1361KiB/s
> > > randwrite: bw=692KiB/s
> > >
> > > With hsq:
> > > read: bw=4246KiB/s
> > > randread: bw=29950KiB/s
> > > write: bw=1417KiB/s
> > > randwrite: bw=697KiB/s
> >
> > Thanks for testing and sharing!
> >
> > Did you use "[PATCH 0/3] Introduce the request_atomic() for the host"
> > as well? In there, it seems like you are disabling the hsq option for
>
> No, I did not use this series when testing, but I think the result
> will be same. Since we will set host->always_defer_done as true for
> removable SD cards.
>
> > removable cards, or did I get that wrong? Does it matter?
>
> No, I did not disable the hsq. In this series, we will not implement
> the request_atomic() API for these removable cards, since we need
> check the card status when handling a request, which maybe a sleepable
> operation when detecting the card status (such as from GPIO), so we
> can not disaptch next request in the irq context, instead we should
> still set the host->always_defer_done as true for the removable cards.

Got it.

So, a temporary/not-to-be-merged hack, to make the SD slot
non-removable, would allow you to use the optimized path with hsq,
right? That could give us some performance numbers also for SD cards.

Kind regards
Uffe
