Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E3E6E6E
	for <lists+linux-mmc@lfdr.de>; Mon, 28 Oct 2019 09:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfJ1Iq0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 28 Oct 2019 04:46:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:33820 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbfJ1Iq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Oct 2019 04:46:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9S8jY59019523;
        Mon, 28 Oct 2019 03:45:35 -0500
Message-ID: <47e67f44f5e955108759fe32400d2622c4a5ba3f.camel@kernel.crashing.org>
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2'
 updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Paul Mackerras <paulus@samba.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Mon, 28 Oct 2019 19:45:34 +1100
In-Reply-To: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2019-10-25 at 17:28 -0500, Rob Herring wrote:
> This doesn't work?:
> 
>         if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev-
> >of_node))
>                 value |= ESDHC_DMA_SNOOP;
>         else
>                 value &= ~ESDHC_DMA_SNOOP;

CONFIG_PPC is restrictive. What about sparc64 ? There could be others
.. .we can't suddenly requests people to add new properties for what
was implied behaviours before hand, esp since it's not in the base 1275
spec, no ?

I would suggest of_dma_is_coherent is *true* by default unless
overriden to do something else.

Cheers,
Ben.


