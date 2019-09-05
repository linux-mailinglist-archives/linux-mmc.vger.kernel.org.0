Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B92A9BF2
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfIEHev (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 03:34:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45162 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfIEHeu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 03:34:50 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so2473704iog.12
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LhtZNoNzRvZSAH108XwpLGps2Yh2JazOU/N47b9DrY=;
        b=wGBJ24FSeI0ftQz8FoR/io+cmoZSq4R9WzfX1YRTQqq4bDgjuQOkMUAc14czc8A7fE
         RTrc4/G6LeaIqGNA3081SM+a34BEuP4u/UCEBaarcn5N0AtDBWgMtm37BzK5eP1a3aF/
         5avzku2ru/lbbGW2fQQX03vBNtZuEMABjof0IGjaj585cv49PXFRxy/vdW18T0On14d9
         +T6f4drlFCbaT1yKDNV2UunHvRAkbbnfoMQG6sxiILp2U6WlYLjrK4shCrzb2+uUDRiC
         RGJFVMinNMBmSvVlQKNuR+u53wJP06152MYY+LT7Xxy+BlEw9EzgU6ug0hvkVG7WL+HU
         yGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LhtZNoNzRvZSAH108XwpLGps2Yh2JazOU/N47b9DrY=;
        b=EsaB9l8bE39tBMuTFxgQN+B3d62/8yZIDYME6ZO0zxfMP9cTU3AYk5Rkehf7T4OaCe
         OcrKlgio16LF59sEU8L0DCJZejqk1wLUaQiTGPp1+FAwBSrGyq6CekfkObNcufnHbLsb
         ENaSAIfIThnaTmWYQ7PObAEZMsrJkvIVH5zUgdrbIBT3VaHPjqBZxouE1FFNAzrNzzZ0
         kWCBAqkxQEyn4DPDPTk9ZmoKWAsoxG5svw4s3UvArmB9wkPeIdRM4pAjBKxnwYQaaftu
         veBq6gad8uzOBqgTXnZOuzvzOjlq9gVFNeIUm68uTlkv1BfsnW7Z8zRnQDivMvTb8XCT
         XSZQ==
X-Gm-Message-State: APjAAAUF+N8t+TpIK3Gc7+gpNTy+MTkOKBjRqv2vOnhndbkBSM3QllQL
        VM52BD+V2UCnqVZwD8EpnGF4QPKfuTknbhXigqaWyew7
X-Google-Smtp-Source: APXvYqwU8zzHowwK8eJgPAFUKUJwghzX5S69y3kO09icT4sMBL7iKeXUnrBl56ZIApRGLl790kJN3KLeXRuu6kqsKDY=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr669621uae.15.1567668574370;
 Thu, 05 Sep 2019 00:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-2-ulf.hansson@linaro.org>
 <20190904235836.GG70797@google.com>
In-Reply-To: <20190904235836.GG70797@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:28:58 +0200
Message-ID: <CAPDyKFqAiBHb3Tta3VXWbhxJkRP_KyokgkXAr+CmJxAXqE7Cvg@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO
 IRQs is enabled
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 01:58, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Ulf,
>
> On Tue, Sep 03, 2019 at 04:21:57PM +0200, Ulf Hansson wrote:
> > To avoid each host driver supporting SDIO IRQs, from keeping track
> > internally about if SDIO IRQs has been enabled, let's introduce a common
> > helper function, sdio_irq_enabled().
> >
> > The function returns true if SDIO IRQs are enabled, via using the
> > information about the number of claimed irqs. This is safe, even without
> > any locks, as long as the helper function is called only from
> > runtime/system suspend callbacks of the host driver.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  include/linux/mmc/host.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 4a351cb7f20f..0c0a565c7ff1 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> >  void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> > +/*
> > + * May be called from host driver's system/runtime suspend/resume callbacks,
> > + * to know if SDIO IRQs has been enabled.
> > +*/
> > +static inline bool sdio_irq_enabled(struct mmc_host *host)
> > +{
> > +     return host->sdio_irqs > 0;
> > +}
> > +
>
> The name of the function is a bit misleadling, since it indicates
> if SDIO IRQs should be enabled, not whether they are actually enabled
> by the host. The resulting code can look a bit confusing to the
> uninstructed reader:
>
>   if (sdio_irq_enabled(host->slot->mmc))
>     __dw_mci_enable_sdio_irq(host->slot, 1);
>
> aka 'if SDIO IRQ is enabled, enable SDIO IRQ'.
>
> sdio_irqs_claimed() could be a possible alternative.
>
> No biggie though, just something I noticed.

Thanks for the suggestions. It makes perfect sense to me, let me rename it.

Kind regards
Uffe
