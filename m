Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077A268366D
	for <lists+linux-mmc@lfdr.de>; Tue, 31 Jan 2023 20:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaTY4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 31 Jan 2023 14:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaTYz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 14:24:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944E5591
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 11:24:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o18so5748933wrj.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4y+ZuW6GtjoBTNPafHpwiagaTjvE6XPCrQfZhYPCAQ=;
        b=ehEaAOCJoPt7ANCjpeOxEKnr3hXlyhYuCekjjhWHIUIZDOcEQD+Zna67t37uGH+GuO
         50InIdnkiD+8vu8yjERTzfZ80s3tz00aKjvBHkgbCHjV5cxiTSrAckE4NSMjT3YEVDE4
         vCwP51sIYHD16nsCmXISgObPYbaIzfxS9Uiw72xJMqAaAKWIPyAzRzWAEYnRR8AWTja5
         rhZdNOqTdZ3/JS5L2TbW65w9JckKSadbSLoK2Uqva8Rp0DSud+tYQEASJKFPVo/Egiap
         BLOVcipoXHib7VMxW+9vMtBPcIJqoDj5MOd6EDuXDkmLU/xizfiMGgZsni30NlroJpwq
         izkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4y+ZuW6GtjoBTNPafHpwiagaTjvE6XPCrQfZhYPCAQ=;
        b=HQXEIr1nbHMgLNwPUKi6olBwvhEtThyV4Csxgs9w4mUVzjGOwQTWIyi0iG9UUx+tNf
         52hOa/sGFoCK+9L8iZO4QVYBNI2N9KtE73+pev8RhSwMQg+YLFcmunG29PETAjF6xPTR
         WYdtJYK2rLS0MkZFS4PI4jiwB7XBF+eWsfU4LAn63jiHTVf1OhLyYZU9l2nOS0xcXTfK
         Gcw3FoGEGMWxaQQeoImSUuvQzPyXPMcDeUxadvDv2kfb5tHTuQatNh0pNS6upFA08n5+
         6WM9LjuGuSyoDXrq+fcO76U5AARKVWokWh2pGxuHByx3Lrn/nUe0y8kR+D121WP3fOE/
         PR5Q==
X-Gm-Message-State: AO0yUKVOPMYUZdc26xq9jBR6rOnmwOIQKl+fyBMnh8OcwI5427N0wSNR
        tO+RX0fqt/+3p75g4iWFTV3+DQ==
X-Google-Smtp-Source: AK7set9PTZvzxhF33ZkIt3r0P1qzuHKaDSEhuvm8Lo6AEfz4xAQ4oYF4+3MYOgHmK1uV4cS/FXE5SQ==
X-Received: by 2002:a05:6000:1105:b0:2bf:b5ec:4844 with SMTP id z5-20020a056000110500b002bfb5ec4844mr128472wrw.19.1675193092560;
        Tue, 31 Jan 2023 11:24:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k7-20020adfb347000000b002bfe5efca78sm8647979wrd.98.2023.01.31.11.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:24:52 -0800 (PST)
Message-ID: <85ae379d-ee71-7636-1ca1-2fb2baad63f3@linaro.org>
Date:   Tue, 31 Jan 2023 20:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/10] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board
 support
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-10-quic_kathirav@quicinc.com>
 <f0312e77-0835-7f79-acf0-3d91d6548f07@linaro.org>
 <8b9ed619-8ff1-53f1-1f3a-c10a3585b9c4@quicinc.com>
 <efe976be-79b9-1f1b-69a1-18dd3b0798df@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <efe976be-79b9-1f1b-69a1-18dd3b0798df@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/01/2023 12:56, Kathiravan Thirumoorthy wrote:
>>>> +        sdhc: mmc@7804000 {
>>>> +            compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
>>>> +            reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>>>> +
>>>> +            interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "hc_irq", "pwr_irq";
>>>> +
>>>> +            clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>> +                 <&gcc GCC_SDCC1_APPS_CLK>,
>>>> +                 <&xo_board>;
>>>> +            clock-names = "iface", "core", "xo";
>>>> +            mmc-ddr-1_8v;
>>>> +            mmc-hs200-1_8v;
>>>> +            max-frequency = <192000000>;
>>> As Krzysztof pointed out, this one should go.
>>
>>
>> Ack.
> 
> Krzysztof & Konrad,
> 
> These are the properties of the SDHC controller present in the SoC. So I 
> think no need to move out these properties to board DTS. Please let me 
> know if my understanding is otherwise.

Usually max frequency of SDHC controller is depending on the board, so
no, it is not a property of SoC. The same with type of attached memory.


Best regards,
Krzysztof

