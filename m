Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC76467F1
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Dec 2022 04:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLHDil (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 7 Dec 2022 22:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHDik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 22:38:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074F60364;
        Wed,  7 Dec 2022 19:38:37 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NSKcr1C4yz4xVnm;
        Thu,  8 Dec 2022 11:38:36 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B83cHPT001033;
        Thu, 8 Dec 2022 11:38:17 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 8 Dec 2022 11:38:19 +0800 (CST)
Date:   Thu, 8 Dec 2022 11:38:19 +0800 (CST)
X-Zmail-TransId: 2af963915c2b2708f952
X-Mailer: Zmail v1.0
Message-ID: <202212081138191215291@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ulf.hansson@linaro.org>
Cc:     <maximlevitsky@gmail.com>, <oakad@yahoo.com>, <axboe@kernel.dk>,
        <hare@suse.de>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZW1zdGljay9tc3Byb19ibG9jazogQ29udmVydCB0byB1c2XCoHN5c2ZzX2VtaXQoKS9zeXNmc19lbWl0X2F0KCkgQVBJcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B83cHPT001033
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63915C3C.000 by FangMail milter!
X-FangMail-Envelope: 1670470716/4NSKcr1C4yz4xVnm/63915C3C.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63915C3C.000/4NSKcr1C4yz4xVnm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/memstick/core/mspro_block.c | 177 +++++++++++-----------------
 1 file changed, 72 insertions(+), 105 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 61cf75d4a01e..5a69ed33999b 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -260,8 +260,8 @@ static ssize_t mspro_block_attr_show_default(struct device *dev,
 				buffer[rc++] = '\n';
 		}

-		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
-				((unsigned char *)s_attr->data)[cnt]);
+		rc += sysfs_emit_at(buffer, rc, "%02x ",
+				    ((unsigned char *)s_attr->data)[cnt]);
 	}
 	return rc;
 }
@@ -290,61 +290,43 @@ static ssize_t mspro_block_attr_show_sysinfo(struct device *dev,
 		date_tz_f *= 15;
 	}

-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "class: %x\n",
-			x_sys->class);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "block size: %x\n",
-			be16_to_cpu(x_sys->block_size));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "block count: %x\n",
-			be16_to_cpu(x_sys->block_count));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "user block count: %x\n",
-			be16_to_cpu(x_sys->user_block_count));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "page size: %x\n",
-			be16_to_cpu(x_sys->page_size));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "assembly date: "
-			"GMT%+d:%d %04u-%02u-%02u %02u:%02u:%02u\n",
-			date_tz, date_tz_f,
-			be16_to_cpup((__be16 *)&x_sys->assembly_date[1]),
-			x_sys->assembly_date[3], x_sys->assembly_date[4],
-			x_sys->assembly_date[5], x_sys->assembly_date[6],
-			x_sys->assembly_date[7]);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "serial number: %x\n",
-			be32_to_cpu(x_sys->serial_number));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc,
-			"assembly maker code: %x\n",
-			x_sys->assembly_maker_code);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "assembly model code: "
-			"%02x%02x%02x\n", x_sys->assembly_model_code[0],
-			x_sys->assembly_model_code[1],
-			x_sys->assembly_model_code[2]);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "memory maker code: %x\n",
-			be16_to_cpu(x_sys->memory_maker_code));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "memory model code: %x\n",
-			be16_to_cpu(x_sys->memory_model_code));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "vcc: %x\n",
-			x_sys->vcc);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "vpp: %x\n",
-			x_sys->vpp);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "controller number: %x\n",
-			be16_to_cpu(x_sys->controller_number));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc,
-			"controller function: %x\n",
-			be16_to_cpu(x_sys->controller_function));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start sector: %x\n",
-			be16_to_cpu(x_sys->start_sector));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "unit size: %x\n",
-			be16_to_cpu(x_sys->unit_size));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "sub class: %x\n",
-			x_sys->ms_sub_class);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "interface type: %x\n",
-			x_sys->interface_type);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "controller code: %x\n",
-			be16_to_cpu(x_sys->controller_code));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "format type: %x\n",
-			x_sys->format_type);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "device type: %x\n",
-			x_sys->device_type);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "mspro id: %s\n",
-			x_sys->mspro_id);
+	rc += sysfs_emit_at(buffer, rc, "class: %x\n", x_sys->class);
+	rc += sysfs_emit_at(buffer, rc, "block size: %x\n", be16_to_cpu(x_sys->block_size));
+	rc += sysfs_emit_at(buffer, rc, "block count: %x\n", be16_to_cpu(x_sys->block_count));
+	rc += sysfs_emit_at(buffer, rc, "user block count: %x\n",
+			    be16_to_cpu(x_sys->user_block_count));
+	rc += sysfs_emit_at(buffer, rc, "page size: %x\n", be16_to_cpu(x_sys->page_size));
+	rc += sysfs_emit_at(buffer, rc, "assembly date: GMT%+d:%d %04u-%02u-%02u %02u:%02u:%02u\n",
+			    date_tz, date_tz_f,
+			    be16_to_cpup((__be16 *)&x_sys->assembly_date[1]),
+			    x_sys->assembly_date[3], x_sys->assembly_date[4],
+			    x_sys->assembly_date[5], x_sys->assembly_date[6],
+			    x_sys->assembly_date[7]);
+	rc += sysfs_emit_at(buffer, rc, "serial number: %x\n", be32_to_cpu(x_sys->serial_number));
+	rc += sysfs_emit_at(buffer, rc, "assembly maker code: %x\n", x_sys->assembly_maker_code);
+	rc += sysfs_emit_at(buffer, rc, "assembly model code: %02x%02x%02x\n",
+			    x_sys->assembly_model_code[0],
+			    x_sys->assembly_model_code[1],
+			    x_sys->assembly_model_code[2]);
+	rc += sysfs_emit_at(buffer, rc, "memory maker code: %x\n",
+			    be16_to_cpu(x_sys->memory_maker_code));
+	rc += sysfs_emit_at(buffer, rc, "memory model code: %x\n",
+			    be16_to_cpu(x_sys->memory_model_code));
+	rc += sysfs_emit_at(buffer, rc, "vcc: %x\n", x_sys->vcc);
+	rc += sysfs_emit_at(buffer, rc, "vpp: %x\n", x_sys->vpp);
+	rc += sysfs_emit_at(buffer, rc, "controller number: %x\n",
+			    be16_to_cpu(x_sys->controller_number));
+	rc += sysfs_emit_at(buffer, rc, "controller function: %x\n",
+			    be16_to_cpu(x_sys->controller_function));
+	rc += sysfs_emit_at(buffer, rc, "start sector: %x\n", be16_to_cpu(x_sys->start_sector));
+	rc += sysfs_emit_at(buffer, rc, "unit size: %x\n", be16_to_cpu(x_sys->unit_size));
+	rc += sysfs_emit_at(buffer, rc, "sub class: %x\n", x_sys->ms_sub_class);
+	rc += sysfs_emit_at(buffer, rc, "interface type: %x\n", x_sys->interface_type);
+	rc += sysfs_emit_at(buffer, rc, "controller code: %x\n",
+			    be16_to_cpu(x_sys->controller_code));
+	rc += sysfs_emit_at(buffer, rc, "format type: %x\n", x_sys->format_type);
+	rc += sysfs_emit_at(buffer, rc, "device type: %x\n", x_sys->device_type);
+	rc += sysfs_emit_at(buffer, rc, "mspro id: %s\n", x_sys->mspro_id);
 	return rc;
 }

@@ -356,7 +338,7 @@ static ssize_t mspro_block_attr_show_modelname(struct device *dev,
 						     struct mspro_sys_attr,
 						     dev_attr);

-	return scnprintf(buffer, PAGE_SIZE, "%s", (char *)s_attr->data);
+	return sysfs_emit(buffer, "%s", (char *)s_attr->data);
 }

 static ssize_t mspro_block_attr_show_mbr(struct device *dev,
@@ -369,27 +351,17 @@ static ssize_t mspro_block_attr_show_mbr(struct device *dev,
 	struct mspro_mbr *x_mbr = x_attr->data;
 	ssize_t rc = 0;

-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "boot partition: %x\n",
-			x_mbr->boot_partition);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start head: %x\n",
-			x_mbr->start_head);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start sector: %x\n",
-			x_mbr->start_sector);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start cylinder: %x\n",
-			x_mbr->start_cylinder);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "partition type: %x\n",
-			x_mbr->partition_type);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "end head: %x\n",
-			x_mbr->end_head);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "end sector: %x\n",
-			x_mbr->end_sector);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "end cylinder: %x\n",
-			x_mbr->end_cylinder);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start sectors: %x\n",
-			x_mbr->start_sectors);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc,
-			"sectors per partition: %x\n",
-			x_mbr->sectors_per_partition);
+	rc += sysfs_emit_at(buffer, rc, "boot partition: %x\n", x_mbr->boot_partition);
+	rc += sysfs_emit_at(buffer, rc, "start head: %x\n", x_mbr->start_head);
+	rc += sysfs_emit_at(buffer, rc, "start sector: %x\n", x_mbr->start_sector);
+	rc += sysfs_emit_at(buffer, rc, "start cylinder: %x\n", x_mbr->start_cylinder);
+	rc += sysfs_emit_at(buffer, rc, "partition type: %x\n", x_mbr->partition_type);
+	rc += sysfs_emit_at(buffer, rc, "end head: %x\n", x_mbr->end_head);
+	rc += sysfs_emit_at(buffer, rc, "end sector: %x\n", x_mbr->end_sector);
+	rc += sysfs_emit_at(buffer, rc, "end cylinder: %x\n", x_mbr->end_cylinder);
+	rc += sysfs_emit_at(buffer, rc, "start sectors: %x\n", x_mbr->start_sectors);
+	rc += sysfs_emit_at(buffer, rc, "sectors per partition: %x\n",
+			    x_mbr->sectors_per_partition);
 	return rc;
 }

@@ -409,22 +381,19 @@ static ssize_t mspro_block_attr_show_specfile(struct device *dev,
 	memcpy(ext, x_spfile->ext, 3);
 	ext[3] = 0;

-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "name: %s\n", name);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "ext: %s\n", ext);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "attribute: %x\n",
-			x_spfile->attr);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "time: %d:%d:%d\n",
-			x_spfile->time >> 11,
-			(x_spfile->time >> 5) & 0x3f,
-			(x_spfile->time & 0x1f) * 2);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "date: %d-%d-%d\n",
-			(x_spfile->date >> 9) + 1980,
-			(x_spfile->date >> 5) & 0xf,
-			x_spfile->date & 0x1f);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "start cluster: %x\n",
-			x_spfile->cluster);
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "size: %x\n",
-			x_spfile->size);
+	rc += sysfs_emit_at(buffer, rc, "name: %s\n", name);
+	rc += sysfs_emit_at(buffer, rc, "ext: %s\n", ext);
+	rc += sysfs_emit_at(buffer, rc, "attribute: %x\n", x_spfile->attr);
+	rc += sysfs_emit_at(buffer, rc, "time: %d:%d:%d\n",
+			    x_spfile->time >> 11,
+			    (x_spfile->time >> 5) & 0x3f,
+			    (x_spfile->time & 0x1f) * 2);
+	rc += sysfs_emit_at(buffer, rc, "date: %d-%d-%d\n",
+			    (x_spfile->date >> 9) + 1980,
+			    (x_spfile->date >> 5) & 0xf,
+			    x_spfile->date & 0x1f);
+	rc += sysfs_emit_at(buffer, rc, "start cluster: %x\n", x_spfile->cluster);
+	rc += sysfs_emit_at(buffer, rc, "size: %x\n", x_spfile->size);
 	return rc;
 }

@@ -438,16 +407,14 @@ static ssize_t mspro_block_attr_show_devinfo(struct device *dev,
 	struct mspro_devinfo *x_devinfo = x_attr->data;
 	ssize_t rc = 0;

-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "cylinders: %x\n",
-			be16_to_cpu(x_devinfo->cylinders));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "heads: %x\n",
-			be16_to_cpu(x_devinfo->heads));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "bytes per track: %x\n",
-			be16_to_cpu(x_devinfo->bytes_per_track));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "bytes per sector: %x\n",
-			be16_to_cpu(x_devinfo->bytes_per_sector));
-	rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "sectors per track: %x\n",
-			be16_to_cpu(x_devinfo->sectors_per_track));
+	rc += sysfs_emit_at(buffer, rc, "cylinders: %x\n", be16_to_cpu(x_devinfo->cylinders));
+	rc += sysfs_emit_at(buffer, rc, "heads: %x\n", be16_to_cpu(x_devinfo->heads));
+	rc += sysfs_emit_at(buffer, rc, "bytes per track: %x\n",
+			    be16_to_cpu(x_devinfo->bytes_per_track));
+	rc += sysfs_emit_at(buffer, rc, "bytes per sector: %x\n",
+			    be16_to_cpu(x_devinfo->bytes_per_sector));
+	rc += sysfs_emit_at(buffer, rc, "sectors per track: %x\n",
+			    be16_to_cpu(x_devinfo->sectors_per_track));
 	return rc;
 }

-- 
2.25.1
