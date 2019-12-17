Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8D812251F
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Dec 2019 08:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLQHBG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Dec 2019 02:01:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfLQHBG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 02:01:06 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0EF067AFBA0ED9A0CC5;
        Tue, 17 Dec 2019 15:01:01 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 15:00:54 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <zhangpan26@huawei.com>, <hushiyuan@huawei.com>,
        <ulf.hansson@linaro.org>, <allison@lohutok.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: host: use kzalloc instead of kmalloc and memset
Date:   Tue, 17 Dec 2019 15:00:37 +0800
Message-ID: <1576566037-29837-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 drivers/mmc/host/vub300.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6ced1b7..e893ced 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1227,12 +1227,10 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 	size -= 1;
 	if (interrupt_size < size) {
 		u16 xfer_length = roundup_to_multiple_of_64(interrupt_size);
-		u8 *xfer_buffer = kmalloc(xfer_length, GFP_KERNEL);
+		u8 *xfer_buffer = kzalloc(xfer_length, GFP_KERNEL);
 		if (xfer_buffer) {
 			int retval;
 			memcpy(xfer_buffer, data, interrupt_size);
-			memset(xfer_buffer + interrupt_size, 0,
-			       xfer_length - interrupt_size);
 			size -= interrupt_size;
 			data += interrupt_size;
 			retval =
-- 
2.7.4

