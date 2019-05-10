Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8119E05
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfEJNWC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 09:22:02 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:45441 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfEJNWC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 May 2019 09:22:02 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2019 09:22:01 EDT
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id B7B7A20342;
        Fri, 10 May 2019 15:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1557493907; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8mkVOrIh7/aBHtVmfeDdU8eJLE9TnXkEAPM4bfj3zA=;
        b=H/R/A2fGR09r1tlb0a4+pfOga+5b91KX6/LHrhVDlpJCY3eNLBD7ZmXQ8APR5HfWuuvXMl
        EaraOpMZ/VjNjRELCoEbnkcpiEUvJwk/Vke+4eFw4c7tzTerkycceLBqRuYrBJMj9GYgc0
        l/kK7EW10P8AwUSCGhYkZ4/QFND+7HJeDPrdZNYA8sIP6HftcWwyzsEUbBgHJiGYjQt23K
        dLIJLvxvOOh27UV0hrDky3Ckw+i3U0GEF4qv6F2MM1+fdfTN5rc1v8E/BqdFLMNotqG++D
        IsDeRGUjWZEOz465LGjl2TVSsnR0lwLEi1P4CcpN9HJRAy2aBa8D/vSf4k5Hrg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id E2527BEEBD;
        Fri, 10 May 2019 15:11:46 +0200 (CEST)
Message-ID: <5CD57891.9000505@bfs.de>
Date:   Fri, 10 May 2019 15:11:45 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mspro_block: Fix an error code in mspro_block_issue_req()
References: <20190510112440.GA22858@mwanda>
In-Reply-To: <20190510112440.GA22858@mwanda>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.10
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         RCVD_COUNT_TWO(0.00)[2]
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Am 10.05.2019 13:24, schrieb Dan Carpenter:
> We accidentally changed the error code from -EAGAIN to 1 when we did the
> blk-mq conversion.
> 
> Maybe a contributing factor to this mistake is that it wasn't obvious
> that the "while (chunk) {" condition is always true.  I have cleaned
> that up as well.
> 
> Fixes: d0be12274dad ("mspro_block: convert to blk-mq")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/memstick/core/mspro_block.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index aba50ec98b4d..9fc22c755dbf 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -694,13 +694,13 @@ static void h_mspro_block_setup_cmd(struct memstick_dev *card, u64 offset,
>  
>  /*** Data transfer ***/
>  
> -static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
> +static int mspro_block_issue_req(struct memstick_dev *card)
>  {
>  	struct mspro_block_data *msb = memstick_get_drvdata(card);
>  	u64 t_off;
>  	unsigned int count;
>  
> -	while (chunk) {
> +	while (true) {
>  		msb->current_page = 0;
>  		msb->current_seg = 0;
>  		msb->seg_count = blk_rq_map_sg(msb->block_req->q,
> @@ -709,6 +709,7 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
>  
>  		if (!msb->seg_count) {
>  			unsigned int bytes = blk_rq_cur_bytes(msb->block_req);
> +			bool chunk;
>  
>  			chunk = blk_update_request(msb->block_req,
>  							BLK_STS_RESOURCE,
> @@ -718,7 +719,7 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
>  			__blk_mq_end_request(msb->block_req,
>  						BLK_STS_RESOURCE);
>  			msb->block_req = NULL;
> -			break;
> +			return -EAGAIN;
>  		}
>  
>  		t_off = blk_rq_pos(msb->block_req);
> @@ -735,8 +736,6 @@ static int mspro_block_issue_req(struct memstick_dev *card, bool chunk)
>  		memstick_new_req(card->host);
>  		return 0;
>  	}
> -
> -	return 1;
>  }
>  

If i see this correcly everybody leaving the loop making the function return something.
I do not know how would do that but IMHO is better to be defensive and end the function
with a propper return code (perhaps 0).

re,
 wh


>  static int mspro_block_complete_req(struct memstick_dev *card, int error)
> @@ -779,7 +778,7 @@ static int mspro_block_complete_req(struct memstick_dev *card, int error)
>  		chunk = blk_update_request(msb->block_req,
>  				errno_to_blk_status(error), t_len);
>  		if (chunk) {
> -			error = mspro_block_issue_req(card, chunk);
> +			error = mspro_block_issue_req(card);
>  			if (!error)
>  				goto out;
>  		} else {
> @@ -849,7 +848,7 @@ static blk_status_t mspro_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	msb->block_req = bd->rq;
>  	blk_mq_start_request(bd->rq);
>  
> -	if (mspro_block_issue_req(card, true))
> +	if (mspro_block_issue_req(card))
>  		msb->block_req = NULL;
>  
>  	spin_unlock_irq(&msb->q_lock);
