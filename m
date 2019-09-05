Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA733AAB96
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfIES5L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 14:57:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40794 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfIES5L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 14:57:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so2368460pfb.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nCAictNnDUt8UpNPme+HYcx2otpA2Cq+yz30/+CpwQ=;
        b=NkNLDHA1VNhBtMVPNbVO1C5wzS2IJF6G42tikzBj/vtgLee3JtCwOn8nZFRmJd+FV3
         HXshvjVtv4qoUM77bzcr0eGqB7H/v6SyJcDIWBp0yXpWyOy8xIvuvXm087A9M3xanwPO
         2T9Bf9D7eBPH07y05dBCrUV9mAp6Y6XVc7Qrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nCAictNnDUt8UpNPme+HYcx2otpA2Cq+yz30/+CpwQ=;
        b=sqi5mjc0nFxkt/CnooCf//2vF36eWJJJ+8CXLL4+FS+yfZ2fyqF7of6+77MEP3sVSq
         9r7kUVFooBPadQs/9ev2YA35OHkLo/IhNr/hjkbe5PBu2g3Y0i21q4PajdflqCKQIVqQ
         7b9gMS6/5a4hM5swiCmO7ozS6nNPTuoVUqKferxv2g70/3nu8q6Mc+ENCtmhHAF/58iv
         R6Cb/1SwLl25bxTeQE2NzReNQCava4frgpPMP64AoHo/+w3bZfiWjZn8ceQt8Z5VxGzH
         iOAZBLf5XgK/ZwmlQWI0Ocdrn1dYa15267dua85O/tjAAtblbDvnWcg7Dxm/Ki3vFALk
         7bSQ==
X-Gm-Message-State: APjAAAVSaHb4mJx6wVA/A+sr2DV8GK7VAd/duwodZCFEjRZXbyHDBT1x
        52S9nSdseMfbC5N8ZAdKIQsfvg==
X-Google-Smtp-Source: APXvYqxOhQTVz0pPuDWSAX1OvL95Ohbrj2oEDFudGxtOgutg4YfVTwRb168DYmxy9uq3o36uVT0LKw==
X-Received: by 2002:a63:f07:: with SMTP id e7mr4769504pgl.238.1567709831061;
        Thu, 05 Sep 2019 11:57:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y192sm4868626pfg.141.2019.09.05.11.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 11:57:10 -0700 (PDT)
Date:   Thu, 5 Sep 2019 11:57:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] mmc: sdhci: Drop redundant check in
 sdhci_ack_sdio_irq()
Message-ID: <20190905185708.GB133864@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-10-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-10-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:05PM +0200, Ulf Hansson wrote:
> The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
> Therefore, let's drop the redundant check of the internal
> SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c1ebc26846db..2a9be044448a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2161,8 +2161,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&host->lock, flags);
> -	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
> -		sdhci_enable_sdio_irq_nolock(host, true);
> +	sdhci_enable_sdio_irq_nolock(host, true);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }


FWIW:

Reviewed-by:  Matthias Kaehlcke <mka@chromium.org>
