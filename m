Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFBC9C1C
	for <lists+linux-mmc@lfdr.de>; Thu,  3 Oct 2019 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfJCKXG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 3 Oct 2019 06:23:06 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42915 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCKXG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2019 06:23:06 -0400
Received: by mail-vs1-f67.google.com with SMTP id m22so1302125vsl.9
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2019 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNddJNMIOpbW8jeVwMcshKV+W9MzR9TwWa+cuOg9jZI=;
        b=Zx+XW6+tC2GOyRbSXn2Aam/uHrF9c9w444BH69PhLekb2E5nfqG4yXzPAwnHpxeQF+
         8WK7J8vZPiLR6qzUH8ZmCB6cTC+kpK5UqAw8ZIw8bYnxVCvscYv8h6yxa1XZRxztjYQE
         Yd/CKkaTVQZ0mZ9jNR6MiDu1zjVOG+Cn7BPIFRdCtOFHCFLTLi3Nr6dVv+SVkwo2rpYp
         Ozidy2dFvFQK/028YGsenfE06UMDcJQWWwuLT8SCtTGkbM+oohFaqYGq2lLuoMpBPU2M
         rn5/xZOXD4dSNk316RXDuyea1UaHB7ryEbRZp8rSngHQwM7UF0kCC+D1bDk8QKGYtaCB
         byPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNddJNMIOpbW8jeVwMcshKV+W9MzR9TwWa+cuOg9jZI=;
        b=ngsloSa0rVylzUrBdgq0d8+plNOQ6sAqhlTFzwpJ5cChLGNn6ztBY6zDQJ3AcCHsFN
         oKeR//QIOyhEEYnxGT0HmH21NvrvyiVYd4BFtzva25iHAVvi9olH59+Rg7wQmsEV9k0v
         z9L6ksUOEH1EqNFuDegdb+lCzHnqJk3uJZM/8PziQsR9LQh4egLfCTqw0h49bOO3KKSj
         bn/sq2ncvsMtEiPrv5ZelzVyE/BANokmkXrVXYFBmH637qwrMkemyPbd7DV+3QahqUHI
         U8Nt+SDO2sTp+ZXoZK/LMD2k0eF8wFV9STa0thPWnFFUkUmZf+YHbr0Lr9sZlUAIMaw/
         7ZKQ==
X-Gm-Message-State: APjAAAXSHFvMhViDf9JHeg0JHzfSlqRH9z9yHn37SvuFC9yRElz7uDm8
        mcoz+DDP82W0Cqa7tKuIaLYVB8MwDbzDPD9tu/3vYw==
X-Google-Smtp-Source: APXvYqwGOv82o17s1OFODXyXNYaoQ5cVwzmO4TkjlcxRkgCMJ+CEoM+pR+PgRPBEdocyky4OF3S+yEmo+vnWR6uCxC4=
X-Received: by 2002:a67:fc5a:: with SMTP id p26mr4552680vsq.200.1570098184846;
 Thu, 03 Oct 2019 03:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190912210509.19816-1-mhei@heimpold.de> <MN2PR04MB6991CE61681D33F1F7E76ADAFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
 <CAPDyKFrae36rymcD-o9RELiWVTzMd-ccM2q1q-dO7GiWYaqw+w@mail.gmail.com> <MN2PR04MB69915A035B856C0038633F7AFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB69915A035B856C0038633F7AFC890@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:22:28 +0200
Message-ID: <CAPDyKFpZ8ASL4KhyzqGw+HYr1_8oh4xDU7LzBWz3c16=URK+8g@mail.gmail.com>
Subject: Re: [PATCH mmc-utils v2 0/5] Various fixes for mmc-utils
To:     Avri Altman <Avri.Altman@wdc.com>,
        "chris@printf.net" <chris@printf.net>
Cc:     Michael Heimpold <mhei@heimpold.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Sep 2019 at 16:06, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On Thu, 19 Sep 2019 at 11:41, Avri Altman <Avri.Altman@wdc.com> wrote:
> > >
> > > Ulf/Adrian,
> > >
> > > As Chris is less responsive in the past few years, We might want to
> > > follow the scsi ML practice with regard to the ufs driver:
> > > Add several reviewers while Martin is pulling the patches.
> >
> > This has been discussed earlier [1] and Chris also agreed that it seems like a
> > good idea.
> Then I would like to suggest myself as a reviewer [R].
> I hope that some more people would be interested to support this.
> Would you be able to pick mmc-utils patches?

Really great that you are willing to help!

No, I can't pick patches, as don't have the permission to push them to
the git tree. Only Chris can do that at this point.

We could create a group to share publish permissions to the git, but
it depending on what Chris feels about that.

Chris?

Kind regards
Uffe

>
> Thanks,
> Avri
>
> >
> > >
> > > It is working quite well since then.
> > >
> > > Is this something that you might consider?
> >
> > As said, it's been discussed. I think it boils down to that someone must
> > volunteer to help Chris. Then it's just a matter of formalizing this, set up git
> > push permissions and document the new ways of maintenance.
> >
> > Perhaps you would be interested to help out?
> >
> > [...]
> >
> > Kind regards
> > Uffe
> >
> > [1]
> > https://patchwork.kernel.org/patch/10709543/
