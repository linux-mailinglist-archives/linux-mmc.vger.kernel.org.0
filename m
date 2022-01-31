Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7D4A4C0D
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Jan 2022 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380417AbiAaQ3F (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 31 Jan 2022 11:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiAaQ3E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 11:29:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82EC06173B
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:29:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i34so7659507lfv.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZh/zXsVY4uAw4/AoKKjhBJR9nVYvIppvpnGf+mWz8I=;
        b=mTzZ6FlxE0qbt7TSt73c7QfPJldMU8vWNZ+3ldqYN/P93Giw3E2TKdHaAgCGWtMahT
         VvLd/nDAX+nbQMF3UAwH+Bzd3FxtZajWAZi3dfrEQFCimE6sqjmuM0JPeKP6FJ96dYW4
         IYO7+PEsV3NFg2ODRvVJp9ERQbHzV9D/dndbQaLx30SL86d/nOlWS6anxv9/NIAznmdR
         JJdyeGnPGExKQ5XtW7B7OsQnMf/PPjiisXEO7gholaqw/mhUnR1aGW/V7wvXkN/kaw9P
         maCq4K+9LJwLSsHGS3BYiBaOdJ4rw6HObs48AnfRrMqRJasbbIjbMGG9lJWr466bdEse
         cPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZh/zXsVY4uAw4/AoKKjhBJR9nVYvIppvpnGf+mWz8I=;
        b=L/rAiHYJLcPW+0LUZwZ5IX0wHBfqJyo5altXDCwR4o05j8aUUFGumgEHMYe8AY12lq
         dvg/nKyNwwZu+i7M3+ajMSHFOqGPdcs8oyvUl1QozHUbcbnFUHduRy0xTtIlxcN+ORSk
         pDtD3kfEx+3O5yBKvoMnt6o8S27hZn1xdEUHvIevKV/aYC3ezuB9X9eX2Mp6T5PqkiMX
         W3JUJexpUV7xMiMvxuCM0pIQDCcocO0XqxkAFy1SssBGl4Hnl1QhmLDeIKSgURQbDl7q
         0CvYsxT76I/MGGcsHhon/ob7ETHFC585h0XqhfnFrzm2jY7tyUP/rQf7dQfPwQr1/1vM
         C88A==
X-Gm-Message-State: AOAM532bl9QxmYyWOgm+OMyoQnbr2OXCermDVaMomXtHFxXCc+vicas8
        GEvM/7hQvdfFoOclEFI+87YOs0lq+O9FJU+oQzr1CA==
X-Google-Smtp-Source: ABdhPJw8ib+uvOkPrEkasfdhGnzwKMTgUNCFIN1bKijxICPIscdKUZzvisWxeylcVzSJ0tQ16+FpFbwvVDmmHk6TsNk=
X-Received: by 2002:ac2:4c08:: with SMTP id t8mr15644982lfq.358.1643646542435;
 Mon, 31 Jan 2022 08:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20220128062050.23978-1-allen-kh.cheng@mediatek.com> <20220128062050.23978-5-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220128062050.23978-5-allen-kh.cheng@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 17:28:25 +0100
Message-ID: <CAPDyKFo+cnMUdng_d=c5eRytUx49+KWCtrnHh9m9jU0syJ+hhw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: mmc: Add compatible for Mediatek MT8186
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list

On Fri, 28 Jan 2022 at 07:21, allen-kh.cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
>
> This commit adds dt-binding documentation of mmc for Mediatek MT8186 SoC
> Platform.
>
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

For some reason $subject patch didn't make it to the mmc patchwork.

Anyway, I have picked this up and applied it for next, thanks!

Kind regards
Uffe



> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index faf89b0c918f..297ada03e3de 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -29,6 +29,9 @@ properties:
>        - items:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
> +      - items:
> +          - const: mediatek,mt8186-mmc
> +          - const: mediatek,mt8183-mmc
>        - items:
>            - const: mediatek,mt8192-mmc
>            - const: mediatek,mt8183-mmc
> --
> 2.18.0
>
