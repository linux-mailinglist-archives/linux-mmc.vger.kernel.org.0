Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAB6B4AA
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 04:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfGQCpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Tue, 16 Jul 2019 22:45:18 -0400
Received: from gli-ex.genesyslogic.com.tw ([60.251.58.171]:42091 "EHLO
        gli-ex.genesyslogic.com.tw" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbfGQCpS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 22:45:18 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 22:45:17 EDT
Received: from localhost (172.17.104.60) by Gli-CASHT02.genesyslogic.com.tw
 (172.17.50.60) with Microsoft SMTP Server id 14.2.347.0; Wed, 17 Jul 2019
 10:39:46 +0800
From:   Ben Chuang <ben.chuang@genesyslogic.com.tw>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <johnsonm@danlj.org>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH 1/2] mmc: sdhci: Add PLL Enable support to internal clock setup
Date:   Wed, 17 Jul 2019 10:39:51 +0800
Message-ID: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [172.17.104.60]
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
setup as part of the internal clock setup as described in 3.2.1 Internal
Clock Setup Sequence of SD Host Controller Simplified Specification
Version 4.20.  This changes the timeouts to the new specification of
150ms for each step and is documented as safe for "prior versions which
do not support PLL Enable."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
---
 drivers/mmc/host/sdhci.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..fd684d7a5f15 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,15 +1636,11 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
        clk |= SDHCI_CLOCK_INT_EN;
        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

-       /* Wait max 20 ms */
-       timeout = ktime_add_ms(ktime_get(), 20);
-       while (1) {
-               bool timedout = ktime_after(ktime_get(), timeout);
-
-               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-               if (clk & SDHCI_CLOCK_INT_STABLE)
-                       break;
-               if (timedout) {
+       /* Wait max 150 ms */
+       timeout = ktime_add_ms(ktime_get(), 150);
+       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+               & SDHCI_CLOCK_INT_STABLE)) {
+               if (ktime_after(ktime_get(), timeout)) {
                        pr_err("%s: Internal clock never stabilised.\n",
                               mmc_hostname(host->mmc));
                        sdhci_dumpregs(host);
@@ -1653,8 +1649,27 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
                udelay(10);
        }

+       clk |= SDHCI_CLOCK_PLL_EN;
+       clk &= ~SDHCI_CLOCK_INT_STABLE;
+       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+       /* Wait max 150 ms */
+       timeout = ktime_add_ms(ktime_get(), 150);
+       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+               & SDHCI_CLOCK_INT_STABLE)) {
+               if (ktime_after(ktime_get(), timeout)) {
+                       pr_err("%s: PLL clock never stabilised.\n",
+                              mmc_hostname(host->mmc));
+                       sdhci_dumpregs(host);
+                       return;
+               }
+               udelay(10);
+       }
+
        clk |= SDHCI_CLOCK_CARD_EN;
        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+       mdelay(1);
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_clk);

--
2.22.0

________________________________

Genesys Logic Email Confidentiality Notice:
This mail and any attachments may contain information that is confidential, proprietary, privileged or otherwise protected by law. The mail is intended solely for the named addressee (or a person responsible for delivering it to the addressee). If you are not the intended recipient of this mail, you are not authorized to read, print, copy or disseminate this mail.

If you have received this email in error, please notify us immediately by reply email and immediately delete this message and any attachments from your system. Please be noted that any unauthorized use, dissemination, distribution or copying of this email is strictly prohibited.
________________________________
