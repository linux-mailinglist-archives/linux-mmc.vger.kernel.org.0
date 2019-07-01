Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60D01522F
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfEFRBk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 13:01:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36241 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfEFRBi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 13:01:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so7093616pfa.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8NEZr+lKEciEtlqvodjs9s9WnuQgHUyLTCz6jchZs+U=;
        b=I8H0Zyd/6abn7dp3fZUDD5BAADvTaLKVYQyECZWLsA+qoSdkJoPxMGWvXMYSmE+/5G
         HzeDykXqLtteyK90RTj5aDi0qjBFqibsa+GjQowv7CvI4t4HoQ0B+whnCgg6mnRxPAmq
         rvEHs/YNkC5QnX8Er4iEBGvy+hpKN/5FlJYqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8NEZr+lKEciEtlqvodjs9s9WnuQgHUyLTCz6jchZs+U=;
        b=We+GXl7tDpudIxryhaGxYa9/MQ8efGRH+E6MuLWbV4yQusvDCi9V7nyS10/WwClTop
         /BRB+PfFeNWmqBKuLAsLG/z7rRNNnUw+8w9Yik461Ay+ad5agDG13i1Y4HKBn5EjiuJj
         EwX3QLx9bPxbyxq+sJUdsU8rHFfRnOqyNlFQG156dCTYrOEEwQN95CE9ZxICaoBPc1lC
         D76cA1iJJFUYuEJzAF5b/wv35us15EHXf5i9ksaRaOCfy/YuQv8bbbvI9RW/NQWPWWdU
         kl6PzdU+saxKmRK5ROpch+dYPZue7HVRWzlCkh3uXA+H9aGN91oTAVA5FFrsYgn1W4oa
         zGAg==
X-Gm-Message-State: APjAAAV2xZlIVxLaKXgvgAQx7yNgOqSlTfGq0Ch8KzpZzek51irPPRO3
        dKgQY830SHuCdLl9icFt39WTNw==
X-Google-Smtp-Source: APXvYqyWFjkQJYyagZNhe7lr3N8EEii7ANc4xZeB7K2J92cARdpf2QgOrjQVLq3JRa2QaZrvfBcu2Q==
X-Received: by 2002:a63:165f:: with SMTP id 31mr33584426pgw.321.1557162098028;
        Mon, 06 May 2019 10:01:38 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:37 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Mon,  6 May 2019 10:01:15 -0700
Message-Id: <20190506170115.10840-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506170115.10840-1-scott.branden@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode.  This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

Fixes: f5f968f2371c ("mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read")
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d4071c41c94..2feb4ef32035 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops = &sdhci_iproc_ops,
 };
-- 
2.17.1

