Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89D99301
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Aug 2019 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfHVMNl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Aug 2019 08:13:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37042 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbfHVMNk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Aug 2019 08:13:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id q188so3675649vsa.4
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2019 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ly6KX3kvL/W0ycoaNLTVk5Ihkvoe8Wnu3biVwC7K5k=;
        b=e+s77JT2cpzLx6Bok8gRYEyL3sIJy4MY0tlRRujMgKNbw6Z8D3adtcuYtllumK+DjH
         LrHgjsL1mpImPi9hm6KbpBAAchu2bX0CfUzY6uYJjTeSuNqn6Wcgz2KcEnwVw6Pe/JpD
         oKBN8X226wmaOyQuFVPK5p8PY+SwbN9m5mTaOL+YUCPd9ztzxrq/fneELEak3mkQUbRD
         MYNbzBNBfg0IIdZfwMJqM9/zCu0TyPnJ89zkl32BKEuddVAN7XgJLendjEh+3sU1emMB
         Q9iajclIOnQww/YNvGzunL8wkFKWjd3INZO0vdCfiVEOCPZMpO7URRy4oOPu0Mi57523
         ZeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ly6KX3kvL/W0ycoaNLTVk5Ihkvoe8Wnu3biVwC7K5k=;
        b=C0C7EU/XkozF015CK61y1S96Ril5hrVTyVzAb+/H1bdb5fV00jpraHsps9cJhXJOp9
         t76r7hkILTEc19zsnqmTNekwNcs6FbmH/hcTaS/wqvpgMfcilQ+XrMFgwLMJmQ90jctX
         hl5Iu4Pbo9xxzvFShodjR0kF5/VwoQFEwByBiqiertf5EUBCQXMpGy4vJZAcJEGLOVFL
         UqKI0hwhkOKTZsxVcYG0kyoUsl+/l8GtIeQKf/pSk5HgLFtY2Wta4CPKNSL1TS7hyWA9
         DbUlJ3052y9wQimKqL8arPPHkFgF90w6VwlaZT5ZbaP4ZWMvRWykc9hwITIkX0oCITcl
         cpew==
X-Gm-Message-State: APjAAAWcEyGT5oFDah7FMsRqC5LCDBGNrrCGt9lcJnGD5rVCVQ+fE2JG
        ZHVsRlVB6iYYevEAUIVIExT34clSNAzzLDclgWTxMK/U
X-Google-Smtp-Source: APXvYqytHCOMHR5M9lts8SdpAxk1X76n5u7WLvfmxOXVJUEBRHaXV9qwemPTTdfSZATLeZEry7/4cv0gzsDJKxqcftg=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr24652042vsb.165.1566476019397;
 Thu, 22 Aug 2019 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190814072649.8237-1-yinbo.zhu@nxp.com> <20190814072649.8237-4-yinbo.zhu@nxp.com>
In-Reply-To: <20190814072649.8237-4-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:03 +0200
Message-ID: <CAPDyKFpwGGPAShEoXPK8Ksg5FPEVrbD3-HfeTSMACPsDC_V5FA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] mmc: sdhci-of-esdhc: add erratum A011334 support
 in ls1028a 1.0 SoC
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Li Yang <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Aug 2019 at 09:24, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> This patch is to add erratum A011334 support in ls1028a 1.0 SoC
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index b16f7d440f78..eb2b290447fc 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1006,6 +1006,7 @@ static struct soc_device_attribute soc_incorrect_hostver[] = {
>  static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
>         { .family = "QorIQ LX2160A", .revision = "1.0", },
>         { .family = "QorIQ LX2160A", .revision = "2.0", },
> +       { .family = "QorIQ LS1028A", .revision = "1.0", },
>         { },
>  };
>
> --
> 2.17.1
>
