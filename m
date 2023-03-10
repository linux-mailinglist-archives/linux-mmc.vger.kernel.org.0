Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633A6B38AB
	for <lists+linux-mmc@lfdr.de>; Fri, 10 Mar 2023 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCJIan (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 Mar 2023 03:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCJIaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 03:30:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC2EAB9E
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 00:30:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so17299526edb.9
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 00:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p60r4RQIq9lENEGJ/QlwBJoxKpdBJ8AZmTLP4vyPj0c=;
        b=U2DJBT9jLSVEnNTuWNboA4NSBMdTcdylwj4pN0VNQQI2ErOS9XwoG/5UrpaHqqS/yZ
         TaUDD6IXkLxo7YmKotKwwzGxl5/vjGDKpXS2bry+fDmKinNTz2I8ajdkJs+7D2dEdiUg
         LQ32+z74oJynSwhXUCJU3Xr/PUFW4q8/wE5jjr1qBKI1tyXuREmUoEckFUG0QBcy5xS5
         thxJtBxSVTpkpjfiBHyBwOnAGTGLivPNE7WpimSYNqzkGYF+8B+eijs3NMmgFsEPFCI2
         soe2e5hXdPO3EzalOcHwwMlgX8geBEGgM3FsAySqdoel6QmozeCbEYTDhvS7LNI/fqVj
         nZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p60r4RQIq9lENEGJ/QlwBJoxKpdBJ8AZmTLP4vyPj0c=;
        b=O+F+mBoZYm25xwUDOynGpokWvSOyo4hDj04wp7BIEDZ2p0ZYWA0an979z4m1qkXUh6
         HPljsQqrfqRS4PaENEsEpNLoaZNt0d/XWIvfltrzt6le0absPffj0n8CCQ/vH/hKG9xx
         9+PWJYBYRucPXF7popN0iAhDrQHYzmkD0Wui3Fz7FQ4HdVfujwlkDtLqLAYZ461oAg41
         wMhFl1wOMGPTx0mPRJdpbN7NPxiqkquj8Yj99VSRRcAapAbPHlaRWVm1Jytu7D9Y8v81
         oSVJtWMA6bfxhB+U/pG4/Yzhzj3FOa1XopxZFs8cFGiCjcUYrFF5sRwofk+CAxA173i8
         fiAQ==
X-Gm-Message-State: AO0yUKUouSwKgvzACe51+H3zux9CgZqUuy9m1TZgca/HdZzZUPjym26H
        8d5KE0V2OOUp61m0lU0wRg+SKg==
X-Google-Smtp-Source: AK7set/yNYP1EquMq3rDndLAJVWho/hyhK9d2ZxbDbkWV9KHk72jmIVb6JNErXFWMCT99dUz7Sb83w==
X-Received: by 2002:aa7:cd0d:0:b0:4d4:d933:4ebd with SMTP id b13-20020aa7cd0d000000b004d4d9334ebdmr23053795edw.14.1678437026457;
        Fri, 10 Mar 2023 00:30:26 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b004c25b12b7cesm541950edc.42.2023.03.10.00.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:30:26 -0800 (PST)
Message-ID: <008f616b-c956-f9ea-7436-039f69808c8b@linaro.org>
Date:   Fri, 10 Mar 2023 09:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/18] dt-bindings: mmc: mediatek,mtk-sd: add mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com>
 <20230203-evk-board-support-v2-2-6ec7cdb10ccf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203-evk-board-support-v2-2-6ec7cdb10ccf@baylibre.com>
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

On 07/03/2023 14:17, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-mmc
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

