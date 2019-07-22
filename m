Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D132B70171
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfGVNny (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:43:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40210 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfGVNnx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:43:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so15309189uad.7
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRYfNxmRGZxja2aVerHwx+L3OctiiirveEgY/SpoZGo=;
        b=LyH7T9dlRo7g4lnuXgZU64vVwhjnpNVE0dmH0+KSUIiLJSNWCQgZoqIWq5XaHwhC3P
         8ydM6v5YUdfeTPYmUnfjEaWYR71/3wbRj6bX555P9r6zI1LS/fttMxBXbkdw/wWvRLDU
         4wsCi9S5vleIdvxmfzsrwtxs8rpXO/3bcIkqTngmeygsWEqdkzyqMgBelhlkBiwo+r8e
         NLE4VgjkjPGj59aOXIT6Gh0EtoVYSYzqd29yGnndn89Kgfs5QqgwQKNycm+J0NcQuBSB
         SFlNjifPIw+SBmO1a3hfIsuMspDoiRCucdhfptRR34hhCDLg66Rh9glIUFXAGZpIRBS0
         6gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRYfNxmRGZxja2aVerHwx+L3OctiiirveEgY/SpoZGo=;
        b=IdvOAIWNwLdpV7BhAIdMBxDeNDhNOkvkhFRc0/5IcZEz/waPDuNzOk5eZcN0BBARTm
         6zDgAgQh6tqJv8kcqjevmqYy5wSnT0BEoh5YVWdSRhntoAoOyg2kiN94zmGh3RRXz05F
         yOUcfuwsVBKsS39LEiT26MhTm1ESmrffO9fawvQIOW9ae8WglE4a6xVyiRrUt+eJXUiM
         25RIlAOyQPBqV+/dYDgYovuK4np3vmEac5laawCeX7tFhmZk+unafrta/NGcpLxHQdc+
         qKaKktJi8B3DrXumrQR7Xx450neA5m69SSjGzB14S87QcDFdRhZObKIZHojtPx9Y3Nzz
         Df9Q==
X-Gm-Message-State: APjAAAWcgyS84MHyEl2Y6lErt4/KfFGinM1Xz8zteLS0YyRVgfsIIdZJ
        sY0zfesR8Ui99iATi/WsDs62ExWJFYQm65u1MEJvsg==
X-Google-Smtp-Source: APXvYqw3AfSjTqhb46VrvlwGb6HfSPyjBQ4zqei8hoJZ9u+BGXpYvPmlaOewG1Gyhz0LPpTnVsahsy6rkH67aXY7HR8=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr41461397uad.15.1563803032923;
 Mon, 22 Jul 2019 06:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190722120740.8966-1-maxime.ripard@bootlin.com> <20190722120740.8966-2-maxime.ripard@bootlin.com>
In-Reply-To: <20190722120740.8966-2-maxime.ripard@bootlin.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:43:16 +0200
Message-ID: <CAPDyKFr+W4jofZb1Ajt4hyRFYBvB3M64cM=zW5AA0=gcp6OWnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: sunxi: Add H5 compatibles
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
> The conversion to the YAML binding left out two compatibles. Add them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 06329115dc6a..d2d4308596b8 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -35,6 +35,12 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-mmc
>            - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun50i-h5-emmc
> +          - const: allwinner,sun50i-a64-emmc
> +      - items:
> +          - const: allwinner,sun50i-h5-mmc
> +          - const: allwinner,sun50i-a64-mmc
>        - items:
>            - const: allwinner,sun50i-h6-emmc
>            - const: allwinner,sun50i-a64-emmc
> --
> 2.21.0
>
