Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABBA1B94
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfH2NhF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 09:37:05 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39910 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfH2NhF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 09:37:05 -0400
Received: by mail-ua1-f65.google.com with SMTP id k7so1159063uao.6
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoycuwM03PAMoYB7LC8b4YSa3oTRgt158KShkM1cXKQ=;
        b=zKgu0Jl4DlvWeQzglf9VPPVkVjkJuw4LSkmT+pELc19VL8JHSvF1cXxTazR+CrZKKr
         kCKva4b0mB1m11diTo57wSNo45Olb6PZAJ9MJQFkQ9yVFAuSd2k0u3LBqbauDprRPNQ/
         aJIlTmkMU61yn3ZDe4r1wBrDPkK9guE6hwr+NIl8Z8P1Ql0aZaijF0sATF21E99eR39v
         WrYTJUr3d3ot/wHi7f49JTlZhShwYMK1yvSVT9G3kmmwWgzaIUFbdbuq98bWRlS4/55u
         6C4AqN2+/uw0MAuG40eXp0w6XNwSJ1YHaW+xBYhE0f0VcARxF6IRgR4b2ubMxBBfGaOc
         sRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoycuwM03PAMoYB7LC8b4YSa3oTRgt158KShkM1cXKQ=;
        b=p2uY0rep67MbQ3S8ABhz2CMI1KKGb+kp7tcqhHFfy+7z0DNUkUZpViE2MRu6I9ZFlP
         z/feFpom3MgxIrOnObJ+ksgxnZe6tc8JgLDbnMYqqjFyrGOVlXjYYCqVPyRlt4VSU4JN
         N7ekvzYr1XUFnonFhdjpEkR6kzysqgM3Y54o+WXCAUKWw5Bho6iBYp4zGexk34k2FsiA
         mshVIt1HTR+joSyFAZsRUc9S8d3TMJJf9OFHofsszXf2uV01OBQX/oC/X7jg+7V/9SIT
         rJfb9ehsCZjKFQ0vSBaOPsc0z19+9xdXUpPwv7VjX3UBtV5AKWJzq3UgFa6C7SoD5dBM
         IOZw==
X-Gm-Message-State: APjAAAVeYDyrGe6Iw54UOSiHNAqHF+k51yF2epWQOC5yT9fu+BSZhVk9
        lK9tZa3rj7oll9BNwaZrcHFJzVk6VEtnqdG93BJLAQ==
X-Google-Smtp-Source: APXvYqw5PMEM/AaXKseVFjiJDB4qE632N2Eh8ohpX17hqRNF3TeDatpY+W6xb/csgdhA+MJBYjRRNsuLKGcO5K48bSs=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr4939055uar.104.1567085824135;
 Thu, 29 Aug 2019 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <1566985524-22749-1-git-send-email-yong.mao@mediatek.com> <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:36:28 +0200
Message-ID: <CAPDyKFqgO7fwybn1nYcf14jiHswM+T7fqY1BuSvx5AubYA6F=A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: enable SDIO IRQ low level trigger function
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 11:45, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> SDIO IRQ is not defaultly triggered by low level,
> but by falling edge. It needs to set related register
> to enable SDIO IRQ low level trigger function.
> Otherwise the SDIO IRQ may be lost in some specail condition.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 33f4b63..585f0c7 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -192,6 +192,7 @@
>  #define SDC_STS_CMDBUSY         (0x1 << 1)     /* RW */
>  #define SDC_STS_SWR_COMPL       (0x1 << 31)    /* RW */
>
> +#define SDC_DAT1_IRQ_TRIGGER   (0x1 << 19)     /* RW */
>  /* SDC_ADV_CFG0 mask */
>  #define SDC_RX_ENHANCE_EN      (0x1 << 20)     /* RW */
>
> @@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
>
>         /* Config SDIO device detect interrupt function */
>         sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> --
> 1.9.1
>
