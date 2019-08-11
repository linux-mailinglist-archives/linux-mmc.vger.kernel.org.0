Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18888F13
	for <lists+linux-mmc@lfdr.de>; Sun, 11 Aug 2019 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHKCZs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 10 Aug 2019 22:25:48 -0400
Received: from mail.overt.org ([157.230.92.47]:40673 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKCZr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 10 Aug 2019 22:25:47 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2019 22:25:46 EDT
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id 4B9F63F246;
        Sat, 10 Aug 2019 21:19:22 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1565489964; bh=8mbkoHErb1nATqQiVlFtsSYa/e89YqDgc7T5aPFexn8=;
        h=From:To:Cc:Subject:Date:From;
        b=MNxDi+kcpbOGPKyWbYW7RzbjfowncwlQyzE1m5VLzQj5pWd42TSNQEzdtDDdwCZ8D
         abmCfD9H/GiXd1MyVv4K1lrGCglYdlzu/0Fwl6ZG8zUQtypDouZueNgzyHJCsjW8Dw
         k8ZceXUc6CN4gw4rMx+bVSSnr9syHPsdGpdcLdIiB2lFZYfTWOiiwgKoUJEHUPo9sx
         jbPFZZawkDuzU7QWwFVAfEM9Sd9z4HYH6GGkl/TLe1Tef5aFuYs7rB8nmb/VupR9+L
         r71n+g2JFTC80w1pOUoMAOAJ5y7noRGjKQ3qmA+P1HgYsERpy2cNvlYpwMQoczO//r
         TvZp2+14LQcGw==
From:   Philip Langdale <philipl@overt.org>
To:     linux-mmc@vger.kernel.org
Cc:     Philip Langdale <philipl@overt.org>
Subject: [PATCH] mmc: rtsx_pci: Do not set MMC_CAP2_FULL_PWR_CYCLE
Date:   Sun, 11 Aug 2019 10:19:17 +0800
Message-Id: <20190811021917.29736-1-philipl@overt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There have been multiple reports of failures for newer SD cards
with Realtek readers using the rtsx_pci_sdmmc driver in recent
months, including myself.

One common theme was that A2 cards all failed while older cards
worked fine. The first reports in bugzilla showed up in late
2018 corresponding with the availabilty of these cards.

I did some experiments and saw that removing the
MMC_CAP2_FULL_PWR_CYCLE cap from the driver made the problem
go away. That then causes us to ask why it helps. This cap was
introduced to provide a way for a host controller to indicate it
can fully power cycle a card. Then in ce69d37, we introduced
power cycling a card as part of changing the operation voltage
of the card.

Now, this is the part where I'm under-informed, but reading the
SD spec, it says that the card will reset to 3.3V operations on
a power cycle, which seems to make sense, as it always has to
be negotiated.

Then, we observe that A2 cards are _required_ to support low
voltage signalling (1.8V) and this is, I think, the only host
visible difference in A2 vs older cards. And in my testing
(with a deficient set of cards, I admit - I'm away from my
main collection), I see that the A2 card does indeed get
switched to 1.8V while older (pre-UHS) cards always run at
3.3V. I unfortunately lack any UHS pre-A2 cards to test
whether 1.8V capable pre-A2 cards fail or succeed, but I
would expect them to fail (and maybe no one was making 1.8V
cards routinely until A2).

This leaves me slightly undercertain as to the root of the
problem. Perhaps the issue is that the driver should not have
ever set this flag, because the hardware doesn't actually support
the functionality that the flag corresponds to. Or, perhaps the
problem is that power cycling on setting the voltage is never
correct for an SD card, or only correct for eMMC, etc.

There are a handful of embedded controllers that the cap is set
for in device tree and the rtsx controllers (pci & usb) are the
only 'traditional' drivers that set the cap. As such, I think
the most likely explaination is that the cap was incorrectly
set in the first place, based on a misunderstanding of what
it actually means.

So, let's stop setting the cap, and observe that A2 cards
now work correctly.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201447
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=202473
Signed-off-by: Philip Langdale <philipl@overt.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index bd50935dc37d..1d7c942fc7f3 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1345,7 +1345,7 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
-	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
+	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
 	mmc->ops = &realtek_pci_sdmmc_ops;
-- 
2.20.1

