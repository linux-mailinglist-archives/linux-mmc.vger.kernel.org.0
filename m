Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB12C1B9
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfE1Ix2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 04:53:28 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38874 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfE1Ix1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 04:53:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id x184so12298977vsb.5
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63rNflCdSI9s1lypjb9kjGuIPUPYyEDW7V3KDJZf4ho=;
        b=hhZ7Ugx8NIA5gGvOhA440AmvtVLs8x74arAvCWzkmIisOX+1tFrNHlQvZrZ4qaspo8
         fMpDnmSprEB9MwIMSTZPRMpZ4dKAeW+HQX6ryQVRBt6+Xvovoq0jldnv0Jksc5Raad/Y
         3Jcp85rjCvKkXHQn2oluvtELFTeTijuBgiLBFvwo7c+S6TjskQQnIUgA4082jjngEI1C
         OVPdhrgfVyYrw1peAtk5DnfFulx7ieluR4jL3Mi7WvUCZ6r48XEHbkLjc8lbl9DAdzJc
         sCsOPh2VGVPYrwj3ICxFPJTrk3fxcCi87nfHPCpgHYObCW1vXRINgVNW+KNQIhvYKuVb
         0Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63rNflCdSI9s1lypjb9kjGuIPUPYyEDW7V3KDJZf4ho=;
        b=qEZh2bqm3qVGd0aBSwCypGtb10gu3WJ5wYPUIrmuTVkSkrYs06W+IPg7SKDWGQR6Tz
         ZKgpqshah5Z2d5fqZgYpWbheBSxcyb/kvcnHtRFhr1vSHZ3e9Rvzs87QReOo09+jQTwB
         jX/NA+FiL7fEV9QQ4Fh2p2uPjinYQDt+ZezWTdhgllnJjUm0XfQWzFFD3RwLjc9aCKza
         MKm1xzr+cCVPBjC0j3CtFuiZJY0NFx705E2r8z55CG+MHRPiUAc3/M/Nbf6hrHAriElV
         J1hA69+rdF1/DKnxEP0Wsa8C1NBGGezFzVROylQh7Iu3WcFll61IIvsu7j/pIWnFJRdl
         QIrQ==
X-Gm-Message-State: APjAAAWKZXt8YPX+P3KOYNR2Db3NQlG9L/GDq1NgXhhLK7YSKu69BGKP
        lzIJyy5xD7XeUBQvCj4LIQrbwdx7I2dLckdBn0EsKw==
X-Google-Smtp-Source: APXvYqy8Gwi8FdbaqibNI40miRadKGRT4k+l+pInetAz3+qmOqETE/H2IYF4/nOcOLypwZKbIuTILXTiP+gRsOJZaCs=
X-Received: by 2002:a67:3046:: with SMTP id w67mr54793522vsw.165.1559033606406;
 Tue, 28 May 2019 01:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190515093512.GD3409@mwanda> <CAPDyKFpm9dB55aCUQkDHgyfcJdniNG9jCbdQ4ezYgQ=L8Rxfhw@mail.gmail.com>
 <20190522133709.GP30938@ulmo> <f8b4cc7c-6f12-21df-e76c-59699ff647b0@nvidia.com>
In-Reply-To: <f8b4cc7c-6f12-21df-e76c-59699ff647b0@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:52:50 +0200
Message-ID: <CAPDyKFpB+gEaS0J_Ro3-ovvLwYpCXG6OPK4dspsp4r_bfow8uA@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: Fix a warning message
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 May 2019 at 18:22, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> On 5/22/19 6:37 AM, Thierry Reding wrote:
> > On Wed, May 15, 2019 at 01:46:40PM +0200, Ulf Hansson wrote:
> >> On Wed, 15 May 2019 at 11:35, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >>> The WARN_ON() macro takes a condition, not a warning message.  I've
> >>> changed this to use WARN(1, "msg...
> >>>
> >>> Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
> >>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>> ---
> >>>   drivers/mmc/host/sdhci-tegra.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> >>> index f608417ae967..10d7aaf68bab 100644
> >>> --- a/drivers/mmc/host/sdhci-tegra.c
> >>> +++ b/drivers/mmc/host/sdhci-tegra.c
> >>> @@ -865,7 +865,7 @@ static void tegra_sdhci_tap_correction(struct sdhci_host *host, u8 thd_up,
> >>>          }
> >>>
> >>>          if (!first_fail) {
> >>> -               WARN_ON("no edge detected, continue with hw tuned delay.\n");
> >>> +               WARN(1, "no edge detected, continue with hw tuned delay.\n");
> >> Not sure why this is a WARN*() in the first place.
> >>
> >> Seems like a dev_warn() or possibly a dev_warn_once() should be used instead.
> > I think this was on purpose in order to increase the likelihood of this
> > getting reported. Sowjanya knows the details much better, but I think
> > this is supposed to be very rare and really a problem with the tap
> > settings in device tree, which is something that we want to know and
> > fix.
> >
> > Let's see if Sowjanya can shed some light on this.
> >
> > Thierry
> >
> This warn can happen when no edge is detected and hw tuning results include
>
> all passing taps which is very unlikely. So, I believe WARN(1, msg)
> should be good to use.
>
> Sowjanya

Okay, so I have picked v1 instead, for fixes, thanks!

Kind regards
Uffe
