Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380263EDEB
	for <lists+linux-mmc@lfdr.de>; Thu,  1 Dec 2022 11:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLAKeI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 1 Dec 2022 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLAKdb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 05:33:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A8950DC
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 02:33:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k5so1443335pjo.5
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 02:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG8ZHIMAeE8vl3jGpHlV1OHGCyPrpg+HO8fB2PbcU+E=;
        b=miRj0TmGToBFvtxxpMbQ3rkI0Xu6hxlBAjgYjpbteqPrdOPIrQYRHtL8q8ZlSGeAHQ
         n2JbJBjNMUtmxXldN/8D4fNNj0Sz/38Tk9rSYzKB7/C4F8kj18YNeFgFI1eHvfoTNuif
         MQdkVDAW46XX/hjrJlI1yrj8Q+Z8BrlYmzjSy+IdGDyyLg0gl1xhf0pV4V8LTPAcoTsa
         tZKk9hb1UaueRd7yaOttv6mVXwMoftNQLUvFWOemU1RmebgEBrw7CWyjoSilBDGNqmZo
         +jnXudv+IyxHr9CR19hvq+9E/QvS+giFfJPVD9AtOyQ+ep+bz/RyKL1j3WIHmxOe1UgW
         3hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG8ZHIMAeE8vl3jGpHlV1OHGCyPrpg+HO8fB2PbcU+E=;
        b=qy7XqEGLO8ZEyxj6iI+42XwPo2325MEYpiFLhT3LW+gGmyI3CnRh2hwsnCkuZIfqON
         XHehNhSibuTdvWNAj92KyMej3y2c4oDqhWJ9apEDv+vPZzJrk8qeZ+H2n5bYWMwdk3AW
         pPwX+ufsj7U80UoRjDQrHugR0dXtS2db7Na/Wv9TJCsx907EO6idy0NvnuFr5ytdw+C/
         WUOz0W8okvJuexaY34rZbi/P9WgCL97KFPvS2pZfeTRNQLu0+G5ZkbXfrXy+NMSdPml6
         ofXLRTj7rMgrZXNmXUlU0goz43Ab8lz6tILPzvjGxYM4YEsmUSaPu8h4Aynt3dQKp/a3
         TguA==
X-Gm-Message-State: ANoB5pl+M6JRCWBFVI9oQMT99nc8wxxza9pziN5FAyE9PtGJiWeHgSuE
        zsqcSjxXbqAQzU4Om+WKh//04vne6O2Nh4umkSKrR6Z9LDl9ow==
X-Google-Smtp-Source: AA0mqf642aoi1yRJJKtNl48AiCybnMQUQrPjPYU25zzkdJRF+D2m7Ssca0I4MtMi0OuCqqsQF2LL+Ig0/3BKfyIQlTw=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr68326529pjq.202.1669890809387; Thu, 01
 Dec 2022 02:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20221201091150.3474-1-wenchao.chen@unisoc.com>
In-Reply-To: <20221201091150.3474-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Dec 2022 11:32:53 +0100
Message-ID: <CAPDyKFoBf25CDAgg5R0MSp53iC277FzGO9DUDf3LPU+_wuxCsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: remove prefer asynchronous probe
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Dec 2022 at 10:12, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> The prefer asynchronous probe affects the order of device probes.

Is there a problem with this? If so, can you elaborate on what kind of problems?

>
> Fixes: d86472ae8b20 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index b92a408f138d..bf8df727e95e 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -801,7 +801,6 @@ static struct platform_driver sdhci_sprd_driver = {
>         .remove = sdhci_sprd_remove,
>         .driver = {
>                 .name = "sdhci_sprd_r11",
> -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = sdhci_sprd_of_match,
>                 .pm = &sdhci_sprd_pm_ops,
>         },
> --
> 2.17.1
>
