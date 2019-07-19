Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55B06DF09
	for <lists+linux-mmc@lfdr.de>; Fri, 19 Jul 2019 06:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfGSEcW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Jul 2019 00:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbfGSED6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6033218A3;
        Fri, 19 Jul 2019 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509037;
        bh=N/baHv5FccMsejpscTTRCDSezMRcSj1IH53OyTadKEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoWUELr/dyp1qLi+azac2ApGY1o01ZhVj7g60zXATWtxE7ENOZDFpUO6Fmi2H5JDa
         Ft8TpFoMezX73jdxXYV4IXX/5K4v/7v6KfDvvqCqtJZG0ppqdUVvMMw5XKI6JUm7Tf
         hc9EWWEnexeK6U2haQgSBKoJTshvBg/t5LC6UDBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Hai <wanghai26@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 034/141] memstick: Fix error cleanup path of memstick_init
Date:   Fri, 19 Jul 2019 00:00:59 -0400
Message-Id: <20190719040246.15945-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Wang Hai <wanghai26@huawei.com>

[ Upstream commit 65f1a0d39c289bb6fc85635528cd36c4b07f560e ]

If bus_register fails. On its error handling path, it has cleaned up
what it has done. There is no need to call bus_unregister again.
Otherwise, if bus_unregister is called, issues such as null-ptr-deref
will arise.

Syzkaller report this:

kobject_add_internal failed for memstick (error: -12 parent: bus)
BUG: KASAN: null-ptr-deref in sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
Read of size 8 at addr 0000000000000078 by task syz-executor.0/4460

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa9/0x10e lib/dump_stack.c:113
 __kasan_report+0x171/0x18d mm/kasan/report.c:321
 kasan_report+0xe/0x20 mm/kasan/common.c:614
 sysfs_remove_file_ns+0x1b/0x40 fs/sysfs/file.c:467
 sysfs_remove_file include/linux/sysfs.h:519 [inline]
 bus_remove_file+0x6c/0x90 drivers/base/bus.c:145
 remove_probe_files drivers/base/bus.c:599 [inline]
 bus_unregister+0x6e/0x100 drivers/base/bus.c:916 ? 0xffffffffc1590000
 memstick_init+0x7a/0x1000 [memstick]
 do_one_initcall+0xb9/0x3b5 init/main.c:914
 do_init_module+0xe0/0x330 kernel/module.c:3468
 load_module+0x38eb/0x4270 kernel/module.c:3819
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
 do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai26@huawei.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/memstick.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 1246d69ba187..b1564cacd19e 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -629,13 +629,18 @@ static int __init memstick_init(void)
 		return -ENOMEM;
 
 	rc = bus_register(&memstick_bus_type);
-	if (!rc)
-		rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_destroy_workqueue;
 
-	if (!rc)
-		return 0;
+	rc = class_register(&memstick_host_class);
+	if (rc)
+		goto error_bus_unregister;
+
+	return 0;
 
+error_bus_unregister:
 	bus_unregister(&memstick_bus_type);
+error_destroy_workqueue:
 	destroy_workqueue(workqueue);
 
 	return rc;
-- 
2.20.1

