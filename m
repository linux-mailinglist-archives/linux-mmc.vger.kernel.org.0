Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD0122BB5
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Dec 2019 13:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfLQMez (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Dec 2019 07:34:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:33316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfLQMez (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 07:34:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22098AD14;
        Tue, 17 Dec 2019 12:34:53 +0000 (UTC)
Message-ID: <d356ad7ac8387f56c03fd24d04f471d26ff9ae7c.camel@suse.de>
Subject: Re: [PATCH v2] mmc: bcm2835: Use dma_request_chan() instead
 dma_request_slave_channel()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com
Cc:     vkoul@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 17 Dec 2019 13:34:51 +0100
In-Reply-To: <20191217122254.7103-1-peter.ujfalusi@ti.com>
References: <20191217122254.7103-1-peter.ujfalusi@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tBZ5rr+Ad+DYa6kDGNIu"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--=-tBZ5rr+Ad+DYa6kDGNIu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-17 at 14:22 +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
>=20
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

> Hi,
>=20
> Changes since v1:
> - instead of returning jump to err: to free up resources
>=20
> Regards,
> Peter
>=20
>  drivers/mmc/host/bcm2835.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 99f61fd2a658..c3d949847cbd 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1393,7 +1393,17 @@ static int bcm2835_probe(struct platform_device *p=
dev)
>  	host->dma_chan =3D NULL;
>  	host->dma_desc =3D NULL;
> =20
> -	host->dma_chan_rxtx =3D dma_request_slave_channel(dev, "rx-tx");
> +	host->dma_chan_rxtx =3D dma_request_chan(dev, "rx-tx");
> +	if (IS_ERR(host->dma_chan_rxtx)) {
> +		ret =3D PTR_ERR(host->dma_chan_rxtx);
> +		host->dma_chan_rxtx =3D NULL;
> +
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			goto err;
> +
> +		/* Ignore errors to fall back to PIO mode */
> +	}
> +
> =20
>  	clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk)) {


--=-tBZ5rr+Ad+DYa6kDGNIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl34y2sACgkQlfZmHno8
x/4RNQf9G4eHpfn79sBZ7cjLKSUuneBG1qqhlSE5MZC2jnxYng41/8xysCdq/WTG
P/LOanHY0hxM3Ye6OV35L1i6Ot+0VqE2DZmDoSHdkDcogx03/u+D3e2epyLuk7fG
HrbaNZ7bV/MP+3LFXXsAmHd/DPdgZ663iTFEwlzOtPapd/LGAT5KuVs5V+ib/XLA
ln6xfJVQXYB7oO9m8ot7vE7yXS5gksEZvVskDWZCpXZSzMLC2DuU+CHQnHUXXonQ
yAC4OhZ0DMhD2I8es+5lv4VwM9OwFxVPbZjgc3CQj0RpWni8L4J16t8fDNX6b2pG
jpncC5yVkZWUhYPZNJkabnx9A7YNwQ==
=WeHO
-----END PGP SIGNATURE-----

--=-tBZ5rr+Ad+DYa6kDGNIu--

