Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC00461B5B
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Nov 2021 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhK2Pyf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Nov 2021 10:54:35 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:52839 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234066AbhK2Pwf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Nov 2021 10:52:35 -0500
Received: from oleh-pc.lan (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id CCC221A20D0A;
        Mon, 29 Nov 2021 17:48:34 +0200 (EET)
From:   Oleh Kravchenko <oleg@kaa.org.ua>
To:     Avri Altman <avri.altman@wdc.com>,
        Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, patchwork-bot@kernel.org
Cc:     Oleh Kravchenko <oleg@kaa.org.ua>, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4] mmc-utils: Use printf() to extract and print fw version
Date:   Mon, 29 Nov 2021 17:48:26 +0200
Message-Id: <20211129154826.23595-1-oleg@kaa.org.ua>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211116105109.3830-1-oleg@kaa.org.ua>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch also fixes a compile error with a newer version of GCC:
error: '__builtin_strncpy' output may be truncated copying 8 bytes from
a string of length 511 [-Werror=stringop-truncation]

Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 mmc_cmds.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

PATCH v4
Update commit message.

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 73bd32a..e07ec94 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1392,7 +1392,6 @@ int do_read_extcsd(int nargs, char **argv)
 	__u32 regl;
 	int fd, ret;
 	char *device;
-	char lbuf[10];
 	const char *str;
 
 	if (nargs != 2) {
@@ -1834,9 +1833,7 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-                memset(lbuf, 0, sizeof(lbuf));
-		strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
-		printf("eMMC Firmware Version: %s\n", lbuf);
+		printf("eMMC Firmware Version: %.8s\n", (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.32.0

