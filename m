Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7963D59A
	for <lists+linux-mmc@lfdr.de>; Wed, 30 Nov 2022 13:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiK3M3n (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 30 Nov 2022 07:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiK3M3l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 07:29:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18576142
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 04:29:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so26636528lfb.13
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 04:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+AI0MJAZxzSaqzb8F3zaCppW8AIzXUV3tWxM7Mevyw=;
        b=kQQPClqFnsW+DJBXxmsAnn+jQogCKmDoaRFEh20J5bWCzM3porK8SZK5p885eC5s9j
         wGa3RhsC44LF6ElaUDIBgKxSt+DtHFwGpDstwVz/KYT/JjMy8JBBNV3vl+C5LthfLOgw
         rv6L8LVtVQyEeqv7ji8VYhi0gGL4lcYJW0fgzf68i39DBf0GxNmtrTcc1NwiwCjl5+z4
         4TjiysbEvJ6GQ6K4CplKwahFw3PVIc23lHQ4qAfrNX4XnoWYds3eZRR3mKggooMk3PKn
         v27prtApWBXpC8D6Tyok4nf53Lty9kgxGZ7ZJwyhHG6p0QqAG9JijSmJ8ghg1MKqYDIu
         YeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+AI0MJAZxzSaqzb8F3zaCppW8AIzXUV3tWxM7Mevyw=;
        b=RqekIZsyjnhvX3iBxuAw1o8qKztYRGt6QwoKWeVuZdaC4OLnbd6BzNTv5AI3QnKyUn
         7cT2qz7sQ/3OaeuKWwClY4mjeSYSKzSnWqcz0CLmkQ5+hHaMwksD/6Ky8KBCaUASKKl9
         c6RW9yfE8e6L6y1G4IrkoVzDbMRjbkkC2JfZaVI7SJVBxRq0nnaksW/uzG9Oa4N2/9Ak
         kLmz8Ljjr/rhgOeSFm2vhMxRJ3NzQy5MjF9WX5kk0COjTbrOAeTuJu0Flwu2jUKyXkJn
         hTcInHRgwl2GsET02WfYHc04XP+i89TgrDXlajNXt6NCtusGWsFiam6mufNsGZzw3Xp9
         7epA==
X-Gm-Message-State: ANoB5pk2I+VWTbWG2tnMO+NZ6yg5mpmdFn2Xke4O2+j/7gWRORG321WZ
        tespyF+b5MZMSYJWd6UZRkRa6w==
X-Google-Smtp-Source: AA0mqf5m6UjtSqDKBQS7eed+m1t0mu/Z7yR8/1BTYHlrCHHsaZWupm2do1AtTsSghfeNJ1Z2WN307w==
X-Received: by 2002:a19:5215:0:b0:4aa:4da0:f8a5 with SMTP id m21-20020a195215000000b004aa4da0f8a5mr19379487lfb.288.1669811378826;
        Wed, 30 Nov 2022 04:29:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004aab0ca795csm239023lfr.211.2022.11.30.04.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 04:29:38 -0800 (PST)
Message-ID: <171b7fcf-7072-89f9-7cdf-6330fa549e20@linaro.org>
Date:   Wed, 30 Nov 2022 13:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3] dt-bindings: mmc: Remove comment on wakeup-source
 property
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221130121033.7270-1-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130121033.7270-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/2022 13:10, Christoph Niedermaier wrote:
> The current comment on wakeup-source is a little confusing because
> the word deprecated can be interpreted at first glance to mean that
> wakeup-source is deprecated. Also mentioning the obsolete property
> confuses more than it helps. Therefore, the comment should be removed
> completely because the enable-sdio-wakeup property is not used in
> any current DTs. Also remove enable-sdio-wakeup reference in
> wakeup-source.txt
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

