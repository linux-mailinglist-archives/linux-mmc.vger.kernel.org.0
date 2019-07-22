Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EF70168
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGVNng (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:43:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43642 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbfGVNng (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:43:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so26114847vsn.10
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzeJmpKD7dB1BcnAqy2fLUAETNrLhEZq/GzIzifX3rM=;
        b=k9ec/yRYrEBUkxwk582HRuZ4bh/6llTYhV1Lyfw+mNJYkWylldnN6VCrx6g4FgIzOf
         fFVYTtxL/EXr48ISMBlPUUt+SozF/0RKzg5JpMyJDF56m6g34zuYVofS6Kb3JBDWO5w1
         BjfwU4DuUN9g1mQBXXBMm66PmXKSpUM7AcxKNOTuSQGH2+ma17JiRCGnnq7FLmqGO6/y
         LRDeoMSaw74ZKM74DzzqPcgsplk46aQBAXlGpyia1xuy8Lw7R/sYRAeS7Z260ZzDU5SA
         fm0eq7nLgw5Svdvk04NOKL/eBzFd18N2cO0L1dZV+uNWucq3jm+vdwKHXay0YfyKs1kX
         pL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzeJmpKD7dB1BcnAqy2fLUAETNrLhEZq/GzIzifX3rM=;
        b=iw1yTYpsj+i0tseB7fSe+T3NefQ2++ljB6pJWTnaDg0VMrGSYA7S6Ky/hT8gmwCPge
         u74ZdpO1QQmgNA2DluceJM64PGlhs9T4Jms/RlKNZmTqc8/GUG1fQ5GZDQK40uXmzAfL
         mP+QKl076kxF//7/svtMrtPRWpIqWQ20+djP+TMRWvK4H1OHW2UawnriR60ZIIgzPADP
         JptUuFtrMPVDWF/Ph1NrrPTBG53qHbH1jOrv4qUXhsd3eAkERIWV/rLGGRP5lQlQNILj
         7JuFkBUbHYLpqRveuV4EmlBdaOWElxwCdyMyGB69Ds+YAMhZ1RqhAEkkt9lVc7+BCRG5
         Z3hA==
X-Gm-Message-State: APjAAAVvdZ8fYe/XBXwacsjCNG9A5hL1h0AkbS/rvrn9ROC9yqBe5mf5
        E2q64F3RgH6id/r+tS5TmyP8Yv7UY3I0JX0cyzOfroCf
X-Google-Smtp-Source: APXvYqysofOLp0mqm8qYUMlKBMjSTE6XdBRitpLtn07et9m3ZF2oRHXMEjMC127T6JQoRdvv8wb0ReINVSNZU/xMTKw=
X-Received: by 2002:a67:8709:: with SMTP id j9mr42148022vsd.35.1563803014581;
 Mon, 22 Jul 2019 06:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190722120740.8966-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190722120740.8966-1-maxime.ripard@bootlin.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:42:58 +0200
Message-ID: <CAPDyKFo-HwgkuY1Dat=FXNior0fFcDdD_QtxWqFb5rYGCLNc6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sunxi: reorder MMC compatibles
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Jul 2019 at 14:07, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The MMC compatibles in the bindings are not ordered as they should, so
> let's make sure it's sorted.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index df0280edef97..06329115dc6a 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -29,18 +29,18 @@ properties:
>        - items:
>            - const: allwinner,sun8i-a83t-mmc
>            - const: allwinner,sun7i-a20-mmc
> -      - items:
> -          - const: allwinner,sun50i-h6-emmc
> -          - const: allwinner,sun50i-a64-emmc
> -      - items:
> -          - const: allwinner,sun50i-h6-mmc
> -          - const: allwinner,sun50i-a64-mmc
>        - items:
>            - const: allwinner,sun8i-r40-emmc
>            - const: allwinner,sun50i-a64-emmc
>        - items:
>            - const: allwinner,sun8i-r40-mmc
>            - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun50i-h6-emmc
> +          - const: allwinner,sun50i-a64-emmc
> +      - items:
> +          - const: allwinner,sun50i-h6-mmc
> +          - const: allwinner,sun50i-a64-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.21.0
>
