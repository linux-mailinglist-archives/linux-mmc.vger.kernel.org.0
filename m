Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887C4054C4
	for <lists+linux-mmc@lfdr.de>; Thu,  9 Sep 2021 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354359AbhIIND3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 Sep 2021 09:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355279AbhIIM5p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Sep 2021 08:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 863BA63268;
        Thu,  9 Sep 2021 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188721;
        bh=8SDHb8hSl496jfByXxncjrG9+2gL6ZG90hdDm5d0zc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG99d7LrodFdO+6qZj4r6txO1AvoUB2ZfqvuDMAWnqPVaOsxvFALkTBaP42k5/MmL
         rXEoPAhc7/dvebEviLbGP9DWOyZByG3a74ECrFoHVxlwUafIothGeVSBOFVhKRhTRO
         GCyH/FPgie7qk+RJtvyjx+ohYmzOhrDZE8CpBhJzbvACEVX8SuL3fKk+6qeUTWe2g9
         Z2ipnSYqkNOwDGVnSu3iYCD0EdMs0uttpA83QigQDVzW0y9TWOfN2tyk/OFkFFLRO5
         m2nieDqhCrRGY/K3zHubswzV/zDwjOBNCvsqkWDhAr7LFZtQgq4Lm+oH1NyizUwalC
         wj8nn3OSETo/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 60/74] mmc: rtsx_pci: Fix long reads when clock is prescaled
Date:   Thu,  9 Sep 2021 07:57:12 -0400
Message-Id: <20210909115726.149004-60-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115726.149004-1-sashal@kernel.org>
References: <20210909115726.149004-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thomas Hebb <tommyhebb@gmail.com>

[ Upstream commit 3ac5e45291f3f0d699a721357380d4593bc2dcb3 ]

For unexplained reasons, the prescaler register for this device needs to
be cleared (set to 1) while performing a data read or else the command
will hang. This does not appear to affect the real clock rate sent out
on the bus, so I assume it's purely to work around a hardware bug.

During normal operation, the prescaler is already set to 1, so nothing
needs to be done. However, in "initial mode" (which is used for sub-MHz
clock speeds, like the core sets while enumerating cards), it's set to
128 and so we need to reset it during data reads. We currently fail to
do this for long reads.

This has no functional affect on the driver's operation currently
written, as the MMC core always sets a clock above 1MHz before
attempting any long reads. However, the core could conceivably set any
clock speed at any time and the driver should still work, so I think
this fix is worthwhile.

I personally encountered this issue while performing data recovery on an
external chip. My connections had poor signal integrity, so I modified
the core code to reduce the clock speed. Without this change, I saw the
card enumerate but was unable to actually read any data.

Writes don't seem to work in the situation described above even with
this change (and even if the workaround is extended to encompass data
write commands). I was not able to find a way to get them working.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Link: https://lore.kernel.org/r/2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 36 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 02de6a5701d6..c1de8fa50fe8 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -551,9 +551,22 @@ static int sd_write_long_data(struct realtek_pci_sdmmc *host,
 	return 0;
 }
 
+static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
+{
+	rtsx_pci_write_register(host->pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
+}
+
+static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
+{
+	rtsx_pci_write_register(host->pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+}
+
 static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
+	int err;
 
 	if (host->sg_count < 0) {
 		data->error = host->sg_count;
@@ -562,22 +575,19 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 		return data->error;
 	}
 
-	if (data->flags & MMC_DATA_READ)
-		return sd_read_long_data(host, mrq);
+	if (data->flags & MMC_DATA_READ) {
+		if (host->initial_mode)
+			sd_disable_initial_mode(host);
 
-	return sd_write_long_data(host, mrq);
-}
+		err = sd_read_long_data(host, mrq);
 
-static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
-{
-	rtsx_pci_write_register(host->pcr, SD_CFG1,
-			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
-}
+		if (host->initial_mode)
+			sd_enable_initial_mode(host);
 
-static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
-{
-	rtsx_pci_write_register(host->pcr, SD_CFG1,
-			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+		return err;
+	}
+
+	return sd_write_long_data(host, mrq);
 }
 
 static void sd_normal_rw(struct realtek_pci_sdmmc *host,
-- 
2.30.2

