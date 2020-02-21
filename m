Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366D41679C1
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Feb 2020 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBUJtA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 Feb 2020 04:49:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40282 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgBUJtA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2020 04:49:00 -0500
Received: by mail-vs1-f68.google.com with SMTP id c18so827420vsq.7
        for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2020 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiubFi99EPYJ/n2rj3yTrsNaDIZ6xoOQx9Jr6SvpoR4=;
        b=VDGmJFutt04VedpvKWAZ6kMFeFwm6k4hIHn0h4jsA5Ke3Nr81Ifna4QyMk/xMZNqHu
         9JJVbtDerM3lWcLd6Zfusk1fq9Zt4pLQg16o4mE3ATox5uakBQS/gK6ci3/GuoyErE7A
         dmfanSLS9WV8TpbC8JZp44r11OLIk444gHgv30w1F7oCtBUisMLTXObrbTcX0znv7V4r
         g7YuneHNVRkw1fIlPZXx8sY6DVWKEjOytK8d4TLDZcXOBjG0cSbxdQCsmOJrzJiEgrvx
         PSxYw3OAYUrlbKnHEtDgRjcqoTKsI1FNXxUQQ0Ye8NFdA2t44jpoOx/a7KTeM8ilMjr9
         AbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiubFi99EPYJ/n2rj3yTrsNaDIZ6xoOQx9Jr6SvpoR4=;
        b=Y0UUz9UpPl2jPqEIcH1RZlnwYY52e4/57H6x0QnCFSZcA29PzKDfF6jVjMW25ARRdO
         KBu4Wy8x8VLzKOFnC1wkyePdVaoNYm4He35koymMciktt76m1bmPJ6hs8rpSUm9N/ImO
         gQEjWxjU9T/7crWucwJ8P0sifT2sNn7Bv1PWeWrG8f9EDKNIEUKU42PwWnfqIx4L55M+
         pYhGVXYrnm9z1ykapUh9sidHOE/kbrhN/fo5ljYMluFkHq4QllXSPHmHLS2YJJGqflhV
         B+MNjhIYrxTVgswD8t0XLRmGFf90N6/lsLOza2ZiA8K7FTiIxnEkvAQ5NfPBcHWDzwZL
         CLpw==
X-Gm-Message-State: APjAAAWf7gS5l0wYUfZm/lu+NVeKn505mtQ327vrR73ttT9Z+L9XbDen
        XKqcY4Cy2O72pEvgLXaSOhD2e/Dhe4ary/Dq9mwSZw==
X-Google-Smtp-Source: APXvYqxIRRKXnARX9u6btKQ3O9gJaec7WIe9eCcj9XZJ870sXHNxs5I8Z8nwuzduLJgoO7/z/UNDEdOwwm1N++0cxlU=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr19891897vsb.200.1582278539428;
 Fri, 21 Feb 2020 01:48:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com> <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
In-Reply-To: <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Feb 2020 10:48:23 +0100
Message-ID: <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Feb 2020 at 18:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> >
> > Try to restore the value for the cache flush timeout, by updating the
> > define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".
>
> I have increased the timeout to 10 minutes but it did not help.
> Same error found.
> [  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
> [  608.684964] mmc1: cache flush error -110
> [  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>
> OTOH, What best i could do for my own experiment to revert all three patches and
> now the reported error gone and device mount successfully [1].
>
> List of patches reverted,
>   mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
>   mmc: block: Use generic_cmd6_time when modifying
>     INAND_CMD38_ARG_EXT_CSD
>   mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
>
> [1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346
>
> - Naresh

Thanks for testing!

This sounds a bit weird, I must say. Also, while looking into the
logs, it seems like you are comparing a v5.5 kernel with v5.6-rc2, but
maybe I didn't read the logs carefully enough.

 In any case, I am looking into creating a debug patch so we can
narrow down the problem a bit further.

Kind regards
Uffe
