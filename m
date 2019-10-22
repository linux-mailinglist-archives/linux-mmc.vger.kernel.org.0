Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BE4DFFB6
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfJVIld (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 04:41:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44317 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVIld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2019 04:41:33 -0400
Received: by mail-vs1-f67.google.com with SMTP id j85so1710955vsd.11
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2019 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fNIb96drh1xO0TilCLRu1LM7UoTRnZM7kYcybXZZVI=;
        b=r/JyeL5Ka9U5RT4RbTK4lE7v6G80uwWF2A/K82EdLA3gkZUkiwloz46ev+0TomOH/I
         Leyl7dGJc6GxL1SsZk2dkOnPSa8fqJ3oRurtzlLnG/RophMY4RA5Pul6ocqL9+RJWdNF
         A3Gtzqe2Ht8r7KthkwsOHrHdS/aaXFILkaWMPTaXh05WhL1Fvmo2HlpPNyRvkr9DbVXz
         +BYHF9QejlfuaSherGs/mhghe8EgWFPiQq7LvwgAYKvvVU1HiBZt1P8AK+kDPmSgaR3s
         J8d6SYc7+iMKjBfzWp1BL5jdlT3FMMj9xI2FrfBacaXNTTjgO7sGRzRVYfKgcef5QuLk
         YUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fNIb96drh1xO0TilCLRu1LM7UoTRnZM7kYcybXZZVI=;
        b=Ux3SAgrIcb7sCncZF234kD/nNvwa/R1qiCzcyuQaLzsHDRIg0EIcLJ6d1QgoIkFQDC
         ECiJyI46gw/sFt5O3ueysXou0wUUaF1It82tNSP1D3+PdgzAUI/wT0RVYGsGa1p/HhHu
         jESdyVTR9TKOHhthMjE+qNrUpCyD3WJg7txm6FA+pgxe5Rhj7h0KIjPZpVjWhyDiLVST
         6a14qSov8qiw12bwEaPg/yehLzuof3xcgSR3N6qm/rG17GQBjULbQVE/965OIGP13XEn
         OiCCjs458lW2Ry+0FbzKH61WPxEP7ZQTLIiqcnHiEmK9fj4KfWnATIk4+hvJC98x/uSx
         gsWg==
X-Gm-Message-State: APjAAAXqDtl8+S1xTfW7JL+5h5+PjknczpHWITbUX+USh/RTeSvP32Oy
        HYbHoSaNxNsWdHN9DMe954jM1KJquf4wAF7DmNN5mA==
X-Google-Smtp-Source: APXvYqz5lGGoNSc7oCX8jbdYDhLkAc+nXbw5QReJDvgmckqyROQvK3k02ncSlqhZq74x/kqrfE+a5uo1U8kZBhaLV9U=
X-Received: by 2002:a67:ebc2:: with SMTP id y2mr1119820vso.191.1571733691759;
 Tue, 22 Oct 2019 01:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Oct 2019 10:40:55 +0200
Message-ID: <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com>
Subject: Re: [RFC 0/6] mmc: Add clock scaling support for mmc driver
To:     Ram Prakash Gupta <rampraka@codeaurora.org>
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        cang@codeaurora.org, ppvk@codeaurora.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Oct 2019 at 16:30, Ram Prakash Gupta <rampraka@codeaurora.org> wrote:
>
> This change adds the use of devfreq based clock scaling to MMC.
> This applicable for eMMC and SDCard.
> For some workloads, such as video playback, it isn't necessary
> for these cards to run at high speed. Running at lower
> frequency, in such cases can still meet the deadlines for data
> transfers.
>
> Scaling down the clock frequency dynamically has power savings
> not only because the bus is running at lower frequency but also
> has an advantage of scaling down the system core voltage, if
> supported. Provide an ondemand clock scaling support similar
> to the cpufreq ondemand governor having two thresholds,
> up_threshold and down_threshold to decide whether to increase
> the frequency or scale it down respectively as per load.

This sounds simple, but what the series is doing is far more
complicated but scaling the bus clock, as it also re-negotiates the
bus speed mode.

Each time the triggering point for scaling up/down is hit, then a
series of commands needs to be sent to the card, including running the
tuning procedure. The point is, for sure, this doesn't come for free,
both from a latency point of view, but also from an energy cost point
of view. So, whether this really improves the behaviour, seems like
very use case sensitive, right!?

Overall, when it comes to use cases, we have very limited knowledge
about them at the mmc block layer level. I think it should remain like
that. If at any place at all, this information is better maintained by
the generic block layer and potentially the configured I/O scheduler.

This brings me to a question about the tests you have you run. Can you
share some information and data about that?

>
>
> Ram Prakash Gupta (6):
>   mmc: core: Parse clk scaling dt entries
>   mmc: core: Add core scaling support in driver
>   mmc: core: Initialize clk scaling for mmc and SDCard
>   mmc: core: Add debugfs entries for scaling support
>   mmc: sdhci-msm: Add capability in platfrom host
>   dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  19 +

I noticed that the DT patch was put last in the series, but the
parsing is implemented in the first patch. Please flip this around. If
you want to implement DT parsing of new bindings, please make sure to
discuss the new bindings first.

>  drivers/mmc/core/block.c                           |  19 +-
>  drivers/mmc/core/core.c                            | 777 +++++++++++++++++++++
>  drivers/mmc/core/core.h                            |  17 +
>  drivers/mmc/core/debugfs.c                         |  90 +++
>  drivers/mmc/core/host.c                            | 226 ++++++
>  drivers/mmc/core/mmc.c                             | 246 ++++++-
>  drivers/mmc/core/queue.c                           |   2 +
>  drivers/mmc/core/sd.c                              |  84 ++-
>  drivers/mmc/host/sdhci-msm.c                       |   2 +
>  include/linux/mmc/card.h                           |   7 +
>  include/linux/mmc/host.h                           |  66 ++
>  12 files changed, 1550 insertions(+), 5 deletions(-)

This is a lot of new code in the mmc core, which I would then need to
maintain, of course. I have to admit, I am a bit concerned about that,
so you have to convince me that there are good reasons for me to apply
this.

As I stated above, I think the approach looks quite questionable in
general. And even if you can share measurement, that it improves the
behaviour, I suspect (without a deeper code review) that some of the
code better belongs in common block device layer.

Kind regards
Uffe
