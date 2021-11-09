Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675144A385
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Nov 2021 02:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbhKIB1b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Nov 2021 20:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243195AbhKIBXO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Nov 2021 20:23:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF2761A7C;
        Tue,  9 Nov 2021 01:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636420125;
        bh=I4SmqnossPhHxOXUZ77imqOgFRIT8hdLs0FlF0lcN0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olLJ4iI/cU8wZMmZ5w4DPNZxZ/W1pdlWuwJJacFmHAzE5w0AxGmo1/fO7KmxEI9Mp
         a8wVE/ABvkr711/a2MEy1AxLE+exuMgQU72lK2+G0F8f+hxZBYQvKG3UuzSGAM4jgQ
         sSHk7x65pv6yqg3dZ1m0sZ87tnnOZxg3Xn4IYTyHENiIwrJSSMq3MLuT1cKrxq//f1
         p9CRlW2Fqq/svFOeTeRGABhnxPHoiQo4RXQY554KpX00OrMCDHm2swgaYBd98jPjR0
         khl5nIFgNymXK9NotxVunup6KNel6Y6E9X8PzSjdyLPTzQ4hBZ8Eeutogd2lMjQcwm
         6o6fQtPLuFaog==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheyu Ma <zheyuma97@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, maximlevitsky@gmail.com,
        oakad@yahoo.com, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/33] memstick: r592: Fix a UAF bug when removing the driver
Date:   Mon,  8 Nov 2021 20:07:55 -0500
Message-Id: <20211109010807.1191567-21-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109010807.1191567-1-sashal@kernel.org>
References: <20211109010807.1191567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Zheyu Ma <zheyuma97@gmail.com>

[ Upstream commit 738216c1953e802aa9f930c5d15b8f9092c847ff ]

In r592_remove(), the driver will free dma after freeing the host, which
may cause a UAF bug.

The following log reveals it:

[   45.361796 ] BUG: KASAN: use-after-free in r592_remove+0x269/0x350 [r592]
[   45.364286 ] Call Trace:
[   45.364472 ]  dump_stack_lvl+0xa8/0xd1
[   45.364751 ]  print_address_description+0x87/0x3b0
[   45.365137 ]  kasan_report+0x172/0x1c0
[   45.365415 ]  ? r592_remove+0x269/0x350 [r592]
[   45.365834 ]  ? r592_remove+0x269/0x350 [r592]
[   45.366168 ]  __asan_report_load8_noabort+0x14/0x20
[   45.366531 ]  r592_remove+0x269/0x350 [r592]
[   45.378785 ]
[   45.378903 ] Allocated by task 4674:
[   45.379162 ]  ____kasan_kmalloc+0xb5/0xe0
[   45.379455 ]  __kasan_kmalloc+0x9/0x10
[   45.379730 ]  __kmalloc+0x150/0x280
[   45.379984 ]  memstick_alloc_host+0x2a/0x190
[   45.380664 ]
[   45.380781 ] Freed by task 5509:
[   45.381014 ]  kasan_set_track+0x3d/0x70
[   45.381293 ]  kasan_set_free_info+0x23/0x40
[   45.381635 ]  ____kasan_slab_free+0x10b/0x140
[   45.381950 ]  __kasan_slab_free+0x11/0x20
[   45.382241 ]  slab_free_freelist_hook+0x81/0x150
[   45.382575 ]  kfree+0x13e/0x290
[   45.382805 ]  memstick_free+0x1c/0x20
[   45.383070 ]  device_release+0x9c/0x1d0
[   45.383349 ]  kobject_put+0x2ef/0x4c0
[   45.383616 ]  put_device+0x1f/0x30
[   45.383865 ]  memstick_free_host+0x24/0x30
[   45.384162 ]  r592_remove+0x242/0x350 [r592]
[   45.384473 ]  pci_device_remove+0xa9/0x250

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Link: https://lore.kernel.org/r/1634383581-11055-1-git-send-email-zheyuma97@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/host/r592.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 2539984c1db1c..256634ec58b63 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -841,15 +841,15 @@ static void r592_remove(struct pci_dev *pdev)
 	}
 	memstick_remove_host(dev->host);
 
+	if (dev->dummy_dma_page)
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
+			dev->dummy_dma_page_physical_address);
+
 	free_irq(dev->irq, dev);
 	iounmap(dev->mmio);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	memstick_free_host(dev->host);
-
-	if (dev->dummy_dma_page)
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
-			dev->dummy_dma_page_physical_address);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.33.0

