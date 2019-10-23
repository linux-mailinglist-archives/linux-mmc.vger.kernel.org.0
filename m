Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFFE1E37
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbfJWOcR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Oct 2019 10:32:17 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60754 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389995AbfJWOcR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2019 10:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cjPuS08fLHV8el8EaxndD6I/d/IQPJlUbi111PAD/l4=; b=iJ2v+CSstuLBKM08pLTx576aM
        VxntxxCQSSo10E8/SL6JaCu7DGHBQbYKoGE9AWr2TOiZmWMAk1KfV1lMlOkN3GsHB0ajoUGKqdzj8
        u202GiupQQbUAZAkvODo9ATZleYIkhkrpJRPRnu8LY4MSuAHQSWl3ggq8+45cAm2o2shQTiCGE7oc
        QAJHHRgOHofIUFTKn/4GK+tcL3Hv9lV0IQf2zQLc3zHoiaLLO8l4DaQpQFUp1fN3yI7bBQAM2O2eN
        Ph+2cwxlod+dsiP0rzFs98e6Yows2hrmXXJjtI8ixe3nYg/6TeHUpejwD6D/kMIr5FIou+yUS0Rpj
        F7KtKig6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58106)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iNHg8-0005SK-LT; Wed, 23 Oct 2019 15:32:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iNHg7-0005cA-5R; Wed, 23 Oct 2019 15:31:59 +0100
Date:   Wed, 23 Oct 2019 15:31:59 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
Message-ID: <20191023143159.GB25745@shell.armlinux.org.uk>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
 <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
 <20191015125105.GU25745@shell.armlinux.org.uk>
 <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
 <20191015131750.GV25745@shell.armlinux.org.uk>
 <87muds586t.fsf@mpe.ellerman.id.au>
 <31d58f086f964937b27209bc18b334d9c9791767.camel@kernel.crashing.org>
 <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpFy-g3earNjZs7jANx4pyRd=CDvZN3emMdXL5YNkYHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 23, 2019 at 08:52:33AM -0500, Rob Herring wrote:
> > I think this should have been done the other way around and default to
> > coherent since most traditional OF platforms are coherent, and you
> > can't just require those DTs to change.
> 
> You can blame me. This was really only intended for cases where
> coherency is configurable on a per peripheral basis and can't be
> determined in other ways.
> 
> The simple solution here is simply to use the compatible string for
> the device to determine coherent or not.

It really isn't that simple.

There are two aspects to coherency, both of which must match:

1) The configuration of the device
2) The configuration of the kernel's DMA API

(1) is controlled by the driver, which can make the decision any way
it pleases.

(2) on ARM64 is controlled depending on whether or not "dma-coherent"
is specified in the device tree, since ARM64 can have a mixture of
DMA coherent and non-coherent devices.

A mismatch between (1) and (2) results in data corruption, potentially
eating your filesystem.  So, it's very important that the two match.

These didn't match for the LX2160A, but, due to the way CMA was working,
we sort of got away with it, but it was very dangerous as far as data
safety went.

Then, a change to CMA happened which moved where it was located, which
caused a regression.  Reverting the CMA changes didn't seem to be an
option, so another solution had to be found.

I started a discussion on how best to solve this:

https://archive.armlinux.org.uk/lurker/thread/20190919.041320.1e53541f.en.html

and the solution that the discussion came out with was the one that has
been merged - which we now know caused a regression on PPC.

Using compatible strings doesn't solve the issue: there is no way to
tell the DMA API from the driver that the device is coherent.  The
only way to do that is via the "dma-coherent" property in DT on ARM64.

To say that this is a mess is an under-statement, but we seem to have
ended up here because of a series of piece-meal changes that don't seem
to have been thought through enough.

So, what's the right way to solve this, and ensure that the DMA API and
device match as far as their coherency expectations go?  Revert all the
changes for sdhci-of-esdhc and CMA back to 5.0 or 5.1 state?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
