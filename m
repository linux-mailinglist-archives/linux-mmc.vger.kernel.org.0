Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78F62F839
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Nov 2022 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiKROvF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Nov 2022 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbiKROuv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 09:50:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C18FF88
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:50:49 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so7063098ljr.5
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flARCzHTVyCR8t1b/alFfXpYG08uQcpbdpykx0qaY6o=;
        b=WPhguTbEITewUUFmzDKk67xFlcItotk7CHPjo38HZOuTantjdkogWORtgo0xLlYRgF
         HWg9GOTf1V4e9ThxnO5h7EGEtSAM84fFMdKNcc5IiTsPgjkjtPAow8xj447vQZ+xI9fu
         +EMNqv8xxM0kkgUKOkUMQThTtqLNuitsLUM2+q9sG4Mf7bfPbimkEiHxBNyigCGXB3JH
         hkw+VprjJL3OtOt+z25ktmnAiSNEDvhjN41HMNxYzS7ZhQbxwhTFwKXP3WbivZpl7aB6
         XkuF/NX6RxoqzQhWxmZioNe+aR0PcSCpDbAE6M/O59pFVA7b2qTsMwpCsLKRSomd9Dlv
         tTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flARCzHTVyCR8t1b/alFfXpYG08uQcpbdpykx0qaY6o=;
        b=KL88xUZxklmc4/0VF4rvqh3mTaB0wEIb3O1Tc7oGZpNRdq/EjR4ciPkc5YnPm1+erD
         y4S9OyKEGmdrWxO8d1++rb3RddUm58V6YxvwKKPFV4cjt+RSTp1BZhzqjOIdFKIZ4hc0
         2ny/rFAtVAW7yhYB5mz+xZdrsUyN17NtO1ViN7j91jgRg5AA0iMgZ7Ea52KTzX9WdHVQ
         cY1qWk18twuhToFR4OO6BO5SQZwym7ktiyUAm1kX1DOTnHCCOBadFZNwM5Bu287Qm7AW
         qKq2250K4QZ0jJdL+TD6KrtokHf3QCUhxTj67MIMp+AxnILVPVIWEfOznwmwMg/tWzB4
         FQJw==
X-Gm-Message-State: ANoB5plnoPOY8zCsyJGN5RS6aJxt6ky+e2hs/RFd46PTeNlzKfKoPAB/
        qeE0YjZLPaids4D4jdXRtpGCXQ==
X-Google-Smtp-Source: AA0mqf59msaFmJhx4BlNDfC6dSrkN8YU7SVi7qZH3ZaQ9nO4p90o4YgmHrxZLIkn1WuJ/YF2IErpqA==
X-Received: by 2002:a2e:9c13:0:b0:26d:c072:ddd with SMTP id s19-20020a2e9c13000000b0026dc0720dddmr2701980lji.158.1668783048034;
        Fri, 18 Nov 2022 06:50:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id dt25-20020a0565122a9900b004947a12232bsm676480lfb.275.2022.11.18.06.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:50:47 -0800 (PST)
Message-ID: <b2f16f4d-f340-185a-ecfe-5d83e8b8ad6a@linaro.org>
Date:   Fri, 18 Nov 2022 15:50:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 06/12] dt-bindings: rtc: convert rtc-meson.txt to
 dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson6 RTC bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/rtc/amlogic,meson6-rtc.yaml           | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-meson.txt          | 35 ------------
>  2 files changed, 62 insertions(+), 35 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

