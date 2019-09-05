Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46857A9786
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfIEAO0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 20:14:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38181 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEAO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 20:14:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so492319pfe.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diieQ8EBqgcQJUrsXwTks6b1z96zAex0NF2Hmz0b35Y=;
        b=WIVl99L8/3T6fM8Qgw/RlwMDG4yQ4lvjWot/XZl5PBbk/kD0JKwwUm56I1dtDYyLwW
         EbNogigWPITfoCAGHHoo2CyZjLbCZ0LZMo79QjpWLEt+kwDH/dFAts4deR8hBKFvIZAH
         7bOOI7qM9Q5BcfwHOaFOkHv5yGdO7+smZzn14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diieQ8EBqgcQJUrsXwTks6b1z96zAex0NF2Hmz0b35Y=;
        b=pmfhh3CnGZAh+AUs7JiBZFStJybl4A9O1pu9MZHR7DDQKJdhTViRHQc/S9NrAtQ9k3
         uH5TuGcsQLtZDOkVE+8IW8hForyvuy2+94kNGk5m56yO2h9u7pGoZX56tfGQM6pE/KKV
         ctjBOF0a+LXOWUDBrBw7MqXtIgwz+B/vM0BjmE1uwkn5TS1+ciVQpQrH9CnoCqA5ecuk
         YM8iICTGyPerygTBaTpxJQqOPCa6p831VOBjiODQcB4Il8bHlEfdeHyvitUOU+q/v1E+
         ME4LePoieJd3CAy+VQ3RtUqh8MEvrcw87NLSZ88v2pvEV1PgMDJf4aKgW/VtlLTU/yti
         W15w==
X-Gm-Message-State: APjAAAWAThFruetpl9dvhsQppEjrERyHukqZFVv6WIu3qtGWwGJZbg7e
        Oot3t/IijBIp96/y98x8hASwng==
X-Google-Smtp-Source: APXvYqx644/2GrLekucQUWiowFO+GAususlTMvtOyZ2eD2nVHynyZdKXd6+std7V+dgBr1PQJyrzjw==
X-Received: by 2002:a65:6256:: with SMTP id q22mr668090pgv.408.1567642464887;
        Wed, 04 Sep 2019 17:14:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q71sm163292pjb.26.2019.09.04.17.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 17:14:24 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:14:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system
 resume
Message-ID: <20190905001422.GH70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
> 
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index eea52e2c5a0c..f114710e82b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
>  	/* Force setup bus to guarantee available clock output */
>  	dw_mci_setup_bus(host->slot, true);
>  
> +	/* Re-enable SDIO interrupts. */
> +	if (sdio_irq_enabled(host->slot->mmc))
> +		__dw_mci_enable_sdio_irq(host->slot, 1);
> +
>  	/* Now that slots are all setup, we can enable card detect */
>  	dw_mci_enable_cd(host);

Looks reasonable to me, besides the bikeshedding over
'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
if SDIO IRQs is enabled").

One thing I wonder is why this change is only needed for dw_mmc and
mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
newb?
