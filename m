Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660BC2C1BF
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfE1Ixg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 04:53:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42605 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfE1Ixf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 04:53:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id z11so12284751vsq.9
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w46wmn45pRWKdWx2S/E0/q503Ba5x6+lr995sSFplTc=;
        b=n/v/lcWRjTbYolV2E7WI0eI+lHIWgRlJgCeQGZnvC/4D7KfrkEWRUAOqrFEtv9ajfp
         CjXeruOMk9hnA5hQ+yKzCZWeooDWgKCf1VQNgax20zCHtvPJ1fcCDINKbIIabnNgl8P4
         2PHsrvm1eci92Adh6MrmCmbjz/2eh534mmqmqpobSD6w/49LJZ4CCY5yjcI1Fk4wHvmg
         zu5QR9656jfm00avoNT6Si4pn8UivZhESMyh5EwnwojKma4v4hXCsCZ4zuK5yvtz7CVa
         tPUpaKb0Mv/U+r1M7hKyu5ehHaSZItzlmj6QoPLe35u7m9UAln9FrOPaGDXJx8uFKVZd
         05/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w46wmn45pRWKdWx2S/E0/q503Ba5x6+lr995sSFplTc=;
        b=ApK7p6z+xtIC1JYh6v80FnFM5SC1qqtOFb+k0qdmW3yvLdhf2nOiOU5vUX6CHAVdzm
         gAEfKbA2Ze1/mEpGviCTWjZ3+O3w6MiLrz7C2+PnHrrhUfJGItX3pCpioAwZmwvLi+iM
         K7wMpau3u8S08tZJUTrO/f2lAQAixGLY8esZ/dmMhPGJDNmaZRcGmeJ8y819XNrYnH23
         OZKVOwyKdq6jfdQP3pqccB5drbI/cxaRZokJhn8PvYYjM64dqQpW8ddprf5NZt4T5wIn
         BwwxLcwPip9vkJdmpsYfqXcrquu4G+pQhMgB40VncKf8SZcaDjLlVFXmXFGLKuLSL9ER
         BB3g==
X-Gm-Message-State: APjAAAU4aAaEwXshycyU7swS38FEXFinN0vc+MhsG73/AhojVelc7hmO
        iYZrSzxdOOqfga7+ZsZ7DSwfjLRpHSuW1uYC/6BpQg==
X-Google-Smtp-Source: APXvYqxYJVYarsSusvqhMycm49apuqHN0JcEAC+UGXcuEP316L7ch39AwNmnVwmDukrEsEJFhW0F27NkX0LDwxIS/vo=
X-Received: by 2002:a67:f99a:: with SMTP id b26mr29207404vsq.200.1559033614951;
 Tue, 28 May 2019 01:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190515182346.5292-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190515182346.5292-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:52:59 +0200
Message-ID: <CAPDyKFrhXLMFwvxqvEAFOtaK4YSz08QQnm_fUo1h2jf+38s9rQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: fix SCC error handling to avoid false positive
 CRC error
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 May 2019 at 20:24, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Takeshi Saito <takeshi.saito.xv@renesas.com>
>
> If an SCC error occurs during a read/write command execution, a false
> positive CRC error message is output.
>
> mmcblk0: response CRC error sending r/w cmd command, card status 0x900
>
> check_scc_error() checks SCC_RVSREQ.RVSERR bit. RVSERR detects a
> correction error in the next (up or down) delay tap position. However,
> since the command is successful, only retuning needs to be executed.
> This has been confirmed by HW engineers.
>
> Thus, on SCC error, set retuning flag instead of setting an error code.
>
> Fixes: b85fb0a1c8ae ("mmc: tmio: Fix SCC error detection")
> Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
> [wsa: updated comment and commit message, removed some braces]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> This patch was suggested by the BSP team because they were seeing CRC errors
> with a hardware I don't have access to. I tested this with my R-Car H3-ES2.0
> and M3-N (both Salvator-XS), and things were still running fine. But I suggest
> to wait for a final ack from Shimoda-san or someone from the BSP team.
>
>
>  drivers/mmc/host/tmio_mmc_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 595949f1f001..78cc2a928efe 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -842,8 +842,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
>         if (mrq->cmd->error || (mrq->data && mrq->data->error))
>                 tmio_mmc_abort_dma(host);
>
> +       /* SCC error means retune, but executed command was still successful */
>         if (host->check_scc_error && host->check_scc_error(host))
> -               mrq->cmd->error = -EILSEQ;
> +               mmc_retune_needed(host->mmc);
>
>         /* If SET_BLOCK_COUNT, continue with main command */
>         if (host->mrq && !mrq->cmd->error) {
> --
> 2.11.0
>
