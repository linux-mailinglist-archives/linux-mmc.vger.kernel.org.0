Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6201634115
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfFDIDb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:03:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44747 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFDIDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:03:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so8159085oib.11
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKpO8H57h4hKIEfk4q7HqguHGPmqzEwBqOwZI4qAzTI=;
        b=wfSINV13HS4ZECgj4OMaDwgnjyqqftKSQPf9sdO3jpWk5j1d1uIYnzwIBGGtBcTCDK
         zBSONMDiI3qwFEuQMKa0jjfLZFJ6uOKnyLxMXNspWMojasO6ZMWT5S2I5sruP96xasLK
         kiKlOBW/QPWonXzYsXTsoouNR1QDK/aRZ5BcpWY6iSsOfR3OufY+Lxq9lWTXRctpL4Hy
         a/R24TK38s9dnK0/H1jtWs8kZ/wfjp6nZ1gf/evwTjwwCR71FDMKKzdc3zqiGbzX11Ef
         d4bFQKqCryQX4Rb3woxnz9UyLAX5WjN5SR2kBXptjQJ4yF804wcIcNR03xl5RNq6h/Ml
         6qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKpO8H57h4hKIEfk4q7HqguHGPmqzEwBqOwZI4qAzTI=;
        b=ffIoadgCPKVy2aApi1WnCf5V9t3K3I+boJVV0/9bPgmJaXjORlS0I6j8gY1yzWyvrP
         vX99BPAMUo3HiQWXTSLu0qGYTAPamjYpLTPgmJkY6SSXEg/14bNYZCfHaIaQzim6Pcmj
         lb7Lnjtc4mGyjKtjmtF4F1AurbZeeFd+X0mycpK5Id74Ctl5cEmXZsJTMZkWDdB8cPYq
         50FzLd8Kjl8QDVIhkQBtz0kDcyJTRUWEbhAi8+981PH/PsLzf3reOqbq7q2DYEYS83Jo
         AT/1ERpHCBwy1cquTfVc+KGk2GYyFt8qcxIOaCTPucHWyT5T9zZiGd/EXOkDcvL0fsNT
         TKHg==
X-Gm-Message-State: APjAAAW1qzaPgv971zLUwML/SY1Sqczjzeg7NajgwhqYOWv6MFxfu+tS
        mYwnsWofgItxW/vOw0H1/Pzos9Q1ktCyciqAQ5ySQw==
X-Google-Smtp-Source: APXvYqyMOpg92w6Qp+vhHVCi14htGNn1rx1iAOVrnv9ZgovV4gSotwygWRGsq+15o2Px5EQGrz+6VMFs1vGy8mmk3Fs=
X-Received: by 2002:aca:dd08:: with SMTP id u8mr44390oig.27.1559635410647;
 Tue, 04 Jun 2019 01:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <ae6e23d4de6bb25cd697412f1402036d5ecc9843.1558346019.git.baolin.wang@linaro.org>
 <ed5bdd08-7227-4d55-23de-e78e15d315c7@intel.com>
In-Reply-To: <ed5bdd08-7227-4d55-23de-e78e15d315c7@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 16:03:18 +0800
Message-ID: <CAMz4kuKEOQwOK2Yh+y+-ZhZDndA2tf9V45J_o-OittuSRJcurQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] mmc: sdhci-sprd: Implement the get_max_timeout_count()
 interface
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 Jun 2019 at 20:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/05/19 1:11 PM, Baolin Wang wrote:
> > Implement the get_max_timeout_count() interface to set the Spredtrum SD
> > host controller actual maximum timeout count.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Seems surprising that there isn't a custom ->set_timeout() as well.

Until now we did not find issues when using sdhci_calc_timeout().
Thanks for your reviewing.

> Nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 31ba7d6..d91281d 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -285,6 +285,12 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
> >       usleep_range(300, 500);
> >  }
> >
> > +static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > +{
> > +     /* The Spredtrum controller actual maximum timeout count is 1 << 31 */
> > +     return 1 << 31;
> > +}
> > +
> >  static struct sdhci_ops sdhci_sprd_ops = {
> >       .read_l = sdhci_sprd_readl,
> >       .write_l = sdhci_sprd_writel,
> > @@ -296,6 +302,7 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
> >       .reset = sdhci_reset,
> >       .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> >       .hw_reset = sdhci_sprd_hw_reset,
> > +     .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> >  };
> >
> >  static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >
>


-- 
Baolin Wang
Best Regards
