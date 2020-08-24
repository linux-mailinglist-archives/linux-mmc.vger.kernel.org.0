Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624224F9F2
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Aug 2020 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgHXJvV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Aug 2020 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgHXJvS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:18 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A408C061795
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:16 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k18so2406881uao.11
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAijYwEhVki3ASVGSGr03ujQoKI91GWpC9DTd+zqR0A=;
        b=qn81eystRutEQfbCLxokhFYJd8I+U2gytbLbne7CogTPMGmSh08XyhDIgI/v2QToR+
         kT+/d/FTJMHoVzz3GQRU0+WI6B5tzZ+g5lv9LH5R/ufdfMDth07OXvmKPldXy8R+wH7Z
         Aq5SkhxScTBiedB2/9jzUCfIpT/3HR3xNLXxDc8IhpGWJrhCkQwS1D8zEMM3mIUSJxFw
         0URvOSFzKErG49kZ5jM9Tiv5+m03GAQWPQAfPQgRvgOFExOanVct6VSB0hB39pWPLrgl
         EJzFdUbXrjRm6hTYef8Xl2JLpe+7wSmFt0+AIvnNwINNSPhjO0CbUMGnZBxP5rfshhka
         ChRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAijYwEhVki3ASVGSGr03ujQoKI91GWpC9DTd+zqR0A=;
        b=e53dnIJz6iCbuUB5C4kSDIIoZr5ooWDFYvr8uBonShRhmI+4Xt2gxBs9JgEFUUaDHt
         8qmxVL8A/KNzUoFdSbRr6GkWkyk1NpOb94EzZOdjnOryYndAuu36eOrYo1Q+ATHDV2v5
         BJpZygkGDx6X2nZWGU1pRzDvoLlkeDeH1t93jmZAoEMzJoH39PHtQjCk+jbh+t/peCtb
         yCIWyUoISYlWlsGILj/0X5X4gTjF/dNon4/QDtMFAYGArtIuQZFNcJkoU7YWsaM6xZf1
         mZfUoi9bU27bw6HrB42e5YdWLtfRiRlVDpGlJvnxr4HYr2LEyG/uOy2gPsg8D+jtXDwN
         iuYw==
X-Gm-Message-State: AOAM531gbr99csViu9RJocAJyL0Y6utemc+jB/PwZEJJGgTwgJ8CgP3v
        bTJDfP/YZYSoNwxWfZ7MMPVstGtvSyiOAz9ckayjh2ceq/y9eA==
X-Google-Smtp-Source: ABdhPJzjncwbZlj5jNnq9VPppz4EGIptpW5meuYQu1QoZeXcpK4+nWbBg2mnjp49m9YA3c/5bJZ6ncdZPbElHbfd3mA=
X-Received: by 2002:ab0:3114:: with SMTP id e20mr1857025ual.104.1598262675798;
 Mon, 24 Aug 2020 02:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200814014346.6496-1-wenbin.mei@mediatek.com> <20200814014346.6496-4-wenbin.mei@mediatek.com>
In-Reply-To: <20200814014346.6496-4-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:38 +0200
Message-ID: <CAPDyKFqrjuHFr0b1xvHFXquELxwMG40wV8_XQF8Sp-HmRNHgmw@mail.gmail.com>
Subject: Re: [v5,3/3] mmc: mediatek: add optional module reset property
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Aug 2020 at 03:44, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> This patch fixs eMMC-Access on mt7622/Bpi-64.
> Before we got these Errors on mounting eMMC ion R64:
> [   48.664925] blk_update_request: I/O error, dev mmcblk0, sector 204800 op 0x1:(WRITE)
> flags 0x800 phys_seg 1 prio class 0
> [   48.676019] Buffer I/O error on dev mmcblk0p1, logical block 0, lost sync page write
>
> This patch adds a optional reset management for msdc.
> Sometimes the bootloader does not bring msdc register
> to default state, so need reset the msdc controller.
>
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>

Applied for fixes, but needed to resolve a conflict when applying, thanks!


> ---
>  drivers/mmc/host/mtk-sd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 39e7fc54c438..fc97d5bf3a20 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> +#include <linux/reset.h>
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/core.h>
> @@ -434,6 +435,7 @@ struct msdc_host {
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
>         struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> +       struct reset_control *reset;

I moved this a couple of lines above, since this conflicts with later
changes for mtk-sd.

[...]

Kind regards
Uffe
