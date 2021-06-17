Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26E3AB50F
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Jun 2021 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhFQNmz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Jun 2021 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhFQNmy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2021 09:42:54 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F057C061574
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 06:40:46 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t40so6560318oiw.8
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0TvC9vxbYXD2X7fWelTsYo5dpOMlgANUi5TSU8s7OI=;
        b=oz1T+GWjdJT8uTEvVA0W3Z2PyEx0iETJxxIkiknnlbTfHtHmujaiqU24IZLATQMQbY
         9yAf06IeoLnTkFbxyvpdNuR3n0TdtoYPiLpbxciGi9NETcuMdcNKE0bDJS2/aRepSs1o
         aTxJTvtCGk607N7FmoHP2/pbBsln+w8RmZAFsFYbMrAam6PPWSFBm23zG7vi/QhpbpRA
         uLoR/LWSkvTpeuwlj7pRcwZEGneUUpkA9Is7bK/lY3+vK1n3tmSyEzpDg5fxNaSXIaik
         M3s5pqXGr9n/KMkiRC9Y2Vqlp/vIeh6zAAvTMXtXNVUmVVjcSEF1C+XvrYmW8qwBV1V/
         PZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0TvC9vxbYXD2X7fWelTsYo5dpOMlgANUi5TSU8s7OI=;
        b=lzU7+2hhmwZFPn/WsQalKfO0m2l6vEwWJQX6GjHXgwQqPTG7WTr7nUcOQa3StdTCb5
         y1OhEEyD7AeSNboeE8srF2N7LjK4hcfS2vSUbPB2MlEsNPNKx20KD67zNbA2c7kOBwSQ
         Fd2PJyL1Sw48WZjIkt6j/4xu4Jjz5ZeV0QoUHeKxldOyenk5sCIOdnhExUqUhyFx6wog
         y4LnnVcHU4V0BeEXUM8cArp/CJKFeQ9e+n24xtEItsDrOgTzcN/hqOLscf0MM5J69jow
         udff1+qpUwR/+ID8oWL8aDfZO7RTboUajS+VS+z78w8+56Epfu8wxKlmXFIk7nzmrsgT
         JBZQ==
X-Gm-Message-State: AOAM533C7L6YeakrL4xhHpgm7gAHt8Dv6WHsIzuVHGhYpplDOy0Wvizg
        3zXxejRvklJa9bm/InmiLiLdug==
X-Google-Smtp-Source: ABdhPJz3Sw7hZWVb8Px6STcaJDgfhU9hpvTpBcuB9vu9YFudVVyibHohPmpHFrx8XeUW1BKaykQ5JQ==
X-Received: by 2002:aca:b8c2:: with SMTP id i185mr10589434oif.172.1623937245688;
        Thu, 17 Jun 2021 06:40:45 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id v203sm1084418oie.52.2021.06.17.06.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:40:45 -0700 (PDT)
Subject: Re: convert the mmc driver to use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
References: <20210616053934.880951-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a669563e-468c-faf2-27a2-062ef41a863c@kernel.dk>
Date:   Thu, 17 Jun 2021 07:40:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/15/21 11:39 PM, Christoph Hellwig wrote:
> Hi Ulf,
> 
> can you take a look at this series which converts the mmc driver to the
> new blk_mq_alloc_disk interface.  It is based upon Jens' for-5.14/block
> or for-next trees.

Applied, thanks.

-- 
Jens Axboe

