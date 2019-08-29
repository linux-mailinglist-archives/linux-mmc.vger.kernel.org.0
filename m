Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DDA140F
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfH2Itf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 04:49:35 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39392 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfH2Itf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 04:49:35 -0400
Received: by mail-vk1-f193.google.com with SMTP id x20so623390vkd.6
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMHReu8t0qb2bsvbvFDIXyQ12gJM8CStkHATkFqVA1M=;
        b=FhQ3RzRUr0ZEqyb3slVM2yr8eLBdMMYyM27K0UcPDO3+1DTMXzLKZyjCtzgDO8L0Nc
         9t4Lhh3fsq/VIlmgJNOEAa4JzhUQMLxRCGPgzl9FFqTUCYo+ZTSU/fNFOJSnqJaWDKYO
         ryg43JAHliyftzWwHA08iKHh73Hc7/e3jWqGnvdmSil5OfeWYqIxdk7U1nEmiy0Wjzyn
         lsL+PhqRNaaOB8dLLlMAgWztyZizGYtnpNBeWU3V54r2HR1dn9tXcjIr7Fio/RGMZHEV
         e/maOD172OZ1cyQdxgjA4ZE/cYfCd8j64ES5cZ2TgNORSWbSq8GxlYkoSUvAwCxHdEVw
         DDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMHReu8t0qb2bsvbvFDIXyQ12gJM8CStkHATkFqVA1M=;
        b=dzqi3C2AoAhlP9vypJ+rx/DTKi6C9x2NcLXd349B2XFhwPItIn/mjdFC4Eyr1NLp1v
         0TcQ2xBK85EA1KD0VdTIGyn2VSXKypsjc1D5ezV+bfGVcprsZCozOnew1TALNjdae6Ym
         HFwLFgWqPdOjBVlfwX77SmR9e2TLY63XY6h1NfudJR/0MZpDSEboXlB2Qd3U+myTd8KT
         I5Pz9BlQ+g6eCkdDA4Mfr9thpbmVkxb7UoOboKH1Jhr/U74t1XurHrDUgKPaPTQmI48P
         yxVT03doNx49P4TyAeeR7cvCqb+A7JQOt8gLsfOhCcJNdz4/C4tJq3JesCVnOxkP5rBH
         IuqA==
X-Gm-Message-State: APjAAAVXsAydru4G7Wi7y5YZGHcD7DOAmXt/W4JAvPvvIcPZkSDiCvJ7
        9/vjbXZjtOt1XMfak3l/lbFzX6jumVlNGs9fLeJf/A==
X-Google-Smtp-Source: APXvYqytFUxVF3De7rSg8RJLMo+rynossC62ogl1jMOOp6Klec0ZbUtAL3c+78swdI23w/XQRRaeQr022HItpPO5qeI=
X-Received: by 2002:a1f:5185:: with SMTP id f127mr4406033vkb.52.1567068574138;
 Thu, 29 Aug 2019 01:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
In-Reply-To: <20190828214620.66003-2-mka@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 10:48:58 +0200
Message-ID: <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With commit 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs
> when the card is suspended") SDIO interrupts are dropped if they
> occur while the card is suspended. Dropping the interrupts can cause
> problems after resume with cards that remain powered during suspend
> and preserve their state. These cards may end up in an inconsistent
> state since the event that triggered the interrupt is never processed
> and remains pending. One example is the Bluetooth function of the
> Marvell 8997, SDIO is broken on resume (for both Bluetooth and WiFi)
> when processing of a pending HCI event is skipped.
>
> For cards that remained powered during suspend check on resume if
> SDIO interrupts are pending, and trigger interrupt processing if
> needed.

Thanks for the detailed changelog, much appreciated!

>
> Fixes: 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs when the card is suspended")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/mmc/core/sdio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8dd8fc32ecca..a6b4742a91c6 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -975,6 +975,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>  static int mmc_sdio_resume(struct mmc_host *host)
>  {
>         int err = 0;
> +       u8 pending = 0;
>
>         /* Basic card reinitialization. */
>         mmc_claim_host(host);
> @@ -1009,6 +1010,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         /* Allow SDIO IRQs to be processed again. */
>         mmc_card_clr_suspended(host->card);
>
> +       if (!mmc_card_keep_power(host))
> +               goto skip_pending_irqs;
> +
> +       if (!sdio_get_pending_irqs(host, &pending) &&
> +           pending != 0)
> +               sdio_signal_irq(host);

In one way, this change makes sense as it adopts the legacy behavior,
signaling "cached" SDIO IRQs also for the new SDIO irq work interface.

However, there is at least one major concern I see with this approach.
That is, in the execution path for sdio_signal_irq() (or calling
wake_up_process() for the legacy path), we may end up invoking the
SDIO func's ->irq_handler() callback, as to let the SDIO func driver
to consume the SDIO IRQ.

The problem with this is, that the corresponding SDIO func driver may
not have been system resumed, when the ->irq_handler() callback is
invoked. If the SDIO func driver would have configured the IRQ as a
wakeup, then I would expect this to work, but not just by having a
maintained power to the card.

In the end, I think we need to deal with synchronizations for this,
through the mmc/sdio core, in one way or the other - before we kick
SDIO IRQs during system resume.

> +
> +skip_pending_irqs:
>         if (host->sdio_irqs) {
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
> --
> 2.23.0.187.g17f5b7556c-goog
>

Kind regards
Uffe
