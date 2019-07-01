Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC65BEA7
	for <lists+linux-mmc@lfdr.de>; Mon,  1 Jul 2019 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfGAOuU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 1 Jul 2019 10:50:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbfGAOuU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2019 10:50:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so7489194plt.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jul 2019 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DhsHhHpoG4ayeBdiyvK+pQwK61SKZGiv/7oJsmdxfQ=;
        b=L5VhDhOasgqtS3rmT4OyVLkqJ1TYyfKg2P8XQbp5QQO7hjCxtOcaKKIAKddBHecQV0
         cFWTLzZobWI7tQV6sV3j+osS2+QI33oWJadpmazRGkTUUNDbmlIy6iDXDPnpDh+tMB+C
         fdRGo3qyXR9gZEFEVq0dcTQDqYfvjWOjOv9YvvzHO63DFjCTONk8jLCNpdvTt5p+Q+c8
         oDGdpOCBUxWcNvKFUJ4LgOMFk8avMky1Ld0uZ8wl6tiDWp0OUewoixMdmlw1OEnaNirl
         0p3mliGk86rDGiTzJhq4IrBQEkc7nHEZfjzmmEGt0cMdFipbsMbfj+AB4OXTeXyiwPy8
         MYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DhsHhHpoG4ayeBdiyvK+pQwK61SKZGiv/7oJsmdxfQ=;
        b=ugup7qUulkrxHaI+GuEegsxUZx2l3gx9TCLgvHP+aJLwR8Hslzx8FREIzNkj3TajT8
         3AHspFetEBQn0cMC196ums+9LEPzE1WSX0XEcEfytbSvnD+CJH8zgjZsxu9w5Rb1N/bH
         tGKgqchzmtlo2SR3C5f44HE1V8E6kCXkPoUYiw7xRzdyiRxzqr6N/SaaRFir9ICysS/f
         oH1rqn8T45Lh+kK9nyLUGiFzYmoYPMvwBw8MYXZh4Tvd/69YZrNd/A/GjitFXqRL5JLC
         3tbUWfzEaHwz0dytw2ZWjwgBtimWJfzeYfDyFyd8Z4Qp54AjOWez8ilJ/wMupLKOo5C0
         xwDg==
X-Gm-Message-State: APjAAAVSUPNhB0tHfczjRVpSQqujMlBZr0hVjXB1lALVtX6PZtapzLJT
        W6F9sJTr9jcmy3KkA+W/P8Cb6A==
X-Google-Smtp-Source: APXvYqwrleYyr6IvOOFIQ4S8xa7usHyTCZaoYl3JWrGqM5qod9TTX390XudbbJ+PaKE4W4aZmlckxw==
X-Received: by 2002:a17:902:1102:: with SMTP id d2mr29415786pla.149.1561992619449;
        Mon, 01 Jul 2019 07:50:19 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i6sm814419pgi.40.2019.07.01.07.50.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:50:18 -0700 (PDT)
Date:   Mon, 1 Jul 2019 07:51:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     adrian.hunter@intel.com, agross@kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org,
        vinod.koul@linaro.org
Subject: Re: [PATCH] mmc: sdhci-msm: fix mutex while in spinlock
Message-ID: <20190701145106.GE12249@tuxbook-pro>
References: <20190701105316.19419-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701105316.19419-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon 01 Jul 03:53 PDT 2019, Jorge Ramirez-Ortiz wrote:

> mutexes can sleep and therefore should not be taken while holding a
> spinlock. move clk_get_rate (can sleep) outside the spinlock protected
> region.
> 
> This regression was introduced with commit
>      Date:   Mon Nov 21 12:07:16 2016 +0530
>      mmc: sdhci-msm: Update DLL reset sequence
> 
>      SDCC core with minor version >= 0x42 introduced new 14lpp
>      DLL. This has additional requirements in the reset sequence
>      for DLL tuning. Make necessary changes as needed.

Your Fixes: below already states this.

> 
> Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Apart from that, your patch is good

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/mmc/host/sdhci-msm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5fc76a1993d0..9cf14b359c14 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	int wait_cnt = 50;
> -	unsigned long flags;
> +	unsigned long flags, xo_clk = 0;
>  	u32 config;
>  	const struct sdhci_msm_offset *msm_offset =
>  					msm_host->offset;
>  
> +	if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
> +		xo_clk = clk_get_rate(msm_host->xo_clk);
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	/*
> @@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  		config &= CORE_FLL_CYCLE_CNT;
>  		if (config)
>  			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
> -					clk_get_rate(msm_host->xo_clk));
> +					xo_clk);
>  		else
>  			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
> -					clk_get_rate(msm_host->xo_clk));
> +					xo_clk);
>  
>  		config = readl_relaxed(host->ioaddr +
>  				msm_offset->core_dll_config_2);
> -- 
> 2.21.0
> 
