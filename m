Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C747219B9E
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Jul 2020 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIJDS (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Jul 2020 05:03:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22138 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIJDR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 05:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594285397; x=1625821397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uebgsYxmG14U9QH1BiVUo1V3hDh9l1YEtcMZMdFFtTQ=;
  b=F1Ywgvhq6fjcIntVgG3QcvA4gVd4oVpxRQ7YCsZ1KT28TDOY7A9/OkjR
   7OCZXitz/kG15XMggYLWR9bf4nk4+OgFw4A87C7M1TC98WBhUTVifBi4y
   lMbbSgCp5Md020wFt/zPPEvmqgMqrZAZXDCProJDa8dd9z6sRbA1pWLKM
   UMH/OU4eEl4P86Ne4rolLZqGn0JaGNIwg8miblTo2THgwPP017JDtfUdy
   S8NOgkUyBP0dtBbtJhRQBjtEERFbXmNWPyUSfqc+L62jKXlbb3ap3rENk
   c5s8Sc2FfxykjcjHsNLhL5FNCi/C9wFx7repJPIzCnZv0JeabJq2v3ZMz
   g==;
IronPort-SDR: hsuJ4MDZbZXnAMoXOjUiCwAWEoaqSuF7CXVTGnPb51qIkyQueg14T9YtGKQWcmk8jBloGaJQPL
 SW5Nab93cQM/Sdic91W1k6pyUb1W+urqHi8+LUGLHC67inAApxf6NO+oErD0mtk/Z3aU6Tt6Im
 gcMALGksJVTNld56/0GW9uz+4rRku+Pgl4KynBWua6r0xePiK6em0+MggCamUYunh+fd1WZM4j
 QUZzv3txfQ7xc2jWeVbCrZWiK5MghXv72FbayF230RmZO5cH0jBZUOw+UUxgNDQqCNv+9+JXYa
 ToA=
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="82390958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 02:03:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 02:02:45 -0700
Received: from ibiza.mchp-main.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 02:03:09 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <eugen.hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH] MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to Eugen Hristev
Date:   Thu, 9 Jul 2020 10:53:31 +0200
Message-ID: <20200709085331.8145-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As Eugen handles the software for bootloaders and new products, handover
the maintenance to him.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c87b94e6b2f6..dafcfa626c76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15376,7 +15376,7 @@ F:	drivers/mmc/host/sdhci*
 F:	include/linux/mmc/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
-- 
2.24.0

