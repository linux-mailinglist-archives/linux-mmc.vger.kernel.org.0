Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5001CAAA1B
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfIERiQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 13:38:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35264 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfIERiQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 13:38:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so1632150plb.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZtEeWQvjAbW4RpXx5Rs391kaT1lN+fLEO9kJk7Fxys=;
        b=Tpv2lsp4ZSX1/DDksSNxod7O8sssf87giKmImdkfKrYTvSGHFs3sT35VSHoMs3cYRi
         7gHbtoMEE6KbCyDUhhPDkXYnu2oW1AUfIu8fqBgIUNKb/jiqlkHPsP0Gi8PGXejv+8Uh
         VdQgYO0NEyVCFXYB4Vkk7vVo+rEOI9+mk0ztU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZtEeWQvjAbW4RpXx5Rs391kaT1lN+fLEO9kJk7Fxys=;
        b=FMaek8VvEaoYEkiHt40NH9XVYapTgACzScfRKndnp/09P2s3G28TnLTOCAoAUVUZbl
         dAAF8hhJr63eIt94GVqLb9+4qXOBjKUU+mHNm+UgOrM5igNBFHpY00uh0Fo/WT9CGN8K
         c9Nn1F1beXGbhXoPAQPGvqDGkpFpGFpFV4bxVsdSpu4fR2TTePnyuk7RqR4v0++HIFe7
         K3dSp2GombJHX1XWjx1AW5qviLQoI85mlNDl8HvRJVgfrrHUOYdNlONC2EQg6uQA+Q74
         l/piipd8CcJHaMDad/x8zFjg6bzBmtKJa4xAfFzaglEbHQeOkPB48D2O/xSdmgnLZS3t
         fVAA==
X-Gm-Message-State: APjAAAW4+kJUyR9OMdoKEAuXk1JMS9/N5WH6PukLruMU6NvBkkSqPBcD
        2Xq+gzrbqcsM9n1WfjS9o/WRMStr5W4=
X-Google-Smtp-Source: APXvYqzppQYLVqSQxNu0WP8Ij9s84K1CSFUQ+cCcQwDX8geaiRWH3nZwKL16gKlY7J3Px/24N6L3Aw==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr1652431plb.120.1567705095379;
        Thu, 05 Sep 2019 10:38:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n185sm2632568pga.16.2019.09.05.10.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 10:38:14 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:38:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mmc: core: WARN if SDIO IRQs are enabled for
 non-powered card in suspend
Message-ID: <20190905173813.GL70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-8-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 03, 2019 at 04:22:03PM +0200, Ulf Hansson wrote:
> To make sure SDIO func drivers behaves correctly during system
> suspend/resume, let add a WARN_ON in case the condition is a non-powered
> SDIO card and there are some SDIO IRQs still being claimed.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8dd8fc32ecca..c557f1519b77 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
>   */
>  static int mmc_sdio_suspend(struct mmc_host *host)
>  {
> +	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
> +
>  	/* Prevent processing of SDIO IRQs in suspended state. */
>  	mmc_card_set_suspended(host->card);
>  	cancel_delayed_work_sync(&host->sdio_irq_work);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
