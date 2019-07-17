Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9176BCE2
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGQNUY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jul 2019 09:20:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35614 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQNUY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jul 2019 09:20:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id u124so16436917vsu.2
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jul 2019 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX/ofVqxjMm0lROBVX50PaKUAgG8XFIbRl7FQ1Pu8+M=;
        b=rmx0gmVKwuL2Xg2U+d28ZdelZx/ogsZBOpIc4oFz3/O6A69P4YDUzFy35dyDhVyWGK
         rTyqv3PgJbOycBPUq1UnP4PXRpa7oPOQlgCDXr0hVyBBi6F3lkMxXiob43ZAUuMy2kSx
         mO92iV5HuI0f5EwcOub1fEjpmIIGfm8dSBXbF78cm7cjEe6KmrQRD3L59SE9Ik7QicOz
         ZOMUX2xocVkaenS2f818W5UFmdIf/BQLInU2+OewhCjRWHrPYCptlqyWmZNyMxWqKyTL
         sKUNWFQhkay2lgAlGQ1FX/n/kRwJn/gVkJFj7zfZ23u6iI/+hWzSDG2x1eJNsgTJNQeO
         tMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX/ofVqxjMm0lROBVX50PaKUAgG8XFIbRl7FQ1Pu8+M=;
        b=tIbGlyZ4SzoZkUhjP3oEI2zTwjKGmsT4d+FFxgx/zWLFPLFD+Bmdp9b9Ap2e3JdsSD
         zLniUQSVLISohzvu1T1gk9ZUXDjTbgHxG+W1a6dkQ61RZmwB3/I29TQPBGg29GlLxS/3
         lDtqFk72Nks9v8lZESwc402gaS+qtju9sxK3755teC/p/spCLKiXJHblEKHjkWGIrsxg
         WPnZSGs1JIPRf6S95k85pPMgWtRN0SiOdAGSnq96Rpprh53SyPBjDpQSsqG2kgHDFulv
         Mm+t4W22peL366CEi5W8VBpgTt2Us94PaHu3BEpyEoz15eaLnYlBXf6wy+YjK8hwkeH0
         ZLow==
X-Gm-Message-State: APjAAAVJckWTc9QfDFfdL/twnpAkAvIsKnwjJMgrEV9lHqKiCoQkxA9r
        ZMo/uss9vF19TsOlbJWiapcgftCvCR5TRStpoHd2hg==
X-Google-Smtp-Source: APXvYqwQJE4UbE5Yv6dmbLWt7pANBVCR8u2C8s/vLGYYIYGzOT5Z0QTyyZ0y5q3/PgW8wTXvVMPxw0msAaNXDjRXCAg=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr23206305vsb.165.1563369622851;
 Wed, 17 Jul 2019 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164217.27297-1-ulf.hansson@linaro.org>
 <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com> <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
In-Reply-To: <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Jul 2019 15:19:46 +0200
Message-ID: <CAPDyKFq-o+JRqONbpr9eYX_O0c8pvKDhkrHdO35Yg19jej5F2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
To:     Jean Nicolas GRAUX <jean-nicolas.graux@st.com>,
        Ludovic BARRE <ludovic.barre@st.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 14:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 17 Jul 2019 at 12:16, Jean Nicolas GRAUX
> <jean-nicolas.graux@st.com> wrote:
> >
> > Hello Ulf, all,
> >
> > For testing purpose, I cherry-picked your patch on top of a 4.19.30 basis.
> > (I apologize as it's a bit old. I miss time to do a rebase on current
> > linux-next right now.)
>
> No worries about the old kernel, for this change, I think it should be
> suufient good as base.
>
> >
> > Unfortunately, I got a kernel crash applying it :(
>
> Huh.
>
> Is it crashing because it fails to mount the rootfs on the SD/MMC card?
>
> >
> > As you may know, ST sta1295/sta1385 SoC embeds the same pl08x variant
> > than one in U8500.
> > So It looks like double-checking again mmci status to make sure busy
> > flag is still set
> > just before proceeding for busy end is required in our case.
>
> Yeah, actually I have a u8500 on my desk now, so I will also test the
> patch to see what goes on. Didn't have the time to do it earlier.
>
> My guess is that, at the point when we received the IRQ for a command
> that has been sent, and then reading the MMCISTATUS register in
> mmci_irq(), the card has not yet started to signal busy on DAT1 and
> hence the busy status bit isn't set yet. This leads to that we will
> never enable the busy end mask, but just completing the request
> directly.
>
> Anyway, let me check and see if I can confirm it.

Problem confirmed.

Moreover, even before my changes it looks like the similar problem is
there. In other words, even if we re-read the status register a few
cycles later in mmci_cmd_irq() there is still a chance that we end up
to by-pass the busy detection, because the card haven't yet started to
signal busy. Just during boot of ux500, I found this to occur three
times, but luckily the card detection works anyway.

[...]

I am working on fix, let's see what I can come up with. Likely to be
posted tomorrow.

Kind regards
Uffe
