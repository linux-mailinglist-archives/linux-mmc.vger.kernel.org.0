Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F133C34C5E
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfFDPiN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 11:38:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37588 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfFDPiN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 11:38:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so554559wmg.2;
        Tue, 04 Jun 2019 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ADPqlK9Kfd3W+fMoC8mvKzJZ97rbykRd+0P4DrwK1g=;
        b=VBbOZTE8WVTFePfLUBBaReos2Bg0lMGE9yuiqDIyJGjH/SdeDTWFZKrcSOdarbU4fT
         dxLkwnbREBmSsOaWZrXEeluXkfF/VY/aY0Q5kjWD33GYerelVq/QH7oDN9CfKE8zhDm3
         7g3EUAo9nW/qyqIhV7wE2cHedC7+qbPK5r2wpxtY2vwpXdTwaXrCmZRQ4U31GkZqU69W
         kyG4ini2BXJpQmXElSnsYW/4Qs5k4eJ8veaRdU7kmnv3mfu5UD4Xw4C6Et4kpkSye+u1
         YrxmpoIPwxNSXnd9k4xVAqe/ZoYZriGDDxdmbAXFT5X4zrU7sF5Ohm4LZg60wHnJa5RK
         PJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ADPqlK9Kfd3W+fMoC8mvKzJZ97rbykRd+0P4DrwK1g=;
        b=GgcZytHpgssI3gbkBHgKMKmbXShc82sxpdZOOBVy3je3Ujm6qKJ8e5p8wCZy/FjOzY
         wInrZ1UszxQ9FYotiija3awCI2J8XntuF7maxG4knX86qyD46wUjQ9FsunbQf6n+PwJV
         L+0CXhL4OX0MzToSPoR+EFFfV3IouayZDPvVdr45b/1iOKFGiW9SVVWzkPw2R9/X6rwn
         Yg0XoYDtKg0skPLt8/sUW4IVIj+iutDo8vrVqIMMQWN+eV8NeuAsu8O4Ol2QYJ0G9CoX
         +z61TyTbnHWNmtmkIofhcoGiOyWj9orzte2UyOLimxF6WadEiiJsiK/zJo/vpbnaJThY
         y/Tw==
X-Gm-Message-State: APjAAAXbPoTaiz3qT6nsApm9gM1Xthei9ddwWG4v3+LEkxAsfDLPP3nG
        ++5VeNNbCy8+pkyPyMMhzZw=
X-Google-Smtp-Source: APXvYqwKWfTU+6XbQZQR9P6IGuZbzh4Lm8HatnpfkPJrilgwFmR3Xb9zlkBweMzImos2KJk9X/X86g==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr6820183wmc.75.1559662691084;
        Tue, 04 Jun 2019 08:38:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y17sm39795295wrg.18.2019.06.04.08.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 08:38:10 -0700 (PDT)
Date:   Tue, 4 Jun 2019 17:38:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sdhci: tegra: Do not log error message on deferred probe
Message-ID: <20190604153809.GA23360@ulmo>
References: <20190604153446.22857-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190604153446.22857-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 05:34:46PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Recent changes have made it much more probably that clocks are not

Ugh... s/probably/probable/. Adrian, Ulf, do you want me to resend just
for that if there are no further comments, or could you ammend that when
applying?

Thierry

> available yet when the SDHCI driver is first probed. However, that
> is a situation that the driver can cope with just fine.
>=20
> To avoid confusion, don't output an error when this happens.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 10d7aaf68bab..8a6a51bc038b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1550,8 +1550,11 @@ static int sdhci_tegra_probe(struct platform_devic=
e *pdev)
> =20
>  	clk =3D devm_clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {
> -		dev_err(mmc_dev(host->mmc), "clk err\n");
>  		rc =3D PTR_ERR(clk);
> +
> +		if (rc !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get clock: %d\n", rc);
> +
>  		goto err_clk_get;
>  	}
>  	clk_prepare_enable(clk);
> --=20
> 2.21.0
>=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2kF4ACgkQ3SOs138+
s6H4SxAAvwWb+YyMS4KJDUJnRkUdcqM7DMSfacb6v3kfQeC1aXUKunXEDWcxZyV1
B0UqqayyvnzchbgxBzlyIzE+wuNDk3ZMvI95+YpOmgX7H4Wx9bPBI1SqKqRjvwiU
r+ZH/Oxa84jr9mb6F3uaSS5atGtAjijmJ9Sj20+m7D6lx6oOVhuoB3GlJYLRf/KQ
CKVR/Jf1AsyS14AEuCry+fygymSp8L5htBqJCUSqWqfl1gXfxQGtoJcrimSDnRKk
eyqNFnLv2Onufzr2lx2gyzvUINbEdXEvAn5hkC5QJkS5Y1PxvzdtArr34x8gjRnl
I90r0Qr2I906j6p+PmZfRANZjnMnGioaumzHCXhPLTdxjHQaisShKeuKG9i6vOFu
MDyQw9V98fwco/o0meku8vmM4gER3yQt7zBKphZ9Rj4mCsuTuYpRFVMLdcXxlEbA
fmm3GGjdGBw3IjB+lvIwk23s+8Rjw6GkPhiXZEaVfYCoN0hEfd+hMlKgh+5R5aVE
NBTXGMS8NKz+lvRrA7DbSQgCv9EZvPhwLX2nQWRHjZeP6i/srTPpfV289iWeuY3D
xAF5k/SO0XdKwK3NZhJk/Hms1gCeXmpIhIlElQYlm3sZMYQh9znFXC1x3hnT6tmW
mQQ33+P+ioRm/C0HVK8OEFswdt9+uIf5s4zGejY/26gkndhJ8RI=
=Eo8p
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
