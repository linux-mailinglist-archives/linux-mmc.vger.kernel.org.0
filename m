Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4E782CD
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Jul 2019 02:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG2AZM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 28 Jul 2019 20:25:12 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.39]:15226 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfG2AZM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Jul 2019 20:25:12 -0400
X-Greylist: delayed 1426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 20:25:11 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 023591456D
        for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2019 19:01:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rt6ShyWNyYTGMrt6ShmhRN; Sun, 28 Jul 2019 19:01:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I9uOKHxVbt8UeBd3GkXgx66REfHuRvFkiJYnkeKfdME=; b=sPPzipz0aQZkir5rbCZc/LsTW4
        7VTuB9XmG+yuadoPyxL4T8CglDxGgDyFw5mYV2qkySG4vU2U8NfGTEBa+D1vDWcMyEQ9Hacr5RdqD
        BVCOy71YUdA8LyKugLGPodqigEha2td6bMTsNkq5V/KPVv5xLxMcO3xJoqSpm21EyYclq322FyuCD
        s6i+a8l4nlqvuykhP3EnQWr+YMnzqD/UlwXeaGJfb1x7wyrgqc5vn/9hgFKlOXavCiJRlXvdJ/vyJ
        1pP+ZNa+9fLhbEFYT9nqyROtbDqYiKuP+JmRhBwvZKFvWuAHn2zpZT9QGCymUsUQLVRIH6N5tV3MW
        4pvmc8DQ==;
Received: from [187.192.11.120] (port=39644 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrt6R-003owE-Nk; Sun, 28 Jul 2019 19:01:23 -0500
Date:   Sun, 28 Jul 2019 19:01:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <20190729000123.GA23902@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrt6R-003owE-Nk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mmc/host/atmel-mci.c: In function 'atmci_get_cap':
drivers/mmc/host/atmel-mci.c:2415:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.has_odd_clk_div = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2416:2: note: here
  case 0x400:
  ^~~~
drivers/mmc/host/atmel-mci.c:2422:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.has_highspeed = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2423:2: note: here
  case 0x200:
  ^~~~
drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->caps.need_notbusy_for_read_ops = 1;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
drivers/mmc/host/atmel-mci.c:2427:2: note: here
  case 0x100:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/atmel-mci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9ee0bc0ce6d0..c26fbe5f2222 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
 	case 0x600:
 	case 0x500:
 		host->caps.has_odd_clk_div = 1;
+		/* Fall through */
 	case 0x400:
 	case 0x300:
 		host->caps.has_dma_conf_reg = 1;
@@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
 		host->caps.has_cfg_reg = 1;
 		host->caps.has_cstor_reg = 1;
 		host->caps.has_highspeed = 1;
+		/* Fall through */
 	case 0x200:
 		host->caps.has_rwproof = 1;
 		host->caps.need_blksz_mul_4 = 0;
 		host->caps.need_notbusy_for_read_ops = 1;
+		/* Fall through */
 	case 0x100:
 		host->caps.has_bad_data_ordering = 0;
 		host->caps.need_reset_after_xfer = 0;
+		/* Fall through */
 	case 0x0:
 		break;
 	default:
-- 
2.22.0

