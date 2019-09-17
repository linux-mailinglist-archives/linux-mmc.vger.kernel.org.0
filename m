Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE9B4FB0
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfIQNwO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:52:14 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41710 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIQNwI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 09:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0kHpPNNmIunZ8PTjKROUxxoBt7miTlYbdWH51X5C1SM=; b=cgm5dIkwieWEw2rYPeRHqe2BB
        Uv2SyN0l6jOTsy9oaxb5LSe2QiFKFLxcBYR3wHIqrCPKrHwudxiPJLkb8WFszY2hkomxlwdPC/axr
        4NXAfYvCV9lXNHkQbzu3gzMGS5mr2hdTRXGc0syLsXedKCl3EyJqRBqTNPISnfTF3Sn5hMAkcDZq5
        jRDewaqOw3vnLSGydQNpcLNE3Q/mKySAi3GnCmkObAqiI1eZ3tq48HxaSE/MWN+Ce5vVDRUR0U/7c
        Rc/EQgDXhnj2Gjy/of1KFgsxNiqagieWh2sXvcwpVL+HwtZ5PmBDApzGjFgZ7KBecvB88jtvrIHvH
        uAz4FnKXg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40658)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iADte-0002Ct-RF; Tue, 17 Sep 2019 14:51:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iADtd-0001LF-EG; Tue, 17 Sep 2019 14:51:57 +0100
Date:   Tue, 17 Sep 2019 14:51:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Message-ID: <20190917135157.GT25745@shell.armlinux.org.uk>
References: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
 <20190917133317.GQ25745@shell.armlinux.org.uk>
 <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:43:35AM -0300, Fabio Estevam wrote:
> On Tue, Sep 17, 2019 at 10:33 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > That attempts to set bit 12 of the host control register 2 (0x3e).
> > The LX2160A documentation states that bit 28 of 0x3c (they're 32-bit
> > wide registers there) is "reserved".
> >
> > So, you're asking for a documented reserved bit to be set...
> 
> Correct, v4 is not supported here indeed.
> 
> From the LX2160 doc:
> "Conforms to the SD Host Controller Standard Specification version 3.0"

The pressing question seems to be this:

Are the eSDHC on the LX2160A DMA coherent or are they not?

Any chances of finding out internally what the true answer to that,
rather than me poking about trying stuff experimentally?  Having a
definitive answer for a potentially data-corrupting change would
be really good...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
