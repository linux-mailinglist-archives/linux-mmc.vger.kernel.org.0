Return-Path: <linux-mmc+bounces-2241-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A88D4387
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 04:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F9A28515B
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFA28DA0;
	Thu, 30 May 2024 02:13:50 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9917984;
	Thu, 30 May 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035230; cv=none; b=jwc+8T4IcSBb7yOlpD6N565bO3S9Mwcdtka4SEXAkCIYAebXOq6QkDpPnLpQ4pwZVZpNC/SPFD6syTsLVv+2KOg+dbTi3ufMyxwpK19DGUjWF1zB2pfiJnWWhTH1gIK19jZFqEbudicjxkxTcC0cGwNn8p5MFZ0vH+lRIEGIb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035230; c=relaxed/simple;
	bh=jwJEg7siBPxa7QbQVCX/r1nA9rstIO45gfu1eOfH+Qg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQqAVmEewDT2tBlKKa0B8B2eA4fb9BoPy/b7zXCu/PCyqCI+I6WERp6v10L+Py7mHPUswokwBTBCLDO8EHthd2Ft5VDdTowmjNy312Ukg3gWYsmPqjoMiOpSVYGKS93RSCW9gFdNE3qW5FWqfPpiyFFmszTyFHMa4//Ego+m/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVI1-000000004d1-02Df;
	Thu, 30 May 2024 02:13:13 +0000
Date: Thu, 30 May 2024 03:13:09 +0100
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
Subject: [PATCH v2 1/9] dt-bindings: block: add basic bindings for block
 devices
Message-ID: <e2ac7ff66251ad491e8912b56fec89a8a3b663e2.1717031992.git.daniel@makrotopia.org>
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

Add bindings for block devices which are used to allow referencing
nvmem bits on them.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/block/block-device.yaml          | 22 ++++++++
 .../devicetree/bindings/block/partition.yaml  | 51 +++++++++++++++++++
 .../devicetree/bindings/block/partitions.yaml | 20 ++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml

diff --git a/Documentation/devicetree/bindings/block/block-device.yaml b/Documentation/devicetree/bindings/block/block-device.yaml
new file mode 100644
index 000000000000..c83ea525650b
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/block-device.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/block-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: block storage device
+
+description: |
+  This binding is generic and describes a block-oriented storage device.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  partitions:
+    $ref: /schemas/block/partitions.yaml
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partition.yaml b/Documentation/devicetree/bindings/block/partition.yaml
new file mode 100644
index 000000000000..86b61e30f9a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partition.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition on a block device
+
+description: |
+  This binding describes a partition on a block device.
+  Partitions may be matched by a combination of partition number, name,
+  and UUID.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  $nodename:
+    pattern: '^block-partition-.+$'
+
+  partnum:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Matches partition by number if present.
+
+  partname:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTNAME if present.
+
+  partuuid:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTUUID if present.
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+    description:
+      This container may reference an NVMEM layout parser.
+
+anyOf:
+  - required:
+      - partnum
+
+  - required:
+      - partname
+
+  - required:
+      - partuuid
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partitions.yaml b/Documentation/devicetree/bindings/block/partitions.yaml
new file mode 100644
index 000000000000..fd84c3ba8493
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partitions.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partitions on block devices
+
+description: |
+  This binding is generic and describes the content of the partitions container
+  node.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+patternProperties:
+  "^block-partition-.+$":
+    $ref: partition.yaml
+
+unevaluatedProperties: false
-- 
2.45.1

