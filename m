Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863B9A89A7
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfIDPoR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 11:44:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41682 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbfIDPoQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 11:44:16 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so3772841ioh.8
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH7Dg9ljf2Vj64HDPlPhmHR1vea0MJI1LXKjcd+873A=;
        b=eTP8Lj0BXh8sZhX3RO0A6HzDQf4KNS0yeIXIPuARLp0MohKONAlQ3xxDrzBBeQZ0ns
         PLccEPHtAm0Nc2vs5JrgL/y0Jpu5fYE9XW5X1vla8ude8uQPpMtEF2fL24cR+yatfBLC
         CxV9CcHgMcZDh7APyBb/UNBW4fVk3jzrzOT4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH7Dg9ljf2Vj64HDPlPhmHR1vea0MJI1LXKjcd+873A=;
        b=LSy8DetIdMQ8jAz2ItiSqUyxDPNW/bGJ8aFnQ3YbUqCfSp9stEex7dsJqPVGqL9Y3L
         AeYvv0lREFMpLF3RY81qyuKGfJKj7Hi9xCphvxOUZ1ouGmEFrOWlYx9rpVA2j4eyvmNQ
         srIXcMDzpZHwiuDz9zPli5+uBcelZKiONv6t0ErPRxIjug9zuUn0vZkwM5wkuiEre5sb
         Siq3tw0GII1dx5PmNnb0icF6tYLuhujP0XzT2An9gC5hsFwYOxxBLBDMOHbQlJQ7anKs
         WgXKr1Ofxww6LB/jETEstuAZ1wWPX5JCZgIBTnGzsPtSr5YqASfbxEkWpicnThlhsbQn
         M1kA==
X-Gm-Message-State: APjAAAWWO0ZuAh3oGLd33y+zr4cawZu8X7I1Yipw57rMnCZXzm9rCVF5
        gNJoGorTW0Ut8n0QTNjiN+Dg/LBMZTQ=
X-Google-Smtp-Source: APXvYqzSfd6cwjK2Ob4PLgFxi5qT4Fn5ycgJB6UJ9bjelArMkK6IUw9KrWxAMcLM6TV2dVZJ+FTVcA==
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr5480380jad.61.1567611855088;
        Wed, 04 Sep 2019 08:44:15 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id s8sm9110100ioe.0.2019.09.04.08.44.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 08:44:14 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id p12so45224395iog.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 08:44:14 -0700 (PDT)
X-Received: by 2002:a6b:6e0a:: with SMTP id d10mr954243ioh.141.1567611854025;
 Wed, 04 Sep 2019 08:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1567564030-83224-1-git-send-email-shawn.lin@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Sep 2019 08:44:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vwmj=LehhLCN5OBbEfNNXp9gULLYRoVV86HtqZBxvEjw@mail.gmail.com>
Message-ID: <CAD=FV=Vwmj=LehhLCN5OBbEfNNXp9gULLYRoVV86HtqZBxvEjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Using 180 sample phase if all
 phases work
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 7:28 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
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

This violates what is documented in the device tree bindings, which says:

* rockchip,default-sample-phase: The default phase to set ciu-sample at
  probing, low speeds or in case where all phases work at tuning time.
  If not specified 0 deg will be used.

Specifically:
* You don't use "default-sample-phase" at all when all phases pass.
* You don't default to 0 if not specified.

Personally I think we could change the bindings to say: "If not
specified 180 deg will be used" and then change the code to do the
same.  If we wanted to keep the "stable ABI" that is device tree we
could also just do the "180 default" for new SoCs and then manually
add the device tree fragment to all old dts files.


-Doug
