Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C4B468E
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 06:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbfIQEpC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 00:45:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51108 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfIQEpC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Sep 2019 00:45:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15D0B1A00B1;
        Tue, 17 Sep 2019 06:45:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D8891A0637;
        Tue, 17 Sep 2019 06:44:58 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3515F402AD;
        Tue, 17 Sep 2019 12:44:55 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 0/3] mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround
Date:   Tue, 17 Sep 2019 12:46:28 +0800
Message-Id: <20190917044631.3161-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch-set is to fix up erratum A-008171 workaround. It had been
verified on LS1046A eSDHC + Phison 32G eMMC which could trigger the
erratum.

Yangbo Lu (3):
  mmc: sdhci: introduce start_tuning() hook
  mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
  mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround

 drivers/mmc/host/sdhci-esdhc.h    |   9 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 248 +++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c          |   5 +-
 drivers/mmc/host/sdhci.h          |   1 +
 4 files changed, 229 insertions(+), 34 deletions(-)

-- 
2.7.4

