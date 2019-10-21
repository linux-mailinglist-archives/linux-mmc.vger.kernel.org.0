Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC7DE159
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 02:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJUAHT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 20 Oct 2019 20:07:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:48162 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfJUAHT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 20 Oct 2019 20:07:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9L06Rln002804;
        Sun, 20 Oct 2019 19:06:29 -0500
Message-ID: <c467eeb45a545263311ae28a49ea5599bb2a882c.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>
Date:   Mon, 21 Oct 2019 11:06:26 +1100
In-Reply-To: <8d7fd474-a1ad-e33f-f2ba-ec47f4bcc995@xenosoft.de>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 2019-10-20 at 14:04 +0200, Christian Zigotzky wrote:
> 
> Thanks a lot for your suggestion!
> 
> I had to create a patch because I wasn't able to select 
> "CONFIG_NOT_COHERENT_CACHE" in the kernel configuration (patch attached).
> 
> After patching I was able to select "CONFIG_NOT_COHERENT_CACHE" in the 
> kernel config. I compiled a new RC3 of kernel 5.4 with this kernel 
> config option yesterday.
> 
> The good news is, that the onboard SD card works! We successfully tested 
> it on two AmigaOnes (X5000/20 and X5000/40) yesterday but we need a new 
> patch
> because of the possibility to select "CONFIG_NOT_COHERENT_CACHE" in the 
> kernel config

What I find weird is why would it be non-coherent ? A system based on a
E500 should be coherent afaik...

Cheers,
Ben.


