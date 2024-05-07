Return-Path: <linux-mmc+bounces-2058-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FF8BDDE5
	for <lists+linux-mmc@lfdr.de>; Tue,  7 May 2024 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18B81C219E2
	for <lists+linux-mmc@lfdr.de>; Tue,  7 May 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8814D70C;
	Tue,  7 May 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoAPkUc1"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5514D447
	for <linux-mmc@vger.kernel.org>; Tue,  7 May 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073410; cv=none; b=kKemCEIfNsF/meiIX7sW90qPRXhDdAoBXhPNv6m9zKCGHfU0ZpNF2iE0GWfYVL7+Kfk/EHcMWNFt+6R8zMmgRPftuoJkFWyS1Gj4b+sIjfuAiCbRtAkU8P+j8J4QByssXC98b+1hOPh3UkeZxxI948YKWpocVJZa8Wr5qEz2I0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073410; c=relaxed/simple;
	bh=xtfjoy+F0TFftfpW6aEVyLUOPLJP3UlaWdlTryh4muo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6h1e5uiG22uRSKhtuxGMiGSJf+s+6MuFmQ0vcS/fMncm7fs4VMS19w3OTbW5CG3Vw3n8qmUSbirpqVLXDNuNtF9QfbjdUfTa7ViqexYyafL08CUNLSqpLex2aDiOX/8oh4bd6XQN6z+WIE3JSqjAeYeV0QlbttUX/aKDEZRjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hoAPkUc1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599a298990so766009966b.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2024 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715073406; x=1715678206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9LjBnSm4X2/c79mvoHgrjptZ8586gCl8XohRSasTkw=;
        b=hoAPkUc1ZgXIFT4YT4YgINkv81fhsAg2RYWQqUWlshSZhLkt9bRigxMgbAbWk5Ly91
         jNg1T9gn+OKPOae6zmir9/LPI016npG6kG6uvFuoe7/3dAPHsDyAdruD9dPApik2+JLe
         +IHWPRICYct0h5d8t4ax7SaxYfD4JkKaxS91YAQTNZ2GsS4vsPyQbyZiTrxEwSjSeTPm
         hiCf9rTQaS52DdkIG33d1r6sqbtigwr2kfncWmX73qepjdC3GSzVNRJX2WEDM+A1POEh
         RSu0iGfF0zTZFa27ejktcti5B8FYmFvBH9/1JXo8GY8QasyhiAgStuWe4RBIpN32cZBC
         KxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715073406; x=1715678206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9LjBnSm4X2/c79mvoHgrjptZ8586gCl8XohRSasTkw=;
        b=sftbBDT+HKM7yES0qB3/DSga6Jy+Nf4aF99UTeW9l+2tWkOb/WeNxfmabgkUMSJ01T
         +ztDSl+1TVvc4fXlc3f/Dkx/AibKmIodliB/kHr/b/Rc0wQrN19GeCIISm099tpl87PT
         lLmBimYxf/tw7tim+gZel0gHXCexYacheo+CogmmvXToXZTEKk10h6ZA03aZDU4fxJuT
         RIMoPL4groy3y0qKjCJJysrWrYRl7FTqjk+Mk2p9SftOK7xJ1/2DNm4d1yaya0Mjtseg
         BPCXfl/6s1qhg5JPXGjw+mofCY2+19VJVC11ZjUOwm0IoRWsuCNB0zC9L5lYdyJ9dQFJ
         lduw==
X-Forwarded-Encrypted: i=1; AJvYcCXs71ln/qe/t6pqbt2eQ9bX2dMet5PtBo8Tlnj44XKZxeHlbkbf9c9t9YmBZcE1IKU/CAMH7CKAVhDbG7haMXib++0ii1MngsMQ
X-Gm-Message-State: AOJu0Yz6/V3a+GXHPqFAiLZLTJezQZ6HeuwN9OsyMp619OYs+sdIVljJ
	WvMixeRa8Pb996EmuJIJ1il7vKHKzvWFxmi6XMEAOU3/3PSxuRAkRQOwMbBuQMA=
X-Google-Smtp-Source: AGHT+IE4tdunArqXI9jwwHr3Wj7EXrtUgivOO0QldeN+H6bZQnVOx8UGCJlBhVolGl7uVuJOY1d4IQ==
X-Received: by 2002:a17:906:5482:b0:a55:a072:1ab8 with SMTP id r2-20020a170906548200b00a55a0721ab8mr7886576ejo.27.1715073406642;
        Tue, 07 May 2024 02:16:46 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061d4700b00a59a93a3ef4sm3976134ejh.149.2024.05.07.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:16:45 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue,  7 May 2024 11:16:17 +0200
Message-Id: <20240507091619.2208810-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507091619.2208810-1-jens.wiklander@linaro.org>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
RPMB commands. Such a partition provides authenticated and replay
protected access, hence suitable as a secure storage.

The initial aim of this patch is to provide a simple RPMB driver
interface which can be accessed by the optee driver to facilitate early
RPMB access to OP-TEE OS (secure OS) during the boot time.

A TEE device driver can claim the RPMB interface, for example, via
rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
provides a callback to route RPMB frames to the RPMB device accessible
via rpmb_route_frames().

The detailed operation of implementing the access is left to the TEE
device driver itself.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS              |   7 ++
 drivers/misc/Kconfig     |  10 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 136 +++++++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..e83152c42499 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19012,6 +19012,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
 
+RPMB SUBSYSTEM
+M:	Jens Wiklander <jens.wiklander@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/misc/rpmb-core.c
+F:	include/linux/rpmb.h
+
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-remoteproc@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..dbff9e8c3a03 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -104,6 +104,16 @@ config PHANTOM
 	  If you choose to build module, its name will be phantom. If unsure,
 	  say N here.
 
+config RPMB
+	tristate "RPMB partition interface"
+	depends on MMC
+	help
+	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
+	  UFS. Provides interface for in-kernel security controllers to access
+	  RPMB unit.
+
+	  If unsure, select N.
+
 config TIFM_CORE
 	tristate "TI Flash Media interface support"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..8af058ad1df4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
+obj-$(CONFIG_RPMB)		+= rpmb-core.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
new file mode 100644
index 000000000000..e42a45debc76
--- /dev/null
+++ b/drivers/misc/rpmb-core.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
+ * Copyright(c) 2021 - 2024 Linaro Ltd.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rpmb.h>
+#include <linux/slab.h>
+
+static struct list_head rpmb_dev_list;
+static DEFINE_MUTEX(rpmb_mutex);
+static struct blocking_notifier_head rpmb_interface =
+	BLOCKING_NOTIFIER_INIT(rpmb_interface);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		get_device(rdev->parent_dev);
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get);
+
+/**
+ * rpmb_dev_put() - decrease rpmb device ref counter
+ * @rdev: rpmb device
+ */
+void rpmb_dev_put(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		put_device(rdev->parent_dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_put);
+
+/**
+ * rpmb_route_frames() - route rpmb frames to rpmb device
+ * @rdev:	rpmb device
+ * @req:	rpmb request frames
+ * @req_len:	length of rpmb request frames in bytes
+ * @rsp:	rpmb response frames
+ * @rsp_len:	length of rpmb response frames in bytes
+ *
+ * Returns: < 0 on failure
+ */
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
+{
+	if (!req || !req_len || !rsp || !rsp_len)
+		return -EINVAL;
+
+	return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
+					rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * Iterate over registered RPMB devices, and call @match() for each passing
+ * it the RPMB device and @data.
+ *
+ * The return value of @match() is checked for each call. If it returns
+ * anything other 0, break and return the found RPMB device.
+ *
+ * It's the callers responsibility to call rpmb_dev_put() on the returned
+ * device, when it's done with it.
+ *
+ * Returns: a matching rpmb device or NULL on failure
+ */
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct rpmb_dev *rdev,
+						   const void *data))
+{
+	struct rpmb_dev *rdev;
+	struct list_head *pos;
+
+	mutex_lock(&rpmb_mutex);
+	if (start)
+		pos = start->list_node.next;
+	else
+		pos = rpmb_dev_list.next;
+
+	while (pos != &rpmb_dev_list) {
+		rdev = container_of(pos, struct rpmb_dev, list_node);
+		if (match(rdev, data)) {
+			rpmb_dev_get(rdev);
+			goto out;
+		}
+		pos = pos->next;
+	}
+	rdev = NULL;
+
+out:
+	mutex_unlock(&rpmb_mutex);
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ *
+ * This function should be called from the release function of the
+ * underlying device used when the RPMB device was registered.
+ *
+ * Returns: < 0 on failure
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rpmb_mutex);
+	list_del(&rdev->list_node);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->descr.dev_id);
+	kfree(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @ops: device specific operations
+ *
+ * While registering the RPMB partition extract needed device information
+ * while needed resources are available.
+ *
+ * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   struct rpmb_descr *descr)
+{
+	struct rpmb_dev *rdev;
+
+	if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
+	    !descr->dev_id_len)
+		return ERR_PTR(-EINVAL);
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+	rdev->descr = *descr;
+	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
+				     GFP_KERNEL);
+	if (!rdev->descr.dev_id) {
+		kfree(rdev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rdev->parent_dev = dev;
+
+	dev_dbg(rdev->parent_dev, "registered device\n");
+
+	mutex_lock(&rpmb_mutex);
+	list_add_tail(&rdev->list_node, &rpmb_dev_list);
+	blocking_notifier_call_chain(&rpmb_interface, RPMB_NOTIFY_ADD_DEVICE,
+				     rdev);
+	mutex_unlock(&rpmb_mutex);
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+/**
+ * rpmb_interface_register() - register for new device notifications
+ *
+ * @nb : New entry in notifier chain
+ *
+ * Returns: 0 on success  -EEXIST on error.
+ */
+int rpmb_interface_register(struct notifier_block *nb)
+{
+	struct rpmb_dev *rdev;
+	int ret;
+
+	ret = blocking_notifier_chain_register(&rpmb_interface, nb);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rpmb_mutex);
+	list_for_each_entry(rdev, &rpmb_dev_list, list_node)
+		nb->notifier_call(nb, RPMB_NOTIFY_ADD_DEVICE, rdev);
+	mutex_unlock(&rpmb_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+/**
+ * rpmb_interface_unregister() - unregister from new device notifications
+ *
+ * @nb : Entry to remove from notifier chain
+ *
+ * Returns: 0 on success or -ENOENT on failure.
+ */
+int rpmb_interface_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&rpmb_interface, nb);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+
+static int __init rpmb_init(void)
+{
+	INIT_LIST_HEAD(&rpmb_dev_list);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	mutex_destroy(&rpmb_mutex);
+}
+
+subsys_initcall(rpmb_init);
+module_exit(rpmb_exit);
+
+MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
+MODULE_DESCRIPTION("RPMB class");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
new file mode 100644
index 000000000000..3ced206fdc17
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+/**
+ * enum rpmb_type - type of underlying storage technology
+ *
+ * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
+ * @RPMB_TYPE_UFS   : UFS (JESD220)
+ * @RPMB_TYPE_NVME  : NVM Express
+ */
+enum rpmb_type {
+	RPMB_TYPE_EMMC,
+	RPMB_TYPE_UFS,
+	RPMB_TYPE_NVME,
+};
+
+/**
+ * struct rpmb_descr - RPMB description provided by the underlying block device
+ *
+ * @type             : block device type
+ * @route_frames     : routes frames to and from the RPMB device
+ * @dev_id           : unique device identifier read from the hardware
+ * @dev_id_len       : length of unique device identifier
+ * @reliable_wr_count: number of sectors that can be written in one access
+ * @capacity         : capacity of the device in units of 128K
+ *
+ * @dev_id is intended to be used as input when deriving the authenticaion key.
+ */
+struct rpmb_descr {
+	enum rpmb_type type;
+	int (*route_frames)(struct device *dev, u8 *req, unsigned int req_len,
+			    u8 *resp, unsigned int resp_len);
+	u8 *dev_id;
+	size_t dev_id_len;
+	u16 reliable_wr_count;
+	u16 capacity;
+};
+
+/**
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @parent_dev       : parent device
+ * @list_node        : linked list node
+ * @descr            : RPMB description
+ */
+struct rpmb_dev {
+	struct device *parent_dev;
+	struct list_head list_node;
+	struct rpmb_descr descr;
+};
+
+enum rpmb_interface_action {
+	RPMB_NOTIFY_ADD_DEVICE,
+};
+
+/**
+ * struct rpmb_interface - subscribe to new RPMB devices
+ *
+ * @list_node     : linked list node
+ * @add_rdev      : notifies that a new RPMB device has been found
+ */
+struct rpmb_interface {
+	struct list_head list_node;
+	void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *rdev);
+};
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct rpmb_dev *rdev,
+						   const void *data));
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   struct rpmb_descr *descr);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
+
+int rpmb_interface_register(struct notifier_block *nb);
+int rpmb_interface_unregister(struct notifier_block *nb);
+#else
+static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
+
+static inline struct rpmb_dev *
+rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
+		     int (*match)(struct rpmb_dev *rdev, const void *data))
+{
+	return NULL;
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
+{
+	return NULL;
+}
+
+static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
+{
+	return 0;
+}
+
+static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmb_interface_register(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmb_interface_unregister(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
-- 
2.34.1


