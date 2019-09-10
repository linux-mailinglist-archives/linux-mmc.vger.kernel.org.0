Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC7AE28F
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfIJD1Y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 23:27:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36812 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbfIJD1X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 23:27:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so12243963lff.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ropqFminAsuYzLc+qA9K24nUNWnD7cn3AN/0FfpV44M=;
        b=auysCQzPijlKbJ8dj8RvUZmk6jgRVymv2glX5u2Ca08XLuwMRh+1OyCCZNBpXOpPXX
         LbbVNuA6VM+3y6KQE58M5Y6pnkcZssZo4yOra6Hobd8cT2oqx1nNnbIt9HXeBi5mgoqx
         i7oyVOpS9eASObqUbyci7/CyCeMy1qp0gEPnTPZdjO5iMgR5+Pmk3s3JFG08FDoYnEgV
         2lh+gs73JByv8yUfwrHoFZKTlCKTeLvETjUZ61b1IG27loNPtdmujlL+FQgNfAB/hqzM
         +nAHSxwnaKaiXQXaRXyfGOHI5V4b7ZvIAyT5CA8U+/IgLSCtEf1EexVlhG7OxL5zCxsc
         zXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ropqFminAsuYzLc+qA9K24nUNWnD7cn3AN/0FfpV44M=;
        b=ky+2zYh0OJHQDEIWTLbkBqABNGjCppOS9BFDcIkpTKvVN10dqqrwHj97riBzipeM7D
         BYlZsOtC0in65bMx0mDJ5+OCdc5fUUtYG81tDEeNZfoZbDcDMcrXzNsYDBk+G4G6TjhX
         YeNFWdtkFSLSc8yUyxIMcAsnubj5vI2FpUDFkbtj3HOYYa5ozCAB3542eKTSEQCJBm3l
         XSQJC8lCsZMUAs5waAgxMgZPGOvZPBzPn10LO8PM9tBj+Y6h4sAjJzKeyKD1SDCuT9Sb
         0E+8pEkDrX9OY4BO+3HeL7a8SytY51VUz0uAtobWWUQOjdMHn4wQqgTwmgG4ECmn6pTs
         5j9w==
X-Gm-Message-State: APjAAAXd6XPuoWnL3V62fauEMihB6fCFDcsQt4awNkxQLQxkNPYoz+oj
        H8LBMxlK5xE1XJAPoNjF+rDd/8a2Ej0sKz/KN//wKg==
X-Google-Smtp-Source: APXvYqypB9y/im+Z9qxmaZUuMkgXQGzTCs7vAzL0uU20Vdq5CFvQMJu0Kd+GW2/zmWzljJE618/x2qTXAZhWQCSOXPY=
X-Received: by 2002:ac2:4424:: with SMTP id w4mr18492565lfl.65.1568086041766;
 Mon, 09 Sep 2019 20:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com> <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
 <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
In-Reply-To: <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 10 Sep 2019 11:27:09 +0800
Message-ID: <CAMz4kuLLjDC_bLpen9qEsxEJTF5WWg9zsH_J-3Xp=Mj_Wss7Eg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 Sep 2019 at 20:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 9/09/19 3:16 PM, Baolin Wang wrote:
> > Hi Adrian,
> >
> > On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 6/09/19 6:52 AM, Baolin Wang wrote:
> >>> Now the MMC read/write stack will always wait for previous request is
> >>> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> >>> or queue a work to complete request, that will bring context switching
> >>> overhead, especially for high I/O per second rates, to affect the IO
> >>> performance.
> >>>
> >>> Thus this patch introduces virtual command queue interface, which is
> >>> similar with the hardware command queue engine's idea, that can remove
> >>> the context switching.
> >>
> >> CQHCI is a hardware interface for eMMC's that support command queuing.  What
> >> you are doing is a software issue queue, unrelated to CQHCI.  I think you
> >
> > Yes.
> >
> >> should avoid all reference to CQHCI i.e. call it something else.
> >
> > Since its process is similar with CQHCI and re-use the CQHCI's
> > interfaces, I called it virtual command queue. I am not sure what else
> > name is better, any thoughts? VCQHCI? Thanks.
>
> What about swq for software queue.  Maybe Ulf can suggest something?

Um, though changing to use swq, still need reuse command queue's
interfaces, like 'mq->use-cqe', 'host->cqe_depth' and cqe ops and so
on, looks a little weird for me. But if you all agree with this name,
then I am okay. Ulf, what do you suggest?

-- 
Baolin Wang
Best Regards
