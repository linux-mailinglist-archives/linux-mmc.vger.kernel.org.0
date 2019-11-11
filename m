Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46F3F72AB
	for <lists+linux-mmc@lfdr.de>; Mon, 11 Nov 2019 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKKLBi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 06:01:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35454 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLBi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 06:01:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id y6so9507477lfj.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLQnYO1CQJ5oZbHPD178tBwE395cXhvU2xCJx9re5Lo=;
        b=RhyMrTCEvzQHGD4Scik+67Yf9PmvN0HkKM9oLT64c9R0yB7JGWfYgHPccN+pX97se3
         WRrByAztZmUqBkSPn+ENYG59MAEuodMqCQEEweFdRE95xLrOqxBhE5ZNMPbP7KwBXi70
         eoL0C3PulZ86Ar3CtCkBi8XGeVajYidymOfxMHZD0q+P2R6h6SM1u9RO5hOjai5sV3tL
         VlUNN6vtgyNiH7EMRrtpnlP361W3vHPXT3BeuowrXKttQ8UdVYY8/PBUH12vRhOUpEF2
         aljgg6LeRMXakBSvvPTalzHs4HdPx8psRBS91lQzl27kkSXqkiPPbfqnA68DKsjQiWKY
         y9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLQnYO1CQJ5oZbHPD178tBwE395cXhvU2xCJx9re5Lo=;
        b=IBB9PdRoBCAgBFMGlfemn7HfVP+3vTF1gAc99aNzNJ2MyTqgCFV4RFTHZ0Frzb5SlO
         wXZWNw95FE3bzWhPgrP0ir2wK1c1PMnV0W5TwPf3KUQUcAmnP0fq73oZzihOxXFDtyES
         IWXgXJ79xvlXoH/bAeHJwfUbPhnnXDB9ksWwiT3IHzsclaMHIICzE6kUe1u3rE+xn62z
         Oug0cR5T3CXL7Jsc/od81pDLtkxyPz0p54FVRUM5u4NhA7ce0XPpahaLNN+4/GkG3qsS
         EZ82xxD5hc+6nv9ADMFOjEPHcwF/VgyPExlmiB0MA5b4CHtYtIrBG3DLHX1usYOAJMpw
         5oyQ==
X-Gm-Message-State: APjAAAVwa7jyckQVfPvKav29GCjefRydn1piQE7Fw3mvNu/5tL18Bkba
        vs3LvXRFlHPCWIqEIYqZbObGPBs1
X-Google-Smtp-Source: APXvYqxnGsJic+8ytv2T4Q8F5t4oXwYn5o//ZHiu7pGY77l8guM6Bm2YsEqUQXKh5s8zMSZGH3kNKg==
X-Received: by 2002:ac2:5b42:: with SMTP id i2mr15272456lfp.164.1573470096621;
        Mon, 11 Nov 2019 03:01:36 -0800 (PST)
Received: from laped.kamstrup.dk ([185.181.22.4])
        by smtp.googlemail.com with ESMTPSA id s26sm2367457ljm.35.2019.11.11.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:01:35 -0800 (PST)
From:   Lars Pedersen <lapeddk@gmail.com>
To:     linux-mmc@vger.kernel.org, michael.heimpold@i2se.com,
        avri.altman@wdc.com
Cc:     Lars Pedersen <lapeddk@gmail.com>
Subject: [PATCH v3] mmc-utils: Add AUTO_EN support in the BKOPS_EN
Date:   Mon, 11 Nov 2019 12:00:51 +0100
Message-Id: <20191111110051.16490-1-lapeddk@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds support to enable auto(AUTO_EN) and
manual(MANUAL_EN) in BKOPS_EN register. Auto bkops
can only be used on eMMC 5.0 or newer.

Signed-off-by: Lars Pedersen <lapeddk@gmail.com>
---
v3:
 - Simplified setting of auto and manual BKOPS into old
   bkops_en function.

v2:
- Added signed-off-by for patches
- Dropped patch for BKOPS start support, since its already
  controlled in the host controller. (mmc_run_bkops)

 mmc.c      |  9 ++++++---
 mmc.h      |  5 +++--
 mmc_cmds.c | 23 ++++++++++++++++-------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..513fb78 100644
--- a/mmc.c
+++ b/mmc.c
@@ -120,9 +120,12 @@ static struct Command commands[] = {
 	  "<boot_bus_width> must be \"x1|x4|x8\"",
 	  NULL
 	},
-	{ do_write_bkops_en, -1,
-	  "bkops enable", "<device>\n"
-		"Enable the eMMC BKOPS feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	{ do_write_bkops_en, -2,
+	  "bkops_en", "<auto|manual> <device>\n"
+		"Enable the eMMC BKOPS feature on <device>.\n"
+		"The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.\n"
+		"Setting auto won't have any effect if manual is set.\n"
+		"NOTE!  Setting manual (MANUAL_EN) is one-time programmable (unreversible) change.",
 	  NULL
 	},
 	{ do_hwreset_en, -1,
diff --git a/mmc.h b/mmc.h
index 648fb26..027cf57 100644
--- a/mmc.h
+++ b/mmc.h
@@ -126,9 +126,10 @@
 #define EN_REL_WR	(1<<2)
 
 /*
- * BKOPS_EN field definition
+ * BKOPS_EN field definitions
  */
-#define BKOPS_ENABLE	(1<<0)
+#define BKOPS_MAN_ENABLE	(1<<0)
+#define BKOPS_AUTO_ENABLE	(1<<1)
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..f433f6f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -734,13 +734,15 @@ int do_write_bkops_en(int nargs, char **argv)
 	__u8 ext_csd[512], value = 0;
 	int fd, ret;
 	char *device;
+	char *en_type;
 
-	if (nargs != 2) {
-	       fprintf(stderr, "Usage: mmc bkops enable </path/to/mmcblkX>\n");
-	       exit(1);
+	if (nargs != 3) {
+		fprintf(stderr, "Usage: mmc bkops_en <auto|manual> </path/to/mmcblkX>\n");
+		exit(1);
 	}
 
-	device = argv[1];
+	en_type = argv[1];
+	device = argv[2];
 
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
@@ -754,12 +756,19 @@ int do_write_bkops_en(int nargs, char **argv)
 		exit(1);
 	}
 
-	if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
-		fprintf(stderr, "%s doesn't support BKOPS\n", device);
+	if (strcmp(en_type, "auto") == 0) {
+		if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
+			fprintf(stderr, "%s doesn't support AUTO_EN in the BKOPS_EN register\n", device);
+			exit(1);
+		}
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE);
+	} else if (strcmp(en_type, "manual") == 0) {
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE);
+	} else {
+		fprintf(stderr, "%s invalid mode for BKOPS_EN requested: %s. Valid options: auto or manual\n", en_type, device);
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, EXT_CSD_BKOPS_EN, device);
-- 
2.23.0

