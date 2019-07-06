Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD260FB8
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Jul 2019 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfGFKAt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 6 Jul 2019 06:00:49 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:54972
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfGFKAs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 6 Jul 2019 06:00:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 79AF53FE9A;
        Sat,  6 Jul 2019 12:00:45 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M8FWJz3YYSGv; Sat,  6 Jul 2019 12:00:45 +0200 (CEST)
Received: from jerusalem (host105-54-dynamic.182-80-r.retail.telecomitalia.it [80.182.54.105])
        by sysam.it (Postfix) with ESMTPSA id 1296B3F114;
        Sat,  6 Jul 2019 12:00:45 +0200 (CEST)
Date:   Sat, 6 Jul 2019 12:00:44 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mmc: sdhci: add quirks for be to le byte swapping
Message-ID: <20190706100044.GA6763@jerusalem>
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190616204823.32758-2-angelo@sysam.it>
 <93921f9e-08a2-c53e-58a2-aa28e66a191d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93921f9e-08a2-c53e-58a2-aa28e66a191d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

thanks for the feedbacks.

On Tue, Jul 02, 2019 at 12:10:44PM +0300, Adrian Hunter wrote:
> On 16/06/19 11:48 PM, Angelo Dureghello wrote:
> > Some controller as the ColdFire eshdc may require an endianness
> > byte swap, because DMA read endianness is not configurable.
> 
> I would prefer something more generic, like adding another callback
> for ->request_done() e.g.
> 
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f56ae6f153d4..a63e528cb885 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	mmc_request_done(host->mmc, mrq);
> +	if (host->ops->request_done)
> +		host->ops->request_done(host, mrq);
> +	else
> +		mmc_request_done(host->mmc, mrq);
>  
>  	return false;
>  }
> 
> 
> Then you can use the ->request_done() callback to iterate over the data->sg
> and make byte-swaps as needed.
> 
Ok, good to know, will try.

> > 
> > Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> > ---
> >  drivers/mmc/host/sdhci.c | 19 +++++++++++++++++++
> >  drivers/mmc/host/sdhci.h |  7 +++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 59acf8e3331e..f56ae6f153d4 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2600,6 +2600,18 @@ static const struct mmc_host_ops sdhci_ops = {
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
> > @@ -2655,6 +2667,13 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >  						host->bounce_addr,
> >  						host->bounce_buffer_size,
> >  						DMA_FROM_DEVICE);
> > +
> > +					if (host->quirks2 &
> > +					    SDHCI_QUIRK2_USE_32BIT_BE_DMA_SWAP)
> > +						sdhci_be_to_le(
> > +							host->bounce_buffer,
> > +							length);
> > +
> >  					sg_copy_from_buffer(data->sg,
> >  						data->sg_len,
> >  						host->bounce_buffer,
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 199712e7adbb..be08ff1a8c6f 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -482,6 +482,13 @@ struct sdhci_host {
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

Reagrds,
Angelo
