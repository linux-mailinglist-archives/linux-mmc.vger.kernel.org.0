Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6BD8F1A
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Oct 2019 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfJPLQY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 07:16:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43507 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392661AbfJPLQX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2019 07:16:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so17121184lfl.10
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2019 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNz2l6RmEwE6Fc6A3eEYVtJGEkTSCgiCfzF9GXY5jH0=;
        b=AVuhKq+85lxvZynjjZBWhJwMItoDVGF2xtfG0T9C8RJmHBrK8LioE+U3sD97zp+9b0
         MsJGip+/J8OoYQhsue8AGIv9T+paDfAlXHCBj774LxPHG/gMWnzxnQjl+Br/KI/7+uKF
         E62CUU26+XQBp3GLQcr2neQhnG3Rgfcl2xV1VavMvdle1mNgH5cDBRQbj9OAMgufUslr
         4glYk3GnjV4EKzQQnHdByPT+io9ZdFD7St1Z7/tIFqsLioW8IA58uoP4TaydWjPBsBFc
         3P4ltuzHIZFO3yJTQOJ93vsLOoUOR2GfAuw8xF0N1bztG+OepQIf8q9w5/jD7bpjI10v
         xOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNz2l6RmEwE6Fc6A3eEYVtJGEkTSCgiCfzF9GXY5jH0=;
        b=PN6IDz89Rj2V+sOn2UHdmlx0ZvllPaemS0g2BAh89xleeMlYFClrish8OzCq4k/VF8
         rK9OyL7k9vDGhdJG/2PmQj6QXDTEktnbAovb2HQVlB0tB42aWGvB1fIY6tYpILPX+ED2
         AuVmDbuBRhpqD2fosYe+81Fh4zX9cb+Fh2BXHLaP+C/fTrF/ldLZHPYGpT978rz49ykm
         0eRr48yDjwo6TdW2E6OMujcHimHnmR3xa6p9hK2C5KiN7F2wU5dAWsgDgm2aj5H5imAN
         HRO+WVzbD2PSSNcMCv5+9jfx9nPbZKopXEFVKRrugKp2WdaVEKz140793xxpkZyrpc6P
         B2+w==
X-Gm-Message-State: APjAAAWehx2tQ9WvN6xe6IL/hKKjY2J9KSdqrmKncctof4vf9y2q3JMr
        ZjwIkY21Gfo7FZ6tPcVmg7Q/2OdZ
X-Google-Smtp-Source: APXvYqwgPGdcjoOxbwvA6aB+8qOkSd/BuMupwiBCN3SOzgqKdFXX0ja7og6I58cCtJDrKLUCZXnXfA==
X-Received: by 2002:a05:6512:515:: with SMTP id o21mr24889349lfb.189.1571224581520;
        Wed, 16 Oct 2019 04:16:21 -0700 (PDT)
Received: from laped.kamstrup.dk ([185.181.22.4])
        by smtp.googlemail.com with ESMTPSA id b21sm6544729lff.96.2019.10.16.04.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:16:21 -0700 (PDT)
From:   Lars Pedersen <lapeddk@gmail.com>
X-Google-Original-From: Lars Pedersen <laa@kamstrup.com>
To:     linux-mmc@vger.kernel.org, avri.altman@wdc.com,
        michael.heimpold@i2se.com
Cc:     Lars Pedersen <lapeddk@gmail.com>
Subject: [PATCH 2/2] mmc-utils: Support for bkops start when manual background operation is used.
Date:   Wed, 16 Oct 2019 13:15:42 +0200
Message-Id: <20191016111542.31358-3-laa@kamstrup.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016111542.31358-1-laa@kamstrup.com>
References: <20191016111542.31358-1-laa@kamstrup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Lars Pedersen <lapeddk@gmail.com>

Add bkops start functionality when BKOPS_EN[0](MANUAL_EN) is set.
---
 mmc.c      |  5 +++++
 mmc.h      |  5 +++++
 mmc_cmds.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 57 insertions(+)

diff --git a/mmc.c b/mmc.c
index 9e02ba0..4ea1339 100644
--- a/mmc.c
+++ b/mmc.c
@@ -131,6 +131,11 @@ static struct Command commands[] = {
 		"NOTE!  Only supported in eMMC-5.1 and MANUAL_EN(BKOPS_EN[0]) must not be set",
 	  NULL
 	},
+	{ do_write_bkops_start, -1,
+	  "bkops start", "<device>\n"
+		"Manually start eMMC BKOPS feature on <device>.\nNOTE!  BKOPS_EN[0] must be set.",
+	  NULL
+	},
 	{ do_hwreset_en, -1,
 	  "hwreset enable", "<device>\n"
 		"Permanently enable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
diff --git a/mmc.h b/mmc.h
index 0596d6c..a804067 100644
--- a/mmc.h
+++ b/mmc.h
@@ -80,6 +80,7 @@
 #define EXT_CSD_WR_REL_SET		167
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_SANITIZE_START		165
+#define EXT_CSD_BKOPS_START		164
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
@@ -132,6 +133,10 @@
 #define BKOPS_ENABLE_AUTO_SET	(1<<1) /* AUTO_EN */
 #define BKOPS_ENABLE_AUTO_CLR	(0)  /* AUTO_EN */
 
+/*
+ * BKOPS_START field definition
+ */
+#define BKOPS_START	(1<<0)
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 05a63db..db1e98c 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -829,6 +829,52 @@ int do_write_bkops_auto_en(int nargs, char **argv)
 	return ret;
 }
 
+int do_write_bkops_start(int nargs, char **argv)
+{
+	__u8 ext_csd[512], value = 0;
+	int fd, ret;
+	char *device;
+
+	if (nargs != 2) {
+	       fprintf(stderr, "Usage: mmc bkops start </path/to/mmcblkX>\n");
+	       exit(1);
+	}
+
+	device = argv[1];
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
+	if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
+		fprintf(stderr, "%s doesn't support background operations\n", device);
+		exit(1);
+	}
+
+	if (!(ext_csd[EXT_CSD_BKOPS_EN] & 0x1)) {
+		fprintf(stderr, "%s manual starting of background operations isn't enabled\n", device);
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_BKOPS_START, BKOPS_START);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_BKOPS_EN, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
+
 int do_status_get(int nargs, char **argv)
 {
 	__u32 response;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 7f825ae..91b7ec5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -29,6 +29,7 @@ int do_write_boot_en(int nargs, char **argv);
 int do_boot_bus_conditions_set(int nargs, char **argv);
 int do_write_bkops_manual_en(int nargs, char **argv);
 int do_write_bkops_auto_en(int nargs, char **argv);
+int do_write_bkops_start(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
-- 
2.21.0

