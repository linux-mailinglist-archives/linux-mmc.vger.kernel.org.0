Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C124C37A
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfFSWWj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Jun 2019 18:22:39 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:52268
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfFSWWj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Jun 2019 18:22:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 03B0B3FBEE;
        Thu, 20 Jun 2019 00:22:38 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 59ViRyGasvku; Thu, 20 Jun 2019 00:22:37 +0200 (CEST)
Received: from jerusalem (host54-236-dynamic.0-87-r.retail.telecomitalia.it [87.0.236.54])
        by sysam.it (Postfix) with ESMTPSA id 7C2773EDA0;
        Thu, 20 Jun 2019 00:22:37 +0200 (CEST)
Date:   Thu, 20 Jun 2019 00:22:36 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mmc: add Coldfire esdhc support
Message-ID: <20190619222236.GA18383@jerusalem>
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190617065807.GA17948@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617065807.GA17948@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Christoph,

On Sun, Jun 16, 2019 at 11:58:07PM -0700, Christoph Hellwig wrote:
> On Sun, Jun 16, 2019 at 10:48:21PM +0200, Angelo Dureghello wrote:
> > This driver has been developed as a separate module starting
> > from the similar sdhci-esdhc-fls.c.
> > Separation has been mainly driven from change in endianness.
> 
> Can't we have a way to define the endianess at build or even runtime?
> We have plenty of that elsewhere in the kernel.

well, the base sdhci layer wants to access byte-size fields of the
esdhc controller registers.
But this same Freescale esdhc controller may be found in 2
flavors, big-endian or little-endian organized.
So in this driver i am actually correcting byte-addresses to
access the wanted byte-field in the big-endian hw controller.

So this is a bit different from a be-le endian swap of a
long or a short that the kernel is organized to do..

Regards,
Angelo 
