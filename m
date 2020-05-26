Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE041A1C7B
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Apr 2020 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDHHVh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Apr 2020 03:21:37 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:29406 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgDHHVh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2020 03:21:37 -0400
Received: from grover.flets-west.jp (softbank126125134031.bbtec.net [126.125.134.31]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 0387L6nE022210;
        Wed, 8 Apr 2020 16:21:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0387L6nE022210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586330467;
        bh=6lUuBNJgYs6dcwN9xI/lESbFXHdxhnYtXrKDzIR2VN0=;
        h=From:To:Cc:Subject:Date:From;
        b=Yc3UUKQjgqgMrF7+on+WzmPK44dhT2n3OZEn1U3sZrfnGSMyFwC35myRhtnLcsu4y
         gS/4W8S9zhG+wyyh3agCPJNLEHqp5RbEXRofqBcaP1g+3iKl4GZjuCPHfIn5gPWZq7
         2bYalDIdMeBl95KvgEOHzb5+ZbCCHMKUjz/pk6ncnIsZn/HNFoeHHOxdb9ctsu2aWg
         pcr+TW13Mw4aoj+zjlkJO/eqG91z8ULMpTyDrEyHJOMGFoBTAr83lQaPv+gExRacdU
         Hm4BcQQZr/iZvRLbRJC2IjuarQ7Ec6e3Hr0fN3wV7se0D0czjwXd6T1HNQPXVbEU6B
         yatyNnCI8YS3g==
X-Nifty-SrcIP: [126.125.134.31]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci: move SDHCI_CAPABILITIES_1 to a more suitable place
Date:   Wed,  8 Apr 2020 16:21:04 +0900
Message-Id: <20200408072105.422-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the SDHCI specification, the Capabilities Register (Offset 0x40h)
is the 64-bit width register, but in Linux, it is represented as two
registers, SDHCI_CAPABILITIES and SDHCI_CAPABILITIES_1 so that drivers
can use 32-bit register accessors.

The upper 32-bit field is associated with SDHCI_CAPABILITIES_1.

Move the definition of SDHCI_CAPABILITIES_1 to the correct place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..b786b68e0302 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -220,6 +220,7 @@
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
 
+#define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
@@ -236,8 +237,6 @@
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
-#define SDHCI_CAPABILITIES_1	0x44
-
 #define SDHCI_MAX_CURRENT		0x48
 #define  SDHCI_MAX_CURRENT_LIMIT	0xFF
 #define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
-- 
2.17.1

