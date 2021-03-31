Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E30344F72
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Mar 2021 20:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhCVS77 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Mar 2021 14:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhCVS71 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FCCB61994;
        Mon, 22 Mar 2021 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439566;
        bh=WlVTEDge8a2sWi1YSIL9GHQT08rBMoQZeeSuGahDmm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaAg53L+LqoHwm+LT0HjGQ5rYxsxUuMG1d3ilweQGgHiRWwxLmzJ36II9eMGyzm96
         V388kwNmgSef90LURzrBpjCBWx2tPd8yXqEjsgqAdPg8UEGOFeu9QA8XaCkHYwWdz/
         htR5BgjklZO2zE4Kxrj52RJuejuYDYGwGV2I2ftvTVLPZIuSKbkBYmXOtRiquGmsng
         YcCHCGE2oohWT80QPiRpMrbz6JNqKZiWLTuqjUdhjkkkUhpD6lkdaMIErbPkx2yxjY
         CWxtKooosprYVrOLH4gYb5kKA5A7TkbGWuELuRCJeVoyt2uxL62CoJPnninquorhig
         up+/dd/Tm63TA==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/4] dt-bindings: mmc: iproc-sdhci: Add clock-frequency support
Date:   Mon, 22 Mar 2021 19:58:15 +0100
Message-Id: <20210322185816.27582-3-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322185816.27582-1-nsaenz@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Users might want to choose a different clock frequency than whatever the
bootloader provided at probe time. Add 'clock-frequency' bindings.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
index 19d84f3ef9e6..9d0d97b2c0a7 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -35,6 +35,12 @@ properties:
     type: boolean
     description: Specifies that controller should use auto CMD12
 
+  clock-frequency:
+    description:
+      Should be the frequency (in Hz) of the core clock. If this is specified
+      and the core clock is specified then we'll try to set the core clock to
+      this at probe time.
+
 required:
   - compatible
   - reg
-- 
2.30.2

