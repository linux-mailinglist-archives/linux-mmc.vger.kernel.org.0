Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAB6B2830
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Mar 2023 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCIPFc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Mar 2023 10:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCIPEu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 10:04:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544193DA
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 07:02:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c10so1644480pfv.13
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvvFe6UE/AYXWScGr9mkG/95G71XHJDx0d83LjJ1ufA=;
        b=DGV9PtKUctpsFz094ALkkGzwPjnZ+iPH5p+KbK/pTLpKrg8EOlEs1M582z9aLqHXvG
         ZtQJJ/sqLkKIuYcoYpQeX3BedQg4/ZcO4klD/zpsNT5I5Vmu9G8p03ezEOhfsIkl8ayy
         2JvNykJW4XeO+HaR313gd2RYvIf1PMKOAPgY3b1LwBgALBJHfmm0ibPjzSp5ggchKo7b
         7KVmSzoV17NSAD6oGCJks3Yq26B4wEHMFdz/hS44vVgFQHX4wd1Ef60+yyy6JEaA+Tzv
         se2tL9KeBsdPEnhGUC1RL5hUyugCwl+9lQqiIjVrMqop7RwlhXN52pqG6sSrXbjeJEYd
         8P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvvFe6UE/AYXWScGr9mkG/95G71XHJDx0d83LjJ1ufA=;
        b=ujGdhMuOyIirH5DulfMNNkLTR8bv7rORzVgszvU1ErxevEGI8ilM003X7s/cKPVw1U
         6frNbEMkMIfyf9XxfWI8PhYehlmOhQsSFHEMYYCp+PYLnsqquGOwJR7gw16J3XJFKr8q
         skPiI4cRByLqWzTQbqtW2tClmexx7D7oTfjKWe27Hlhu31+EybhE4XjZu5kZVnLTIUtL
         KaTtyhXcQXsxXxDgS8A0bJMJaDHXXCYSjYfN3Oq1lGlO7fGWU7M5MYsyVbNoiKatd7A3
         KlfktnjJsgjANthDwegjgcLNFmjfugzoiiGjSYMNuLlqa3xOnePRag3w+gfIgRVLqXeb
         XBGg==
X-Gm-Message-State: AO0yUKXcThy/qslU2RKLJy9wvu6QoBxXKo0at/c2z72A00gDdUIa9VVP
        NKEb25iECVlH0CSgtux5WeAB4r8HMc9A10KNi7600g==
X-Google-Smtp-Source: AK7set8BvqTU8HcO89O4sLJTzLfcCTtLtR8RSfk0EY0PihdbgIh+Nawl1V6aNDZle+awq/RD+FaCggLV3wVTc0NL/pQ=
X-Received: by 2002:a63:7b4f:0:b0:503:ae1b:df3f with SMTP id
 k15-20020a637b4f000000b00503ae1bdf3fmr7927904pgn.5.1678374174636; Thu, 09 Mar
 2023 07:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20230307164338.1246287-1-zyytlz.wz@163.com>
In-Reply-To: <20230307164338.1246287-1-zyytlz.wz@163.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:18 +0100
Message-ID: <CAPDyKFoV9aZObZ5GBm0U_-UVeVkBN_rAG-kH3BKoP4EXdYM4bw@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Fix UAF bug in r592_remove due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Mar 2023 at 17:44, Zheng Wang <zyytlz.wz@163.com> wrote:
>
> In r592_probe, dev->detect_timer was bound with r592_detect_timer.
> In r592_irq function, the timer function will be invoked by mod_timer.
>
> If we remove the module which will call hantro_release to make cleanup,
> there may be a unfinished work. The possible sequence is as follows,
> which will cause a typical UAF bug.
>
> Fix it by canceling the work before cleanup in r592_remove.
>
> CPU0                  CPU1
>
>                     |r592_detect_timer
> r592_remove         |
>   memstick_free_host|
>   put_device;       |
>   kfree(host);      |
>                     |
>                     | queue_work
>                     |   &host->media_checker //use
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 1d35d147552d..2bfa7eaae80a 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
>         /* Stop the processing thread.
>         That ensures that we won't take any more requests */
>         kthread_stop(dev->io_thread);
> -
> +       del_timer_sync(&dev->detect_timer);
>         r592_enable_device(dev, false);
>
>         while (!error && dev->req) {
> --
> 2.25.1
>
