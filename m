Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1594F38869
	for <lists+linux-mmc@lfdr.de>; Fri,  7 Jun 2019 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfFGLDD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 Jun 2019 07:03:03 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37142 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfFGLDD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2019 07:03:03 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so218493uaa.4
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jun 2019 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJJw6aC2zrJqZeFVWgJP7Dr4v9Y0eA3RoR5pHTOrcqI=;
        b=H8eAe0vTztkXtwjhsPaMpNGSkMiaddBzCx/Vq1WfpBiNSRGFSwlpsSaTjiquKYmzMz
         Jxfi38jkECxmHgCJKrQ+qtSfKcs7yK8Lp+dHTeMRXpJr3YoFeRTUiCkf1KKd1mYB+Zyw
         81W5PTQtMw8TY+Eemc2yq3lK1ee9Uas9X3mmoSdzmAjJcJ9/6Ob5iAfaGSh/Mb81VMe/
         KNnZYj1uVy/UhdawY2yesrxBSXgl4YCceGt/+a8hog53gogHFkbxkmXCspz0lXJpuL+k
         K+TfWmNshj6P+dGivLRSJgzO+lynp5hDexPzC1mqkpAPJXoFivDaSOy+1glMujlsQs8S
         9oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJJw6aC2zrJqZeFVWgJP7Dr4v9Y0eA3RoR5pHTOrcqI=;
        b=jNakLzEI61JQY9Zc7WusU2V7FDtb8kbDUvxnvl+c+Xnhj1hFsTGhySgSXwKXEXnkhV
         ro+wElTkQoKusLACctfgWos7ALCu3KkUXQbEFNCp9peMd9WrDaOjhP9epzwQ3rb8JP5Q
         WmVUf8dnJYS8UsV1VuSMjt3hJ+dMZSbKkzaaCFeVsJ5Ly7lHZu/IDE7xa1oARC4STZgr
         FSfwkWj6MDrdOJ57QEwXuT5wEVn//RlmaTV6daW0BI+Ert7EQUGsZNayvAW6nXZFDv97
         P3t41p506vXBPkOyAyv+1Kkdjt3YPM2Oomija/gS+VEMG0kWra8OBHYZjaJ6Hzz1LV9o
         /buw==
X-Gm-Message-State: APjAAAWcdgLM1tgLHFfD3WcsSvWHE6lGQ4+7xb6hXBoTlAKkPN/3/BxN
        7TH7RybXvtrKrokI3yf1SvUmN5DklLuAwc+Qm6220A==
X-Google-Smtp-Source: APXvYqxK4vX+YhsfVfiEfzvya7UpMW8vcQyQqrPY3OflJIwIaRrwyirvvkzTJN1qbWq8qFZJSUmyPgfsgx3hjeJHh2Q=
X-Received: by 2002:ab0:2488:: with SMTP id i8mr13481086uan.104.1559905382439;
 Fri, 07 Jun 2019 04:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190604153446.22857-1-thierry.reding@gmail.com> <20190604153809.GA23360@ulmo>
In-Reply-To: <20190604153809.GA23360@ulmo>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jun 2019 13:02:26 +0200
Message-ID: <CAPDyKFotaOnCYzWGh35rGsH3EDCXFPn0iaK7cb3xKjccsTfKzA@mail.gmail.com>
Subject: Re: [PATCH] sdhci: tegra: Do not log error message on deferred probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 17:38, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Jun 04, 2019 at 05:34:46PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Recent changes have made it much more probably that clocks are not
>
> Ugh... s/probably/probable/. Adrian, Ulf, do you want me to resend just
> for that if there are no further comments, or could you ammend that when
> applying?

No worries, I amended the changelog.

>
> Thierry
>
> > available yet when the SDHCI driver is first probed. However, that
> > is a situation that the driver can cope with just fine.
> >
> > To avoid confusion, don't output an error when this happens.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index 10d7aaf68bab..8a6a51bc038b 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -1550,8 +1550,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
> >
> >       clk = devm_clk_get(mmc_dev(host->mmc), NULL);
> >       if (IS_ERR(clk)) {
> > -             dev_err(mmc_dev(host->mmc), "clk err\n");
> >               rc = PTR_ERR(clk);
> > +
> > +             if (rc != -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "failed to get clock: %d\n", rc);
> > +
> >               goto err_clk_get;
> >       }
> >       clk_prepare_enable(clk);
> > --
> > 2.21.0
> >
