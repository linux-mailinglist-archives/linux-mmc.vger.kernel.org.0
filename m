Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5A70CCDD
	for <lists+linux-mmc@lfdr.de>; Mon, 22 May 2023 23:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjEVVtL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 May 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjEVVtC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 17:49:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D627192
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 14:49:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOk-0001Eu-Gq; Mon, 22 May 2023 23:48:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOj-0026AP-Ih; Mon, 22 May 2023 23:48:57 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DOi-008YGG-J1; Mon, 22 May 2023 23:48:56 +0200
From:   Enrico Jorns <ejo@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, ejo@pengutronix.de
Subject: [PATCH 2/3] mmc-utils: fix printing OID for mmc in non-verbose mode
Date:   Mon, 22 May 2023 23:48:17 +0200
Message-Id: <20230522214818.2038252-2-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522214818.2038252-1-ejo@pengutronix.de>
References: <20230522214818.2038252-1-ejo@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It is parsed as an integer and printed as a char which does not really
make sense.
E.g. if OID is '0' (which does not seem to be uncommon), then this
prints a '\0' character and makes output nearly unreadable/unparsable.

Also, do not print it like it would be a string, instead use 0x<digit>
format.

Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
---
 lsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index da9d69e..cea43af 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid)
 		printf("\tCRC: 0x%02x\n", crc);
 	} else {
 		if (config->mmc_ids[mid])
-			printf("manufacturer: '%s' '%c'\n",
+			printf("manufacturer: '%s' 0x%01x\n",
 			       config->mmc_ids[mid], oid);
 		else
-			printf("manufacturer: 'Unlisted' '%c'\n", oid);
+			printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
 
 		printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor);
 		printf("serial: 0x%08x\n", psn);
-- 
2.39.2

