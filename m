Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325896E366E
	for <lists+linux-mmc@lfdr.de>; Sun, 16 Apr 2023 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDPJGx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 16 Apr 2023 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPJGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 05:06:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DD1AC
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:06:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id xd13so22679706ejb.4
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681636010; x=1684228010;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MySIw9waWW4Xk/aovZcd2fC1291iB4ogfzRvJl3ikps=;
        b=oPD6z41rIRPiPN9vujgQErfu+O7lVBNDXDkn0rbx39zbPgvqKoU+3+77OfnPZnM0jK
         +WBeLLwnlW2fDcIAPfJ131a3K89NQpaCium3NI5Z69+k7ZnS41TmhqZRqrYdkz7GfELN
         amvkQpBNoM51MjeQAmwBNMjmJ8H4eTzeGualZKl/TPKjMq0TsOKmWbhojakuC2M5ewqR
         siFTO9atvMBtg9NDhZJKqhmemXP2vPejkkW/HDy/yTnzuRMjcMxPuVVmKvBmMKY9lDxY
         j/e5QUeWb72kTEcAxQe5XdzAcERvaIrQ/uffmnRekX457Vfkp77hOf/IxsgagfLt3bpI
         lnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681636010; x=1684228010;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MySIw9waWW4Xk/aovZcd2fC1291iB4ogfzRvJl3ikps=;
        b=bu2WCyZOayKUqEwdif7h3ACKwnXBXE2Qj6FkEn934VmmZgwLUftz51MdrTwFZ4b+Ip
         zgX1UfT4YsitdYXpzrNyxNfC20gHURiGrtcdGF7V2wBsBwAm/OkbTPR+Ama1p88zfWuL
         +k1dYC0AN5jM38HwBTfO5J8QiZ1+037MWAH4fjJs8NL+qEcKttMFon8iuoP9VPtZKwh4
         uYF2ak88ObxIz5JroesEGoJZ28RleqYpVlSSPFPsQuih22UthFLshVgLT35+aT1sjd7b
         3y/X2sAWdLTtETbKxiQqreF16oWAaeQ1W/yDZacWXswlvcwniErUvSkOTXLo3neGDZ2a
         EDFg==
X-Gm-Message-State: AAQBX9foLNDipRvfo/n6NsxnnkJyVBmHtIAkHJZcsbJ/6E/rdkO3tAuq
        6WlDsraC5GrtvmBdYtsepLcEgw==
X-Google-Smtp-Source: AKy350ZzWsYy0GX5jmLzK+27nTxe75g9meKiLlz60+VnfHusZw/nv0Wk/QH+DWdFrAqqKXPLKLUiPA==
X-Received: by 2002:a17:906:ae56:b0:932:1af9:7386 with SMTP id lf22-20020a170906ae5600b009321af97386mr4158267ejb.27.1681636010015;
        Sun, 16 Apr 2023 02:06:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id wt10-20020a170906ee8a00b0094f225c0cd3sm1739874ejb.86.2023.04.16.02.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:06:49 -0700 (PDT)
Message-ID: <608ad622-4ffd-8264-4a95-2cedc429e469@linaro.org>
Date:   Sun, 16 Apr 2023 11:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 6/9] dt-bindings: firmware: document IPQ5018 SCM
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-7-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-7-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 367d04a..ea5987d 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -28,6 +28,7 @@ properties:
>            - qcom,scm-ipq6018
>            - qcom,scm-ipq806x
>            - qcom,scm-ipq8074
> +          - qcom,scm-ipq5018

Keep proper order, not random.

Best regards,
Krzysztof

