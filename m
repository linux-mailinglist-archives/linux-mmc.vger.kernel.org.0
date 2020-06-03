Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0F1ED358
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Jun 2020 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCPaS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 3 Jun 2020 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCPaR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jun 2020 11:30:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAE6C08C5C1
        for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2020 08:30:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so1809978pfa.12
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2020 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVeUDdt9eIT/ZF5+h1yiYqekEPn8xtcv2SdMrAGMgrM=;
        b=ZfhuzLQZ39itOhbSOkMesC0AXIlQ9xFBQJE8ETjpLJ8vsl0evGW6yJS3uNXaSPcc0H
         eZ7KkUTrz2YyfKYgftyFwJtRscMXz5Z2aTR8Nb2qQZPH9Wp2EGIA29rk9oEZCrkPmz18
         g+POX82Mwz5TuYKpaG2bii3SxkiN5P9qPMjtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jVeUDdt9eIT/ZF5+h1yiYqekEPn8xtcv2SdMrAGMgrM=;
        b=PwiZhlK9YGlozRyuUvTQ/6Fz12wddbg0zJ+ZmXFGQqCj1HmDcHTsT8YGdo7bUeaTXS
         fJlWKoZzqAjmwmCjQypauOXTkKStSH6vkF/Qc1C/KQFZDZNUfXLjveE9b2p1GNyiSwN8
         W3Ns9qwlZgBCEFZQgZOLrlPgBAw4tMA1X9wPKl+y8y2gjwPcIMXSkPcoErzsz/Vs/vN0
         QrvtkaP3NHBgef4FBaTnjyOnsVB8ZK9xOuwwtZFxtGugG43iik+rneAdD9HNpsZbCZAF
         gC4OxGRJNjRGCjXD+wSEJZnMhxymqAIGjUtsdY+u8AQsf33KoOimIMFwshNP/NDTdNUU
         smzQ==
X-Gm-Message-State: AOAM5300kUyD5PYspfhc0Mw228usU6SinFLW9l0zwsqP3SBYbCkAxFh7
        6f0CVaDwCHgA7HdmjAfK4t+02w==
X-Google-Smtp-Source: ABdhPJy3uyFUIfgXfk2WoiTSIJ7bYnel+0P3REYqKw4cbkObOs2pxuVi3H4+zUFWFwhLVq19JiGykw==
X-Received: by 2002:a17:90a:f011:: with SMTP id bt17mr223527pjb.179.1591198216948;
        Wed, 03 Jun 2020 08:30:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o13sm1946836pgs.82.2020.06.03.08.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 08:30:16 -0700 (PDT)
Date:   Wed, 3 Jun 2020 08:30:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc-owner@vger.kernel.org,
        rnayak@codeaurora.org, sibis@codeaurora.org, matthias@chromium.org
Subject: Re: [PATCH V1 1/2] mmc: sdhci-msm: Add interconnect bandwidth
 scaling support
Message-ID: <20200603153013.GO4525@google.com>
References: <1591175376-2374-1-git-send-email-ppvk@codeaurora.org>
 <1591175376-2374-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1591175376-2374-2-git-send-email-ppvk@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pradeep,

On Wed, Jun 03, 2020 at 02:39:35PM +0530, Pradeep P V K wrote:
> Interconnect bandwidth scaling support is now added as a
> part of OPP [1]. So, make sure interconnect driver is ready
> before handling interconnect scaling.
> 
> This change is based on
> [1] [Patch v8] Introduce OPP bandwidth bindings
> (https://lkml.org/lkml/2020/5/12/493)
> 
> [2] [Patch v3] mmc: sdhci-msm: Fix error handling
> for dev_pm_opp_of_add_table()
> (https://lkml.org/lkml/2020/5/5/491)
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b277dd7..bf95484 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -1999,6 +2000,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_msm_host *msm_host;
>  	struct clk *clk;
> +	struct icc_path *sdhc_path;

nit: The 'sdhc_' prefix doesn't provide any useful information, change it
to 'icc_path', which makes evident what it is?

>  	int ret;
>  	u16 host_version, core_minor;
>  	u32 core_version, config;
> @@ -2070,6 +2072,20 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  	msm_host->bulk_clks[0].clk = clk;
>  
> +	/* Make sure that ICC driver is ready for interconnect bandwdith
> +	 * scaling before registering the device for OPP.
> +	 */
> +	sdhc_path = of_icc_get(&pdev->dev, NULL);
> +	ret = PTR_ERR_OR_ZERO(sdhc_path);
> +	if (ret) {

nit: IMO it would be clearer to do this instead of using PTR_ERR_OR_ZERO()
(as for the OPP table below):

	if (IS_ERR(sdhc_path)) {
		ret = PTR_ERR(sdhc_path);

> +		if (ret == -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "defer icc path: %d\n", ret);

This log seems to add little more than noise, or are there particular reasons
why it is useful in this driver? Most drivers just return silently in case of
deferred probing.

> +		else
> +			dev_err(&pdev->dev, "failed to get icc path:%d\n", ret);
> +		goto bus_clk_disable;
> +	}
> +	icc_put(sdhc_path);
> +
>  	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
>  	if (IS_ERR(msm_host->opp_table)) {
>  		ret = PTR_ERR(msm_host->opp_table);
> -- 
> 1.9.1
> 
