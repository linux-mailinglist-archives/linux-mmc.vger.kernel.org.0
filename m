Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C0372DB4
	for <lists+linux-mmc@lfdr.de>; Tue,  4 May 2021 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEDQNr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 May 2021 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhEDQNm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:13:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FFC061761
        for <linux-mmc@vger.kernel.org>; Tue,  4 May 2021 09:12:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c11so14080588lfi.9
        for <linux-mmc@vger.kernel.org>; Tue, 04 May 2021 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbWXoJHQ0uWHFVcBWf57QwZSLHYhmQWZi0APC0CkQ08=;
        b=gExKlqDoKgJalaIZaU8BM2x89Hb4Dohp9KedfOXruDPXVcWDkbMIubEXRTev60u9Th
         HcZRM3d7e8VDENDbx9lfI6MezGAisJxM1un5F/Yi1e2NR23HxAFVr0MsR2xpmDyh/tL8
         AEeIZn3rjHu66iBNPk3Dxe0fZ1LYs5keoyuEWGyNZAnb2ica6U0UeMr3NXzO35CiwVxi
         tsEszOaRd4F+OAR65+/pPl8pDiWdMZHW3pk+2xZOqB9Vp0l/GgNuBNWLE499L+A9Q+LJ
         Ku+PuQzagL5cp1qjHyUWmkt8mhIVkYt/L+FCAgIga1xTunlbn3N3Z9DAQwIJpighfA8X
         567A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbWXoJHQ0uWHFVcBWf57QwZSLHYhmQWZi0APC0CkQ08=;
        b=TCg4J851Q8o65I3PH96B1bcZ0J7gv10VEqEC0i/6eiiFjverNHbNMCZE2AQzaPOLpQ
         /q/3YBZrjA0/lhsnhHJBamyPhtef2D5fZprmj0vGaenP0ZzEtdwId1a5UHtCMoKDEoIq
         NVcWfSD3qGxsPxkFKbzZA/bltxDN3be5YUZqn6BTQ2mXSiuhlfYq7YUUPrQITCKLUH/7
         2EAhLkFOBZwA/MYcQOfoWm5hyfK6WbKbS0Asd7wwTJ2t8zA9Prl74Obl5awTt0vWjer0
         cJEZW62EwhNtXUNn+SPlw/XnfQeWTqQ6tVdSMmiSBrq4Ak6/K9WmU0M/JKELiDC3TRUq
         dECw==
X-Gm-Message-State: AOAM5322skMvGWAJ3e8CojWRuRjMnf0y7PdxLubCvPe9hY6RwB0PZzXT
        7hO2l68QhWnaF6G8vBzXEdSI0UnZuNGb6pB0
X-Google-Smtp-Source: ABdhPJyvMw01Rzrp2T1AFFthQkcduusLKNZ1Zsiz/LYkrImYWZ59EDKdnOxO8rE7EoDsNLHKgHvDrA==
X-Received: by 2002:a19:ac4a:: with SMTP id r10mr17287804lfc.112.1620144765023;
        Tue, 04 May 2021 09:12:45 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be re-used for additional cmds
Date:   Tue,  4 May 2021 18:12:17 +0200
Message-Id: <20210504161222.101536-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The function mmc_send_cxd_data() sends a data read command of ADTC type and
prepares to receive an R1 response. To make it even more re-usable, let's
extend it with another in-parameter for the command argument. While at it,
let's also rename the function to mmc_send_adtc_data() as it better
describes its purpose.

Note that, this change doesn't add any new users of the function. Instead
that is done from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 11 +++++------
 drivers/mmc/core/mmc_ops.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 653627fe02a3..b1da8f1950ee 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -252,9 +252,8 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
  * NOTE: void *buf, caller for the buf is required to use DMA-capable
  * buffer or on-stack buffer (with some overhead in callee).
  */
-static int
-mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
-		u32 opcode, void *buf, unsigned len)
+int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
+		       u32 args, void *buf, unsigned len)
 {
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
@@ -265,7 +264,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	mrq.data = &data;
 
 	cmd.opcode = opcode;
-	cmd.arg = 0;
+	cmd.arg = args;
 
 	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
 	 * rely on callers to never use this with "native" calls for reading
@@ -311,7 +310,7 @@ static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
 	if (!cxd_tmp)
 		return -ENOMEM;
 
-	ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
+	ret = mmc_send_adtc_data(NULL, host, opcode, 0, cxd_tmp, 16);
 	if (ret)
 		goto err;
 
@@ -359,7 +358,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	if (!ext_csd)
 		return -ENOMEM;
 
-	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD, ext_csd,
+	err = mmc_send_adtc_data(card, card->host, MMC_SEND_EXT_CSD, 0, ext_csd,
 				512);
 	if (err)
 		kfree(ext_csd);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index aca66c128804..2b1d730e56bf 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -26,6 +26,8 @@ int mmc_set_dsr(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
+int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
+		       u32 args, void *buf, unsigned len);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries);
 int mmc_send_status(struct mmc_card *card, u32 *status);
-- 
2.25.1

