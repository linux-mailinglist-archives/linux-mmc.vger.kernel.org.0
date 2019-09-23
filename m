Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D4BBE57
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Sep 2019 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407700AbfIWWLh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 18:11:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58898 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393454AbfIWWLg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 18:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uQIGMb1Dzin6UXLLiaXD8NPdfpyb7AaDZUU3nn9qp1w=; b=EX9v7OC9K+JB9u656wnad3Qso
        vFCQvz2aDK8wnmWQIz06DB5LbtFGvkmTtpIWfmykLrNdwU0bxVOsmCp8/7w+2/sil7JMXnGTaoJ1l
        XfzbXUxDAPCtoQhvxyvgjUiQqcw+lQ7ZgFrm5OZzbiF7XLuzl/IGnHZtWnNoorO9jr+eoLMB6z5ak
        A6pUzjZ3pkySjI7/41cCUVrXbivAt4gacm3d7GrPLJgnYzMTrnhDHC+NHbsfcWLMBcoP9id9gaKde
        AjH101b3/0MacGGGMlmCXJEGZVNivX9sXdspsCdDhsjcQm3L92CEd5cFN4tLp8pBkWQ5v06rgZUhC
        kW4/M+tCA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:35748)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCWYE-0006j6-4D; Mon, 23 Sep 2019 23:11:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCWY9-0000ds-Po; Mon, 23 Sep 2019 23:11:17 +0100
Date:   Mon, 23 Sep 2019 23:11:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: improve ADMA error reporting
Message-ID: <20190923221117.GV25745@shell.armlinux.org.uk>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz4v-0008MV-4k@rmk-PC.armlinux.org.uk>
 <CAPDyKFqmO3aRPzN2Wctx9Ww5w_YBbcjJqMHeasQAHb97Dwar0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqmO3aRPzN2Wctx9Ww5w_YBbcjJqMHeasQAHb97Dwar0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 23, 2019 at 11:54:46PM +0200, Ulf Hansson wrote:
> On Sun, 22 Sep 2019 at 12:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > ADMA errors are potentially data corrupting events; although we print
> > the register state, we do not usefully print the ADMA descriptors.
> > Worse than that, we print them by referencing their virtual address
> > which is meaningless when the register state gives us the DMA address
> > of the failing descriptor.
> >
> > Print the ADMA descriptors giving their DMA addresses rather than their
> > virtual addresses, and print them using SDHCI_DUMP() rather than DBG().
> >
> > We also do not show the correct value of the interrupt status register;
> > the register dump shows the current value, after we have cleared the
> > pending interrupts we are going to service.  What is more useful is to
> > print the interrupts that _were_ pending at the time the ADMA error was
> > encountered.  Fix that too.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> This seems useful to land for 5.4, so I have queued this up via my fixes branch.
> 
> Perhaps we should also tag this for stable, what do you think?

No objection from me.

Thanks.

> 
> Kind regards
> Uffe
> 
> 
> > ---
> >  drivers/mmc/host/sdhci.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a5dc5aae973e..0f33097c55ec 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2855,6 +2855,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
> >  static void sdhci_adma_show_error(struct sdhci_host *host)
> >  {
> >         void *desc = host->adma_table;
> > +       dma_addr_t dma = host->adma_addr;
> >
> >         sdhci_dumpregs(host);
> >
> > @@ -2862,18 +2863,21 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
> >                 struct sdhci_adma2_64_desc *dma_desc = desc;
> >
> >                 if (host->flags & SDHCI_USE_64_BIT_DMA)
> > -                       DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> > -                           desc, le32_to_cpu(dma_desc->addr_hi),
> > +                       SDHCI_DUMP("%08llx: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
> > +                           (unsigned long long)dma,
> > +                           le32_to_cpu(dma_desc->addr_hi),
> >                             le32_to_cpu(dma_desc->addr_lo),
> >                             le16_to_cpu(dma_desc->len),
> >                             le16_to_cpu(dma_desc->cmd));
> >                 else
> > -                       DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> > -                           desc, le32_to_cpu(dma_desc->addr_lo),
> > +                       SDHCI_DUMP("%08llx: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
> > +                           (unsigned long long)dma,
> > +                           le32_to_cpu(dma_desc->addr_lo),
> >                             le16_to_cpu(dma_desc->len),
> >                             le16_to_cpu(dma_desc->cmd));
> >
> >                 desc += host->desc_sz;
> > +               dma += host->desc_sz;
> >
> >                 if (dma_desc->cmd & cpu_to_le16(ADMA2_END))
> >                         break;
> > @@ -2949,7 +2953,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> >                         != MMC_BUS_TEST_R)
> >                 host->data->error = -EILSEQ;
> >         else if (intmask & SDHCI_INT_ADMA_ERROR) {
> > -               pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
> > +               pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
> > +                      intmask);
> >                 sdhci_adma_show_error(host);
> >                 host->data->error = -EIO;
> >                 if (host->ops->adma_workaround)
> > --
> > 2.7.4
> >
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
