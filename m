Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E787DDC268
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfJRKO6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:14:58 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60808 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633389AbfJRKNu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z0sSMVnDx6pKSl+j6a5OWLy8DuLUQGBB0Kqfgd0KOoE=; b=1CFOMur8Okse85O9q/uJ7TXrv
        RanJgKl7jXEhV54f8hRBQAKAr4FqxYBSHKS5fQrR/+DEuik4WtZ03mqccILbs8QI1lEYLzKqB6XMk
        TZjA2+gqALQ0AmUYhNoE+7a4/1LMt161euyo3/4VKCmLXjD+DdPlgnr2t+yzcNfhk/7JRFKiyq6x4
        Cxh63h4vn/KZ46Sq4VK7C3i3nQKsKLwaPoLVejnBBaUqub2FjH4qCH/3/XZUw6GjUvkeQnUXZjyCW
        xlE8EVVHBTkWVeVcsS1LpNGbCTOExSusjIVI89EqYVRvioFUf2MX7yXbWc0huVfYxhupb0w8Je+4Y
        17oXXheIw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:44254)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iLPGF-0006nP-PA; Fri, 18 Oct 2019 11:13:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iLPG7-0000eB-9q; Fri, 18 Oct 2019 11:13:23 +0100
Date:   Fri, 18 Oct 2019 11:13:23 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Message-ID: <20191018101323.GG25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
 <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 17, 2019 at 01:16:00PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2019-10-15 at 15:44 +0200, Ulf Hansson wrote:
> > > Hmm, so it looks like PowerPC doesn't mark devices that are dma
> > > coherent with a property that describes them as such.
> > > 
> > > I think this opens a wider question - what should
> > > of_dma_is_coherent()
> > > return for PowerPC?  It seems right now that it returns false for
> > > devices that are DMA coherent, which seems to me to be a recipe for
> > > future mistakes.
> > 
> > Perhaps implement the arch_setup_dma_ops() for PPC, that set
> > "dev->dma_coherent = true" could work?
> 
> Only for coherent ops :)

For those of us who have never touched the PowerPC code before, any
suggestion where you would like to see that?  No file in arch/powerpc/mm
stands out as a place for DMA stuff (and dma-noncoherent.c is certainly
not correct.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
