Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC8BDD4F
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Sep 2019 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfIYLmh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 25 Sep 2019 07:42:37 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47052 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404639AbfIYLmh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2019 07:42:37 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD5gn-00058b-2H; Wed, 25 Sep 2019 12:42:33 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD5gm-0004bH-Jd; Wed, 25 Sep 2019 12:42:32 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-mmc@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: mmci: make unexported functions static
Date:   Wed, 25 Sep 2019 12:42:31 +0100
Message-Id: <20190925114231.17640-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the following sparse warnings by making any functions not used
outsde the mmci.c driver static.

drivers/mmc/host/mmci.c:422:6: warning: symbol 'mmci_dma_release' was not declared. Should it be static?
drivers/mmc/host/mmci.c:430:6: warning: symbol 'mmci_dma_setup' was not declared. Should it be static?
drivers/mmc/host/mmci.c:465:5: warning: symbol 'mmci_prep_data' was not declared. Should it be static?
drivers/mmc/host/mmci.c:481:6: warning: symbol 'mmci_unprep_data' was not declared. Should it be static?
drivers/mmc/host/mmci.c:490:6: warning: symbol 'mmci_get_next_data' was not declared. Should it be static?
drivers/mmc/host/mmci.c:498:5: warning: symbol 'mmci_dma_start' was not declared. Should it be static?
drivers/mmc/host/mmci.c:533:6: warning: symbol 'mmci_dma_finalize' was not declared. Should it be static?
drivers/mmc/host/mmci.c:542:6: warning: symbol 'mmci_dma_error' was not declared. Should it be static?
drivers/mmc/host/mmci.c:951:6: warning: symbol 'mmci_variant_init' was not declared. Should it be static?
drivers/mmc/host/mmci.c:956:6: warning: symbol 'ux500v2_variant_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/mmci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c37e70dbe250..e14003e52058 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -419,7 +419,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	mmci_write_clkreg(host, clk);
 }
 
-void mmci_dma_release(struct mmci_host *host)
+static void mmci_dma_release(struct mmci_host *host)
 {
 	if (host->ops && host->ops->dma_release)
 		host->ops->dma_release(host);
@@ -427,7 +427,7 @@ void mmci_dma_release(struct mmci_host *host)
 	host->use_dma = false;
 }
 
-void mmci_dma_setup(struct mmci_host *host)
+static void mmci_dma_setup(struct mmci_host *host)
 {
 	if (!host->ops || !host->ops->dma_setup)
 		return;
@@ -462,7 +462,7 @@ static int mmci_validate_data(struct mmci_host *host,
 	return 0;
 }
 
-int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
+static int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 {
 	int err;
 
@@ -478,7 +478,7 @@ int mmci_prep_data(struct mmci_host *host, struct mmc_data *data, bool next)
 	return err;
 }
 
-void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
+static void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
 		      int err)
 {
 	if (host->ops && host->ops->unprep_data)
@@ -487,7 +487,7 @@ void mmci_unprep_data(struct mmci_host *host, struct mmc_data *data,
 	data->host_cookie = 0;
 }
 
-void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
+static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 {
 	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 
@@ -495,7 +495,7 @@ void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 		host->ops->get_next_data(host, data);
 }
 
-int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
+static int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 {
 	struct mmc_data *data = host->data;
 	int ret;
@@ -530,7 +530,7 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
-void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	if (!host->use_dma)
 		return;
@@ -539,7 +539,7 @@ void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		host->ops->dma_finalize(host, data);
 }
 
-void mmci_dma_error(struct mmci_host *host)
+static void mmci_dma_error(struct mmci_host *host)
 {
 	if (!host->use_dma)
 		return;
@@ -948,12 +948,12 @@ static struct mmci_host_ops mmci_variant_ops = {
 };
 #endif
 
-void mmci_variant_init(struct mmci_host *host)
+static void mmci_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 }
 
-void ux500v2_variant_init(struct mmci_host *host)
+static void ux500v2_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 	host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
-- 
2.23.0

