Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD52A5F1B4C
	for <lists+linux-mmc@lfdr.de>; Sat,  1 Oct 2022 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJAJ2p (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 1 Oct 2022 05:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJAJ2o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 05:28:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4052440
        for <linux-mmc@vger.kernel.org>; Sat,  1 Oct 2022 02:28:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j16so10226769lfg.1
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2022 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YdPHxxrsTu8LYdCepcG9y1MKQ3OdnJI3POPrADnpEgg=;
        b=xg9mTtvdWNdexWck3qcrU0/mLGdrcl5gP6TF4vNz0rshUYG/ZOsbQhM6Xe6c7SdJBi
         gEWMs8H11WZEuiF0B/XuMr4mSWNJ7dr3muhSLqcj5FBA+Kg8hX0PP80D2bZvnbBGebQ3
         2SQphnKAhNjHLkl8eTbJk0PqSx+Y7E5UOpc1VrO38FjdX42lTXdxVgNwJysT4iH8DhHY
         1thM47N5sjqDvVtaDcnv68xR5u+jljMpJqtpKPang3zKc6ZoDjXhGdJTMvO8c/z2un+u
         WUmPhHESK1ZwieclZqS2JGqzAzJJiSTpET9OT80RJtjeA/Hvw6/7SCOONfOTK/EMODYV
         MGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YdPHxxrsTu8LYdCepcG9y1MKQ3OdnJI3POPrADnpEgg=;
        b=a3H2aiYrtoDABwObSCsRTxEsVCe4gwTsAzDVSlKOWdGa4/yGLCi2mIAZdFw2x3bV2q
         ONsTWw+8KOCaJht/9FaK7GqlvewUIBRS36ygiGMX2LS0t1Susuh+9BD3n1VlpC5z33IQ
         FqKGc1wkUWACMamwPNptPGAvF4HG5qnk2C4+yKuc7HPFhnYSeiTfM30nkp9yuQ0ze6cZ
         66hi5nrCcnn9gtdjwfpKlZJH6s49FuW8erRQtdSky3kcKyTthntAA122/GRJDgBVUvz1
         xCS+zAAG43H6YZi60E/s3orrra/0Z6ySEZepMlrfxOccZ1ijsoAMyScXLuMhSbZeIs+4
         qOpg==
X-Gm-Message-State: ACrzQf0dx8//hnaHNkPyQpfmAiQbpI+GllorQZHcl2Zg+A4u4E7kd77g
        /nfOlPct9pZCozq/b2ajXFDcqQ==
X-Google-Smtp-Source: AMsMyM73dNZllJJbkaOeh+4CRO/HvU5rKn/jqqmuBTDx1I1F+c+bifIfykTSjnGeLIepliZ7wpFGRA==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr4452776lfr.339.1664616520531;
        Sat, 01 Oct 2022 02:28:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a5-20020a2eb545000000b0026c687f9f7bsm361292ljn.107.2022.10.01.02.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:28:40 -0700 (PDT)
Message-ID: <874940fc-3975-172d-b5a6-6ff7e510047a@linaro.org>
Date:   Sat, 1 Oct 2022 11:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 5/5] soc: qcom: socinfo: Add QDU1000/QRU1000 and variant
 IDs
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
 <20221001030641.29354-6-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030641.29354-6-quic_molvera@quicinc.com>
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
> Add soc IDs for QDU1000 and QRU1000 and their variants.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/soc/qcom/socinfo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 4554fb8655d3..d10942b1b9a7 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -334,6 +334,12 @@ static const struct soc_id soc_id[] = {
>  	{ 482, "SM8450" },
>  	{ 487, "SC7280" },
>  	{ 495, "SC7180P" },
> +	{ 539, "QRU1000" },
> +	{ 545, "QDU1000" },
> +	{ 587, "QDU1010" },
> +	{ 588, "QRU1032" },
> +	{ 589, "QRU1052" },
> +	{ 590, "QRU1062" },

Rebase on this patch:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220830065744.161163-3-krzysztof.kozlowski@linaro.org/

It is quite discouraging that it could not be merged through that entire
time...

Best regards,
Krzysztof

