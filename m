Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80AAAB57
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfIESnk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 14:43:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIESnk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 14:43:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so1900355pgj.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fn8SAMa0kHIf62H+0ZvQwfwKj3AOqtxXz/Ns6Tf+0hg=;
        b=m5TQ/l8/gpBIBBYyzHTkSLKUh00lD/2kUVoHlrS31oAm2wuKupko2sk49zGnZeRC5w
         XETHnJsuQSxmL+X2PatVMr3RHntKClFgnxL2YuqJhMGVKTpYzE3xq0hvhXy0+BS5n3tN
         AvUD4Lcosyd8BO3ed/74ILca3jY3et4g3zES0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fn8SAMa0kHIf62H+0ZvQwfwKj3AOqtxXz/Ns6Tf+0hg=;
        b=JK+cL2Wwp3Tuaj/i9uKETXT4RNiGrdhOf4zFkeLnDXPpRszSOp1imawaCRRaCUduwk
         yNn4E0H2A078tRKyUKXV3Qg0eltToSlE81jK4PxuhRbXcpHUMU6XfzZApqbUTffUuSlo
         +Cnd6onmhU6kfdwxQs+HjDdjryLkgIh6Km7/pKCnqveVD1lowIis3J5Mt2xmNKi+g6Bn
         El/pSIck+O2qpFaM5a3smTIR4xYyCJkxuRwciOVZUlIF9nbDFQTo8f+60nuBq/X0/LpA
         YBfTCXDqP0iHZCAvzKhgoiDB9lm5W5Vn9k4xLe083QTB3wVHuEzc+PKP678X7rt9OYcu
         ggeg==
X-Gm-Message-State: APjAAAVYdHL3z2PfH7Cq1nI7eTm7UmCJZnK3NaNZm/JBX5ABPWaYyxdO
        fVvgdNiP01u54SegfdjqnRzTnQ==
X-Google-Smtp-Source: APXvYqxsoC2iAUPy8yQ6zCuWue0mOAZvhGJlSFrzwhw4M7Z/y03wd0Fknx/UhdR/a62nnuLNXPy0rA==
X-Received: by 2002:aa7:8592:: with SMTP id w18mr5708116pfn.237.1567709019909;
        Thu, 05 Sep 2019 11:43:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d14sm6312439pfh.36.2019.09.05.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 11:43:39 -0700 (PDT)
Date:   Thu, 5 Sep 2019 11:43:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
Message-ID: <20190905184337.GA133864@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:04PM +0200, Ulf Hansson wrote:
> System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> behaviour. Some problems have been taken care of so far, but more issues
> remains.
> 
> For example, calling the ->ack_sdio_irq() callback to let host drivers
> re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> which may not be the case during system suspend/resume. This may lead to
> that a host driver re-signals the same SDIO IRQ over and over again,
> causing a storm of IRQs and gives a ping-pong effect towards the
> sdio_irq_work().
> 
> Moreover, calling the ->enable_sdio_irq() callback at system resume to
> re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> count for some host drivers to become in-balanced. This then leads to the
> host to remain runtime resumed, no matter if it's needed or not.
> 
> To fix these problems, let's check if process_sdio_pending_irqs() actually
> consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> ->ack_sdio_irq() callback.
> 
> Additionally, there should be no need to re-enable SDIO IRQs as the host
> driver already knows if they were enabled at system suspend, thus also
> whether it needs to re-enable them at system resume. For this reason, drop
> the call to ->enable_sdio_irq() during system resume.
> 
> In regards to these changes there is yet another issue, which is when there
> is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> has been system suspended. Currently these IRQs are just thrown away, while
> we should at least make sure to try to consume them when the SDIO card has
> been system resumed. Fix this by calling sdio_signal_irq() after system
> resumed the SDIO card.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index c557f1519b77..3114d496495a 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>  			wake_up_process(host->sdio_irq_thread);
>  		else if (host->caps & MMC_CAP_SDIO_IRQ)
> -			host->ops->enable_sdio_irq(host, 1);
> +			sdio_signal_irq(host);

You could possibly limit this to cards that remain powered during
suspend, but doing it always should do no harm.

>  	}
>  
>  out:
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index d7965b53a6d2..900871073bd7 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -115,7 +115,8 @@ static void sdio_run_irqs(struct mmc_host *host)
>  	mmc_claim_host(host);
>  	if (host->sdio_irqs) {
>  		process_sdio_pending_irqs(host);
> -		host->ops->ack_sdio_irq(host);
> +		if (!host->sdio_irq_pending)
> +			host->ops->ack_sdio_irq(host);
>  	}
>  	mmc_release_host(host);
>  }

I'm by no means a SDIO expert, but as far as I can tell this looks
good. I verified that this patch fixes a problem with SDIO interrupts
that are ignored while suspending.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
