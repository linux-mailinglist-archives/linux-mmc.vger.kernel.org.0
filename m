Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C85F1B43
	for <lists+linux-mmc@lfdr.de>; Sat,  1 Oct 2022 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJAJ0l (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 1 Oct 2022 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJAJ0h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 05:26:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C250923F1
        for <linux-mmc@vger.kernel.org>; Sat,  1 Oct 2022 02:26:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z4so10215698lft.2
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2022 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vYycpIjt46roj/JmgTgurQfrwVP3W22UYGGnXE1tY3E=;
        b=xjbww+8JVXBC5dEg7aBR/GlzgU+v7kFpqVmmmpfjItWXk4lsAP/8mAauFvV8LK+SG8
         sydEdmSLYAQSN5CcuBaBAwk5jsA5XcWdgmrR3uY6Wz62G0wdHPst8YOnSF7nFMB7DMtV
         UD2iA7oYoewGHx8nqisEKBTeukYcNH2HyNMLqcpB/M4VlsgTWzG8dtJ4AuHNIQy5bZiw
         9MRAKx2G/WrJuISEnMOiOGNFp+IwJBqLPdDOPfCx7U5j+lvXQwFUHtdtK6R6NexEwgMp
         xflNAvRnemPLlX8jJLl+X2+Y7cQqB3v+eI/JLNRQOQ0FAIt+W2m/xW97Ntongatgatwx
         LWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vYycpIjt46roj/JmgTgurQfrwVP3W22UYGGnXE1tY3E=;
        b=HOSjHEIirCwNn1f5cKwBURXgITvzNvZLG2qfdVRYY7bI5/ubOGP2KFF/MRTT5JLsJR
         z+YFjOYOm7NY4p4J95E+XRctfFknXOmH4xQE78O9fkFfuU7CvLsO4q1MJ4ytqhupfek7
         djl4RhON16CiknZTFa0+IPuZsjEGog3nVUpJM0+JU6hI4wc6Qx+y+sVXNB8+lN8gwZ8m
         6ubKU7s4dzWfoW2GOlE6haEGCu7i77ACja1aJijgth+gG2QRw7HJ7Oqodw8ksoAqAvRQ
         9uqob5BDRj0CiTqsWaa8nmpCdLBB1TNxlI39giybdAPtEVw/LUbCz34EqNn1xavFv4Ln
         9tKQ==
X-Gm-Message-State: ACrzQf1WzxnWDE9I8Sc71vVelaC9MLakeI++PVG+ISj6wsrgHDuwGgT6
        9647zdj3mbO+P/ztiGiqya1BFA==
X-Google-Smtp-Source: AMsMyM6nB5tjy77rODhilMPVMTsAivmhxLCM04oeuE9gx5AX5/w6eGObHidEOsuR00XKa9oauDjGmw==
X-Received: by 2002:a05:6512:2286:b0:49e:eb:ea19 with SMTP id f6-20020a056512228600b0049e00ebea19mr4744520lfu.645.1664616392017;
        Sat, 01 Oct 2022 02:26:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b0049313f77755sm697924lfq.213.2022.10.01.02.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:26:31 -0700 (PDT)
Message-ID: <59d306a6-989a-ecf8-0262-7562d110bf0e@linaro.org>
Date:   Sat, 1 Oct 2022 11:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs
 and boards
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030641.29354-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Document the QDU1000 and QRU1000 SoC bindings and the boards that use
> them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++

This patch goes with DT.

>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index fb1d00bcc847..1cfd92f4ab5d 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -61,6 +61,8 @@ description: |
>          sm8250
>          sm8350
>          sm8450
> +        qdu1000
> +        qru1000
>  
>    The 'board' element must be one of the following strings:
>  
> @@ -76,6 +78,7 @@ description: |
>          mtp
>          qrd
>          sbc
> +        x100
>  
>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> @@ -718,6 +721,19 @@ properties:
>                - qcom,sm8450-qrd
>            - const: qcom,sm8450
>  
> +      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
> +          - items:
> +              - enum:
> +                  - qcom,qdu1000-idp
> +                  - qcom,qdu1000-x100
> +              - const: qcom,qdu1000

Wrong order - you put it in some odd place.

> +
> +      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
> +          - items:
> +              - enum:
> +                  -qcom,qru1000-idp

Missing space.

> +              - const: qcom,qru1000
> +
>  additionalProperties: true
>  
>  ...

Best regards,
Krzysztof

