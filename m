Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A5739735
	for <lists+linux-mmc@lfdr.de>; Thu, 22 Jun 2023 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFVGH7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 22 Jun 2023 02:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFVGH6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2023 02:07:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293CE7E
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 23:07:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b46cfde592so73883451fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687414075; x=1690006075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42WBoV9nvhGVfUL97mST3SZ90VrS3Nxy3thM265lKf4=;
        b=V4oIr2JjcN7zS6KKE1l2Vf16GI3VsP8o0UfB7Gkwzv9ph4LbLCqbZPGoxHmpaiXVbn
         Z5olqhr5H1abgfr50b4N4SpOiP/gGhdwIjZt0/vRa87fThcR5yWaDN6mluRlMPCBfG4a
         Ajm6lNKotdKSAtNij++Qr+4T0SW1nytFJdUUTDauYsvFyYkWmGVS8YLmnGo/LDQlL/pc
         yQ6yIoPOu5u7FSZMTt4oILXBpOAJ6f+uf4eZk75xCUcJcsDWBmXs/phVg7ipxFkHYBaA
         0Gt4Fejy1LcJUIIZpgNHHWodkO60cPX6/qgr2rkBpLlYOTK6Y36T588PIrrTXoJj+gZV
         vNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414075; x=1690006075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42WBoV9nvhGVfUL97mST3SZ90VrS3Nxy3thM265lKf4=;
        b=OYNEjTPN9HrPPqfs4cBTFZqFpErzPUShH6u7TGXe6KFghBJsQ9ExUXWg7FFiFVVkuB
         gGwNMVfMROBmmy88D2BE5Mi8KUayF5goEvztMZNuqMzld1tgpI1UVTG7PoCB4rb+cRYI
         c7pRLOHa3E7iiE9/KDkCJg3pZXQX4LCTP+xNSSbrF34gig291Qy9PxnWuE9dSFpSb3Qe
         BHjsfnZX/3qQI4WupgP9VjvCtmTPWIaPqqrXX8thcevVs07iVQeJSKTy5n0dUYdQsYuh
         gwbHrq4nEx2zXjw8am1lgUL8seumVdNDwBh9jLAnvH+VeyC2EFbDuAEVrzdXVk3soGho
         ZiZQ==
X-Gm-Message-State: AC+VfDxGZ7CA4K7sje7LDEoqFau84fZ5P0S4SH/5/GEt0mmSikkqji0X
        OQBosBBENYB4PvRoFU9DPX0Yfg==
X-Google-Smtp-Source: ACHHUZ44/dBU5JQciwFC/zC9afOtRvdAyg2U902n97s5dynw933e4XvREw3eHG52sOonDsrwU9HxWw==
X-Received: by 2002:a2e:b601:0:b0:2b4:8623:cf74 with SMTP id r1-20020a2eb601000000b002b48623cf74mr5829296ljn.18.1687414074964;
        Wed, 21 Jun 2023 23:07:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003f8d0308616sm6760823wmb.32.2023.06.21.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:07:54 -0700 (PDT)
Message-ID: <80ca0da4-5243-9771-0c4c-62b956e97b2f@linaro.org>
Date:   Thu, 22 Jun 2023 08:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20230408214041.533749-1-abel.vesa@linaro.org>
 <20230408214041.533749-2-abel.vesa@linaro.org>
 <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org>
 <yq1ilbgqoq6.fsf@ca-mkp.ca.oracle.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <yq1ilbgqoq6.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/06/2023 03:19, Martin K. Petersen wrote:
> 
> Abel,
> 
>> Un-reviewed. This is broken and was never tested. After applying this
>> patch, I can see many new warnings in all DTBs (so it is easy to spot
>> that it was not actually tested).
>>
>> Your probably meant here:
>>   if:
>>     required:
> 
> Please provide a fix for this. I don't want to rebase this late in the
> cycle.

AFAIK, this was not applied. At least as of next 20210621 and I
commented on this few days ago. Anything changed here?

Best regards,
Krzysztof

