Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3018AA2288
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfH2RkC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 13:40:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42874 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfH2RkB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 13:40:01 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so6602033iod.9
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fy1EONJYFzvA6a2F757/vnVFBYdEDoPHNwTUWgsvybk=;
        b=Z1cP/5ezzJ90NFU0M1U6zbk+KT4PjiIv172TBGDPGRStchob2kMIXvTBkcXqclue2c
         Pshe76ei8DZxZd/hbugynKc/kZpkF6mSXg2hkUlUffI8nfmY6z5Dzime1bmwMJyrMckU
         dAcjYiSXvN2cFOLrsXI5NPL7Vx0T7FS0VHjQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fy1EONJYFzvA6a2F757/vnVFBYdEDoPHNwTUWgsvybk=;
        b=KoDD7/NnyEKa4k7TwJfzOp3UlbHHuXQ6LqzSVmtgN1e4ww29ep/c3PGTbj73/3WgeP
         Yc1jAfjQ+vYG1p5dHtf8sCl6z/PWAYZ1fNzl8aCsxwOwCc8V+V5b2Hh52AAmUf1H6NDd
         zDaIgS1K1Wv6tXN2WX80azzEySLzplX1wxGSFtwxSJ/xwObUfRGfCpzdRD1/nhuk6KvU
         Dgs6SzEyo9P2jfSR9OLxvqhzvBZ7PPnzuVyyq0pD5ZTJMyjwC5CQ5lfw9uB7HP+/YSWV
         0/q1LGtOtmJzdUug93miR7IfH1fEUnSwtlxU5XPqkKCjX/oOl+y2ugEKN25r0nNDcbl6
         vlCg==
X-Gm-Message-State: APjAAAU/X4Mg35x42a1O3VJwGc1mGYxPQHsKIsDOQ73TaM8rOqyQkJw9
        PHTOqUHahzWci/SPFHaoiUZDGBtTX7o=
X-Google-Smtp-Source: APXvYqyjkQX2/uHql43FoOmXp+FWN3AGQrcwG8RLn6awwk4ADzw/uEGPi1KOi1PiOX2AMHnOkCas6A==
X-Received: by 2002:a6b:640c:: with SMTP id t12mr1950490iog.123.1567100400756;
        Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id e19sm2192072iom.57.2019.08.29.10.40.00
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id j4so8501548iog.11
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 10:40:00 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr12308339iop.58.1567100399775;
 Thu, 29 Aug 2019 10:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com> <20190829171555.GD70797@google.com>
In-Reply-To: <20190829171555.GD70797@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Aug 2019 10:39:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Message-ID: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 29, 2019 at 10:16 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> > In one way, this change makes sense as it adopts the legacy behavior,
> > signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> >
> > However, there is at least one major concern I see with this approach.
> > That is, in the execution path for sdio_signal_irq() (or calling
> > wake_up_process() for the legacy path), we may end up invoking the
> > SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> > to consume the SDIO IRQ.
> >
> > The problem with this is, that the corresponding SDIO func driver may
> > not have been system resumed, when the ->irq_handler() callback is
> > invoked.
>
> While debugging the the problem with btmrvl I found that this is
> already the case without the patch, just not during resume, but when
> suspending. The func driver suspends before the SDIO bus and
> interrupts can keep coming in. These are processed while the func
> driver is suspended, until the SDIO core starts dropping the
> interrupts.
>
> And I think it is also already true at resume time: mmc_sdio_resume()
> re-enables SDIO IRQs and disables dropping them.

I would also note that this matches the design of the normal system
suspend/resume functions.  Interrupts continue to be enabled even
after the "suspend" call is made for a device.  Presumably this is so
that the suspend function can make use of interrupts even if there is
no other reason.  If it's important for a device to stop getting
interrupts after the "suspend" function is called then it's up to that
device to re-configure the device to stop giving interrupts.

-Doug
