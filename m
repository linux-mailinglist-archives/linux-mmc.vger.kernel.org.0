Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6612F22
	for <lists+linux-mmc@lfdr.de>; Fri,  3 May 2019 15:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfECN3t (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 May 2019 09:29:49 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45318 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfECN3s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 May 2019 09:29:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id o10so3550948vsp.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 May 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stZ6FrbCQvENNToP29H4XLypQxhEfxxBik6rsVzltL8=;
        b=hJor99eADGSy7BH75aOvVzj0ISYuIOrwHZoUVPqlMyNRoUpV36K2HLahXqIzcfcGwZ
         ts+L8RnjERJ4ofCuGghatZ5aYv2DI0gbeAyxH/v1jakPNZQzspui1vmpR1hA1QPrH2rZ
         smTrAfXcR8qYJpnO8Iy6TshnBG06EQ+0gb5Tkf1ULj68GZA34n7YN7IU8swba5aDLIPM
         p1guNy+mbn87KVGMPgHwlJQRD+Cov6aHKHiF+Q7dvNwbEycwv7UACOu12iWYgRlqXS7H
         /EwNCq4m2nWUssyiHMvvx9fr1NzgOTG6Uvj+t7kR+V049fXJwYvKyPwmuuxV+vFapvtQ
         U1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stZ6FrbCQvENNToP29H4XLypQxhEfxxBik6rsVzltL8=;
        b=HfnrwNuTBBlif13lkHW1OcQ3SfmYMBvwOvq3MA9Bt4aNlEIjMUdcI1QTTcztKssmTo
         WILsNmIC8wiPGmcauV5cCVrjkf/ZOvu8BtKKMYwmQmvT2KZUerTPuWD8TfWWIFI83fNb
         NU4r6RLSih2Was5UmQmG9P2JUXSFFc3Zs+WrmnEoW0jj3MAmEsnTJdeQlzCjJaPR8o1n
         wPThtZBiScNn2iSVR0G1d5VinMQ4MYYMkNfGiqho4QMTq+Q/V+AqPFl3Kn08v5BfSdVd
         40LdiAgrVJw3OoEW9Syo81B6eqMSRlkL7QP7udKOesxuBWQIf01fmceOIY82z6XkWSbu
         PtnQ==
X-Gm-Message-State: APjAAAWtoTK0nI6vrxDiunmnrL70Oxj2kmmW4iq6bL9p0mlvIUN8o4o2
        d59N7phn3EvA4yZUkEBS6AYoqKh1WuQY0hmU3Ti9AGEd
X-Google-Smtp-Source: APXvYqwwVgRZj147HHgDwpNYnaxqQgwtO2KsWndKtml3VjSfKsFGlg5s7RTXQTvJWWXIwsM5QQ/aSTyuE/FwXvSdFBc=
X-Received: by 2002:a67:84d1:: with SMTP id g200mr5558816vsd.34.1556890187183;
 Fri, 03 May 2019 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190501203621.GA11352@embeddedor>
In-Reply-To: <20190501203621.GA11352@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:29:10 +0200
Message-ID: <CAPDyKFr0KrUCuBpYyypKiUsin98XaYOVUx8MuDEpxvm6knxrzw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 May 2019 at 22:36, Gustavo A. R. Silva <gustavo@embeddedor.com> w=
rote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> In file included from drivers/mmc/host/usdhi6rol0.c:9:
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_timeout_work=
=E2=80=99:
> ./include/linux/device.h:1483:2: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]
>   _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro =E2=80=
=98dev_err=E2=80=99
>    dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
>    ^~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
>   case USDHI6_WAIT_FOR_CMD:
>   ^~~~
> drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    usdhi6_sg_unmap(host, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
>   case USDHI6_WAIT_FOR_DATA_END:
>   ^~~~
>   CC [M]  drivers/isdn/hisax/hisax_isac.o
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_stop_cmd=E2=80=
=99:
> drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    if (mrq->stop->opcode =3D=3D MMC_STOP_TRANSMISSION) {
>       ^
> drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

I took the liberty to clean up the comments, avoiding to break 80
chars per line.

Kind regards
Uffe


> ---
> Changes in v2:
>  - Turn multiple line comments into single line comments.
>  - Fix additional fall-through warning.
>
>  drivers/mmc/host/usdhi6rol0.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index cd8b1b9d4d8a..f0cc5e0dbf79 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host=
)
>                         host->wait =3D USDHI6_WAIT_FOR_STOP;
>                         return 0;
>                 }
> -               /* Unsupported STOP command */
> +               /* fall through - Unsupported STOP command */
>         default:
>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported stop CMD%d for CMD%d\n",
> @@ -1687,7 +1687,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>         switch (host->wait) {
>         default:
>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
> -               /* mrq can be NULL in this actually impossible case */
> +               /* fall through - mrq can be NULL in this actually imposs=
ible case */
>         case USDHI6_WAIT_FOR_CMD:
>                 usdhi6_error_code(host);
>                 if (mrq)
> @@ -1709,10 +1709,7 @@ static void usdhi6_timeout_work(struct work_struct=
 *work)
>                         host->offset, data->blocks, data->blksz, data->sg=
_len,
>                         sg_dma_len(sg), sg->offset);
>                 usdhi6_sg_unmap(host, true);
> -               /*
> -                * If USDHI6_WAIT_FOR_DATA_END times out, we have already=
 unmapped
> -                * the page
> -                */
> +               /* fall through - If USDHI6_WAIT_FOR_DATA_END times out, =
we have already unmapped the page */
>         case USDHI6_WAIT_FOR_DATA_END:
>                 usdhi6_error_code(host);
>                 data->error =3D -ETIMEDOUT;
> --
> 2.21.0
>
