Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E92B0E42
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Nov 2020 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKLTlQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Nov 2020 14:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKLTlP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 14:41:15 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DD42224A;
        Thu, 12 Nov 2020 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605210075;
        bh=xd/Vc7WoIe125xQL70/5CKTN/z05rzC6msMBzUjogVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWEEuLDB+3WJv2jHtPxrxpq4uwR0di8woZ6b+F1xK1zVJPnmFY/kQ69iEZ2trJY4s
         K35NYAfoXGj+vt6XbCKXu7VLuu6VJujVCLWNLA1OPBCu39fiBv8HE7cRiRFJGfxWpl
         Tk+TC+tnjvi7JEWRGbImKIflrWyQFQ5sxOk+Q3NA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH 2/8] mmc: cqhci: rename cqhci.c to cqhci-core.c
Date:   Thu, 12 Nov 2020 11:40:05 -0800
Message-Id: <20201112194011.103774-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112194011.103774-1-ebiggers@kernel.org>
References: <20201112194011.103774-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Rename cqhci.c to cqhci-core.c so that another source file can be added
to the cqhci module without having to rename the module.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/mmc/host/Makefile                  | 1 +
 drivers/mmc/host/{cqhci.c => cqhci-core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/mmc/host/{cqhci.c => cqhci-core.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 451c25fc2c692..20c2f9463d0dc 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
+cqhci-y					+= cqhci-core.o
 obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci-core.c
similarity index 100%
rename from drivers/mmc/host/cqhci.c
rename to drivers/mmc/host/cqhci-core.c
-- 
2.29.2

