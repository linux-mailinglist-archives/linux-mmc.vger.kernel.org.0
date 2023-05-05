Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6192B6F88DD
	for <lists+linux-mmc@lfdr.de>; Fri,  5 May 2023 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjEESrH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 5 May 2023 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjEESrF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 14:47:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438B1E9B3
        for <linux-mmc@vger.kernel.org>; Fri,  5 May 2023 11:47:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so3381672a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 May 2023 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683312422; x=1685904422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xizeI1xw1N1o1KCR/0d3CEO5HKUJMy4YKMQX1QmsJGU=;
        b=BYjn7MR+ccvEmSQ0mrXcIifJSGfkZYwfRcTeP0ubpg11K5pBkh3FQ/6t9t7zmM5pm4
         Nja8mfI6By1KkXVz/cH092kKR4ynt0oIMRA9EoGPv5a12FRs1uVJBLYrM4bHUxtgDewC
         s6i2bvPJT162ghE3iQXfHMRsqHt1M60kBOIMhqSLJBQubkfYgxx9MmtdI+rcAic5qg0Y
         8kVtA3EQ8tHR4LmGqfU0bAoM55gZvv7QNCQG5GPVvdPgn6K3WBLOxwec8qDjSsipcG1D
         XYZLHJu/I9NwxRuoMkTXSMGWDBTLWbrizX8sTIO8d16Ekbmc4PLyX9X8010RAitoXF3s
         8qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312422; x=1685904422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xizeI1xw1N1o1KCR/0d3CEO5HKUJMy4YKMQX1QmsJGU=;
        b=AY9jXFk7aPLhlO9An5iVq6cicz1n/JLhabaNdKG3R2t+m4WlSM7PYe+sgL2dn+uBxV
         hM3trL02dIn6Wbh5C+UMtI6vEUwdpi6BtC3lVktEbNilUsPJjLsTsZscAOdP7FC/vkNe
         ILyTB+/3lMRxMmDouhdAqPhoL7WfYw7aA+A2R6hp+qGTgbN/dXBFtqK6hznmoQTLic3z
         O2v82SiEhhaTq05L61Kf2gPfQBvlxkSZP6oP9kLiPj8PQ+shAFyAH/w4Cf5elJvsqvWo
         SDZYDnTRNtfdbP/cUYHJRlMygBJnalAnb1qy7EP1izKdya81r2ip+emvrvs3gK63O1vE
         RX5A==
X-Gm-Message-State: AC+VfDxqWVzrem5nTGG6g+3gCDOeNyHohFtl+MksvWirOXPbkx8v656z
        9Zn8K2RjDpBlW9AissdSZe7Q2Q==
X-Google-Smtp-Source: ACHHUZ6EzeWMpBxmWaCjOrtvtyfpMbhXeKnbo8gnWIGqsyLOp/pkuaTAcAyh14W6LDPIk97mCn1Hgw==
X-Received: by 2002:a17:906:db03:b0:965:4b43:11f1 with SMTP id xj3-20020a170906db0300b009654b4311f1mr1799980ejb.3.1683312422000;
        Fri, 05 May 2023 11:47:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709065daa00b0094edbe5c7ddsm1252130ejv.38.2023.05.05.11.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:47:01 -0700 (PDT)
Message-ID: <316e9ee5-fccc-e199-f727-7b8187e965ff@linaro.org>
Date:   Fri, 5 May 2023 20:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20230408214041.533749-1-abel.vesa@linaro.org>
 <20230408214041.533749-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230408214041.533749-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/04/2023 23:40, Abel Vesa wrote:
> Starting with SM8550, the ICE will have its own devicetree node
> so add the qcom,ice property to reference it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v6 is here:
> https://lore.kernel.org/all/20230407105029.2274111-3-abel.vesa@linaro.org/
> 
> Changes since v6:
>  * Dropped the minItems for both the qcom,ice and the reg in the
>    qcom,ice compatile subschema, like Krzysztof suggested
> 
> Changes since v5:
>  * dropped the sm8550 specific subschema and replaced it with one that
>    mutually excludes the qcom,ice vs both the ICE specific reg range
>    and the ICE clock
> 
> Changes since v4:
>  * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
>    it while making sure none of the other platforms are allowed to use it
> 
> Changes since v3:
>  * dropped the "and drop core clock" part from subject line
> 
> Changes since v2:
>  * dropped all changes except the qcom,ice property
> 
> 
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

I see dt_binding_check errors after applying this patch. Are you sure
this was tested?

Best regards,
Krzysztof

