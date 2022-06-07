Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D7534A89
	for <lists+linux-mmc@lfdr.de>; Thu, 26 May 2022 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbiEZGyA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 May 2022 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346266AbiEZGx7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 02:53:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38A7220A
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 23:53:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id rq11so1285484ejc.4
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+OlWFNuXubaG+wIbcU6S2PD/trjlRQ/H0QdDAVlC7L8=;
        b=HTSbKdqa3Nz+rgnORHSDlCCrWGmPxq/uTvVIJ1mdxP93fxi23p4/iaudQGQ0yvJ9qD
         sVCbrRfo4bBZ9mQRMOESsrCFhgNGIGplr+gRzybCAWSTUbTrkEc8qWTZ4+OL34B9gBo5
         dOF8MFYMdEGZrlkLcq9wisY90Wjy5NOu5xRch0PKTnXgXXXoQiEdUGSOr8epjCyfTbVS
         Dr28G81aHk81OulVCikCIbagbO+Y4eDk0jAdcfnyEEMK2ynz5Uduj5WXS6eh/HElm7AY
         yhKdPVZCKYG7q/YHZlKZoSErjnkxy2vKC9OXBJfkrBc3mnIe3F9Jp3DD8FlhwnTPS8Hy
         kCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+OlWFNuXubaG+wIbcU6S2PD/trjlRQ/H0QdDAVlC7L8=;
        b=p8FKfa/D7uBnUTnVMSXMbFUXXqBJiFSEXINJ/1MLOfnMIzYLbLHj70PcXtlPZTqL3h
         RNWnV1rcmYTaD2sB2GtttMzawX1qPFb2fwsVeLAjlG8n/aiL7y8VF9pJSiZzGr9fPOAz
         gDj1yQoESWvZ8E134Zqk6PNuleRy2SaLcUhcMq5DSY1wPwXeiLGGUeudt0nxjfDLa2Ho
         hkUVmfkeGLV4g+O8Yzyp9lI86T0O/p7c5MjBtUKSn2V0WlnfIe4rhZMAoxIJzPtWZ3JR
         I4Lz1kLpttmDq2xYclSyYm3Ll4JNyQd7hx2fUZ0FnJouzIksiqRa/Uh+z2yaLEJsFJz8
         6EYQ==
X-Gm-Message-State: AOAM530AB8+wwPlBR7lgLVDApSxmSkUqENw9ezxbLFtU6f5nPLLdBBsU
        84jgwKMJTXgPIQ0qemEbHdoqAA==
X-Google-Smtp-Source: ABdhPJxK0GdBqnqhHeFKnB17hFODfbqtX8jNbVhbmw+n/G8WMqDopEGaBisjwS7Dq3PBf+ZqYanNVA==
X-Received: by 2002:a17:906:9b90:b0:6ff:a02:1f9 with SMTP id dd16-20020a1709069b9000b006ff0a0201f9mr9350097ejc.672.1653548036203;
        Wed, 25 May 2022 23:53:56 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x65-20020a50bac7000000b0042617ba63absm389060ede.53.2022.05.25.23.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 23:53:55 -0700 (PDT)
Message-ID: <8d2c9375-63d7-6d36-8a0b-6c5d117cc213@linaro.org>
Date:   Thu, 26 May 2022 08:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
 <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
 <CAK9rFnzPEq1_zOnHYzTDyOOU9xRsuP-KBEFnc84cRoyfAve+Jg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9rFnzPEq1_zOnHYzTDyOOU9xRsuP-KBEFnc84cRoyfAve+Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/05/2022 02:19, Brad Larson wrote:
> Hi Krzysztof,
> 
> On Thu, Apr 7, 2022 at 12:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 07/04/2022 01:36, Brad Larson wrote:
>>> Add Pensando common and Elba SoC specific device nodes
>>>
>>> +&spi0 {
>>> +     num-cs = <4>;
>>> +     cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>>> +                <&porta 7 GPIO_ACTIVE_LOW>;
>>> +     status = "okay";
>>> +     spi0_cs0@0 {
>>
>> Generic node name needed matching the class of a devicxe.
> 
> The device on this spi bus is a FPGA with 4 functions and looking at
> other projects I've changed it to a resource-controller node name.  On
> cs0 there is a sub-device reset-controller added in the upcoming
> patchset to enable hardware reset of the eMMC device.
> 
>>> +             compatible = "semtech,sx1301";  /* Enable spidev */
>>
>> This comment is a bit odd... did you just use random compatible from
>> spidev instead of defining proper compatible?
> 
> Yes, because adding a compatible was nacked.  We have a driver added
> (two actually, mfd and reset driver) for the next patch update.

Yeah, but using some other one is also not correct.



Best regards,
Krzysztof
