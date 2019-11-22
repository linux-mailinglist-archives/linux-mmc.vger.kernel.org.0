Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6310673E
	for <lists+linux-mmc@lfdr.de>; Fri, 22 Nov 2019 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKVHpO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 22 Nov 2019 02:45:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40059 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVHpN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Nov 2019 02:45:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id m9so4201870vsq.7
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2019 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Khk7RPCC8dvIurrOXe6a/rIhnCfguLQQ5rTOcR3JbL4=;
        b=l0QZ0PFeZ9C7UPPaeiZ++Vz5YqMWy/zDGZx/L/65JSZ/2ndrObyhIdamdrXom0rWYl
         /uR6lsnV0/3EqqhTFwI/3fchMfkpCDSFva5u+FbBVkxJbFsS2iP0c8ta0rSJPf8P3SCV
         d7ZPfUY+/WvE4CPp8pksg676M2S8ndsQUITw02PXZo65cp4qM+ujm5MDQy8dGjWLfowb
         /POkzqCSn74s/lo4S5IOYLanUiiZNyteZsNJD36neFUISCkKxFgrXjt1ePRmY8OSDaBM
         OKhB1laSwWusabubBScushpwDDYaRG0uBBBL/HZ4fvOCP9gDcjnBapmxaBLb4gGQQTAv
         8sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Khk7RPCC8dvIurrOXe6a/rIhnCfguLQQ5rTOcR3JbL4=;
        b=jzh9M1oiCdMNGlQ0F5zWMyJwwki0o/P+seUQZojwB/CT/Xse9z/Lm6wIMnlFv89+oc
         /gqfu10OW4esWxYhl60OyV1q1bCfgBCpFoaT4C2qziWltfrKe4LOh+ef6HopLmeczxaP
         Ebt9ztYtuhrRk85+Bvh9gPrEiCPtDYjGC/uW/lsvqgu87lKGRHwTlnLCGikZTv0MlqxJ
         AaOU/JXQFgmAVQ2lw7w6wZojbvE6hQandYRghKRChg3e5sxCM9hrCN7nz5P0JNwUZPVP
         43BoXQqQ/I6aGTLFfuEa4BMSjdAIohz8j+NMOITE+jQyPeHownH4cs1u47K2i+XxWOW/
         ZNvw==
X-Gm-Message-State: APjAAAV8HIqeckFD/JEBxBA376ENZWcorZTuuvxz64mVaPXfZPFnNrCs
        EBGM6u8JttWz0F4gaixRIA8yowyiAcbcX/eieweWuw==
X-Google-Smtp-Source: APXvYqxn4nqOw0EUK21HEf0TuHRL4qsez4AhPzx6knNfNo/2pYr3N0uOfC4T9fhbR+ZTRgQySFW8Ii4bC3qUwOxpUp8=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr9316374vsa.34.1574408712646;
 Thu, 21 Nov 2019 23:45:12 -0800 (PST)
MIME-Version: 1.0
References: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Nov 2019 08:44:36 +0100
Message-ID: <CAPDyKFokY52H4WO7TZHqfUu46U85dOV6FMp1QeY_ivUpfgS2sw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Correct the type of the clk phase properties
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Nov 2019 at 08:16, Manish Narani <manish.narani@xilinx.com> wrote:
>
> The clock phase properties are having two uint32 values. The minItems
> and maxItems are set to 2 for the same. So the property type should be
> 'uint32-array' and not 'uint32'. Modify it to correct the same.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/mmc-controller.yaml | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 305b2016bc17..b130450c3b34 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -334,16 +334,17 @@ patternProperties:
>        - reg
>
>    "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 2
>      maxItems: 2
> -    allOf:
> -      - $ref: /schemas/types.yaml#/definitions/uint32
> -      - minimum: 0
> -        maximum: 359
> -    description:
> -      Set the clock (phase) delays which are to be configured in the
> -      controller while switching to particular speed mode. These values
> -      are in pair of degrees.
> +    items:
> +      minimum: 0
> +      maximum: 359
> +      description:
> +        Set the clock (phase) delays which are to be configured in the
> +        controller while switching to particular speed mode. These values
> +        are in pair of degrees.
>
>  dependencies:
>    cd-debounce-delay-ms: [ cd-gpios ]
> --
> 2.17.1
>
