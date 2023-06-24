Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458F373C97A
	for <lists+linux-mmc@lfdr.de>; Sat, 24 Jun 2023 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjFXI2I (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 24 Jun 2023 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFXI0s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Jun 2023 04:26:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452E297B
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 01:25:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1686984a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 24 Jun 2023 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595076; x=1690187076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9m88tdrjltI5afqB2y4W0GvMxnga3YhkyI5zgzVbcGE=;
        b=Xq63fn/XWemDzkx3c0aeAAWnkqQM+vMTmqJyDMM+c8xqtOklqM5UVjx/QJRBSnWaqw
         jrvpmmv7+n1h1fwYvqTDppb7q3v4CxpcBFLat2c8scG7YJTYn2RmymqLDDJsDvPD7ylE
         rE42LjjD4p8GfEZlnyuM6Y+bxAwhLcTrcE5m6SXqpdYJPckhjxHR3sa7nsmPaHTOo4bo
         QG1MD5s2ZYzijyxmfTee6mNrCmD3Uj2fs3fB+ZiZj7XCg9jNuU7jC6SzGnlAVZ1GVS9s
         eCF8jLAK5vJGcqxv1zMzR0xfIlnd31mZdDJeDioTtl88mW/oLVOMCuZtZlIjCR83PEas
         8/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595076; x=1690187076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m88tdrjltI5afqB2y4W0GvMxnga3YhkyI5zgzVbcGE=;
        b=VhNrkOlJlNKzAkqWEKHkHYMzISuJqxrLMi4AX16KXOmypeH5ST0DD5o5Njg0DNrcAe
         NgiDDHA0IU2mhDybfe8EHv9IQx98Ygm1Z/l778cgo7jxWRmrxgQR4cgE6wpsHCxrwKTS
         heVvScn3uefj27MiF3shG4Rts1ZAJLHfjYbz/SPqZZFMwTC9fu/xCGp2BQRV5uQpF2Dz
         b5EIDFTPw/6oL3WayuI21r8O8ClAMfT3K58j197pP+BcOpr+LtEOUkMX5Jw5x/Gm+su4
         AFolI9UgAIcYowJpnvRjyBnFDj2y4fWg3qeM+lcNGpckL/Uaj2D88cbQbltQyXjhn7Aa
         Alfg==
X-Gm-Message-State: AC+VfDxUDcBYWPzKvy5Lk/KnB4xt/7KBAfqVEQ4+Sx9k1nNdE9hO5H4U
        OJaRDHSZgTuZbIRZxfQ3DwaMPw==
X-Google-Smtp-Source: ACHHUZ4kfvWWOU4PQnvhhihUyXC/j4nl3PRhbWc6xuByephTLC+3tBRktkXGlK7+K+j6XrtjsNoPmg==
X-Received: by 2002:a17:907:3e16:b0:978:a186:464f with SMTP id hp22-20020a1709073e1600b00978a186464fmr23817557ejc.39.1687595075771;
        Sat, 24 Jun 2023 01:24:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906654700b009875a6d28b0sm626289ejn.51.2023.06.24.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:35 -0700 (PDT)
Message-ID: <769b5cf3-0182-d046-a56d-c3a076249c57@linaro.org>
Date:   Sat, 24 Jun 2023 10:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 25/45] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-26-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-26-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add microchip,sam9x7-pmecc to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index 50645828ac20..9c9dfab38fdf 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -56,6 +56,7 @@ Required properties:
>  	"atmel,sama5d4-pmecc"
>  	"atmel,sama5d2-pmecc"
>  	"microchip,sam9x60-pmecc"
> +	"microchip,sam9x7-pmecc"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof

