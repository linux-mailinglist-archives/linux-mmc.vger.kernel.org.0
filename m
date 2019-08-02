Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFC7F84A
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfHBNP4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 09:15:56 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:40078 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfHBNP4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 09:15:56 -0400
Received: by mail-vs1-f47.google.com with SMTP id a186so49670134vsd.7
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL96+oW/yqu3GlB2SHdxWs/IB9gZGL0u6XkpAaVxe90=;
        b=W2haaDFt0cdqbuQ6wOx7VPvVg45sIrjMKmNCAkPRqnU4gRiHj65YokpvB0+bq6xkvt
         4QDaSXqcY8rezBV/GQ+f2ZXqQkMaMt/Z3CgDrsgq6OYcZoWaTpCO0rt1yvmrIwxkKQcc
         vIDonnAohXsWs58Mu0ZD1q5cOT3JvnZ8U/D37am3q/ypnRxpW3xmjKyQlyhW3u1DTV30
         ZnXWc3LKgY/fkpKQNPk5EBZA8S7M45WkRperCUeaScQ7B9dQb6nYXRocgWin+XVcMXcV
         aUwUzvNTFr6uKhYgx5UHej8H0kTrH9zphf6FVQgPCowEZkNhlmnQKiT4e6EzfcK6i6fM
         Y83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL96+oW/yqu3GlB2SHdxWs/IB9gZGL0u6XkpAaVxe90=;
        b=Dn/MV8kX8VH/MgL3i4tJjwNYH/zxtaar2i1YfLzRRoO5fnOLgA+UfBGISSGfobhbLF
         4CU+g9LUNtAT4RGgXgMbgsZSGb8cyUbPSRbRwpPNJs+BUzdpOCGWsAENhFYtLSBMVpxa
         kpX06Tp4r5pgYmBn4fwF5rPRdQ54U/V4gLInzqKilTwm3HkTS38MCeO4GzNrkasTXvHQ
         JyUxpfMm7UVxSi2jEtgr4iBEX+QV0LxsfLnAahhhnWL1GvlMftW99accEgst5hCWQQd9
         sMSg0T45L3YCsSXrC6jcx9FnME4VuG0+gpUGaS6udES8171nx+kaY1PVGxO3UHhzkEp1
         FVfQ==
X-Gm-Message-State: APjAAAU2A3TCzfwbwOvBmSvteOjqtHdX3616Pn6+2T58zGOQWeILmV+Y
        63Euv9CPJpkAisQFOccM3soY8MJdkwulm73VDe+eJCXfyDc=
X-Google-Smtp-Source: APXvYqxJaTtdjhHhhXhev+Vv/CzF8amr2LXIcv2Msiu0N8vSgUVztfGWyGiS61mURNZ0FIGqiKTbhJqnOOYvkId+sXE=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr1715060vsp.191.1564751755311;
 Fri, 02 Aug 2019 06:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
In-Reply-To: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 15:15:18 +0200
Message-ID: <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com>
Subject: Re: Possible bug in sdhci_set_power_reg
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Jul 2019 at 15:17, Phil Elwell <phil@raspberrypi.org> wrote:
>
> Hi MMC team,
>
> I've spent some time trying to add a regulator to control power to an SD card
> (vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
> I found that powering up the regulator during the boot process was effectively disabling
> the SDHCI controller. Note that this was despite having regulator-boot-on set in the
> device tree.
>
> The problem seems to be in sdhci_set_power_reg:
>
>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>
>         if (mode != MMC_POWER_OFF)
>                 sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>         else
>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>
> This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
> register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
> Select bits to 0b000 (a reserved value).
>
> sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
> select bits, so I found that (in my limited test cases) replacing the if/else above
> with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.
>
> Can anyone tell me what I've been doing wrong, or suggest a better "fix"?

There are other sdhci variants having the similar needs, hence we have
the flexibility available via using the optional ->set_power()
callback.

Have a look at sdhci_arasan_set_power(), for example.

Kind regards
Uffe
