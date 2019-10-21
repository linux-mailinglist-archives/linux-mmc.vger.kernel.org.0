Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FADEFA6
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfJUOd1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 10:33:27 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35305 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJUOd1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 10:33:27 -0400
Received: by mail-vk1-f195.google.com with SMTP id d66so2802284vka.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jfA0P/Q8T8UjCLrgdWWyNBUpvtRRs/536E+E+xKTUI=;
        b=fo+M5yNGWjh6WpyTan0dMaP6adElk8Q28uVOOSVGR6oiDnQuPMI6e5xfGmEds2bvv2
         IZMqR+5WOgGiJjjultpETJ7uo8T7veXupA55susBuyXB3N3RA8t2kBkiFC7FeiwQrY0a
         S3uv76RJKvqdexspozSjBMMdh+Fbw7PUvOfTRlUkCf3WFVU48277x4gcmqd5D63DMsLp
         SvtWTKOaN/08hHadAKZNaTeN3YkefHsndbvdf3CYoc7cu4n3287YMpAgef4nIr6AXUWQ
         lQfJ9MA1fE89OMxCfSUQ29NsqZEh07ssu/CmNX5i+UalUOUU+JKl/VNLstP4teC6m+4q
         AVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jfA0P/Q8T8UjCLrgdWWyNBUpvtRRs/536E+E+xKTUI=;
        b=i6uHrio1JUKGCp0jSnHVauG3A9JwYeKqdQXfY9/dsOmy/bb9tu7hDqlHB7Bh3HZ1tz
         JpyjWI9c0q7i3u99ai5zdbhFyzCSwNS6dXmnVnfuyTbvGx1KR6w8Jg1KbMTfdflIykD8
         ZzPb5sGSPU2QxtH0NIGSKLK/qpdQ0GfADg9/k8KW4Rqo+gNdMq3p6RvDa5kLaa3G1NsD
         BE765n8uk5Hul1fPNDy0vLlydq6UsPpeuaTqnm0Gd5bdUGnedjMzcndScZ5+5YABCN8L
         fiQ4diVImSAEM9bj6JpOoQq64+aHpojcXNWpSUDMFM6O54Nz1tLNXz4tbuLOhTI3MZ+X
         LOvw==
X-Gm-Message-State: APjAAAVLAaaVqcN0L1ArxMjYvI3xbukh//12LN8Dk27BcOS/ru0ICVxL
        yAIWVUQ7SFPGZ7YohejqiPBQMrqr08zdp420+BjHkoYdeMQ=
X-Google-Smtp-Source: APXvYqwxG+OOH5vTVcxbeM++YEq/oLjw7diPz4dlTQB9dJJL+KeH2klQ2bLGQpl2ZMsrWsuLtAulGEUhOnAzfVkF7Ws=
X-Received: by 2002:a1f:2f51:: with SMTP id v78mr12965554vkv.101.1571668405527;
 Mon, 21 Oct 2019 07:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191018131338.11713-1-hslester96@gmail.com>
In-Reply-To: <20191018131338.11713-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 16:32:49 +0200
Message-ID: <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
To:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> failures.
> Add checks for them to fix the problem.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d4ada5cca2d1..dc5ad6632df3 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (!IS_ERR(priv->pinctrl)) {
>                 priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
>                                                 PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(priv->pins_default))
> +                       return PTR_ERR(priv->pins_default);
> +
>                 priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
>                                                 "state_uhs");
> +               if (IS_ERR(priv->pins_uhs))
> +                       return PTR_ERR(priv->pins_uhs);
>         }

This looks correct to me, as I guess if there is a pinctrl specified
for device node of the controller, it means that it should be used!?

I understand that this is only used for those variants that supports
UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
this fine you think?

>
>         host = tmio_mmc_host_alloc(pdev, mmc_data);
> --
> 2.20.1
>

Kind regards
Uffe
