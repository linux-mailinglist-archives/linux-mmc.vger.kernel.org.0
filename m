Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78DAAA12
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbfIERd5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 13:33:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45155 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391007AbfIERd5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 13:33:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so1768273pgm.12
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8R3+OmtuDMMstbafhwym94imqZ0Nk5n4dGHFrzndn4=;
        b=YzUa7NKYJ7LuOVtU5RTZpJYn8xXyvlW7tNsK1cAhTCwVpts1tCbVBH+P6E4PDE8RDd
         tT3g+4pO+kc6Y1yHA1IO+YutSQjrI4BYDcoqV+g5xCMpEvgUFs3WNvChFf072tNGCfam
         TROx2NtXkMU1Rmfgh3ZPtHbgXyqle5gX+CMiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8R3+OmtuDMMstbafhwym94imqZ0Nk5n4dGHFrzndn4=;
        b=Lmk/7NsGIAXbckrgMt3MbUYYjLll0WMZp+nuz1/tjO614h3hgGllKVyZ93mdvdy2ZD
         K+2m2SQdRpdgZEn409IhoZGUY3V5tl1zyY3BXiRZYg+QMIXGhQCm9nk2C8qjKWqOixGp
         m0Va1sYDut7y1S9V8YdU1tRj8ZwSyPF+Ip1CrE5sL0K/f+ByATKl0p8Un9zyOitqQ7x1
         iY1L6R3prqcNa63QxQ+2GJMmV5EdhPXJ5xQj/P0ZJM/jhc2pI//RZEMOb+XNWfHL/gFx
         I6/VYPbIh2m+pWKsJCuKyiJLogLR3yX2JtZ4ZKPdksgmxR4XhR1YLyhn+K93ikfI/bQJ
         LTgA==
X-Gm-Message-State: APjAAAXYZD1clqLE/YIU0rNwu6pZ7z2Iz4vvLDY2zmqAytMgDeG14K/p
        Y4OjPHlqvBvgTxBkfVl+Rft5Jg==
X-Google-Smtp-Source: APXvYqys3sPK99TN513v9cRXEKaBZBoB9eVABz2ZryJ2drDMFQ/3biNgtDT4yzNq9fMsqApSP949NQ==
X-Received: by 2002:a17:90a:a407:: with SMTP id y7mr5168384pjp.60.1567704836861;
        Thu, 05 Sep 2019 10:33:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a20sm1602694pfo.33.2019.09.05.10.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:33:56 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:33:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
Message-ID: <20190905173354.GK70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-7-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:02PM +0200, Ulf Hansson wrote:
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
> 
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 0962a4357d54..d7965b53a6d2 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
>  		process_sdio_pending_irqs(host);
> -		if (host->ops->ack_sdio_irq)
> -			host->ops->ack_sdio_irq(host);
> +		host->ops->ack_sdio_irq(host);
>  	}
>  	mmc_release_host(host);
>  }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0c0a565c7ff1..ecdc1b0b1313 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -128,6 +128,7 @@ struct mmc_host_ops {
>  	int	(*get_cd)(struct mmc_host *host);
>  
>  	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
> +	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
>  	void	(*ack_sdio_irq)(struct mmc_host *host);
>  
>  	/* optional callback for HC quirks */

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
