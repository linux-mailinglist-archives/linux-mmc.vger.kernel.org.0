Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF11241D6
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Dec 2019 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfLRIev (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Dec 2019 03:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRIeu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 03:34:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0264520717;
        Wed, 18 Dec 2019 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576658090;
        bh=dvKP0X1h/lVcq7dknTKY2AhF0POXpCHryalhjGJTFjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QENNtYG4TwkAEyuujnV32atmP/7ZQ7KlsNt6+wtvDfeF1/hL+N5YTNr5fEa2opdTX
         McCu9wbWTXo2mtBHMwsMQA5UEa+PkUvMIywyDaKqbYDZzqn3s1X6Dt1uOyTJd4IBiG
         lzFc3aff7ZlQDCs0SbmSa0Bltn5PtQYbPbjJ7qtQ=
Date:   Wed, 18 Dec 2019 09:34:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sujith Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Xiaonian Wang <xiaonian@codeaurora.org>
Subject: Re: [<PATCH v1> 7/9] mmc: core: Skip frequency retries for SDCC slots
Message-ID: <20191218083448.GE1554871@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
 <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 06:50:40PM -0800, Bao D. Nguyen wrote:
> From: Sujith Reddy Thumma <sthumma@codeaurora.org>
> 
> Qualcomm SDCC controller supports minimum SD clock frequency
> which is required for card initialization. This information is
> exported through platform data for each SDCC controller. There is
> no need of retrying higher frequencies than the minimum supported
> by controller for Qualcomm chipsets which inturn add delay in
> detection process if there is no card during suspend/resume cycles.
> Hence, skip multiple frequency retries.
> 
> Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Xiaonian Wang <xiaonian@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/core/core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1e37f78..38b0cec 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2281,7 +2281,6 @@ void mmc_rescan(struct work_struct *work)
>  {
>  	struct mmc_host *host =
>  		container_of(work, struct mmc_host, detect.work);
> -	int i;
>  
>  	if (host->rescan_disable)
>  		return;
> @@ -2332,13 +2331,7 @@ void mmc_rescan(struct work_struct *work)
>  		mmc_release_host(host);
>  		goto out;
>  	}
> -
> -	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> -		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> -			break;
> -		if (freqs[i] <= host->f_min)
> -			break;
> -	}
> +	mmc_rescan_try_freq(host, host->f_min);

What about for non-qualcomm controllers?  Did this just break their
functionality?

thanks,

greg k-h
