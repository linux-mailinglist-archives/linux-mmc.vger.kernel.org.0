Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF6DF7DE
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfJUWNw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 18:13:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36807 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWNw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 18:13:52 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so17921052iof.3
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 15:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TLExkVMvOpDTxrAPa6CkioyV3R0cc46IoRh0yejrVk=;
        b=CZ8d0bWmuMWru3AuFCtc8RsvHw3UW0faKzpKCLpXoJOFhaUreDa3gG9lEnrMDyZEOK
         oI9frqf3iST1+eHSgZ8WOafLB+qfwhFpsBjwUiR16MCTKrZK2K0liu2lF3VHxqVf/GlH
         6LW2eeboJNosnHtnVdNhFR4tNMnIVDWh5y2Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TLExkVMvOpDTxrAPa6CkioyV3R0cc46IoRh0yejrVk=;
        b=f4i7BEmm3w1R9OdNOyVkjObc85/l2nbz8KvCWkmwau89Gw4DQWepG76+/VFmBPyZHD
         H4L80KYrDIsMMjExQCDT65kgRGQ2qF+Akg6qMvs86MSbVIwcLwN9/GGmCiKrXnjCXV8l
         LlRbFKH+dz8Phj+zpqfYYSM/mN7miwZ4Qq6VeXQw2hxq/1xa1bWGrqwdxXC3t0b/6HNe
         CPf4xOJI0o34R9mUDAgC0AGdwps9RvNtjTGKHGTaLwHwWfKqTDna2MDb+HOkb2/ty1iP
         fMgrgeoKaLKoqCoCXwd6Jv9vbSlYg3jpBF3J6j0kz2V00YKLC6LUYSW7UJrLksTpToQR
         TpBQ==
X-Gm-Message-State: APjAAAVnkCNy6FbxEp/66WyCgA7ZNzMMjMwwPDyyBCj0f3Rrd0rXbQny
        rCAKpuk0ZWeAhdQWJRUbniBOu5cCgWk=
X-Google-Smtp-Source: APXvYqzgZUyxHLo+CUKlHmYicZSGVkZ+0zh+oMu2SRv6DWDKQoC2+s2+UvZ7fpL8O1Rqh4caFSa1ww==
X-Received: by 2002:a05:6602:248e:: with SMTP id g14mr607955ioe.6.1571696030847;
        Mon, 21 Oct 2019 15:13:50 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id f18sm1196563ilc.23.2019.10.21.15.13.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 15:13:50 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z19so17982449ior.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 15:13:50 -0700 (PDT)
X-Received: by 2002:a6b:7715:: with SMTP id n21mr561180iom.142.1571696029970;
 Mon, 21 Oct 2019 15:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-2-ulf.hansson@linaro.org>
In-Reply-To: <20191017135739.1315-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Oct 2019 15:13:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wh3bnvNu-_1cXf1xT44-EwomoZEWDt88PZzhUVCn9PcQ@mail.gmail.com>
Message-ID: <CAD=FV=Wh3bnvNu-_1cXf1xT44-EwomoZEWDt88PZzhUVCn9PcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 17, 2019 at 6:57 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
> scanning only once for non-removable cards. Therefore, it's also not
> possible that we can have bus attached, when we are scanning non-removable
> cards. For this reason, let' drop the check for mmc_card_is_removable() as
> it's redundant.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 221127324709..6f8342702c73 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
>
>         mmc_bus_get(host);
>
> -       /*
> -        * if there is a _removable_ card registered, check whether it is
> -        * still present
> -        */
> -       if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
> +       /* Verify a registered card to be functional, else remove it. */
> +       if (host->bus_ops && !host->bus_dead)
>                 host->bus_ops->detect(host);

At first I thought this was a bit more of a change than your
description makes it sound like.  Specifically it seemed like
non-removable cards used to never call host->bus_ops->detect() here
(even during the first call to mmc_rescan) but now they would call it
the first time through.

...so I put in a bunch of printouts.  It appears that the first time
through mmc_rescan() host->bus_ops is NULL.

...ah, and this is what that sentence in your description means about
having a bus attached.  Now I get it!  :-)

...so, right, this looks fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
