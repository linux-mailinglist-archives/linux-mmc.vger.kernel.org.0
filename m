Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD94DE7C3
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJUJRX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 05:17:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38382 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUJRV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 05:17:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so11955308wmi.3
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fyXVzNh3bAaYBk42fBdJzICclG09jxX+kSBbHAatABk=;
        b=p4S4M34gvq7oiAB7J7289QTGzutBGVytHXmZcMwYdJALNOpROj/preCC22gLSwW5TA
         SZs3A+KB5ZLSMPlDwl+QqnbvsdWVWFULUMjp9tYBU0MwSYNvYf9UUTMNbRmzMM1EnayT
         578LwJ+f5/z6e/UV0xFr1Tgnd3uik7trySc2j5I4N0yn8wCA9nzqA/oR4CQk7UXXjaTP
         +VKoQ4TUgX0iNs0XTVtH+X7HcNzxcButh2wy1rSmARSZmcuZm14bzgbx8Vq7CvY2qMMX
         f/lEMkuP1Evq6gn2STPlsSqrhq3BURnK3x9rCVJ2tO/KCFF3HQ/jv3lr8L34ooUyPPHi
         u5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fyXVzNh3bAaYBk42fBdJzICclG09jxX+kSBbHAatABk=;
        b=NJWkDhgEru41K+3R5kiKpgWkukJdzIR0A7QneH0AlultpfyCz8+TRF1k+SU3P+S6Rf
         YVicjNKF4UE86KgVFab4jaaNZBaeBNBizfZTbS8CRDQcBCAyIDoPjcRtfMjbYiX4KZj/
         RuzIgSXmy0rCOd6DuxgKxX5u84GiScUGi+s7n1JkzpUQKhs1SHOBEbiu/w42r6AM7SmB
         arcJeXrtYw8N+25YT3q7u7hv9N+oEYgIBI8HdMg3ZHBc9Nuxb7W79qcMRKRBdBLhN5eZ
         oKQ+pdlHu0HFnmTM2RfZonGH4eKA+Hveqitzwmg+/Q8Skcr5GswUR5UD8q+Eo5tW9YN2
         zOlQ==
X-Gm-Message-State: APjAAAV/mjj3DZrcbwBfwGg1DbwBn6z9gFSEU7m7fcJYQEwCuWPLCldM
        k6mcj89m3KHQdIjAGOp+TvB37Q==
X-Google-Smtp-Source: APXvYqw+pd4xa5lgOL/v6WOYLZfNpXm5PjaGaVCXIE4K2rWe5kR78a5m76bsxJwfBU9kEbLI6J5SiA==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr19199540wmh.116.1571649437343;
        Mon, 21 Oct 2019 02:17:17 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f6sm13170666wrm.61.2019.10.21.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:17:16 -0700 (PDT)
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com> <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nan Li <nan.li@amlogic.com>, linux-amlogic@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
In-reply-to: <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
Date:   Mon, 21 Oct 2019 11:17:15 +0200
Message-ID: <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Mon 21 Oct 2019 at 09:57, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>
> Thanks for the fix.
>
> First, you should add "mmc: meson-gx:" in the subject.
>
> On 21/10/2019 07:59, Jianxin Pan wrote:
>> From: Nan Li <nan.li@amlogic.com>
>> 
>> In MMC dma transfer, the region requested by dma_map_sg() may be released
>> by dma_unmap_sg() before the transfer is completed.
>> 
>> Put the unmap operation in front of mmc_request_done() to avoid this.
>

Since we have seen this problem (yet), could you briefly how you've
triggered it ?

>
> You should add a "Fixes:" tag so it can be backported on stable kernels.
>
>> 
>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index e712315..7667e8a 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -173,6 +173,7 @@ struct meson_host {
>>  	int irq;
>>  
>>  	bool vqmmc_enabled;
>> +	bool needs_pre_post_req;
>>  };
>>  
>>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
>> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>>  	struct meson_host *host = mmc_priv(mmc);
>>  
>>  	host->cmd = NULL;
>> +	if (host->needs_pre_post_req)
>> +		meson_mmc_post_req(mmc, mrq, 0);
>>  	mmc_request_done(host->mmc, mrq);
>>  }
>>  
>> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>  {
>>  	struct meson_host *host = mmc_priv(mmc);
>> -	bool needs_pre_post_req = mrq->data &&
>> +
>> +	host->needs_pre_post_req = mrq->data &&
>>  			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>>  
>> -	if (needs_pre_post_req) {
>> +	if (host->needs_pre_post_req) {
>>  		meson_mmc_get_transfer_mode(mmc, mrq);
>>  		if (!meson_mmc_desc_chain_mode(mrq->data))
>> -			needs_pre_post_req = false;
>> +			host->needs_pre_post_req = false;
>>  	}
>>  
>> -	if (needs_pre_post_req)
>> +	if (host->needs_pre_post_req)
>>  		meson_mmc_pre_req(mmc, mrq);
>>  
>>  	/* Stop execution */
>>  	writel(0, host->regs + SD_EMMC_START);
>>  
>>  	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
>> -
>> -	if (needs_pre_post_req)
>> -		meson_mmc_post_req(mmc, mrq, 0);
>>  }

The code around all this is getting quite difficult to follow eventhough
it does not actually do much

The root of the problem seems be that meson_mmc_pre_req() and
meson_mmc_post_req() are passed to framework but also called manually
from meson_mmc_request().

Because of this, some code is added to make sure we don't do things twice.
Maybe I'm missing something but it look weird ? Ulf, could you give us
your view ?

As far as I can tell:
 * pre_req : determine if we use CHAIN_MODE or not AND
             dma_map_sg() if we do
 * post_req : dma_unmap_sg() if previously allocated

Do we really need to do all this meson_mmc_request() ? Shouldn't we let the
framework do the calls to pre/post_req for us ?

>>  
>>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>>
> Neil

