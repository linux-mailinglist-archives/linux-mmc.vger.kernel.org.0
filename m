Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7561910516F
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Nov 2019 12:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKULan (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Nov 2019 06:30:43 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40309 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKULam (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2019 06:30:42 -0500
Received: by mail-vs1-f67.google.com with SMTP id m9so2004695vsq.7
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2019 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzOo2JV6kkqnrwHkbUSJuC+75l0A5IKM+uRyHywuXgo=;
        b=lg4JgcZK7t2R0U9FLgUevhlhy7bVd0uQOQbZ4FU/lBtzXd/Oe0ED7vvfm1wvlaHer3
         swUXak8Mp79XDGOXu3i/EslwDffIo0voi3c3icVXgsFPaSVRwrKOttt42XJba2hionhC
         1Hk3DX9a3lazZ6iu4L60+jNWjOusc+WkPQBo+Le3GPYbUEMKz9yEKSh4RB7iTBvA/3Sy
         s9USQXzn4lNKgwvl7WR0/+JlRPv4ytRumvQ9cbf8UDEYbNrsNoDfC/A/GToOD7ELC/Z7
         A1pzL3o9mIogCGh2Vz4fbrJCXjZ+fnCMFyqKczspqNnwVhwbX/cdn7qQzxwqnJoL6YBn
         O40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzOo2JV6kkqnrwHkbUSJuC+75l0A5IKM+uRyHywuXgo=;
        b=ilB1dd3TUbAFV2kL4vGbT6KhG1KalZrferkAj/jjJSalsG+mg0uVEaNCFnjnG8dL5T
         KOBtHXvsxXooleB9wzc15DpTxtkyvVQy1Ed1EFouNY5inrEJtuCPtTVaIxnjFSJedK7N
         mSaJz/rFpYdJmxs6aWSB6h/CWDT2StQJmnuoTE3xOZFVGJbUqxPFbiQvDru895JkkAvV
         b3H8W+7rF4elcCIAvd81haM5cdnHL5jAOuj3KiZrHaNMEOKrbTT1zwDwSoWx2TafxF9h
         AIt2UidazqWPG2hPIVyWzkIeR4IU8R77x+ZhoNogJjDjN6PHak6O58hVo3oFeNzZMuge
         MTww==
X-Gm-Message-State: APjAAAUaxiYM1ReiRVYK98h5JxGhTimKyvnNmIbGdoSTuVm1A6a0GXvP
        2by367u6CxA06sgfID9AkuII+VAMGPh/GrZwe0j5XA==
X-Google-Smtp-Source: APXvYqyi/CNSLQC7kcZJtahFRlILYFYUIVR4PapSxddBUrS44erqpLciYYxGapgJhka0MHjM+RpzfqX/W4c1YbQcBh8=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr5559804vsr.165.1574335841550;
 Thu, 21 Nov 2019 03:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20191120134101.14738-1-krzk@kernel.org>
In-Reply-To: <20191120134101.14738-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Nov 2019 12:30:05 +0100
Message-ID: <CAPDyKFohHYuqu=a4PJMqPq6ydNGcVjVMotyiSniF=mhZQ-qa4Q@mail.gmail.com>
Subject: Re: [PATCH] memstick: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Nov 2019 at 14:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/core/Kconfig | 18 +++++++++---------
>  drivers/memstick/host/Kconfig |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
> index 516f454fde14..08192fd70eb4 100644
> --- a/drivers/memstick/core/Kconfig
> +++ b/drivers/memstick/core/Kconfig
> @@ -6,16 +6,16 @@
>  comment "MemoryStick drivers"
>
>  config MEMSTICK_UNSAFE_RESUME
> -        bool "Allow unsafe resume (DANGEROUS)"
> -        help
> -          If you say Y here, the MemoryStick layer will assume that all
> -          cards stayed in their respective slots during the suspend. The
> -          normal behaviour is to remove them at suspend and
> -          redetecting them at resume. Breaking this assumption will
> -          in most cases result in data corruption.
> +       bool "Allow unsafe resume (DANGEROUS)"
> +       help
> +         If you say Y here, the MemoryStick layer will assume that all
> +         cards stayed in their respective slots during the suspend. The
> +         normal behaviour is to remove them at suspend and
> +         redetecting them at resume. Breaking this assumption will
> +         in most cases result in data corruption.
>
> -          This option is usually just for embedded systems which use
> -          a MemoryStick card for rootfs. Most people should say N here.
> +         This option is usually just for embedded systems which use
> +         a MemoryStick card for rootfs. Most people should say N here.
>
>  config MSPRO_BLOCK
>         tristate "MemoryStick Pro block device driver"
> diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
> index 446c93ecef8f..4113343da056 100644
> --- a/drivers/memstick/host/Kconfig
> +++ b/drivers/memstick/host/Kconfig
> @@ -18,7 +18,7 @@ config MEMSTICK_TIFM_MS
>           'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
>           (TIFM_7XX1)'.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called tifm_ms.
>
>  config MEMSTICK_JMICRON_38X
> @@ -29,7 +29,7 @@ config MEMSTICK_JMICRON_38X
>           Say Y here if you want to be able to access MemoryStick cards with
>           the JMicron(R) JMB38X MemoryStick card reader.
>
> -          To compile this driver as a module, choose M here: the
> +         To compile this driver as a module, choose M here: the
>           module will be called jmb38x_ms.
>
>  config MEMSTICK_R592
> --
> 2.17.1
>
