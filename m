Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F753BC4DC
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Sep 2019 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504242AbfIXJaN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Sep 2019 05:30:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47220 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504186AbfIXJaN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Sep 2019 05:30:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC38B1A0192;
        Tue, 24 Sep 2019 11:30:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B69F71A03A9;
        Tue, 24 Sep 2019 11:30:09 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 55242402B4;
        Tue, 24 Sep 2019 17:30:04 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 0/2] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
Date:   Tue, 24 Sep 2019 17:31:29 +0800
Message-Id: <20190924093131.17471-1-yangbo.lu@nxp.com>
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

Yangbo Lu (2):
  mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
  mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround

 drivers/mmc/host/sdhci-esdhc.h    |  14 +++
 drivers/mmc/host/sdhci-of-esdhc.c | 254 +++++++++++++++++++++++++++++++++-----
 2 files changed, 235 insertions(+), 33 deletions(-)

-- 
2.7.4

