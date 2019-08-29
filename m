Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A231A22A5
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfH2Roc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 13:44:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34270 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2Roc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 13:44:32 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so8683179ioa.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0/wEQOY41ZAwBlbnwMnPIcIDqJGJYBAEzaUfyt/UCA=;
        b=RxAdYwWHCc51YWNiPsz3mKegfEe4w4o1SQpJRubLe15x3wQxumvC0x0pbMl/hxXzBg
         uHPnACDF2ylQF8pcwTKJg5lsvtbbUfb4KdEsa4YqLefKOwV+d4EyllVFGVI/VjycXU+0
         I9QNa9yh9ywYEqtZ7aMVzLFlvoM+Fa8jLOPkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0/wEQOY41ZAwBlbnwMnPIcIDqJGJYBAEzaUfyt/UCA=;
        b=aS5Uy9TdShMFIiANYITiOAuDeP094sfDNYJgio0ucSyX+djnfnmh3wS7Fw1bICnelw
         K5gslVrr1RVe34xcqtBeNA6KRvLd4MpywoCfiyq6wsGAcfa3SlBaeY648z09dlzm5JHG
         TVPv7/KpxWk6X4eyZ4XuSPiTzrUSPab61XWTDhKiZcSRNse/1DnsQzyf5hGn/G/fdlnm
         v7B/DaXQh9+pPsENJVUPWF0CdstisbwKT1Wmac+zF0XcVYuIYXFu7/sBoJ4vHWOWbhA8
         MurVrQdzmQi70g2ZfmAqadDEnUTIyJJkTc4IVvpkhcQIlMLKLofAulsqYzG2zUJenmOC
         zAoA==
X-Gm-Message-State: APjAAAWG2f8dqiXzoevc8+YyNc6VUNv4ueAVCUJLvAi6A1K7ps2bF4ZY
        i5JwoRenZnQhH+0P45BE01LEMOQzxtk=
X-Google-Smtp-Source: APXvYqwOhpZAJLQYhKN9SzPrV1jauH/B4sujJpYXz1QOdJMQsqTpzMwuDzKpWCGstLthDLlpO1G40A==
X-Received: by 2002:a02:9a0b:: with SMTP id b11mr549653jal.106.1567100670977;
        Thu, 29 Aug 2019 10:44:30 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id p1sm2476911iol.11.2019.08.29.10.44.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:44:30 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id b10so8671414ioj.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 10:44:30 -0700 (PDT)
X-Received: by 2002:a6b:d006:: with SMTP id x6mr12265612ioa.218.1567100669783;
 Thu, 29 Aug 2019 10:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
In-Reply-To: <20190828214620.66003-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Aug 2019 10:44:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhKCKzj7W+LGAGuzukCsOag1meHk4dW7=XQF21KeS_pg@mail.gmail.com>
Message-ID: <CAD=FV=UhKCKzj7W+LGAGuzukCsOag1meHk4dW7=XQF21KeS_pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Aug 28, 2019 at 2:46 PM Matthias Kaehlcke <mka@chromium.org> wrote:
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
> +
> +skip_pending_irqs:
>         if (host->sdio_irqs) {

nit: I'd prefer to avoid the "goto" if possible.  Using "goto" to
handle unwinding during error handling always makes good sent to me,
but here you're not doing unwinding--you're just using the "goto" as
an unstructured "if".  I'd rather just see:

  if (mmc_card_keep_power(host) &&
      !sdio_get_pending_irqs(host, &pending) && pending != 0)
          sdio_signal_irq(host);

Other than that this patch seems sane to me though (obviously) the
person you'd need to convince is Ulf.  ;-)

-Doug
