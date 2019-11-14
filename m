Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E86FB28D
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfKMO2S (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 09:28:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44476 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMO2S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 09:28:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id z188so2101548lfa.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4Br6s5tJ4L1zVkGHFm9nI2kU0+XpkWE4+fr2OAuoLA=;
        b=g3xvfdpeL4WhflkdqvFIf0sp3bsmmDqyBmGTTvSd0WbexD/iYz/QRxWLCrSoV8uBm6
         MxLvUlgSwN9+pcc6arb/YCpcd2uIyR+LP0ImjhPQPHzrSSoxJEnV4Aqf3mMHORn7efd8
         UrObo3Znzj5KBNFJTLnTgqPX07wzEKj9Z/VdEHs8Qm76QF0/xsRRlJ5grWrXvnLGVQ8E
         urh4n2r5oDH2qPXJz5Ccr8xQGIB5Kn8+G63mxytvx4DCeNKqx3a5iH1NvfpeOsIa66Gq
         UnTdSdSsapDwtmVjlhpp9EcTB2wWYomumBMX2ckJuDb4IbG+LZXFJzIfCoNtbFSr3ngO
         Yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Br6s5tJ4L1zVkGHFm9nI2kU0+XpkWE4+fr2OAuoLA=;
        b=hgFv9AlJqgT37gjadJFseq30u7L0HjOjZuIG86qjZ1Qt6kO4z+fzbGNBWXi2igx+cw
         jXm1wtDW5p+stnl4WuH4bG6nkSdsZfhqKVN7HBsNHJqfvTSTqRHQrG4/kpLsZGVBYFJp
         4C1H3EiyBV4iPGGuippV1vhiSMZ0JnL8C3QR8V65NkObbKrp3UEHSTPUJP7TTO/ri2nT
         d2rxazezLN+guv7h9yxMBYdNzaHSRy5BVf/61RtNhUThKkuydbWcax9pIKSmw6a8jIZP
         6Gldx4135SiBrMOXrc/z88kR+WYspfNTD7W6qoA//U/SGf1vKdPMxuJB+vRDhqSQPcz5
         ZC6w==
X-Gm-Message-State: APjAAAU/N7qMSP6tynP/s+aCULZkJG5LKxfai1NjY5xC+E210lhpEv5X
        FsHjob4TS4RtfRLc7Hi9zAFlcNheQWVzS4AAULKwcA==
X-Google-Smtp-Source: APXvYqy3NtMfniXtu2zud+Kl2BXXUcMjxJFOjULwGGbFTpijwYWIw97dIEANaBIleld3reEDnxzEZB6WWUWhGfFzOD4=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr2916588lfp.5.1573655296620;
 Wed, 13 Nov 2019 06:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 15:28:05 +0100
Message-ID: <CACRpkdZH1e856Rnoy_rwHuM2nyMDwCiXLvxOV2CJ0arXaTwj0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@denx.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 8, 2019 at 5:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
