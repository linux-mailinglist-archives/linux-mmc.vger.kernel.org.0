Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB03A4701F
	for <lists+linux-mmc@lfdr.de>; Sat, 15 Jun 2019 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFONF5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 15 Jun 2019 09:05:57 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:42934
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFONF5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 15 Jun 2019 09:05:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 778A53FE8E;
        Sat, 15 Jun 2019 15:05:55 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X3gbcPYhl66G; Sat, 15 Jun 2019 15:05:55 +0200 (CEST)
Received: from jerusalem (unknown [95.233.239.237])
        by sysam.it (Postfix) with ESMTPSA id 204633FE88;
        Sat, 15 Jun 2019 15:05:55 +0200 (CEST)
Date:   Sat, 15 Jun 2019 15:05:53 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirks for be to le byte swapping
Message-ID: <20190615130553.GA7273@jerusalem>
References: <20190512194125.7091-1-angelo@sysam.it>
 <20190512194125.7091-2-angelo@sysam.it>
 <b2adda22-613e-67bf-cc3a-6bdd603ae02c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2adda22-613e-67bf-cc3a-6bdd603ae02c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Wed, Jun 12, 2019 at 09:42:27AM +0300, Adrian Hunter wrote:
> On 12/05/19 10:41 PM, Angelo Dureghello wrote:
> > Some controller as the ColdFire eshdc may require an endianness
> > byte swap, becouse DMA read endianness is not configurable.
> 
> becouse -> because
> 
ok

> Do any other drivers have this issue?
> 
host/mxcmmc.c for PPC devices is doing a similar swap (buffer_swap32).

> > 
> > Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> > ---
> >  drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
> >  drivers/mmc/host/sdhci.h |  7 +++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 97158344b862..317dcfb4bb4c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2592,6 +2592,18 @@ static const struct mmc_host_ops sdhci_ops = {
> >  	.card_busy	= sdhci_card_busy,
> >  };
> >  
> > +static void sdhci_be_to_le(char *buff, u32 length)
> > +{
> > +	int i, size = length >> 2;
> > +	u32 *buffer = (u32 *)buff;
> > +	u32 temp;
> > +
> > +	for (i = 0; i < size; i++) {
> > +		temp = *buffer;
> > +		*buffer++ = __le32_to_cpu(temp);
> > +	}
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Request done                                                              *
> > @@ -2647,6 +2659,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >  						host->bounce_addr,
> >  						host->bounce_buffer_size,
> >  						DMA_FROM_DEVICE);
> > +
> > +					if (host->quirks2 &
> > +					    SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP)
> > +						sdhci_be_to_le(
> > +							host->bounce_buffer,
> > +							length);
> 
> How come it only affects the bounce buffer?  What about if there is no
> bounce buffer?
> 
Right, Will check where how to apply the swap also without bounce buffer.

> > +
> >  					sg_copy_from_buffer(data->sg,
> >  						data->sg_len,
> >  						host->bounce_buffer,
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index d6bcc584c92b..38fa69678cec 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -486,6 +486,13 @@ struct sdhci_host {
> >   */
> >  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> >  
> > +/*
> > + * On some architectures, as ColdFire/m68k, native endianness is big endian,
> > + * and the dma buffer is filled in big endian order only (no other options).
> > + * So, a swap is needed for these specific cases.
> > + */
> > +#define SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP		(1<<19)
> > +
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> >  	char *bounce_buffer;	/* For packing SDMA reads/writes */
> > 
> 

Regards,
Angelo
