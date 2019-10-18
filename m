Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB1DC33A
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfJRK6s (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:58:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43319 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJRK6s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:58:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id b1so3710164vsr.10
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rio9HHOlkvh+lIpCQASjDvFu34ch6yz1YASODTUfN2A=;
        b=x+ivwMa1fuOo73+TkPEdt11VJpA5s5IaNM4sh0A4umv+Kpq/SIrNSspl+Tx6BxkHYY
         RGSVUmvMZ49HKAPY82E2W2EXufUFG0ArEJgsKO2irYjk/IFl7cZriGK8qRvmlpM5DiI4
         cW4RyJmj6uE0YSjjvo3dcX10dzCulzvu3Wdu8JdDMZA8ZyqvmS1gBcQtAT6sZMSEGUxe
         b3hhe8+ibWVBQRUWstv/Fvg1kRt6EKrLFHH+vqY7nvhAYcBSj/NDyg1zXhKZySE4005U
         /Gbap+Mi81K6+uIXOrxUfYlABOUqEqwZBfS0dsqwISFWanRaHb3jm1VdybIarZTQFU0m
         4jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rio9HHOlkvh+lIpCQASjDvFu34ch6yz1YASODTUfN2A=;
        b=WE+DzEIAkg/3Ueld0LbjuOZMcrnihmSReQooqdVxancFAcCUMpY+YMeOb3uLyNyTR8
         a2oED6CDgR5TwWhw0bp52DcpBDDo7hu09jye/fHyXhuo8tZ+qfvJqXcjVHM4haMQ2RCT
         Dw2SEqaQ4SsAJib6pElgb1/xzRtuWAZaEDk1XLhsA47iV3sx84qBysg8eEkvhddZP/LC
         cW2sGB9RHT/5sNAB+AFRYk7rJkhD4vrIupgTdqB2wRSWKutHik4hWHbvzx57NHXe9/wI
         i+IXrnxyYIG5P93fYCfvjZit24IopXhN+0rpCv6mivMeZAZxPXhDDi3VFM4jElys0SCO
         EVxw==
X-Gm-Message-State: APjAAAWnVKN15PNk7fDh1DvSy3qamHk3G2pS9jFatk455URuWBauZh/X
        YsDiRwKUo1ReXcHt00Sdr8zHLVblKo//Gkd4C95F7g==
X-Google-Smtp-Source: APXvYqwRBr47REEzkA0e8ZYJ3EAkV4RqwFlssr91UqI3z8UAFs6Fwd6iaf/97SDUNB8MbcQd5ZnSNa99yYm/Z5IUQR4=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr5230380vsl.34.1571396327014;
 Fri, 18 Oct 2019 03:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
In-Reply-To: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:10 +0200
Message-ID: <CAPDyKFqcOKhqza=Gbjbwim1no2_NBLEzrq6JRoK_7U9hGXL5Xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sdhci-of-at91: add the
 microchip,sdcal-inverted property
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Oct 2019 at 14:34, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> Add the specific microchip,sdcal-inverted property to at91 sdhci
> device binding.
> This optional property describes how the SoC SDCAL pin is connected.
> It could be handled at SiP, SoM or board level.
>
> This property read by at91 sdhci driver will allow to put in place a
> software workaround that would reduce power consumption.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 1b662d7171a0..503c6dbac1b2 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -9,6 +9,11 @@ Required properties:
>  - clocks:              Phandlers to the clocks.
>  - clock-names:         Must be "hclock", "multclk", "baseclk";
>
> +Optional properties:
> +- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
> +  inverted. The default polarity for this signal is described in the datasheet.
> +  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
> +  and a capacitor (see "SDMMC I/O Calibration" chapter).
>
>  Example:
>
> --
> 2.17.1
>
