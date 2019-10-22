Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD46DFDAA
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 08:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfJVGUc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 02:20:32 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32952 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfJVGUc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2019 02:20:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id p13so10588747vso.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8DW9vd1TIycb0sU0HAtL003PnMYaqF/Te0E+k23Gg8=;
        b=TQ0Nb+kieO5MMn1rHD6P0qJMUfJ6iTIbZ2TVn3pGuctKRPEgEIYZkA6rJfGg9vLqw3
         YPeqXraDyVEV3lnJm4Uv1UxZ6w+aYr2pnrKj85XP+0Y7oSWtjA2Ou1TAzgy/Djlo5alq
         Muj7WQ+1yc54PPSWjfqEnSU9kVTSE2HWAhQzsf5jjE2VXq7Na+o+8oIBtWCWQJc8pVck
         FaCDI8y3Vk9DJzCHAH5tn+4Ka8z7AjGZg3McnSAOCJFESVqW/BZMzgQpBdT7/3t6+TNT
         lNKRqNvDbu9oQjPv2DnHXnDA7eVOW6MKCWZvOVz/i+WlGgN/Xe6TL5XWZWUvzV2X1obN
         QmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8DW9vd1TIycb0sU0HAtL003PnMYaqF/Te0E+k23Gg8=;
        b=OGAMwGa9kaRaUsXny/ylxonDgF2JGbQCXtBjK4//+t1FNaDTeDuRsg0TQDGjtm3pyy
         cuGs4+C6c6RgbgiDZZrTXu6mbOoduYXWaOZ3WJr206iVVCPPy1Ft4A3f9xw7tWR1Zz5+
         /Gkceb2gbnb3fWWA+4DLtZLKouV0KigS0QdbwWIbF8Cf4QvYZW6zTNxs2FcNvlj63jsX
         Avi1oDEVyxj8D/WsV4LI885PwFGnXAp0Tel29XUCeVtrWqrsh47z/cbNeUM3MnFONT+B
         68SxB7I25CuPQKF5dijXyM3kOQgid8MCrWm1jpPMzCqrgFsU4M6jTpypp02UhYCzaqE4
         mFzQ==
X-Gm-Message-State: APjAAAUR9bv2lwJJrGdMNQyDP/vYBeCtXpHuKl27ZG4+SOsWqT5xyY6l
        ZRGUClFuBSJFmkpiNjtcqVPhdBMaQUm6ysG7fMR2Zw==
X-Google-Smtp-Source: APXvYqzkYXuPseyXcdejvdvVSZXrEV06mZj0Op9CmRCQocYg4WimxvN1pSQnH8nJ/I9kGzCrw1RMyltd+I7tD0ELvMo=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr918147vsl.34.1571725230784;
 Mon, 21 Oct 2019 23:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-2-ulf.hansson@linaro.org>
 <CAD=FV=Wh3bnvNu-_1cXf1xT44-EwomoZEWDt88PZzhUVCn9PcQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wh3bnvNu-_1cXf1xT44-EwomoZEWDt88PZzhUVCn9PcQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Oct 2019 08:19:53 +0200
Message-ID: <CAPDyKFo58zdN5A18kY9tieFspC_dEPqomAE_FfC+NhpcL7LC9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
To:     Doug Anderson <dianders@chromium.org>
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

On Tue, 22 Oct 2019 at 00:13, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Oct 17, 2019 at 6:57 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
> > scanning only once for non-removable cards. Therefore, it's also not
> > possible that we can have bus attached, when we are scanning non-removable
> > cards. For this reason, let' drop the check for mmc_card_is_removable() as
> > it's redundant.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/core.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 221127324709..6f8342702c73 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
> >
> >         mmc_bus_get(host);
> >
> > -       /*
> > -        * if there is a _removable_ card registered, check whether it is
> > -        * still present
> > -        */
> > -       if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
> > +       /* Verify a registered card to be functional, else remove it. */
> > +       if (host->bus_ops && !host->bus_dead)
> >                 host->bus_ops->detect(host);
>
> At first I thought this was a bit more of a change than your
> description makes it sound like.  Specifically it seemed like
> non-removable cards used to never call host->bus_ops->detect() here
> (even during the first call to mmc_rescan) but now they would call it
> the first time through.
>
> ...so I put in a bunch of printouts.  It appears that the first time
> through mmc_rescan() host->bus_ops is NULL.
>
> ...ah, and this is what that sentence in your description means about
> having a bus attached.  Now I get it!  :-)
>
> ...so, right, this looks fine.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for testing and reviewing! Let me amend the changelog a bit, to
try to clarify that the host->bus_ops is NULL.

Additionally, I think this one should be tagged for stable, but let's
see what happens with patch 2/2 first.

Kind regards
Uffe
