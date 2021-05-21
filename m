Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22C38BDFE
	for <lists+linux-mmc@lfdr.de>; Fri, 21 May 2021 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhEUFxF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 May 2021 01:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhEUFxF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 May 2021 01:53:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FA8C061574;
        Thu, 20 May 2021 22:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1uf84BS8Q7NSBXg1yQR5EC+qaCg2ZgLYmuXoDkaPjCQ=; b=yVac5N8yUOzpUTxL5O1tvL86te
        m3UAUEPJY/af59veHnMPwBOnJ7BRLcZrKIKt8Dh7YPbjkftLfLGTS4VhKOyyyjq3VjpC44ktitdB9
        IGcelhE3Oa213g7yVLse3bazcfqBPE0AjzvZkAoIGc9XTXbidpJpsbluOmOOc3JrOP6KXc8MYblK4
        oHQQgY+u4rceYmhcSMGEEbuC03JwZPicLhzcbKv5cdyhrdklHJY1gLYGuEEO6TAkLoGvvppviy5Hp
        K3tkB8PLSkhH6CJEnd2fuR+rb3FAaFtYutga3kk4PwncNu4+e+dofRaE7iKfkJNVvZr+BYooXFvLx
        bVfJReyA==;
Received: from [2001:4bb8:180:5add:4fd7:4137:d2f2:46e6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljy3s-00Gpw6-Eq; Fri, 21 May 2021 05:51:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com,
        linuxppc-dev@lists.ozlabs.org (open list:PS3 PLATFORM SUPPORT),
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: simplify gendisk and request_queue allocation for bio based drivers
Date:   Fri, 21 May 2021 07:50:35 +0200
Message-Id: <20210521055102.1053529-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi all,

this series is the first part of cleaning up lifetimes and allocation of
the gendisk and request_queue structure.  It adds a new interface to
allocate the disk and queue together for bio based drivers, and a helper
for cleanup/free them when a driver is unloaded or a device is removed.

Together this removes the need to treat the gendisk and request_queue
as separate entities for bio based drivers.

Diffstat:
 arch/m68k/emu/nfblock.c             |   20 +---
 arch/xtensa/platforms/iss/simdisk.c |   29 +------
 block/blk-core.c                    |    1 
 block/blk.h                         |    6 -
 block/genhd.c                       |  149 +++++++++++++++++++-----------------
 block/partitions/core.c             |   19 ++--
 drivers/block/brd.c                 |   94 +++++++---------------
 drivers/block/drbd/drbd_main.c      |   23 +----
 drivers/block/n64cart.c             |    8 -
 drivers/block/null_blk/main.c       |   38 ++++-----
 drivers/block/pktcdvd.c             |   11 --
 drivers/block/ps3vram.c             |   31 +------
 drivers/block/rsxx/dev.c            |   39 +++------
 drivers/block/rsxx/rsxx_priv.h      |    1 
 drivers/block/zram/zram_drv.c       |   19 ----
 drivers/lightnvm/core.c             |   24 +----
 drivers/md/bcache/super.c           |   15 ---
 drivers/md/dm.c                     |   16 +--
 drivers/md/md.c                     |   25 ++----
 drivers/memstick/core/ms_block.c    |    1 
 drivers/nvdimm/blk.c                |   27 +-----
 drivers/nvdimm/btt.c                |   25 +-----
 drivers/nvdimm/btt.h                |    2 
 drivers/nvdimm/pmem.c               |   17 +---
 drivers/nvme/host/core.c            |    1 
 drivers/nvme/host/multipath.c       |   46 +++--------
 drivers/s390/block/dcssblk.c        |   26 +-----
 drivers/s390/block/xpram.c          |   26 ++----
 include/linux/blkdev.h              |    1 
 include/linux/genhd.h               |   23 +++++
 30 files changed, 297 insertions(+), 466 deletions(-)
