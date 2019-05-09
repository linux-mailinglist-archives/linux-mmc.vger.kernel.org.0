Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAF18EE7
	for <lists+linux-mmc@lfdr.de>; Thu,  9 May 2019 19:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEIRYo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 May 2019 13:24:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43817 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEIRYk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 May 2019 13:24:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so1536511pgi.10
        for <linux-mmc@vger.kernel.org>; Thu, 09 May 2019 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wx8gaoHC5MOYV389XtnYNdY7stPe/BwS11WRGJ3X0jU=;
        b=NLbenTRuAo/KwttyYdSfiYeHTl8s02uccdxHkJwJLM2aY7TwvWQqlzRs0z8yANQP8R
         khMAKyxuFZJpgqgeNYGcHLqu5JE1xjX9RHiBh3YBz9oyDSgkjkxUuCIXX01cR7/10nQI
         rodbcT1oFhD5khMY98DrmTSlWUYOKTkyTYnlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wx8gaoHC5MOYV389XtnYNdY7stPe/BwS11WRGJ3X0jU=;
        b=VQ+UzcyoyFDwM2xCt0POgEwUBOz7bFpNjzMd6wUgaPla/kasAPYcXdjWgN1/yqva5h
         KsVICRbHY3A6MZoR4kV0GvtLqj+Wqy6+VcVP3s1p05OTa2etPh87Nns3GT75BdGHdJxt
         3AXmTWzyv5PJNm+92XShG7mOZAlQrIe1YTBXZCZ+rbCU1Yu1ElvwaKyynype2h/BnXe/
         +tabzGq5EBFYs38cn7LaUrlIP5evKSR84g5bx6PZdtajUqechSClH0ZHkvrkewgqLwjw
         nQEXaMOnkjNo1aP0kjpsHXP4/kdcSNUJHaxoPvDJ1gR6G9ZF6Ze3h/n6tL4Gi8YNGqHv
         kqkw==
X-Gm-Message-State: APjAAAXkOYqgiVZtqnkcP8wabIvbQfEpxJqvDD6aSeIZNnAwzBYF836q
        wzzcHQGYOj8JLRkMxc97QKleIQ==
X-Google-Smtp-Source: APXvYqwYqy8L9x/EoYgEU/4wY9WEr7lylwmLPU9640H1GKytWxa+mGBeQ/ZgM4Ryo2yw8qrfa7yERw==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr6898551pfh.165.1557422679753;
        Thu, 09 May 2019 10:24:39 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m8sm3989699pgn.59.2019.05.09.10.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:24:39 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Thu,  9 May 2019 10:24:27 -0700
Message-Id: <20190509172427.17835-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
References: <20190509172427.17835-1-scott.branden@broadcom.com>
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

Stable tag (v4.12+) chosen to assist stable kernel maintainers so that
the change does not produce merge conflicts backporting to older kernel
versions. In reality, the timing bug existed since the driver was first
introduced but there is no need for this driver to be supported in kernel
versions that old.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

