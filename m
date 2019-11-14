Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6132FC98E
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKNPKA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 10:10:00 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33089 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfKNPKA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 10:10:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id c25so4090258vsp.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnl8/R+wC38rXwVuF4Uv1hht9TdtUwdSGAq6WJK/Inw=;
        b=Dban84AkznJz4/Lo/AGf01Og1BxBmDR+H65oFtBjz52lqptwVFpC1gWv3V8jYPsBpI
         As6k5VcWLVCOIMCyBkzaCesd6pKtXjMeU6xbf4qcYJE1Qu/4yEHTYA3noX4RsOZSYgzQ
         STXXzW7X7w1gqLjdSnPUTzLpPcD3RkTvrBnCnijnCOcwaH2+t+zC6dkaffiGxkBH4la2
         bHVElB+VRghkDSDaKSct8oDhHUG9KHGEmEU6DPLHRuNhnio0uzkswhzJGchV1rDCZlAn
         J7THWdPWIjq42YLCCN+wFYb8fc/vV6/6nKM6UIBu6E+u8QHgnd4RPJyWyKV4TEYdkOhV
         jIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnl8/R+wC38rXwVuF4Uv1hht9TdtUwdSGAq6WJK/Inw=;
        b=k4KI3yOh3nJL1icnFMR5yeVMdVYsJmzIryvnw8RmqzrANBXszrIBrpZOZu7JCs0ed1
         xmkB04SGTJKS8QFLOZUH7rodalBeNZ5AK3PrDp9fmJR/0iQHMp2VWUxxVcIfDETHmvn0
         gj/8bRIls0Vh//QQ+QkKNNoNz102LzpgkwUBdStehVVVfa3o73z05uI1UFz9dfBDgPnt
         JG5cnU6ahFQ0BMKz4HxkA30lZWxnkcv51R6zigL2w+0/7JsvXwa5gBCwfc+EtbUNKIPt
         zQcVVAvPpl/Lj55ZxC4Nj16xpjM3RGi0LPJKXKSIP275y59J4G0X9RrkEMYKm1gDs0/4
         Pkvw==
X-Gm-Message-State: APjAAAWevuRH1fCiicl+WtSbj4/g0oSFg8PFRc/zCnWNNe8joHamO083
        oIlHiJa+OEhjooCDgYcUhaiTatl9LhCgnVaUSW/UMg==
X-Google-Smtp-Source: APXvYqxtziN/hu01bi+v1OPZ/nveSSQBkA3nNdrugi9zOjFDw+spxc18pADtGTWNLmf/e/FtNr359aBj6yMsZNnsg90=
X-Received: by 2002:a67:2087:: with SMTP id g129mr5900116vsg.191.1573744198308;
 Thu, 14 Nov 2019 07:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113172514.19052-1-ludovic.Barre@st.com>
In-Reply-To: <20191113172514.19052-1-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 16:09:22 +0100
Message-ID: <CAPDyKFooSJUn6UCE6QkFmJOCovm00ehz_nAPbiNQM3AcJT_bJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: mmci: add threaded irq to abort DPSM of
 non-functional state
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

On Wed, 13 Nov 2019 at 18:25, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> If datatimeout occurs on R1B request, the Data Path State Machine stays
> in busy and is non-functional. Only a reset aborts the DPSM.

Please clarify/extend this information to tell that this is for the
variant, that keeps DPSM enabled and uses the data timer while sending
a CMD12. Or something along those lines.

>
> Like a reset must be outside of critical section, this patch adds

/s/critical section/atomic context

> threaded irq function to release state machine. In this case,
> the mmc_request_done is called at the end of threaded irq and
> skipped into irq handler.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  1 +
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 40e72c30ea84..ec6e249c87ca 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       if (host->irq_action == IRQ_WAKE_THREAD)
> +               return;
> +
>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         } else if (host->variant->busy_timeout && busy_resp &&
>                    status & MCI_DATATIMEOUT) {
>                 cmd->error = -ETIMEDOUT;
> +               host->irq_action = IRQ_WAKE_THREAD;
>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
>                 cmd->resp[1] = readl(base + MMCIRESPONSE1);
> @@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>  {
>         struct mmci_host *host = dev_id;
>         u32 status;
> -       int ret = 0;
>
>         spin_lock(&host->lock);
> +       host->irq_action = IRQ_HANDLED;
>
>         do {
>                 status = readl(host->base + MMCISTATUS);
> @@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                 if (host->variant->busy_detect_flag)
>                         status &= ~host->variant->busy_detect_flag;
>
> -               ret = 1;
>         } while (status);
>
>         spin_unlock(&host->lock);
>
> -       return IRQ_RETVAL(ret);
> +       return host->irq_action;
> +}
> +
> +/*
> + * mmci_irq_threaded is call if the mmci host need to release state machines
> + * before to terminate the request.
> + * If datatimeout occurs on R1B request, the Data Path State Machine stays
> + * in busy and is non-functional. Only a reset can to abort the DPSM.
> + */
> +static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
> +{
> +       struct mmci_host *host = dev_id;
> +       unsigned long flags;
> +
> +       if (host->rst) {
> +               reset_control_assert(host->rst);
> +               udelay(2);
> +               reset_control_deassert(host->rst);
> +       }
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       writel(host->clk_reg, host->base + MMCICLOCK);
> +       writel(host->pwr_reg, host->base + MMCIPOWER);
> +       writel(MCI_IRQENABLE | host->variant->start_err,
> +              host->base + MMCIMASK0);
> +
> +       host->irq_action = IRQ_HANDLED;
> +       mmci_request_end(host, host->mrq);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       return host->irq_action;
>  }
>
>  static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> @@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
>                         goto clk_disable;
>         }
>
> -       ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
> -                       DRIVER_NAME " (cmd)", host);
> +       ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], mmci_irq,
> +                                       mmci_irq_threaded, IRQF_SHARED,
> +                                       DRIVER_NAME " (cmd)", host);

In general it's a good idea to move drivers into using a threaded IRQ handler.

However, the reason this hasn't been done for mmci before, is because
there are some legacy variants, that doesn't support HW flow control.

Unless I am mistaken, that means when the fifo gets full during data
transfers - it's too late to act. In other words, running the handler
in hard IRQ context, should increase the probability of not missing
the deadline.

If a threaded IRQ handler also is sufficient for these legacy
variants, only tests can tell.

An option, would be to use a threaded handler for those variants that
supports HW flow control. Not sure how messy the code would be with
this option, perhaps you can give this a try?


>         if (ret)
>                 goto clk_disable;
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 158e1231aa23..5e63c0596364 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -412,6 +412,7 @@ struct mmci_host {
>
>         struct timer_list       timer;
>         unsigned int            oldstat;
> +       u32                     irq_action;
>
>         /* pio stuff */
>         struct sg_mapping_iter  sg_miter;
> --
> 2.17.1
>

Kind regards
Uffe
