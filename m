Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6431369914D
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Feb 2023 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBPKc2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 16 Feb 2023 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBPKc1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 05:32:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60398521D9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 02:32:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jg8so4027285ejc.6
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWFSUdCVRyVw6x7wcHcTM6IEabG8cCTacN0P9Cw7hss=;
        b=DMVup6OQE69edQyn0ggk5ICi+662UFL0/JfpbZ1h8e+u4l5Oh2B34koVVN9Qc4yX5j
         82JMa3fgus74jDHnOE9BaoHTn9ePGcRv7Ty1bwSf083Q51CQ5VaYILa/ndl4Jsko2xL5
         afpHBT1CUVQQRKDb3biN/mAlsG4yKM0gRtzoZutL4nX6oZAD9IUuWSeeqXso66mnSBCc
         f5nMcP8DKEEtolK5H8fM4y5rr+PqN89HVv9UeilaFAXPExCHYy2vaO2lxMZDMqPemx91
         t0iDcsvGZcbj0aWJxg4kaOC7DjGJObegwF+7x4NAg9Iz1EQt6uvTsFbZbZIY1jf3QcMI
         OHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWFSUdCVRyVw6x7wcHcTM6IEabG8cCTacN0P9Cw7hss=;
        b=BEmGh453Nb1NbUDFGCqDy7ZwslayIDuLNEvP6OQaeDsXzd9VOOx7yBuwV2weC2gndq
         eQQBCCTC0FhXmDWv0SPnBc9s3fRI6m04M8ACM8kfIYrdHtGQ1t84+a3z/rBIyeuJmla4
         r9KttinfAHCok3Sh4lWIHeaL+BRHZwN7xh4G1RZeBBiXZdTEKXlz1HpraKlk5KD08Q7F
         unIslPEjdpby1kKtj/mNFU2YnEHmqq68PUm2HuEKQBAzLV46TyJw/Z4boZEqj3v1qV++
         4s+g7d9ge+UddUKyJ6v5cuMPUnD44pFTr5V+TRfhRC2t1W7R72agbJN5avHLCTT598l4
         qTnA==
X-Gm-Message-State: AO0yUKVaENPSyMi1d/A5busGsPfN9Cg7Va0cDYO0rRXKV5yJ1Z8DgDEn
        0U6xYLtL0gSjCW1Smh7/ugaxeRIPCoWVoPVN
X-Google-Smtp-Source: AK7set/sKPk5xv7sgFMMvWdIVPPdD/XK4wPmGnvEGYQZMLg0YJX52U9MQnYr5e9CYPFb4GHTbmdmSg==
X-Received: by 2002:a17:906:ca4e:b0:89c:d072:e33e with SMTP id jx14-20020a170906ca4e00b0089cd072e33emr6792084ejb.49.1676543531221;
        Thu, 16 Feb 2023 02:32:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id my10-20020a1709065a4a00b0084d35ffbc20sm635832ejc.68.2023.02.16.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:32:10 -0800 (PST)
Message-ID: <07ce0eaa-d468-2425-be2a-f1868cd45419@linaro.org>
Date:   Thu, 16 Feb 2023 11:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
 <4b9edac8-20bf-be1c-6b32-69b7f7616ad5@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4b9edac8-20bf-be1c-6b32-69b7f7616ad5@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/02/2023 11:30, William Qiu wrote:
> 
> 
> On 2023/2/16 18:23, Krzysztof Kozlowski wrote:
>> On 15/02/2023 12:32, William Qiu wrote:
>>> Add documentation to describe StarFive System Controller Registers.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> ---
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - starfive,jh7110-stg-syscon
>>> +          - starfive,jh7110-sys-syscon
>>> +          - starfive,jh7110-aon-syscon
>>
>> Maybe keep them ordered alphabetically?
>>
> 
> I'm sorting by register address, or I can keep them ordered
> alphabetically，which is better?

We don't know register address here, so I propose alphabetically.


Best regards,
Krzysztof

