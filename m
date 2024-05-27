Return-Path: <linux-mmc+bounces-2210-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8C8CFFBB
	for <lists+linux-mmc@lfdr.de>; Mon, 27 May 2024 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882BE286887
	for <lists+linux-mmc@lfdr.de>; Mon, 27 May 2024 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09515ECE4;
	Mon, 27 May 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqTc79OE"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E315E5D3
	for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812084; cv=none; b=exL8djwcSw2hyJomjxjzjb5mJcNdUYD0CbpOcqw8QJVLuebOOuhZOEd1zPlZQ3Osa2fMzQqsAkr/kt39ZSDa0j3sGMwI+VVM9DnTKtDloSrH9XEu2hiMp7dFqusla7eb85rFe6VZne8jDHnQVfVl8BaCAXrnQxmzkWgyYfA+toI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812084; c=relaxed/simple;
	bh=QD7gnQxv8cIAN7TtB/CTTPJa7RLvuQHAFayQoObEyiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYQy5OJBJMeBsbz0cP7Cz+VyYQXocJY/mh942TnUve88j4KrnaaL3cwzImzBP6dLtiwsD+FAUbaTdOA0zCFT8ebFCo/joX97LZ3eVoegErrGPIVWYP7FM8b6F67dGWMnCm7FY5qv8g4SZLVrwCJ8KRyBj4BiYaJf3wuimmyWVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqTc79OE; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so2801001a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716812080; x=1717416880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xURT2KPwgmYzjI1Hql+2YgnmnDPpF3nkLLW1M9i6H0M=;
        b=XqTc79OEJ7pB3KLxfQMVNiDjGTer40jl7xz1L9bLZk5rIhyvVuXBuorh9vX9H86XtB
         Jz+WE00OMNj92iqlOI1lrX3vflRp7kMsOtR2WKgINYJIAc/hOQDLez+AU6+Rqh/Vvzqk
         BqL1wMgaRLbU3pnPX7xc9mHa7Gkf1eso5pgLGQzRIuAp+xp+ofEvyoZwq7uUAaoovUw+
         ruBNPYwkvL36crZTtDOTYF238Fz0ra5CS6+BfOSwPAXC91k5e+JozMLJD86VEE1Er9Vz
         Ks1b8hzfaL2KNIE3B9b8pkzlj98dZb2LFXPyiUbXbtBy+ZPptpbl32LXN37occ5rvbnD
         S63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812080; x=1717416880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xURT2KPwgmYzjI1Hql+2YgnmnDPpF3nkLLW1M9i6H0M=;
        b=DNNB1RLvSerJNdzRx5pqQz1hZIhk30ghpf6q7IWMCYMdo+q9nFth2HweebDe7S1TOc
         Y32HlvoB6yCmHn3UpTnsDgtNK97jxpU0zwFDR9KpSZd2pRlPCX9LKIuTvlV/EQ+krTAd
         V8hj8kA9CBMcPCtrOs7Zt8DAiQfoXUJQZsPHLOfnTvOJEFX1paqMdmESX/BKv6HZnOhS
         XMSMGht+wR9k8+9ZyHkTeP03B+H7yv0wSUyqyjI9Pi8cem9uz9xk3HQ9PRTdVfBqxRGj
         xpAm7s7wbfoifHy8/yECPJYP4U3F+s9dsuEHOAGgJM6WG/3BvJgvoNu9bA76W5zhs/fN
         9ftQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2IelFD7WlQwchHp6Zy2Dq8S6SefCVDKUUOCDBt3JOJkRF4HmmEOPVgSlL+bZKvnPf+aYHZNYBm3uW2PQDZdM3Tuh/z6tdywNt
X-Gm-Message-State: AOJu0YytToLAlMUS9VDFcwfQUYtEvYnmgqueelRNxrZJnY86ea4QPwTo
	rDoBedCfpJawnTdFhLj25oe/ShatDlrvDlDb9MBNEflQRgfvmGPY3TVGirToiM4=
X-Google-Smtp-Source: AGHT+IE+CJ/HmsAtAe0Rgf8LN8OQ2LRZKOt58Zc2GR+pg/KVtCa8QSwfHK+s/xlJ9tmOyDx9FspfSQ==
X-Received: by 2002:a17:906:2d4a:b0:a59:bdb7:73e8 with SMTP id a640c23a62f3a-a6264f16087mr590890166b.53.1716812079659;
        Mon, 27 May 2024 05:14:39 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c2a8sm484100866b.165.2024.05.27.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:14:38 -0700 (PDT)
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
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Mon, 27 May 2024 14:13:40 +0200
Message-Id: <20240527121340.3931987-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527121340.3931987-1-jens.wiklander@linaro.org>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
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
index 4c671827a08b..0d0bc01fd3eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21709,6 +21709,7 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 L:	op-tee@lists.trustedfirmware.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-tee
 F:	Documentation/driver-api/tee.rst
 F:	Documentation/tee/
 F:	Documentation/userspace-api/tee.rst
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..3194c071a175 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -11,12 +11,28 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_drv.h>
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
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 			       size_t size, size_t align,
 			       int (*shm_register)(struct tee_context *ctx,
@@ -80,11 +96,63 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 	shm->pages = NULL;
 }
 
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
@@ -161,6 +229,9 @@ void optee_release_supp(struct tee_context *ctx)
 
 void optee_remove_common(struct optee *optee)
 {
+	blocking_notifier_chain_unregister(&optee_rpmb_intf_added,
+					   &optee->rpmb_intf);
+	cancel_work_sync(&optee->rpmb_scan_bus_work);
 	/* Unregister OP-TEE specific client devices on TEE bus */
 	optee_unregister_devices();
 
@@ -177,13 +248,18 @@ void optee_remove_common(struct optee *optee)
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
@@ -194,18 +270,36 @@ static int __init optee_core_init(void)
 	if (is_kdump_kernel())
 		return -ENODEV;
 
+	if (IS_ENABLED(CONFIG_RPMB)) {
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
+		if (IS_ENABLED(CONFIG_RPMB)) {
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
+	if (IS_ENABLED(CONFIG_RPMB) && intf_is_regged) {
+		rpmb_interface_unregister(&rpmb_class_intf);
+		intf_is_regged = false;
+	}
+
 	if (!smc_abi_rc)
 		optee_smc_abi_unregister();
 	if (!ffa_abi_rc)
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 1892e49a8e6a..ff26850f704f 100644
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
index ecb5eb079408..b3b87e49f7fb 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -7,6 +7,7 @@
 
 #include <linux/arm_ffa.h>
 #include <linux/errno.h>
+#include <linux/rpmb.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee->ffa.bottom_half_value = U32_MAX;
 	optee->rpc_param_count = rpc_param_count;
 
+	if (IS_REACHABLE(CONFIG_RPMB) &&
+	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
+		optee->in_kernel_rpmb_routing = true;
+
 	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
 	if (IS_ERR(teedev)) {
@@ -919,6 +924,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	}
 	optee->supp_teedev = teedev;
 
+	optee_set_dev_group(optee);
+
 	rc = tee_device_register(optee->teedev);
 	if (rc)
 		goto err_unreg_supp_teedev;
@@ -934,6 +941,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx = teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
@@ -955,6 +963,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (rc)
 		goto err_unregister_devices;
 
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	blocking_notifier_chain_register(&optee_rpmb_intf_added,
+					 &optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -968,6 +980,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
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
index 7a5243c78b55..1a41d4736bf8 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -7,7 +7,9 @@
 #define OPTEE_PRIVATE_H
 
 #include <linux/arm-smccc.h>
+#include <linux/notifier.h>
 #include <linux/rhashtable.h>
+#include <linux/rpmb.h>
 #include <linux/semaphore.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
@@ -20,11 +22,13 @@
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_ITEM_NOT_FOUND	0xFFFF0008
 #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
 #define TEEC_ERROR_BUSY			0xFFFF000D
 #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
+#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
 
 #define TEEC_ORIGIN_COMMS		0x00000002
 
@@ -197,6 +201,12 @@ struct optee_ops {
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
@@ -215,9 +225,16 @@ struct optee {
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
@@ -250,6 +267,8 @@ struct optee_call_ctx {
 	size_t num_entries;
 };
 
+extern struct blocking_notifier_head optee_rpmb_intf_added;
+
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
 int optee_notif_wait(struct optee *optee, u_int key);
@@ -280,8 +299,12 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 
 #define PTA_CMD_GET_DEVICES		0x0
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
+#define PTA_CMD_GET_DEVICES_RPMB	0x2
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
+void optee_bus_scan_rpmb(struct work_struct *work);
+int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
+			 void *data);
 
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 			       size_t size, size_t align,
@@ -295,6 +318,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
 						     struct tee_shm *shm));
 
 
+void optee_set_dev_group(struct optee *optee);
 void optee_remove_common(struct optee *optee);
 int optee_open(struct tee_context *ctx, bool cap_memref_null);
 void optee_release(struct tee_context *ctx);
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
index f3f06e0994a7..4a3c02914f9c 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -103,4 +103,39 @@
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
index e69bc6380683..cf6a4b97549c 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -255,6 +256,154 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
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
@@ -271,6 +420,34 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
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
index a37f87087e5c..fd689dfb5697 100644
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
@@ -1688,6 +1689,10 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.sec_caps = sec_caps;
 	optee->rpc_param_count = rpc_param_count;
 
+	if (IS_REACHABLE(CONFIG_RPMB) &&
+	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
+		optee->in_kernel_rpmb_routing = true;
+
 	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
@@ -1702,6 +1707,8 @@ static int optee_probe(struct platform_device *pdev)
 	}
 	optee->supp_teedev = teedev;
 
+	optee_set_dev_group(optee);
+
 	rc = tee_device_register(optee->teedev);
 	if (rc)
 		goto err_unreg_supp_teedev;
@@ -1715,6 +1722,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 
 	platform_set_drvdata(pdev, optee);
 	ctx = teedev_open(optee->teedev);
@@ -1769,6 +1777,10 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_disable_shm_cache;
 
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	blocking_notifier_chain_register(&optee_rpmb_intf_added,
+					 &optee->rpmb_intf);
 	pr_info("initialized driver\n");
 	return 0;
 
@@ -1782,6 +1794,8 @@ static int optee_probe(struct platform_device *pdev)
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


