Return-Path: <linux-mmc+bounces-8872-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE4BCF42F
	for <lists+linux-mmc@lfdr.de>; Sat, 11 Oct 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290EC189E123
	for <lists+linux-mmc@lfdr.de>; Sat, 11 Oct 2025 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797F265CC8;
	Sat, 11 Oct 2025 11:12:22 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14452261B96;
	Sat, 11 Oct 2025 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181142; cv=none; b=jvwxVNTnH0VeNhFoYdcoE8hr4IwBHNcEtsd5wWcq+1Oy/xwsoyBqSviNcqCzgShWuwG0fD5lFaZ6ee03KGtCwLaI6lA50DcB+m13ELK+Tl8TMK953JK9K++162IpazUTBpQKOqotrlYLt/DEKfkCmc6LI1eiMgog0IuoZqFLEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181142; c=relaxed/simple;
	bh=0wSwoXHpiZ3KVMpSHH8XKIJYAfcZ1DY2+Tk+0mjGMYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skUC1hDXeJxdEAwVxD29bDQcLhXpry5Hts27J8wIisxs/Rymwr2sDteKojzeKzyLdCE0s1rtLO85RqOYqwtqgG0g5RsiSyjGOoYWTu1UZ/deJiE7TDBwZvWDLLnMiH/vm9MyrHBJVPhpOQ4gv54hNYKVAy12E2RJSu4RXOp6uSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgC3SZN8O+poTfIDAQ--.5744S2;
	Sat, 11 Oct 2025 19:11:58 +0800 (CST)
From: hehuan1@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	hehuan1@eswincomputing.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
Date: Sat, 11 Oct 2025 19:11:50 +0800
Message-ID: <20251011111150.553-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251011111039.533-1-hehuan1@eswincomputing.com>
References: <20251011111039.533-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgC3SZN8O+poTfIDAQ--.5744S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr45ZF17Jr48tryruFW7urg_yoW5JF13pa
	95GFW7Gr1fJr1fZw48J3Wvk3W3t3Z7Jr1Yyr17Jr43JanYvFyUKrZIkwn8Ka45CFyxXa4a
	9ay2vry5Aay2vr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRByxiUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index f882219a0a26..edd6c8e90cad 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -30,6 +30,7 @@ properties:
           - sophgo,sg2002-dwcmshc
           - sophgo,sg2042-dwcmshc
           - thead,th1520-dwcmshc
+          - eswin,eic7700-dwcmshc
 
   reg:
     maxItems: 1
@@ -52,17 +53,30 @@ properties:
     maxItems: 5
 
   reset-names:
-    items:
-      - const: core
-      - const: bus
-      - const: axi
-      - const: block
-      - const: timer
+    maxItems: 5
 
   rockchip,txclk-tapnum:
     description: Specify the number of delay for tx sampling.
     $ref: /schemas/types.yaml#/definitions/uint8
 
+  eswin,hsp-sp-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to HSP(High-Speed Peripheral) device
+      - description: Offset of the stability status register for
+                     internal clock
+      - description: Offset of the stability register for host regulator
+                     voltage.
+    description: |
+      HSP CSR is to control and get status of different high-speed
+      peripherals (such as Ethernet, USB, SATA, etc.) via register,
+      which can close module's clock, reset module independently
+      and tune board-level's parameters of PHY, etc.
+
+  eswin,drive-impedance-ohms:
+    description: Specifies the drive impedance in Ohm.
+    enum: [33, 40, 50, 66, 100]
+
 required:
   - compatible
   - reg
@@ -110,6 +124,37 @@ allOf:
             - const: block
             - const: timer
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-dwcmshc
+    then:
+      properties:
+        resets:
+          minItems: 4
+          maxItems: 4
+        reset-names:
+          items:
+            - const: axi
+            - const: phy
+            - const: prstn
+            - const: txrx
+      required:
+        - eswin,hsp-sp-csr
+        - eswin,drive-impedance-ohms
+    else:
+      properties:
+        resets:
+          maxItems: 5
+        reset-names:
+          items:
+            - const: core
+            - const: bus
+            - const: axi
+            - const: block
+            - const: timer
+
   - if:
       properties:
         compatible:
-- 
2.25.1


