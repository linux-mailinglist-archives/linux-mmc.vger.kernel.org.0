Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85701527DA
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Jun 2019 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfFYJVE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 25 Jun 2019 05:21:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYJVC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jun 2019 05:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PFFctdNrSRlEmYFziRh2gXkH/51FMqRKiiZb1uQDWQg=; b=jaBJvzPtSagsatrt5/FzWEqXO
        oFJKNfqW4dTyJ529zBaraXXR1L1kwJDR8IIG0DYUvPM00sOeJgW/wsxuBdeiVcWR674F2/J/295Xp
        Txq5FHubIgINXo/oN0c2JrKujX9SJC48TCW53qfIMnzIvmMXoR8wIy8TpVdZL4iMUSMVE4OoAXsq4
        FjXZ1voKAWG4c4VOa6cYeCn6cFRULUpBZmFsji3fAUlvk1gour4G5lj1V3RiDrMfNKnvwq19wKDo3
        i9BY1PNYYHDwT1RYED0mu7444sDnfgU84unVorATYEi7nSo1vmOFz7pZFpgb7sZ1VQWUXs1AhTUY5
        zh09iBTNw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfhd7-0005iX-UF; Tue, 25 Jun 2019 09:20:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: get rid of dma_max_pfn
Date:   Tue, 25 Jun 2019 11:20:40 +0200
Message-Id: <20190625092042.19320-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi everyone,

I though I got rid of all non-highmem, non-ISA block layer bounce
buffering a while ago, but I missed the MMC case.  While I still plan to
also kill off the highmem bouncing there I won't get to it this merge
window, so for now I'd like to make some progress and move MMC to the
DMA layer (swiotlb or arm dmabounce) bouncing for addressing limitations
and kill off the dma_max_pfn helper.

I'm fine with merging this through the mmc tree if it suits everyone.
