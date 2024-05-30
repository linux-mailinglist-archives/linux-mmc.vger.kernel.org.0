Return-Path: <linux-mmc+bounces-2244-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD98D4393
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190F11C21D04
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FA1CAB2;
	Thu, 30 May 2024 02:15:18 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1181C6BE;
	Thu, 30 May 2024 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035318; cv=none; b=rqdn8nuSth9t5l+ICrF2r7FS+rKkm++hu+TRYSpvDXu2m1Atwir5MtbmkFkxB+CTqt7ZGCQj9vJHVmeTD7qt1pnY+pNN0qrA/ov6bipRRQdp5nLwpaaK3UcRiO3lkPt2W81CRsYIGtrOmAgir7vxsY7Fsz+BK79zaSvDFeBVjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035318; c=relaxed/simple;
	bh=H02eYHE1BedVpEUBdE0xG8/wNXYB9wQeEmhHAiAsL2U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHJGDTxllmB82XoqE590Fjsd5h2YohyUcr+4M02NrUkMt2vqrO6+ar0RpyXtmznbdbiX5t5lodFxUfcs0oymk+NtrAvjcj9/h2URUi1LMotZMNZoaf40NJPiC0cf6Hd3Wauy2MoqOY0NNMpp85qGPqJIgYtcXdi7+eaRhmJU4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVJq-000000004gi-0v8J;
	Thu, 30 May 2024 02:15:06 +0000
Date: Thu, 30 May 2024 03:15:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2 5/9] nvmem: implement block NVMEM provider
Message-ID: <96554d6b4d9fa72f936c2c476eb0b023cdd60a64.1717031992.git.daniel@makrotopia.org>
References: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717031992.git.daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing any block device or partition in Device Tree to
allow e.g. Ethernet and Wi-Fi drivers accessing them via the NVMEM layer.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/nvmem/Kconfig  |  11 +++
 drivers/nvmem/Makefile |   2 +
 drivers/nvmem/block.c  | 198 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/nvmem/block.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 283134498fbc..1d6df20301a4 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -40,6 +40,17 @@ config NVMEM_APPLE_EFUSES
 	  This driver can also be built as a module. If so, the module will
 	  be called nvmem-apple-efuses.
 
+config NVMEM_BLOCK
+	tristate "Block device NVMEM provider"
+	depends on BLOCK
+	depends on OF
+	depends on NVMEM
+	select BLOCK_NOTIFIERS
+	help
+	  Allow block devices (or partitions) to act as NVMEM prodivers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 config NVMEM_BCM_OCOTP
 	tristate "Broadcom On-Chip OTP Controller support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index cdd01fbf1313..68fcf845f417 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
 nvmem-bcm-ocotp-y			:= bcm-ocotp.o
+obj-$(CONFIG_NVMEM_BLOCK)		+= nvmem-block.o
+nvmem-block-y				:= block.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)		+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y			:= brcm_nvram.o
 obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
diff --git a/drivers/nvmem/block.c b/drivers/nvmem/block.c
new file mode 100644
index 000000000000..dc9e43f98616
--- /dev/null
+++ b/drivers/nvmem/block.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/blkdev.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+/* List of all NVMEM devices */
+static LIST_HEAD(nvmem_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+struct blk_nvmem {
+	struct nvmem_device	*nvmem;
+	struct device		*dev;
+	struct list_head	list;
+};
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	unsigned long offs = from & ~PAGE_MASK, to_read;
+	pgoff_t f_index = from >> PAGE_SHIFT;
+	struct blk_nvmem *bnv = priv;
+	size_t bytes_left = bytes;
+	struct file *bdev_file;
+	struct folio *folio;
+	void *p;
+	int ret = 0;
+
+	bdev_file = bdev_file_open_by_dev(bnv->dev->devt, mode, priv, NULL);
+	if (!bdev_file)
+		return -ENODEV;
+
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index++, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			goto err_release_bdev;
+		}
+		to_read = min_t(unsigned long, bytes_left, PAGE_SIZE - offs);
+		p = folio_address(folio) + offset_in_folio(folio, offs);
+		memcpy(val, p, to_read);
+		offs = 0;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+err_release_bdev:
+	fput(bdev_file);
+
+	return ret;
+}
+
+static int blk_nvmem_register(struct device *dev)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct device_node *np = dev_of_node(dev);
+	struct nvmem_config config = {};
+	struct blk_nvmem *bnv;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	if (!of_get_child_by_name(np, "nvmem-layout"))
+		return 0;
+
+	/*
+	 * skip devices which don't have GENHD_FL_NVMEM set
+	 *
+	 * This flag is used for mtdblock and ubiblock devices because
+	 * both, MTD and UBI already implement their own NVMEM provider.
+	 * To avoid registering multiple NVMEM providers for the same
+	 * device node, don't register the block NVMEM provider for them.
+	 */
+	if (!(bdev->bd_disk->flags & GENHD_FL_NVMEM))
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices
+	 * which are using an 'int' as address
+	 */
+	if (bdev_nr_bytes(bdev) > INT_MAX)
+		return -EFBIG;
+
+	bnv = kzalloc(sizeof(struct blk_nvmem), GFP_KERNEL);
+	if (!bnv)
+		return -ENOMEM;
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = &bdev->bd_device;
+	config.name = dev_name(&bdev->bd_device);
+	config.owner = THIS_MODULE;
+	config.priv = bnv;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bnv->dev = &bdev->bd_device;
+	bnv->nvmem = nvmem_register(&config);
+	if (IS_ERR(bnv->nvmem)) {
+		dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
+			      "Failed to register NVMEM device\n");
+
+		kfree(bnv);
+		return PTR_ERR(bnv->nvmem);
+	}
+
+	mutex_lock(&devices_mutex);
+	list_add_tail(&bnv->list, &nvmem_devices);
+	mutex_unlock(&devices_mutex);
+
+	return 0;
+}
+
+static void blk_nvmem_unregister(struct device *dev)
+{
+	struct blk_nvmem *bnv_c, *bnv = NULL;
+
+	mutex_lock(&devices_mutex);
+	list_for_each_entry(bnv_c, &nvmem_devices, list) {
+		if (bnv_c->dev == dev) {
+			bnv = bnv_c;
+			break;
+		}
+	}
+
+	if (!bnv) {
+		mutex_unlock(&devices_mutex);
+		return;
+	}
+
+	list_del(&bnv->list);
+	mutex_unlock(&devices_mutex);
+	nvmem_unregister(bnv->nvmem);
+	kfree(bnv);
+}
+
+static int blk_nvmem_handler(struct notifier_block *this, unsigned long code, void *obj)
+{
+	struct device *dev = (struct device *)obj;
+
+	switch (code) {
+	case BLK_DEVICE_ADD:
+		return blk_nvmem_register(dev);
+	case BLK_DEVICE_REMOVE:
+		blk_nvmem_unregister(dev);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct notifier_block blk_nvmem_notifier = {
+	.notifier_call = blk_nvmem_handler,
+};
+
+static int __init blk_nvmem_init(void)
+{
+	blk_register_notify(&blk_nvmem_notifier);
+
+	return 0;
+}
+
+static void __exit blk_nvmem_exit(void)
+{
+	blk_unregister_notify(&blk_nvmem_notifier);
+}
+
+module_init(blk_nvmem_init);
+module_exit(blk_nvmem_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_DESCRIPTION("block device NVMEM provider");
-- 
2.45.1

