Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187CDE1AEA
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbfJWMkh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Oct 2019 08:40:37 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34968 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390207AbfJWMkg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2019 08:40:36 -0400
Received: by mail-vk1-f193.google.com with SMTP id d66so4387233vka.2
        for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2019 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td+5v62luaK17DIKgu/9K0KKwUeMkYA5SFVZr/oyThI=;
        b=yXA4ZIexYjDv6xjTogTSzL8qNIBnICOTejFxIsogplkGY9rZZvlKxfrQ1tvWD09wAH
         zK2fdhfb49NQoXmU/h8XnJpCgMBUXBjMJEvV+vO/9dZN1H9dkB4jiOEt07JTilW1f1Mx
         S08afyvRCC9QHTSKc/VUC1CSktyW+k6JdBG89PjfGips8PwWkcOndXlq5V33J3shwcyB
         LlkTk138Vl3tPSAtrv/wawbqbF4Szj4thndqDvbfx5lsFofsRx+70QGGLqbcbBMCU/V4
         nFk3esz9zSvRkQNI4VgPcvnumXSjsjXRB8Xb6d16tnFudr+OhKLHGlzul54qt0NMKH/g
         IDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td+5v62luaK17DIKgu/9K0KKwUeMkYA5SFVZr/oyThI=;
        b=nPpwhBXEoTCGsZ/YjiUPaascyhB78EwaZFx+Am7Loit2mCSCLdmVb/6kvm4Jp7JiXe
         P5bA8+bn1A02G/COhCBenVbnTlgUpTXTEkgFbkPxmGzSNRl63ZhKxZG4ZMjQjJeaPziX
         ODStVfZTbfRwFNl2nzQmU2Wl4Jjj48hpmbiecKI4lM//4ZNJw1RjUDtNfO9ktF4Kt670
         impOWqWRi9GkpTUw49FAZv8qKIfK/afHAZoR4mLpxim83TuROo4S4x+dOhtQqLtiZtA6
         ZLY19rln/8KFGvwqhonTqONT//HYPItRYxatp33HcjlAx52ScD4wonFL/htQqwZ9iCSb
         +1SQ==
X-Gm-Message-State: APjAAAVjd4twpn9P2RSU+k60OhSfJuMOamz6CCBfM1awa4ah4VE+BGjI
        dVyoQ3Hq86d2Otxao2z5r8jk6c41l8/Sqcpr+lQxxw==
X-Google-Smtp-Source: APXvYqyUEbyxZWyaXWyV5JPcNuCh0d7/ckbTtrpa/6d+Zxyq4SYJk8fsTgLhUdZwfCES2l0zOc254VMD7BJwF8ToAv8=
X-Received: by 2002:a1f:ae0a:: with SMTP id x10mr5154470vke.25.1571834435305;
 Wed, 23 Oct 2019 05:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Oct 2019 14:39:57 +0200
Message-ID: <CAPDyKFq7_Obp2Qc2iZDC4wCokMt9-ttuZ0A8A1CYR+b4=JbqOw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: remove unused variable
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Oct 2019 at 15:00, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> The use of 'status' was removed but the variable itself was not
> removed and thus adding a build warning.
>
> Fixes: 05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

This has already been taken care of, by amending the original patch.
Thanks anyway!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ee1fd7df4ec8..95b41c0891d0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -497,7 +497,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct scatterlist sg;
>         int err;
>         unsigned int target_part;
> -       u32 status = 0;
>
>         if (!card || !md || !idata)
>                 return -EINVAL;
> --
> 2.11.0
>
