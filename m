Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E069833EC2
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 08:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfFDGJJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 02:09:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39702 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDGJJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 02:09:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5468vdG114243;
        Tue, 4 Jun 2019 01:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559628537;
        bh=vpolFfzSu3TNGG8dxBjsDUMOZVsketQ0r9/5AvjnH0g=;
        h=From:To:CC:Subject:Date;
        b=L4qL5KK5RuoQnp47XzrhElmEDFDtgfFWhER1w5gk507jkqhSD21efG6cr23lSnt8t
         Cwj3G29uOn51f5xT6TYWBzV4nE+2yM4+nX+FhTdrgBL1IgCzR5jIW95B1+RCfQYzVd
         p2YfnqXy7mrGAZ5Jid6COYafx9G/6wJ2QbAf5BBQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5468vsI034671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 01:08:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 01:08:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 01:08:57 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5468pYx049516;
        Tue, 4 Jun 2019 01:08:53 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <nm@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 0/4] Add Support for MMC in J721E
Date:   Tue, 4 Jun 2019 11:39:10 +0530
Message-ID: <20190604060914.10886-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following patches add driver support for MMC SDHCI interfaces on
TI's J721E devices. The 8 bit and 4 bit instances have phys which are
different from the am65x interfaces as well as different from each
other which leads to 3 different compatibles and a bunch of flags for
indicating the differences.

Depends on Nishanth's initial J721E patches here:
https://lore.kernel.org/patchwork/cover/1077382/

Also depends on my fixes for AM65x driver here:
https://lore.kernel.org/patchwork/cover/1079924/

Tested with: j721e-evm and am65x-evm.

DT patches will be added in a separate series.

Faiz Abbas (4):
  dt-bindings: mmc: sdhci-am654: Document bindings for the host
    controllers on TI's J721E devices.
  mmc: sdhci_am654: Add Support for 8 bit IP on J721E
  mmc: sdhci_am654: Add Support for 4 bit IP on J721E
  arm64: defconfig: Add config for MMC on AM65x and J721E devices

 .../devicetree/bindings/mmc/sdhci-am654.txt   |   9 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/mmc/host/sdhci_am654.c                | 257 +++++++++++++-----
 3 files changed, 204 insertions(+), 63 deletions(-)

-- 
2.19.2

