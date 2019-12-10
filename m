Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF2119830
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Dec 2019 22:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfLJVhd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 10 Dec 2019 16:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbfLJVfb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Dec 2019 16:35:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF25B2467C;
        Tue, 10 Dec 2019 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013730;
        bh=8Nar7KQyexigtXQZAEJ9QBpT9ro7aQBOAsTgfZ6PZ/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvcI/s+WOlPAp2QAOMOkDbEkCDDCt/2eINKuB60sC2qmEZk8I6haIYvZbgoVTLJun
         A4YdzGcoM4C3OnG0saYRzYFNTAK7rLnfYpMlMmNIs85oVHhKmqnXzsht2H7frfiTmD
         cmlgzSoUOJely4Ux2MDTu2A6ePTdDEVjBo3w+31A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 155/177] mmc: tmio: Add MMC_CAP_ERASE to allow erase/discard/trim requests
Date:   Tue, 10 Dec 2019 16:31:59 -0500
Message-Id: <20191210213221.11921-155-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

[ Upstream commit c91843463e9e821dc3b48fe37e3155fa38299f6e ]

Isolated initially to renesas_sdhi_internal_dmac [1], Ulf suggested
adding MMC_CAP_ERASE to the TMIO mmc core:

On Fri, Nov 15, 2019 at 10:27:25AM +0100, Ulf Hansson wrote:
 -- snip --
 This test and due to the discussions with Wolfram and you in this
 thread, I would actually suggest that you enable MMC_CAP_ERASE for all
 tmio variants, rather than just for this particular one.

 In other words, set the cap in tmio_mmc_host_probe() should be fine,
 as it seems none of the tmio variants supports HW busy detection at
 this point.
 -- snip --

Testing on R-Car H3ULCB-KF doesn't reveal any issues (v5.4-rc7):

root@rcar-gen3:~# lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
mmcblk0      179:0    0 59.2G  0 disk  <--- eMMC
mmcblk0boot0 179:8    0    4M  1 disk
mmcblk0boot1 179:16   0    4M  1 disk
mmcblk1      179:24   0   30G  0 disk  <--- SD card

root@rcar-gen3:~# time blkdiscard /dev/mmcblk0
real    0m8.659s
user    0m0.001s
sys     0m1.920s

root@rcar-gen3:~# time blkdiscard /dev/mmcblk1
real    0m1.176s
user    0m0.001s
sys     0m0.124s

[1] https://lore.kernel.org/linux-renesas-soc/20191112134808.23546-1-erosca@de.adit-jv.com/

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Originally-by: Harish Jenny K N <harish_kandiga@mentor.com>
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 35630ccbe9e5d..33c9ca8f14a97 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1267,7 +1267,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 			return ret;
 	}
 
-	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
 	mmc->max_blk_size = 512;
-- 
2.20.1

