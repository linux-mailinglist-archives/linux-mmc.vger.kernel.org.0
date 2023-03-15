Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725C6BA9BB
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Mar 2023 08:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCOHs1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Mar 2023 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCOHsU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 03:48:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980462FE0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn21so41744955edb.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flS65m6zpOwZwk8Rpq8oSYxl86XXWfwzo9qoU3TRW3k=;
        b=a+UzzvO0EdWvfHqpZ+JkF0Sj6/Wc3KFKQrfSz/yq+K+zdci/QWUaCMcqEBBABxyfBS
         kfRvWUOb0lsLZjLdquNb57IHHMjGT9/WruduRv4mgRcecOm0pSjwTl5OnvhM3Sdv75tL
         bSWi9hYGEHhblWHHC5BnT9YIaJuUOrYQZrzK6obqFcOqdDQITv7wNnkPkXG654gzOKGb
         vW96TTWPxM++gMkDWtCKq04NAhPTfQLFWqKe4bsLIQodR0Fnl9dInZL3CYEEg1zFBy8V
         0PpfHQGLay33RtgZ9Vax1KuNYarenhpDoexvx5quYvck2srBUTfoVFb0gUFyXRb7gBRF
         JU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flS65m6zpOwZwk8Rpq8oSYxl86XXWfwzo9qoU3TRW3k=;
        b=QMQTZf66DMO3qw5QmbiUznffwCle4iodLbJ4aHobLD1DK2PEa+HxH5wli+ufPKSCIf
         DZquGlIdZEadai27ZuiK06O0i7tDF+MTz+G1g2G7NlzI7CQlE5Ssnugf46yRreeAsEm8
         WBcHeBEJi1L8dqCYy0jbNUFb2+zkLPSsx4sQW2u/Q8E07fO0vTtvvCp6CeZvYSC2T5DB
         i+6JepeKA2o+EwrZG+BqJdQHdVN9iBr3M2CeYt1ZN6zGqFvLs+MJIj8nVnWw3MwOckO0
         jQegNCewet+POD6MdHlCDdLWo3A46MEMRssSaX654juNSmRJ57DkfxNW0VgxRlUbMjLC
         kO4Q==
X-Gm-Message-State: AO0yUKVdLcf3fGmk/OlVgvSzPb1ScqS2oXjWWSyHd4yBtw6SR4nN99LE
        WJsx/Sy9TtYQ3MAZSAjzk91LKQ==
X-Google-Smtp-Source: AK7set9zZ+gCQxgiRNEmWP7Ta1I/fHTCP0stjypuN/iQ/Cwg3Qxi78lRHJEW9qtE5PPi1fnwrKb9Hw==
X-Received: by 2002:a05:6402:38a:b0:4fb:2296:30af with SMTP id o10-20020a056402038a00b004fb229630afmr1746327edv.20.1678866481260;
        Wed, 15 Mar 2023 00:48:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id bt20-20020a0564020a5400b004fb419921e2sm1946643edb.57.2023.03.15.00.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:48:00 -0700 (PDT)
Message-ID: <33ae98be-480e-8951-88d8-7624a695fcc9@linaro.org>
Date:   Wed, 15 Mar 2023 08:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] QCM2290 compatibles
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/03/2023 13:52, Konrad Dybcio wrote:
> Document a couple of compatibles for IPs found on the QCM2290 that don't
> require any specific driver changes
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I assume this is what you talked about that DTS will follow a bit later?

Best regards,
Krzysztof

