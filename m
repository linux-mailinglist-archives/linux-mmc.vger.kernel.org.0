Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13FDDA384
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395041AbfJQCQd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 22:16:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:45515 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfJQCQd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Oct 2019 22:16:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9H2G0Q8003121;
        Wed, 16 Oct 2019 21:16:01 -0500
Message-ID: <ed35a87495b0f0d322f555a16fb3e0f7574415ac.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Date:   Thu, 17 Oct 2019 13:16:00 +1100
In-Reply-To: <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de>
         <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de>
         <20191015125105.GU25745@shell.armlinux.org.uk>
         <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de>
         <20191015131750.GV25745@shell.armlinux.org.uk>
         <CAPDyKFq_0P8X-6hkjko1chLtOrwsxGcEFR31GcbffhhUQNw+bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2019-10-15 at 15:44 +0200, Ulf Hansson wrote:
> > Hmm, so it looks like PowerPC doesn't mark devices that are dma
> > coherent with a property that describes them as such.
> > 
> > I think this opens a wider question - what should
> > of_dma_is_coherent()
> > return for PowerPC?  It seems right now that it returns false for
> > devices that are DMA coherent, which seems to me to be a recipe for
> > future mistakes.
> 
> Perhaps implement the arch_setup_dma_ops() for PPC, that set
> "dev->dma_coherent = true" could work?

Only for coherent ops :)

Cheers,
Ben.


