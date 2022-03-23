Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823774E5412
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Mar 2022 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiCWOOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Wed, 23 Mar 2022 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiCWOOP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2022 10:14:15 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8163DA66;
        Wed, 23 Mar 2022 07:12:46 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D6223122FBB;
        Wed, 23 Mar 2022 15:12:43 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C4784122DBF;
        Wed, 23 Mar 2022 15:12:43 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 23 Mar 2022 15:12:43 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 15:12:43 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Wed, 23 Mar 2022 15:12:43 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "cloehle@posteo.de" <cloehle@posteo.de>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "david-b@pacbell.net" <david-b@pacbell.net>
Subject: [PATCHv2] mmc: block: Check for errors after write on SPI
Thread-Topic: [PATCHv2] mmc: block: Check for errors after write on SPI
Thread-Index: AQHYPsAQB7Ge7QSFOEmDJ2kn629cyA==
Date:   Wed, 23 Mar 2022 14:12:43 +0000
Message-ID: <cf04ac31665c48be9f275ed21332763b@hyperstone.com>
References: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com>
In-Reply-To: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26790.000
X-TMASE-Result: 10--2.793200-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi5rFdvBEmTnvLZ0InVwVLVTn5nfR7I2dFOxPXYIh1l6dlg7
        cH4SOkOpdWqA+wY3gFZusJxXwmCOnpDH5Y6LoY7BRZfQN+FVqbA1kR+05VC1hsiCh8yBqE+tbiP
        oclJOCy0MV38Bdz1roh5HSIAURpXTL/tBTZzO5Q0D2WXLXdz+Afb991FvFjWAd3XtjqAaoMLBTP
        qP0WxWQAGRC3bBIF8o0+pR+Ea5cIJI5l15C51feb+viKbH3Jj7+VJ6lZyB0s/3K1BQq7xa/qPFj
        JEFr+olIoOsWgr8s12OhzOa6g8KrfVs4fo5Jz/CFFjqD8M1Htc+HGIjyd7T85t1B6KjWowdgKQB
        rzCcMVk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: c45e74ff-0bbe-40a2-b079-69b958a98b15-0-0-200-0
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
  
 drivers/mmc/core/block.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4e67c1403cc9..54c2009f398f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1903,9 +1903,34 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	struct mmc_blk_busy_data cb_data;
 	int err;
 
-	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
+	if (rq_data_dir(req) == READ)
 		return 0;
 
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
+	if (mmc_host_is_spi(card->host)) {
+		u32 status = 0;
+
+		err = __mmc_send_status(card, &status, 0);
+		/* All R1 and R2 bits of SPI are errors in our case */
+		if (err || status) {
+			mqrq->brq.data.bytes_xfered = 0;
+			if (err)
+				return err;
+			return -EIO;
+		}
+		return 0;
+	}
+
 	cb_data.card = card;
 	cb_data.status = 0;
 	err = __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

