Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7F1B57C7
	for <lists+linux-mmc@lfdr.de>; Thu, 23 Apr 2020 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDWJJT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 23 Apr 2020 05:09:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDWJJS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 05:09:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9496F9BBF6822CF50185;
        Thu, 23 Apr 2020 17:09:11 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 17:09:01 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
Date:   Thu, 23 Apr 2020 17:15:19 +0800
Message-ID: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes coccicheck warning:

drivers/mmc/core/debugfs.c:222:0-23: WARNING: mmc_clock_fops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
for debugfs files

Fixes: 703aae3d09a4b ("mmc: add a file to debugfs for changing host clock at runtime")
Fixes: a04c50aaa916f ("mmc: core: no need to check return value of debugfs_create functions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/mmc/core/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 09e0c76..9ec84c8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -219,7 +219,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
+DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
 void mmc_add_host_debugfs(struct mmc_host *host)
@@ -232,8 +232,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
 	debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
 	debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
-	debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
-			    &mmc_clock_fops);
+	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
+				   &mmc_clock_fops);
 
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
-- 
2.6.2

