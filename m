Return-Path: <linux-mmc+bounces-2858-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BF917665
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Jun 2024 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4F284999
	for <lists+linux-mmc@lfdr.de>; Wed, 26 Jun 2024 02:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545145BFC;
	Wed, 26 Jun 2024 02:51:16 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031176F06B;
	Wed, 26 Jun 2024 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370276; cv=none; b=MnTectOKo8sTxDMdBa70Q3DTSIJu9AXKgduk+HVtP8OfKNXxdbH4fS6Bl+2TK12wT3tz99k5/VzHvqrE6314fHBATXjqu9vGFe+Q0TkjUXupchULjevJ44Q2MCnz3Y9JnwicKHnwAlAe4HnLp9BNtJdCMsZkYQYSmxPcjwKdrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370276; c=relaxed/simple;
	bh=mjuTceoUgUq4NKeZo7mgWeAGUCarJ1ymjop5K9OGsY8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEtDNF3sB0vqtjYqj9wjXG2WOyaw8kEWWGxIiEw2AbO1O4JG9+ba7eBigZgkXOpPBfz7YNM+/IlzjR3/+LVOgfd0I0zxIp2pA7hyMgN1hPDz8l+adveA1Z9iRdoMMXnCBNCM0HFzRIqrBvf+yX+q13GIgQvo40FZI043zPls7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMIkO-000000005sL-1k6y;
	Wed, 26 Jun 2024 02:51:00 +0000
Date: Wed, 26 Jun 2024 03:50:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
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
Subject: [PATCH v3 2/4] block: partitions: populate fwnode
Message-ID: <afa870ec6ac1027561d1c002205ab1e05358a46c.1719368448.git.daniel@makrotopia.org>
References: <cover.1719368448.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719368448.git.daniel@makrotopia.org>

Let block partitions to be represented by a firmware node and hence
allow them to being referenced e.g. for use with blk-nvmem.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..f88829e254e6 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,8 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
+#include <linux/property.h>
+
 #include "check.h"
 
 static int (*const check_part[])(struct parsed_partitions *) = {
@@ -281,6 +283,42 @@ static ssize_t whole_disk_show(struct device *dev,
 }
 static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
+static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
+{
+	struct fwnode_handle *fw_parts, *fw_part;
+	struct device *ddev = disk_to_dev(bdev->bd_disk);
+	const char *partname, *uuid;
+	u32 partno;
+
+	fw_parts = device_get_named_child_node(ddev, "partitions");
+	if (!fw_parts)
+		fw_parts = device_get_named_child_node(ddev->parent, "partitions");
+
+	if (!fw_parts)
+		return NULL;
+
+	fwnode_for_each_child_node(fw_parts, fw_part) {
+		if (!fwnode_property_read_string(fw_part, "uuid", &uuid) &&
+		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_UUIDLTH ||
+		     strncmp(uuid, bdev->bd_meta_info->uuid, PARTITION_META_INFO_UUIDLTH)))
+			continue;
+
+		if (!fwnode_property_read_string(fw_part, "partname", &partname) &&
+		    (!bdev->bd_meta_info || strlen(uuid) > PARTITION_META_INFO_VOLNAMELTH ||
+		     strncmp(partname, bdev->bd_meta_info->volname,
+			     PARTITION_META_INFO_VOLNAMELTH)))
+			continue;
+
+		if (!fwnode_property_read_u32(fw_part, "partno", &partno) &&
+		    bdev_partno(bdev) != partno)
+			continue;
+
+		return fw_part;
+	}
+
+	return NULL;
+}
+
 /*
  * Must be called either with open_mutex held, before a disk can be opened or
  * after all disk users are gone.
@@ -355,6 +393,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_put;
 	}
 
+	device_set_node(pdev, find_partition_fwnode(bdev));
+
 	/* delay uevent until 'holders' subdir is created */
 	dev_set_uevent_suppress(pdev, 1);
 	err = device_add(pdev);
-- 
2.45.2

