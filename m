Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E5F853A
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 01:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKLAdm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 19:33:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42684 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLAdl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 19:33:41 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so8304716ioa.9
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qm9qC61frUmjw7P/ieSKt2kG2a2HaCUv4lVcNyooLzU=;
        b=odI2yIUMmbLRIEI5p0mrTZm2bP1f6NB1QkpIbKCTy+shpXtRSRdIPXeZNPXaOkG/je
         064fQpAqA3GCg89a0wWZUUtoZTj0mxs4CheDPZG9YH61fAQ5Ldidskkbin6D3ZGex29q
         SsG+/Js3LB2Iz5/Bk4nzHixTYci4bQyShyFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qm9qC61frUmjw7P/ieSKt2kG2a2HaCUv4lVcNyooLzU=;
        b=WPUQFc4YYahYil6TwTRf1iCbu3K/YRRm2CSwnV+Oq6p6Xx17hYmEP7/sEhgk4Z0AgR
         XdgjUGIAilkdzXZfb0uoiYEeS37oGpfplH2It+H5yw0QMhpoo+OToaf68sd3vOLUn8EA
         xUJqz8j8gavN/uhcS/Pqeuxfa1TvIZB4bKAbw+eFsrbHejjxg8M616eP1BzuinsMIHrF
         kermlHHO8W6IfeSlJuDwND3Ae8f10/+stqznhhfy4lvT9101/mbr8AXjCkXw5FoFQf4Q
         ymMfOsR4OYzvpujgH22bELnnZ0O8tYCMox/g9ecU3RPPPQ3zsPvsxMcfeHO2GH2jKWsU
         /pdw==
X-Gm-Message-State: APjAAAVT6QCBupv5IAZ5BMDbFJaTmAF9Adxk6/UK57i0qf3XPNXPbtI1
        MH1YxR4FihwLZ83wq8M1vUWCie7s9Zw=
X-Google-Smtp-Source: APXvYqyNt2bIxb0B2QgcyCP+lTuYgPCabwwpgLRn1HXhBMKJV5Cn9aIw5EJFxEWa6lmg8VbdGvnT7Q==
X-Received: by 2002:a5d:9ecb:: with SMTP id a11mr12237712ioe.19.1573518820725;
        Mon, 11 Nov 2019 16:33:40 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id r1sm1284184iod.69.2019.11.11.16.33.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 16:33:38 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id c11so16712108iom.10
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 16:33:38 -0800 (PST)
X-Received: by 2002:a5d:8953:: with SMTP id b19mr28438799iot.168.1573518818050;
 Mon, 11 Nov 2019 16:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191109103046.26445-4-ulf.hansson@linaro.org>
In-Reply-To: <20191109103046.26445-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Nov 2019 16:33:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
Message-ID: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6f8342702c73..abf8f5eb0a1c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>         mmc_bus_put(host);
>  }
>
> -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> -                               bool cd_irq)
> +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>  {
>         /*
>          * If the device is configured as wakeup, we prevent a new sleep for
> @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>         ret = host->bus_ops->hw_reset(host);
>         mmc_bus_put(host);
>
> -       if (ret)
> +       if (ret < 0)
>                 pr_warn("%s: tried to HW reset card, got error %d\n",
>                         mmc_hostname(host), ret);

Other callers besides marvell need to be updated?  In theory only SDIO
should have positive return values so I guess we don't care about the
caller in drivers/mmc/core/block.c, right?  What about:

drivers/net/wireless/ath/ath10k/sdio.c

...I guess I don't know if there is more than one function probed
there.  Maybe there's not and thus we're fine here too?


I didn't spend massive amounts of time looking for potential problems,
but in general seems workable to me.  Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
