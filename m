Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B73EF9DA
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Aug 2021 07:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhHRFMF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Aug 2021 01:12:05 -0400
Received: from verein.lst.de ([213.95.11.211]:60601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhHRFMF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 01:12:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 847C467357; Wed, 18 Aug 2021 07:11:28 +0200 (CEST)
Date:   Wed, 18 Aug 2021 07:11:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: imx7: dev->coherent_dma_mask NULL warning
Message-ID: <20210818051128.GA8550@lst.de>
References: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 17, 2021 at 09:23:26PM -0300, Fabio Estevam wrote:
> 
> void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> ....
> WARN_ON_ONCE(!dev->coherent_dma_mask);
> 
> Where should the coherent_dma_mask be set to avoid this problem?

Looking at the ath10k code ar->dev is set by ath10k_core_create, which
has multiple callers.

For ath10k_pci_probe it is a pci_dev, whoch should always have a
dma_mask.
For ath10k_ahb_probe is is a device tree probed platform_device,
which should have a dma mask.
For ath10k_sdio_probe it is a sdio_func, which from my understanding is
a virtual device can't do DMA itself.
For ath10k_snoc_probe it is a platform device wit an explicit
dma_set_mask_and_coherent and above so the dma_mask is set.
For ath10k_usb_probe it is an usb device which can't do USB

So unless I misred the driver you're using the SDIO or USB variant,
and those are not allowed to just call dma_* functions on their
respective devices.
