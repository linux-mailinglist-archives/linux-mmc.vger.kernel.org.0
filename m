Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372D52AABD
	for <lists+linux-mmc@lfdr.de>; Tue, 17 May 2022 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352115AbiEQS1y (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 May 2022 14:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiEQS1w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 14:27:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E573A5EC;
        Tue, 17 May 2022 11:27:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so17641433pfa.7;
        Tue, 17 May 2022 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYtgIznm21TVQ7ViKJW4yH+KEfcmA7jYzNlTXWmB3cQ=;
        b=oaHCqgLaRl6UsDy08j3qFv7XdR1YqM13Lkzsa7Kq5n9noFoiVcDQIHgOMCH2iaMbWD
         8lYFSo9KVs+d6pM32pUMirYkEXl43gIgmCows5n97Sh+UY2uv2VpICA99oea8RL/EFji
         PhtBDbjM02wySXxinEoUp6cIKQt1dxOQ0tF0eMH3YhfeCKsBwucPakGoFBjk5Z/u7Cml
         ETWuwg4ekzu6M+iB2aX6yZeC4SdbMEVg4nYVBKsvJmB7+XIuvZgoP4m8leOd92WABvZu
         5zOYK9buwAtTEQa15/V39nAqZ1MkwkQaPnr3/IeScu0CXz3oRV5V8+MYhlgehWq1M+pZ
         7oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYtgIznm21TVQ7ViKJW4yH+KEfcmA7jYzNlTXWmB3cQ=;
        b=p/+UgPMnmnmrpDxLU7eAZaMXJ8kusG6ejSUUJ4Xbnol3Avpn9QlJSbVC+8pfWmUeXx
         GttvQ5ilJkpPblRNYtjBp2a5/huX6k6n7cNvcoJRCbx1FLf8+c5+uXA2bE0cImNe7J2t
         kzVAn8KYEXAfHQrgoZB/JzxOL9LA1XpgCX6s79L05/NSnC3fFQ6B67qj35orL128vQHE
         o4HLlwo2UivqbcZxBQvAlunOLc9L5RiE2Op+QOvYZhVM4wrqKtQtOwc7Q1NSeXTIrbgo
         KTF/snjXuHFdQfl8yssgzSFVgTAtOuogMnDVxnN9fbgj428IMj414saH/pH0eGMis+a2
         KS2g==
X-Gm-Message-State: AOAM531UJUt64SKZpUWrt0RQeHYvgdoL4rtnYdPufjQ75fGHhVK2uceR
        ts6U6Q0JGRvwjj1nE5ZMyD+GYmrTYWI=
X-Google-Smtp-Source: ABdhPJyU94RpW4zoa3mqcNKTQcrGOQipEy8ypld8BEQ8/eRPMIU0sdYEFkxD2GskeHX/trVhoFWvHw==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr23895272pfc.39.1652812070948;
        Tue, 17 May 2022 11:27:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902d88c00b0015e8d4eb1fasm9538656plz.68.2022.05.17.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:27:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list),
        alcooperx@gmail.com, kdasu.kdev@gmail.com
Subject: [PATCH stable 4.14 1/3] mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
Date:   Tue, 17 May 2022 11:27:44 -0700
Message-Id: <20220517182746.252893-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517182746.252893-1-f.fainelli@gmail.com>
References: <20220517182746.252893-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9 upstream

The timeout values used while waiting for a CMD6 for BKOPS or a CACHE_FLUSH
to complete, are not defined by the eMMC spec. However, a timeout of 10
minutes as is currently being used, is just silly for both of these cases.
Instead, let's specify more reasonable timeouts, 120s for BKOPS and 30s for
CACHE_FLUSH.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20200122142747.5690-2-ulf.hansson@linaro.org
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mmc/core/mmc_ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 54686ca4bfb7..44e90062c95a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -23,7 +23,9 @@
 #include "host.h"
 #include "mmc_ops.h"
 
-#define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
+#define MMC_OPS_TIMEOUT_MS		(10 * 60 * 1000) /* 10min*/
+#define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
+#define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -989,7 +991,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	mmc_retune_hold(card->host);
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, timeout, 0,
+			EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS, 0,
 			use_busy_signal, true, false);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
@@ -1022,7 +1024,8 @@ int mmc_flush_cache(struct mmc_card *card)
 			(card->ext_csd.cache_size > 0) &&
 			(card->ext_csd.cache_ctrl & 1)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_FLUSH_CACHE, 1, 0);
+				 EXT_CSD_FLUSH_CACHE, 1,
+				 MMC_CACHE_FLUSH_TIMEOUT_MS);
 		if (err)
 			pr_err("%s: cache flush error %d\n",
 					mmc_hostname(card->host), err);
-- 
2.25.1

