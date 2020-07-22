Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC621228EBD
	for <lists+linux-mmc@lfdr.de>; Wed, 22 Jul 2020 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbgGVDsj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jul 2020 23:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbgGVDsj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 23:48:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A0C0619DC
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2020 20:48:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so461892pjg.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2020 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G5KYjb9bNgf9eCCuCYizkaT2kpB0m1ixCzJ1dcGJY6U=;
        b=V6d5SPltSWqumvHstU3VvtLH3Ci84LGquioPfjldy1c4jhoQ6FglxljnmTta/cKn+T
         qIcb73/3/Zq5LzqI+8Pdijq8nmyesJbsxBubdTV4uA/K+CEfCl0t2wbrmjCM1Bi79Hvd
         uRDKG72AbHFIAZY3whaU+wxChhzDp4CiViLqQugbf7Zfy2Ob0xKH52lgjvJkm+5SrsB1
         /pw16L22jEI8bHLKdleJtlTaNbG6wdY69zqC9mtS0n9vQu4yMUTfkBHoz8OZMDCBZFS6
         egrg/DTuecWnSNHSjcVkGw82Rm50z4ISCRC8t8LfAjZJv6IQ2RFd+23SO7+xYIeeuT+k
         UxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5KYjb9bNgf9eCCuCYizkaT2kpB0m1ixCzJ1dcGJY6U=;
        b=BzZ5xds/8BwKtvR7+DJSl8GKUcAkSpM42JtP/Wz9RhYEZN6/iQCqM1wDm2hMJot3f/
         Ekj3HtUDm6emutjds4zMzSLH2JzC7gwcJdpWiooiWUSEvnR2ImDWRWnarK4fN/9ACEpr
         RgrQDUTXexAY7BwlZGSz2IeQBgqySjZmbf1GweQCQQve2NkD5bTH1n2mBxHtBrYZxGhF
         6oyVivA6vE04/PaCoX4ii2pMLXBd80u5Z1Ug84mJnGjSdf6Of7Zw4izqPDIMX00Y27vF
         1xIlSfqc3bOaPgmxeE9SuNe/nugrLFhrIu7U2HB0EWbX5YO+Vw3dJEg0ZyvWA90BxrtV
         AGrA==
X-Gm-Message-State: AOAM5334O3Byl0iwgB4rKYJjpiMOyPZ2vF5scDiYXKQKkpvR834EqZ7I
        mmvodw+6+DsH5yel+N3B9H7X8w==
X-Google-Smtp-Source: ABdhPJxHUzJMxV2Q5+PGR2CNZ4P47YBRSndklbesbF/hAWkYin017A7oyZFQAs4vvRl+MU0+ZZw73A==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr8219218pjp.228.1595389718402;
        Tue, 21 Jul 2020 20:48:38 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm21383713pff.185.2020.07.21.20.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 20:48:37 -0700 (PDT)
Date:   Tue, 21 Jul 2020 20:46:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7180: Include xo clock to sdhc
 clocks list
Message-ID: <20200722034644.GP388985@builder.lan>
References: <1595328268-29398-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595328268-29398-1-git-send-email-sbhanu@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue 21 Jul 03:44 PDT 2020, Shaik Sajida Bhanu wrote:

> From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> 
> Include xo clock to sdhc clocks list which will be used
> in calculating MCLK_FREQ field of DLL_CONFIG2 register.
> 

Can you please describe why this is useful, perhaps required? What
difference does this make and what problem does it resolve?

If required please include a Fixes: tag here to show that you're fixing
the previous commit.

Thanks,
Bjorn

> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d78a066..7ccb780 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -682,8 +682,9 @@
>  			interrupt-names = "hc_irq", "pwr_irq";
>  
>  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -					<&gcc GCC_SDCC1_AHB_CLK>;
> -			clock-names = "core", "iface";
> +					<&gcc GCC_SDCC1_AHB_CLK>,
> +					<&xo_board>;
> +			clock-names = "core", "iface", "xo";
>  			interconnects = <&aggre1_noc MASTER_EMMC &mc_virt SLAVE_EBI1>,
>  				<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_EMMC_CFG>;
>  			interconnect-names = "sdhc-ddr","cpu-sdhc";
> @@ -2481,8 +2482,9 @@
>  			interrupt-names = "hc_irq", "pwr_irq";
>  
>  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> -					<&gcc GCC_SDCC2_AHB_CLK>;
> -			clock-names = "core", "iface";
> +					<&gcc GCC_SDCC2_AHB_CLK>,
> +					<&xo_board>;
> +			clock-names = "core", "iface", "xo";
>  
>  			interconnects = <&aggre1_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
>  				<&gem_noc MASTER_APPSS_PROC &config_noc	SLAVE_SDCC_2>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
