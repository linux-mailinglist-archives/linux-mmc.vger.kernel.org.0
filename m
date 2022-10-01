Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F635F1B5C
	for <lists+linux-mmc@lfdr.de>; Sat,  1 Oct 2022 11:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJAJeS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 1 Oct 2022 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJAJeR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 05:34:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F955FF42
        for <linux-mmc@vger.kernel.org>; Sat,  1 Oct 2022 02:34:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o7so2957730lfk.7
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2022 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=P7Jq51tyMHoeZHrZDGPWEeNBcJqEDxElbAOOSKcyPOM=;
        b=T42LMASoIsUMext9gElFhOnDWe1SP63HoZqV2Wp8sZsAGHiwShbJlCELgEt3h0qonJ
         GnBJEvXzb4NZwcRlQiZc9JYufsBCCD6Km86P9keyYHcIEoIt8Dx/jYOXTZJ60gmLa0AZ
         7nhT1CtyP+UejXCYWM0ubN1E8ynbSx2QADzpQevnHLX+KfpYB/GMySuDqFyxOZj+BUyG
         mjUZIlbiAWUdNmjjRvJeUXmDHT1mQfael/Mi3kg21O8fVRDnXgl4pyki+W9Z5R8wtlsF
         E6lEppVmZSKCASRLtm1LEb1CfCUsznexkuqnrmJ8kl7z0CJpIl/Ohq0jYKDyEvI8UJit
         D4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P7Jq51tyMHoeZHrZDGPWEeNBcJqEDxElbAOOSKcyPOM=;
        b=sYPuMlCWAdglClJZNxvXs7dHQd7znudkPu6b7EkJYmEdOO4yiksR2SHLi4qVqkY7Hq
         Ar5zrBsw0UUtI7Y8wtFW0/SYGQ2d2fE7K1HJBYJBjpmMB+rLPBOK0Cz0Vv8jlBMMfkR7
         Lpc5Rrtf+hTxMx0d5DC5kXSOFCKcnk9QaeFcbyvWrqocqSsqTsbSoHQkyiMywnEbNuGn
         dByl6geVxXqrjg50/Hb57q0QLTIRzScZLlJLEZq1kwCw6OMF50RLj5qzf7nRRggIxQiI
         aa6lpqdqbMcPi8ENsvBR4ohoHlLZbgmMzEyN6C4s0oh7iwrZQdOVvKJNa1Snv6T3jhgM
         slZA==
X-Gm-Message-State: ACrzQf2wWyqaiO4u0qp+ZiZqXANwLwZtbtWw/u8aulpLLex0UUFkdwQs
        QRD6QO7GJygqRpunSDCkgvnfwA==
X-Google-Smtp-Source: AMsMyM5CTnn56Q/hGDGaxBj6XigCif4H2Aa5nvxOQrL6400LmJ5o9jklu/Dp+noLYDYBQw4mPy4X3A==
X-Received: by 2002:ac2:442d:0:b0:4a2:23e2:cf59 with SMTP id w13-20020ac2442d000000b004a223e2cf59mr687844lfl.650.1664616853741;
        Sat, 01 Oct 2022 02:34:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a19e056000000b004a0232613desm702729lfj.205.2022.10.01.02.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:34:13 -0700 (PDT)
Message-ID: <084e6f2f-0976-85c8-e27c-b5ed7722d396@linaro.org>
Date:   Sat, 1 Oct 2022 11:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/5] Add misc support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030641.29354-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> This series firmware, SoC, rpmpd, tz-log, and mmc bindings as well as
> pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.
> 
> This patchset is based off of [1] and [2] YAML conversion patches.

All of your patchsets were sent to wrong Bjorn's address. This means
either you based on mainline (which is reasonable but for some reason
address was not fixed in mainline...) or on some older linux-next.

I propose to rebase on recent linux-next, so you will get proper Bjorn's
email.

Best regards,
Krzysztof

