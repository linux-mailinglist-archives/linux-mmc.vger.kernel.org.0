Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD013BB109
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Jul 2021 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhGDXKd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 4 Jul 2021 19:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhGDXKE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 4 Jul 2021 19:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5950B6162A;
        Sun,  4 Jul 2021 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440042;
        bh=+0RmVVSDzLNt2nkptVlfGz2MqVzeDxn8hiCZHkPC86c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB/evyi83I2dTu3iEuXPJzR3szbJRQBTgpZKowGwyDvL9vXI4MAXf3lg7FQBKiLkc
         4PFShdr9jl72caOMwWycMzFtpFJjWonT2hanmzo1bMraoYm5ilsyytDGa+rXGtblco
         ZKMdHTpBKX6S8H1PbtXNL48QrvgueIRaVQXXm80Zz8/42NjMppQvLEKghYTAsLven3
         TJngsnbAP1MSlHAqJAl8PrwS3s+ynKCy5UK0sgA2Y1lR9Pi1woa+tOQkXmjfR4KnTF
         VNQDllasSKUw0HTKxwW+7n+zlOVgBJkzWrG9zmO2PiwGpPWFvy+nhhSFjIvlxSXmcf
         8lc7EYtEzJn0Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 48/80] memstick: rtsx_usb_ms: fix UAF
Date:   Sun,  4 Jul 2021 19:05:44 -0400
Message-Id: <20210704230616.1489200-48-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230616.1489200-1-sashal@kernel.org>
References: <20210704230616.1489200-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Tong Zhang <ztong0001@gmail.com>

[ Upstream commit 42933c8aa14be1caa9eda41f65cde8a3a95d3e39 ]

This patch fixes the following issues:
1. memstick_free_host() will free the host, so the use of ms_dev(host) after
it will be a problem. To fix this, move memstick_free_host() after when we
are done with ms_dev(host).
2. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
and free host otherwise memstick_check will be called and UAF will
happen.

[   11.351173] BUG: KASAN: use-after-free in rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
[   11.357077]  rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
[   11.357376]  platform_remove+0x2a/0x50
[   11.367531] Freed by task 298:
[   11.368537]  kfree+0xa4/0x2a0
[   11.368711]  device_release+0x51/0xe0
[   11.368905]  kobject_put+0xa2/0x120
[   11.369090]  rtsx_usb_ms_drv_remove+0x8c/0x140 [rtsx_usb_ms]
[   11.369386]  platform_remove+0x2a/0x50

[   12.038408] BUG: KASAN: use-after-free in __mutex_lock.isra.0+0x3ec/0x7c0
[   12.045432]  mutex_lock+0xc9/0xd0
[   12.046080]  memstick_check+0x6a/0x578 [memstick]
[   12.046509]  process_one_work+0x46d/0x750
[   12.052107] Freed by task 297:
[   12.053115]  kfree+0xa4/0x2a0
[   12.053272]  device_release+0x51/0xe0
[   12.053463]  kobject_put+0xa2/0x120
[   12.053647]  rtsx_usb_ms_drv_remove+0xc4/0x140 [rtsx_usb_ms]
[   12.053939]  platform_remove+0x2a/0x50

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20210511163944.1233295-1-ztong0001@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/host/rtsx_usb_ms.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 102dbb8080da..29271ad4728a 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -799,9 +799,9 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 
 	return 0;
 err_out:
-	memstick_free_host(msh);
 	pm_runtime_disable(ms_dev(host));
 	pm_runtime_put_noidle(ms_dev(host));
+	memstick_free_host(msh);
 	return err;
 }
 
@@ -828,9 +828,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	}
 	mutex_unlock(&host->host_mutex);
 
-	memstick_remove_host(msh);
-	memstick_free_host(msh);
-
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal
 	 */
@@ -838,10 +835,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 		pm_runtime_put(ms_dev(host));
 
 	pm_runtime_disable(ms_dev(host));
-	platform_set_drvdata(pdev, NULL);
-
+	memstick_remove_host(msh);
 	dev_dbg(ms_dev(host),
 		": Realtek USB Memstick controller has been removed\n");
+	memstick_free_host(msh);
+	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
2.30.2

