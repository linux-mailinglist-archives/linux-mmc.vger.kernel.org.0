Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB79739C95
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Jun 2023 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjFVJWO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Jun 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjFVJVn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2023 05:21:43 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A09365B3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 02:12:11 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4717a1d07fdso1786025e0c.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jun 2023 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687425130; x=1690017130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAUOQODzdCeUTcrDvoPMBORZt9+ufR2Q6MlQ8V9HqcA=;
        b=mXPKXfCQ5AqfGGN7eLis7zio/LUO4dolZMn9tGoBWo9lQ/0YSYOantIpV+5Aknn1uh
         3J4AAW5FwrtrCjPqExngKvRZGdsEMMnXiWLjxSlxcZ4Z4hrIKAqnf3JGXGjDgW9P3bL1
         pFNgcMjEIcXauA2TF31JXquLUpbL+xqhM2fQ9hmTnukCcFG1Mle2eakMHU8X4YmkO6LO
         bAhMo5m/gWYLFCsmeuIdoTLd4aVKzBQXkX6znVpbHzzsNtQEyUyVQaAV7jfwZ4Hpde4C
         pcPlmHg9x/K3XVnBI0Byou5ihxHLvg+InoKTxxb2YQ/iI8WDHTP84M7mjcSJauXDobPV
         PPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425130; x=1690017130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAUOQODzdCeUTcrDvoPMBORZt9+ufR2Q6MlQ8V9HqcA=;
        b=PWV8nvlzBW35NC0XL2fLb5XQyeyyJTRbxF8LT/lXtKJr9BPXoEI2eIvUlwngvsLC6F
         fg0qSTAut5/7vw8fe90VXBd2i4qUi19bPYrsBe78I0NC/vl3HN9x+GK2mlnmZO6WSALO
         JqTyTn3vdv9Akew3nlF3N9TLt3opr0469huv/gPWEyoLKurxP/BUWPk3OzPr6Nn8w1PG
         m5OygSHmZu8BHzwPXPKPCdgsfhvDEv41g5R/pVDBSR7QQr16H+koWZLdZVZAzAapaMyK
         tikUBDLiR5H7LFGoac0516RGVha53eLpJ450b8bxtN2DEAlzbNVYodvbMj1UmexMUhQJ
         jIpQ==
X-Gm-Message-State: AC+VfDwWqRFyUzBTKUOVXhRYaS//yE9akRlFoG8GB9niDCCsN25nnGXQ
        YPwWDVGG6ub9DXAYJZvETq3Cg3y9aj8t7loHdosGmg==
X-Google-Smtp-Source: ACHHUZ7Jjoae1j3de5QaDkn+NVntLKV6op75KhbpCaUpXW852Raha07Xg8nXWZ9iLhTkIRdAW16BPNsvDSHUyHVrFYM=
X-Received: by 2002:a1f:4801:0:b0:471:cfa1:5065 with SMTP id
 v1-20020a1f4801000000b00471cfa15065mr4808788vka.3.1687425130628; Thu, 22 Jun
 2023 02:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093245.78130-1-o.rempel@pengutronix.de> <20230621093245.78130-2-o.rempel@pengutronix.de>
In-Reply-To: <20230621093245.78130-2-o.rempel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Jun 2023 11:11:33 +0200
Message-ID: <CAPDyKFqYfuQNCTPiEM56jrzUBe2jevY+MuTOj6K-7OkpO0_daA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org
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

On Wed, 21 Jun 2023 at 11:32, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> the fsl-imx-esdhc.yaml file. This is required to match the compatible
> strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> commit addresses the following dtbs_check warning:
> imx6ul-prti6g.dtb:0:0: /soc/bus@2100000/mmc@2190000: failed to match any schema with compatible: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc']
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index fbfd822b92707..82eb7a24c8578 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -42,6 +42,7 @@ properties:
>            - enum:
>                - fsl,imx6sll-usdhc
>                - fsl,imx6ull-usdhc
> +              - fsl,imx6ul-usdhc
>            - const: fsl,imx6sx-usdhc
>        - items:
>            - const: fsl,imx7d-usdhc
> --
> 2.39.2
>
