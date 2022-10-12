Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810215FCAC2
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Oct 2022 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJLSiG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Wed, 12 Oct 2022 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJLSiF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2022 14:38:05 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190896F546;
        Wed, 12 Oct 2022 11:38:04 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1294F122F07;
        Wed, 12 Oct 2022 20:38:02 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E898C122EDD;
        Wed, 12 Oct 2022 20:38:01 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 12 Oct 2022 20:38:01 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 12 Oct
 2022 20:38:01 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 12 Oct 2022 20:37:58 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCHv4 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Topic: [PATCHv4 1/2] mmc: block: Remove error check of hw_reset on
 reset
Thread-Index: Adjeaabz7a/Vp/YESbKGERCtIHQ41g==
Date:   Wed, 12 Oct 2022 18:37:58 +0000
Message-ID: <f7757a12fb204b8584dacc04e67fdd1c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.001
X-TMASE-Result: 10-0.521300-10.000000
X-TMASE-MatchedRID: dc8Jy61QoRpgljMcj2tyXt5x7RpGJf1a4SkIdSwphgahLh9e7qvSIg2V
        4b0zHULvGgn/HW4MjTmKoat5I/Uj/worSvYb1VTuKsurITpSv+M2LwvzxRX0gMC5DTEMxpeQfiq
        1gj2xET9dBLSzNqCHg1o4rfBbwEORvvHAd28bGMe5x7uAXGEprfWr7HvOSElar4YC4lUEmf2Ypu
        G7kpoKR5p6VbtqvFM0+WatSktubmiel3N+gDvB54knvYO5kHScNUSduuqYHDuZtziFUn+D+UzAk
        Vmkw08mi/rJKndm3e8gE0bHoPl2Aq+/EguYor8cEzQnFLEeMUndB/CxWTRRu/558CedkGIvqcoA
        hihTwvhT9DdstK6naoyidLLBmKNP4BqxW0NCo8420zviUk4+fiXH6tsKNnAM
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 29804778-e865-4b84-b688-f2a6fce2c007-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Before switching back to the right partition in mmc_blk_reset there used
to be a check if hw_reset was even supported. This return value
was removed, so there is no reason to check. Furthermore ensure
part_curr is not falsely set to a valid value on reset or
partition switch error.

As part of this change the code paths of mmc_blk_reset calls were checked
to ensure no commands are issued after a failed mmc_blk_reset directly
without going through the block layer.

Fixes: fefdd3c91e0a ("mmc: core: Drop superfluous validations in mmc_hw|sw_reset()")
Cc: stable@vger.kernel.org

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
-v4: Only partition switch if necessary and fix one mmc_blk_reset call
-v3: Ensure invalid part_curr on error
-v2: Do not attempt to switch partitions if reset failed

 drivers/mmc/core/block.c | 42 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..2619cc47b97c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -134,6 +134,7 @@ struct mmc_blk_data {
 	 * track of the current selected device partition.
 	 */
 	unsigned int	part_curr;
+#define MMC_BLK_PART_INVALID	UINT_MAX	/* Unknown partition active */
 	int	area_type;
 
 	/* debugfs files (only in main mmc_blk_data) */
@@ -987,33 +988,39 @@ static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
 	return ms;
 }
 
+/*
+ * Attempts to reset the card and get back to the requested partition.
+ * Therefore any error here must result in cancelling the block layer
+ * request, it must not be reattempted without going through the mmc_blk
+ * partition sanity checks.
+ */
 static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 int type)
 {
 	int err;
+	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
 
 	if (md->reset_done & type)
 		return -EEXIST;
 
 	md->reset_done |= type;
 	err = mmc_hw_reset(host->card);
+	/*
+	 * A successful reset will leave the card in the main partition, but
+	 * upon failure it might not be, so set it to MMC_BLK_PART_INVALID
+	 * in that case.
+	 */
+	main_md->part_curr = err ? MMC_BLK_PART_INVALID : main_md->part_type;
+	if (err)
+		return err;
 	/* Ensure we switch back to the correct partition */
-	if (err) {
-		struct mmc_blk_data *main_md =
-			dev_get_drvdata(&host->card->dev);
-		int part_err;
-
-		main_md->part_curr = main_md->part_type;
-		part_err = mmc_blk_part_switch(host->card, md->part_type);
-		if (part_err) {
-			/*
-			 * We have failed to get back into the correct
-			 * partition, so we need to abort the whole request.
-			 */
-			return -ENODEV;
-		}
-	}
-	return err;
+	if (mmc_blk_part_switch(host->card, md->part_type))
+		/*
+		 * We have failed to get back into the correct
+		 * partition, so we need to abort the whole request.
+		 */
+		return -ENODEV;
+	return 0;
 }
 
 static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
@@ -1868,7 +1875,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* Reset before last retry */
 	if (mqrq->retries + 1 == MMC_MAX_RETRIES)
-		mmc_blk_reset(md, card->host, type);
+		if (mmc_blk_reset(md, card->host, type))
+			return;
 
 	/* Command errors fail fast, so use all MMC_MAX_RETRIES */
 	if (brq->sbc.error || brq->cmd.error)
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

