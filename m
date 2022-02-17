Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F844BA495
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Feb 2022 16:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiBQPkJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Feb 2022 10:40:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiBQPkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:40:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4932B2E14
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m14so5282lfu.4
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2cIkQoSyV/uoYmrp2FFR+PMJsIjwxkMBhA2ESiWt/c=;
        b=irgKRKkZ9T7jN+IYDnE3HbB0ZKFJSvwHktgqtGHXqrNvrXiBqXAtZ4fRvHLfPiTrJh
         AqNdJVAnnp4ODJx58Fm4PjIeEbuBMT7hPJlDdT77elMGp/zpfNgcwWaJNa8PgqTOKNRW
         7l7b5G3XD9p4n3lbnn1b4jLZ/KH0qtJX+Af8VpbJ+sCB6srjQqWp1P04vYYwpdU962xz
         MGwmsQkClNOs6sqCeYuDT9kRQZQ3CxViKt1kQjH8JWbhxQCnl39gYbLLNkTUfp/zq6gq
         GmY/jOpAJKMTDII4B1hnKosm7sn2jk1IAQeeOXkBcc3PwHm51epFQiu0AqjlgxOZAH4H
         EtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2cIkQoSyV/uoYmrp2FFR+PMJsIjwxkMBhA2ESiWt/c=;
        b=YOlOQRtvL8V8Y2qplYYwhQg/3a283jKOlfftib5Soe/kiOkZQP3iopyppLClYFEwiV
         F8KW54TdVx2ReTGq7thQxW01OuBMWaOzS50rnzc8IUrIA40koCV72I1a6LS0cnSDirXp
         yjshR75l1WWAT7xqvLUDzcnkI4H0Ra9C29TkAbtDbUEJq7nFkdyw8lI6SyB3aztf9ofH
         /lrzYI+jkwvBFAtBX+2U27BwtU2WksiZ6f2hOmdwiewDqZMXcGSvZJt6+ZiAZK3l75vE
         R8vFud/l99Vn0s+Zc/QMSDlsuJ0PshtLOsUGONA4A0wDbrNwXCPvi8lUoN75GmzgSNX6
         HrTQ==
X-Gm-Message-State: AOAM532jFm1WhmRDve8LP2ExzZzL9im0NEwppMQnfJDRfYMjjy1gczLW
        70AX0yIV7HHhL6ELzT9pVkiT2qym6/KeKrD+WjP0hw==
X-Google-Smtp-Source: ABdhPJxySvao13bawbL/6voEBW6OIbyLML55whQqeuxe5in4ddY/RXXRus+yOhL0IM7O4ZRy9PMY9ZEzeviBoYjSv4A=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr2419922lfj.254.1645112392017; Thu, 17
 Feb 2022 07:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-30-yury.norov@gmail.com>
In-Reply-To: <20220210224933.379149-30-yury.norov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:15 +0100
Message-ID: <CAPDyKFqvYhPTenGEH=LZyJXb5rJKbyeds4rH+aRN=u6JH_eJ5A@mail.gmail.com>
Subject: Re: [PATCH 29/49] memstick: replace bitmap_weight with
 bitmap_weight_eq where appropriate
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <david.laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org,
        Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Feb 2022 at 00:55, Yury Norov <yury.norov@gmail.com> wrote:
>
> msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
> weight of bitmap with a given number. We can do it more efficiently with
> bitmap_weight_eq because conditional bitmap_weight may stop traversing the
> bitmap earlier, as soon as condition is (or can't be) met.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Shubhankar Kuranagatti <shubhankar.vk@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 0cda6c6baefc..5cdd987e78f7 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -155,8 +155,8 @@ static int msb_validate_used_block_bitmap(struct msb_data *msb)
>         for (i = 0; i < msb->zone_count; i++)
>                 total_free_blocks += msb->free_block_count[i];
>
> -       if (msb->block_count - bitmap_weight(msb->used_blocks_bitmap,
> -                                       msb->block_count) == total_free_blocks)
> +       if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
> +                               msb->block_count - total_free_blocks))
>                 return 0;
>
>         pr_err("BUG: free block counts don't match the bitmap");
> --
> 2.32.0
>
