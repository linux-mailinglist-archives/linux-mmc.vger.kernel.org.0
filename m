Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1903C480F7
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFQLf5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:35:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33223 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLf5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:35:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so5898493vsj.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otnv9cTgTfe5r23dfOto9MZjGxvYYJ6GS/smezsERbw=;
        b=GhSJZeoC/oXLyZ+TRiMZ0YoXyHryTR3BQ9q66WqrqpWj4KduSA9n3Udj3Q7AiY94c7
         ApmEGyvfHjEeCnF+Bow7WWJquaPIFB/gMPr49O2j6bcgghpvg0XWk/cc4JHNjEdz7yxi
         3icABA7wUklyEK6MablY/noFcwcUfOP3MqD3ooi54cey/mH1qVhQzu81icq43SWOvl8k
         3VEbBqiExhkaV+MutYoQNaN0MHEf5ou1YKkOclJVHN73qhp9Gh04uCnDKw/GCo4h7T5N
         RUktUXFcT0j/RWnPTbUMjGO6Ottd0/ODo86n5mbFPW0+6YhmJ6Jg4cX0RsNVBFGx7ZPt
         uZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otnv9cTgTfe5r23dfOto9MZjGxvYYJ6GS/smezsERbw=;
        b=Cgj+ASRQ5N6MACh/3g3ZWXyoe70VrbzzJBHGVa9tWIaI6zKoz3gduIMLnD8mF4b/pF
         eSZst8wE9/3DMKRj/eWzLBAilmg+Ef+iceSCXzG53/yajvSt7Fa+J9NGnhHUTxKPtu7Z
         iwQ9SDOOdh/qGuCQbGLE0ndlmSQtFlTFnlNwJPivhkdolqrzZ/jpFMfm0YThnN37Jdte
         0leOdGGB0+8kfl8OU6mp1HiuJBe5kvDKyVzpUAG4Zss0+AuSfWOX5ou3AIRtjRaTZKcz
         Xh5xa7z31/D6Sg58hpyCHlJ/y1VAWnlVbU/R2I4c582q1UDYKcE5PxTiz/qSq0SD3yOw
         5q1A==
X-Gm-Message-State: APjAAAWkYkB8qYwH/uDb92Tyl5KnNBWE/pnLCgRoNqC62g5T3BjYY01J
        WQ5Ql4M6QAKqAgHy1EC1uOu4wft0oDvCbi87fOiBzA==
X-Google-Smtp-Source: APXvYqwBVjsPbGBBhP5ZVvSPIZSSHx/Xzfdo7b8id4zHbReP84EdzxehZlurqqpezNNACpbcKL5o3Jdqu3aySrLPFcM=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9846vsp.165.1560771356174;
 Mon, 17 Jun 2019 04:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190614082954.39648-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190614082954.39648-1-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:20 +0200
Message-ID: <CAPDyKFq-zb3aA7SjFPxx3-xDb+UUwEGG5EK1UW951LyQnBNopA@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: set the sd clock divisor value
 above 3
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Jun 2019 at 10:28, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yangbo Lu <yangbo.lu@nxp.com>
>
> This patch is to set the sd clock divisor value above 3 in tuning mode
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d4ec0a959a75..c4af026c3fba 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -824,9 +824,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         bool hs400_tuning;
> +       unsigned int clk;
>         u32 val;
>         int ret;
>
> +       /* For tuning mode, the sd clock divisor value
> +        * must be larger than 3 according to reference manual.
> +        */
> +       clk = esdhc->peripheral_clock / 3;
> +       if (host->clock > clk)
> +               esdhc_of_set_clock(host, clk);
> +
>         if (esdhc->quirk_limited_clk_division &&
>             host->flags & SDHCI_HS400_TUNING)
>                 esdhc_of_set_clock(host, host->clock);
> --
> 2.17.1
>
