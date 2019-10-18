Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F88DD596
	for <lists+linux-mmc@lfdr.de>; Sat, 19 Oct 2019 01:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfJRXk5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 19:40:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:38319 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfJRXk5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Oct 2019 19:40:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9INeArK008853;
        Fri, 18 Oct 2019 18:40:12 -0500
Message-ID: <499d70835d5f3e3cc191e5b5444475cd5a8c4604.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Date:   Sat, 19 Oct 2019 10:40:10 +1100
In-Reply-To: <20191018101323.GG25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
         <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
         <20191015125105.GU25745@shell.armlinux.org.uk>
         <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
         <20191015131750.GV25745@shell.armlinux.org.uk>
         <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
         <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
         <20191018101323.GG25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2019-10-18 at 11:13 +0100, Russell King - ARM Linux admin wrote:
> On Thu, Oct 17, 2019 at 01:16:00PM +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2019-10-15 at 15:44 +0200, Ulf Hansson wrote:
> > > > Hmm, so it looks like PowerPC doesn't mark devices that are dma
> > > > coherent with a property that describes them as such.
> > > > 
> > > > I think this opens a wider question - what should
> > > > of_dma_is_coherent()
> > > > return for PowerPC?  It seems right now that it returns false for
> > > > devices that are DMA coherent, which seems to me to be a recipe for
> > > > future mistakes.
> > > 
> > > Perhaps implement the arch_setup_dma_ops() for PPC, that set
> > > "dev->dma_coherent = true" could work?
> > 
> > Only for coherent ops :)
> 
> For those of us who have never touched the PowerPC code before, any
> suggestion where you would like to see that?  No file in arch/powerpc/mm
> stands out as a place for DMA stuff (and dma-noncoherent.c is certainly
> not correct.)

Anywhere is fine but I think it's easy. Coherent DMA is for historical
reasons a function of the processor generation, and as such a CONFIG
option.

So setting it according to CONFIG_NOT_COHERENT_CACHE will probably work
just fine.

Well at least I think so ... unless I'm missing some broken HW
somewhere I am not aware of.

Cheers,
Ben.


