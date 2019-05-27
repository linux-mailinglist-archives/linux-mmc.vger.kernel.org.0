Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446652B9F9
	for <lists+linux-mmc@lfdr.de>; Mon, 27 May 2019 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfE0SRn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 May 2019 14:17:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44083 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0SRn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2019 14:17:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id w124so11086024vsb.11
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2019 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wk2hdUXANFYl1/k0tGnBJuWme842kQgEugYRrAdMJgU=;
        b=dS4IbOdhgZVSQqWE7W9HLkrZGQvhZ5abk5sQyiNlaHVjv85/1nWeAywC/QDyez/NL5
         z5AsU7MavE++ZEHOw8BPtuFl6Sl4UofmOw2JMe8ShMocnqtby87XNUKx/Ynr/IiV5k4S
         orzYRSZzC7PdIRMNlk5aBCIXPnUpTfvSyJn5JPRMiFhwEko33ECMK7cuh70/+y6un1gJ
         rrPyBdC2KSR4FFZ/fXnMog2IOWRqmbwXXzgLgWBhbyphDpZn+xro+tYx+/W4yNXgHXah
         3/mzTz1Ffet/YgR4K1+Noi+2C8Qr5Gf16oP/oHeUde/Cw3BPJYfSTbmqpKYSPiHHrZ9H
         ELeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wk2hdUXANFYl1/k0tGnBJuWme842kQgEugYRrAdMJgU=;
        b=brcDGd/x1bicH2lhB3EgdlQQEZB//gXYPH0m/WfGAM21QaoUYeavP6y8HqVR46YNoS
         yFE75sLL8J0783WoGsnBXI1jXVqXiCb1DKXbygSQO97UPjXCCDVpweYCpVTZS2SMbT2h
         VBVbk3k8/qf2sL6WU8J7lIF2ew5uc8c4WIj2xq6eH7HKY0uK8ybcKaFqino/GElgyWEr
         hkcDHYXibaX00bkYCHxvB1q1HG6HYDZBADafNAIX+7xw6QCOvZE40WkU6Lk4z8PdmIl7
         2zFTCZDRP/CgHSsJQgc0PrjXsUOH++bli8UuPVwmoZDbqNVnRZFFe/9iH2lXBPwGkTBt
         Lg9g==
X-Gm-Message-State: APjAAAVHXrrFkxYdixPzQGE5zfVmrGdJLgpvNsmUxwrCqohyJSKnYZ1x
        O2WpOXlLFXRVDXbuApRD0LGQ0c3KQcFthdRy5QyD7A==
X-Google-Smtp-Source: APXvYqzuKcW/79QkdRTF5rt129CfhCTBkDjwdQNIeah8lsnBs26cDYoRW6a2C+MEJfPi6wzVzRHznUMCZcNZHRlI5d8=
X-Received: by 2002:a67:3046:: with SMTP id w67mr51182171vsw.165.1558981062356;
 Mon, 27 May 2019 11:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com> <1556264798-18540-4-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1556264798-18540-4-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 May 2019 20:17:05 +0200
Message-ID: <CAPDyKFrxp3Y3AudNvkkSRaph2Fe-A-F6Cs0jfy9RUja76GYeiA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] mmc: mmci: fix clear of busy detect status
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The "busy_detect_flag" is used to read/clear busy value of
> mmci status. The "busy_detect_mask" is used to manage busy irq of
> mmci mask.
> For sdmmc variant, the 2 properties have not the same offset.
> To clear the busyd0 status bit, we must add busy detect flag,
> the mmci mask is not enough.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Ludovic, again, apologies for the delay.

> ---
>  drivers/mmc/host/mmci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index a040f54..3cd52e8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                  * to make sure that both start and end interrupts are always
>                  * cleared one after the other.
>                  */
> -               status &= readl(host->base + MMCIMASK0);
> +               status &= readl(host->base + MMCIMASK0) |
> +                       host->variant->busy_detect_flag;

I think this is not entirely correct, because it would mean we check
for busy even if we haven't unmasked the busy IRQ via the
variant->busy_detect_mask.

I suggest to store a new bool in the host (call it
"busy_detect_unmasked" or whatever makes sense to you), to track
whether we have unmasked the busy IRQ or not. Then take this flag into
account, before ORing the value of host->variant->busy_detect_flag,
according to above.

>                 if (host->variant->busy_detect)
>                         writel(status & ~host->variant->busy_detect_mask,
>                                host->base + MMCICLEAR);
> --
> 2.7.4
>

Kind regards
Uffe
