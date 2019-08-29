Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3776AA1941
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfH2Ls2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 07:48:28 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43965 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH2LsY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 07:48:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id l63so2171214vsl.10
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/UJems08T/e/rVWLn74/4KxusO+sjRC5wAOV+EnKhk=;
        b=H+j5n2T6jtb6MwAMzHofdA21fuRGODOcXiTYmfqYykH8AI8+EWEVZdRtn93zzmiATq
         udC9h4dfqPtFy2IqgaU05NHnCFEXDH1Cfuvb/QQKnuznz5UZkCJCr+JJrgGev2bGJ0rA
         rzHXDijZvxRtWIpJyvYl+HQ/5KWOoMT81qH9fdtCrz/oa50tdIr7mv1iBHjWOGxwKJzS
         MoM+Srm0rNbZhmZBpDzhZHgILudvPlkE19MwVGrNyjs+c9Sg/6PHgDbuQc9SeyWqOoJr
         uoewzCmcxNaM/N8FHAMfrnqhoLFzAVGctOE7Fz7qhFamwDsyjaiIRzJJCtIiv9miVXR+
         z65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/UJems08T/e/rVWLn74/4KxusO+sjRC5wAOV+EnKhk=;
        b=Zsufu3ib3Z5MdUVikJNet3NbCmAWlwWnbP41rqAxqDHuFaMxazKEpwU92HymCj5y2d
         Dyobn7vjAWKCWtU4dd2ZbC5K/NFPQKSGzqjJZX2wPSpwhYS+w4MUjdCmhNkKHzSun8oY
         CL6BPSaYy+E1ToUDHYpOk7ZnNkB1uXQBASagjmy/rUfgZDEY0XJ5gUVwIoplWmQFAhaf
         z10I9Qf5Xjy/0Pl9NFv0eLtTE+BmrE+ewze0PZJYWIFDvmpGJhZWf2EjWAhgan0M1Nq9
         5i0qPVpVlNkqxePTQhWA4mKlTMjH/HKILIJDkEOJxkG8/6gSLgSjB0F9Erq+Z1rbKrWl
         tkaQ==
X-Gm-Message-State: APjAAAX9pLP95UmF8oS41lgFyKKivFrxZoyrO6YQXEr/EgKryhd+mk5c
        AwyID/b7EtSFFj2s96f3r4jD0KU8nV/88U66CNjS/w==
X-Google-Smtp-Source: APXvYqyg1IFDOT7WWebRNY7RJ6UtG+ER8Z41eJQOQjNZsUNVdCjdRynrBHgIgliKUfU02boEkrdRE+zsaPUvVJY6MPU=
X-Received: by 2002:a67:347:: with SMTP id 68mr5223627vsd.35.1567079303139;
 Thu, 29 Aug 2019 04:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190829104928.27404-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 13:47:47 +0200
Message-ID: <CAPDyKFooFQgBgK3N1Ob9rsT_7-5kqC9i7PeMxkkeAbnDP+Fwnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "# 4.0+" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The IP datasheet says this controller is compatible with SD Host
> Specification Version v4.00.
>
> As it turned out, the ADMA of this IP does not work with 64-bit mode
> when it is in the Version 3.00 compatible mode; it understands the
> old 64-bit descriptor table (as defined in SDHCI v2), but the ADMA
> System Address Register (SDHCI_ADMA_ADDRESS) cannot point to the
> 64-bit address.
>
> I noticed this issue only after commit bd2e75633c80 ("dma-contiguous:
> use fallback alloc_pages for single pages"). Prior to that commit,
> dma_set_mask_and_coherent() returned the dma address that fits in
> 32-bit range, at least for the default arm64 configuration
> (arch/arm64/configs/defconfig). Now the host->adma_addr exceeds the
> 32-bit limit, causing the real problem for the Socionext SoCs.
> (As a side-note, I was also able to reproduce the issue for older
> kernels by turning off CONFIG_DMA_CMA.)
>
> Call sdhci_enable_v4_mode() to fix this.
>
> I think it is better to back-port this, but only possible for v4.20+.
>
> When this driver was merged (v4.10), the v4 mode support did not exist.
> It was added by commit b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")
> i.e. v4.20.
>
> Cc: <stable@vger.kernel.org> # v4.20+
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for fixes, by adding below tag, thanks!

Fixes: b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 163d1cf4367e..44139fceac24 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -369,6 +369,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
> +       sdhci_enable_v4_mode(host);
>
>         sdhci_get_of_property(pdev);
>
> --
> 2.17.1
>
