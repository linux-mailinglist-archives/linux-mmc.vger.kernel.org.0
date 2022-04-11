Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2671A4FB502
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Apr 2022 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbiDKHgY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Apr 2022 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiDKHgU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 03:36:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502726D
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:34:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ll10so6015673pjb.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZkMojDEiOG897WMlFg+Va0QtRJHeg2erchkTICMc24=;
        b=hRdTZbnlrYWoBM0S8X6kLUXTF8SNJO5PrmDCFE/DJnzjqJS8PZQGxNejp8OMNXx5Ra
         VB4qMrcyMMDskerI3ElBg/Pfz9IYBoHMSQJCPYscb1SwHNfFoH4xY4I3GQEW5ZPWrChB
         xuV8kHfY6s5Ut/ApM6lYD93p+BCJCX/Dlgez37VfSwOJhk6cLpU9Lt0gcBNR7hjElywR
         WRlAW3OewEjN7PS+Wqh2MW9xLOukNDMbcZ7O68ihL7U3j1puvlYv1wYHKuKlIfsvgFnK
         4xffWmjv/3yXginjUG6tzLvjnvg5Kpx55SmqqMixCVCYYyYg6hu1ZlwQwX9NlunzpMC1
         375w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZkMojDEiOG897WMlFg+Va0QtRJHeg2erchkTICMc24=;
        b=ooOLmFB4kVJ285NlKFNzKUj9IZXiPsgIXba8BYCiTlk8FMWzMpuLvmrWuzyo+W5nzD
         /eNOojD2OfzsFYKEw/FmdT2MAm6+pXCpKIfVQ7fXseP80GFJWV6tk2h/011yBj4xnjwE
         ESlO0+lr1/CZ6vAQ6UdN+t/XpK9/5Lea++KWAYh0+ncCHs9KvX51fVZQEf8pnZINLVCI
         jh/L5hin1EDarkJpYQ8eqs2FP2qzvs6VL/0gGbJzPY5xHQ7kbPIYV3lBD3LPj4qhvlWK
         Hry5WmeFEDo5YxypMTeZOlse/jpg/UbkKaPo64OJNwJYZnT26VpopokZDG3VY8SySAqK
         GuVw==
X-Gm-Message-State: AOAM533sPj5wA1vIPTQ4/o93eZXALgqz+B0QIuEOvtGAIGIwgrkjIH6R
        Ew+igGxD14UQewQuj7OR9Pn/
X-Google-Smtp-Source: ABdhPJzAQ1sW5dAp4LbQendoFyZcshYJiDlJIWfSZjsLfFvcCcxYZj5kvAk6DUP9/icLNdM7fDr6bQ==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr30864306ple.157.1649662444701;
        Mon, 11 Apr 2022 00:34:04 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b00505b8bad895sm3477896pff.106.2022.04.11.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:34:04 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:03:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 6/7] ARM: dts: qcom: sdx65: Add support for TCSR Mutex
Message-ID: <20220411073355.GE24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-7-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649660143-22400-7-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 12:25:42PM +0530, Rohit Agarwal wrote:
> Add TCSR Mutex node to support Qualcomm Hardware Mutex block
> on SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 2481769..5c28c94 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -168,6 +168,12 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01f40000 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
>  		sdhc_1: sdhci@8804000 {
>  			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x08804000 0x1000>;
> -- 
> 2.7.4
> 
