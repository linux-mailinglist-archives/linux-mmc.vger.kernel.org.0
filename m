Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4007F8F93
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKLMUe (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Nov 2019 07:20:34 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34713 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLMUe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2019 07:20:34 -0500
Received: by mail-vs1-f66.google.com with SMTP id y23so10648965vso.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 04:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=og0UIW/NGqvsDW3+Z9reKd9ioJlmKdQ1Kpo1MB8gx6Q=;
        b=hMMt9iG5GRldzj1k3cn4WhjT13oakgFn97P4rJ26+wqfkLD9eamNNxHan+2hxxoxSS
         QOHXMAW9n6wd4nbUqwomOaB7mmzjyIz3u0FsJJXCaVhMSUXaBG3A9JsJ4MBQNyGQJjja
         7WoE+OdRpUi1D0Km7yMVWy1FLcnkijoICrusPbsBQfyw8GK7Fsv3N0ypNMcIcLxExspf
         KFv87syByU06Eu+jfe2qe8wq/mw2hcbDJ7jEKUVsfoJhgP9sQici9ZHTf5j2dLyGawOw
         l7Gpep5jw6jc4Sa++3kjlqlxv7yUboqbAMlQA6pWGoYuNQ3lr0TjWCwlZh5A9NG/VPJ2
         Y1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og0UIW/NGqvsDW3+Z9reKd9ioJlmKdQ1Kpo1MB8gx6Q=;
        b=IoKgppb5rgl27UFZvryX7cw0net3N1NwmF/gEKsYgmvw+CeNa6As8KrRefcMJNzI9p
         v6HtOiAOmG6IZqWYIO0CPxnJAkZz7P60+HND+SfvkKs+u5fdVal1Iz3ZHL6MbHfdzhd7
         Xa1yzCxEbfhWtKOl7Lb0+d9QJGHzaZ0ms5Ap45Ls8jbGX08Z73KgYhPMk+BTKCuZjyuy
         6l3ZsgfwbyYQoT77nLQrqZTVBrpL61SoJOOHuayKFdaX3MfxP1J1ii0SBeJ0oDPaBTKe
         UWXWkNY3AfkZRtHLE9r/hM6oDAY3FjIxZsNHSxURPd9khTO56KdSHJw9HwBpcM/Z2BH0
         UaEQ==
X-Gm-Message-State: APjAAAU7xikHFBjJcBVBuQAxt2Ivzd9eXNV4RrM0KrTVVSC4vguI/6WM
        /JpBV22pVcTp3UIceHDtsoBoRAuGSc0Kj9PKjtLxoA==
X-Google-Smtp-Source: APXvYqxqNMSl3XDztmekyz0Cvg0QKHXqAqKI0I0Wv0xHu/cWT20+WTgwZNzGgYgYhZ1b+LHYoQOEJ0gKBE4a/tnhdZ8=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr22173790vsa.34.1573561231123;
 Tue, 12 Nov 2019 04:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-4-ulf.hansson@linaro.org> <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
In-Reply-To: <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Nov 2019 13:19:55 +0100
Message-ID: <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
To:     Doug Anderson <dianders@chromium.org>
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

On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 6f8342702c73..abf8f5eb0a1c 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
> >         mmc_bus_put(host);
> >  }
> >
> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
> > -                               bool cd_irq)
> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
> >  {
> >         /*
> >          * If the device is configured as wakeup, we prevent a new sleep for
> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
> >         ret = host->bus_ops->hw_reset(host);
> >         mmc_bus_put(host);
> >
> > -       if (ret)
> > +       if (ret < 0)
> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
> >                         mmc_hostname(host), ret);
>
> Other callers besides marvell need to be updated?  In theory only SDIO
> should have positive return values so I guess we don't care about the
> caller in drivers/mmc/core/block.c, right?

Correct, but maybe I should add some more information about that in a
function header of mmc_hw_reset(). Let me consider doing that as a
change on top.

>  What about:
>
> drivers/net/wireless/ath/ath10k/sdio.c
>
> ...I guess I don't know if there is more than one function probed
> there.  Maybe there's not and thus we're fine here too?

Well, honestly I don't know.

In any case, that would mean the driver is broken anyways and needs to
be fixed. At least that's my approach to doing this change.

>
>
> I didn't spend massive amounts of time looking for potential problems,
> but in general seems workable to me.  Thanks!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Kind regards
Uffe
