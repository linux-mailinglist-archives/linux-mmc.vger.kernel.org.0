Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5232A1A033
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEJP3O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 11:29:14 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:1275 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfEJP3O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 May 2019 11:29:14 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 745592036B;
        Fri, 10 May 2019 17:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1557502148; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7rUq6g66N4nwvS2jevP/8cgut3AdGljfT53km0/eVU=;
        b=hESCG5HKqL5ZcIzqa286iClzPM4jW3UHOzILA4ki4vQ+BMfSgDcXMQDH/WT4ys7+PCYy/V
        y6yITjEnBRCQBfkj0r9hivY2u+vnDuMCZXTo8fvNShOCNyOOoVlDAKqS/sGtBzM3VhJjuE
        kiQgcvlbgey9ogS0Q5rk5HcC0K6ensvZFzuFZW7jBxq/JGY5BfE5aeF+6ZWJt7VED55qnh
        v/SgXbEgbTNtl8siy+nDe2zuZ8/ty/bx4af2xS/wDRr9POEyVz8veE90SHrpCxshrYehV3
        7KWBvJj/PKthKbslcK44uRWBG9Ke+PfBkD4haZGxjYi5MKqMJdaFgo7qmFmgLQ==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id DF9C7BEEBD;
        Fri, 10 May 2019 17:29:07 +0200 (CEST)
Message-ID: <5CD598C3.9090003@bfs.de>
Date:   Fri, 10 May 2019 17:29:07 +0200
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
References: <20190510112440.GA22858@mwanda> <5CD57891.9000505@bfs.de> <20190510132347.GH16030@kadam>
In-Reply-To: <20190510132347.GH16030@kadam>
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



Am 10.05.2019 15:23, schrieb Dan Carpenter:
> On Fri, May 10, 2019 at 03:11:45PM +0200, walter harms wrote:
>> If i see this correcly everybody leaving the loop making the function return something.
>> I do not know how would do that but IMHO is better to be defensive and end the function
>> with a propper return code (perhaps 0).
>>
> 
> It's a forever loop.  If we add another break statement without adding
> at return then GCC will complain.
> 
> I feel like maybe you're saying that you don't like forever loops?  That
> becomes a pretty complicated position to take...
> 

No, not really,
but after several years of programming i have learned that forever() is never
forever and a break statement is easily added (in future).

Also it also looks strange to have a function returning int but the last thing
is not returning something.

just my 2 cents,

re,
 wh

ps: you could easily do
 	memstick_new_req(card->host);
  	break;
  }
return 0;

