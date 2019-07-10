Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56B961DFD
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Jul 2019 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfGHL4N (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jul 2019 07:56:13 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:35196 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGHL4N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2019 07:56:13 -0400
Received: by mail-vs1-f48.google.com with SMTP id u124so7986289vsu.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jul 2019 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xo7o6HVE/xn9qpops1z0+On7QRm5OAbCvXp9M/IoyTA=;
        b=Y5NBAw/pna6vKqJfoE2mDarvSAMM8zgFKcnRLHFCnbiwZCesih3Vun1ny1PBvJy4qZ
         rSycH4u2/6AdJrZ1OBqnBOnz/F0F76rwQdGww3xhRMAiuy2w/7jH4dy2K7kRpCrkZdxz
         8/0k2DwbVkMkoSyn8zu7WRJd/J84pIJkfTrGmWp7pTnc5gJwmQQRa6k2iiVRTcqgDDhU
         I/qvq//SP663yolGX+Iafi2gtf70L4/xiev791KSBgr0lmUnlv/qTOnQKfoyhbBg0Q+7
         U/SjWek2W5ccVA8sZVrslUM4M2nJ9J48orRhzpti8BlG+fy6DtWuqTzCJYY4EuaaGZTa
         FBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xo7o6HVE/xn9qpops1z0+On7QRm5OAbCvXp9M/IoyTA=;
        b=OR8swYOy1z37jSZloVhOZLnsONmxcWPkRX2m8l2uUe4B2RWZu+wR2Ar9FclRP7/Zjg
         LKdWf4SdXSpBYwuBFQwVXDBnMFXMJ1sxgqvVNWmy7xVdpLG+pMLY4q9KlCpajnpjoE/d
         vWD+ni+ngbHcEYk5DP220b7a4yvYETxdWMU469t33fy+o6pQjnst4UWrz4PAJ/ULTab2
         AvnIB6cD63DVLaO1ptQ5fYOlnMjZE72HIAKa/M8J7YTL7d1K+j33ZY2TfHbH0ki/oLTi
         bVGErA2ztzAjnFKhO6omSO8ijwpqkPUaqPVM1MHamzt4frLY3JFq81ps/ULirVBGaJFW
         cPAw==
X-Gm-Message-State: APjAAAWJjllaFBoIGqKbCe+rTTRpUPBbOFvkaYfGytG6bfZGMg2Ed4Vm
        Vomt1wDOOghQjDHs3oV385tECNdooCM98mndgfBeWA==
X-Google-Smtp-Source: APXvYqwu+R5WI9AMsqmD+oHlyrV3nJ+8UBciZuyzYzNb1YU8XDOCPtFx/01zRg+hguwOvH6nfh4HxvYtpTAKU7F2qg4=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9881012vsp.165.1562586972066;
 Mon, 08 Jul 2019 04:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190628040751.46196-1-yuehaibing@huawei.com>
In-Reply-To: <20190628040751.46196-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:36 +0200
Message-ID: <CAPDyKFp=7qPeTgx8tJDHaAvg+w+1z8iWExVUeOyRE=5cud8KBQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci_am654: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Jun 2019 at 06:09, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/mmc/host/sdhci_am654.c:192:6: warning: symbol 'sdhci_j721e_4bit_set_clock' was not declared. Should it be static?
> drivers/mmc/host/sdhci_am654.c:261:18: warning: symbol 'sdhci_j721e_8bit_ops' was not declared. Should it be static?
> drivers/mmc/host/sdhci_am654.c:284:18: warning: symbol 'sdhci_j721e_4bit_ops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 3b39481..bb90757 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -189,7 +189,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>  }
>
> -void sdhci_j721e_4bit_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
> +                                      unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> @@ -258,7 +259,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>         .flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>
> -struct sdhci_ops sdhci_j721e_8bit_ops = {
> +static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> @@ -281,7 +282,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
>         .flags = DLL_PRESENT,
>  };
>
> -struct sdhci_ops sdhci_j721e_4bit_ops = {
> +static struct sdhci_ops sdhci_j721e_4bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> --
> 2.7.4
>
>
