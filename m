Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7161067
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Jul 2019 13:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGFLUc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 6 Jul 2019 07:20:32 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:55336
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfGFLUc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 6 Jul 2019 07:20:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id BA9F73FE9A;
        Sat,  6 Jul 2019 13:20:30 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dT9pNHnNbr_d; Sat,  6 Jul 2019 13:20:30 +0200 (CEST)
Received: from jerusalem (host105-54-dynamic.182-80-r.retail.telecomitalia.it [80.182.54.105])
        by sysam.it (Postfix) with ESMTPSA id 2CEEE3F114;
        Sat,  6 Jul 2019 13:20:30 +0200 (CEST)
Date:   Sat, 6 Jul 2019 13:20:29 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mmc: add Coldfire esdhc support
Message-ID: <20190706112028.GC6763@jerusalem>
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190617065807.GA17948@infradead.org>
 <20190619222236.GA18383@jerusalem>
 <a5427af4-079e-7e0a-487e-389969809cb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5427af4-079e-7e0a-487e-389969809cb5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, Jul 02, 2019 at 12:10:54PM +0300, Adrian Hunter wrote:
> On 20/06/19 1:22 AM, Angelo Dureghello wrote:
> > Hi Christoph,
> > 
> > On Sun, Jun 16, 2019 at 11:58:07PM -0700, Christoph Hellwig wrote:
> >> On Sun, Jun 16, 2019 at 10:48:21PM +0200, Angelo Dureghello wrote:
> >>> This driver has been developed as a separate module starting
> >>> from the similar sdhci-esdhc-fls.c.
> >>> Separation has been mainly driven from change in endianness.
> >>
> >> Can't we have a way to define the endianess at build or even runtime?
> >> We have plenty of that elsewhere in the kernel.
> > 
> > well, the base sdhci layer wants to access byte-size fields of the
> > esdhc controller registers.
> > But this same Freescale esdhc controller may be found in 2
> > flavors, big-endian or little-endian organized.
> > So in this driver i am actually correcting byte-addresses to
> > access the wanted byte-field in the big-endian hw controller.
> > 
> > So this is a bit different from a be-le endian swap of a
> > long or a short that the kernel is organized to do..
> 
> Did you consider just using different sdhci_ops so that you could support
> different sdhci I/O accessors?

Initially i tried to modify the IMX/Vybrid (arm) driver. But was stopped from
several points, trying to remember now, 

- the I/O accessors was a const struct, but this of course is not a big 
  issue,
- here and there bitfields and positions of the ColdFire controller
  registers, compared to the arm versions, are different, so controller hw
  is not exactly the same,
- on ColdFire controller and some behaviors and errata are different,
- dma endiannes not hw-configurable,
- ColdFire has max clock limitations, a bit different clock init.

Finally, since there is already a common library (shdci.c) i decided to go
as a separate driver, instead of filling the driver of "if (coldfire)" also 
mainly for the following reasons:

1) separated ColdFire driver has a quite small amount of code, simple to
understand.
2) having drivers used by multiple architectures, it add risks, each time
i perform a change, i can test it only on ColdFire, and can break
the driver for the other architectures (i see this not rarely happening for
multiple-arch used drivers).

So let me know if the way chosen can be ok. Otherwise i will roll back 
trying to modify the iMX/Vybrid driver, likely adding a lot of "if (coldfire)"
complicating it quite a lot.

Regards,
Angelo
