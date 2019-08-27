Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DA9EA2E
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfH0N4B (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 09:56:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41955 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfH0N4A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 09:56:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id m62so13439783vsc.8
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQzhNAIFt5hn3lNj8VHzyzeNesjUsxuZGnqma8bu4p4=;
        b=GXtulx5b+8SWICbyuPjwDF9F7bv+zAAqlu3W0izJJ9FxbhtfIyDF2TP/yJ4bvTKKRJ
         kgNhO8/nY9YbctW58lDbFnAWR6Meq0ojGpQZmXLNP1dQZLvYE8QaHs6k0J0zlZ/SsYls
         PI8D1ZdYXfEXEnq9nmLbvAMn7hNxxdUoL4jaNKYRLdyyhhon6NVBCTXJ5tGKFO7KK9K1
         I+ZME+KKZOGOZnRBwyA0gD5Ki2Okp9WZUjEh7cnmTchfvMKoxZjQAMVRCi66JZLUezCE
         7R4sYFa3DMEvWHqp98Yh/W1rU58+BlXbxxZFO4cimlrY0k3gSvb56qpaixubm0OuJP7a
         tVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQzhNAIFt5hn3lNj8VHzyzeNesjUsxuZGnqma8bu4p4=;
        b=ZjR6teoMUUcJtwfcfn/4LKKCfhaOJB/FF47lnMAcdUHIyrDaGgHXwBmGRnghGYaCZH
         PItM7OkgzV/+lAJQd9DS29z69xq14WoV3l8aEsj2ApY6ndMsel1t3knL6brImQ3fdKAl
         97mgLJ65cRVbCX3/ImeScU1n8/t8a0A/WXAaoE5ckNmfe5NCJI8zpsCd5WDk4rYjQBT4
         fe9Ksrf3NYs5xVvpQ//yAsemeKF0cwgfPdxCx/00qOf33btFd9MhtJHLf/EWrZGVNkju
         6NHydJ1JtqH/91bEzR2Hv1MZoFld+tTTiZYbezI8GAxYO6xT0UiW//QRkcGzsUbSo3ZS
         31iA==
X-Gm-Message-State: APjAAAUnv5P6guMG43SdRKzGj6PtluI6KhZWuzkqfEzibhLYHlQ9O9c7
        T/jn1b2gT2fxY7THNa113dMKcIu4JxSB6TbLwk2TOg==
X-Google-Smtp-Source: APXvYqxyqinG9B1wk9mMD63rudWgHA96o+UjC3keLDloPcQN/XZg/h4S9AIvpCaBd00wLVyZueMl5UVixOOQudOS1oc=
X-Received: by 2002:a67:e287:: with SMTP id g7mr13489601vsf.200.1566914160059;
 Tue, 27 Aug 2019 06:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134337.GK13294@shell.armlinux.org.uk>
In-Reply-To: <20190827134337.GK13294@shell.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:55:23 +0200
Message-ID: <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
Subject: Re: Continuous SD IO causes hung task messages
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> While dd'ing the contents of a SD card, I get hung task timeout
> messages as per below.  However, the dd is making progress.  Any
> ideas?
>
> Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> for the card?

Is it a regression?

There not much of recent mmc core and mmc block changes, that I can
think of at this point.

>
> ARM64 host, Macchiatobin, uSD card.

What mmc host driver is it? mmci?

Kind regards
Uffe

>
> Thanks.
>
> root@arm-d06300000000:~# dd if=/dev/mmcblk1 | md5sum
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 241 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 362 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
