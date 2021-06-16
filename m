Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94C3A9152
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Jun 2021 07:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFPFlz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Jun 2021 01:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPFlz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jun 2021 01:41:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33EAC061574;
        Tue, 15 Jun 2021 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=K30aY/7ywJPJb7vqcbek9Ev9guY9TjzXRgFWmfcBIq8=; b=FHImfLr5TulOBuLXfi+rAHhs5s
        d6Rwt1SlVP9r5t6URpiKaeiSRBgCCyn/Uvvv9wv7kFh5NjR/6fqqmAO1sQSNoBEiv9S5+vZOJVD9m
        JjcnmOwBavLS3QgDuh9qL2XhTtm+ZwaDc3JoKoz2XMIDmLReBl3bUgQdDX8qWbQJ2Y1UDoMqTzEE+
        vfG8q/0OaPsBHiuU5Ata0Wlrty88HEux0uIdQ69TkXUK0eNZ31L836mo1Oz3+8wcd/1OnNZriRjEZ
        QFkNroo/mNWeWWv8eCRu+CYpxkjL3ChWy6DcQ9yG3P4367Fy36gECEvG/V8ni8IidphkCxPZuWNcj
        BbayIPtg==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOH3-007e7u-Er; Wed, 16 Jun 2021 05:39:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: convert the mmc driver to use blk_mq_alloc_disk
Date:   Wed, 16 Jun 2021 07:39:32 +0200
Message-Id: <20210616053934.880951-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

can you take a look at this series which converts the mmc driver to the
new blk_mq_alloc_disk interface.  It is based upon Jens' for-5.14/block
or for-next trees.

Diffstat:
 block.c |   28 ++++------------------------
 queue.c |   23 ++++++++++-------------
 queue.h |    2 +-
 3 files changed, 15 insertions(+), 38 deletions(-)
