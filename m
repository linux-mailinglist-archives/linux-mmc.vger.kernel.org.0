Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77552F79E9
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Nov 2019 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKR2b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 12:28:31 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39604 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKR2b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 12:28:31 -0500
Received: by mail-vs1-f68.google.com with SMTP id x21so195647vsp.6
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OTu7RzLc243iGue7chxiy8Vk2YRX4D1tgtKssbyxYs=;
        b=t5ZpWPMLeBDEvkNCdWobOXpY1rn8mKKbhlJAqH/nClIIPOo8xtotQlHbtDHya4Is2h
         oMEZKC6Qh/5PvNDFNmY7Qo0a3QcMJk8QVG0lTAlBXtjVdwYFZGnwxEfUmx0l/jfycAlA
         wQB0V12uNIgPHHMkZZzhcbKeXCUVhZeNQYZb9vvA6OAYGiQ1jyh3DqSXYUX4O4VUgcbM
         nntC2qRDQHoKCArmi5zgZ9chZOb3Z+WZDSz02rWVMpT8A+tmZWrPjxhJ990eCDT4/D7z
         1KGN6yioFbYO0lWiOBt1hF/sQINuGYPnD6hUG9Ty9K/hpA13WopK8gW42j8mHxk+adXW
         OKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OTu7RzLc243iGue7chxiy8Vk2YRX4D1tgtKssbyxYs=;
        b=kyj8PoPVzdJUK37XDnowsa5uZ01Vy214puqNwuDP8IkAO0avkGD8xUdsfGmwtF1lZl
         WkKg/Lu3sLi/hCmgFYKYYKl4Lx3eOxoWNCPU9/2cMMi6ULL5P/31wMS3ravR+8rvVsJC
         Wekb8bjIJv6uoDQoegXTZlCG7Net+/k5Vm72TbLiQJfRLPHsxo027vEfRajg98l51I6j
         /WyISMpd/Fdnb1tn8Cbho1L+xFmLh5c2lpl0GHi5E4D7N6nGddMYNqhDWJh27gmk9ni1
         OKWSnB/CZY41MAJ4+G7IKFPx0KYflmXETW2yL6h15LyOfYgrp3Y589E+c3AENVM+rgro
         3G9Q==
X-Gm-Message-State: APjAAAUgzbQ/3nkrpgtnlE4MYl5n/WZHaV0oQUrVKr6ym7DImJFHzTqF
        DNHL7G7jJ+gMbl8OXQKbXsMoBtYYIWSa+zQvuSplC2kT
X-Google-Smtp-Source: APXvYqwilC07dl1RnIx5npEnNIV0hBMmZ1Z8YLoBy1QbElednuBWAi2IH+P4714/fpUNZRzKUbKdgOH1iwmWYFORaFA=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr10817201vsr.165.1573493310523;
 Mon, 11 Nov 2019 09:28:30 -0800 (PST)
MIME-Version: 1.0
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
In-Reply-To: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Nov 2019 18:27:54 +0100
Message-ID: <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> Add SDR104 capability and regulators to SD card node.
> While at it, fix a typo in lcd pinctrl and remove two
> undocumented bindings from pmic.
>
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index 33df95e384b4..e86a6db54499 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -135,6 +135,20 @@
>                 vin-supply = <&vcc_1v8>;
>         };
>
> +       vcc3v0_sd: vcc3v0-sd {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vcc3v0_sd_en>;
> +               regulator-name = "vcc3v0_sd";
> +               regulator-always-on;

This looks odd. A GPIO regulator being always on?

> +               regulator-boot-on;
> +               regulator-min-microvolt = <3000000>;
> +               regulator-max-microvolt = <3000000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };

Assumes this powers an SDIO embedded card. Often those have a specific
power sequence, just wanted to make sure the above are really
sufficient? No delays or external clock needed?

[...]

Kind regards
Uffe
