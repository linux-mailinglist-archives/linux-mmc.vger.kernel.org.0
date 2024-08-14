Return-Path: <linux-mmc+bounces-3328-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CE951EB4
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2024 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86191F22365
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Aug 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE11B8EBE;
	Wed, 14 Aug 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQ8bMBjy"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C31B86EF
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649773; cv=none; b=GZtwh+CYATmwYIuOBLnWurCaUN9kvzEkUpOYIbASPvKG5SIx0ayo2FiowQrYnB5uMD6QVo+uGAyUqoCJMzwzK1AZ050BmoVFa74ibZJBorduseGWDrlH/qk6C2NS7w4AEndiqkUegU/WRRTV6DXpXsQxwEi+9rKs+34dPu7gjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649773; c=relaxed/simple;
	bh=GNIgkSPQGJVdI7kD9gEmCUIhRXr1y908y3ZivifHEsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNwftgBGXKrvZLf3piidDldH4tnkPCFM+LRhXfrXDnFYg6i9QWBCh2KrC2gxVe6dvq2ZmtslYAUPl0E+68NBrC3esSZWpxwlxBiaoVuljE/dRRGhkmEo+mB7sWGL5SwixH3C1Kox/kJ+2FmI+L8j2Q28rYqUKmKmUj0qrgB6qR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQ8bMBjy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8553db90so1995366b.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723649769; x=1724254569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKgU4dOhg4UPd4NaczhdmgeJakoZkjeRqG8HeCd4c1I=;
        b=SQ8bMBjymxGYkVRmgxJ0o1gDH8eqo/nig2BhITmmQ9rUbQG3PE8ZtBvXcvlwGiWshA
         S45lQg/Zw6BcUhSnqMuBY45umVuuT0u4U2/compOWdKb2d5cvgx1MpOLuYHuYK3VCr6u
         v/oM+xoWv+rN58z/UK3i+wdwghXVhGZoTPU00+tuWJeqxQIDHNv6XQtDKVwMKqwnu5+O
         Vcx7qP1tQCKZYSxYsH5moZvh0jX66AfscBj53+H9Cwsfy7OAP8aECNE1RBLJIcdICTx8
         o97UUih3ETFts4GGB5e180FSBBI4xlcqZsKDy7cmjvrje6UMmYVyxCOw4fBjMzB4RTM5
         NMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649769; x=1724254569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKgU4dOhg4UPd4NaczhdmgeJakoZkjeRqG8HeCd4c1I=;
        b=qFYaacSDTUnK3SK6Y/y3DnpROKf//3d9INtl6w12yTerP0itaqJ7VHSTOYPMZpKI4v
         V4hrLbkRqXGShwjXtzwvk9JrdfcVNfJVin0+Ml7EFLhxcPSvghUhOc5EDUICsHp1f+R4
         OyT+A6Uin577Rgi+7BfIslLqUVMJMXnvubBxF05OH9OKzxfvV4iMdaYIGyM7SlD8WcwT
         VHLz3Mee4+4Q4vSdNqvCS6+BBFhBW4lPO2jCD3dIDT3MKVUzg68Da20yCkMekvs45Qz7
         WVLL0YRuEfeiT2DeB2f3GKL03jE4GrRGU0GT/MUrP7cDXNGI+T4Sh+lt9299p8Y9o2MN
         Xutw==
X-Forwarded-Encrypted: i=1; AJvYcCWH5brMvHJcFLf9fJH/Jcg6hybUaBXP83vflavUTPIR7egob/4J+YEcPswDSCDGiFgi41HrcqoFqdtGrp31L/3REuFzzmjMTIV7
X-Gm-Message-State: AOJu0Yy7FPSqtgbpjt4LWeFMnJlSCIuYLVG65CLMEGqzQ0FnL31Ecf+J
	IIy9EiZR9wPtBfLAth/qj9tbBfVdu2KGPGgLyodnf4kAqs4SuuvDFqXnfqsMWak=
X-Google-Smtp-Source: AGHT+IHWPO8pO4dkM7Obpgk9oZZvUEG5T1hq9MJGfDAcpslUK1shRMaqJgcGxKbsubdAUj2AqN7SxQ==
X-Received: by 2002:a17:907:e6d7:b0:a7a:929f:c0cb with SMTP id a640c23a62f3a-a8366d7837dmr222178266b.38.1723649769407;
        Wed, 14 Aug 2024 08:36:09 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm185532566b.199.2024.08.14.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:36:08 -0700 (PDT)
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
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 14 Aug 2024 17:35:58 +0200
Message-Id: <20240814153558.708365-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
use an RPMB device via the RPMB subsystem instead of passing the RPMB
frames via tee-supplicant in user space. A fallback mechanism is kept to
route RPMB frames via tee-supplicant if the RPMB subsystem isn't
available.

The OP-TEE RPC ABI is extended to support iterating over all RPMB
devices until one is found with the expected RPMB key already
programmed.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Manuel Traut <manut@mecka.net>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-class-tee |  15 ++
 MAINTAINERS                               |   1 +
 drivers/tee/optee/core.c                  |  96 +++++++++++-
 drivers/tee/optee/device.c                |   7 +
 drivers/tee/optee/ffa_abi.c               |  14 ++
 drivers/tee/optee/optee_ffa.h             |   2 +
 drivers/tee/optee/optee_private.h         |  26 +++-
 drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
 drivers/tee/optee/optee_smc.h             |   2 +
 drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c               |  14 ++
 11 files changed, 387 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tee

diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
new file mode 100644
index 000000000000..c9144d16003e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tee
@@ -0,0 +1,15 @@
+What:		/sys/class/tee/tee{,priv}X/rpmb_routing_model
+Date:		May 2024
+KernelVersion:	6.10
+Contact:        op-tee@lists.trustedfirmware.org
+Description:
+		RPMB frames can be routed to the RPMB device via the
+		user-space daemon tee-supplicant or the RPMB subsystem
+		in the kernel. The value "user" means that the driver
+		will route the RPMB frames via user space. Conversely,
+		"kernel" means that the frames are routed via the RPMB
+		subsystem without assistance from tee-supplicant. It
+		should be assumed that RPMB frames are routed via user
+		space if the variable is absent. The primary purpose
+		of this variable is to let systemd know whether
+		tee-supplicant is needed in the early boot with initramfs.
diff --git a/MAINTAINERS b/MAINTAINERS
index 716011964b18..d692417edab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22433,6 +22433,7 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-tee
 F:	Documentation/driver-api/tee.rst
 F:	Documentation/tee/
 F:	Documentation/userspace-api/tee.rst
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 39e688d4e974..c75fddc83576 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -10,17 +10,85 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_core.h>
 #include <linux/types.h>
 #include "optee_private.h"
 
+struct blocking_notifier_head optee_rpmb_intf_added =
+	BLOCKING_NOTIFIER_INIT(optee_rpmb_intf_added);
+
+static int rpmb_add_dev(struct device *dev)
+{
+	blocking_notifier_call_chain(&optee_rpmb_intf_added, 0,
+				     to_rpmb_dev(dev));
+
+	return 0;
+}
+
+static struct class_interface rpmb_class_intf = {
+	.add_dev = rpmb_add_dev,
+};
+
+void optee_bus_scan_rpmb(struct work_struct *work)
+{
+	struct optee *optee = container_of(work, struct optee,
+					   rpmb_scan_bus_work);
+	int ret;
+
+	if (!optee->rpmb_scan_bus_done) {
+		ret = optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB);
+		optee->rpmb_scan_bus_done = !ret;
+		if (ret && ret != -ENODEV)
+			pr_info("Scanning for RPMB device: ret %d\n", ret);
+	}
+}
+
+int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
+			 void *data)
+{
+	struct optee *optee = container_of(intf, struct optee, rpmb_intf);
+
+	schedule_work(&optee->rpmb_scan_bus_work);
+
+	return 0;
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
 }
 
+static ssize_t rpmb_routing_model_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct optee *optee = dev_get_drvdata(dev);
+	const char *s;
+
+	if (optee->in_kernel_rpmb_routing)
+		s = "kernel";
+	else
+		s = "user";
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
+}
+static DEVICE_ATTR_RO(rpmb_routing_model);
+
+static struct attribute *optee_dev_attrs[] = {
+	&dev_attr_rpmb_routing_model.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(optee_dev);
+
+void optee_set_dev_group(struct optee *optee)
+{
+	tee_device_set_dev_groups(optee->teedev, optee_dev_groups);
+	tee_device_set_dev_groups(optee->supp_teedev, optee_dev_groups);
+}
+
 int optee_open(struct tee_context *ctx, bool cap_memref_null)
 {
 	struct optee_context_data *ctxdata;
@@ -97,6 +165,9 @@ void optee_release_supp(struct tee_context *ctx)
 
 void optee_remove_common(struct optee *optee)
 {
+	blocking_notifier_chain_unregister(&optee_rpmb_intf_added,
+					   &optee->rpmb_intf);
+	cancel_work_sync(&optee->rpmb_scan_bus_work);
 	/* Unregister OP-TEE specific client devices on TEE bus */
 	optee_unregister_devices();
 
@@ -113,13 +184,18 @@ void optee_remove_common(struct optee *optee)
 	tee_shm_pool_free(optee->pool);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 }
 
 static int smc_abi_rc;
 static int ffa_abi_rc;
+static bool intf_is_regged;
 
 static int __init optee_core_init(void)
 {
+	int rc;
+
 	/*
 	 * The kernel may have crashed at the same time that all available
 	 * secure world threads were suspended and we cannot reschedule the
@@ -130,18 +206,36 @@ static int __init optee_core_init(void)
 	if (is_kdump_kernel())
 		return -ENODEV;
 
+	if (IS_REACHABLE(CONFIG_RPMB)) {
+		rc = rpmb_interface_register(&rpmb_class_intf);
+		if (rc)
+			return rc;
+		intf_is_regged = true;
+	}
+
 	smc_abi_rc = optee_smc_abi_register();
 	ffa_abi_rc = optee_ffa_abi_register();
 
 	/* If both failed there's no point with this module */
-	if (smc_abi_rc && ffa_abi_rc)
+	if (smc_abi_rc && ffa_abi_rc) {
+		if (IS_REACHABLE(CONFIG_RPMB)) {
+			rpmb_interface_unregister(&rpmb_class_intf);
+			intf_is_regged = false;
+		}
 		return smc_abi_rc;
+	}
+
 	return 0;
 }
 module_init(optee_core_init);
 
 static void __exit optee_core_exit(void)
 {
+	if (IS_REACHABLE(CONFIG_RPMB) && intf_is_regged) {
+		rpmb_interface_unregister(&rpmb_class_intf);
+		intf_is_regged = false;
+	}
+
 	if (!smc_abi_rc)
 		optee_smc_abi_unregister();
 	if (!ffa_abi_rc)
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index d296c70ddfdc..950b4661d5df 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -43,6 +43,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	ret = tee_client_invoke_func(ctx, &inv_arg, param);
 	if ((ret < 0) || ((inv_arg.ret != TEEC_SUCCESS) &&
 			  (inv_arg.ret != TEEC_ERROR_SHORT_BUFFER))) {
+		/*
+		 * TEE_ERROR_STORAGE_NOT_AVAILABLE is returned when getting
+		 * the list of device TAs that depends on RPMB but a usable
+		 * RPMB device isn't found.
+		 */
+		if (inv_arg.ret == TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			return -ENODEV;
 		pr_err("PTA_CMD_GET_DEVICES invoke function err: %x\n",
 		       inv_arg.ret);
 		return -EINVAL;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 3e73efa51bba..f3af5666bb11 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -7,6 +7,7 @@
 
 #include <linux/arm_ffa.h>
 #include <linux/errno.h>
+#include <linux/rpmb.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -909,6 +910,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee->ffa.bottom_half_value = U32_MAX;
 	optee->rpc_param_count = rpc_param_count;
 
+	if (IS_REACHABLE(CONFIG_RPMB) &&
+	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
+		optee->in_kernel_rpmb_routing = true;
+
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
 	if (IS_ERR(teedev)) {
@@ -925,6 +930,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	}
 	optee->supp_teedev = teedev;
 
+	optee_set_dev_group(optee);
+
 	rc = tee_device_register(optee->teedev);
 	if (rc)
 		goto err_unreg_supp_teedev;
@@ -940,6 +947,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx = teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
@@ -961,6 +969,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (rc)
 		goto err_unregister_devices;
 
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	blocking_notifier_chain_register(&optee_rpmb_intf_added,
+					 &optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -974,6 +986,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	teedev_close_context(ctx);
 err_rhashtable_free:
 	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 	mutex_destroy(&optee->ffa.mutex);
diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
index 5db779dc00de..257735ae5b56 100644
--- a/drivers/tee/optee/optee_ffa.h
+++ b/drivers/tee/optee/optee_ffa.h
@@ -92,6 +92,8 @@
 #define OPTEE_FFA_SEC_CAP_ARG_OFFSET	BIT(0)
 /* OP-TEE supports asynchronous notification via FF-A */
 #define OPTEE_FFA_SEC_CAP_ASYNC_NOTIF	BIT(1)
+/* OP-TEE supports probing for RPMB device if needed */
+#define OPTEE_FFA_SEC_CAP_RPMB_PROBE	BIT(2)
 
 #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
 
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 424898cdc4e9..dc0f355ef72a 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -7,7 +7,9 @@
 #define OPTEE_PRIVATE_H
 
 #include <linux/arm-smccc.h>
+#include <linux/notifier.h>
 #include <linux/rhashtable.h>
+#include <linux/rpmb.h>
 #include <linux/semaphore.h>
 #include <linux/tee_core.h>
 #include <linux/types.h>
@@ -20,6 +22,7 @@
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_ITEM_NOT_FOUND	0xFFFF0008
 #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
@@ -28,6 +31,7 @@
 
 /* API Return Codes are from the GP TEE Internal Core API Specification */
 #define TEE_ERROR_TIMEOUT		0xFFFF3001
+#define TEE_ERROR_STORAGE_NOT_AVAILABLE	0xF0100003
 
 #define TEEC_ORIGIN_COMMS		0x00000002
 
@@ -200,6 +204,12 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @mutex:		mutex protecting @rpmb_dev
+ * @rpmb_dev:		current RPMB device or NULL
+ * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
+ *			was already done
+ * @rpmb_scan_bus_work	workq to for an RPMB device and to scan optee bus
+ *			and register RPMB dependent optee drivers
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -218,9 +228,16 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	/* Protects rpmb_dev pointer */
+	struct mutex rpmb_dev_mutex;
+	struct rpmb_dev *rpmb_dev;
+	struct notifier_block rpmb_intf;
 	unsigned int rpc_param_count;
-	bool   scan_bus_done;
+	bool scan_bus_done;
+	bool rpmb_scan_bus_done;
+	bool in_kernel_rpmb_routing;
 	struct work_struct scan_bus_work;
+	struct work_struct rpmb_scan_bus_work;
 };
 
 struct optee_session {
@@ -253,6 +270,8 @@ struct optee_call_ctx {
 	size_t num_entries;
 };
 
+extern struct blocking_notifier_head optee_rpmb_intf_added;
+
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
 int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
@@ -283,9 +302,14 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
 #define PTA_CMD_GET_DEVICES		0x0
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
+#define PTA_CMD_GET_DEVICES_RPMB	0x2
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
+void optee_bus_scan_rpmb(struct work_struct *work);
+int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
+			 void *data);
 
+void optee_set_dev_group(struct optee *optee);
 void optee_remove_common(struct optee *optee);
 int optee_open(struct tee_context *ctx, bool cap_memref_null);
 void optee_release(struct tee_context *ctx);
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index 4576751b490c..87a59cc03480 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -104,4 +104,39 @@
 /* I2C master control flags */
 #define OPTEE_RPC_I2C_FLAGS_TEN_BIT	BIT(0)
 
+/*
+ * Reset RPMB probing
+ *
+ * Releases an eventually already used RPMB devices and starts over searching
+ * for RPMB devices. Returns the kind of shared memory to use in subsequent
+ * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
+ *
+ * [out]    value[0].a	    OPTEE_RPC_SHM_TYPE_*, the parameter for
+ *			    OPTEE_RPC_CMD_SHM_ALLOC
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_RESET	22
+
+/*
+ * Probe next RPMB device
+ *
+ * [out]    value[0].a	    Type of RPMB device, OPTEE_RPC_RPMB_*
+ * [out]    value[0].b	    EXT CSD-slice 168 "RPMB Size"
+ * [out]    value[0].c	    EXT CSD-slice 222 "Reliable Write Sector Count"
+ * [out]    memref[1]       Buffer with the raw CID
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT	23
+
+/* Type of RPMB device */
+#define OPTEE_RPC_RPMB_EMMC		0
+#define OPTEE_RPC_RPMB_UFS		1
+#define OPTEE_RPC_RPMB_NVME		2
+
+/*
+ * Replay Protected Memory Block access
+ *
+ * [in]     memref[0]	    Frames to device
+ * [out]    memref[1]	    Frames from device
+ */
+#define OPTEE_RPC_CMD_RPMB_FRAMES	24
+
 #endif /*__OPTEE_RPC_CMD_H*/
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 7d9fa426505b..879426300821 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -278,6 +278,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world supports probing for RPMB device if needed */
+#define OPTEE_SMC_SEC_CAP_RPMB_PROBE		BIT(7)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 5de4504665be..a4b49fd1d46d 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/tee_core.h>
 #include "optee_private.h"
@@ -261,6 +262,154 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
 	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
 }
 
+static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
+					     struct optee *optee,
+					     struct optee_msg_arg *arg)
+{
+	struct tee_param params[1];
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	params[0].u.value.a = OPTEE_RPC_SHM_TYPE_KERNEL;
+	params[0].u.value.b = 0;
+	params[0].u.value.c = 0;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	optee->rpmb_dev = NULL;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	arg->ret = TEEC_SUCCESS;
+}
+
+static int rpmb_type_to_rpc_type(enum rpmb_type rtype)
+{
+	switch (rtype) {
+	case RPMB_TYPE_EMMC:
+		return OPTEE_RPC_RPMB_EMMC;
+	case RPMB_TYPE_UFS:
+		return OPTEE_RPC_RPMB_UFS;
+	case RPMB_TYPE_NVME:
+		return OPTEE_RPC_RPMB_NVME;
+	default:
+		return -1;
+	}
+}
+
+static int rpc_rpmb_match(struct device *dev, const void *data)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	return rpmb_type_to_rpc_type(rdev->descr.type) >= 0;
+}
+
+static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
+					    struct optee *optee,
+					    struct optee_msg_arg *arg)
+{
+	struct rpmb_dev *rdev;
+	struct tee_param params[2];
+	void *buf;
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
+	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+	buf = tee_shm_get_va(params[1].u.memref.shm,
+			     params[1].u.memref.shm_offs);
+	if (!buf) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rdev = rpmb_dev_find_device(NULL, optee->rpmb_dev, rpc_rpmb_match);
+	rpmb_dev_put(optee->rpmb_dev);
+	optee->rpmb_dev = rdev;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	if (!rdev) {
+		arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	if (params[1].u.memref.size < rdev->descr.dev_id_len) {
+		arg->ret = TEEC_ERROR_SHORT_BUFFER;
+		return;
+	}
+	memcpy(buf, rdev->descr.dev_id, rdev->descr.dev_id_len);
+	params[1].u.memref.size = rdev->descr.dev_id_len;
+	params[0].u.value.a = rpmb_type_to_rpc_type(rdev->descr.type);
+	params[0].u.value.b = rdev->descr.capacity;
+	params[0].u.value.c = rdev->descr.reliable_wr_count;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	arg->ret = TEEC_SUCCESS;
+}
+
+static void handle_rpc_func_rpmb_frames(struct tee_context *ctx,
+					struct optee *optee,
+					struct optee_msg_arg *arg)
+{
+	struct tee_param params[2];
+	struct rpmb_dev *rdev;
+	void *p0, *p1;
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rdev = rpmb_dev_get(optee->rpmb_dev);
+	mutex_unlock(&optee->rpmb_dev_mutex);
+	if (!rdev) {
+		arg->ret = TEEC_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	if (arg->num_params != ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT ||
+	    params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+
+	p0 = tee_shm_get_va(params[0].u.memref.shm,
+			    params[0].u.memref.shm_offs);
+	p1 = tee_shm_get_va(params[1].u.memref.shm,
+			    params[1].u.memref.shm_offs);
+	if (rpmb_route_frames(rdev, p0, params[0].u.memref.size, p1,
+			      params[1].u.memref.size)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+	arg->ret = TEEC_SUCCESS;
+out:
+	rpmb_dev_put(rdev);
+}
+
 void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 		   struct optee_msg_arg *arg)
 {
@@ -277,6 +426,34 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 	case OPTEE_RPC_CMD_I2C_TRANSFER:
 		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
 		break;
+	/*
+	 * optee->in_kernel_rpmb_routing true means that OP-TEE supports
+	 * in-kernel RPMB routing _and_ that the RPMB subsystem is
+	 * reachable. This is reported to user space with
+	 * rpmb_routing_model=kernel in sysfs.
+	 *
+	 * rpmb_routing_model=kernel is also a promise to user space that
+	 * RPMB access will not require supplicant support, hence the
+	 * checks below.
+	 */
+	case OPTEE_RPC_CMD_RPMB_PROBE_RESET:
+		if (optee->in_kernel_rpmb_routing)
+			handle_rpc_func_rpmb_probe_reset(ctx, optee, arg);
+		else
+			handle_rpc_supp_cmd(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB_PROBE_NEXT:
+		if (optee->in_kernel_rpmb_routing)
+			handle_rpc_func_rpmb_probe_next(ctx, optee, arg);
+		else
+			handle_rpc_supp_cmd(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB_FRAMES:
+		if (optee->in_kernel_rpmb_routing)
+			handle_rpc_func_rpmb_frames(ctx, optee, arg);
+		else
+			handle_rpc_supp_cmd(ctx, optee, arg);
+		break;
 	default:
 		handle_rpc_supp_cmd(ctx, optee, arg);
 	}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 844285d4f03c..e9456e3e74cc 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/rpmb.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -1685,6 +1686,10 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.sec_caps = sec_caps;
 	optee->rpc_param_count = rpc_param_count;
 
+	if (IS_REACHABLE(CONFIG_RPMB) &&
+	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
+		optee->in_kernel_rpmb_routing = true;
+
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
@@ -1699,6 +1704,8 @@ static int optee_probe(struct platform_device *pdev)
 	}
 	optee->supp_teedev = teedev;
 
+	optee_set_dev_group(optee);
+
 	rc = tee_device_register(optee->teedev);
 	if (rc)
 		goto err_unreg_supp_teedev;
@@ -1712,6 +1719,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 
 	platform_set_drvdata(pdev, optee);
 	ctx = teedev_open(optee->teedev);
@@ -1766,6 +1774,10 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_disable_shm_cache;
 
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	blocking_notifier_chain_register(&optee_rpmb_intf_added,
+					 &optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -1779,6 +1791,8 @@ static int optee_probe(struct platform_device *pdev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_supp_uninit:
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-- 
2.34.1


