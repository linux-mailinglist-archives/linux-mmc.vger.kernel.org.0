Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917067FD5B
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfHBPRI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 11:17:08 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36442 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbfHBPRI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 11:17:08 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so51495636vsc.3
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuKMc11aWlktrZ8JPjVIWHFW0kEI8OzLwNyEg414joM=;
        b=o/xWXyttxwnPZpGymJWMS3zDGLO7EwAzJgRTM+KqPtjJUnnKd01izY+MaTd/lp1dcp
         bYCbiOGY++yFYhqvEebeYSIQea08lgFytSJTxKrySFCUMIHpuqPSBwWsfWh5W+Ur7QnM
         IItqtYXXR0fF2n/1s8X6BFXzkm472oDd42VSJ+Rm0ovVAZsAgp/RyXVXnFYd8P22iXue
         pK+YMrI074FTb0czvfi5+VIYJzFCpYKNQUupdeKVc1r858KCFzWpficrf7K+c0thc12Q
         eTmSvZOhfdn7fthl05gNuSBTK2BpHRWxN0NIg6gAaZRB7ddUJq+0s4XqMBpgooW05M3d
         syCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuKMc11aWlktrZ8JPjVIWHFW0kEI8OzLwNyEg414joM=;
        b=blptJW5OX80608mSVBdl3+LGtvLekj6ZY/4sntgbOPD0ixsTOQxNORiOLedm2yxZv0
         8IqP2ehZi2SzGsCldb/MKa0UKFbP0IxWbN7uIYZiha2n2ojfh+P3/6w6NwXdBDiYT5ML
         q/RWwrpCtewlgezwt7qo9ya8Zwmq0fW8e2J4JQJdigCmfpHSmq08k+d/Cn6ZIvppWR8N
         psrd0fsOZNWTLDYimjX+fhPspOKMjAm41/5sKFQz4c54KEaK3uC69qSrlwknOftMuHLv
         fc5WmZBQ/CkeSadW1tv1ltcMFT1xCatJaV75Swm1NtkH9MNwlebXZxgCfI9S5kRk6Bvh
         FW3g==
X-Gm-Message-State: APjAAAVugb7Fl/dX04P9/hgOEmgJgjHUOrNzmo0FDxFvznPtWjRrO/vr
        7EyjZLqN0Z2bLVA6yhXIWgHm/DWJXDsw5JFdkVxWJg==
X-Google-Smtp-Source: APXvYqxuUZhyZ/2jBLSyhZvTnT+wvu+urb28okrpgWr1w0OmPEyWiupD06g3qkKPD8Ih4kcC2uLGp1RbOOoij59X8to=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr35444838vsb.165.1564759027394;
 Fri, 02 Aug 2019 08:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190726023049.27055-1-haokexin@gmail.com> <20190726023049.27055-3-haokexin@gmail.com>
In-Reply-To: <20190726023049.27055-3-haokexin@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:30 +0200
Message-ID: <CAPDyKFpwNao5_18XyYr=UH=WN4Y8MCjZ61NNwhqNKfAx0D7C+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: cavium: Add the missing dma unmap when the dma
 has finished.
To:     Kevin Hao <haokexin@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Jul 2019 at 04:32, Kevin Hao <haokexin@gmail.com> wrote:
>
> This fixes the below calltrace when the CONFIG_DMA_API_DEBUG is enabled.
>   DMA-API: thunderx_mmc 0000:01:01.4: cpu touching an active dma mapped cacheline [cln=0x000000002fdf9800]
>   WARNING: CPU: 21 PID: 1 at kernel/dma/debug.c:596 debug_dma_assert_idle+0x1f8/0x270
>   Modules linked in:
>   CPU: 21 PID: 1 Comm: init Not tainted 5.3.0-rc1-next-20190725-yocto-standard+ #64
>   Hardware name: Marvell OcteonTX CN96XX board (DT)
>   pstate: 80400009 (Nzcv daif +PAN -UAO)
>   pc : debug_dma_assert_idle+0x1f8/0x270
>   lr : debug_dma_assert_idle+0x1f8/0x270
>   sp : ffff0000113cfc10
>   x29: ffff0000113cfc10 x28: 0000ffff8c880000
>   x27: ffff800bc72a0000 x26: ffff000010ff8000
>   x25: ffff000010ff8940 x24: ffff000010ff8968
>   x23: 0000000000000000 x22: ffff000010e83700
>   x21: ffff000010ea2000 x20: ffff000010e835c8
>   x19: ffff800bc2c73300 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: ffff000010e835c8 x14: 6d20616d64206576
>   x13: 69746361206e6120 x12: 676e696863756f74
>   x11: 20757063203a342e x10: 31303a31303a3030
>   x9 : 303020636d6d5f78 x8 : 3230303030303030
>   x7 : 00000000000002fd x6 : ffff000010fd57d0
>   x5 : 0000000000000000 x4 : ffff0000106c5210
>   x3 : 00000000ffffffff x2 : 0000800bee9c0000
>   x1 : 57d5843f4aa62800 x0 : 0000000000000000
>   Call trace:
>    debug_dma_assert_idle+0x1f8/0x270
>    wp_page_copy+0xb0/0x688
>    do_wp_page+0xa8/0x5b8
>    __handle_mm_fault+0x600/0xd00
>    handle_mm_fault+0x118/0x1e8
>    do_page_fault+0x200/0x500
>    do_mem_abort+0x50/0xb0
>    el0_da+0x20/0x24
>   ---[ end trace a005534bd23e109f ]---
>   DMA-API: Mapped at:
>    debug_dma_map_sg+0x94/0x350
>    cvm_mmc_request+0x3c4/0x988
>    __mmc_start_request+0x9c/0x1f8
>    mmc_start_request+0x7c/0xb0
>    mmc_blk_mq_issue_rq+0x5c4/0x7b8
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied for fixes and by adding a stable/fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index c956813bc6bd..89deb451e0ac 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -374,6 +374,7 @@ static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
>  {
>         data->bytes_xfered = data->blocks * data->blksz;
>         data->error = 0;
> +       dma_unmap_sg(host->dev, data->sg, data->sg_len, get_dma_dir(data));
>         return 1;
>  }
>
> --
> 2.14.4
>
