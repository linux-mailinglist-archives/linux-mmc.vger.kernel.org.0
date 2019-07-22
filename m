Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679A070170
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfGVNnw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:43:52 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37865 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbfGVNnu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:43:50 -0400
Received: by mail-vk1-f194.google.com with SMTP id 9so7839023vkw.4
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7axn/WEl0UCH44zkoJUqsY56vD3XQJHdkoWajImQl5A=;
        b=KvxICKAA5JaoQy/uRIrSIXrigZfcZ024VajYn1/ifQHnSsW0DLdF28At7lYhDOX0Pi
         WUwH/oiCuwFge7W2blPO2SPAoUoGlBtiyD7RNPoAJ4RziKjYuqFDeO0+joBB9Br8FHrU
         O4otZDFE+Q4bRXfXfDxxtzEYmUv91i89jxBI3400CbcGgAb7XMAp2I1X6nVI6mdmhzpb
         DVzaTXbYBTogzrdvJl8TjEqGhDkdTsAaqGDgt0g32b+0avUiDg0q4G/EGa9uqonCpkkY
         kRgzFbyMHnmzwCJldxnFSWGJyIw4qdwIkv2+98nXVSWRHnZJxe62i1R64kU47S3WA0Sm
         uKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7axn/WEl0UCH44zkoJUqsY56vD3XQJHdkoWajImQl5A=;
        b=TD3AaDt3hl01eXAxEYh84tx7BjejjUMiBeeqnZyozGe/Br61ydaZq4l7ScyW4nv5ud
         8osez7hAucT25LnflkdNwd89OEooX1Be/fiPvG003b92QMP1js5w2Nh1lk6OxfL366lL
         hNYVfpr/HnfRw8uKqp46eBurn6KSk/8BhqfXRzvRPqCxETrgQx66Ef7FpoW2sUKd7a0S
         psf+hFxyW62sWzjmxIfXfIA7t80rqxAQJZtVvSukT42Y7AF6x0zaIIhoGzdW7uvtl/Xw
         rd/jH6dTUwPFjxwOd6TYDAMv+dKlqLw9Gz/XKEstTMgVVZhp4wonYXT741IwSJlUjfRQ
         HuWQ==
X-Gm-Message-State: APjAAAUpnCCFyXGmCuKFySTAzSfyhr7NUe26NZw6g3MsneWCtzloIZ/d
        zw8Q4fItmkkwJJamxOsyButkwVsGSKBDT8wr3f09YXq9
X-Google-Smtp-Source: APXvYqz5RamDeA1TGTsDZNBPvJ69vDuVRi0j52gDyNJWuRl+bwhn4+sBWlgsT7k8n6QYFWoKCeH6bT+Dd08AOQo0vfw=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr24148097vkk.36.1563803029477;
 Mon, 22 Jul 2019 06:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1563768186-22161-1-git-send-email-shihpo.hung@sifive.com>
In-Reply-To: <1563768186-22161-1-git-send-email-shihpo.hung@sifive.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:43:13 +0200
Message-ID: <CAPDyKFoUTHZt6LNgUiiLnqXgABSg4mZYdvWTE9VPJ5LWHwTbGg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: Enable stable writes
To:     shihpo.hung@sifive.com
Cc:     Andreas Koop <andreas.koop@zf.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Jul 2019 at 06:03, <shihpo.hung@sifive.com> wrote:
>
> From: ShihPo Hung <shihpo.hung@sifive.com>
>
> From: Andreas Koop <andreas.koop@zf.com>
>
> Hello,
>
>   While using the mmc_spi driver occasionally errors like this popped up:
>
>   mmcblk0: error -84 transferring data
>   end_request: I/O error, dev mmcblk0, sector 581756
>
>   I looked on the Internet for occurences of the same problem and came
>   across a helpful post [1]. It includes source code to reproduce the bug.
>   There is also an analysis about the cause. During transmission data in
>   the supplied buffer is being modified. Thus the previously calculated
>   checksum is not correct anymore.
>
>   After some digging I found out that device drivers are supposed to
>   report they need stable writes.  To fix this I set the appropriate flag
>   at queue initialization if CRC checksumming is enabled for that SPI host.
>
>   [1]
>   https://groups.google.com/forum/#!msg/sim1/gLlzWeXGFr8/KevXinUXfc8J
>
> Signed-off-by: Andreas Koop <andreas.koop@zf.com>
> [shihpo: rebase this on v5.3-rc1]
> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>

Wow, that was an old bug that needed to be fixed! Thanks for re-posting!

I have applied this for fixes and by adding a stable tag! I also
decided to keep Andreas as the author as it seems like the code is
very similar to its original. I also cleanup up the changelog, but
just a little bit.

Kind regards
Uffe


>
> Cc: Andreas Koop <andreas.koop@zf.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  drivers/mmc/core/queue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index e327f80..7102e2e 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -10,6 +10,7 @@
>  #include <linux/kthread.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/backing-dev.h>
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -427,6 +428,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>                 goto free_tag_set;
>         }
>
> +       if (mmc_host_is_spi(host) && host->use_spi_crc)
> +               mq->queue->backing_dev_info->capabilities |=
> +                       BDI_CAP_STABLE_WRITES;
> +
>         mq->queue->queuedata = mq;
>         blk_queue_rq_timeout(mq->queue, 60 * HZ);
>
> --
> 2.7.4
>
