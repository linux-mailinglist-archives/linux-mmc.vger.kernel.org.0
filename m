Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88FA6C94
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfICPLN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 11:11:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46044 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICPLN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 11:11:13 -0400
Received: by mail-ua1-f66.google.com with SMTP id j6so5576612uae.12
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D3e9W2yeYksy0f4fuNlRYAPcfLR8aSNbO/EU86R0hP4=;
        b=WO3yaL50caVRPNVVzECDC1KIYPSQoV/F/kmIrCspE7EpXM29WGxFHYDjMLBRTOcwWR
         /HDfH528vagRQJqA41CrJe3/GSu3MzBR4zrmCXJuNTzcH2jeXniIEpG7NXknajc8mHUt
         ak1CtU1+Fqfjmjp62RHNsgmkgWDWurtv+l/UlKP4e0RJEMtJQ9fs6DK1uPhx/D7ckQlD
         X15jTqnfvUwMdE6veV6PXWW+SujPbHo+BXVLG2O7bauSrqc2eEHpFDDATBRRkRWYUcha
         0w5iGr3k/BvfuScoE2q1GJaNcz97lo3GkFZZZHAams/1Nwwh7UWCl1t+XttNuoE09jJW
         Ea+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D3e9W2yeYksy0f4fuNlRYAPcfLR8aSNbO/EU86R0hP4=;
        b=Hq/J+i0sKCh1YFFqPto7r1w46Z6VL7A94cLGNxP1BJo8oFeEP+/u7tJ/bs2LRo9cOt
         OiDzugd8qyJ6M9Nr6TN4NDVELmyncm+07RIqG9ExyUDFMp5pxH999K4fCNc1CDBXFzRo
         +VnXXBpR8b7Faz/42c4bNzHaChcojqEJ88fDVMk/RrFE7UYfWUW9lfpgWXPHc6mk71td
         +JTWQ3mbw+Mv/uJlQX/11W0IwDgs1FQPADQQgaCp6ki6a8UEFZzONQDGIsQ3AqQHrfLc
         /emYGrtNK4cORbjhTJEI5GWIsY2ydmZEaJW+wkCNMbfpmcVHcs68TM96KstKOapUT6s9
         SPIg==
X-Gm-Message-State: APjAAAVxSCK7ChWlYdJRU2WPg5e6mwivq0eVb5O5PEp/QG5UcGm8xobj
        jO0O+r0WVOv3y5uPkLVmIt3t6SEYVjFTEF1aDB19VQ==
X-Google-Smtp-Source: APXvYqzZVbNhOosd22YGLbO9TXiU0/LmjJ+fiNJ65ysBR9g7sb/vcJNqesHJIz9Axt0Evic7ko3VJu8vP0VDM325ZeY=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr17513945uar.104.1567523471452;
 Tue, 03 Sep 2019 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190829183634.3376-1-tszucs@protonmail.ch>
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:35 +0200
Message-ID: <CAPDyKFpRtzS3CXAi4jKjyPOEd5KjCZ1Vqpi_fmm-F+O8eAqbmQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
To:     =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 20:36, Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch> =
wrote:
>
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs=
.
> This will indicate the precise SD clock in I/O settings rather than only =
the
> sometimes misleading requested clock.
>
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
> index 64d3b5fb7fe5..4c9774dbcfc1 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>  {
>         struct renesas_sdhi *priv =3D host_to_priv(host);
>         unsigned int freq, diff, best_freq =3D 0, diff_min =3D ~0;
> -       int i, ret;
> +       int i;
>
>         /* tested only on R-Car Gen2+ currently; may work for others */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> @@ -153,9 +153,9 @@ static unsigned int renesas_sdhi_clk_update(struct tm=
io_mmc_host *host,
>                 }
>         }
>
> -       ret =3D clk_set_rate(priv->clk, best_freq);
> +       clk_set_rate(priv->clk, best_freq);
>
> -       return ret =3D=3D 0 ? best_freq : clk_get_rate(priv->clk);
> +       return clk_get_rate(priv->clk);
>  }
>
>  static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_=
host *host,
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       if (new_clock =3D=3D 0)
> +       if (new_clock =3D=3D 0) {
> +               host->mmc->actual_clock =3D 0;
>                 goto out;
> +       }
>
> -       clock =3D renesas_sdhi_clk_update(host, new_clock) / 512;
> +       host->mmc->actual_clock =3D renesas_sdhi_clk_update(host, new_clo=
ck);
> +       clock =3D host->mmc->actual_clock / 512;
>
>         for (clk =3D 0x80000080; new_clock >=3D (clock << 1); clk >>=3D 1=
)
>                 clock <<=3D 1;
> --
> 2.11.0
>
