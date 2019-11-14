Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E7FC82D
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKNNzB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 08:55:01 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39188 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfKNNzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 08:55:01 -0500
Received: by mail-vs1-f67.google.com with SMTP id x21so3890564vsp.6
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQdqtU9AJrfvA0vx5iY0zt/N7LRcXmR4gIsWCKPomIc=;
        b=IaGrxXnt5PX2cJ1rm6x36LKV/bnK3au87fn+HxLGBoePtqQNwa/aOB4OSGHnmYa+LN
         08xSvL1bFGkj0Ej0PLtJif+Wp5lEPuUnyk197PA+HnooXS606f8qtuIiaPPhVb8F1+ly
         6gQayBtpDzlV2b1nO4TjC2Zm5kgf7XCjL6EHzNwIstblYwR+gqL8fgfYyFfyjcINeYLo
         J4+4PDTZ0KHsuaSiX8HpBtOfrbA4NyXfhNXZ/XgnMibL3E/gOnCz+50Ol4wjWRjci3yM
         TEGfRq7L/adV+IcVxsB/5gCvXLGfucFY0i8bfzKoVSKTnIFro1hMioYihnEptOJlYLLG
         PuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQdqtU9AJrfvA0vx5iY0zt/N7LRcXmR4gIsWCKPomIc=;
        b=cBGFCxZ6BBv+sYidIAMzIOJiaIotJEgn8ttbT/tys4GAC9wLdQBXwwBtk8wk35AmjD
         X9MYexFXeGwmflgzj8XsLV4E54jVqXALizoDbcawEw4n5neREI3afrXLFU0GOCTu+Z7I
         qkt6ROUv37Zp/MjGijEgsSDGT4Fi+LzKwJV3+mfjNsTHAXLpiQtTZZ5g+vx2yo0g4PpI
         AFkJt8zAjjXqGsN95B2bbS0qVU6CviPyLczJxZ/qbBOycOMfxBzjJeHBaAWpe6BOS4AA
         gtdyIG+Ivqg4o4JJ7V0UGkJUTxUkNuO4KZm/MilFD7qgBOcVM2VzpO2rSWOXRwrj5ASd
         +BFw==
X-Gm-Message-State: APjAAAVn90eeJc1LdAj1BdlywOP/bvnvBvxPIk7z34lA5FOvQHt7os+G
        ibezYqT50ewZ5YiIPYsfr+pwmCG5MevUserTRMNPk9Ek
X-Google-Smtp-Source: APXvYqxAhVltZe29RXSAjbVyuaxl3T46O8xniWm/LFmVepQsDj/zOkQdvVgK0A+12Z5aTtsx9Vna1wn4HRxB8nJemxI=
X-Received: by 2002:a67:fc04:: with SMTP id o4mr5459803vsq.35.1573739700231;
 Thu, 14 Nov 2019 05:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
In-Reply-To: <20191114111814.35199-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 14:54:23 +0100
Message-ID: <CAPDyKFo16PZHd-0vAvBg6FCbGvrgsarPe5h=EcR3rCtRi27SWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 12:18, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The STOP command is disabled for multiple blocks r/w commands
> with auto CMD12, when start to send. However, if there is data
> error, software still needs to send CMD12 according to SD spec.
> This patch is to allow software CMD12 sending for this case.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 09cdbe8..3041c39 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1326,12 +1326,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
>
>         /*
>          * Need to send CMD12 if -
> -        * a) open-ended multiblock transfer (no CMD23)
> +        * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
>          * b) error in multiblock transfer
>          */
>         if (data->stop &&
> -           (data->error ||
> -            !data->mrq->sbc)) {
> +           ((!data->mrq->sbc && !sdhci_auto_cmd12(host, data->mrq)) ||
> +            data->error)) {

Per your other reply to this thread, I don't think there is any harm
in always sending a CMD12 if there is an error, at least from the
card's point of view.

The worst thing that can happen is that there are two CMD12 sent to
the card and I don't think that is a problem for the error path.

My only concern, is to understand if $subject patch causes other
changes in behaviours for the SDHCI driver. Let's see what Adrian
thinks.

>                 /*
>                  * 'cap_cmd_during_tfr' request must not use the command line
>                  * after mmc_command_done() has been called. It is upper layer's
> @@ -1825,17 +1825,6 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         sdhci_led_activate(host);
>
> -       /*
> -        * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
> -        * requests if Auto-CMD12 is enabled.
> -        */
> -       if (sdhci_auto_cmd12(host, mrq)) {
> -               if (mrq->stop) {
> -                       mrq->data->stop = NULL;
> -                       mrq->stop = NULL;
> -               }
> -       }

In general, I am not very fond of when host drivers change these
structures under the hood of the core, which means I like this part.

> -
>         if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>                 mrq->cmd->error = -ENOMEDIUM;
>                 sdhci_finish_mrq(host, mrq);
> --
> 2.7.4
>

Kind regards
Uffe
