Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ABD0877
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfJIHko (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 03:40:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42320 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIHko (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Oct 2019 03:40:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A65F91A09F3;
        Wed,  9 Oct 2019 09:40:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 515F81A09F9;
        Wed,  9 Oct 2019 09:40:40 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 05898402B1;
        Wed,  9 Oct 2019 15:40:36 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
Date:   Wed,  9 Oct 2019 15:41:38 +0800
Message-Id: <20191009074140.3934-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch-set is to fix up erratum A-008171 workaround. It had been
verified on LS1046A eSDHC + Phison 32G eMMC which could trigger the
erratum.
---
Changes for v2:
	- Dropped sdhci start_tuning() hook patch.
	- Implemented SW tuning starting in eSDHC writew().
Changes for v3:
	- Converted to use esdhc_flush_async_fifo() and usleep_range().
	- Added ACK of Adrian.

Yangbo Lu (2):
  mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
  mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround

 drivers/mmc/host/sdhci-esdhc.h    |  14 +++
 drivers/mmc/host/sdhci-of-esdhc.c | 257 ++++++++++++++++++++++++++++++++------
 2 files changed, 231 insertions(+), 40 deletions(-)

-- 
2.7.4

