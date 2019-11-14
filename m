Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F8FAD0C
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKMJfP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 04:35:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47504 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfKMJfP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 04:35:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z3Gm120152;
        Wed, 13 Nov 2019 03:35:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573637703;
        bh=mpwqDeEPMA78i0tTP2wIwxuQcnYymL4njjvgQPRuSt8=;
        h=From:To:CC:Subject:Date;
        b=E6cg3AUx/IewZbNFRoHl/hK0LGdooaYMCv4P2fU5ehl4waS8afixIsYa9UAt7ywYi
         33poMU4+LHISbdbIAWU6Ow+F1W4JG4CI/kAkD2KA0ZPLxJN6CeIWklMOE+9oQizyfg
         PXebbMpEtcuFaq05Pr9+xkIsdJuNR/BULygZIgFQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z3wW051207;
        Wed, 13 Nov 2019 03:35:03 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:34:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:34:45 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z0hT086866;
        Wed, 13 Nov 2019 03:35:01 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/2] mms: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:36:14 +0200
Message-ID: <20191113093616.32474-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I'm going through the tree to remove dma_request_slave_channel_reason() as it
is just:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Regards,
Peter
---
Peter Ujfalusi (2):
  mmc: atmel-mci: Use dma_request_chan() directly for channel request
  mmc: moxart: Use dma_request_chan() directly for channel request

 drivers/mmc/host/atmel-mci.c  | 3 +--
 drivers/mmc/host/moxart-mmc.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

