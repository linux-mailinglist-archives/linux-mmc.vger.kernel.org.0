Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0853FE86
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Jun 2022 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiFGMPQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Jun 2022 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiFGMPF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 08:15:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA8C4EB9
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 05:15:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er5so22702607edb.12
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=5fH4FavPEfvLlMdMUWk9QQO46jHXVYLmKxePrfhtVTY=;
        b=xPL8KUcGOJQUW6FJ7vqGgkD7DnRuM9BbLBv1xfktYaCGemXr11kTt9hlgeR/rWy44D
         RsbYk+vgElonYHAOitiDzU81OjYUZLQqszvIIvJ8BpRX2kpcjCt9TbgRahx6J+Io1klS
         zCNPJEXCjy6asJRwIsfFUAm7JkpXdMqLGz0e8rUBCSiQdEibs2iO0eG4bY1idePyGUFM
         W6tscg+T2Y3QVHGUICuDo4KuG+UNCredWNAO604DOki/ZTHUia4AKV414vtxYnMvRlti
         82Suy2cGUjUiiTJNd3MpvBGtZfaEM5v6+fqBr2lMtfX2H4A8fsNkJdBn3UBWe+R31trJ
         Cu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=5fH4FavPEfvLlMdMUWk9QQO46jHXVYLmKxePrfhtVTY=;
        b=7l5jVfzX6+3XYzy1GEy1JdDvaaqsGf1Ipxz8slcmaX+YNa55Mn6lzzqliMc4ADtxSF
         Mu6E8JLAuSd5Png2ZJzAAc6sjTrgggy9nkfcec3FVnX56Hxz8IVUyfBSB93agdBGRBYU
         yjMPODloPjHaIgOQimntGfIJc1shk7+IUnNOLEHwROM6szrKdV7WbvTzaXE5MY1nVsLI
         8/x+sVtMCJrYGehyzBtSsczxeFEWtyGb3qQ/unLl1XnHcn2nLkmW+0tqhzgBYK5sOBST
         nEO3hTCBeGDlh8AFbQAJKWQpd6dWQGnMQELoOnYcX7w0+FFOgEhbMCamkpt4wt0ICXYQ
         0VPQ==
X-Gm-Message-State: AOAM533wWFwqdRaod6XR/xv2lhodWRo/cF5GqZN6FX28zA2Mda722EFB
        Y0g5HGg+cuTjo9qukK9iugvCwQ==
X-Google-Smtp-Source: ABdhPJx0DSqjBZ+b9BV4kl1YSSXSZRVKSEOfofAh7Iqy1JDvVeOQvA2sW119u0gPadHqCpd/wWJZ+A==
X-Received: by 2002:a05:6402:254e:b0:431:35df:5e38 with SMTP id l14-20020a056402254e00b0043135df5e38mr18206654edb.385.1654604102905;
        Tue, 07 Jun 2022 05:15:02 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906b00200b006ff05d4726esm7576280ejy.50.2022.06.07.05.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:15:02 -0700 (PDT)
Message-ID: <92db548d-aaa7-aac5-a56b-e787769ab0fb@linaro.org>
Date:   Tue, 7 Jun 2022 14:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/23] dt-bindings: mmc: exynos-dw-mshc: update
 samsung,pinctrl.yaml reference
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <cover.1654529011.git.mchehab@kernel.org>
 <5c937793dd7aec30da4964b39561072ae184f89b.1654529011.git.mchehab@kernel.org>
 <5fe2246f-97db-e7b0-a72e-c8c5ff6b2abe@linaro.org>
In-Reply-To: <5fe2246f-97db-e7b0-a72e-c8c5ff6b2abe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/06/2022 17:41, Krzysztof Kozlowski wrote:
> On 06/06/2022 17:25, Mauro Carvalho Chehab wrote:
>> Changeset af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
>> renamed: bindings/pinctrl/samsung-pinctrl.txt
>> to: bindings/pinctrl/samsung-pinctrl.yaml, splitting it into multiple
>> files.
>>
>> Update exynos-dw-mshc.txt accordingly.
>>
>> Fixes: af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Commit is okay, but you can also drop it entirely because entire part
> will be removed with:
> https://lore.kernel.org/all/20220605163710.144210-4-krzysztof.kozlowski@linaro.org/

Which was now applied by Ulf.

Best regards,
Krzysztof
