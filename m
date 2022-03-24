Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF34E63E9
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Mar 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiCXNQK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Thu, 24 Mar 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350397AbiCXNQJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2022 09:16:09 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421E5D5D9;
        Thu, 24 Mar 2022 06:14:36 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C720D1231DB;
        Thu, 24 Mar 2022 14:14:34 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B44BE123009;
        Thu, 24 Mar 2022 14:14:34 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Thu, 24 Mar 2022 14:14:34 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 14:14:34 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Thu, 24 Mar 2022 14:14:34 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv3] mmc: block: Check for errors after write on SPI
Thread-Topic: [PATCHv3] mmc: block: Check for errors after write on SPI
Thread-Index: AQHYP4CK2VoQSzZIoUqoVtvoCdsHfA==
Date:   Thu, 24 Mar 2022 13:14:34 +0000
Message-ID: <b65d044223cc43898de6698b2a14e0c3@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26790.007
X-TMASE-Result: 10--2.484200-10.000000
X-TMASE-MatchedRID: LVkZzMT5mEprFdvBEmTnvLZ0InVwVLVTn5nfR7I2dFOxPXYIh1l6dlg7
        cH4SOkOpdWqA+wY3gFZusJxXwmCOnpDH5Y6LoY7BRZfQN+FVqbA1kR+05VC1hsiCh8yBqE+tbiP
        oclJOCy0MV38Bdz1rogpwpdIIi4oJCtNdSL7NMxRO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDfal
        dUczBqFzyK8WRp1qJNDyVcDYF9X2gcQvLacRAgcPCW/PNRRp/ZeLLCA0PD7aiOS54Qk4fByRJd3
        nIYBNFRvAQxPUzd//aAUraeY8ICeWgwIvLATTKBC24oEZ6SpSkj80Za3RRg8Al3ZL80ZqgLmFEo
        HbUHYssj/FwX/s/Fh7qYj8OceYPLKCLLs5ecoDY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: afa7c4a5-af8a-4365-9656-8d85acbb6163-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Introduce a SEND_STATUS check for writes through SPI to not mark
an unsuccessful write as successful.

Since SPI SD/MMC does not have states, after a write, the card will
just hold the line LOW until it is ready again. The driver marks the
write therefore as completed as soon as it reads something other than
all zeroes.
The driver does not distinguish from a card no longer signalling busy
and it being disconnected (and the line being pulled-up by the host).
This lead to writes being marked as successful when disconnecting
a busy card.
Now the card is ensured to be still connected by an additional CMD13,
just like non-SPI is ensured to go back to TRAN state.

While at it and since we already poll for the post-write status anyway,
we might as well check for SPIs error bits (any of them).

The disconnecting card problem is reproducable for me after continuous
write activity and randomly disconnecting, around every 20-50 tries
on SPI DS for some card.

Fixes: 7213d175e3b6f ("MMC/SD card driver learns SPI")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
v2:
  - Reorder err and status check for err to take precedence and look cleaner
v3:
  - Move the logic into its own function

 drivers/mmc/core/block.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4e67c1403cc9..eb539dbe00e8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1880,6 +1880,33 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
 	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
 }
 
+static int mmc_spi_err_check(struct mmc_card *card, struct mmc_queue_req *mqrq)
+{
+	u32 status = 0;
+	int err;
+
+	/*
+	 * SPI does not have a TRAN state we have to wait on, instead the
+	 * card is ready again when it no longer holds the line LOW.
+	 * We still have to ensure two things here before we know the write
+	 * was successful:
+	 * 1. The card has not disconnected during busy and we actually read our
+	 * own pull-up, thinking it was still connected, so ensure it
+	 * still responds.
+	 * 2. Check for any error bits, in particular R1_SPI_IDLE to catch a
+	 * just reconnected card after being disconnected during busy.
+	 */
+	err = __mmc_send_status(card, &status, 0);
+	/* All R1 and R2 bits of SPI are errors in our case */
+	if (err || status) {
+		mqrq->brq.data.bytes_xfered = 0;
+		if (err)
+			return err;
+		return -EIO;
+	}
+	return 0;
+}
+
 static int mmc_blk_busy_cb(void *cb_data, bool *busy)
 {
 	struct mmc_blk_busy_data *data = cb_data;
@@ -1903,9 +1930,12 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	struct mmc_blk_busy_data cb_data;
 	int err;
 
-	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
+	if (rq_data_dir(req) == READ)
 		return 0;
 
+	if (mmc_host_is_spi(card->host))
+		return mmc_spi_err_check(card, mqrq);
+
 	cb_data.card = card;
 	cb_data.status = 0;
 	err = __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

