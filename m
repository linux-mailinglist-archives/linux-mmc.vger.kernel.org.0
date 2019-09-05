Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93C0AAF40
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbfIEXs1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 19:48:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41604 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbfIEXsZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 19:48:25 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so8695698ioh.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdzexQoF5loWHf9nViLs5mZFtTWqWxiWfQRVaa/SkTs=;
        b=FQzdq6xIL+HmAfj2br7r/ZOsXYSloAcTvunrlUf6FJad5RQuzxCSMWyFVafIquJ8gv
         6lLJBiUTqULtMKz6FKxd3et93cCUEmWMl7fcqs5xWEtIO7VvJPKPpSLUX1kaxBYxTMS+
         njEhmfEGVTqf5lODOvif/c5JJ5w/kbOmVd8g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdzexQoF5loWHf9nViLs5mZFtTWqWxiWfQRVaa/SkTs=;
        b=BpQBHlsmCepPKwUydPyA7ZvY3jmTVRG0ZVjUwYmk4fSIo5a1iBXUkU+uTf77J4TnpQ
         p6StbFJ8ANGz/Sbpi2Km9NtjJMant+c76qJTwd9eASAeeSa0KXo5ePGSJs7y91PuerZ8
         3b/wgR2/3uoxxaCE4+brwW9REfVaC9IC4tuoqSGXo29Qw6+KP4fsxWzo7UgRlCYJ4cks
         WluAP0Fj6CojrrQAgeMETTKjsG6QmsuiefQ0D9TupimuOo4PwfjxDZDP+44sAKHE3UPN
         n1vuk9Cmw4FogBlFa1p5VjHPbkk1vi+1xGh16my7olr7t6S/9SmljogwtrTyNvBs5EGi
         WWEA==
X-Gm-Message-State: APjAAAUvaY554w5+RFv+CDdMphItsYjxuTWSUPfih5AwYYfDpDHUALO7
        GiED6dGpMHaj+F9I6aMyH+Bm8JP18Mg=
X-Google-Smtp-Source: APXvYqwWc8m8+504beoe6ro2x5w5dmoT4ysopP5d6omKUQph0jhdfR8CTMYkdt0T6VkPD5LHc2kJ6g==
X-Received: by 2002:a02:cad1:: with SMTP id f17mr4177440jap.18.1567727304263;
        Thu, 05 Sep 2019 16:48:24 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id u3sm3244122iog.36.2019.09.05.16.48.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:48:23 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id j4so8678639iog.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:48:23 -0700 (PDT)
X-Received: by 2002:a5e:8d14:: with SMTP id m20mr7461431ioj.52.1567727302507;
 Thu, 05 Sep 2019 16:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-9-ulf.hansson@linaro.org>
In-Reply-To: <20190903142207.5825-9-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Sep 2019 16:48:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
Message-ID: <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
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
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
>                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> -                       host->ops->enable_sdio_irq(host, 1);
> +                       sdio_signal_irq(host);

Is this always safe?  On 1-function cards you won't poll CCCR_INTx so
you'll always signal an interrupt at resume time, won't you?

-Doug
