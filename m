Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4160BDAA
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Oct 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiJXWnI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Mon, 24 Oct 2022 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJXWmn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 18:42:43 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7499168E63
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 14:05:14 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6FA74122F3A;
        Mon, 24 Oct 2022 19:35:24 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 5FA16121965;
        Mon, 24 Oct 2022 19:35:24 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Mon, 24 Oct 2022 19:35:24 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 24 Oct
 2022 19:35:21 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Mon, 24 Oct 2022 19:35:21 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Index: AdjnzoBSTaQo1pFFRXi0S56OT7wLqg==
Date:   Mon, 24 Oct 2022 17:35:20 +0000
Message-ID: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27222.001
X-TMASE-Result: 10--1.662500-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi69nTq7rJdwXKekGZXOwUBuUrr7Qc5WhKjAuQ0xDMaXkMAo
        6b+EBkLgf146W0iUu2sZ6AKZ5CDJjqy/oBy0PY8JSs47mbT7SARMVCcj56k8hrt/YafNBu9cK2g
        uGsQ9MyGiZ+sr4QQVHv0bVLkspps25zIAscb9v20dahq+rGDn//NkoMDX+kiuVC4aflv2vZk8TF
        M4WP/swQUTHiQ6ysBCqhlEJaSjYZAkGC0QjFSfgUXBhxFdFgcQI64EUz6lBaheCiaGE+TES6PFj
        JEFr+olIoOsWgr8s12OhzOa6g8Krfbha8Hd4q3059NgCK88uwJ42ANm+ZWMGE/7CniSRUbZadl/
        dNKPyns=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0ba29e83-2a3f-4d17-9256-bb156984212e-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implements the alternative boot operation for eMMCs.
Note the limitations of the help.

This is mostly useful for testing purposes if you set
up the boot partition configuration correctly.

Usage:
$ sudo dd if=/dev/mmcblk2boot0 of=bootdatammcblk count=2
2+0 records in
2+0 records out
1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s

$ sudo ./mmc boot_operation bootdata 2 /dev/mmcblk2

$ diff -s bootdata bootdatammcblk
Files bootdata and bootdatammcblk are identical

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc.c      | 12 +++++++++
 mmc.h      |  1 +
 mmc_cmds.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 90 insertions(+)

diff --git a/mmc.c b/mmc.c
index 170ee39..f328585 100644
--- a/mmc.c
+++ b/mmc.c
@@ -255,6 +255,18 @@ static struct Command commands[] = {
 	  "Issues a CMD0 GO_PRE_IDLE",
 	  NULL
 	},
+	{ do_alt_boot_op, -1,
+	  "boot_operation", "<boot_data_file> <boot_blocks> <device>\n"
+	  "Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file.\n\n"
+	  "Note some limitations\n:"
+	  "1. The boot operation must be configured, e.g. for legacy speed:\n"
+	  "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n"
+	  "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
+	  "2. The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).\n"
+	  "3. Most hosts cannot do transfers of the typical size of the boot partition, adjust <boot_blocks> accordingly.\n"
+	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 6511dbc..98fad16 100644
--- a/mmc.h
+++ b/mmc.h
@@ -24,6 +24,7 @@
 #define MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_GO_IDLE_STATE_ARG		0x0
 #define MMC_GO_PRE_IDLE_STATE_ARG	0xF0F0F0F0
+#define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3db17e1..1da61d4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3101,3 +3101,79 @@ int do_preidle(int nargs, char **argv)
 
 	return 0;
 }
+
+int do_alt_boot_op(int nargs, char **argv)
+{
+	int fd, ret, boot_data_fd;
+	char *device, *boot_data_file;
+	struct mmc_ioc_multi_cmd *mioc;
+	__u8 ext_csd[512];
+	__u8 *boot_buf;
+	unsigned int boot_blocks, ext_csd_boot_size;
+
+	if (nargs != 4) {
+		fprintf(stderr, "Usage: mmc boot_op <boot_data_file> <boot_blocks> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+	boot_data_file = argv[1];
+	boot_blocks = strtol(argv[2], NULL, 10);
+	device = argv[3];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open device");
+		exit(1);
+	}
+	boot_data_fd = open(boot_data_file, O_WRONLY | O_CREAT, 0644);
+	if (boot_data_fd < 0) {
+		perror("open boot data file");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		perror("read extcsd");
+		exit(1);
+	}
+	ext_csd_boot_size = ext_csd[226] * 128 * 1024;
+	if (boot_blocks * 512 > ext_csd_boot_size) {
+		perror("Requested boot size bigger than boot partition");
+		exit(1);
+	}
+
+	boot_buf = calloc(1, sizeof(__u8) * boot_blocks * 512);
+	mioc = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			   2 * sizeof(struct mmc_ioc_cmd));
+	if (!mioc || !boot_buf) {
+		perror("Failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	mioc->num_of_cmds = 2;
+	mioc->cmds[0].opcode = MMC_GO_IDLE_STATE;
+	mioc->cmds[0].arg = MMC_GO_PRE_IDLE_STATE_ARG;
+	mioc->cmds[0].flags = MMC_RSP_NONE | MMC_CMD_AC;
+	mioc->cmds[0].write_flag = 0;
+
+	mioc->cmds[1].opcode = MMC_GO_IDLE_STATE;
+	mioc->cmds[1].arg = MMC_BOOT_INITIATION_ARG;
+	mioc->cmds[1].flags = MMC_RSP_NONE | MMC_CMD_ADTC;
+	mioc->cmds[1].write_flag = 0;
+	mioc->cmds[1].blksz = 512;
+	mioc->cmds[1].blocks = boot_blocks;
+	/* Access time of boot part differs wildly, spec mandates 1s */
+	mioc->cmds[1].data_timeout_ns = 2 * 1000 * 1000 * 1000;
+	mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
+
+	ret = ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
+	if (ret)
+		perror("multi-cmd ioctl error %d\n", ret);
+	close(fd);
+
+	ret = DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512);
+	if (ret < 0) {
+		perror("Write error\n");
+		exit(1);
+	}
+	return 0;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index faab362..5f2bef1 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
 int do_preidle(int nargs, char **argv);
+int do_alt_boot_op(int nargs, char **argv);
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

