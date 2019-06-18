Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943284A581
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfFRPfH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 11:35:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44414 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFRPfG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 11:35:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so13549768ljc.11
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39AvwfEHlmBtGb6TxK0PyFLzSAjznL8ashWYfCKeN2c=;
        b=DUVUxibyDbzeXA/hk3Zo8He9/+aJwnnN/pWh2NoweNxHStKsgrZcL3ZumTlXIZi9dc
         WeUijBH1Poz8ChLYZL1bKBUZAU3ZR2rj+GsEo6x7xMich3xxY2RV2kmS46NGxJI1MlWJ
         MRV+/JP6Ow8j7mAt22aZqlyJMo58hJW7C1+l5F2aW3gLhq3E6aifPYIMX50uxHGyRfAj
         nyDIqPeURa/a7Fy4aPbWw0kn8Ksosu30TGM/Pb52uAWj/Szv97GuIBw2bLOWuedt4IlD
         CFBVs6KhAozkHAU+vLUcbzP663GUGFkz2FWRwQ9+z//w/fik73WCUrLkrWQCSIWWuAav
         LI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39AvwfEHlmBtGb6TxK0PyFLzSAjznL8ashWYfCKeN2c=;
        b=g2gSXsgm/9KOjV/t7jqOB77OuqAKorOThRjTv1eLq1+lZZX9gv0TesEfB9ekTU12u9
         sndLlbst9c0fSwiRfbf4jUAohBGz+ighDsBddEfq5jIk3L0O3ZUq1ef8v518eEh5CrGB
         xm/6Zvuvlan5OAYjE+0h4Iq6JaO+MIYVvH2vFPlhd3U2GZhXAeFzWwZy8H4HBP9wpTm5
         8xfVcTizD3/qMOuwqL0gKJLej2DEiZHwoCWcIiiLNW27u1BS+TGH/yJasjaQfDedpq4g
         ScwT583/zmNIQgCmK0GoRDrHdF0frg6FZ5cj8hM7wDEq3jTNhogjHGhVJmN6GTE1n23p
         789g==
X-Gm-Message-State: APjAAAVZ8QJX45fdwIPLWcWPh+ySffG//g6bG5ECXNKn+p/xdyT0mmr9
        T4RCZO3krB6nEfcwxJ8kubC7Q3gRvwk=
X-Google-Smtp-Source: APXvYqzqSuNRPHYXuZYjsrM4vMz/pSEweQAxVCKNSjhT88bGxkBRwG2XZGuS418CXp2VRlIwakP1rw==
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr47966037lji.209.1560872104224;
        Tue, 18 Jun 2019 08:35:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:35:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
Date:   Tue, 18 Jun 2019 17:34:45 +0200
Message-Id: <20190618153448.27145-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To use the so called powered-on re-initialization of an SDIO card, the
power to the card must obviously have stayed on. If not, the initialization
will simply fail.

In the runtime suspend case, the card is always powered off. Hence, let's
drop the support for powered-on re-initialization during runtime resume, as
it doesn't make sense.

Moreover, during a HW reset, the point is to cut the power to the card and
then do fresh re-initialization. Therefore drop the support for powered-on
re-initialization during HW reset.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 29f86c1e9923..a9bfcae8db5b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1028,13 +1028,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
-	int ret;
-
-	ret = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
-	if (!ret && host->sdio_irqs)
-		mmc_signal_sdio_irq(host);
-
-	return ret;
+	return mmc_sdio_reinit_card(host, 0);
 }
 
 static int mmc_sdio_runtime_suspend(struct mmc_host *host)
-- 
2.17.1

