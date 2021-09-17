Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19440FD67
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Sep 2021 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbhIQP6X (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Sep 2021 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbhIQP6V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 11:58:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2BC0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:56:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o8so6487854pll.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PGP90rGrx9Q/B4QCSOjOFqunMnqzEXwIkqq9k8atHps=;
        b=ndpEhuAFaSf+VKhSsdGkhk1t8wZvo2kOEpwhVl8Uc7QPrpRUJatzhcIoIXAvOodFiT
         j9A6gHvoFP3+d0I70cP2Wm8/2tKrj9jOUZNQtV5e/dchiaFc1tluEFhx3BuEsgryQOCC
         3bAzwxTYoFiNda41I8OWc1aYnHj1aRByiuC6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PGP90rGrx9Q/B4QCSOjOFqunMnqzEXwIkqq9k8atHps=;
        b=WkwtRjEkxUd+ucSHpZHHx8r/uwvjTSMn/UD+RIg1iq9C/HB6VhOQs9Il79bedPeQ6c
         7T7GbhYfSUZ6qZuUkrTay3flfo0zj5m4puBCT2SNKv1RpEpU4+FoBMgp+pFhReGMs+LT
         kE27FxJoAr83JwnONyVpPPshqoBHqz8SBV6UyKCh3kT6NcJwzf30Vr3+tuO1P2efy6Aj
         cb4yAMxbSUKNy/XimFtGTXJvAlX1PZUdjYxIlRVYIINjDFBWJsODEDuCX37nAw94/03u
         eAWsah/6QFFABI9M5E13nMZeAQeUunub8LsLClWk4mo4l32E5dgSHFR8w7U8uHPZjqjI
         dFTA==
X-Gm-Message-State: AOAM533SBtQr1XM5yQopgC/hM38PruXnrvV8bC8UgVNxb0FoWGR+eMWL
        IQRqP9uiu1wBxm4KiOXsLphKxw==
X-Google-Smtp-Source: ABdhPJxuE2pcxHAXT7E8aoPaByNbXnM5kqHn5Dpxd8dr/lCPpKeAjwJ+TGvxC9Ma0RX+KMf6E3BhXQ==
X-Received: by 2002:a17:902:e54f:b0:13c:a004:bc86 with SMTP id n15-20020a170902e54f00b0013ca004bc86mr9475793plf.78.1631894218277;
        Fri, 17 Sep 2021 08:56:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y195sm6959896pfc.7.2021.09.17.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:56:57 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:56:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
Message-ID: <202109170856.8DDB49112D@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-6-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917061104.2680133-6-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:03PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit.
> 
> Turn it off.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/mmc/host/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 14004cc09aaad..2ab083931f8fd 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> +CFLAGS_sdhci-of-aspeed.o		+= $(DISABLE_STRUCTLEAK_PLUGIN)

This isn't a stand-alone test object, so I'm less excited about
disabling STRUCTLEAK here.

>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

-- 
Kees Cook
