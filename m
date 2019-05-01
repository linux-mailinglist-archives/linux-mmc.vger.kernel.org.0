Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5B10E4E
	for <lists+linux-mmc@lfdr.de>; Wed,  1 May 2019 22:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEAU4t (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 May 2019 16:56:49 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.60]:31620 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfEAU4t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 May 2019 16:56:49 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 16:56:49 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B7E2446BE
        for <linux-mmc@vger.kernel.org>; Wed,  1 May 2019 15:36:43 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Lvy7hrFdldnCeLvy7hbJyg; Wed, 01 May 2019 15:36:43 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=52658 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hLvxm-003wyT-QW; Wed, 01 May 2019 15:36:42 -0500
Date:   Wed, 1 May 2019 15:36:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] mmc: usdhi6rol0: mark expected switch fall-throughs
Message-ID: <20190501203621.GA11352@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hLvxm-003wyT-QW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:52658
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from drivers/mmc/host/usdhi6rol0.c:9:
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_timeout_work’:
./include/linux/device.h:1483:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro ‘dev_err’
   dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
   ^~~~~~~
drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
  case USDHI6_WAIT_FOR_CMD:
  ^~~~
drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   usdhi6_sg_unmap(host, true);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
  case USDHI6_WAIT_FOR_DATA_END:
  ^~~~
  CC [M]  drivers/isdn/hisax/hisax_isac.o
drivers/mmc/host/usdhi6rol0.c: In function ‘usdhi6_stop_cmd’:
drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (mrq->stop->opcode == MMC_STOP_TRANSMISSION) {
      ^
drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Turn multiple line comments into single line comments.
 - Fix additional fall-through warning.

 drivers/mmc/host/usdhi6rol0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index cd8b1b9d4d8a..f0cc5e0dbf79 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host)
 			host->wait = USDHI6_WAIT_FOR_STOP;
 			return 0;
 		}
-		/* Unsupported STOP command */
+		/* fall through - Unsupported STOP command */
 	default:
 		dev_err(mmc_dev(host->mmc),
 			"unsupported stop CMD%d for CMD%d\n",
@@ -1687,7 +1687,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 	switch (host->wait) {
 	default:
 		dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
-		/* mrq can be NULL in this actually impossible case */
+		/* fall through - mrq can be NULL in this actually impossible case */
 	case USDHI6_WAIT_FOR_CMD:
 		usdhi6_error_code(host);
 		if (mrq)
@@ -1709,10 +1709,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
 			host->offset, data->blocks, data->blksz, data->sg_len,
 			sg_dma_len(sg), sg->offset);
 		usdhi6_sg_unmap(host, true);
-		/*
-		 * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
-		 * the page
-		 */
+		/* fall through - If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped the page */
 	case USDHI6_WAIT_FOR_DATA_END:
 		usdhi6_error_code(host);
 		data->error = -ETIMEDOUT;
-- 
2.21.0

