Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8017FD5A
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbfHBPRF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 11:17:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34502 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbfHBPRE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 11:17:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id m23so51566897vso.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34SlPPsqBpanmFxkGehpmSHJPHcE8gkzW7/L1usR8Mg=;
        b=fyWQfNOr/zOX2AH5ARyrGt309xXLzfiejVWgpcGx95JMGuCSg43otK7e2/sG9yvhyZ
         sDS7t6Ae0peeqA5rdahPkx+BzSVm0giCK0reVt2eyW57feiWIN7y3WPVg2SIvdMYvCBo
         nt2zO4rslpAd4HsQZu0cLrJngSlYPCVZuuaX/BQRNUs5BpyWM5gyioW1Cs+fVIoKk77m
         2DKVw73IPEHXDT4f5KSFSlI7yxAJg1+Qbj9j4hOQLpzueYrcFM//XmB0opVwRguRC8e9
         j/mRcptGBe8TPvWJajQPV1+gIucb7Wao/KxocZQfReiJzGeiG/1Tu0+MSsdiXO2aYOKl
         b0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34SlPPsqBpanmFxkGehpmSHJPHcE8gkzW7/L1usR8Mg=;
        b=N2GUo+FGRhCAojqx7THIR43TvynhmZL4L8UTHgY92SN97F3Xdmm+SmPCp7XAjAV49u
         L1UDbimgHrPgBdXgb5/rYPcMUh82x8/wsMonlFE9iusD7woOzTZesw6ZO1fqVFsuOuMX
         nCgBlzqMoU6kKz78rMf+HH62UDVag65KYYZXnbreIcbs6lr7hK7V124ZZee9SPiid9S1
         QlQ4ZdgqDoEb5FOxwNnqTnWNFfc0PELHZDY1yGGdNmhg1ouooMhcTSe42J1qxDxaNhFF
         mG2iWh3OcHKScWQ8t+a052BXZPWzElGY+xIiZp4vliJLo7EyBSKX0lVCotHC+kbW9rca
         kpDw==
X-Gm-Message-State: APjAAAUk2HZvqICHhmC2EaC43y4/h3HRCW6d6MISFA7nRMSUb+2b8HzC
        1uRmYUD0hfL7PEMw5u3FAY2sxxXgD7GUVqCWUytdgA==
X-Google-Smtp-Source: APXvYqw5CGsIm7IsBQ3dHk5ULqjPy3RW5jcQQZi4L0GFZz41fZp52oXFU+e0og/yYorfLeZpHphSr/BtbXAqDMRRNsk=
X-Received: by 2002:a67:e454:: with SMTP id n20mr88737744vsm.34.1564759023739;
 Fri, 02 Aug 2019 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190726023049.27055-1-haokexin@gmail.com> <20190726023049.27055-2-haokexin@gmail.com>
In-Reply-To: <20190726023049.27055-2-haokexin@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:27 +0200
Message-ID: <CAPDyKFq+PFVdABNV6iMbAtPGrxrc+DjyQB1M-wHvnvZ-cFtkpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cavium: Set the correct dma max segment size for mmc_host
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
> We have set the mmc_host.max_seg_size to 8M, but the dma max segment
> size of PCI device is set to 64K by default in function pci_device_add().
> The mmc_host.max_seg_size is used to set the max segment size of
> the blk queue. Then this mismatch will trigger a calltrace like below
> when a bigger than 64K segment request arrives at mmc dev. So we should
> consider the limitation of the cvm_mmc_host when setting the
> mmc_host.max_seg_size.
>   DMA-API: thunderx_mmc 0000:01:01.4: mapping sg segment longer than device claims to support [len=131072] [max=65536]
>   WARNING: CPU: 6 PID: 238 at kernel/dma/debug.c:1221 debug_dma_map_sg+0x2b8/0x350
>   Modules linked in:
>   CPU: 6 PID: 238 Comm: kworker/6:1H Not tainted 5.3.0-rc1-next-20190724-yocto-standard+ #62
>   Hardware name: Marvell OcteonTX CN96XX board (DT)
>   Workqueue: kblockd blk_mq_run_work_fn
>   pstate: 80c00009 (Nzcv daif +PAN +UAO)
>   pc : debug_dma_map_sg+0x2b8/0x350
>   lr : debug_dma_map_sg+0x2b8/0x350
>   sp : ffff00001770f9e0
>   x29: ffff00001770f9e0 x28: ffffffff00000000
>   x27: 00000000ffffffff x26: ffff800bc2c73180
>   x25: ffff000010e83700 x24: 0000000000000002
>   x23: 0000000000000001 x22: 0000000000000001
>   x21: 0000000000000000 x20: ffff800bc48ba0b0
>   x19: ffff800bc97e8c00 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: ffff000010e835c8 x14: 6874207265676e6f
>   x13: 6c20746e656d6765 x12: 7320677320676e69
>   x11: 7070616d203a342e x10: 31303a31303a3030
>   x9 : 303020636d6d5f78 x8 : 35363d78616d5b20
>   x7 : 00000000000002fd x6 : ffff000010fd57dc
>   x5 : 0000000000000000 x4 : ffff0000106c61f0
>   x3 : 00000000ffffffff x2 : 0000800bee060000
>   x1 : 7010678df3041a00 x0 : 0000000000000000
>   Call trace:
>    debug_dma_map_sg+0x2b8/0x350
>    cvm_mmc_request+0x3c4/0x988
>    __mmc_start_request+0x9c/0x1f8
>    mmc_start_request+0x7c/0xb0
>    mmc_blk_mq_issue_rq+0x5c4/0x7b8
>    mmc_mq_queue_rq+0x11c/0x278
>    blk_mq_dispatch_rq_list+0xb0/0x568
>    blk_mq_do_dispatch_sched+0x6c/0x108
>    blk_mq_sched_dispatch_requests+0x110/0x1b8
>    __blk_mq_run_hw_queue+0xb0/0x118
>    blk_mq_run_work_fn+0x28/0x38
>    process_one_work+0x210/0x490
>    worker_thread+0x48/0x458
>    kthread+0x130/0x138
>    ret_from_fork+0x10/0x1c
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied for fixes and by adding a stable/fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index ed5cefb83768..c956813bc6bd 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -1046,7 +1046,8 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
>                 mmc->max_segs = 1;
>
>         /* DMA size field can address up to 8 MB */
> -       mmc->max_seg_size = 8 * 1024 * 1024;
> +       mmc->max_seg_size = min_t(unsigned int, 8 * 1024 * 1024,
> +                                 dma_get_max_seg_size(host->dev));
>         mmc->max_req_size = mmc->max_seg_size;
>         /* External DMA is in 512 byte blocks */
>         mmc->max_blk_size = 512;
> --
> 2.14.4
>
