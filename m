Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8119FB142
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 14:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMNYm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 08:24:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34694 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMNYm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 08:24:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id y186so1967755lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQo/splhUGv9XSw+8c37KzMY1kcM0qsjSZS8+fTXlnY=;
        b=YuZmtIb4LvusfIFt5PoAHeeujiVoF8Ldptn3dd5cjJawoDdzoUxMIMZtvujA2uYgWT
         0d+IahXjLhwTY238iQKTgr+SZ6tp8WRerCIg8PbT68bOZbDdQ+6uPM/Cw7lT//H6AlJY
         YH7a2c4ZIuy5uYe5jeLUIq5qdorAGyfSvAU7VOrHsOnALDt/3z09g5j097HFsLaedU7q
         0Ra5Vk3Ks+FmME35qTjr8SoaRzHAaVtQT8rCyWeaV3xiw5xVkqK30LwL2EO4V7kUNRF4
         Z7Al2qFfL9aU9esnLRc6vTGLvZgU9d+QElqmlg9ziVfAqJCVN0lpHEGUBgsvW79zZcis
         Gi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQo/splhUGv9XSw+8c37KzMY1kcM0qsjSZS8+fTXlnY=;
        b=f97vH1/ymqMXm3o/zc1jdA8Zf0fqPtQjup+yTsyuUZOIhAmpgWYZUJk7Q/DlrZr1z/
         A/vMtrFRYfdB+tp/WqpnEhxtBjE50HRqL0xy/K5DJCqynzhnc+lrUzEjIsYztdWPM1PC
         8pkk/iwMeF1EzRwlsTxLZ9IYr6clRMwaEeadM0/mH96mwHVa9vhwcBHJIdV1ePNABhbQ
         BoZcQgiCZUWl1qTQcykj39n/rAoxvqZohQSonqPYQpP8JT1sUnRDVEQvoTwfUf386Vd6
         4MvPsuHdzvpolq4/PCMHHzZJi5UqF/C1WNOkvqo7vLu/pWCxSugZefQzRsWghYjB0KF7
         +bRw==
X-Gm-Message-State: APjAAAWYjbiRuXgXVRJYLISrqyQJeRBHbFTMVeY0UL9jRF1x3bmJwYsC
        KHiv/kxos7zeSTJWjj3NpgotYgCj2d6lm2nCqTeAjQ==
X-Google-Smtp-Source: APXvYqx2WrB+YBqtNKpqKOlKtR1VDhJUWFftKmthD7IevKwMwOuLXKtvmD0wiAB1j7jKkZaJjG40omA9GmjrLHMb5+8=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr1383965lfg.133.1573651478899;
 Wed, 13 Nov 2019 05:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20191113075335.31775-1-linus.walleij@linaro.org> <20191113075335.31775-4-linus.walleij@linaro.org>
In-Reply-To: <20191113075335.31775-4-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 14:24:27 +0100
Message-ID: <CACRpkdZLiy4BSh1JYtQj0HjKk3=qdyKoj9tQv4HrthDi=4e-Bg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: mmci: Proper PIO residue handling
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 13, 2019 at 8:53 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> +               /* Pack the residue into a 32bit word */
> +               for (i = 0; i < host->pio_write_residue_sz; i++) {
> +                       val |= host->pio_write_residue[i];
> +                       val <<= 8;
> +               }
> +               /* Top up with new data */
> +               for (i = 0; i < fill; i++) {
> +                       val |= *ptr;
> +                       val <<= 8;
> +                       ptr++;
> +                       remain--;
> +               }

I'm worried that I might have gotten this wrong.

iowrite32_rep() reads the data little-endian (native endianness)
from memory does it not?

Bytes  [0 1 2 3] end up in the FIFO like [3 2 1 0].

So it will pack the first byte into the lowest 8 bits, second byte into
bits 8-15 etc.

So I should rewrite all the loops like this:

for (i = 0; i < host->pio_write_residue_sz; i++) {
        val |= (host->pio_write_residue[i] << 24);
        val >>= 8;
}

So I shift the value down from the high bits instead of the
other way around.

This also gives a pretty plausible hint att what might be wrong with the
DMA in non-divisible by 4.

As suggested by Stephan in another context, I will try to set up my
own test rig for this.

Yours,
Linus Walleij
