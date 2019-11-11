Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00592F747D
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Nov 2019 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKKNFX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 08:05:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37225 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKNFW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 08:05:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id u6so8631446vsp.4
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8vYvx18GD5TBNd1q0mA7jDSSmkQRIuSLUp/v+fUMPA=;
        b=Mr3jgn8X85TRmMABlrppdjqKXTw3KoQ0tkejNY2UUpSNRBX4S1su6qu9/bD/8aiibf
         vL7rp++v1RVTiZIvvNVJG1X/INTj3uzIglB6Lyo55sqFpH6itTcsrScfFVE1T58FOimr
         ZDpg3mH6j2crHZMGuJxEGRFJFiTE4Yn/uC750/u4TFUbXzj7VdPV4YyqpdGkK1wT4RIw
         HW+GpYCl/MWI9UYpf/EyAJaVnNN5MtuI0IR1iSyP3EXmAE8jtWaOlh35qGKFwLNIJOig
         jTo0hoeXucWpQ678zzjlmCLNoBYMP+40Mv0yOB3CVGTFgwkYSpRAzw9qOvdR88GOxXtZ
         2r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8vYvx18GD5TBNd1q0mA7jDSSmkQRIuSLUp/v+fUMPA=;
        b=ZAh/XefghXG0S95gc9ZrxUErHCLSk63G39fQfCbI7bEWPPjSlF7SGhoDiGgCnDwpRk
         E8ynhtAVGPsE7gtSlKInaaLC12X9Ziom1ORyPw8xj52F3DiHMbZ3g+hv/ZTx1uEKznu5
         3cSu3iWR+mtyAQWr2cYw1igD3zb1VfVkSPMJdDC288x50QbkippnVrdzXdUEA0ZB9oZz
         Phi5crkBpMipy82U/JVKh6P1nn6jZU1CALvld4LGzdmXNwWKN4BhN+Ya4lEqLDH7oe4+
         S+IDKdsFrEmSV1pJJk8gjLBEMzk0RQb6nle8gthgveAqOKgtbi+/OhqLvffVRsjk+XvL
         EjeQ==
X-Gm-Message-State: APjAAAVYtoQAhuiJtMwK2XOC2gJlEIsh+Cb303DK8ei9gfHr1eVX7HPx
        JrTj8yJ6dB/VPjEB09e+XfMFm4XqAv8+scSN5DOE7Q==
X-Google-Smtp-Source: APXvYqxGAuQCp/8AvEDPLKZli/PbYKhYU1pS5j8TWO3nkfvlnOb8NUdy0lHofs5UupjfdckHmocertmwl5UWj2f467A=
X-Received: by 2002:a67:2e0f:: with SMTP id u15mr19259795vsu.89.1573477521399;
 Mon, 11 Nov 2019 05:05:21 -0800 (PST)
MIME-Version: 1.0
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Nov 2019 14:04:45 +0100
Message-ID: <CAPDyKFropF-au2OTgyRL8-sO0MKXs3GtZGMqYpWpsKHtfdtpyw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [1/3] mmc: core: expose MMC_CAP2_CQE* to dt
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Nov 2019 at 07:43, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
>
> Expose MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD
> to host->caps2 if
> 1. "supports-cqe" is defined in dt and
> 2. "disable-cqe-dcmd" is not defined in dt.
>
> Change-Id: I3d172e6bcfac34520c3932a6f8df2e20f2c0d05b
> CR-Id:
> Feature:

Remove these tags please.

> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/mmc/core/host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 105b7a7..efb0dbe 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -319,6 +319,14 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_NO_SD;
>         if (device_property_read_bool(dev, "no-mmc"))
>                 host->caps2 |= MMC_CAP2_NO_MMC;
> +       if (device_property_read_bool(dev, "supports-cqe"))
> +               host->caps2 |= MMC_CAP2_CQE;
> +
> +       /* Must be after "supports-cqe" check */
> +       if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> +               if (host->caps2 & MMC_CAP2_CQE)
> +                       host->caps2 |= MMC_CAP2_CQE_DCMD;
> +       }
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> --
> 1.9.1
>

Otherwise, this looks good to me.

Kind regards
Uffe
