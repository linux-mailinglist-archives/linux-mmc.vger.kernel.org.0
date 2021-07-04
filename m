Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22A13BB363
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Jul 2021 01:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhGDXR7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 4 Jul 2021 19:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhGDXOh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 4 Jul 2021 19:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1FF061981;
        Sun,  4 Jul 2021 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440217;
        bh=2WtajsOj7fe07Yx5SkDoLC1ViN8fbEvcUM2RY0WTpk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QClUge08T5ZnmyXO9+f/Ukp2n02JutkWbot2HCzAh+HhUr3VdXbTzNySpVFEndBI0
         t/lJaPYXtFp/aFNwPdZ7oku8235N9vWEot7OziuVa35Ip5KMEUojfxLmImh3z+sEwS
         xkjtQYoqoX+n6FsJYL6TcCXO2p13wCMB2xI4+4WQS4xkfN2P4reb+KRd3wx2F6CPwF
         kDkzWtipLMWAhbzKq3+Is0FYvvXfPZB7YyDBFX7UOHiAcVQjsfjUQgHL/d3PEUzoWx
         PCN43YsVWWkyOhEAqYbH6dypbLSpIDZdGeTDPbYc5PeHFfj27sN6jHJ39ra6ys9HLQ
         LiHYkntxqOFtA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 30/50] mmc: sdhci-sprd: use sdhci_sprd_writew
Date:   Sun,  4 Jul 2021 19:09:18 -0400
Message-Id: <20210704230938.1490742-30-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230938.1490742-1-sashal@kernel.org>
References: <20210704230938.1490742-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 961470820021e6f9d74db4837bd6831a1a30341b ]

The sdhci_sprd_writew() was defined by never used in sdhci_ops:

    drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20210601095403.236007-2-krzysztof.kozlowski@canonical.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 10705e5fa90e..a999d2089d3d 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -382,6 +382,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
+	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
 	.get_max_clock = sdhci_sprd_get_max_clock,
-- 
2.30.2

