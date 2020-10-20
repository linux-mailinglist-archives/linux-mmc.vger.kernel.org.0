Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1D293F44
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Oct 2020 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408114AbgJTPIC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Oct 2020 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407644AbgJTPIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2020 11:08:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DE9C0613D1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2020 08:08:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id r17so771218uaf.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2020 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YpTMFQeEZb0rjpUuW6XXMOAXIdREE2jLBrSTZUeG4I8=;
        b=U1XUF5DhInl+St5txZvE2N429K3nu9ruKXD64YmX2X9+frCh1aWremcUA85iF2PIx1
         DLK9xaE52MkGJALcimxPhnvF3IBiGas67tyRMEO11rVkqq2lMq8YJzOqqG1pvEgcHaVM
         QrU6NGgqq+aY7T8Bl7fUpiQM4tFebDK9yMrhenwM6yX58MjiEYyAMTQQ7YrFTE6lxtUi
         OXaQRoagMEWU3zF0JrOSkFFMp+bcFDs4SvBOnhtj57cGNHe212D2YzYsy6WeE2rXyg0G
         y0Hx3T05Dcv4O0QwgqD0NlzZ/TXN5kk8ycpPqPu7i3n5fTgYQGkWxShdlqxNh00mY5GT
         nXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YpTMFQeEZb0rjpUuW6XXMOAXIdREE2jLBrSTZUeG4I8=;
        b=hNgChhcHXh//ZpXTsLX5SXtR4UrNVzBlN5no7EP1EJhuk81ZFyPNYPkuf3TTC97OcY
         sQ30repTQwGKrlF0l1buj8gtAaUiHK96DQQrKX7xF4OIVCxGVHQBkqtLpkILkxtfMv5h
         L8f3I98Ao79SoSZngTYObx/9REBikvKTCBNmoV8O6M+7P4focqLg9i7+bUjhBWOYAmbr
         LztD4EBXAsSyRPL06K1EAZXu4IOq3vBE0AO3nmcCxE97n5+zgi2EdPxQ+935zwJm2L0x
         qprauSIQSYiXNEVionW4rs+zdoX5/XbehMXi1IUDz+ZKPOBCgd1bo7A3uRrB+frjbDk4
         2SZA==
X-Gm-Message-State: AOAM531zqwSpdrcN7pibas4YIwilhVm8rayiW7eovumuhXfT1ECtlYYQ
        tQb5wT2xGWMonmvuvv5iji7D1KW1d3T8fMFVSr0ZFQ==
X-Google-Smtp-Source: ABdhPJwm/KewgGT5Q4WyxYXhPhUG/Zzq9WDofYxTVkmfKUiHImFkm6avmj6ccvMkFsJ3lYGD58oCWd/inLtq/UlBoG4=
X-Received: by 2002:ab0:6f11:: with SMTP id r17mr1324840uah.15.1603206476961;
 Tue, 20 Oct 2020 08:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201020125817.1632995-1-Jerome.Pouiller@silabs.com> <20201020125817.1632995-2-Jerome.Pouiller@silabs.com>
In-Reply-To: <20201020125817.1632995-2-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Oct 2020 17:07:19 +0200
Message-ID: <CAPDyKFp9pnK0T2xKaXcMUzpxO9OCD49Od=ML+gdQbNndrX0Bag@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] mmc: sdio: add SDIO IDs for Silabs WF200 chip
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Oct 2020 at 14:58, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Add Silabs SDIO ID to sdio_ids.h.
>
> Note that the values used by Silabs are uncommon. A driver cannot fully
> rely on the SDIO PnP. It should also check if the device is declared in
> the DT.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/mmc/sdio_ids.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 12036619346c..20a48162f7fc 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -25,6 +25,11 @@
>   * Vendors and devices.  Sort key: vendor first, device next.
>   */
>
> +// Silabs does not use a reliable vendor ID. To avoid conflicts, the dri=
ver
> +// won't probe the device if it is not also declared in the DT.
> +#define SDIO_VENDOR_ID_SILABS                  0x0000
> +#define SDIO_DEVICE_ID_SILABS_WF200            0x1000
> +
>  #define SDIO_VENDOR_ID_STE                     0x0020
>  #define SDIO_DEVICE_ID_STE_CW1200              0x2280
>
> --
> 2.28.0
>
