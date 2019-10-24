Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC1E3558
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Oct 2019 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405680AbfJXORI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 24 Oct 2019 10:17:08 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40582 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405266AbfJXORI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Oct 2019 10:17:08 -0400
Received: by mail-lf1-f44.google.com with SMTP id i15so11855052lfo.7
        for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2019 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dES9Xo+9/R7jzfLTta3Y8IdhMhHAziTRk3ND1c2gP48=;
        b=cmifzL1VviwDQVFjIs62LGCX93rhOx168ZhFPsLj2rvnPg8j/xmS0BNoQEvoUiXv9P
         RpSQL6aUY8EXvhsA6xHp75wGJzDEPZOK1znFrBlQwSIiBBerXmCIuxQE9U6pMPHyOh2E
         bAbxYmoMbPOrU9qM9Twt2Eo/+dIotEq1ukKelVE/zly7WEb3OdDMC6OsC2AZO/ZhTv0r
         Dn1+Wi55jY2z8cHr9vLVeDPg4IomXIsBtSJaOYK7K+U0mJIo+4HkCpjkG5A1iaLg0CPP
         VKRkmEfuN9RbaphP94+ZeCrzDrD5ssPcOPsgWOtuLModC/nJca7QBEPhHmvcQTd6yPiz
         ROoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dES9Xo+9/R7jzfLTta3Y8IdhMhHAziTRk3ND1c2gP48=;
        b=rnYpaQKG7hq3NhG+0+NWf8t/9VLMpP/7xC4x37N0VEB8IFstehSrKPTGJdXLXxS1xg
         ZyVTSiJ88yfroI0dq6MnZmoXObE+OhoY6j1N2sAzqbOQ2QdCvZ8WC2hPv7ScikX1FZCJ
         JA2Aib3xM8Y39FFe0VC6HMRGqQ4Th0Tzmdo04yNlyRNnwMZFwteY9Hklnqp9K1U0eNca
         XcUrBm7td4FzMHJQxL1ALXJqfe7CeAQv/kkE3w1yzUsr0VhN/AY62vU5eiFy5HiX5rDp
         Vwoqx+cABwcoIGHMqvvHoSyql/A3Bf+XegQWHmP+l9yQXtpSzsn4MBkSUgnP0LE7glfe
         9Fwg==
X-Gm-Message-State: APjAAAXyVZNc92OFBoMqaCOmtW0ayAzFgJPc+VGThOWG6SOS5kIUDtD1
        y2uFV3evN6Oe5C2MymRC8vIU50MX
X-Google-Smtp-Source: APXvYqyRAZFcXVwf/F/KFfrFIl767ssbYIwtLUIjdLhAK4+hA6gwL7K9kDL9rUtzID3TxYA8ig5KgA==
X-Received: by 2002:ac2:5de9:: with SMTP id z9mr17899385lfq.5.1571926625231;
        Thu, 24 Oct 2019 07:17:05 -0700 (PDT)
Received: from laped.kamstrup.dk ([185.181.22.4])
        by smtp.googlemail.com with ESMTPSA id b20sm10692267ljo.106.2019.10.24.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:17:04 -0700 (PDT)
From:   Lars Pedersen <lapeddk@gmail.com>
To:     linux-mmc@vger.kernel.org, michael.heimpold@i2se.com,
        avri.altman@wdc.com
Cc:     Lars Pedersen <lapeddk@gmail.com>
Subject: [PATCH v2 1/1] mmc-utils: Support MANUAL_EN and AUTO_EN in BKOPS_EN register
Date:   Thu, 24 Oct 2019 16:16:34 +0200
Message-Id: <20191024141634.19287-2-lapeddk@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024141634.19287-1-lapeddk@gmail.com>
References: <20191024141634.19287-1-lapeddk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The BKOPS_EN register in eMMC 5.1 now has two fields AUTO_EN and MANUAL_EN.

Signed-off-by: Lars Pedersen <lapeddk@gmail.com>
---
 mmc.c      | 14 ++++++++----
 mmc.h      |  7 ++++--
 mmc_cmds.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 mmc_cmds.h |  3 ++-
 4 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..9e02ba0 100644
--- a/mmc.c
+++ b/mmc.c
@@ -120,9 +120,15 @@ static struct Command commands[] = {
 	  "<boot_bus_width> must be \"x1|x4|x8\"",
 	  NULL
 	},
-	{ do_write_bkops_en, -1,
-	  "bkops enable", "<device>\n"
-		"Enable the eMMC BKOPS feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	{ do_write_bkops_manual_en, -1,
+	  "bkops manual enable", "<device>\n"
+		"Enable eMMC BKOPS MANUAL_EN(BKOPS_EN[0]) on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
+	{ do_write_bkops_auto_en, -2,
+	  "bkops auto", "<mode> <device>\n"
+		"Enable/disable eMMC BKOPS AUTO_EN feature on <device>.\nThe device may perform background operations while not servicing the host.\n"
+		"NOTE!  Only supported in eMMC-5.1 and MANUAL_EN(BKOPS_EN[0]) must not be set",
 	  NULL
 	},
 	{ do_hwreset_en, -1,
@@ -467,7 +473,7 @@ static int parse_args(int argc, char **argv,
 			matchcmd->verb, matchcmd->nargs);
 			return -2;
 	}
-	
+
         if (prepare_args( nargs_, args_, prgname, matchcmd )){
                 fprintf(stderr, "ERROR: not enough memory\\n");
 		return -20;
diff --git a/mmc.h b/mmc.h
index 648fb26..0596d6c 100644
--- a/mmc.h
+++ b/mmc.h
@@ -126,9 +126,12 @@
 #define EN_REL_WR	(1<<2)
 
 /*
- * BKOPS_EN field definition
+ * BKOPS_EN field definitions
  */
-#define BKOPS_ENABLE	(1<<0)
+#define BKOPS_ENABLE_MAN	(1<<0)  /* MANUAL_EN */
+#define BKOPS_ENABLE_AUTO_SET	(1<<1) /* AUTO_EN */
+#define BKOPS_ENABLE_AUTO_CLR	(0)  /* AUTO_EN */
+
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..05a63db 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -729,14 +729,14 @@ int do_hwreset_dis(int nargs, char **argv)
 	return do_hwreset(EXT_CSD_HW_RESET_DIS, nargs, argv);
 }
 
-int do_write_bkops_en(int nargs, char **argv)
+int do_write_bkops_manual_en(int nargs, char **argv)
 {
 	__u8 ext_csd[512], value = 0;
 	int fd, ret;
 	char *device;
 
 	if (nargs != 2) {
-	       fprintf(stderr, "Usage: mmc bkops enable </path/to/mmcblkX>\n");
+	       fprintf(stderr, "Usage: mmc bkops manual enable </path/to/mmcblkX>\n");
 	       exit(1);
 	}
 
@@ -759,7 +759,67 @@ int do_write_bkops_en(int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE);
+	ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE_MAN);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_BKOPS_EN, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
+int do_write_bkops_auto_en(int nargs, char **argv)
+{
+	__u8 ext_csd[512], value = 0;
+	int fd, ret;
+	char *device;
+	char *mode;
+
+	if (nargs != 3) {
+	       fprintf(stderr, "Usage: mmc bkops auto enable/disable </path/to/mmcblkX>\n");
+	       exit(1);
+	}
+
+	mode = argv[1];
+	device = argv[2];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	if (ext_csd[EXT_CSD_REV] != EXT_CSD_REV_V5_1) {
+		fprintf(stderr, "%s doesn't support eMMC 5.1\n", device);
+		exit(1);
+	}
+
+	if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
+		fprintf(stderr, "%s doesn't support BKOPS\n", device);
+		exit(1);
+	}
+
+	if ((ext_csd[EXT_CSD_BKOPS_EN] & 0x1)) {
+		fprintf(stderr, "%s manual BKOPS already enabled.\n", device);
+		exit(1);
+	}
+
+	if (strcmp(mode, "enable") == 0) {
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE_AUTO_SET);
+	} else if (strcmp(mode, "disable") == 0) {
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE_AUTO_CLR);
+	} else {
+		fprintf(stderr, "%s invalid mode for BKOPS_EN AUTO_EN requested: %s. Valid options: enable or disable\n", mode, device);
+		exit(1);
+	}
+
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, EXT_CSD_BKOPS_EN, device);
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d3246c..7f825ae 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -27,7 +27,8 @@ int do_writeprotect_user_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
 int do_write_boot_en(int nargs, char **argv);
 int do_boot_bus_conditions_set(int nargs, char **argv);
-int do_write_bkops_en(int nargs, char **argv);
+int do_write_bkops_manual_en(int nargs, char **argv);
+int do_write_bkops_auto_en(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
-- 
2.21.0

