Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FE6AB76
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfGPPN0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 11:13:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:26405 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPN0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 11:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563290004;
        s=strato-dkim-0002; d=fpond.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/oKBVysnS6pnsgJqnvc4PKg6WVXy4zXMetDOoCMTtvs=;
        b=b3t+7CTRnK7v4SXPA4sADDK/7TmV6DcUkaU3052tZjahqXZj8GtE4IvoD8tckk/kw1
        Wuv2nbaigflJCstpLXHLOlkrykGoOW5XioUET5t/+PcRlUQs47u/bUQdI7WMaC/b3v02
        5/dGTUQxR5nyVBZQu1Q1vU4X3CLjS95CTHxqQyKNLylx6M7lY3yUZwGZiADz7NCzjxUo
        S5EU7FQ+oJ06xGsR0u3ESC43H9ZXJIRcUXT4zwLOHUfu9F5mBQKkOJE1J9gnRDqLTnj6
        RSt7cWnC1airfbfH5ntPdubr22f5UvL3Sa1HnsZx/cFk09jwxfLe+gx6JJWMcteFqAYf
        x7Iw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA67Ot4fvR82dYd7rJSdw="
X-RZG-CLASS-ID: mo00
Received: from groucho.site
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v6GF1Ed5I
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 16 Jul 2019 17:01:14 +0200 (CEST)
From:   Ulrich Hecht <uli+renesas@fpond.eu>
To:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     niklas.soderlund@ragnatech.se, wsa@the-dreams.de,
        yamada.masahiro@socionext.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, magnus.damm@gmail.com,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 2/2] mmc: tmio: remove obsolete PM workaround
Date:   Tue, 16 Jul 2019 17:01:04 +0200
Message-Id: <1563289264-26432-3-git-send-email-uli+renesas@fpond.eu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
References: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Obsoleted by
"mmc: tmio: move runtime PM enablement to the driver implementations".

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
---
 drivers/mmc/host/tmio_mmc_core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 26dcbba..29c0d2c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1221,15 +1221,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->reset = tmio_mmc_reset;
 
 	/*
-	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
-	 * hotplug gets disabled. It seems RuntimePM related yet we need further
-	 * research. Since we are planning a PM overhaul anyway, let's enforce
-	 * for now the device being active by enabling native hotplug always.
-	 */
-	if (pdata->flags & TMIO_MMC_MIN_RCAR2)
-		_host->native_hotplug = true;
-
-	/*
 	 * While using internal tmio hardware logic for card detection, we need
 	 * to ensure it stays powered for it to work.
 	 */
-- 
2.7.4

