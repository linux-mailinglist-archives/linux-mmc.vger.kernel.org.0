Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF29A9768
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 01:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfIDX6m (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 19:58:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDX6m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 19:58:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so328669pgm.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzCBcaJ5OXHeTAD9ReyC4ft6yTqJSMLEq74ZF5Dx+sE=;
        b=iC/g4yXM5OocLK4SajwTUkJeyEO8+T4E3re+X57It084S75WZuMT1xW/XtDBxbV3e1
         rCwI6Cu8qUa6oMG/pTQ0f0F1LnsX/2SSFRLJ+IJXdxI55ZaWStRd9opIk8cUoqqwNrIP
         H7tpNxuUkgkrFUP3vXeObEMl8Nso1hqkDA488=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzCBcaJ5OXHeTAD9ReyC4ft6yTqJSMLEq74ZF5Dx+sE=;
        b=qMHhwsAAr4MQNrDMZXNkiJdjpQRIKB4JiejVw6CplZviBez6PuqSJGPY1VfSC84/KA
         cfaDw44ZYIiftFaMHZedeCeiSecc2rmG+V7iVJtCZE8z1UeihiRXJvgYp55vxec0DfXN
         yKUmbuwOVEHALvgDt1IIut/19yeuXQKhGSiWoQNK4WOy+wdPn5PBN4dyvS0iDe29bN4t
         QiRiTF5JHKJNfQ6/UWBlTlucYwHCHPiaBnngIVdnN69xuGZ502dlibi5nIEtDtR4kx2U
         p2okGDDJlUDjgHFgpkCoENwifzABr7gTqNc4TPTjHadAfDR72wMu0X5X51hV++n0p9Ql
         d/qQ==
X-Gm-Message-State: APjAAAXrL97KwNDWw9CFW+hssFGHphbx8Je/ra3L4gv66xX9RQm3Xpll
        ZqX90Dj6BNsPhbMwGDouokGv+A==
X-Google-Smtp-Source: APXvYqzrzu0vmwj7KrAElXE3dLnEORa8R7ryqq/uOGycM4Twl5etL9SOdCv1415tg9jmkA1mu+6Rng==
X-Received: by 2002:aa7:8f08:: with SMTP id x8mr423535pfr.48.1567641521708;
        Wed, 04 Sep 2019 16:58:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d69sm187118pfd.175.2019.09.04.16.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 16:58:41 -0700 (PDT)
Date:   Wed, 4 Sep 2019 16:58:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO
 IRQs is enabled
Message-ID: <20190904235836.GG70797@google.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
 <20190903142207.5825-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903142207.5825-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, Sep 03, 2019 at 04:21:57PM +0200, Ulf Hansson wrote:
> To avoid each host driver supporting SDIO IRQs, from keeping track
> internally about if SDIO IRQs has been enabled, let's introduce a common
> helper function, sdio_irq_enabled().
> 
> The function returns true if SDIO IRQs are enabled, via using the
> information about the number of claimed irqs. This is safe, even without
> any locks, as long as the helper function is called only from
> runtime/system suspend callbacks of the host driver.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/mmc/host.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4a351cb7f20f..0c0a565c7ff1 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
>  
>  void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
>  
> +/*
> + * May be called from host driver's system/runtime suspend/resume callbacks,
> + * to know if SDIO IRQs has been enabled.
> +*/
> +static inline bool sdio_irq_enabled(struct mmc_host *host)
> +{
> +	return host->sdio_irqs > 0;
> +}
> +

The name of the function is a bit misleadling, since it indicates
if SDIO IRQs should be enabled, not whether they are actually enabled
by the host. The resulting code can look a bit confusing to the
uninstructed reader:

  if (sdio_irq_enabled(host->slot->mmc))
    __dw_mci_enable_sdio_irq(host->slot, 1);

aka 'if SDIO IRQ is enabled, enable SDIO IRQ'.

sdio_irqs_claimed() could be a possible alternative.

No biggie though, just something I noticed.
