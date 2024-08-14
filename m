Return-Path: <linux-mmc+bounces-3325-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE085951EAD
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2024 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5281F23149
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19911B5819;
	Wed, 14 Aug 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hF+P9gIN"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E391AED24
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649768; cv=none; b=CxAupB1+GWMyqa39ZCZ/Lj+KBtVe4NYdMwT4A7OP35e1LEg8aLdJ+7KlVdV+7BuC2dJ9Szod7Tx1UgKpAYxnkZz5G+wikEAa9GGnf4cPh6NPh7u53SRS7Mexlnd4umoQAnaPv5rzJQb2qdkEMqT8VDzrsMgI7vP8urAtJY4UCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649768; c=relaxed/simple;
	bh=YYOJ0L04QfsOatu61D9ba61rpfp5u8fSRxxbKNAgV5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NR9QSWVgnLLYJ28KnR+4u1ut3PbuqhyCRYco8i+h3FLQ170aUDYey2ifsqBbfq51O6trrzjzHTeiBKkPqxstVlqom8WvobeeS8M9zlvZoJMltRnQMAaNhV+srdl3uwkwdY0170i1tQAdwq6HBVTLN4IKoyh9g2zMCQ3GlmW58gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hF+P9gIN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f149845d81so202271fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723649764; x=1724254564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ16tr5XF5Is4Okm/11kEaz0x3cT4Ust2HHO8GPoBAg=;
        b=hF+P9gINevCY+7tLKVT3pCuTkatmYlO7L1YaPHA8BpH0rbL924/1OM+jBBE3Pfku51
         5YvliPi31wVgq9HEMG+ruVPcsYi0FjkPdhEt1m9fj3nFDRhZaHBnaRjX9ViRxyiUzTvE
         hBWtGv9HpstL6/cZvTHcdNg+la3jHiBkwqOD1Ff5etVdlKiK7d1C28C5xmk5muOXX/6X
         ex2a/daHfPe5aJH3DgR4MW+vD2kA5d5b/JlbzU3bgRFXkx0iJX9MjLFPyYmOE9H5lHDk
         DE5LqEu0bwz7taMRTPbfulcQwd0/T2tQtYAq4DLVlQI1BmbhLICu1QJXmYQdDBdNpaSY
         Ir9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649764; x=1724254564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ16tr5XF5Is4Okm/11kEaz0x3cT4Ust2HHO8GPoBAg=;
        b=LmSoqdJRcGGvXQjuXbGxDui+Fr3vMlVfvsWqmrQYXCwESoxvzLjQ2skMyRpwGq8Rlk
         83eTC1wmIPhO3ouRbddx3ygI1xKTUAhn1whK1Q7O0CPmCEL+AJ6RAL/pzA94GlqpraU/
         6tjQJBxNRr+jxfGW/AJNVljgxgVxcwx5BbnBmMVCFQoMrlA1wcS+UxhL5AcesntHyOif
         zYStEW6gahcjCWcNb44KB952smSMFcDJaPtmXZa9tzvfwTyPDs1jwMeLfelIeMJkc96S
         Of0+v0+T+gqXbJa+A+GdATOGZKCWtyquGRHjL8LdKk3ARGzvJQU0rHIwVX391SgK+QfS
         qDHg==
X-Forwarded-Encrypted: i=1; AJvYcCWhIt0S77iX98Cdgiby9xMMppnuR0umszvlrxOva4Z7xLSgnPyXxUu05MucRmCCCs3h2SceJ4EmKTcRRvUu6tQSJlfO/nVr3kCS
X-Gm-Message-State: AOJu0YzjIYrQtAhifGMBbT5aKWYgJc71wJsP8eZgX1zjoEiZxZEyFSo+
	m91zEvr2P8bgKNmeDJU1ZBQ9RZ19IeraEuM0xBMNM5kxtUcAlUlEQ/FtVfUrhKQ=
X-Google-Smtp-Source: AGHT+IEuXcf+PSogeB23R2+iah2c6up9I9gYtRaHWKdtCaImJjShqq1ezAmGZvJwF4iNg4MLScDplg==
X-Received: by 2002:a2e:bea2:0:b0:2ef:320e:cbe9 with SMTP id 38308e7fff4ca-2f3aa1d8157mr25273211fa.9.1723649763414;
        Wed, 14 Aug 2024 08:36:03 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm185532566b.199.2024.08.14.08.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:36:02 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 14 Aug 2024 17:35:55 +0200
Message-Id: <20240814153558.708365-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
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
Tested-by: Manuel Traut <manut@mecka.net>
---
 MAINTAINERS              |   7 ++
 drivers/misc/Kconfig     |  10 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 123 +++++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..716011964b18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19838,6 +19838,13 @@ T:	git git://linuxtv.org/media_tree.git
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
index 41c3d2821a78..21403392d809 100644
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
index c2f990862d2b..a9f94525e181 100644
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
index 000000000000..c8888267c222
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
+static DEFINE_IDA(rpmb_ida);
+static DEFINE_MUTEX(rpmb_mutex);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		get_device(&rdev->dev);
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
+		put_device(&rdev->dev);
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
+	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
+					rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->descr.dev_id);
+	kfree(rdev);
+}
+
+static struct class rpmb_class = {
+	.name = "rpmb",
+	.dev_release = rpmb_dev_release,
+};
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @start: rpmb device to begin with
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
+				      int (*match)(struct device *dev,
+						   const void *data))
+{
+	struct device *dev;
+	const struct device *start_dev = NULL;
+
+	if (start)
+		start_dev = &start->dev;
+	dev = class_find_device(&rpmb_class, start_dev, data, match);
+
+	return dev ? to_rpmb_dev(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
+
+int rpmb_interface_register(struct class_interface *intf)
+{
+	intf->class = &rpmb_class;
+
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+void rpmb_interface_unregister(struct class_interface *intf)
+{
+	class_interface_unregister(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
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
+	device_del(&rdev->dev);
+
+	rpmb_dev_put(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @descr: RPMB device description
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
+	int ret;
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
+		ret = -ENOMEM;
+		goto err_free_rdev;
+	}
+
+	mutex_lock(&rpmb_mutex);
+	ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	mutex_unlock(&rpmb_mutex);
+	if (ret < 0)
+		goto err_free_dev_id;
+	rdev->id = ret;
+
+	dev_set_name(&rdev->dev, "rpmb%d", rdev->id);
+	rdev->dev.class = &rpmb_class;
+	rdev->dev.parent = dev;
+
+	ret = device_register(&rdev->dev);
+	if (ret)
+		goto err_id_remove;
+
+	dev_dbg(&rdev->dev, "registered device\n");
+
+	return rdev;
+
+err_id_remove:
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+err_free_dev_id:
+	kfree(rdev->descr.dev_id);
+err_free_rdev:
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+static int __init rpmb_init(void)
+{
+	int ret;
+
+	ret = class_register(&rpmb_class);
+	if (ret) {
+		pr_err("couldn't create class\n");
+		return ret;
+	}
+	ida_init(&rpmb_ida);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	ida_destroy(&rpmb_ida);
+	class_unregister(&rpmb_class);
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
index 000000000000..cccda73eea4d
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
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
+ * @dev              : device
+ * @id               : device_id
+ * @list_node        : linked list node
+ * @descr            : RPMB description
+ */
+struct rpmb_dev {
+	struct device dev;
+	int id;
+	struct list_head list_node;
+	struct rpmb_descr descr;
+};
+
+#define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct device *dev,
+						   const void *data));
+int rpmb_interface_register(struct class_interface *intf);
+void rpmb_interface_unregister(struct class_interface *intf);
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   struct rpmb_descr *descr);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
+
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
+		     int (*match)(struct device *dev, const void *data))
+{
+	return NULL;
+}
+
+static inline int rpmb_interface_register(struct class_interface *intf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rpmb_interface_unregister(struct class_interface *intf)
+{
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, struct rpmb_descr *descr)
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
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
-- 
2.34.1


