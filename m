Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB13728EF
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfGXHUI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 03:20:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35340 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGXHUI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 03:20:08 -0400
Received: by mail-ua1-f66.google.com with SMTP id j21so18088622uap.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZzXFeEn87A5vyKYJCjfJnKarDAqU0LIG7gGJcY5sqsg=;
        b=Jw04qDJbUduHDaQul0E7od3NeIWVX284jfuzm47kaW8A6J/Nnm5Ru1i0Xq/+mK6Det
         u2uKGf2FZ+RZEBpz4g/IQdHIB6bYME+9m/PynBS4EO0FOXuOVJtFS8oY8w0+lRzqjubv
         0yZUoNouuzpBinqBD4/A+/Y4EZsff3UUko4zsIPtTlNqtVUnu/HXqkPzsdg+A1Y5TP7q
         K914bSyggrk1akIAGqOLQiBpXToAxaaxL8Ci70+cjFHb7CDZnEZOwAFmoOil6Wjg6xZ2
         keD9WElSm/+VEaRG5C4Hmr/GXBzuuw83tn0hxXN2a4upjV+ayGEycRNSTcQkCe6Y34le
         4j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzXFeEn87A5vyKYJCjfJnKarDAqU0LIG7gGJcY5sqsg=;
        b=pVpfFzjF8RLqorA5rs3CkwR+uEBlNyI/qW9ocjpznuhQ2O+IfvxBD9KBtyz8hK+3je
         Hq4p5GXX+b1c7NKHg2R+lcRww7tPhidX7d/eJduD2LciI/r86oVsAEmmXG4jznrKpKWf
         Y4iJv6gf+Gwg1NGsbnPY5jE4iTUHyaUoyjqkYEZwKjQiYvkdpYdx6PCT1vPnU2Wr2T8b
         KjaHCTcmAbdEdsc4MeqnG6O32PpvkDS0bxOi8MwM3KmKrXtKl6x+Q3I5Re7KwdYmHxnC
         vYQd+G0+45MXLXdDdM+xPTvWrhixhZbP6m9pIqzA35eOvgIkWzilSAV2Bwm9VFMMRIpS
         nPFA==
X-Gm-Message-State: APjAAAVZ5pWhmSpK1oLHV/krDqy+Qoa6k5XLGCAHz85UgOQQCGoUp35C
        EpGpxgqa829Z9tqCqFxucXnXPxt7+eE040bjoWeFiQ==
X-Google-Smtp-Source: APXvYqwAZ+IHQRsFDAdYH1zuStC/NjCSHs84NulAyquPAW0fpjlQaG3LiIyzngHaaBb05uDzByEEcn48fMR+6udD5Dg=
X-Received: by 2002:ab0:5973:: with SMTP id o48mr40276484uad.19.1563952807229;
 Wed, 24 Jul 2019 00:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
In-Reply-To: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 09:19:30 +0200
Message-ID: <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add PLL Enable support to internal clock setup
To:     Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        johnsonm@danlj.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 04:39, Ben Chuang <ben.chuang@genesyslogic.com.tw> w=
rote:
>
> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> setup as part of the internal clock setup as described in 3.2.1 Internal
> Clock Setup Sequence of SD Host Controller Simplified Specification
> Version 4.20.  This changes the timeouts to the new specification of
> 150ms for each step and is documented as safe for "prior versions which
> do not support PLL Enable."
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..fd684d7a5f15 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,15 +1636,11 @@ void sdhci_enable_clk(struct sdhci_host *host, u1=
6 clk)
>         clk |=3D SDHCI_CLOCK_INT_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> -       /* Wait max 20 ms */
> -       timeout =3D ktime_add_ms(ktime_get(), 20);
> -       while (1) {
> -               bool timedout =3D ktime_after(ktime_get(), timeout);
> -
> -               clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -               if (clk & SDHCI_CLOCK_INT_STABLE)
> -                       break;
> -               if (timedout) {
> +       /* Wait max 150 ms */
> +       timeout =3D ktime_add_ms(ktime_get(), 150);
> +       while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +               & SDHCI_CLOCK_INT_STABLE)) {
> +               if (ktime_after(ktime_get(), timeout)) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                mmc_hostname(host->mmc));
>                         sdhci_dumpregs(host);
> @@ -1653,8 +1649,27 @@ void sdhci_enable_clk(struct sdhci_host *host, u16=
 clk)
>                 udelay(10);

This looks like it could be changed to an usleep_range(), perhaps an
additional change on top?

>         }
>
> +       clk |=3D SDHCI_CLOCK_PLL_EN;
> +       clk &=3D ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       /* Wait max 150 ms */
> +       timeout =3D ktime_add_ms(ktime_get(), 150);
> +       while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +               & SDHCI_CLOCK_INT_STABLE)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       pr_err("%s: PLL clock never stabilised.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +               udelay(10);

Ditto.

> +       }
> +
>         clk |=3D SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       mdelay(1);

This is new, maybe add a comment and change to usleep_range().

>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_clk);
>
> --
> 2.22.0
>
> ________________________________
>
> Genesys Logic Email Confidentiality Notice:
> This mail and any attachments may contain information that is confidentia=
l, proprietary, privileged or otherwise protected by law. The mail is inten=
ded solely for the named addressee (or a person responsible for delivering =
it to the addressee). If you are not the intended recipient of this mail, y=
ou are not authorized to read, print, copy or disseminate this mail.
>
> If you have received this email in error, please notify us immediately by=
 reply email and immediately delete this message and any attachments from y=
our system. Please be noted that any unauthorized use, dissemination, distr=
ibution or copying of this email is strictly prohibited.
> ________________________________

If you want me to apply the patch, you have to drop the above notice.

Kind regards
Uffe
