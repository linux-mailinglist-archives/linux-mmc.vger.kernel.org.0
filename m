Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13B250578
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Aug 2020 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHXRQ1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Aug 2020 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgHXRQU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 13:16:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22698C061573
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 10:16:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z17so9475251ioi.6
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl71a8cghqkJSR267P9P0mVn6KDAwl29z7WcXnWApbw=;
        b=CVkUGe4wi7xJpIXZZjM4CDM2kUZqeM9SAA3oVUlDitCdrBc2e7Xoif2L0s0narbqp6
         rT8cIz+pJWuOfi+8YRApNDUn7x4k5tU3f50o8jSGlSLwRUADB/KEbZhXucNgiTaVkO9e
         9yoqk+xs2Jhp969r7l0mrYSWSgcOu7ANi7gbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl71a8cghqkJSR267P9P0mVn6KDAwl29z7WcXnWApbw=;
        b=EXdt2RbByat/VffgwifwH7uPOfQtvUq0BSf0MjY+Zs/Arr9LmuMRRbzhHc+yW0nBG2
         7xvhgEMqpIi6MWHTYOUiZqy5vCQbTAU722Z8zuXjLIpLtdyBad3w2OANSuQOc3lY57v/
         BdN7ipIb2MH3q8vRSMczx0P7mLMkDNbq/pOVoVRwUw0/pmqygCQA7swPnXl1dXb6vcSj
         BSUCPc3IGe09ykZDtjizNognJPeYdc00zkdZVQbda2nsnS2bSLkD+7UUaCQCaHZCvraz
         q2qEBh7+NehrYkIU11cd6Pw3TXyDrcmjAtQzw1qXn27T23JPTJmZ9xiVfd0Vw6PG/vuO
         UDTQ==
X-Gm-Message-State: AOAM530ra93XmH5Xyyk3P5uAzwhJbXCeJCZ4gddtUOkUwUiOwJdjUjTH
        08/pT7Mz2NUW/Ig5qJO2TA1zJA==
X-Google-Smtp-Source: ABdhPJzJpVpTBCn9w1SRoKPNDmqmftKz/0Hk0SqBHm4+qva5yK1qN6pusdN1tE19FBtGZFn2rMK8zQ==
X-Received: by 2002:a6b:5c03:: with SMTP id z3mr5669907ioh.16.1598289371025;
        Mon, 24 Aug 2020 10:16:11 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id p77sm7618499ill.39.2020.08.24.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:16:10 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     chris.wang@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Don't enable presets while tuning
Date:   Mon, 24 Aug 2020 11:16:07 -0600
Message-Id: <20200824111427.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
used for DDR52. The HS400 retuning sequence is:

    HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400

This means that when HS400 tuning happens, we transition through DDR52
for a very brief period. This causes presets to be enabled
unintentionally and stay enabled when transitioning back to HS200 or
HS400.

This patch prevents enabling presets while tuning is in progress.

     change and that presets were still disabled.

Fixes: 0dafa60eb2506 ("mmc: sdhci: also get preset value and driver type for MMC_DDR52")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
The indentation changed because I ran clang-format

 drivers/mmc/host/sdhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b1158c1c0c9..fd702c436c165 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2360,12 +2360,13 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->timing = ios->timing;
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
-				((ios->timing == MMC_TIMING_UHS_SDR12) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
-				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
-				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
+		    !mmc_doing_retune(mmc) &&
+		    ((ios->timing == MMC_TIMING_UHS_SDR12) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR25) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR50) ||
+		     (ios->timing == MMC_TIMING_UHS_SDR104) ||
+		     (ios->timing == MMC_TIMING_UHS_DDR50) ||
+		     (ios->timing == MMC_TIMING_MMC_DDR52))) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
-- 
2.28.0.297.g1956fa8f8d-goog

