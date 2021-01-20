Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E342FD19C
	for <lists+linux-mmc@lfdr.de>; Wed, 20 Jan 2021 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbhATM7J (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 20 Jan 2021 07:59:09 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45498 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389287AbhATMLx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 07:11:53 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KCB7rN009131;
        Wed, 20 Jan 2021 04:11:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=7rQcgcFOLF/2qtkEeErkcXGbtpIioxnTdrggX0o13p4=;
 b=BU5b6VSO1CEwnFcjU74HlBZhfUW99TwdPS/gfK6/0EPolNXdPPKPFhkMBqsu9a20rM5F
 9mAuZjWO19L6VdtdyHtHyQd0f+K+YK3scGXnhm00TCgr+pGCZXrygN4KU99Aly8RapJr
 /xZnlARG9OD6zGMXRLUlcpV98+1enzVnsdFGrkKtJfrtERy1whQonseKvHZ8xXwv790Y
 7mAs6hgb6kigmW/NplM4Z+b3oNrK2f8JN75VwK2IofCmmEzQxRtcoTphZ42lIUZaoKE2
 Z2xLNDqyVg0sGFwWOmo7Fil+m1UrQ9kQa7er88FWzqDTBXyMYSj0YtZGAKjHhAtwjTIe KQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3668p7j27c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 04:11:06 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Jan
 2021 04:11:04 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Jan
 2021 04:11:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jan 2021 04:11:04 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 22C6F3F7041;
        Wed, 20 Jan 2021 04:11:01 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <ulf.hansson@linaro.org>, <keescook@chromium.org>,
        <ccross@android.com>, <tony.luck@intel.com>, <sgoutham@marvell.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bhaskara Budiredla" <bbudiredla@marvell.com>
Subject: [PATCH v5 1/2] mmc: Support kmsg dumper based on pstore/blk
Date:   Wed, 20 Jan 2021 17:40:46 +0530
Message-ID: <20210120121047.2601-2-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120121047.2601-1-bbudiredla@marvell.com>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_05:2021-01-20,2021-01-20 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch introduces to mmcpstore. The functioning of mmcpstore
is similar to mtdpstore. mmcpstore works on FTL based flash devices
whereas mtdpstore works on raw flash devices. When the system crashes,
mmcpstore stores the kmsg panic and oops logs to a user specified
MMC device.

It collects the details about the host MMC device through pstore/blk
"blkdev" parameter. The user can specify the MMC device in many ways
by checking in Documentation/admin-guide/pstore-blk.rst.

The individual mmc host drivers have to define suitable polling and
cleanup subroutines to write kmsg panic/oops logs through mmcpstore.
These new host operations are needed as pstore panic write runs with
interrupts disabled.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 drivers/mmc/core/Kconfig     |  14 ++-
 drivers/mmc/core/Makefile    |   1 +
 drivers/mmc/core/block.c     |  19 +++
 drivers/mmc/core/block.h     |   9 ++
 drivers/mmc/core/core.c      |  44 +++++++
 drivers/mmc/core/mmcpstore.c | 227 +++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h     |   5 +
 include/linux/mmc/host.h     |  12 ++
 8 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index c12fe13e4b14..4c651da4f2d2 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -34,9 +34,22 @@ config PWRSEQ_SIMPLE
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
 
+config MMC_PSTORE_BACKEND
+	bool "Log panic/oops to a MMC buffer"
+	depends on MMC_BLOCK
+	help
+	  This option will let you create platform backend to store kmsg
+	  crash dumps to a user specified MMC device. This is primarily
+	  based on pstore/blk.
+
+config MMC_PSTORE
+	tristate
+	select PSTORE_BLK
+
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on BLOCK
+	select MMC_PSTORE if MMC_PSTORE_BACKEND=y
 	default y
 	help
 	  Say Y here to enable the MMC block device driver support.
@@ -80,4 +93,3 @@ config MMC_TEST
 
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
-
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 95ffe008ebdf..7cb9a3af4827 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -16,5 +16,6 @@ obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
+mmc_block-$(CONFIG_MMC_PSTORE)	+= mmcpstore.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 42e27a298218..6592722cd7b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2870,6 +2870,21 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
 #endif /* CONFIG_DEBUG_FS */
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+sector_t mmc_blk_get_part(struct mmc_card *card, int part_num, sector_t *size)
+{
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct gendisk *disk = md->disk;
+	struct disk_part_tbl *part_tbl = disk->part_tbl;
+
+	if (part_num < 0 || part_num >= part_tbl->len)
+		return 0;
+
+	*size = part_tbl->part[part_num]->nr_sects << SECTOR_SHIFT;
+	return part_tbl->part[part_num]->start_sect;
+}
+#endif
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
@@ -2913,6 +2928,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 			goto out;
 	}
 
+	if (mmc_card_mmc(card) || mmc_card_sd(card))
+		mmcpstore_card_set(card, md->disk->disk_name);
+
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
@@ -3060,6 +3078,7 @@ static void __exit mmc_blk_exit(void)
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
 	bus_unregister(&mmc_rpmb_bus_type);
+	unregister_mmcpstore();
 }
 
 module_init(mmc_blk_init);
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f41..2a4ee5568194 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -16,5 +16,14 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq);
 struct work_struct;
 
 void mmc_blk_mq_complete_work(struct work_struct *work);
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+sector_t mmc_blk_get_part(struct mmc_card *card, int part_num, sector_t *size);
+void mmcpstore_card_set(struct mmc_card *card, const char *disk_name);
+void unregister_mmcpstore(void);
+#else
+static inline void mmcpstore_card_set(struct mmc_card *card,
+					const char *disk_name) {}
+static inline void unregister_mmcpstore(void) {}
+#endif
 
 #endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 19f1ee57fb34..7ad7ff1cab8c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -569,6 +569,30 @@ int mmc_cqe_recovery(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_cqe_recovery);
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+/**
+ *	mmc_wait_for_pstore_req - initiate a blocking mmc request
+ *	@host: MMC host to start command
+ *	@mrq: MMC request to start
+ *
+ *	Start a blocking MMC request for a host and wait for the request
+ *	to complete that is based on polling and timeout.
+ */
+void mmc_wait_for_pstore_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	unsigned int timeout;
+
+	host->ops->req_cleanup_pending(host);
+	mmc_start_request(host, mrq);
+
+	if (mrq->data) {
+		timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
+		host->ops->req_completion_poll(host, timeout);
+	}
+}
+EXPORT_SYMBOL(mmc_wait_for_pstore_req);
+#endif
+
 /**
  *	mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
  *	@host: MMC host
@@ -817,6 +841,26 @@ int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
 }
 EXPORT_SYMBOL(__mmc_claim_host);
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+/**
+ *	mmc_claim_host_async - claim host in atomic context
+ *	@host: mmc host to claim
+ *
+ *	This routine may be called in panic/oops scenarios.
+ *	Return zero with host claim success, else busy status.
+ */
+int mmc_claim_host_async(struct mmc_host *host)
+{
+	if (!host->claimed && pm_runtime_active(mmc_dev(host))) {
+		host->claimed = 1;
+		return 0;
+	}
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL(mmc_claim_host_async);
+#endif
+
 /**
  *	mmc_release_host - release a host
  *	@host: mmc host to release
diff --git a/drivers/mmc/core/mmcpstore.c b/drivers/mmc/core/mmcpstore.c
new file mode 100644
index 000000000000..f783ea215f18
--- /dev/null
+++ b/drivers/mmc/core/mmcpstore.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MMC pstore support based on pstore/blk
+ *
+ * Copyright (c) 2020 Marvell.
+ * Author: Bhaskara Budiredla <bbudiredla@marvell.com>
+ */
+
+#define pr_fmt(fmt) "mmcpstore: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pstore_blk.h>
+#include <linux/blkdev.h>
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/scatterlist.h>
+#include "block.h"
+#include "card.h"
+#include "core.h"
+
+static struct mmcpstore_context {
+	char dev_name[BDEVNAME_SIZE];
+	int partno;
+	sector_t start_sect;
+	sector_t size;
+	struct pstore_blk_config conf;
+	struct pstore_blk_info info;
+
+	struct mmc_card	*card;
+	struct mmc_request *mrq;
+} oops_cxt;
+
+static void mmc_prep_req(struct mmc_request *mrq,
+		unsigned int sect_offset, unsigned int nsects,
+		struct scatterlist *sg, u32 opcode, unsigned int flags)
+{
+	mrq->cmd->opcode = opcode;
+	mrq->cmd->arg = sect_offset;
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	if (nsects == 1) {
+		mrq->stop = NULL;
+	} else {
+		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
+		mrq->stop->arg = 0;
+		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
+	mrq->data->blksz = SECTOR_SIZE;
+	mrq->data->blocks = nsects;
+	mrq->data->flags = flags;
+	mrq->data->sg = sg;
+	mrq->data->sg_len = 1;
+}
+
+static int mmcpstore_panic_write_req(const char *buf,
+		unsigned int nsects, unsigned int sect_offset)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	struct mmc_request *mrq = cxt->mrq;
+	struct mmc_card *card = cxt->card;
+	struct mmc_host *host = card->host;
+	struct scatterlist sg;
+	u32 opcode;
+	int ret;
+
+	opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK : MMC_WRITE_BLOCK;
+	mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, MMC_DATA_WRITE);
+	sg_init_one(&sg, buf, (nsects << SECTOR_SHIFT));
+	mmc_set_data_timeout(mrq->data, cxt->card);
+
+	ret = mmc_claim_host_async(host);
+	if (ret)
+		return ret;
+
+	mmc_wait_for_pstore_req(host, mrq);
+	return 0;
+}
+
+static int mmcpstore_panic_write(const char *buf, sector_t off, sector_t sects)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	int ret;
+
+	ret = mmcpstore_panic_write_req(buf, sects, cxt->start_sect + off);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct block_device *mmcpstore_open_backend(const char *device)
+{
+	struct block_device *bdev;
+	dev_t devt;
+
+	bdev = blkdev_get_by_path(device, FMODE_READ, NULL);
+	if (IS_ERR(bdev)) {
+		devt = name_to_dev_t(device);
+		if (devt == 0)
+			return ERR_PTR(-ENODEV);
+
+		bdev = blkdev_get_by_dev(devt, FMODE_READ, NULL);
+		if (IS_ERR(bdev))
+			return bdev;
+	}
+
+	return bdev;
+}
+
+static void mmcpstore_close_backend(struct block_device *bdev)
+{
+	if (!bdev)
+		return;
+	blkdev_put(bdev, FMODE_READ);
+}
+
+void mmcpstore_card_set(struct mmc_card *card, const char *disk_name)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	struct pstore_blk_config *conf = &cxt->conf;
+	struct pstore_blk_info *info = &cxt->info;
+	struct block_device *bdev;
+	struct mmc_command *stop;
+	struct mmc_command *cmd;
+	struct mmc_request *mrq;
+	struct mmc_data *data;
+	int ret;
+
+	ret = pstore_blk_get_config(conf);
+	if (!conf->device[0]) {
+		pr_debug("psblk backend is empty\n");
+		return;
+	}
+
+	/* Multiple backend devices not allowed */
+	if (cxt->dev_name[0])
+		return;
+
+	bdev =  mmcpstore_open_backend(conf->device);
+	if (IS_ERR(bdev)) {
+		pr_err("%s failed to open with %ld\n",
+				conf->device, PTR_ERR(bdev));
+		return;
+	}
+
+	bdevname(bdev, cxt->dev_name);
+	cxt->partno = bdev->bd_part->partno;
+	mmcpstore_close_backend(bdev);
+
+	if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
+		return;
+
+	cxt->start_sect = mmc_blk_get_part(card, cxt->partno, &cxt->size);
+	if (!cxt->start_sect) {
+		pr_err("Non-existent partition %d selected\n", cxt->partno);
+		return;
+	}
+
+	/* Check for host mmc panic write polling function definitions */
+	if (!card->host->ops->req_cleanup_pending ||
+			!card->host->ops->req_completion_poll)
+		return;
+
+	cxt->card = card;
+
+	mrq = kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
+	if (!mrq)
+		goto out;
+
+	cmd = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
+	if (!cmd)
+		goto free_mrq;
+
+	stop = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
+	if (!stop)
+		goto free_cmd;
+
+	data = kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
+	if (!data)
+		goto free_stop;
+
+	mrq->cmd = cmd;
+	mrq->data = data;
+	mrq->stop = stop;
+	cxt->mrq = mrq;
+
+	info->major = MMC_BLOCK_MAJOR;
+	info->flags = PSTORE_FLAGS_DMESG;
+	info->panic_write = mmcpstore_panic_write;
+	ret = register_pstore_blk(info);
+	if (ret) {
+		pr_err("%s registering with psblk failed (%d)\n",
+				cxt->dev_name, ret);
+		goto free_data;
+	}
+
+	pr_info("%s registered as psblk backend\n", cxt->dev_name);
+	return;
+
+free_data:
+	kfree(data);
+free_stop:
+	kfree(stop);
+free_cmd:
+	kfree(cmd);
+free_mrq:
+	kfree(mrq);
+out:
+	return;
+}
+
+void unregister_mmcpstore(void)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+
+	unregister_pstore_blk(MMC_BLOCK_MAJOR);
+	kfree(cxt->mrq->data);
+	kfree(cxt->mrq->stop);
+	kfree(cxt->mrq->cmd);
+	kfree(cxt->mrq);
+	cxt->card = NULL;
+}
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 29aa50711626..53840a361b5a 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -166,6 +166,11 @@ struct mmc_request {
 
 struct mmc_card;
 
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+void mmc_wait_for_pstore_req(struct mmc_host *host, struct mmc_request *mrq);
+int mmc_claim_host_async(struct mmc_host *host);
+#endif
+
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 01bba36545c5..ba9001498e03 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -178,6 +178,18 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+	/*
+	 * The following two APIs are introduced to support mmcpstore
+	 * functionality. Cleanup API to terminate the ongoing and
+	 * pending requests before a panic write post, and polling API
+	 * to ensure that write succeeds before the Kernel dies.
+	 */
+	void	(*req_cleanup_pending)(struct mmc_host *host);
+	int	(*req_completion_poll)(struct mmc_host *host,
+				       unsigned long timeout);
+#endif
 };
 
 struct mmc_cqe_ops {
-- 
2.17.1

