Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0415D10C7F
	for <lists+linux-mmc@lfdr.de>; Wed,  1 May 2019 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEARzH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 May 2019 13:55:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37513 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEARzH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 May 2019 13:55:07 -0400
Received: by mail-it1-f194.google.com with SMTP id r85so11013301itc.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 May 2019 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uxj4eaoNpSrPRNPfGOWw+nAI5ei5rNPE4Zz0eGAIncQ=;
        b=JNruUJ7gsvMMumZ5pwArN8KMnaLlMBIibpuZxx7BAJD42ZxX7b3LrmqnqYo4/MDqFO
         dvgVUfvRHdOK6AmG1okETPXKrxva+eI2kSuHkKwklwv00I0EiXx+5052rRbZ3fGqVDEm
         vg8ndfuvDOEQzQb6N/j82EgIcbHlGmTNurlfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uxj4eaoNpSrPRNPfGOWw+nAI5ei5rNPE4Zz0eGAIncQ=;
        b=snN0tsdCvmsasIgfIXM3zC19g0eUMKWCPIxFaw8nQKXzuOgMKDVB4axlDtFSpKinwn
         8UWlNIjgD8fghIhLhNaa9NvRSaYr1TIq8K4jZMrt/ChB3tpmNLri8Sk2xN50pHTfdp5S
         BBLNLRc/ZIY9X+qOw3zcVqM2EzQxSa8lIlOghJdST1Q/2hn0MfRULyzoN9DfdT7s4qr7
         2V3iXOtM7E9RWFcCDe5jLjGOnZXSA7CgjWsfTSL36N9YZcWpZwAqGfouIYgqSjNE6OmT
         ej8RplvKHsjxMKslWeSeb6v24gf1XLAwHb4blOXkqvr/QuGtK2nIlvOwoHmPZPt4FIl7
         JwRA==
X-Gm-Message-State: APjAAAW+YbEjdrdq3KmTKOrIG/N5qOgIJ6v0HAz69I2NaC7WPIRuVM9W
        Q6lc5BbFVCCd7Fn5AVnLcbeqsRmOOU3oWw==
X-Google-Smtp-Source: APXvYqzpVR6PQtpadZMu+h/Pzk97UCjaX+Mujf8dWuxCZ8cPgJOzT/0R0gqaARbn9CKksFrazn09PQ==
X-Received: by 2002:a24:29d4:: with SMTP id p203mr9259864itp.63.1556733306079;
        Wed, 01 May 2019 10:55:06 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t24sm10175129ioc.1.2019.05.01.10.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:55:05 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after reset
Date:   Wed,  1 May 2019 11:54:56 -0600
Message-Id: <20190501175457.195855-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a race condition between resetting the SDHCI controller and
disconnecting the card.

For example:
0) Card is connected and transferring data
1) mmc_sd_reset is called to reset the controller due to a data error
2) sdhci_set_ios calls sdhci_do_reset
3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
configured.
4) Wait for SOFT_RESET_ALL to clear
5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
   IRQs are not configured a CARD_REMOVED interrupt is never raised.
6) IRQs are enabled again
7) mmc layer never notices the device is disconnected. The SDHCI layer
   will keep returning -ENOMEDIUM. This results in a card that is always
   present and not functional.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
You can see an example of the following two patches here:
https://privatebin.net/?b0f5953716d34ca6#C699bCBQ99NdvspfDW7CMucT8CJG4DgL+yUNPyepDCo=
Line 8213: EILSEQ
Line 8235: SDHC is hard reset
Line 8240: Controller completes reset and card is no longer present
Line 8379: mmc_sd_reset notices card is missing and issues a card_event
           and schedules a detect change.
Line 8402: Don't init the card since it's already gone.
Line 8717: Marks card as removed
Line 8820: mmc_sd_remove removes the block device

I am running into a kernel panic. A task gets stuck for more than 120
seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
calling something correctly?

Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=

I sometimes see the following:
[  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time

I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
So I'm guessing I'm missing an upstream fix.

Do the patches look correct or am I doing something that would cause a
kernel panic?

I have a DUT setup with a GPIO I can use to toggle the CD pin. I ran a
test where I connect and then randomly, between 0s - 1s disconnect the
card. This got over 20k iterations before the panic. Though when I do it
manually and stop for 2 minutes the panic happens.

Any help would be appreciated.

Thanks,
Raul


 drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..9206c4297d66 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 static int mmc_sd_hw_reset(struct mmc_host *host)
 {
+	int present;
 	mmc_power_cycle(host, host->card->ocr);
+
+	present = host->ops->get_cd(host);
+
+	/* The card status could have changed while resetting. */
+	if ((mmc_card_removed(host->card) && present) ||
+	    (!mmc_card_removed(host->card) && !present)) {
+		pr_info("%s: card status changed during reset\n",
+		       mmc_hostname(host));
+		host->ops->card_event(host);
+		mmc_detect_change(host, 0);
+	}
+
+	/* Don't perform unnecessary transactions if the card is missing. */
+	if (!present) {
+		pr_info("%s: card was removed during reset\n",
+			mmc_hostname(host));
+		return -ENOMEDIUM;
+	}
+
 	return mmc_sd_init_card(host, host->card->ocr, host->card);
 }
 
-- 
2.21.0.593.g511ec345e18-goog

