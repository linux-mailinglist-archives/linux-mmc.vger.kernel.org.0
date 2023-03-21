Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE486C32DD
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Mar 2023 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCUN3J (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Mar 2023 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCUN3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2023 09:29:09 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3932500
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2023 06:28:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l16so7503941ybe.6
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679405333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T8IHUW0jzANzQv9QNlwvT0rXUx7xha0g1Bpyg1M+irU=;
        b=X1vKY07AWODDBD02IgmyrUA9QOO/4kzkmb/owSjHmTpVzHypfmk5i5v3smUp1h0VL4
         i/CV9OBOog9xrtbzhNZClJ88IdQm/oO+nKWOu4RGhH+dSxTJCnvwYlErKAMCwTKzcB89
         o9hf8gqc+Xmsd4jqZEVYGz2CnwrQHwwQavaSGbLiNP592DwS92pDfsDe/OnU9RBY77cT
         WSFrAEYQI5xJzzBEggVntqVEpUILXcAqkzeaAvgZvQvDGMsioafSF6Qa7BIUGgwRmC9V
         rxKa7j4pLKkVxDYx5KSsHN79IJz0L8rBVtaqkbxoxZXssk/Zlw+mH6hAdlx+gqMApPW4
         gZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679405333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8IHUW0jzANzQv9QNlwvT0rXUx7xha0g1Bpyg1M+irU=;
        b=jaTYlyAdbu61MNUBezSq9/jTzso/WyT4zXA5KFiuGt15fzck7OQsIYaS/cdAKvh3+u
         F9frsghiMlqQ3XfymZE0J2dmEMQaajuCGvANVN2cyDLGo+HIGZRTczg81zdspemucm+o
         MlLfQLi3ZV/WEJQ0docCQfauY3b+R6ZRIqVn5uum+hm5A9jDMhBkDSk9D/W4y86CwJGL
         7BGG7B9BbOELQbCDrwC2bczSXvOJCYYigosspAalDPiTbgFsGqBLYoGs6NDICOp1H6kE
         lbNmw10N5ZDSS11Pot3nBmznLTlZg9gSoLARxiB1aRZL6QV5xYJ0ZI678RJ69DMZlZkp
         88mA==
X-Gm-Message-State: AAQBX9eRImdocgZCMW6grSesK6BgQ2JHgaBncpi7gdejA9AKn1f9XHbU
        OLEyORklkbH2L5XVXoIrXrKCoFul0IdEqpr//Xt8/g==
X-Google-Smtp-Source: AKy350YU4hQjSGCJH0Y8ETmUXn7sueulPmLtjCK+zP0Jt7J9GJOX5hVhcG/5p92KOlB6AnfKwlfl3Qv5LdC3jKlaCGw=
X-Received: by 2002:a05:6902:120c:b0:b6e:b924:b96f with SMTP id
 s12-20020a056902120c00b00b6eb924b96fmr1581220ybu.3.1679405333536; Tue, 21 Mar
 2023 06:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <ZBNIg8+rOdFKcsS8@infradead.org> <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
 <ZBf8dZm1FZIusMls@infradead.org> <CAPDyKFogTyf30X+3JGeqf+yER_OLQ8JwXy6oEF3Rn78KzLSDxw@mail.gmail.com>
 <ZBmlB2K3KMt7Apv5@infradead.org>
In-Reply-To: <ZBmlB2K3KMt7Apv5@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Mar 2023 14:28:17 +0100
Message-ID: <CAPDyKFpV9BhsFYKajWCibUD0bQ4LFEn2J1LqF8M5Qxd16z3j0A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Mar 2023 at 13:37, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 20, 2023 at 04:24:36PM +0100, Ulf Hansson wrote:
> > > Neither to ATA or SCSI, but applications and file systems always very
> > > much expected it, so withou it storage devices would be considered
> > > fault.  Only NVMe actually finally made it part of the standard.
> >
> > Even if the standard doesn't say, it's perfectly possible that the
> > storage device implements it.
>
> That's exactly what I'm saying above.
>
> > > But these are completely separate issue.  Torn writes are completely
> > > unrelated to cache flushes.  You can indeed work around torn writes
> > > by checksums, but not the lack of cache flushes or vice versa.
> >
> > It's not a separate issue for eMMC. Please read the complete commit
> > message for further clarifications in this regard.
>
> The commit message claims that checksums replace cache flushes.  Which
> is dangerously wrong.  So please don't refer me to it again - this
> dangerously incorrect commit message is wht alerted me to reply to the
> patch.

That was not the intent, but rather to state that REQ_FUA isn't the
only thing a filesystem can rely on, there are other things too. If
it's striving towards being more tolerant to sudden power failures, I
mean.

Anyway, thanks for your advice, I will drop these parts from the
commit message to make sure it doesn't cause confusion.

>
> > > > However, the issue has been raised that reliable write is not
> > > > needed to provide sufficient assurance of data integrity, and that
> > > > in fact, cache flush can be used instead and perform better.
> > >
> > > It does not.
> >
> > Can you please elaborate on this?
>
> Flushing caches does not replace the invariant of not tearing subsector
> writes.  And if you need to use reliable writes for (some) devices to
> not tear sectors, no amount of cache flushing is going to paper over
> the problem.

Of course, then I get your point!

I think the confusing part here is that the internals of the eMMC
treats a "reliable write" as a cache flush too. At least this is the
case for earlier eMMC devices, where the write-cache couldn't be
explicitly controlled by the host.

Kind regards
Uffe
