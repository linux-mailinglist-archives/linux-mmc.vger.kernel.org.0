Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAEAE107
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfIIW3Y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:29:24 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37295 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfIIW3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:29:24 -0400
Received: by mail-vk1-f195.google.com with SMTP id v78so3116628vke.4
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aw3KitC+gZjAstmoI82CIHR5PcpwjoN5I9nINWW5tjg=;
        b=OE6c/504gfqx+xO3l8yQTRuLIaUfZpmyT5bd/Y4/MMENKMVNlHOdbj6o9KvDbA9NVH
         IqSAw9xiB9jJ4LFy9nu/lRldThsV0HIziCBBq7vEwYVQ2k5Q82MS++D4zwXZ427rZHKZ
         NyE2Ab3zEfzf8I93dA9spyKWXxkdT25yuALaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw3KitC+gZjAstmoI82CIHR5PcpwjoN5I9nINWW5tjg=;
        b=RqnijFgPW53K/1iqE3nC+0F9qUwFX2EG3QGAo8gzCqrmiEuyiIeRlc0iIbnAbyiQ+W
         Bjah6kgy2qmSfxQ4inqRHD0FfmWOZO5ORJDKr3bLFhj3+SfHsgeHC7B3ZlYaYmP4a3dd
         zAAposSrcOLbnbd0nIvYeaHS/agySVshJFbsPxFCh6mCR3fi6bxmuWKkHTO3Evr95xdq
         E7gOcYcta3X8YSTEJB6SePqRJiVi3ubMIqasHLroW8txn/Wpx3+5kBWs/CIcZrpzlJ6+
         bjSB1taOodfOM0QbTtpgckgF8OSmBZlysFrG5f46RwKZesRvpKivJYVcqdEXJ+i2DF01
         X1Og==
X-Gm-Message-State: APjAAAXccsA0I05SIJieIoZT8IcUr9ktpul3TqLLA1FdFTLcZ7kbU1eo
        uHgLGlFo9hLspewRoqStlE1lVJHCbiI=
X-Google-Smtp-Source: APXvYqyvHLAscNUZQDjWXE2XDFFe+4V8/rl3RQl3sTay2zQ9p9HLN+CURlrdckmbyQEzzwYL+e9p+Q==
X-Received: by 2002:a1f:eb86:: with SMTP id j128mr12189960vkh.61.1568068163121;
        Mon, 09 Sep 2019 15:29:23 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id d3sm11915256vsd.34.2019.09.09.15.29.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:29:22 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y62so9906923vsb.6
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:29:22 -0700 (PDT)
X-Received: by 2002:a67:2b86:: with SMTP id r128mr278682vsr.119.1568068161962;
 Mon, 09 Sep 2019 15:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-4-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:29:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
Message-ID: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means msdc_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
>
> This means during system suspend/resume, the register context of the mtk-sd
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the mtk-sd driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the mtk-sd driver, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mtk-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6946bb040a28..ae7688098b7b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
>         } else {
>                 host->save_para.pad_tune = readl(host->base + tune_reg);
>         }
> +
> +       if (sdio_irq_claimed(host->mmc))
> +               __msdc_enable_sdio_irq(host, 1);
>  }
>
>  static void msdc_restore_reg(struct msdc_host *host)

I don't personally have a Mediatek device setup to test this patch on.
If it's super urgent I could try to track down one and try to set it
up, but hopefully it's easier for someone else...

That being said, from code inspection it seems like you should be
adding your code to msdc_restore_reg(), not to msdc_save_reg().  Am I
confused?

-Doug
