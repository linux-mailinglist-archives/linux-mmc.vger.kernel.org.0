Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3C4096D0
	for <lists+linux-mmc@lfdr.de>; Mon, 13 Sep 2021 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbhIMPNz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 Sep 2021 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbhIMPNt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2021 11:13:49 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F37C0C7015
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 07:02:56 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso13426926otv.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3xvNWywI97T4tWFgzxwRssL/X08dlRk9g/Y8iCoCYDQ=;
        b=P/L+slfGYvd26hdMp0Y/CSmadKyMlS3h6DMan0rYpjL4lDuewmqrlQNRopj+ozCgj+
         lsM+ZPRfP/O0n1WuTCBx340GD1ZcRF0jgGJD5DhU17g+VsUxq0eu3D3oydRxdPmMURKg
         2Qpa9hyVmbEiIaf3ANBqQCswXZR8EU6PXOnakXNO5c8y1TdP2Xez+GJ9hoW9d7dAEutK
         5sPEbmWg4NHx+D2TdWUH+aYCjCLYuR1Ptx7IQIIRbrLCf3ZTJsAZcuwDg/i7Qyt5mhTm
         7FaUQ/De72DOrf/bHoDzBtRv1HI5n3+VFdATkr7O6D11WSVzx2xDYZKis+SVZQOpkyUL
         9sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3xvNWywI97T4tWFgzxwRssL/X08dlRk9g/Y8iCoCYDQ=;
        b=DNC7L1kN2kdkg9zT2nuewOSFEjMLOicoOvqILWxrWp2WcHwTxPkrZNMvjfMYsZtIW8
         9dUO/2kiT+4ehYNn3EawJqoCZd76T1uOGXSkhby5ndp5U4BAs4Gmsq0apZDc0FuXzZPj
         GGBFkTUrkJCnXitJQtLQCm6E0Q/MPradFHoinW4u5d7gkYjHa1n3AQnOROtM17S8hUec
         BPax9+IdFBccsk9qFzUnDtr1zAbvGL76zpPrIQbow1Ez7Gym+tLDMNOrUq2+LManDdzA
         6rGigXwMG2wXTBPrdHO2n3d8ODYuhPNXaYLu7cpmESPYr646jJqfMMKeWxyLng6y1sEB
         Fx5A==
X-Gm-Message-State: AOAM532Z34ZFUZoTCcr0nzB7GbH9EHMc+3AP25HzO40BJTBvji50MPX0
        bckbr8+b1EqL/GkCTIWQcSj3cWuw9KACMov+yi5S35DL
X-Google-Smtp-Source: ABdhPJw6B+ADdHrI0v2l9YUhSmMkHi6e/RmCUYhA9Q4rP5TKra6nFstMWnobd78qf6G+X3DtelGZXixa3F5BrTuieZ0=
X-Received: by 2002:a9d:3e09:: with SMTP id a9mr10200108otd.87.1631541775337;
 Mon, 13 Sep 2021 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMeyCbgzrbt_A_e=YGKdFyFexX0q7D15KMdL3jTKGw-YKzLA8Q@mail.gmail.com>
In-Reply-To: <CAMeyCbgzrbt_A_e=YGKdFyFexX0q7D15KMdL3jTKGw-YKzLA8Q@mail.gmail.com>
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Mon, 13 Sep 2021 16:02:45 +0200
Message-ID: <CAMeyCbjBeuqUknNKzLhBrjTVch23nShO+eCK80kcJs36uKdWLA@mail.gmail.com>
Subject: mmc host: abort pending mmc requests
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

I am trying to implement some special use-case.
On our platform the CPU will be notified with an interrupt if the
power fails. After that the system has ~100ms time to do some
tear-down tasks.
One important step is to store some information (~512KB) on some non
volatile storage.
EMMC seems to be a good choice because of the high throughput. But the
drawbacks are the non deterministic latencies caused by the EMMC
itself, the complex sdhci mmc host driver, the blocklayer, ...

Because time is critical I tried to implement this in the kernel space.

Most likely EMMC hardware latencies can be reduced by execution of a
block discard during boot-up. So in case of a power-fail no sectors
have to be erased, because they are pre-erased.

I looked at the mmc_test.c kernel module to execute raw mmc block writes.
For 512KB the write take ~60ms => looks promising

But the biggest concern is the influence of other tasks. The emmc has
multiple partitions.
So if i start a benchmark on another partition the write could also
take longer, because the mmc host driver has a lot of requests in its
queue.
I measured up to 6s. This is caused by the blocking call to
mmc_claim_host which waits for the queues to drain.

So i looked for a way to stop all queued mmc requests on the mmc host
before calling claim_host.

There exists some pstore implementations which have a similar use-case.
=> store data in block before panic reboot.

pstore_blk is mainline and can configured in two ways:
1. call block->panic_write if the block driver supports it. (Currently
only some mtd drivers and no emmc?)
2. Use "best_effort" and write to /dev/mmcblk via kernel_write() =>
possible with emmc

https://github.com/torvalds/linux/commit/f8feafeaeedbf0a324c373c5fa29a2098a69c458#diff-d3fb8bf94c21d538c62beccd243ca6266b4dec19c6d60a581aa6d71ba9874a53

This second option is also heavily influenced by other io, because it
uses the same system io scheduler like userspace?


But there exists also some more raw patch sets:
https://patchwork.kernel.org/project/linux-mmc/patch/1425015219-19849-1-git-send-email-jh80.chung@samsung.com/
https://patchwork.kernel.org/project/linux-mmc/patch/20201207115753.21728-2-bbudiredla@marvell.com/#23849559

And even some which tap into the sdhci driver to abort all ongoing
emmc requests:
https://lkml.org/lkml/2012/10/23/335


Because I want to keep it simple I started with some more basic commands:

The first try was to call
_mmc_blk_suspend(mmc_card);
before mmc_claim_host() => also slow

Next
blk_mq_freeze_queue(mmc_card->queue.queue)
before mmc_claim_host() => also slow

Next
mmc_blk_hw_queue_stop(mmc_card->queue.queue);
before mmc_claim_host() => better
By changing the scheduler to none and reducing max_sectors_kb. The
writes take up to ~100ms with parallel userspace write test running.
Without the write test it only takes ~60ms. So the scheduling of
userpace io still has some influence.

Do you know any way to forcefully stop all pending mmc host requests
to improve this further? I think mmc_blk_hw_queue_stop still waits for
the pending requests to be finished.
Or is there a way to queue my mmc block requests before all other
pending requests?

Thanks in advance!
