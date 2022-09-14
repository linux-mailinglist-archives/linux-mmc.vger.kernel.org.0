Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B55B89C4
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Sep 2022 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiINOCt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Sep 2022 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiINOCN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2022 10:02:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13E205C0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so25381980lfb.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tkQ2gij3IWVpYWf59I81AFLezwcjvGUELvmkiUnZplU=;
        b=DFsG/LkzdyNq1ygpJt5ZhZ/qbXe9ZrqRf+2XsUYliUGNaapd3HjPRYqrrFDHkpuP8U
         KDKCf2COGFoasFQC/T+eL9HTpvJqCw8QuOtrfwaM+2d7GN5DoEwic9ggsc3s+ST97nlB
         9OE8ywg4y3gncpe8jvI0Xd6FkFE/MepNk5idJYeKKcVuFDvH7IfaV+aEqhMaP9YC8YXO
         6I9vCkqbZgZ7zYbICIMNdCod5B8N2084jF+WlOdNm3pfBLfeWC/V0VYe2fkGMQVkF9dF
         LRywsPVL7WlsFAI1OH0bP+LbU1nLX9uzYoxQBJMD3N/i7FjZPVN6pZmXuAX0YzwFwjli
         KiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tkQ2gij3IWVpYWf59I81AFLezwcjvGUELvmkiUnZplU=;
        b=IJ82Tdcdoo4bpNDvkPH3jEKE5Ejtk6EQFVXWG7znPOYyqtABdztiufuyQtfbjEZMfZ
         +hREwnRV+LO6rxtpnslTSr+9ShtWT0a2+K5A/f/MKETBDipL2TCPrcey1Qvinm3cylCJ
         3VJJBC2/BLmhlTTeIvpWWOAKl3cJt1Sx3v5Q/+uhudDOCZlSZC95UJZ0jlD8WJYNvoxU
         ek4ufcKKomYwTkjZiHUjZUaDP+y0WPmxhP8bUDt9EB++GO2URAGSANqgvugP4TjjmKCa
         lpDLyvYTFitMaVny1zMIsN/p960JKepCeowrY0mLDBgMsR3t1kYSFdlV4Z1zVVEsQXNw
         7rvQ==
X-Gm-Message-State: ACgBeo0fTOLUp8N/FFYyJ9Nvf0IZ6evz2RayfVw2fJJl3siy7oamHf/M
        JEiojztHBNQIELjDSTATqeWcvzgzZFKNiuFQkFYZkA==
X-Google-Smtp-Source: AA6agR7X61E5vyWoRMVEAMnwI7yhahS3J9/2twMcEzs8aFUjVsC6q4tksh5kS0GIjvek6Xxz9vgbIFRwYNfpaT7SPTY=
X-Received: by 2002:ac2:4c42:0:b0:497:9dfe:e870 with SMTP id
 o2-20020ac24c42000000b004979dfee870mr11527722lfk.184.1663164083141; Wed, 14
 Sep 2022 07:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220910143213.477261-1-iskren.chernev@gmail.com> <20220910143213.477261-6-iskren.chernev@gmail.com>
In-Reply-To: <20220910143213.477261-6-iskren.chernev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Sep 2022 16:00:46 +0200
Message-ID: <CAPDyKFp5kLF2kkFg3n5ZNzp3oX7hU-SAj9iSoJKDX7PAQxU75A@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] dt-bindings: mmc: sdhci-msm: Add pinctrl-1 property
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 10 Sept 2022 at 16:32, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>
> Most mmc blocks contain two pinctrls, default and sleep. But then
> dt-schema complains about pinctrl-1 not being defined.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index a792fa5574a0..775476d7f9f0 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -97,6 +97,10 @@ properties:
>      description:
>        Should specify pin control groups used for this controller.
>
> +  pinctrl-1:
> +    description:
> +      Should specify sleep pin control groups used for this controller.
> +
>    resets:
>      maxItems: 1
>
> --
> 2.37.2
>
