Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C244BA2E
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Jun 2019 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfFSNjY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Jun 2019 09:39:24 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46698 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbfFSNjY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2019 09:39:24 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so9794639uap.13
        for <linux-mmc@vger.kernel.org>; Wed, 19 Jun 2019 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygy1CFkQCFTyi/IaVMEk8MlBKcngDnJcBhfNCxwCCbI=;
        b=SJYrCy+bfnRbJ93ZqsjyRYfk4YZr6fNQVRLcOUDirI0mB2QZiVbpPFPpgOH4OwXisL
         6T/Nz3oRrbVzY68aw9HU+kZGXvjwf7YTiDi4NxbV8yV0lyRy3Se3TO8YAaArfXc1NgtD
         e+tZPzTrD/vCFJ9UNyQsw9tSySTeg9ZqTusm+nmEM3quTV5E2qsygs361Z4PwT5q2ykf
         BhTkWoKQZX1OOVred+4P5uyHX9NfhGoPuKhVGsShL1G9F42URdX0phy2rRjOWz6ZkUDU
         fdM5Rc71DmqsoooEurdw3vvURuQnOoBEoebttrxPtmjg8cQ01FaT8ZtaTsis8IXqNWm+
         ZkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygy1CFkQCFTyi/IaVMEk8MlBKcngDnJcBhfNCxwCCbI=;
        b=RruKwhQbWBrNU2ciVGPimCzU4pBt/iYI/Ue4M5yjhYmTptJSy26JrKUlAb0ZIulswW
         3+2xmGuhrIwQ+MrRZH3raIW0KIux0Io61RVuZJNs1axS5pyuIN/2F8g9qupYG8wZjXv5
         R39h/RFWoE362AE8phXS6x4C1SrMx3NU+haqSMGOqTcW8q7U3Isyx0YC3hOAcs7r11CZ
         KLBJMpL7SnSP8em73XoOh6jiCMu82zyoiAUkiVm6fn2HUAKoJTHHYLtdeBYAvp5MsS0S
         buwFkaupD3w/zBKuTRcrt6377uvMjSrhXYsNRfmDEgdq5fxavznAdUT2o1ZC9569mahh
         Nrrg==
X-Gm-Message-State: APjAAAUCO1UrXeEqUYuHVGkZZ1Rvui7NUGTHIPN37dZcy2CqCwHyoOXx
        m9/+XbmB4nLPsuVRl6SaoMQJ8WHDnyVyKwHqacbEpQ==
X-Google-Smtp-Source: APXvYqy2SC+4P4kfrJYqcfaPIIK+E7p9ADoB0DluVM96aMYIJtafUGfr1APFftQPqYnOav8bOUtdJ6QkFhwE1yInUVU=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr15613313uam.129.1560951563492;
 Wed, 19 Jun 2019 06:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Jun 2019 15:38:47 +0200
Message-ID: <CAPDyKFqb3uRU1XbrioSw6UZ5atZ8WwZNhQ_yq2+3JfxXZCxr7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Jun 2019 at 10:40, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, June 17, 2019 5:51 PM
> [...]
> >
> > The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> > a clock provider specific struct, which is assigned when calling
> > sdhci_arasan_register_sdclk. I understand that all the clock data is
> > folded into struct sdhci_arasan_data today, but I think that should be
> > moved into a "sub-struct" for the clock specifics.
> >
> > Moreover, when registering the clock, we should convert from using
> > devm_clk_register() into devm_clk_hw_register() as the first one is
> > now deprecated.
>
> Just a query here:
> When we switch to using devm_clk_hw_register() here, it will register the clk_hw and return int.
> Is there a way we can get the clk (related to the clk_hw registered) from the
> clock framework?
> I am asking this because we will need that clk pointer while calling clk_set_phase() function.

I assume devm_clk_get() should work fine?

Kind regards
Uffe
