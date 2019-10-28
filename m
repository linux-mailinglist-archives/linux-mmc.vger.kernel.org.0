Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E1E6E72
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2019 09:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfJ1Irp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Oct 2019 04:47:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:53273 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbfJ1Irp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Oct 2019 04:47:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9S8l1T2019620;
        Mon, 28 Oct 2019 03:47:02 -0500
Message-ID: <e68c5f8d73fbf1841531bf07eef0132d409e91b3.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Mon, 28 Oct 2019 19:47:01 +1100
In-Reply-To: <20191026063918.GA24015@infradead.org>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
         <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
         <20191015125105.GU25745@shell.armlinux.org.uk>
         <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
         <20191015131750.GV25745@shell.armlinux.org.uk>
         <87muds586t.fsf@mpe.ellerman.id.au>
         <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
         <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
         <20191023143159.GB25745@shell.armlinux.org.uk>
         <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
         <20191026063918.GA24015@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2019-10-25 at 23:39 -0700, Christoph Hellwig wrote:
> On Fri, Oct 25, 2019 at 05:28:45PM -0500, Rob Herring wrote:
> > This doesn't work?:
> > 
> >         if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev-
> > >of_node))
> >                 value |= ESDHC_DMA_SNOOP;
> >         else
> >                 value &= ~ESDHC_DMA_SNOOP;
> > 
> > While I said use the compatibles, using the kconfig symbol is
> > easier
> > than sorting out which compatibles are PPC SoCs. Though if that's
> > already done elsewhere in the driver, you could set a flag and use
> > that here. I'd be surprised if this was the only difference between
> > ARM and PPC SoCs for this block.
> 
> I think the right thing is a Kconfig variable that the architectures
> selects which says if OF is by default coherent or incoherent, and
> then use that in of_dma_is_coherent.

That too. We could also define properties for both ways so we can
override the default either way.

Cheers,
Ben.


