Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471DD552BD4
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jun 2022 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbiFUHYJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jun 2022 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbiFUHYA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2022 03:24:00 -0400
X-Greylist: delayed 1842 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 00:23:56 PDT
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4812253F
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H3A71
        LTwINGg7q9rhkZYGNr4mEmxxJLrgNsYw2vE29I=; b=pwymRhuZhPCsuIEMm+tfA
        3VZhrwVQv1F7upUbv1GYrQxnfB57icIL+KgXueuUmE+k8eq7pF0TiFFHO7G2q+AX
        97IOXlzlJ1Syh08T6SkUmebl7BxSW6GpCDtNkOxrnQ4hN8BUtXkvTbQdli06o4L2
        v2lv9EgBByhfm2vyNkqLD8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgA3lXHNarFiIltfGA--.36525S2;
        Tue, 21 Jun 2022 14:53:02 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     windhl@126.com
Subject: [PATCH] mmc/host/sdhci-of-esdhc: Hold a reference returned by of_find_compatible_node
Date:   Tue, 21 Jun 2022 14:52:59 +0800
Message-Id: <20220621065259.4079817-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgA3lXHNarFiIltfGA--.36525S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry5XrW5CF4UWr45AF4rGrg_yoW8Jw1DpF
        W5WrWFkFWfGF18Kr9a93WkuasYga10kayxKrW7Wa1rX3yqgFyqqF1xuFyYyr1rXFyrJ3WS
        qF1qgr18CFyrJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4rWxUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2g4nF1uwMQCulQAAsF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In sdhci_esdhc_probe(), we should hold the reference returned by
of_find_compatible_node() which is used to of_node_put() for keep
refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d9dc41143bb3..9c8cd8b63578 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1418,7 +1418,7 @@ static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
 static int sdhci_esdhc_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	struct device_node *np;
+	struct device_node *np, *tp;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_esdhc *esdhc;
 	int ret;
@@ -1463,7 +1463,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	if (esdhc->vendor_ver > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 
-	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
+	tp = of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc");
+	if (tp) {
+		of_node_put(tp);
 		host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 	}
-- 
2.25.1

