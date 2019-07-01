Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E62127CB
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfECGbP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 02:31:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:23973 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECGbP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 May 2019 02:31:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 23:31:14 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2019 23:31:10 -0700
Subject: Re: [PATCH] mmc: Fix tag set memory leak
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     avri.altman@wdc.com, djkurtz@chromium.org, zwisler@chromium.org,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190502190714.181664-1-rrangel@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <681b2cba-4442-ae9a-5a3c-461c384198bd@intel.com>
Date:   Fri, 3 May 2019 09:29:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502190714.181664-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/05/19 10:07 PM, Raul E Rangel wrote:
> The tag set is allocated in mmc_init_queue but never freed. This results
> in a memory leak. This change makes sure we free the tag set when the
> queue is also freed.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

One comment below, otherwise:

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> I found this using kmemleak and plugging and unplugging an SD card in a
> few times.
> 
> Here is an example of the output of kmemleak:
> unreferenced object 0xffff888125be4ce8 (size 8):
>   comm "kworker/1:0", pid 17, jiffies 4294901575 (age 204.773s)
>   hex dump (first 8 bytes):
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<0000000061cb8887>] blk_mq_alloc_tag_set+0xe9/0x234
>     [<00000000cf532a0f>] mmc_init_queue+0xa9/0x2f0
>     [<000000001e085171>] mmc_blk_alloc_req+0x125/0x2f9
>     [<00000000eae1bd01>] mmc_blk_probe+0x1e2/0x6c1
>     [<00000000a0b4a87d>] really_probe+0x1bd/0x3b0
>     [<00000000e58f3eb9>] driver_probe_device+0xe1/0x115
>     [<00000000358f3b3c>] bus_for_each_drv+0x89/0xac
>     [<00000000ef52ccbe>] __device_attach+0xb0/0x14a
>     [<00000000c9daafa7>] bus_probe_device+0x33/0x9f
>     [<0000000008ac5779>] device_add+0x34b/0x5e2
>     [<00000000b42623cc>] mmc_add_card+0x1f5/0x20d
>     [<00000000f114ebc3>] mmc_attach_sd+0xc5/0x14b
>     [<000000006e915e0d>] mmc_rescan+0x261/0x2b6
>     [<00000000e5b49c26>] process_one_work+0x1d3/0x31f
>     [<0000000068c8cd3c>] worker_thread+0x1cd/0x2bf
>     [<00000000326e2e22>] kthread+0x14f/0x157
> 
> Once I applied this patch the leak went away.
> 
> p.s., I included a small white space fix. Hope that's ok.

Not really.  For example, the patch does not apply cleanly to stable trees
only because of that chunk.

> 
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..176a08748cf1 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -402,7 +402,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>  
>  	mq->card = card;
>  	mq->use_cqe = host->cqe_enabled;
> -	
> +
>  	spin_lock_init(&mq->lock);
>  
>  	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
> @@ -472,6 +472,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>  		blk_mq_unquiesce_queue(q);
>  
>  	blk_cleanup_queue(q);
> +	blk_mq_free_tag_set(&mq->tag_set);
>  
>  	/*
>  	 * A request can be completed before the next request, potentially
> 

