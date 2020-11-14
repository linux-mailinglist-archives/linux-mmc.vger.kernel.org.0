Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9182B2D01
	for <lists+linux-mmc@lfdr.de>; Sat, 14 Nov 2020 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKNMIV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 14 Nov 2020 07:08:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60914 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNMIV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Nov 2020 07:08:21 -0500
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kduLr-0002Z3-NM; Sat, 14 Nov 2020 12:08:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: Kconfig: fix spelling mistake "hardare" -> "hardware"
Date:   Sat, 14 Nov 2020 12:08:19 +0000
Message-Id: <20201114120819.416311-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig file. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 310e546e5898..7324a61d7416 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -664,7 +664,7 @@ config MMC_S3C_PIO
 config MMC_S3C_DMA
 	bool "Use DMA transfers only"
 	help
-	  Use DMA to transfer data between memory and the hardare.
+	  Use DMA to transfer data between memory and the hardware.
 
 	  Currently, the DMA support in this driver seems to not be
 	  working properly and needs to be debugged before this
-- 
2.28.0

