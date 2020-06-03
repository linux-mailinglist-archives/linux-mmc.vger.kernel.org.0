Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF61EC8C4
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Jun 2020 07:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCF0l (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 3 Jun 2020 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFCF0k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jun 2020 01:26:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C544C05BD43;
        Tue,  2 Jun 2020 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B9FZXvCVa4OcevC1BEI/2OAvMbOb5AtVuCYULJ2X2Z4=; b=HrsjkFjE34DIX8ilChH6LzX4q5
        1cFzLEE4zdcDZtVK4jdUnSk+WPpHG9ggL2mJhsgob8SUnwEkV+FIbx5ZrUeB55xHQk4+LHrQv6T+j
        qR5YYxJGrxqqRnhnysgmeZU+vAC5OsPyk8HFaRQ8jPsCKGJLRAjSSsk9L59OhOCB8aK5+cz2pYbWB
        y9ox2eqbd3/dsbJ72gidswzwgWBsVIqsJUyy1km1tBKGv5SCo/XRPqz2KWm7FEN4e1o2U6lgthItJ
        +7Sc3nhY5ZzXPGwsiRziDBV5LepLvEoGAEhhNbsztPl26udsWo0NHdzKGopYs79CJSF2GLun3MjxX
        q20wr0ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgLvD-0005QD-N3; Wed, 03 Jun 2020 05:26:39 +0000
Date:   Tue, 2 Jun 2020 22:26:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
Message-ID: <20200603052639.GB15520@infradead.org>
References: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 02, 2020 at 11:20:59AM +0200, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

So this crap now shows up piecemail on various lists?  Indepent of that
it seems like a bad idea to start with, bombing people with patches that
apparently depend on something you did first but they are not Cced on
is just an amazingly bad idea.  Don't do that ever.
