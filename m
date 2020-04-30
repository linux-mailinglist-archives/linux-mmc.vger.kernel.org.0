Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727451BF3F8
	for <lists+linux-mmc@lfdr.de>; Thu, 30 Apr 2020 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgD3JRH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 30 Apr 2020 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JRG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 05:17:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EDBC035494
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so5708676ljl.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYtBS8/bdD7KI7PkR78/ZukbdqMPK7h5qCtkWF9k0YU=;
        b=c6hkv6C0TY7SlLSo0HHsD8TibtF+oxLni1E/8ReD3pQTWO1T+s68/ye2YNSPbhofo0
         X3/0IBH1kA3BmL7drTNNrGx4WSPP+XEQwbcx4WLf60zc/AEM7m21upvdkXH6+JF8tgJh
         L+3m0HnIPAoUBDbzwzuCIwbv5C3nlbovQ07c6FAeJ+Q3tb27gorLxkuoM3YF43L+qJ81
         pFTfxQsu97W7PR6zrq0LVXUN/WvAITdYI/ES/fhvnlM1s6heFZlH7w31qUhmslgUKvgV
         Dg6a7/R5C3XRWi5Mej+w+8VHsNtCQY1/d6rjCixiW7i7TdMDb4OgsmGtqa6f2nBGxQcn
         rPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYtBS8/bdD7KI7PkR78/ZukbdqMPK7h5qCtkWF9k0YU=;
        b=SQgi4nQHnjZ65iSD6EzI04KJb5GQ0MJIaDWGLuaiROs6hKbchtmLPFWjyvt5v01AWJ
         xtz3rgXUuTADR0UpWL9GRiiDjsVQCCcnL03PrPXjDPoSbkS6L+6RM/BJfc2HwtWlG1Kj
         WUZDgA8e69C2YNr2jko9VaaUYsNETQ/DKfVSAn0OrzhHHFL/hXVWNtJa9RlQKGiuZETl
         qlJZcJuto1DGeAAvwpYnteovsLOmyqPzLm7P5W1rLpqRQu5oh4asH1ZXbQcC0uvCTNM+
         +Iax21rP0YX3iKI6JJktxzB8M75VQfiOXW0JOKDQQoxVE611c/5aKchldnL5/2l/xveM
         uzrg==
X-Gm-Message-State: AGi0PuZH8kUAZSeQRYPWBhp776gPv9nrSyDYxn8TqiEzDJLv76ET4OWa
        KIGkUpphxoQ+1acaE+ONYbZm6XeezMo=
X-Google-Smtp-Source: APiQypJXJNEDjnXvxoxl/55gotG0f2jHRvoKAQlg+Ap/uoeQIwlR5mebUgjpTdjde8nWPTOnwUBhdQ==
X-Received: by 2002:a2e:760c:: with SMTP id r12mr1502937ljc.139.1588238223120;
        Thu, 30 Apr 2020 02:17:03 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x29sm4417818lfn.64.2020.04.30.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:17:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 3/4] mmc: sdio: Re-use negotiated OCR mask when re-sending CMD8
Date:   Thu, 30 Apr 2020 11:16:39 +0200
Message-Id: <20200430091640.455-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430091640.455-1-ulf.hansson@linaro.org>
References: <20200430091640.455-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

While initializing an SDIO card in mmc_sdio_init_card(), we may need to
retry the UHS-I specific initialization, in case the first attempt fails.

This leads to resending a CMD8, but also to restart from scratch with the
so called OCR mask negotiations. This is unnecessary as we already have a
negotiated OCR mask, so let's use that instead. In this way, the behaviour
also becomes more consistent with other similar paths.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 20eed28ea60d..853ac65f0485 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -543,12 +543,12 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	return err;
 }
 
-static void mmc_sdio_resend_if_cond(struct mmc_host *host,
+static void mmc_sdio_resend_if_cond(struct mmc_host *host, u32 ocr,
 				    struct mmc_card *card)
 {
 	sdio_reset(host);
 	mmc_go_idle(host);
-	mmc_send_if_cond(host, host->ocr_avail);
+	mmc_send_if_cond(host, ocr);
 	mmc_remove_card(card);
 }
 
@@ -640,7 +640,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (rocr & ocr & R4_18V_PRESENT) {
 		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
-			mmc_sdio_resend_if_cond(host, card);
+			mmc_sdio_resend_if_cond(host, ocr_card, card);
 			retries--;
 			goto try_again;
 		} else if (err) {
@@ -712,7 +712,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	err = sdio_read_cccr(card, ocr);
 	if (err) {
-		mmc_sdio_resend_if_cond(host, card);
+		mmc_sdio_resend_if_cond(host, ocr_card, card);
 		if (ocr & R4_18V_PRESENT) {
 			/* Retry init sequence, but without R4_18V_PRESENT. */
 			retries = 0;
-- 
2.20.1

