Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8FF284F53
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Oct 2020 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJFP7O (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 6 Oct 2020 11:59:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:56023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJFP7K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Oct 2020 11:59:10 -0400
IronPort-SDR: YhFx+BBZl6//WSY8lk5UF16QClVXQ6Stl9G3TxHKr2He1roFWqccSTzIV72DYJOkutWVZmLOkn
 Ge4+HtJ5Pclg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="226148699"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="226148699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 08:59:05 -0700
IronPort-SDR: n3gTXKqyzGGj5EgagxFxtQdWpnG31/gymGCTdpqWXpw4J1yWrTGgPHLYJBa6l2D7XRL4mQgpHQ
 5VLIiSoxiwvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="343826712"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2020 08:59:02 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted Firmware Service call
Date:   Tue,  6 Oct 2020 23:55:49 +0800
Message-Id: <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add header file to handle API function for device driver to communicate
with Arm Trusted Firmware.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 .../linux/firmware/intel/keembay_firmware.h   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay_firmware.h

diff --git a/include/linux/firmware/intel/keembay_firmware.h b/include/linux/firmware/intel/keembay_firmware.h
new file mode 100644
index 000000000000..9adb8c87b788
--- /dev/null
+++ b/include/linux/firmware/intel/keembay_firmware.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Intel Keembay SOC Firmware API Layer
+ *
+ *  Copyright (C) 2020-2021, Intel Corporation
+ *
+ *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
+#define __FIRMWARE_KEEMBAY_SMC_H__
+
+#include <linux/arm-smccc.h>
+
+/**
+ * This file defines API function that can be called by device driver in order to
+ * communicate with Arm Trusted Firmware.
+ */
+
+/* Setting for Keem Bay IO Pad Line Voltage Selection */
+#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26
+#define KEEMBAY_SET_1V8_VOLT		0x01
+#define KEEMBAY_SET_3V3_VOLT		0x00
+
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
+static int do_fw_invoke(u64 func_id, u64 arg0, u64 arg1)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(func_id, arg0, arg1, &res);
+
+	return res.a0;
+}
+
+int keembay_sd_voltage_selection(int volt)
+{
+	return do_fw_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, volt, 0);
+}
+#else
+static inline int keembay_sd_voltage_selection(int volt)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

