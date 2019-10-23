Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109DCE0F9C
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfJWBSM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 21:18:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:33457 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfJWBSM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Oct 2019 21:18:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9N1HUmB004727;
        Tue, 22 Oct 2019 20:17:31 -0500
Message-ID: <01389cb3b2eff0aea512ae2352d3fc4363a501be.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Date:   Wed, 23 Oct 2019 12:17:30 +1100
In-Reply-To: <850A5079-4B0D-4508-9B46-A79074DAEEFD@xenosoft.de>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
         <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
         <20191015125105.GU25745@shell.armlinux.org.uk>
         <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
         <20191015131750.GV25745@shell.armlinux.org.uk>
         <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
         <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
         <20191018101323.GG25745@shell.armlinux.org.uk>
         <499d70835d5f3e3cc191e5b5444475cd5a8c4604.camel@kernel.crashing.org>
         <8d7fd474-a1ad-e33f-f2ba-ec47f4bcc995@xenosoft.de>
         <c467eeb45a545263311ae28a49ea5599bb2a882c.camel@kernel.crashing.org>
         <850A5079-4B0D-4508-9B46-A79074DAEEFD@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2019-10-21 at 08:39 +0200, Christian Zigotzky wrote:
> > 
> Hi Ben,
> 
> I think it isn’t good to use the kernel config option
> "CONFIG_NOT_COHERENT_CACHE" if the system is coherent, is it?
> 
> We tested the kernel with "CONFIG_NOT_COHERENT_CACHE" yesterday but
> we didn’t find any differences to the coherent kernel.
> 
> Could you please explain us the difference between the coherent and
> not coherent kernel?

So first, ideally, we should make this a runtime mechanism...
historical crap.

Fundamentally when you set CONFIG_NOT_COHERENT_CACHE you tell the
kernel that your processor isn't snooping the bus for DMA accesses
colliding with the caches. Thus SW has to explicitly maintain cache
coherency around DMA operations by invalidating or flushing the cache
accordingly and by keeping pool(s) of non-cachable memory around
to use for the consistent allocator.

This slows things down.

Cheers,
Ben. 

