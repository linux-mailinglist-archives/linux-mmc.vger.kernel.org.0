Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F42619B48
	for <lists+linux-mmc@lfdr.de>; Fri,  4 Nov 2022 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDPTa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Nov 2022 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiKDPTZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2022 11:19:25 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39694A457
        for <linux-mmc@vger.kernel.org>; Fri,  4 Nov 2022 08:19:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id mi9so3389312qvb.8
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2022 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRnjrNrKpUEdCWynwN46DRbvjj6rSysENOSI8RxBlNo=;
        b=nG9oFgohsMgh0IKM6eaQaQ76xOTmewTADKqUnB3LIf8Pyh2WRzvGKl2UgeDuNsnYrO
         ZhO0HKTxzc2OyZQ1bglKCjndW9q33wxeSysF3DgSu4S3CMtFgd9y90jyWtC5b5U5ifjO
         aqfvBJVpBXXQWhAxEHawDdO9jwhdjT6SLOw45/Y16BFnutT5MoPm22ogdg0yZFT3U1vE
         lQcM6vmJlDiOmFH6oWMlPc0e3QC6JZIXwFeREE7TJRUb2bs+LV3pQRpNjk9KasIeY7Iu
         tWqHLNTjzLeGW+1hcJSDcC3DyWPpc0/FLatlRgpXn8OHXAzG96ee9jwrbMZJhiNmDvNv
         BM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRnjrNrKpUEdCWynwN46DRbvjj6rSysENOSI8RxBlNo=;
        b=JXxc8Jwshqocaz3Q0OR5cg2UF6cQj4f4/CpgEk7aESgj2KCvzyKKj6/Qw9XqUqLMnS
         /UpHYl9Iu/jyExGj9EDN+PR7YEpXSRujLhOwOrntiH/Oe/+VskE8GkLQATAjAR72FZCj
         Zm9XaV9B4eI5mz+H14Xxav9kopITdoZXdOdZVps/TqT2t5HIt617TKPIDpjTb6lcG3XK
         u6VvWKZW/Lfsm2XE2QgCUOU7br6NFmIlyU3n05I8uaZGt0RcsRpIKSbc/Ri8B8AgVymO
         EJUiGfTsOE3hnjBSwUudyvpj04RSWM/kQGBWMMeQ2dqLtPbZznpzsY/wLCn1f8Fe7l3M
         uk6A==
X-Gm-Message-State: ACrzQf1hxryVElyCY6Uqd3cTj5YNhYmjSf5A3tmzhxEEKDhNmhqkxsyT
        tJyi5glh65tDA1ZDPFXAyQhuCx+YE5O1Fg==
X-Google-Smtp-Source: AMsMyM6/bD7TwetAszdHR3EmYhj0XT1Ya2qXerlaVZb95uTZIfvp1C7Y6AQQUqEDn0G3VLRG4dxKxg==
X-Received: by 2002:a05:6214:20c2:b0:4b1:316c:67a2 with SMTP id 2-20020a05621420c200b004b1316c67a2mr32412761qve.32.1667575163412;
        Fri, 04 Nov 2022 08:19:23 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bq37-20020a05620a46a500b006ee77f1ecc3sm3160269qkb.31.2022.11.04.08.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:19:22 -0700 (PDT)
Message-ID: <8cdd0560-8a64-de1f-d1f2-a4dc729f8970@linaro.org>
Date:   Fri, 4 Nov 2022 11:19:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] Mediatek eMMC Inline Crypto Engine support
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221104095848.27444-1-mengqi.zhang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104095848.27444-1-mengqi.zhang@mediatek.com>
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

On 04/11/2022 05:58, Mengqi Zhang wrote:
> Change in v2
> - change patch 1 commit title
> - change patch 2 commit title, and correct commit message
> - add crypto clock description base on new code base
> 
> Mediatek eMMC hardware IP has Inline Crypto Engine (ICE), we support inline encryption now.
> 
> This patchset supports Mediatek eMMC inline encryption which meets the upcoming version of the eMMC specification such as v5.1 or v5.2.
> 
> Patch 1, add crypto clock control flow in mtk-sd driver, patch 2, document the device tree description about crypto clock.
> 
> Mengqi Zhang (2):
>   mmc: mtk-sd: add Inline Crypto Engine clock control
>   dt-bindings: mmc: mtk-sd: add Inline Crypto Engine clock
> 

Your threading is broken. Resend with proper threads.

Best regards,
Krzysztof

