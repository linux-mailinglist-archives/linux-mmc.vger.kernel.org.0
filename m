Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA49279E
	for <lists+linux-mmc@lfdr.de>; Mon, 19 Aug 2019 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfHSOxt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 19 Aug 2019 10:53:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36944 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSOxs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2019 10:53:48 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so4885843iog.4
        for <linux-mmc@vger.kernel.org>; Mon, 19 Aug 2019 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
        b=Mb8tCh2bLsjeTjXBHqs0/cQN56crbWNd/Q8xr/pSttNKCouz6ipVyNQ0+eAAUwy4Fg
         s1np2ZTCFqN3neFZsTIeSJtxhAFbC+5XA8RAZAyolGlsOmTH9S3LITyl9eoPOssO0lnJ
         kpUpE6ip013rwPiNw2Bu9nefooFjpQS3wtXUPgNduuc2sBF0o7NXM475JBSCWstwU8k5
         NwYY4rZpqmg8nJv9ipS2IGWDJSJR8UJB890KZ+Cc3lRgtwo0iih8BhCEn4xhGKW+ZdAf
         ZDEUK9HPlh4Ub0yDU+XPxaEGu1+idYMNf2bT2tJijA6R6pwJ+0sV/oek3N7RrhW3k4HF
         tdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
        b=RWYHBzzgH04NX/AAY54S+f/0sJ3wKW2ydq69Lz2oA36IUqbYqYIbObmWe9WtJ7UlGL
         vsvETNcTKf9WUhxKa07Ipwo0gjXrYMHPfTSyshtV0ATILr5gK6Mm0J4pxZpQ75OG0AHf
         WMbf5Wvp8CxyrAX1MS0vzEbJ4+v7eqBkeeFXJGqgytEMhct6tcvPcB39pXWgpHB8iJkF
         nzr6fM7BkPUB7HgCoiPhYkAl8HTGOefK7h7smwQlZvBY8H7BF6ZCfArtNu3APaDXDExq
         uzAbMk6IXxQr9DYSkm7AsTQ984N9imNACatOvVJegpcqZuOd8fH2hSjNM8k8xsBTuRK5
         fV4w==
X-Gm-Message-State: APjAAAXxn+p9gWxeiCTGmqiIobgBsxGaLItb9JSf6HMkM1roxfeH5MOT
        5a3BfGE7aDX4LXcZBIWHLRvOqQ==
X-Google-Smtp-Source: APXvYqww0IFLngqPqM7W6572CFxzF909pM0goodpc31llb6Yt4oi/F2OvBrkbuK/8LN1xVz/+eRMdQ==
X-Received: by 2002:a02:952d:: with SMTP id y42mr15298473jah.66.1566226427998;
        Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Received: from ?IPv6:2603:3026:406:3000:70aa:6052:7aba:c7b? ([2603:3026:406:3000:70aa:6052:7aba:c7b])
        by smtp.gmail.com with ESMTPSA id o3sm13893887ioo.74.2019.08.19.07.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
To:     Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190816195026.GC6886@kunai>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
Date:   Mon, 19 Aug 2019 08:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816195026.GC6886@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/16/19 1:50 PM, Wolfram Sang wrote:
> On Fri, Jul 26, 2019 at 05:31:14PM +0900, Yoshihiro Shimoda wrote:
>> This patch sorts the headers in alphabetic order to ease
>> the maintenance for this part.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
> 
> Jens, can we have your ack for this patch so Christoph can take this
> series via his tree (also for patch 4/5)?

Please just drop this patch.

-- 
Jens Axboe

