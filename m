Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF83E58DA
	for <lists+linux-mmc@lfdr.de>; Sat, 26 Oct 2019 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfJZGkH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 26 Oct 2019 02:40:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJZGkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Oct 2019 02:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6s17gBBg/6zRKAY7SPudjFKm/VgEPnz4H38+RtC8BxM=; b=hwuUqh5Oi86w7OEh0JFjKFc8b
        CaaHHIRIZh8BFLDE00o2RIuqYJN8J44I+BA2Uaiv6+03YhJ9NPS/dnmjKIGkQ8AGMCTNGyWc08uIj
        Dfv8hAHuN2M1xVu7n8X89L+VtGxT6TYPqnHZbGDqyST66bOya7xp7pBpirj2CYrGpLamJWn+ILDkt
        n1DXFkqsfRIfl7rfcYSoia1dZKHIiiQXOjXzTnmZNzQMNz2gUT4HyUAdG+hxGk06/DIur7wWmVFu3
        sSfh58f3kS+L28JMI+Y14hGdNdOR92GR0vB1uW8ctz/ZY53tlv5FTJI6BQ0anwyMF8AxPBiGc5utx
        91/NCE3QQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOFjK-0006J7-QH; Sat, 26 Oct 2019 06:39:18 +0000
Date:   Fri, 25 Oct 2019 23:39:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20191026063918.GA24015@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLZV1sXc053QMLcV-dV1BbGcRtX3eu1zbtNA_N3hzQE4g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 25, 2019 at 05:28:45PM -0500, Rob Herring wrote:
> This doesn't work?:
> 
>         if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev->of_node))
>                 value |= ESDHC_DMA_SNOOP;
>         else
>                 value &= ~ESDHC_DMA_SNOOP;
> 
> While I said use the compatibles, using the kconfig symbol is easier
> than sorting out which compatibles are PPC SoCs. Though if that's
> already done elsewhere in the driver, you could set a flag and use
> that here. I'd be surprised if this was the only difference between
> ARM and PPC SoCs for this block.

I think the right thing is a Kconfig variable that the architectures
selects which says if OF is by default coherent or incoherent, and then
use that in of_dma_is_coherent.
