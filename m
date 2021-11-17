Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E845500E
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Nov 2021 23:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhKQWEf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Nov 2021 17:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237296AbhKQWEd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 17:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m92SQVtAROkV6IUuMiUUxvdoqMyREAfFRjvLLM5TS74=;
        b=g9/2TarUU8Bf+748KfAE5GIkm3hvtxQ+eAo/GyIvGvni9cel5Qa9QLRPXoxfnsWDGhXn2r
        6V9BF71Arj67CYyNGm12p0i8BNDrkl+oGq4jveLJHgk3YYWq9OEI9ou77kfQHzZ10uLpPi
        Z+M09+EounHrLdv5eQ9KJGNSlXkGE1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-eQbhoXwxN-qbfV3A0UDwIw-1; Wed, 17 Nov 2021 17:01:30 -0500
X-MC-Unique: eQbhoXwxN-qbfV3A0UDwIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F038119057A1;
        Wed, 17 Nov 2021 22:01:28 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9985D9DE;
        Wed, 17 Nov 2021 22:01:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5.16 regression fix 1/5] ACPI: Change acpi_device_always_present() into acpi_device_override_status()
Date:   Wed, 17 Nov 2021 23:01:14 +0100
Message-Id: <20211117220118.408953-2-hdegoede@redhat.com>
In-Reply-To: <20211117220118.408953-1-hdegoede@redhat.com>
References: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ATM acpi_bus_get_status() calls acpi_device_always_present() to allow
platform quirks to override the _STA return to report that a device
is present (status = ACPI_STA_DEFAULT) independent of the _STA return.

In some cases it might also be useful to have the opposite functionality
and have a platform quirk which marks a device as not present (status = 0)
to work around ACPI table bugs.

Change acpi_device_always_present() into a more generic
acpi_device_override_status() function to allow this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c       |  4 +--
 drivers/acpi/x86/utils.c | 66 +++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h  |  5 +--
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index fa923a929224..dd535b4b9a16 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -98,8 +98,8 @@ int acpi_bus_get_status(struct acpi_device *device)
 	acpi_status status;
 	unsigned long long sta;
 
-	if (acpi_device_always_present(device)) {
-		acpi_set_device_status(device, ACPI_STA_DEFAULT);
+	if (acpi_device_override_status(device, &sta)) {
+		acpi_set_device_status(device, sta);
 		return 0;
 	}
 
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index bfcb76888ca7..165110210750 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -22,40 +22,49 @@
  * Some BIOS-es (temporarily) hide specific APCI devices to work around Windows
  * driver bugs. We use DMI matching to match known cases of this.
  *
- * We work around this by always reporting ACPI_STA_DEFAULT for these
- * devices. Note this MUST only be done for devices where this is safe.
+ * Likewise sometimes some not-actually present devices are sometimes
+ * reported as present, which may cause issues.
  *
- * This forcing of devices to be present is limited to specific CPU (SoC)
- * models both to avoid potentially causing trouble on other models and
- * because some HIDs are re-used on different SoCs for completely
- * different devices.
+ * We work around this by using the below quirk list to override the status
+ * reported by the _STA method with a fixed value (ACPI_STA_DEFAULT or 0).
+ * Note this MUST only be done for devices where this is safe.
+ *
+ * This status overriding is limited to specific CPU (SoC) models both to
+ * avoid potentially causing trouble on other models and because some HIDs
+ * are re-used on different SoCs for completely different devices.
  */
-struct always_present_id {
+struct override_status_id {
 	struct acpi_device_id hid[2];
 	struct x86_cpu_id cpu_ids[2];
 	struct dmi_system_id dmi_ids[2]; /* Optional */
 	const char *uid;
+	unsigned long long status;
 };
 
-#define X86_MATCH(model)	X86_MATCH_INTEL_FAM6_MODEL(model, NULL)
-
-#define ENTRY(hid, uid, cpu_models, dmi...) {				\
+#define ENTRY(status, hid, uid, cpu_model, dmi...) {			\
 	{ { hid, }, {} },						\
-	{ cpu_models, {} },						\
+	{ X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },		\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
+	status,								\
 }
 
-static const struct always_present_id always_present_ids[] = {
+#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, hid, uid, cpu_model, dmi)
+
+#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
+	ENTRY(0, hid, uid, cpu_model, dmi)
+
+static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
-	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
+	PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
+	PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
 
 	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
-	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
@@ -63,18 +72,18 @@ static const struct always_present_id always_present_ids[] = {
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	ENTRY("INT0002", "1", X86_MATCH(ATOM_AIRMONT), {}),
+	PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
+	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
+	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -90,19 +99,19 @@ static const struct always_present_id always_present_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
@@ -110,26 +119,27 @@ static const struct always_present_id always_present_ids[] = {
 	      }),
 };
 
-bool acpi_device_always_present(struct acpi_device *adev)
+bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)
 {
 	bool ret = false;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
-		if (acpi_match_device_ids(adev, always_present_ids[i].hid))
+	for (i = 0; i < ARRAY_SIZE(override_status_ids); i++) {
+		if (acpi_match_device_ids(adev, override_status_ids[i].hid))
 			continue;
 
 		if (!adev->pnp.unique_id ||
-		    strcmp(adev->pnp.unique_id, always_present_ids[i].uid))
+		    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
 			continue;
 
-		if (!x86_match_cpu(always_present_ids[i].cpu_ids))
+		if (!x86_match_cpu(override_status_ids[i].cpu_ids))
 			continue;
 
-		if (always_present_ids[i].dmi_ids[0].matches[0].slot &&
-		    !dmi_check_system(always_present_ids[i].dmi_ids))
+		if (override_status_ids[i].dmi_ids[0].matches[0].slot &&
+		    !dmi_check_system(override_status_ids[i].dmi_ids))
 			continue;
 
+		*status = override_status_ids[i].status;
 		ret = true;
 		break;
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2f93ecf05dac..5895f6c7f6db 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -615,9 +615,10 @@ int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
 #ifdef CONFIG_X86
-bool acpi_device_always_present(struct acpi_device *adev);
+bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
 #else
-static inline bool acpi_device_always_present(struct acpi_device *adev)
+static inline bool acpi_device_override_status(struct acpi_device *adev,
+					       unsigned long long *status)
 {
 	return false;
 }
-- 
2.31.1

