Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682146BA9CB
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Mar 2023 08:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCOHtD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Mar 2023 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjCOHtC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 03:49:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7232926862
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so1129736edc.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MREBIvTg0iZmfIPQnZaCyAIdy2S4bN3xav9922F8IsA=;
        b=BhIKcRSuG8ti6+luQ4IPYniApMzm5BPiWORy6tURoUBgpOEZGN36UK+YtzoLZ96Zjk
         R61stJ4g6RRjgswTFwrdjYkjWqv3FKs4k1PTyBniRDqInkRNn1InzDR0ONk/2q1hdPYo
         WEn00FlAvI83SfF/cYya9z9G9ZSAAHrKT99ubzcPInljSSnuL8LVIVwX87GxxUW6VBkG
         MtdCrgX7ggU48zQczPmxoTH7YL6BnLp+0Zqh9t1OjpZlkiFnsncPxs2bTsW1XTp3XPB5
         uGmVIU1b9+lF5LaRng1aZHw0zMY7cMLuV7YBfpJpbrF+KmYfX/Et/9Z7ft467iiV/DAb
         2orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MREBIvTg0iZmfIPQnZaCyAIdy2S4bN3xav9922F8IsA=;
        b=mN2NlowexNNYvfASooOELoWWmVBbqkR4QWFnQyk6zeKX1A0T0S1vCqP94DENcJOo5c
         0lY8Lxc2Osze5Mb7uVxdNjjE1iW0qCKOZYkRzgnRNxFlZL2avaXNWN30F9Kf921yfihR
         IvGr5peCUJm28kBQr1uCDga+izx6uxPkLM0X4tMtqkrRby2PiJ8bcEriZ1F/T+YRt/4n
         82rtqWqfNxh8oueW3bEsnPWWox8BXXWX+LQCmaNbwkJV9yJzwvi00Qtyw94q+55YeXwT
         TDLVMvqij5rqSuHPyH625wPbynIoeIqPv6S3gfD9Z7oruMVsfKJXtLx8Q9KEayR2Ezpl
         VxPQ==
X-Gm-Message-State: AO0yUKXXYiUkpV9GHcBf4nMgPaDp3+RFQuRGt7BiWwlRU89g+O875+/o
        91YUg6OBjppS0sbvRR2HEfpCeQ==
X-Google-Smtp-Source: AK7set+krnIsUbl4Zio7XgnkQduBL1Lg67Y6lAAjZWqDJRPzBWyWLkrJYti/9xjwJE8TlyxBmDMYTA==
X-Received: by 2002:a05:6402:383:b0:4fd:3faf:1c12 with SMTP id o3-20020a056402038300b004fd3faf1c12mr1665317edv.23.1678866521846;
        Wed, 15 Mar 2023 00:48:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id y89-20020a50bb62000000b004bf28bfc9absm1981218ede.11.2023.03.15.00.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:48:41 -0700 (PDT)
Message-ID: <c92a0965-988e-44f4-951f-790f5bb903a1@linaro.org>
Date:   Wed, 15 Mar 2023 08:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI
 DMA
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/03/2023 13:52, Konrad Dybcio wrote:
> Add a compatible for the single GPI DMA controller on QCM2290. It uses
> the same 0x10000 offset as SM6350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

