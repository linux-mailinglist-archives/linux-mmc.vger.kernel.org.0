Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD020091C
	for <lists+linux-mmc@lfdr.de>; Fri, 19 Jun 2020 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgFSM6a (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Jun 2020 08:58:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgFSM63 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwAWU058249;
        Fri, 19 Jun 2020 07:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571490;
        bh=d4x8ogqFfDH2kB8gVKWGAaXg2kq+h2ME/W7y4f5BO40=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PDUXpxrukOrtOJBTvzXesACfJgIGJOjQdYY8SY1CAYHpMc5/9W5OSq41IGJ3F8bDs
         OSK25zdAkCupMQQ4zJQK4ON2mj5DqhJiVskH9f3DdDtcyU6Im+QSopHJucjDeaaS0e
         ZLORPMgTMWNRy3PTw+3h6VVWtRaKOY9rxZ4Z8WC4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwAvC007140;
        Fri, 19 Jun 2020 07:58:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:10 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hl015675;
        Fri, 19 Jun 2020 07:58:07 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 1/7] dt-bindings: mmc: sdhci-am654: Add ti,clkbuf-sel binding
Date:   Fri, 19 Jun 2020 18:27:55 +0530
Message-ID: <20200619125801.9530-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619125801.9530-1-faiz_abbas@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add documentation for the clock buffer select phy property in the
am654x and j721e 4 bit IP

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
index c6ccecb9ae5a..6d202f4d9249 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -39,6 +39,7 @@ Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
 				  Valid values are 33, 40, 50, 66 and 100 ohms.
 Optional Properties:
 	- ti,strobe-sel: strobe select delay for HS400 speed mode. Default value: 0x0.
+	- ti,clkbuf-sel: Clock Delay Buffer Select
 
 Example:
 
-- 
2.17.1

