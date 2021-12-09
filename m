Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93846E62A
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Dec 2021 11:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLIKJ5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Dec 2021 05:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhLIKJz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2021 05:09:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1110C061746
        for <linux-mmc@vger.kernel.org>; Thu,  9 Dec 2021 02:06:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z8so8134045ljz.9
        for <linux-mmc@vger.kernel.org>; Thu, 09 Dec 2021 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lFATsequWOiCgnpZ4p/6BBWla14PJU5Wf+t9BaVSeE=;
        b=D8Gx/46XuC+G4SdL3UPnzw5BJbgf55Qxd5JmtotiY1ynfDNb8RtTnulE65G9a6uho+
         NhC+AXr42MKR8uh/is+sgaXRdtZ/LChoW2Bpb836OIT2anUdS3ZqJnyGU9af/xG5Varj
         z4259F+PM/GID9nAYLcKnbZgytkDHyjp6eNha/0fRTrEkAQmuUoXDDAsAwus00otIPa7
         Dmd2W2WF+G+KgVyXPwjD6jDk21D/NcY4L/qZTKZ8dxaCxazDt9O7t2eLTPuQEtW8SJ1q
         pla4kcIbGWrlQikz2EeZy2ME21VcQmNN0vA9To2AHNHtkfbUjlI5GOgVzoUFqQAXKhOd
         CKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lFATsequWOiCgnpZ4p/6BBWla14PJU5Wf+t9BaVSeE=;
        b=GYOMKZ323FsWQZXT2uBWf7UtH8b72OUaQP5VZnYZTkBPneOW/VGA73veYDCDCTSPSj
         GintEedZ2Z5/IPEXHSvqpS//w94plfZeRAiuwL4rCXaQ52XjFs2NRHVkVCrlAlT7CDVY
         nPOM1JufyX2zhHjMfJZpUpJrq5so2hUPeFAlEMWtrx/MiM6vLCrHL0O1WrRMpXHnakWK
         kfr+mQG1HT0bAwuxfwtyMWDRf0eIUqByMGX1eZxKqPCqzlfkR2RIHzbXN6JUMe1mjboI
         X2S5djhG7EIk7CJnDaDHK+CE0HOw7EgDWWi0w74uSmLQo8npf4xVinKJGD0cUbbgxAZA
         SoyA==
X-Gm-Message-State: AOAM533lLerEiUXhOhyITOxcDS2xrvwDcVxWegVHMtpp1cahMbYv/5np
        kFuwsRUNjxmt9PeDdrVeUJ5q6saJ9yw1LQESaxtagQ==
X-Google-Smtp-Source: ABdhPJxH23WdQ4mT6uTrJq9zH7lO81XwGmaOOoonGOh9qQI9zjkuCKnUu+dh8lkJjj41ieGjwixrLVBJQTLbcM6lrTs=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr5619180ljf.300.1639044380237;
 Thu, 09 Dec 2021 02:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20211207075013.22911-1-wenbin.mei@mediatek.com>
In-Reply-To: <20211207075013.22911-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:43 +0100
Message-ID: <CAPDyKFqakV8FiQohbvh8h9UCpO14XJFDETPojSmdDUCeC1Kj8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] mmc: mediatek: free the ext_csd when
 mmc_get_ext_csd success
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Dec 2021 at 08:50, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> If mmc_get_ext_csd success, the ext_csd are not freed.
> Add the missing kfree() calls.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
> Cc: stable@vger.kernel.org

We don't need the stable tag in this case, as commit c4ac38c6539b was
introduced in v5.16-rc1. In any case, thanks for adding the fixes tag,
it certainly helps!

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 943940b44e83..632775217d35 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2291,8 +2291,10 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
>                         sdr_set_field(host->base + PAD_DS_TUNE,
>                                       PAD_DS_TUNE_DLY1, i);
>                 ret = mmc_get_ext_csd(card, &ext_csd);
> -               if (!ret)
> +               if (!ret) {
>                         result_dly1 |= (1 << i);
> +                       kfree(ext_csd);
> +               }
>         }
>         host->hs400_tuning = false;
>
> --
> 2.25.1
>
