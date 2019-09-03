Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609DEA6C9A
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfICPLb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 11:11:31 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42755 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICPLb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 11:11:31 -0400
Received: by mail-vk1-f194.google.com with SMTP id t136so3639548vkt.9
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=597kM3j7GMQPvL0o4gYpdI/ql7rF2tjaizbjC1K9t98=;
        b=dtjaqiYatHI8zLkjyXFRKziKxzEOaWF8lq/JNf5VCBgrOoA5kY9jkDPcA5PnEwjmwc
         7o/y3TPaKBofPlgYuSHpC83INXaIP3rKNN/2P62Fq9qDgVgg6n8fq4IAcT4nJBnzDyln
         HGErEJj0l1k/5z14iXY4Qe9U+c2hDzUIeOPou+HqSNnmHZ7eptzdacvsahovXFrQmlw5
         s4Em0nEZhE+CBuo3e5I1CCIN6WB+BMf23dLQRKpehGoCbmkUtAVQ7BEfiPbG/8goOqi4
         Vnqn7ME0PQ9O6BHyNq3u1wFUULmRHmhtaFXYtTGOdlEtQ97BhQHv9vnj9RpAaKNewLey
         sRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=597kM3j7GMQPvL0o4gYpdI/ql7rF2tjaizbjC1K9t98=;
        b=E+L3yTLgMss3UdAFHlHKrW8DAQmoZQ06dB6N/Mduc8A7d6iyLsRoB8z4rI2wNhRyjG
         7R2LXWdd3W8m087jVwXKu6js8P3PCbfdbNtSxDF+i05MN8aMR0/HRF6zDrJVvaJgE2Ix
         kV/LMtextv5FOd4ycezaGLzkOVRXR4sFzGJVJe5FEI5IH+up4x7iOwSJ6TAKzaWMRvr1
         Cli7b8TsFTASxtV1lgSCq+wtZ2lhk85k+KKtoUjsTVXK1JREcgpfPhKrmXSfr1CoGPO9
         QVCAKd7NMyUgqldzv/iVJLlWGT/oRA9rr0sVB3KYFiZ6mgabYqrmU++RrRykGNHilU/b
         5EpA==
X-Gm-Message-State: APjAAAWmT6+w9zBRdGvkJMQfVxnQ9tDux5wII461PGESxHmlm1aK1szs
        1prHywYFeT7/Ka69y+SKsanBfKSrR8gOSSgGaunG6Q==
X-Google-Smtp-Source: APXvYqy0Ku9DQM4xh6AXf28ArKwxBLwOsxhGt3RKLQVioVoIwxVGXDuVVOTMMWpQPhemG4IoW6RxVsOLNem2DvWzsTk=
X-Received: by 2002:a1f:5602:: with SMTP id k2mr16121674vkb.36.1567523490576;
 Tue, 03 Sep 2019 08:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190820114229.11948-1-ja.kaisrlik@gmail.com>
In-Reply-To: <20190820114229.11948-1-ja.kaisrlik@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:54 +0200
Message-ID: <CAPDyKFrz3AsGTz_Km7Y5GNevmEnDHouCaCA_exGQkAQ23X=LYg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
To:     Jan Kaisrlik <ja.kaisrlik@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Aug 2019 at 13:42, <ja.kaisrlik@gmail.com> wrote:
>
> From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
>
> This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.
>
> Turns out the patch breaks initialization of Toshiba THGBMNG5.
> [    1.648951] mmc0: mmc_select_hs200 failed, error -84
> [    1.648988] mmc0: error -84 whilst initialising MMC card
>
> Signed-off-by: Jan Kaisrlik <ja.kaisrlik@gmail.com>

Applied for fixes and by adding some more information to the
changelog, according to our additional findings.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 74e4364bc9fb..09113b9ad679 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -564,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         if (index == EXT_CSD_SANITIZE_START)
>                 cmd.sanitize_busy = true;
>
> -       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>         if (err)
>                 goto out;
>
> --
> 2.20.1
>
