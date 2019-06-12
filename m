Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7439C42887
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfFLONT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 10:13:19 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58876 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbfFLONR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2019 10:13:17 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,366,1557212400"; 
   d="scan'208";a="37224401"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2019 07:13:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 07:13:08 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 12 Jun 2019 07:13:09 -0700
Date:   Wed, 12 Jun 2019 16:12:09 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/4] mmc: host: atmel-mci: no need to check return value
 of debugfs_create functions
Message-ID: <20190612141209.hd6wnmzkiumxqfmb@M43218.corp.atmel.com>
Mail-Followup-To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-mmc@vger.kernel.org
References: <20190612082531.2652-1-gregkh@linuxfoundation.org>
 <20190612082531.2652-2-gregkh@linuxfoundation.org>
 <20190612083008.GN25472@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190612083008.GN25472@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 12, 2019 at 10:30:08AM +0200, Alexandre Belloni wrote:
> External E-Mail
> 
> 
> On 12/06/2019 10:25:29+0200, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: <linux-mmc@vger.kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

> 
> > ---
> >  drivers/mmc/host/atmel-mci.c | 38 +++++++-----------------------------
> >  1 file changed, 7 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index 735aa5871358..e1f10c3fa144 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -579,42 +579,18 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
> >  	struct mmc_host		*mmc = slot->mmc;
> >  	struct atmel_mci	*host = slot->host;
> >  	struct dentry		*root;
> > -	struct dentry		*node;
> >  
> >  	root = mmc->debugfs_root;
> >  	if (!root)
> >  		return;
> >  
> > -	node = debugfs_create_file("regs", S_IRUSR, root, host,
> > -				   &atmci_regs_fops);
> > -	if (IS_ERR(node))
> > -		return;
> > -	if (!node)
> > -		goto err;
> > -
> > -	node = debugfs_create_file("req", S_IRUSR, root, slot,
> > -				   &atmci_req_fops);
> > -	if (!node)
> > -		goto err;
> > -
> > -	node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
> > -	if (!node)
> > -		goto err;
> > -
> > -	node = debugfs_create_x32("pending_events", S_IRUSR, root,
> > -				     (u32 *)&host->pending_events);
> > -	if (!node)
> > -		goto err;
> > -
> > -	node = debugfs_create_x32("completed_events", S_IRUSR, root,
> > -				     (u32 *)&host->completed_events);
> > -	if (!node)
> > -		goto err;
> > -
> > -	return;
> > -
> > -err:
> > -	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
> > +	debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
> > +	debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> > +	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
> > +	debugfs_create_x32("pending_events", S_IRUSR, root,
> > +			   (u32 *)&host->pending_events);
> > +	debugfs_create_x32("completed_events", S_IRUSR, root,
> > +			   (u32 *)&host->completed_events);
> >  }
> >  
> >  #if defined(CONFIG_OF)
> > -- 
> > 2.22.0
> > 
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
