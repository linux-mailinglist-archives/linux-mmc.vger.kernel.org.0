Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C117AC0BC3
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Sep 2019 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfI0SuK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Sep 2019 14:50:10 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34354 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0SuK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2019 14:50:10 -0400
Received: by mail-vk1-f194.google.com with SMTP id d126so1444990vkb.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2019 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBZJx9mwfwKl/d1YIGsqXIQmYrQ0m8MFTpNwf6yagA8=;
        b=H5dEeRS9CP0jlYjImC6db5aNPKHty0p5YdWo3lugKh4Pm3xxuTRG24ERUjIcqA4E5b
         0/EItbxItxl9urEqAcfhdC9Gxdz8ADd8NAPx2x/sg0J5T0Pt0PNDSYjgy8DbbMjCM3MJ
         vLjyjqwCfGOmhAkYHDcW74kWilqiZIKjR5u+DKTVYcKgTvcyJ0HwVT3PkTLqEtnz7h2q
         2AuD/vYPdU2A1TXjqJdNeX3IypXUtfGOeq2PAmz6UvnEliGHnhnhwn3VBoYknS1o90Fo
         hcWNavv5mTmQ9Hsv75s6+/PZS91UY48ZayemO8AnHKsywI4CLdQ+N3NFFNRzALJ6AB5y
         +MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBZJx9mwfwKl/d1YIGsqXIQmYrQ0m8MFTpNwf6yagA8=;
        b=LsA1c11+rEz3t93Y1zRfgoylebZpHIj17QFo8j10arDb/vTzaSQiDHYv3bjEkJ/GLB
         vvIOZbSmgImWJS/Ps9ZUkwvqmiXhz29wYnpAlPgkybF67twbMB6NvrqD6Xgemk3ZfkPF
         dtP8Hw8v2YJJBAIY9tsVbYj77yAxFJ2kiVjVgWUpwt1bT8pCd2ch65SRsd19/nZQNHC3
         79JGI2BBB8K2pDJ8xN9r2Aom+7WiutyGMvHnL7NI73b2D0a6hyLi8Wg78DrlNRnhRtt2
         1/xhzF0UOOsiKY2sLA4wNXVvBVep24yv1+/Shqn8cN2XsaP2iHD/tHqEMtmOZDnWY+7O
         pwqA==
X-Gm-Message-State: APjAAAU9cxYnl6+r867fKhH6L2c0vi+V/mAHt20YU9ggJ5XGQkfnGDKg
        4mvzmMOQdsT2J3x9jcm+Bod6sasHrOzSKnOCOQuLIg==
X-Google-Smtp-Source: APXvYqzOU21WddncSc1IrWQHL6FdZMo/EgPppLvIw/h3P6j4sgxIB6VYfLntNv7P7g39dvDmRgnveUuUkEOhSIWpa5I=
X-Received: by 2002:a1f:da45:: with SMTP id r66mr5057255vkg.36.1569610208805;
 Fri, 27 Sep 2019 11:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568184581.git.benchuanggli@gmail.com> <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org> <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
 <20190923213925.GA19247@people.danlj.org>
In-Reply-To: <20190923213925.GA19247@people.danlj.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Sep 2019 20:49:31 +0200
Message-ID: <CAPDyKFqTtGAygYPQ-qJuBaU2YU8CU-OgZJyWSmAQYYtq5xnpvg@mail.gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Sep 2019 at 23:39, Michael K. Johnson <johnsonm@danlj.org> wrote:
>
> On Wed, Sep 18, 2019 at 02:07:51PM +0300, Adrian Hunter wrote:
> > On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > > I see that the first four patches made it into Linus's kernel
> > > yesterday. Is there any chance of this final patch that actually
> > > enables the hardware making it into another pull request still
> > > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > > addressing all the review comments?
> ...
> > > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>
> > >> Add support for the GL9750 and GL9755 chipsets.
> > >>
> > >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> > >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> > >> tuning flow for GL9750.
> > >
> >
> > It is OK by me:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Ulf,
>
> Sorry to be a bother... Is anything remaining for this work to make
> it into a second PR for 5.4 before the merge window closes?
>
> It would be really convenient for the microsd readers in
> current-generation thinkpads (for instance) to have hardware support out
> of the box without having to wait another kernel release cycle, if
> there's nothing otherwise remaining to change.  I confirmed that
> it currently applies cleanly on top of Linus's kernel.

I have applied this for fixes, so it will go in for 5.4, but perhaps I
need to defer my PR to after rc1 as I am still on the road.

Kind regards
Uffe
