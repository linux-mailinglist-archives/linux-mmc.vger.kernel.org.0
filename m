Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8746217C015
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Mar 2020 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFOTx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Mar 2020 09:19:53 -0500
Received: from verein.lst.de ([213.95.11.211]:36853 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFOTx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 09:19:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB97468AFE; Fri,  6 Mar 2020 15:19:50 +0100 (CET)
Date:   Fri, 6 Mar 2020 15:19:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Message-ID: <20200306141950.GA1017@lst.de>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com> <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com> <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com> <20200305152337.GC4870@lst.de> <CAPDyKFovCm5r7J4pQNfV21KiyAC+VGHvowddgkdzkSE4f3UnGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFovCm5r7J4pQNfV21KiyAC+VGHvowddgkdzkSE4f3UnGA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 06, 2020 at 03:02:09PM +0100, Ulf Hansson wrote:
> That makes sense to me, but we also have other bus types to consider,
> like the amba bus for example.
> 
> So, in principle, those buses that may get DMA capable devices
> attached, needs to do the allocation, that's what you are proposing?

Having a dma_params allocated doesn't mean all devices are dma capable,
for example there are PCI devices that aren't as well.
