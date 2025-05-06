Return-Path: <linux-mmc+bounces-6424-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65434AAB3EB
	for <lists+linux-mmc@lfdr.de>; Tue,  6 May 2025 06:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE211889BF4
	for <lists+linux-mmc@lfdr.de>; Tue,  6 May 2025 04:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CC394A32;
	Tue,  6 May 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5jnoY+6"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A12820B9;
	Mon,  5 May 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486444; cv=none; b=tuKxSlKDEtuxR49P48L700Q5c6mOjqzB3w4qJQ+4L3Y04WYwdC4xZhCA3aTQ8SbeTdVLM+UNYLxYRCoXJiKcGvkjQYGa8KTNzRHHS2+j5cOqRn+DRhcN+DiERUmc6EBnBkgY5sfA4ETkepmyfbge5NFPAXrbq4+Sq7L9xkOYjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486444; c=relaxed/simple;
	bh=Kv5EsO+4YkFNwXXL8BuUkKTNw09Hsbyxwyz1iv/3W/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7IVPn/kuOKeUUT8KRx1MKH35T6F87Vqq13rzUBvUGglY3iP+aO8jdYqDpc6PZEMicF0vqN2Yvtq0R5VyuIBGKtCot4cGnXahSydT8cZKk3K51faYhR2+B+JzGLsxO8gXajAGPfIjSO+LACcPIlMuMyevL4xUjEIiIVzjxgEDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5jnoY+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAC9C4CEED;
	Mon,  5 May 2025 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486442;
	bh=Kv5EsO+4YkFNwXXL8BuUkKTNw09Hsbyxwyz1iv/3W/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5jnoY+6SkkfMyTMCUNWv8CHB+MZnqWfxS1Z2BokT8Rk3qocKO9Rr/iTHXyhrfr4Q
	 sARaa9Q/TP67GXbtqCnY9pMJn602GnRksxvyUvgul3BjpS8YTfdSyPPtlNJCEH+qZc
	 sX0wCf+FoHaJavj+BA2JtGKsPegwmmD0dGN5ACV4ufjsKRb4IyTfZ5r57kaqBBLRQt
	 kEX6oj2Mbt+fymTe5RvGbK6TgGcyFwMfu4wxz0KJXlromqys5ZXAxxZF6fdtUPBGIQ
	 B65eP03aKZeFBBnhdjwzCGzcY1mUGPhDW2ddrUoJgTy78LvMkJBaAxVbhEQAsPmxWl
	 bssaA98wBf38A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 030/212] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 19:03:22 -0400
Message-Id: <20250505230624.2692522-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Erick Shepherd <erick.shepherd@ni.com>

[ Upstream commit 31e75ed964582257f59156ce6a42860e1ae4cc39 ]

The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
lowered to less than 0.5V for a minimum of 1 ms when powering off a
card. Increase wait to 15 ms so that voltage has time to drain down
to 0.5V and cards can power off correctly. Issues with voltage drain
time were only observed on Apollo Lake and Bay Trail host controllers
so this fix is limited to those devices.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250314195021.1588090-1-erick.shepherd@ni.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5a5cc40d4bc37..c71d9956b398d 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -613,8 +613,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+			usleep_range(15000, 17500);
 		return;
+	}
 
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
-- 
2.39.5


