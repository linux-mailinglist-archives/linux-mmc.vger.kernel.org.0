Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585636CC01
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Apr 2021 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhD0Twt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Apr 2021 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhD0Twt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2021 15:52:49 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE144C061574;
        Tue, 27 Apr 2021 12:52:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso6507754oos.6;
        Tue, 27 Apr 2021 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uu73mTAV52nH4kxJ/AjLHVLdDtEAObsKkNqeF1Rq6Q=;
        b=d0JluEuMn8SDvNSaQgAFrAEga2OmXRVtxt6XCBdkE21CtNz+HOY2XU91dCFh07BEZM
         rt/0rD0MiV8roQZrOyZIyBuAFexsRLd8z8F19ysbFwVuyzc0TLzYcybnG94BJMO1BPPJ
         iaAubdUV8pj317iVsYrf0up1Ug9tJub9l5SH81VNrTpCFgfevveP/sqTnJnwCeMDemP/
         cO3H2ioA1q0q9dIC+mXbFvN6Qk27vY1o0Sw8mFJ+WoLJfZCNLdSM5E3r1w2YCzkrh5E1
         SNDiw2AqTKillOIn5qQ7isIUT78qte11lEexGOxoijP0AzeyET9CAXI+PIiPsrERaImq
         HL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uu73mTAV52nH4kxJ/AjLHVLdDtEAObsKkNqeF1Rq6Q=;
        b=lWrdZGMgmgxVbF6LCg6n4teGeGiTVh4h1reTPD8Luu9qKSFjry6LZu2eeklCubriht
         L3hoRtfxBRjgSYq+pYy4JDPp7TZdYoIUodV/+FaCgGjqEK0cPT+wJSEUK1VXdPdryhh2
         MsQtGfSzU2a7Y9pBo+iWWWMhYJ8YPhH48TYIUSeJnb/LrKFtvXf+GIpjceE+jc/mcPGq
         g6eQ2L24N88yloMbcSRCWWkKDaNHuz0+DnZp2zCpPKeAuI0q8sn+NHbKwE8l92rQ9LF6
         U5KnhSkB89bDDqoVB/tvenEnCXJFhi9M/p8N4pQDZU0qmprK3DC7i6QHmJpbjP5Pnwom
         44Sg==
X-Gm-Message-State: AOAM530K4SUeiZjljaCDv9cf6HjVAqo76k9catxgKA753loz5FT+clBn
        hu3MMFPvR8t/X/LU9tPvixOc0aaNjn/DE5cZ
X-Google-Smtp-Source: ABdhPJz3G4gfrXQkC/us1TEbZAfTcRh7qTatZMl8z57rXilQtYdEsi3ze9gW+uGZLV0aFbIZVhSU/g==
X-Received: by 2002:a4a:94c3:: with SMTP id l3mr19220303ooi.12.1619553122134;
        Tue, 27 Apr 2021 12:52:02 -0700 (PDT)
Received: from Kimitos-MBP.hsd1.co.comcast.net ([2601:285:8380:2960::46a0])
        by smtp.gmail.com with ESMTPSA id a21sm855135oop.20.2021.04.27.12.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:52:01 -0700 (PDT)
From:   luserhker@gmail.com
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org, avri.altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3] mmc-utils: Add eMMC erase command support
Date:   Tue, 27 Apr 2021 13:51:57 -0600
Message-Id: <20210427195157.26568-1-luserhker@gmail.com>
X-Mailer: git-send-email 2.24.1 (Apple Git-126)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kimito Sakata <kimito.sakata@oracle.com>

we have been using this erase feature for a while, but it is
still not merged into the upstream mmc-utils. Especially, for
the customer, every time when they update the mmc-utils, they
should re-install this patch again, let's try to make this
erase command upstreamed in the mmc-utils.

We need to send 3 MMC commands and it is important that they
stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.

Co-developed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>

Changelog:
v2--v3:
    1. Remove redundant ifndef

V1--V2:
    1. refactor Kimito's original patch
    2. change to use MMC_IOC_MULTI_CMD
    3. add checkup if eMMC devie supports secure erase/trim
---
 mmc.c      |   8 ++++
 mmc.h      |  13 +++++-
 mmc_cmds.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index f3d724b..eb2638b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -229,6 +229,14 @@ static struct Command commands[] = {
 		"Run Field Firmware Update with <image name> on <device>.\n",
 	  NULL
 	},
+	{ do_erase, -4,
+	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
+		"Send Erase CMD38 with specific argument to the <device>\n\n"
+		"NOTE!: This will delete all user data in the specified region of the device\n"
+		"<type> must be: legacy | discard | secure-erase | "
+		"secure-trim1 | secure-trim2 | trim \n",
+	NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 5754a9d..e9766d7 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,7 +35,15 @@
 #define MMC_SET_WRITE_PROT	28    /* ac   [31:0] data addr   R1b */
 #define MMC_CLEAR_WRITE_PROT	29    /* ac   [31:0] data addr   R1b */
 #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
-
+#define MMC_ERASE_GROUP_START	35    /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE_GROUP_END	36    /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE		38    /* ac   [31] Secure request
+					      [30:16] set to 0
+					      [15] Force Garbage Collect request
+					      [14:2] set to 0
+					      [1] Discard Enable
+					      [0] Identify Write Blocks for
+					      Erase (or TRIM Enable)  R1b */
 /*
  * EXT_CSD fields
  */
@@ -62,6 +70,7 @@
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
 #define EXT_CSD_CACHE_SIZE_0		249
+#define EXT_CSD_SEC_FEATURE_SUPPORT	231
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224
 #define EXT_CSD_HC_WP_GRP_SIZE		221
@@ -190,6 +199,8 @@
 #define EXT_CSD_REV_V4_2		2
 #define EXT_CSD_REV_V4_1		1
 #define EXT_CSD_REV_V4_0		0
+#define EXT_CSD_SEC_GB_CL_EN		(1<<4)
+#define EXT_CSD_SEC_ER_EN		(1<<0)
 
 
 /* From kernel linux/mmc/core.h */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6c24cea..24f80db 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2514,6 +2514,136 @@ int do_cache_dis(int nargs, char **argv)
 	return do_cache_ctrl(0, nargs, argv);
 }
 
+static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
+{
+	int ret = 0;
+	struct mmc_ioc_multi_cmd *multi_cmd;
+
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			   3 * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("Failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	multi_cmd->num_of_cmds = 3;
+	/* Set erase start address */
+	multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
+	multi_cmd->cmds[0].arg = start;
+	multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	multi_cmd->cmds[0].write_flag = 1;
+
+	/* Set erase end address */
+	multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
+	multi_cmd->cmds[1].arg = end;
+	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	multi_cmd->cmds[1].write_flag = 1;
+
+	/* Send Erase Command */
+	multi_cmd->cmds[2].opcode = MMC_ERASE;
+	multi_cmd->cmds[2].arg = argin;
+	multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
+	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	multi_cmd->cmds[2].write_flag = 1;
+
+	/* send erase cmd with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	if (ret)
+		perror("Erase multi-cmd ioctl");
+
+	free(multi_cmd);
+	return ret;
+#endif
+}
+
+int do_erase(int nargs, char **argv)
+{
+	int dev_fd, ret;
+	char *print_str;
+	char **eptr = NULL;
+	__u8 ext_csd[512], checkup_mask = 0;
+	__u32 arg, start, end;
+
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
+		start = strtol(argv[2], eptr, 16);
+	else
+		start = strtol(argv[2], eptr, 10);
+
+	if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
+		end = strtol(argv[3], eptr, 16);
+	else
+		end = strtol(argv[3], eptr, 10);
+
+	if (end < start) {
+		fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
+			start, end);
+		exit(1);
+	}
+
+	if (strcmp(argv[1], "legacy") == 0) {
+		arg = 0x00000000;
+		print_str = "Legacy Erase";
+	} else if (strcmp(argv[1], "discard") == 0) {
+		arg = 0x00000003;
+		print_str = "Discard";
+	} else if (strcmp(argv[1], "secure-erase") == 0) {
+		print_str = "Secure Erase";
+		checkup_mask = EXT_CSD_SEC_ER_EN;
+		arg = 0x80000000;
+	} else if (strcmp(argv[1], "secure-trim1") == 0) {
+		print_str = "Secure Trim Step 1";
+		checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x80000001;
+	} else if (strcmp(argv[1], "secure-trim2") == 0) {
+		print_str = "Secure Trim Step 2";
+		checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x80008000;
+	} else if (strcmp(argv[1], "trim") == 0) {
+		print_str = "Trim";
+		checkup_mask = EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x00000001;
+	} else {
+		fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
+		exit(1);
+	}
+
+	dev_fd = open(argv[4], O_RDWR);
+	if (dev_fd < 0) {
+		perror(argv[4]);
+		exit(1);
+	}
+
+	if (checkup_mask) {
+		ret = read_extcsd(dev_fd, ext_csd);
+		if (ret) {
+			fprintf(stderr, "Could not read EXT_CSD from %s\n",
+				argv[4]);
+			goto out;
+		}
+		if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
+								checkup_mask) {
+			fprintf(stderr, "%s is not supported in %s\n",
+				print_str, argv[4]);
+			ret = -ENOTSUP;
+			goto out;
+		}
+
+	}
+	printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, end);
+
+	ret = erase(dev_fd, arg, start, end);
+out:
+	printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
+	close(dev_fd);
+	return ret;
+}
+
+
 int do_ffu(int nargs, char **argv)
 {
 #ifndef MMC_IOC_MULTI_CMD
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d3246c..8331ab2 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
+int do_erase(int nargs, char **argv);
-- 
2.24.1 (Apple Git-126)

