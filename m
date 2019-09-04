Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2CA7BBC
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfIDGdA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 02:33:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33189 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDGdA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 02:33:00 -0400
Received: by mail-vs1-f67.google.com with SMTP id s18so5985618vsa.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 23:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uji7ZwBx64gRfxdB6F0eCR6oa+56phUDHTpbBifC9Ds=;
        b=uuHYSAp5LqDb5RG3NrUCRi1NMhbcInlwuXVPiRVxOYxObhvMhiw+80wIQlCcIhAoq6
         X+y13siK+NfTrZvcQgBjRLw6dNi13FLKdWJZmZlVVVFlbgbpJqaFLV1AJg7st0blvz78
         8LIFkD6z/lUbr8+Cff+m9icDZMj6wC7m7aJYoCM5Sm1rPuCNAZA9Y6NJ5Vx6DfYblcBf
         QHnSkyL/bx5gt6qbVt9RKdCLK6VJEH4gE7hGW+Zj5v7kcOF4TMt59h3pR2OnyZwl3eFQ
         npzC5o/lyiZmgjAdaDkW68RdKstAIlKzqO5t7ZXapN6a35XeVOeTJ8XTHcMIDSMpn/5D
         0tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uji7ZwBx64gRfxdB6F0eCR6oa+56phUDHTpbBifC9Ds=;
        b=ULLmelZzFc6VS+abdIuJCDg82LKnGasJ3aNakh7LQBpurlmXkjJy63dWXwMIO9O4Nx
         GokKtNMmYdvWDDka8RfjoA7JkNhMmkbkLmnkKMONKj7OljuicxwUXHYwK4M+y9UARhzH
         pvg51IXCXxdlPitS1iiZwBHCuSO5SQWMGPAVljVT4ADpHsq2+WKVSUY4y6+7Y8ec7Zgw
         02crGZRJKzJhRD9GcUkGNjojCmowbkyhrd8zh89RzSM5dMUdWn5oOHR0/HYHtJ3fQDqq
         n0e44hN0HTRkO14jZEP9MRQQ3UNNsb5MSiX52eoGS24/5zaWn8yjgu1cW1grGU6J2pa5
         pTSw==
X-Gm-Message-State: APjAAAV7joLPOAqwkVq4BCEDkfArStpDDwhMUtrTcCus/ixV0tuih6wN
        LNSfWK2IriIAhM70doqHuorNHIyqgD0m1x9naPgD2w==
X-Google-Smtp-Source: APXvYqy0pJF2kz23GupGecb1aqldnQpwpBN38yl4NOQVJhW1Q1GxkznSdDp3mQznh4vHtU9ys7RLaZYVj3n4LY37qkc=
X-Received: by 2002:a67:983:: with SMTP id 125mr15702331vsj.191.1567578779701;
 Tue, 03 Sep 2019 23:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 08:32:23 +0200
Message-ID: <CAPDyKFpmh2zcz7=zL77XGBHUhxcFquoMSiRHf8w3dnvwH50aYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Using 180 sample phase if all
 phases work
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 04:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> default_sample_phase is used to make sure the cards are enumurated
> properly and will be set to 0 if not assigned. However, the sample
> phase should depends on the tuned phase if running higher clock rate.
> If all phases work but default_sample_phase isn't assigned, driver
> set sample phase to 0 for this case, which isn't the best choice,
> because we always expect to set phase to the middle of window. To
> solve the following continually issues we have seen in the test, we
> need set phase to the more stable one, 180, if all phases work.
>
> mmcblk1: error -84 transferring data, sector 1735064, nr 8, cmd
> response 0x900, card status 0xb00
> mmcblk1: retrying using single block read
> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
> mmcblk1: retrying because a re-tune was needed
>
> .....
>
> mmcblk1: error -84 transferring data, sector 1728672, nr 248, cmd
> response 0x900, card status 0xb00
> mmcblk1: retrying using single block read
> dwmmc_rockchip ff0f0000.dwmmc: All phases work, using default phase 0.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Is this ready to be tagged for stable, or think its better to get it
tested a while and then send a backport to Greg etc instead?

In any case, applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index d4d0213..9ef9723 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -209,9 +209,8 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>         }
>
>         if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
> -               clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> -               dev_info(host->dev, "All phases work, using default phase %d.",
> -                        priv->default_sample_phase);
> +               clk_set_phase(priv->sample_clk, 180);
> +               dev_info(host->dev, "All phases work, using phase 180.");
>                 goto free;
>         }
>
> --
> 1.9.1
>
>
>
