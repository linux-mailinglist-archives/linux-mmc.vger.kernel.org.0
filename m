Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF65EE252
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Sep 2022 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiI1Qyc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Sep 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI1Qyb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 12:54:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D928E9CF5;
        Wed, 28 Sep 2022 09:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18517B82174;
        Wed, 28 Sep 2022 16:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75D5C433D6;
        Wed, 28 Sep 2022 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664384067;
        bh=9ieKrZ0kEy9+GmqajkIGyMGgIizGgDSihdd1eBCLfJU=;
        h=From:To:Cc:Subject:Date:From;
        b=Y7z7TnxCeygSgevrUVEukmqOLSpLUkC2fprjDa0Gp2NgRAfQnwV4qOkI5gGr/Ui3P
         u4r8fUdI3SYKtVch0OWVPy6XuiQZrKrvv3aI4kh3dnoo31RWF0WvEwrtpdTa2gdx5Z
         tw4idgOSBMy53VUsatFFlHfMvbGShQOCGm9mWgiQ1HVAnBkSm0gjUCoeS8YABnM8ek
         ICId8KI+ZgbswShVfDggedJ53HYdwt41zJx+Mkm9BhUWV8NOx0Z6aez4CNMl9ZGEIV
         4ZDTlYJcDK/SBBsBZo4wHdyI8LmVHGxPPBYrxPzH5EkmMDgssgSMlKd3CGw+VlQ8Ex
         yTYoqt+r9vrjA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Wed, 28 Sep 2022 11:54:18 -0500
Message-Id: <20220928165420.1212284-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Document the optional "altr,sysmgr-syscon" binding that is used to
access the System Manager register that controls the SDMMC clock
phase.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: add else statement
v3: document that the "altr,sysmgr-syscon" binding is only applicable to
    "altr,socfpga-dw-mshc"
v2: document "altr,sysmgr-syscon" in the MMC section
---
 .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index ae6d6fca79e2..b73324273464 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Synopsys Designware Mobile Storage Host Controller Binding
 
-allOf:
-  - $ref: "synopsys-dw-mshc-common.yaml#"
-
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
@@ -38,6 +35,34 @@ properties:
       - const: biu
       - const: ciu
 
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the sysmgr node
+          - description: register offset that controls the SDMMC clock phase
+    description:
+      Contains the phandle to System Manager block that contains
+      the SDMMC clock-phase control register. The first value is the pointer
+      to the sysmgr and the 2nd value is the register offset for the SDMMC
+      clock phase register.
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml#"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const:
+              - altr,socfpga-dw-mshc
+    then:
+      required:
+        - altr,sysmgr-syscon
+    else:
+      properties:
+        altr,sysmgr-syscon: false
+
 required:
   - compatible
   - reg
-- 
2.25.1

