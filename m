Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8370157
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfGVNmc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:42:32 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41500 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfGVNmc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:42:32 -0400
Received: by mail-vs1-f68.google.com with SMTP id 2so26088796vso.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaHBjnJFvYpr3DEes/kuOj/K1B5xxoaa1SMu0FmdZ3M=;
        b=rUdEOJR+JNagLCPUzILfIEZUMlA1SQNhUMpKPyVuDLCcj4JfRx+/sKLpXNhfhUz87R
         yqMfG2d5VsWW0cshTolWC9H951TN2G0ZXUjORbyg9lV/WeaWMjU2M9+G1fu/+KrIGwFI
         WPHGA7InTjURufNG2KmUKaJ2wfIzW0/kQumXjx7nHV27S6+pafh6+YYob0dA5rwRp+8/
         RdOy7xdhu6q4z689UGGbUuaCA5ExWd/+WXW8TpptH56iU/TZdsxlfOCfZZRT6fzD5rdl
         N1a7wZdwNvB0wSCMDc6w8btAnHwIiqzOxYbSOAkOaO0TwhA/r4XeIcctkVnWwxFFrxJX
         NMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaHBjnJFvYpr3DEes/kuOj/K1B5xxoaa1SMu0FmdZ3M=;
        b=asL8QJqxjn3AxnNJB2UgpZPup0Uo8PY2ScpWO1GliG/WoqqYYPCu710XKv2yZfBOeG
         lg50hM/ucEXT7oi27LfqWpRVufgEFsQm2MPk8vnIRThmmdyFVQLW7SbdMJ02trEfm1jf
         AwtpDGKRbO9LSjhcZZiIgt8k10I9pJ23Jm/+Q+6y3ZYlsVdelQrvgFveULQxmGs2MRo+
         RA+f626MFkh2s7gy0uAdTyXrjNI3suf7R9IR3bfBIjY2IXQvj8eAlAK5onZ02RREtho0
         1ufEckd95waUVqUKXVsTRv9fexIavcNat6A1kCnWeQpKyhsFF5M2hCiQZAoxzKJPAtxl
         3c8g==
X-Gm-Message-State: APjAAAUFnLAfVARTQA1lmXekLUgMV/M1DNvXrCoWebQ7N3aoW8Xp/YZX
        GkhSpnuTCN7IiJcCTflnf/A4bfxLXAV/FMdFmUW7Pg==
X-Google-Smtp-Source: APXvYqyaTv6dJJcv21QQoGgk4eHCM+fKgbd4PtuMRgYz4E+1WOStaJicLhi/fi7A0uYMGvSu0i06RMfT0JeZWXKX4O0=
X-Received: by 2002:a67:8709:: with SMTP id j9mr42144801vsd.35.1563802951387;
 Mon, 22 Jul 2019 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190709135351.25628-1-larper@axis.com>
In-Reply-To: <20190709135351.25628-1-larper@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:41:55 +0200
Message-ID: <CAPDyKFpT7HtJbWo5Em6f+UU+7t7eNGb+WypCzg5xumzqvE=aHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: Add maintainers
To:     Lars Persson <lars.persson@axis.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jesper Nilsson <jespern@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Persson <larper@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Jul 2019 at 15:54, Lars Persson <lars.persson@axis.com> wrote:
>
> The usdhi6rol0 driver is exclusively used for the ARTPEC family of
> SoCs. Other SoCs with the same IP of Panasonic origin use the tmio_mmc
> driver. Therefore we assigner maintainer responsibility to us at Axis
> until the two drivers become unified.
>
> Change-Id: I38b6fd0addc1d93ae172332b67e6eb71c0871508

I dropped this.

> Signed-off-by: Lars Persson <larper@axis.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 677ef41cb012..a91d04e5c084 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1432,6 +1432,7 @@ F:        arch/arm/mach-artpec
>  F:     arch/arm/boot/dts/artpec6*
>  F:     drivers/clk/axis
>  F:     drivers/crypto/axis
> +F:     drivers/mmc/host/usdhi6rol0.c
>  F:     drivers/pinctrl/pinctrl-artpec*
>  F:     Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>
> --
> 2.11.0
>
