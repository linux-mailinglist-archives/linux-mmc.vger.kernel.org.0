Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A05A99D8
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 06:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfIEE4D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 00:56:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfIEE4D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 00:56:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so706025pgn.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 21:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/LzhWSSzwX3K/hqMCR0bItWL2N1tFvg/6Xp0fTTF9U=;
        b=OBcKTagCpLVTDKOsVh3JeeW61D0lZ0ejJUGOCGEbjJ/3HoeQ464QQ/fJE8Nl3u6gys
         rZNxvFGRjPDAP9B95oR0zzYJVt/oXiC0PEhL/bybUc3tGvYPvb6h/i20SEymuDHONxAw
         lM65EQnmw2wfK4Q8/QqKUqN0dqtwNDmhX1wDDcBQ3AVKkqpeVUbSI+ItG7y6Vdf+AsRQ
         hW/bqmLDWnQVOx9WyiLkctLj/FYynvy1Slv/bGcZUF8amadSOw/fu+2lefmvwe9XS9sR
         GTecHjnYQGfgEXf+YrDl338Vr8YuDPbYkEIdgxzwany2cWTNHOAhg0fRngSa8+eaz6R3
         D/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/LzhWSSzwX3K/hqMCR0bItWL2N1tFvg/6Xp0fTTF9U=;
        b=q2M9JcSak9vyXRCP6wh1SoyyE7thg05gefxsYtcxZKHQr9smNAXqjEqiFrgfRZa3HF
         5R+dbYGA826Gc3niKMMDg2sxGqH4AVhNC5Hiy+PDwEBNRs4yzNqmBPnl+Prxgtb/5svs
         kxVpccVN2ID1eCR+DlLEVJStJR2PmEd7gLOYRmCcsqYnszvY10LnGIG9PMY3n6OMVqy3
         AcS26IX1p5tPvXM3D7zk6VcPhg3OPx8Da7qHyNNbjAU2cjSQBLFu9G9o3ghpBlb/nJ4E
         tdG+7KhrJczl+sNAWqPR0CJ3+Nz3cpNwLqdFio3CRX43I/krM8Rju+ABTDY0rTRrdWfe
         76aw==
X-Gm-Message-State: APjAAAWm6zuwhFJju+QJcMApAHdZBUZl6JZ+MrotCCz4wHYuhGMaMrE3
        0t5TYjSIcGC2aFI0zeNrWKpR070FCww=
X-Google-Smtp-Source: APXvYqxHml3i8+UlgMhFa8p1gW1HzrIPUOMF3vIDqf2TVaFSM63ZaIF3BER2uWg1dVRs9mYjR7jSwA==
X-Received: by 2002:a17:90a:22b0:: with SMTP id s45mr1794748pjc.22.1567659362065;
        Wed, 04 Sep 2019 21:56:02 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d69sm788140pfd.175.2019.09.04.21.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 21:56:01 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux@endlessm.com,
        ernest.zhang@bayhubtech.com
Subject: [PATCH] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller"
Date:   Thu,  5 Sep 2019 12:55:57 +0800
Message-Id: <20190905045557.8812-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This reverts commit 414126f9e5abf1973c661d24229543a9458fa8ce.

This commit broke eMMC storage access on a new consumer MiniPC based on
AMD SoC, which has eMMC connected to:

02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog-if 01)
	Subsystem: O2 Micro, Inc. Device 0002

During probe, several errors are seen including:

  mmc1: Got data interrupt 0x02000000 even though no data operation was in progress.
  mmc1: Timeout waiting for hardware interrupt.
  mmc1: error -110 whilst initialising MMC card

Reverting this commit allows the eMMC storage to be detected & usable
again.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 9dc4548271b4..19944b0049db 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -432,7 +432,6 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 					mmc_hostname(host->mmc));
 				host->flags &= ~SDHCI_SIGNALING_330;
 				host->flags |= SDHCI_SIGNALING_180;
-				host->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
 				host->mmc->caps2 |= MMC_CAP2_NO_SD;
 				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 				pci_write_config_dword(chip->pdev,
@@ -682,6 +681,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
 const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe = sdhci_pci_o2_probe,
 	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
 	.probe_slot = sdhci_pci_o2_probe_slot,
 #ifdef CONFIG_PM_SLEEP
 	.resume = sdhci_pci_o2_resume,
-- 
2.20.1

