Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC34C3316D
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Jun 2019 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfFCNsv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 09:48:51 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37024 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfFCNsr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 09:48:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id l3so6362038uad.4
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAX0xjkGcEXxKUF7vZFHxjTqN+8GO7j4+KMf4Q9seNI=;
        b=gAx0FdT7BZTU+CsokwfA7qZGL1MGYSitF1l72RSO64zJk2c5vfROnKaJ+XeXLRIBJc
         tsOyEMdeEDBo5OHm72bMnlUatjj++mbq6DzEdktY62SJ09UwgexFJ116A//3MaPqlGDa
         7ry6f/s9ItrPTLjmX7qC3t50vTQ78DTE9QmKMibO5gh/yjZR42HGRhjyKOMG0avzhhzV
         UFYYXQCAg3BwOz2YhE4Dr2ArJSzoPE2UrANkB+5r+oeZ2iuMG6fCdfkRpdyfFwVRx9s8
         7hwP1dKKOBD730KZXoYwwHy755KrYdgSCW1jks5DtXeg5I2Go3MCBr3byemj9IlwftuL
         GgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAX0xjkGcEXxKUF7vZFHxjTqN+8GO7j4+KMf4Q9seNI=;
        b=GwKh7REQX9mbpHwytYAuTQCp6P4woJiqBAdszS7TVZXBYLg2m5IpEMcUi1HY5mOppm
         a0V0b+MpA9qT3HKwDllmqhMQxyNFuaaiD2S5dAWbf4Ex+gY+Vn+ry8vPPyUw+otmkmW3
         7zHs7LzSVyJkQUzl0AXDbYe/u0GOOGHIS4wr+F7MZ+pY8YG8LHkSRL4RaD5qVHAA1sgq
         7SfSesCfLcrhszQNRSzEJOhZjqAKLeAGKNhKXL+ewO/TgkkcgjKGX/KRGU60SZ30d7rY
         Mzd8Fxdeck6L2bm5jHWlwnaUxcbKfWOicAlIBRwvc1BVdxgVBekIfClKmEtBBNacIhLL
         560Q==
X-Gm-Message-State: APjAAAXG811DCVJtzVfW+G8eh/RVcJDY4dDIxKmQc7AUtobIrNT0uQIl
        vaEUHHk/gYdWC3/XMOxwSvCCruahx0oUyy5ARMRHLQ==
X-Google-Smtp-Source: APXvYqzzczFhoWvx3KPDbwmQwr9gLyMfPLnT1ZWU+Mk/3rKi5dvNkbvECWmDbfWjtexLy1Xw4xZku3AK9U0Z0IPty8M=
X-Received: by 2002:ab0:2b8f:: with SMTP id q15mr12844791uar.104.1559569726120;
 Mon, 03 Jun 2019 06:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190515143725.18872-1-wanghai26@huawei.com>
In-Reply-To: <20190515143725.18872-1-wanghai26@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:09 +0200
Message-ID: <CAPDyKFpjRqa7vq4jqp-Wat=cYWHe5DkuUBhzuwwFg3oeaG9jfw@mail.gmail.com>
Subject: Re: [PATCH] memstick: Fix error cleanup path of memstick_init
To:     Wang Hai <wanghai26@huawei.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 May 2019 at 16:39, Wang Hai <wanghai26@huawei.com> wrote:
>
> If bus_register fails. On its error handling path, it has cleaned up
> what it has done. There is no need to call bus_unregister again.
> Otherwise, if bus_unregister is called, issues such as null-ptr-deref
> will arise.
>
> Syzkaller report this:
>
> kobject_add_internal failed for memstick (error: -12 parent: bus)
> BUG: KASAN: null-ptr-deref in sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
> Read of size 8 at addr 0000000000000078 by task syz-executor.0/4460
>
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xa9/0x10e lib/dump_stack.c:113
>  __kasan_report+0x171/0x18d mm/kasan/report.c:321
>  kasan_report+0xe/0x20 mm/kasan/common.c:614
>  sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
>  sysfs_remove_file include/linux/sysfs.h:519 [inline]
>  bus_remove_file+0x6c/0x90 drivers/base/bus.c:145
>  remove_probe_files drivers/base/bus.c:599 [inline]
>  bus_unregister+0x6e/0x100 drivers/base/bus.c:916 ? 0xffffffffc1590000
>  memstick_init+0x7a/0x1000 [memstick]
>  do_one_initcall+0xb9/0x3b5 init/main.c:914
>  do_init_module+0xe0/0x330 kernel/module.c:3468
>  load_module+0x38eb/0x4270 kernel/module.c:3819
>  __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
>  do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai26@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 1246d69ba187..b1564cacd19e 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -629,13 +629,18 @@ static int __init memstick_init(void)
>                 return -ENOMEM;
>
>         rc = bus_register(&memstick_bus_type);
> -       if (!rc)
> -               rc = class_register(&memstick_host_class);
> +       if (rc)
> +               goto error_destroy_workqueue;
>
> -       if (!rc)
> -               return 0;
> +       rc = class_register(&memstick_host_class);
> +       if (rc)
> +               goto error_bus_unregister;
> +
> +       return 0;
>
> +error_bus_unregister:
>         bus_unregister(&memstick_bus_type);
> +error_destroy_workqueue:
>         destroy_workqueue(workqueue);
>
>         return rc;
> --
> 2.17.1
>
>
