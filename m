Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3BCDEDB3
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfJUNgX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 09:36:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43759 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfJUNgW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 09:36:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id b1so8831585vsr.10
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXjl3Qdj6k4PSsOEssi1NBEDlEeNdvwTH033BcyI0qQ=;
        b=Hso+9CrinK4xZlbaApuYrGSZonV4azH0FJB494beKtvJpcRl8Veanvo9tKNRl7Hd1x
         4tmspmnmA0Cr3+PVnZpVJ/kh//Qy8fgmmXudTnPcLaULLV/AVkzp926bTQRYB+2cdjZ7
         D2Gr10VIaRo6QwVbtfNc1HqK26D8ym5oe82dJZdBpwN3+AQ/64P8TQrSoBI326eblL6S
         Le+iuwOkJkXR+ECvd9X6PwZUqbCReqmk68QHVjx9BJUJ3cnEgYloCebC3Csv1czA2QIe
         Pop03LroOrf/V2y7qf2Nv1poWAHPtBnNJ071pfZtADDmz3RnX0XW8p/bICpvIBU6NQ0O
         4uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXjl3Qdj6k4PSsOEssi1NBEDlEeNdvwTH033BcyI0qQ=;
        b=Osey/dMKnGplX0MXxn0rU5r2INXLI492SYXkkt/CDZV21m9aP245UQioWKGLjzKP1v
         zx82EkgE8lbpUP2U+f4zAs4bV4+dlJWYMaruvnyAlvW495t55cBTVySH46QVkAqd0qqh
         L9kFlb47C5y7FuBcLp2JUo28Le1gcO6ao2rxH3YWYMxKzxA9wdsAn4eKIhdUwKptzIA4
         j1OnKhbtRRBkNO/Vu+A/Rp9N0hVlRIdUlhzbrhxQMshR+7j5B4flEBhEibu/J7P3WnCr
         jiUSGU00yM7SBq29lh47sS/jWFCVChhG5APe9nJ3LG9El/s/RMrL2LyQKZlZXRQbLt5n
         4BfQ==
X-Gm-Message-State: APjAAAXo5Tb6ZdiU2IQLhRRfzCc6WePYX4T442XKEaA1btbC8JrKQT7X
        S7+6bUmSI7abdX+FUI3Axe0QWH1whJOtWXjeo6zwAg==
X-Google-Smtp-Source: APXvYqyaD/lVRLAGjdvleYMAYDc5dLlKYIHBFNw9Y8pm/8dJbZCYSSBsihmIjD8/eWFRLVRUnDlcrVW2b1zkXu+Rw1E=
X-Received: by 2002:a67:ebc2:: with SMTP id y2mr13457816vso.191.1571664981141;
 Mon, 21 Oct 2019 06:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191011131502.29579-1-ludovic.Barre@st.com> <20191011131502.29579-2-ludovic.Barre@st.com>
In-Reply-To: <20191011131502.29579-2-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 15:35:44 +0200
Message-ID: <CAPDyKFqE09nqdev_qewwNzjjUuhm0UUC03tgvY=ZukYY4az7wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: add unstuck function if host is in deadlock state
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

On Fri, 11 Oct 2019 at 15:15, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> After a request a host may be in deadlock state, and wait
> a specific action to unstuck the hardware block before
> re-sending a new command.

Rather than talking about "unstuck" and "deadlock", how about instead
describing that an MMC controller, may end up in an non-functional
state hanging on something. Then to allow it to serve new requests it
needs to be reset.

>
> This patch adds an optional callback mmc_hw_unstuck which
> allows the host to unstuck the controller. In order to avoid
> a critical context, this callback must be called when the
> request is completed. Depending the mmc request, the completion
> function is defined by mrq->done and could be in block.c or core.c.

I think it's important to state exactly what is expected from the core
perspective, by the mmc host driver when it calls this new host ops.
We need to clarify that.

>
> mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
> DEADLK error.

To me, this approach seems a bit upside-down. Although, I have to
admit that I haven't thought through this completely yet.

The thing is, to make this useful for host drivers in general, I
instead think we need to add timeout to each request that the core
sends to the host driver. In other words, rather than waiting forever
in the core for the completion variable to be set, via calling
wait_for_completion() we could call wait_for_completion_timeout(). The
tricky part is to figure out what timeout to use for each request.
Perhaps that is even why you picked the approach as implemented in
@subject patch instead?

Anyway, the typical scenario I see, is that the host driver is
hanging, likely waiting for an IRQ that never get raised. So, unless
it implements it own variant of a "request timeout" mechanism, it
simple isn't able to call mmc_request_done() to inform the core about
that the request has failed.

For comments to the code, I defer that to the next step, when we have
agreed on the way forward.

Kind regards
Uffe

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/core/block.c | 11 +++++++++++
>  drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
>  include/linux/mmc/core.h |  1 +
>  include/linux/mmc/host.h |  7 +++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c71a434c915..2f723e2f5fde 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1799,6 +1799,17 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>         u32 blocks;
>         int err;
>
> +       /*
> +        * if the host return a deadlock, it needs to be unstuck
> +        * before to send a new command.
> +        */
> +       if (brq->sbc.error == -EDEADLK || brq->cmd.error == -EDEADLK ||
> +           brq->stop.error == -EDEADLK || brq->data.error == -EDEADLK) {
> +               pr_err("%s: host is in bad state, must be unstuck\n",
> +                      req->rq_disk->disk_name);
> +               mmc_hw_unstuck(card->host);
> +       }
> +
>         /*
>          * Some errors the host driver might not have seen. Set the number of
>          * bytes transferred to zero in that case.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 221127324709..43fe59a7403b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -397,6 +397,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>  {
>         struct mmc_command *cmd;
> +       int sbc_err, stop_err, data_err;
>
>         while (1) {
>                 wait_for_completion(&mrq->completion);
> @@ -420,8 +421,24 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>                                        mmc_hostname(host), __func__);
>                         }
>                 }
> -               if (!cmd->error || !cmd->retries ||
> -                   mmc_card_removed(host->card))
> +
> +               sbc_err =  mrq->sbc ? mrq->sbc->error : 0;
> +               stop_err = mrq->stop ? mrq->stop->error : 0;
> +               data_err =  mrq->data ? mrq->data->error : 0;
> +
> +               /*
> +                * if the host return a deadlock, it needs to be unstuck
> +                * before to send a new command.
> +                */
> +               if (cmd->error == -EDEADLK || sbc_err == -EDEADLK ||
> +                   stop_err == -EDEADLK || data_err == -EDEADLK) {
> +                       pr_debug("%s: host is in bad state, must be unstuck\n",
> +                                mmc_hostname(host));
> +                       mmc_hw_unstuck(host);
> +               }
> +
> +               if ((!cmd->error && !sbc_err && !stop_err && !data_err) ||
> +                   !cmd->retries || mmc_card_removed(host->card))
>                         break;
>
>                 mmc_retune_recheck(host);
> @@ -430,6 +447,12 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>                          mmc_hostname(host), cmd->opcode, cmd->error);
>                 cmd->retries--;
>                 cmd->error = 0;
> +               if (mrq->sbc)
> +                       mrq->sbc->error = 0;
> +               if (mrq->stop)
> +                       mrq->stop->error = 0;
> +               if (mrq->data)
> +                       mrq->data->error = 0;
>                 __mmc_start_request(host, mrq);
>         }
>
> @@ -2161,6 +2184,14 @@ int mmc_sw_reset(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_sw_reset);
>
> +void mmc_hw_unstuck(struct mmc_host *host)
> +{
> +       if (!host->ops->hw_unstuck)
> +               return;
> +       host->ops->hw_unstuck(host);
> +}
> +EXPORT_SYMBOL(mmc_hw_unstuck);
> +
>  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>  {
>         host->f_init = freq;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b7ba8810a3b5..eb10b8194073 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -173,6 +173,7 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
>
> +void mmc_hw_unstuck(struct mmc_host *host);
>  int mmc_hw_reset(struct mmc_host *host);
>  int mmc_sw_reset(struct mmc_host *host);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba703384bea0..8b52cafcd1eb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -163,6 +163,13 @@ struct mmc_host_ops {
>         void    (*hw_reset)(struct mmc_host *host);
>         void    (*card_event)(struct mmc_host *host);
>
> +       /*
> +        * Optional callback, if your host could be in deadlock after a command
> +        * and need a specific action to unstuck the controller before sending
> +        * new command.
> +        */
> +       void    (*hw_unstuck)(struct mmc_host *host);
> +
>         /*
>          * Optional callback to support controllers with HW issues for multiple
>          * I/O. Returns the number of supported blocks for the request.
> --
> 2.17.1
>
