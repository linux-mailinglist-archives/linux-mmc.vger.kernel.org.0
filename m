Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A1AAF3B
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 01:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfIEXrU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 19:47:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37066 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbfIEXrU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 19:47:20 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so8752046iop.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siNwSdIYFNtVZ3AHic9j9ZXRlU43cbV/eECxgsuYWQ0=;
        b=gicLTwd9Yg/AWWDtsWsMOScBKzSbHe6y74CyVJLLUU+pK0fluT99gtJrzBRk3xEMr1
         RXVe+9H9EosBTGKbhvtnZbGwpqQph+kg3r/esw7b+DnXQgWFMwqNrhftMkXkPvjPDQU4
         AJQ7C1xsKnUa+qe7oAzgOdZkRhzz/18iO7PCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siNwSdIYFNtVZ3AHic9j9ZXRlU43cbV/eECxgsuYWQ0=;
        b=KeeLnr3+7gCblvCiD5Oj3S9jBMxpGIPPef9tCCCBT8dk9HOt3nW8fIovM8NWJnKY5Z
         cCd2JFflACsoym0uH+Vl0K1wy+/Mvd5VKZcp4tdYG8fWaSRfMzrCyuF3RjfG4xHKKlGa
         Y9GZNAZvu/aH6E6I8sGQtrdxVkhYkW2vPmCa27eZDXfR+YwfahCROM7oE0/kK3lu0zIm
         Hi1TTtcHkRMj0LiG1C7IS0pQzYGOGDaMsBvMUophTJsRLtYpnZCbkhftqHKt1Cbh/9qn
         vhaw7yhHBuijDJM8FPSaT1xjbKLS91TztQQ5gKdjLZEUSngSUn4mLpJSdFHikSbGrlaM
         vBRw==
X-Gm-Message-State: APjAAAVLFOEmUWOoAZ217Td5tds117lTBojsyiw5fft7a4882ewDyuoV
        GGHsFN9WvKHp9q2TV4CvcJTbiuhLynU=
X-Google-Smtp-Source: APXvYqxx5yDSLMVyyyqpMyti7JwmDP2WaK+Z73RtYV4tlXnz8XEBoHrWGgMBsWKfSkOp65tm2KJv+g==
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr3932221iob.113.1567727238786;
        Thu, 05 Sep 2019 16:47:18 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id 80sm6555663iou.13.2019.09.05.16.47.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:47:17 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id j4so8674561iog.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 16:47:17 -0700 (PDT)
X-Received: by 2002:a6b:ee17:: with SMTP id i23mr6820804ioh.168.1567727237453;
 Thu, 05 Sep 2019 16:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
In-Reply-To: <20190903142207.5825-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Sep 2019 16:47:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
Message-ID: <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
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
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.

Even if they weren't lost the resume code currently has this statement:

mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
   DW_MCI_ERROR_FLAGS);

...so that would have clobbered any existing state even if register
state wasn't lost.  ;-)

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
>         /* Force setup bus to guarantee available clock output */
>         dw_mci_setup_bus(host->slot, true);
>
> +       /* Re-enable SDIO interrupts. */
> +       if (sdio_irq_enabled(host->slot->mmc))
> +               __dw_mci_enable_sdio_irq(host->slot, 1);
> +

There's a slight bit of subtleness here and I guess we need to figure
out if it matters.  From testing things seem to work OK so maybe we're
fine, but just to explain what's bugging me:

If we got an SDIO interrupt that was never ACKed then this is going to
act like an implicit ACK.  Notice that dw_mci_ack_sdio_irq() is
exactly this call because when the SDIO IRQ fires we mask it out.
...then unmask when Acked.

Specifically after your series is applied, I think this is what
happens if an interrupt fires while the SDIO bus is officially
suspended:

1. dw_mci_interrupt() will get called which will mask the SDIO IRQ and
then call sdio_signal_irq()

2. sdio_signal_irq() will queue some delayed work.

3. The work will call sdio_run_irqs()

4. sdio_run_irqs() _won't_ ack the IRQ, so it will stay disabled.

5. When we get to the resume we'll re-enable the interrupt.

I guess that's fine, but it is a little weird that we might not really
be restoring it simply because it got disabled due to the clobbering
of INTMASK but also because we implicitly skipped Acking an interrupt
that fired.


I wonder if the correct fix is to just add an explit zeroing of the
INTMASK (so mask all interrupts) in dw_mmc's suspend callback.  Then
there's no possible way we could get an interrupt during suspend...



-Doug
