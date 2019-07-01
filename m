Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E94480F4
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFQLfv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:35:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36678 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfFQLfv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:35:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id l20so5883810vsp.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaMaGenOD4N8b325Sjijr4yZaXPGNKq+TVNXE6cscOU=;
        b=uONy/nnaWJS5YnlekVpZ6hSp62ck/n140Ql6GM+iMx5eXARgkLsu4yUoBGQG4mZMsx
         JPVEPfAUizflPNYzQdAVNWMEA+EAePkbnAJmhUlLB1bc9cmVnPmYGUe8epJp5QRsr7fv
         3fSXKdbmbUX+lHk+i8IZcWgfzItQYtk1ZrzNZcpygYy0Z2Qzk9paEqGWaq+M8yYUov9n
         vpC1pQkpankIn0pzLQ2yYcH5hlWPq7YsyyIzcAvDY/jZDYHlmnHNvaGaRm+o9V74zP+U
         oCm4zuFp1UkSyXq49pkhH3XgX9bG4WBP7ub8KNmwdmacoeTwtN1G7qFUgr+N7SXLJ2iA
         cPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaMaGenOD4N8b325Sjijr4yZaXPGNKq+TVNXE6cscOU=;
        b=WIU84ttczl9xU+O4HhUUXHSgE2Iayi7ZHFI/MiKaafkSdKoT+qHzS+JpML/eVZeWzk
         0p/kJ0YnItD0fweaz3I8q955n10wO53P5eSxYkMHr7BbkdHx8OafF1WE1Tt3dGiWQhSE
         xYM6BdSmKeLuNl7j7UIzHBvJBe3ahaV5IA1GpNxYIa0YwTX19vdE1m2iv7D3ldwQ0x47
         9S6nywYpnRJ5Qg0AA8/LCbBQjWhG9V9+PI4C4mokKGVo9QrkiJLEAlbRSPhBPqd1c+Vc
         jLIOsC/o+Q2HIjcFpnt6ZTf8xve9TOhWZbLAsMkam3zVoPtVky5ErB1/PReot6qexo6z
         uTWQ==
X-Gm-Message-State: APjAAAWl8v6ra94+53wjAV6TniijIIsfUZoduf7umtmc0UrNz2nlvyFl
        4O4sltWHKbp6l6Z/EmoY4GNQPAB57ZGLhq09ctdL8A==
X-Google-Smtp-Source: APXvYqy1iw03xovxVxG7DFIiObqWByOSpxIG6znLpJdvU2E+tvGtVv5f1UFVBS4cZkKB5nErh4SPzFnfR6lB6yyVJvQ=
X-Received: by 2002:a67:3254:: with SMTP id y81mr20641150vsy.34.1560771350006;
 Mon, 17 Jun 2019 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com> <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:13 +0200
Message-ID: <CAPDyKFoTBhCy2bB8uzzDTNMBPnNjD81134BGt2Op3USFCW1R7Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: mediatek: fix SDIO IRQ detection issue
To:     Jjian Zhou <jjian.zhou@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Mao <yong.mao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 13:04, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> If cmd19 timeout or response crcerr occurs during execute_tuning(),
> it need invoke msdc_reset_hw(). Otherwise SDIO IRQ can't be detected.
>
> Signed-off-by: jjian zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes and by adding a fixes/stable tag, thanks!


> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fa7d420..ba1ad5e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1031,6 +1031,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         msdc_track_cmd_data(host, mrq->cmd, mrq->data);
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
> +       if (host->error)
> +               msdc_reset_hw(host);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> --
> 1.9.1
>
