Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C793427C
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFDJAo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 05:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfFDJAo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Jun 2019 05:00:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0106B2404B;
        Tue,  4 Jun 2019 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559638843;
        bh=yLF/5A0Yt9mZ3x/1aXHAcLHej2ocHYBWAz21St3a8cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMPkntsZuOQOTATf2QcQlpT6noEdpw2iM9TaoGZwwXEfEH4Q4a71EjkYhH4vafCeU
         f4aUKUM3TzE4b4m9fTqCCJ1KYrUfQ5qY2r3jbB9loxrFAjYnyvp/KLpN08m4pWY3i0
         LwlvTdaXx+5QVpJTcO5Am5KePDpEOhNS3KcXscqI=
Date:   Tue, 4 Jun 2019 11:00:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
Message-ID: <20190604090041.GB2855@kroah.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com>
 <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
 <CAMuHMdWHnyTWMToXU_DSezwYs_Lkxj+v0BC8PKXHZgX=e1N3ww@mail.gmail.com>
 <b6e67d32-6092-4bdf-312d-7241094a9248@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e67d32-6092-4bdf-312d-7241094a9248@baylibre.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 04, 2019 at 10:52:51AM +0200, Neil Armstrong wrote:
> Hi,
> 
> 
> On 04/06/2019 10:36, Geert Uytterhoeven wrote:
> > Hi Ulf, Neil,
> > 
> > On Tue, May 28, 2019 at 10:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>> Update the SPDX Licence identifier for the Amlogic MMC drivers.
> >>>
> >>> Neil Armstrong (2):
> >>>   mmc: meson-gx-mmc: update with SPDX Licence identifier
> >>>   mmc: meson-mx-sdio: update with SPDX Licence identifier
> >>>
> >>>  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
> >>>  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
> >>>  2 files changed, 2 insertions(+), 19 deletions(-)
> >>
> >> Applied for next, thanks!
> > 
> > Please note this conflicts with commit 2874c5fd28426836 ("treewide:
> > Replace GPLv2 boilerplate/reference with SPDX - rule 152") upstream,
> > which added (different) tags.
> 
> This happens when we are not CCed with such changes.

No one was cc:ed on such huge changes.  The merge conflicts are trivial
to work out, this should not be an issue.

thanks,

greg k-h
