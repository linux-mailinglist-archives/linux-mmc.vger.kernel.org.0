Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D263EAABAB
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 21:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbfIETCu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 15:02:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42474 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390303AbfIETCu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 15:02:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so2376808pfi.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhPdMk5kkl4vNeHNFRv6+uGYtSiMWgPfsCU3Jo4srKc=;
        b=nP777WelkoqBWLusAI8NNTc6RCCo83H0DHAW7A4N4d7RCInwVMsCwQsmwMhaFILWxw
         kLlPX35isKrcDbSFmVOL93LVxLEER4uhM3RIoZ8v9s0pwS4NqZdD3+/9Zwcvk/p9Ry/8
         bAdTB//w8Pu5XJNPviOp4gdaA3YK2eIq8lmW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhPdMk5kkl4vNeHNFRv6+uGYtSiMWgPfsCU3Jo4srKc=;
        b=nzHotxkGNZ6m3390vj3K7WgZ4S50mNfGce6iAWIuU/rGdl5pCYye/hgU8ctZlbI/Kj
         XAkIspXRTrA0YowH6QLnW76q/htoJqViJLD9BCnS9Lbi3XLDwWzNg4yo0G2HaG/09e3c
         GEIfotCrDtuo30xZiZ2S0uUF29lhYLNa9cgRrN2yUPfje60KzW10sAx7o23hbCy1DwAc
         H0ztt6WJHXXrdHwHfJb41BHkd44/4iTwLn/iSVE7UEtGXyom+RH81qNm9HF+QTxLkoqv
         V1+1t3+mVP+Fqu33nVa4Dg5A26/PVah58Q8U2CkP3W2H2ERElv/vMQNPxUvJb7/C4J+d
         Zxjw==
X-Gm-Message-State: APjAAAU79uyuVbO2td2x64YTA8x8ygYfg1gbGV2s65ML96h7+fKpXHDe
        sK09mHqGQaRKGiwKScjiS98NDA==
X-Google-Smtp-Source: APXvYqzA4VdWjZM+dp24ITBO4oiitE4WoUSoiaEXBHpKSS25seOWddBWZq1HjdPFW1+gQk2W+9R8vQ==
X-Received: by 2002:a63:784c:: with SMTP id t73mr4728585pgc.268.1567710169579;
        Thu, 05 Sep 2019 12:02:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f74sm7307103pfa.34.2019.09.05.12.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 12:02:48 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:02:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] mmc: sdhci: Convert to use sdio_irq_enabled()
Message-ID: <20190905190246.GC133864@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-12-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:07PM +0200, Ulf Hansson wrote:
> Instead of keeping track of whether SDIO IRQs have been enabled via an
> internal sdhci status flag, avoid the open-coding and convert into using
> sdio_irq_enabled().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 7 +------
>  drivers/mmc/host/sdhci.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7df22ed65aa..4b4db41aec50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2142,11 +2142,6 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  		pm_runtime_get_noresume(host->mmc->parent);
>  
>  	spin_lock_irqsave(&host->lock, flags);
> -	if (enable)
> -		host->flags |= SDHCI_SDIO_IRQ_ENABLED;
> -	else
> -		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
> -
>  	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> @@ -3380,7 +3375,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
>  	host->runtime_suspended = false;
>  
>  	/* Enable SDIO IRQ */
> -	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
> +	if (sdio_irq_enabled(mmc))
>  		sdhci_enable_sdio_irq_nolock(host, true);
>  
>  	/* Enable Card Detection */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 8effaac61c3a..a29c4cd2d92e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -512,7 +512,6 @@ struct sdhci_host {
>  #define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
>  #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
> -#define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
>  #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
>  #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
>  #define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
