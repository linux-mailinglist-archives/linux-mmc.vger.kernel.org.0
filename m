Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBADB4F56
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfIQNd0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:33:26 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41392 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIQNd0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 09:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IaO3Rqk7+O5bRQtudJzKuCkFQ7NvStYQjWVNTuy11ok=; b=NEuy8P+HoAJBIWwI8fCTDHVYQ
        NPHj58j6BGnSqBZgOtpgXL70qrAN4ppgDLgubXrwKzjECCRLWAKLhTY9vtiow/Sgizb5iidbKV/mK
        7Gl477qAJhs96+3d1S10peMEACGtHY8wsLXWbcrEUxcaARirKec1M2/OCgeUIbacRaniNbiAIyv86
        6KoJrxOSNmiyac8ugXbnIUAQDjPXfBxHk3Ob8Bw8RUYcR7UJ0OixZbHTgEot+fjFz8IeePnZFiDlD
        SwpSh+wll6Fh0QTuo7/K8gAKdSQI3qjntcFYao6VmuAJeaWOKi1sXwc7DIi73Syb4XrY/LvxhIQrU
        H4CGHABHA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33130)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iADba-00026a-IB; Tue, 17 Sep 2019 14:33:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iADbZ-0001Js-Ki; Tue, 17 Sep 2019 14:33:17 +0100
Date:   Tue, 17 Sep 2019 14:33:17 +0100
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
Message-ID: <20190917133317.GQ25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:24:57AM -0300, Fabio Estevam wrote:
> Hi Russell,
> 
> On Tue, Sep 17, 2019 at 10:10 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> 
> > Will suggested reverting bd2e75633c80 ("dma-contiguous: use fallback
> > alloc_pages for single pages") which has been implicated in the same
> > problem here:
> >
> > https://www.spinics.net/lists/arm-kernel/msg750623.html
> 
> It seems that the final fix was:
> https://lore.kernel.org/patchwork/patch/1121600/
> 
> Does it work for you if we follow the same idea?
> 
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1105,6 +1105,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
> 
>         esdhc_init(pdev, host);
> 
> +       sdhci_enable_v4_mode(host);
>         sdhci_get_of_property(pdev);
> 
>         pltfm_host = sdhci_priv(host);

That attempts to set bit 12 of the host control register 2 (0x3e).
The LX2160A documentation states that bit 28 of 0x3c (they're 32-bit
wide registers there) is "reserved".

So, you're asking for a documented reserved bit to be set...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
