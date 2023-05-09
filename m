Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA46FBF03
	for <lists+linux-mmc@lfdr.de>; Tue,  9 May 2023 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjEIGHl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 May 2023 02:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjEIGHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 02:07:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7609EF3
        for <linux-mmc@vger.kernel.org>; Mon,  8 May 2023 23:07:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso9873977a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2023 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683612457; x=1686204457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJwJ3lUCWaeI9xt1H2n4gYB2pq8BNEnon5LHiMEUlm0=;
        b=oDETymYlpE3eA939L9Tgg9ZoFD35m5Kz2/s9k+Ze/oXILZs7Y8Te45zLnH0VEEU7mg
         YBPWV1KOVyTFEYgnPTve4frViqbQrJ7JiHLD6bcLuHx7oPM3S79RJbmbQ0thdbiKg0CP
         spJekN+fPAhKzuonevMBQGXGlf2DKeKVI2Hkj6c5w/p5HkAq2JSKBZCGWA21fEwoQw4x
         BBR4KoToBRrssN6wtF8LrXpCBz3VXQgj+TP8mNe70JRKEv0xRp22MSa1vI537V+Q9hiw
         Xj70xIclhRa/wFh4qJvGX5Yf4qGlZuzLm9+2ivNXLHF6IaUu46t5ZtdAFjkZVomQjd9W
         rUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612457; x=1686204457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJwJ3lUCWaeI9xt1H2n4gYB2pq8BNEnon5LHiMEUlm0=;
        b=HyER0O8WBvt9lP8lPYH+006WW2qvlQCEe4zzJooIFZYo/JAxaIV0ouDLx9rzOVQO+4
         y4ELEmx21WLnK0W3m4oFYrUSGE9LJv/stUFLFKsBQQhjCVm+EPDX7DXXs88tVHVbEiUW
         Bz1pNgY5haOnjdTP8F/hlQ6+TpB5TjXdKhNZiNgIRC7TJWVd2HXyWfwjHkYOoGTtOgZ7
         k9w0sxXBiouep0Ty5NKntaz9T1rWKRGQOp1G9adBDT+4wYjxUT0iMAuGBHTVrqtIS2HM
         xaBFA93bEf/gtj2OuvIyjXd34pmLgC3k3qjaTNwdFELWu0G08U8PcxMbGJKCo+UwME/H
         6maQ==
X-Gm-Message-State: AC+VfDw0pde/B0au5cGbwCDUodVc45wV5Tsmccp/OI+ZLWTCqPK02Z9a
        gtu3vMwfmCBY4M0Hks3RO9peGw==
X-Google-Smtp-Source: ACHHUZ7AL41IuvXDZ9vfBclUbizEzgEi9z4TdWexztQRYu3SjKmN2WB3INZq2YNBvLZId1k/q7Fcwg==
X-Received: by 2002:aa7:cccb:0:b0:504:a359:3fa8 with SMTP id y11-20020aa7cccb000000b00504a3593fa8mr10194768edt.20.1683612456917;
        Mon, 08 May 2023 23:07:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id o22-20020aa7d3d6000000b0050696c2d2f6sm328200edr.88.2023.05.08.23.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:07:36 -0700 (PDT)
Message-ID: <04bd4a18-0b4b-dbbb-d095-1b924b737d8c@linaro.org>
Date:   Tue, 9 May 2023 08:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document SC8280XP SDHCI
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509030136.1524860-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/05/2023 05:01, Bjorn Andersson wrote:
> Add compatible for the SDHCI block found in SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

