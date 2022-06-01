Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303B53A260
	for <lists+linux-mmc@lfdr.de>; Wed,  1 Jun 2022 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352003AbiFAKQD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 Jun 2022 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351985AbiFAKQC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 06:16:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C236A432
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 03:16:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so1476153edf.11
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l19XAZ4RQlB6J7TkjVOMmvipD7uiUl1NY4xv6/LugyI=;
        b=BtCIyFjN7SFARpIH1mnWAScPZAo/XJHoBZSi2HQQ7H83f88XfXLI/MeYvWG5YjOGez
         q8hrM8fnZplltFJ8MOqPvahGQWiFqMo+jgX0/eKYCSAlzbXiEOBkZ/Xs+9UJj3+dCAlR
         4+PnY1MSlS9esAdaRcE9nCR9J9JUnQ3jSYf97NA2Dw3NJ3I0WyGHJGJIEMdyqnOJ0H9E
         bXa4sJB7S/LusFzZBuAnmy8Z1k72D609NjRBnvVsityJqE+4PtcST5BiKZkMwEju4QCJ
         bLCtp5CXpJOQUQuceR7/5ipgBauLhhIZeuYEY6a/zfX/LzafUYE8w1vk3etCxbkkZhZn
         Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l19XAZ4RQlB6J7TkjVOMmvipD7uiUl1NY4xv6/LugyI=;
        b=bxiMS7U2qcYhFilRCTD6A7IiaFpeJXCup1420tm6BXi2gVSJmrAUvRyNF/9Anrh83h
         rRHaoT4paIu2EfFGdDhO7AgeK5PpONYfjlL09pjw6kYQJm/yuJH1NflTOXFZ8zcih7sh
         1zCQO5xwoHoTW4JzAr23b7v6fnFODpadWXdx5CHHD0bMMuRNUlVCoawfxpr4XG2uOgel
         Nu2EM438kc/iT8rYW6yV7Cjpt0YG7kMpQX5PcThAiW0wt+YWqMuP3/CDjWVST6+/HsP4
         NOh/84P2+6CO7a7r9YxWcQjKtQrLbddYSo7slYjLJBN+YvRlNLpfAJqc+LOSEl1hzgTl
         o8fw==
X-Gm-Message-State: AOAM532LgbzxzwfiZKagi1jPmvk9sbTYSPAOYZqf4qRYan4sAF9at/XR
        p5X+dIFQPPNT4MxtGGYPJ7VoqA==
X-Google-Smtp-Source: ABdhPJwqLQ4Ui6MtgBlrktb1cmqeGlIiI3nvKGpc3MDfpcX9j7W/cB4tKjt/uwhPk3xrWT+HZr/CNw==
X-Received: by 2002:a05:6402:4410:b0:427:ab6f:a39a with SMTP id y16-20020a056402441000b00427ab6fa39amr69619893eda.120.1654078558779;
        Wed, 01 Jun 2022 03:15:58 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090615cf00b006f3ef214dd9sm534351ejd.63.2022.06.01.03.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:15:58 -0700 (PDT)
Message-ID: <7f4c0956-7663-60fc-a603-fd40f0317a1b@linaro.org>
Date:   Wed, 1 Jun 2022 12:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 15/17] arm64: dts: mediatek: add mt6357 device-tree
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        qii.wang@mediatek.com, matthias.bgg@gmail.com, jic23@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, chunfeng.yun@mediatek.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220531135026.238475-1-fparent@baylibre.com>
 <20220531135026.238475-16-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531135026.238475-16-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/05/2022 15:50, Fabien Parent wrote:
> Add device-tree for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6357.dtsi | 272 +++++++++++++++++++++++
>  1 file changed, 272 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6357.dtsi
> 
(...)

> +
> +		mt6357rtc: mt6357rtc {

Generic node names, so "rtc".

> +			compatible = "mediatek,mt6357-rtc",
> +				     "mediatek,mt6358-rtc";
> +		};
> +
> +		mt6357keys: mt6357keys {

Generic node names.

> +			compatible = "mediatek,mt6357-keys";
> +		};
> +	};
> +};


Best regards,
Krzysztof
