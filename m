Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD7F128E
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Nov 2019 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfKFJmY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Nov 2019 04:42:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39009 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKFJmY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2019 04:42:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id 195so17490852lfj.6
        for <linux-mmc@vger.kernel.org>; Wed, 06 Nov 2019 01:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwqiT+1NfnspAIK0wZjnJtlVbnGrlTL8OWauuSVNTc8=;
        b=Nq0KdS7Ro02CE5gR4ZFcjBmHVVxK6kJPyUQ1PSV1FJ0XHaizW9nEBAWJisUzUrhBW6
         3O0G6uE65IeBsAkGuQ+/FyAT5SlHm10C2vnuibqUF7FNfpkHU8y2LqjDooQvp2ggbK1J
         bN640CHMRwOmwx2aZAVEpXmCRo0HbdOlmXT4P+QjQiCc9lKbAS1/fD9UmRAtNF3IuVyJ
         fUkw78ZGQilqXH3LntMeTaR/nkDoTSZE1bGIz2nGs87AiiF8k3+xjopVrvpwOpEk4nHX
         4VxCLpYwtUGfriXg+p9/EvuuD9PpHQhRTy688BtojIEqrbOBSp1RRksCIjSNYuHj+itr
         fF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwqiT+1NfnspAIK0wZjnJtlVbnGrlTL8OWauuSVNTc8=;
        b=e5eMF6IM7/LON2b+145TzqmJ/JWS79p7xR5W1cL3lm3/PnMC4BP4st3TtCgZYnd4na
         BskRLdnmheM+tJ5DQOJ0736cWJAZZ2HPdq6BargomiFFA5oIwGFvGFQ9zUokpvAtIAy1
         nghQVjzBg2VCuUAyutivRFuau1X6GyC0/Y6N1SNAxE5/aF5DyvT5Os9CYuLQc5Td+owm
         3FoCBj8y23dDZwbz47escqR12liRlyElf4qJlyaSJBU6oLZ83lPYs63XVzY52bPLv+vZ
         XzJJLW0FZEdEUSyBAMRnA0xSqRjUEAT/D3U2xpxWcNSpmVeDXDX5GxtcaRUxENgbOEe6
         47+g==
X-Gm-Message-State: APjAAAXRG6oNtukQKtBeGEfha/IS5wO9+YrvT2cMnAD+nclplBhJQgiv
        G/hYH+y4m/66yaxl9isBbkVfEzRW63eEPSdxFT2n+Q==
X-Google-Smtp-Source: APXvYqyTQZnFnYq55RWutP2Qz2nHbxPAnD/+tra78abV0fWRkD8Hj55bsCpbzdvnT5PejLQgVfYHsVnGZacF9QuKPbA=
X-Received: by 2002:a19:f107:: with SMTP id p7mr23099189lfh.91.1573033340814;
 Wed, 06 Nov 2019 01:42:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572326519.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 6 Nov 2019 17:42:09 +0800
Message-ID: <CAMz4kuKEOL=qdXHk=XwB6Fd-nq=OhB7sTwQpiYiwRrnM+sCwww@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add MMC software queue support
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, 29 Oct 2019 at 13:44, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi All,
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
>
> Thus this patch set will introduce the MMC software command queue support
> based on command queue engine's interfaces, and set the queue depth as 32
> to allow more requests can be be prepared, merged and inserted into IO
> scheduler, but we only allow 2 requests in flight, that is enough to let
> the irq handler always trigger the next request without a context switch,
> as well as avoiding a long latency.
>
> Moreover we can expand the MMC software queue interface to support
> MMC packed request or packed command instead of adding new interfaces,
> according to previosus discussion.
>
> Below are some comparison data with fio tool. The fio command I used
> is like below with changing the '--rw' parameter and enabling the direct
> IO flag to measure the actual hardware transfer speed in 4K block size.
>
> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read
>
> My eMMC card working at HS400 Enhanced strobe mode:
> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>
> 1. Without MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> Average speed: 59.66MiB/s
>
> 2) Random read:
> Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> Average speed: 27.04MiB/s
>
> 3) Sequential write:
> Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> Average speed: 69.68MiB/s
>
> 4) Random write:
> Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> Average speed: 35.96MiB/s
>
> 2. With MMC software queue
> I tested 5 times for each case and output a average speed.
>
> 1) Sequential read:
> Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> Average speed: 60.68MiB/s
>
> 2) Random read:
> Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> Average speed: 31.36MiB/s
>
> 3) Sequential write:
> Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
> Average speed: 71.66MiB/s
>
> 4) Random write:
> Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> Average speed: 68.76MiB/s
>
> Form above data, we can see the MMC software queue can help to improve some
> performance obviously for random read and write, though no obvious improvement
> for sequential read and write.
>
> Any comments are welcome. Thanks a lot.
>
> Changes from v4:
>  - Add a seperate patch to introduce a variable to defer to complete
>  data requests for some host drivers, when using host software queue.
>
> Changes from v3:
>  - Use host software queue instead of sqhci.
>  - Fix random config building issue.
>  - Change queue depth to 32, but still only allow 2 requests in flight.
>  - Update the testing data.
>
> Changes from v2:
>  - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
>  instead adding 'struct sqhci_host', which is only used by software queue.
>
> Changes from v1:
>  - Add request_done ops for sdhci_ops.
>  - Replace virtual command queue with software queue for functions and
>  variables.
>  - Rename the software queue file and add sqhci.h header file.

Do you have any comments for this patch set? Since the merge window is
approaching, is it possible to apply this patch set into V5.5? Thanks.

>
> Baolin Wang (4):
>   mmc: Add MMC host software queue support
>   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
>   mmc: host: sdhci-sprd: Add software queue support
>   mmc: host: sdhci: Add a variable to defer to complete data requests
>     if needed
>
>  drivers/mmc/core/block.c      |   61 ++++++++
>  drivers/mmc/core/mmc.c        |   13 +-
>  drivers/mmc/core/queue.c      |   33 +++-
>  drivers/mmc/host/Kconfig      |    8 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h    |   30 ++++
>  drivers/mmc/host/sdhci-sprd.c |   26 ++++
>  drivers/mmc/host/sdhci.c      |   14 +-
>  drivers/mmc/host/sdhci.h      |    3 +
>  include/linux/mmc/host.h      |    3 +
>  11 files changed, 523 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/mmc/host/mmc_hsq.c
>  create mode 100644 drivers/mmc/host/mmc_hsq.h
>
> --
> 1.7.9.5
>


-- 
Baolin Wang
Best Regards
