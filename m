Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808697645F6
	for <lists+linux-mmc@lfdr.de>; Thu, 27 Jul 2023 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjG0FoW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 27 Jul 2023 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0Fnw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2023 01:43:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B544A3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Jul 2023 22:42:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad907ba4so3584995ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 26 Jul 2023 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436497; x=1691041297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hOt4JSGfUE5gU0yacloLGJlfRYBYpf+ipeOpBUjKNM=;
        b=Kuq9l8I7Ju9+mfwW/4hNW7XR2Of8OzPo9y3Knw4BfrpCs99gGGoSzDMYJnVSc+QCPO
         IBmUoXbgJFEMzxwfKyXTVvSgevk2H/JsIf0tMDC1KBlqFzMV/Kg5mn38xva5mum5pY1V
         rkgSC9C3h1igGM0Ha8T8mvi9eLoQ84lWq8fAiAqq4rVr26S9AnVJm/tZgYK0+7BIcHmy
         WYc8jC2FKhI8k7JnaHiGi7pn4nlPJduoNAMC1MS8ZEShlOcIg2UGfJUv86WRFUZCRvOK
         heFJKWYxs81gekLI23ka3N5kbL7Z9E93tnQgfCXSborYvO5V2w5YxwjQk5g+zwf9bHR/
         P4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436497; x=1691041297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hOt4JSGfUE5gU0yacloLGJlfRYBYpf+ipeOpBUjKNM=;
        b=XuuG9XdeIr9e6/O1m3gjjqBIfFUmrHnAclchEvL9CKNmWgXPS0f4tbCMDGSvWqZZyv
         DjEnMqu/JqoevZls+BJBThaJ9Yx2SF6P3w9U0u8iZLKWuIf8RcQnCa9f7vb+awLsVgjD
         xBhQTPAUUTx+Ha8rIF+xdm3yXsfn276SwRqMkyHAtK/P+rtWBopeY7pnxNrDP+CVNGtL
         drtu1rRL6b/6rFxmcLi623CHQMovsT3MfLhKmObHXlOHlhGAPmujzTp6N1sEwySIxBVH
         ptS72vVVVz3KQMhk5rSv0Dy9Vo7cHQaW+Ptu9b1M1h7iP7djTvm2ibiGNmkU532bc3Kg
         n4dQ==
X-Gm-Message-State: ABy/qLbrH4qu1pbVMUQIk5gH1nuO0jtaKlSpQAvwjw1QqcXZwvZ9oGmz
        IPqZhvmo/uxcR9cF0ZyHQ/aMTA==
X-Google-Smtp-Source: APBJJlGLqhEYZFyockZ7kQ8xzFt6+vTwuXVKCHw0Pf4YFqnPNsgR9xQM23jn+ls85R/x9uD/DbKECg==
X-Received: by 2002:a17:903:48d:b0:1b9:cb27:7f43 with SMTP id jj13-20020a170903048d00b001b9cb277f43mr3256746plb.43.1690436497422;
        Wed, 26 Jul 2023 22:41:37 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id jw16-20020a170903279000b001b8a7e1b116sm561407plb.191.2023.07.26.22.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:41:37 -0700 (PDT)
Message-ID: <7a8e07cf-2995-0018-b658-91a37457f05b@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:41:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 46/61] mmc: atmel-mci: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-46-frank.li@vivo.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726040041.26267-46-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 26.07.2023 07:00, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/mmc/host/atmel-mci.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index dd18440a90c5..b4ae9aa939a5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2600,7 +2600,7 @@ static int atmci_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int atmci_remove(struct platform_device *pdev)
> +static void atmci_remove(struct platform_device *pdev)
>   {
>   	struct atmel_mci	*host = platform_get_drvdata(pdev);
>   	unsigned int		i;
> @@ -2630,8 +2630,6 @@ static int atmci_remove(struct platform_device *pdev)
>   
>   	pm_runtime_disable(&pdev->dev);
>   	pm_runtime_put_noidle(&pdev->dev);
> -
> -	return 0;
>   }
>   
>   #ifdef CONFIG_PM
> @@ -2664,7 +2662,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
>   
>   static struct platform_driver atmci_driver = {
>   	.probe		= atmci_probe,
> -	.remove		= atmci_remove,
> +	.remove_new	= atmci_remove,
>   	.driver		= {
>   		.name		= "atmel_mci",
>   		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
