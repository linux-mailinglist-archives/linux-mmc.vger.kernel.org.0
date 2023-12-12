Return-Path: <linux-mmc+bounces-452-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0C80EE62
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Dec 2023 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC971C20AB1
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Dec 2023 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844D7316C;
	Tue, 12 Dec 2023 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DS2xMuge"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E5A6;
	Tue, 12 Dec 2023 06:10:37 -0800 (PST)
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EC5683F6CB;
	Tue, 12 Dec 2023 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702390236;
	bh=G7KJJKG7a1rFAa9okOTBeeQq/rysigJxkpYfoNGj4TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=DS2xMugenS6NrlohVsc3ICV4No6cdQfIseweWGgSzIjOinJAKFtASN/96fvXVmYBf
	 36IvA2jqBeaV7YnRKmn37Sb8/26Rtw65CLoJSy3Rwanu3hR2ujfOOq89shpWU8UIoy
	 /keXVPcKj3G+oEb9ZqK8EhLTQ63iUKEN0TNkFyWSqoHIKCA6p1E6DJWt3TPyxsvxj0
	 BfSBikTD5BmN9AmKDJBX2RGLsqOqJ7UaCjs5gDxcjbnt5h7wZIwO3nPjN5r2eZwxWD
	 0l5Muo+jdQ4Q9V/WwLVdPmBcp5UVcB1UMcEnG44NRhWezvtyCD6ZewHkHfdFh8iAB2
	 l69U57g4uoDhg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-gli: GL9750: Mask rootport's replay timer timeout during suspend
Date: Tue, 12 Dec 2023 22:10:28 +0800
Message-Id: <20231212141029.239235-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spamming `lspci -vv` can still observe the replay timer timeout error
even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
replay timer timeout of AER"), albeit with a lower reproduce rate.

Such AER interrupt can still prevent the system from suspending, so let
root port mask and unmask replay timer timeout during suspend and
resume, respectively.

Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c  | 50 +++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci.h      |  1 +
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 025b31aa712c..59ae4da72974 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -68,7 +68,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
-static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 {
 	int i, ret;
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 77911a57b12c..7d1548c83742 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1429,6 +1429,50 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 	return sdhci_pci_resume_host(chip);
 }
 
+static void mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val |= PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+
+static void unmask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val &= ~PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+
+static int sdhci_pci_gl975x_suspend(struct sdhci_pci_chip *chip)
+{
+	mask_replay_timer_timeout(chip->pdev);
+
+	return sdhci_pci_suspend_host(chip);
+}
+
+static int sdhci_pci_gl975x_resume(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+
+	unmask_replay_timer_timeout(chip->pdev);
+
+	return ret;
+}
+
 static int gl9763e_resume(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
@@ -1547,7 +1591,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
 	.probe_slot	= gli_probe_slot_gl9755,
 	.ops            = &sdhci_gl9755_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume         = sdhci_pci_gli_resume,
+	.suspend	= sdhci_pci_gl975x_suspend,
+	.resume         = sdhci_pci_gl975x_resume,
 #endif
 };
 
@@ -1570,7 +1615,8 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
 	.probe_slot	= gli_probe_slot_gl9750,
 	.ops            = &sdhci_gl9750_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume         = sdhci_pci_gli_resume,
+	.suspend	= sdhci_pci_gl975x_suspend,
+	.resume         = sdhci_pci_gl975x_resume,
 #endif
 };
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 153704f812ed..19253dce687d 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -190,6 +190,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM_SLEEP
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
 int sdhci_pci_enable_dma(struct sdhci_host *host);
-- 
2.34.1


