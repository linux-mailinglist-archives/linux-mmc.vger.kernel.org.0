Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300D11028B2
	for <lists+linux-mmc@lfdr.de>; Tue, 19 Nov 2019 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKSPzJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 19 Nov 2019 10:55:09 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36087 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSPzJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Nov 2019 10:55:09 -0500
Received: by mail-qv1-f67.google.com with SMTP id cv8so8163088qvb.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Nov 2019 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D8wsC5xHZbuma+zY4qTLvNmX92B4x231yNHJl390MNo=;
        b=fQljWVTmezUqOCh0ipvy6rP28WChEvDokbtcydl0xwLM7Zqe6os4v1FfK2epTIeYEC
         OJkEBD/9UNr6V5efs/Lybrto9swRAwLCd2R9lUfYo8FYhI6lkVF5kol+AEcacKH1zgam
         AEudIgbsxcbC0JWQtgLJctL6wsO5XXAA/WbWJPFivoPje+8q8CKYnkrN36PeuKdVaXEn
         F8aVlgX2Yy5NCAGOScvw8HZ5/Cv23LBapYOGhTsu0pPwfDrKqox1J9Rw5todAIphVRsM
         JQc7iYq6IJgaDHLaY+qhf54OeCA6Zjory7ZhyhCHxbi7tZGBsM7u9D2kc6t+yQ0qEIC7
         bPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D8wsC5xHZbuma+zY4qTLvNmX92B4x231yNHJl390MNo=;
        b=ap8sCQ3Qc3gQlICyW73moUPZcAornE+OabYwC1/A6eh670tkrRWujFwTajLUBczqIo
         JmCh+rAQz0UG4D+Fvwa9HDIckDJ1ufRdZpn115Yb5KZYK4J70P7jWNCcGedzFa3PgVn5
         +lZRh1Rg3seZ5EoRQIlXve3Np6lZiK0UVPdnnCgxWnTK6LLqAE3Svht/z3cPz8qlt7PO
         7ZHtbpv9fKAjMnitmS0bNn6T5WhmnVcernI2DvTn8AkDIJXvt7mv2hpjWEzNTS5DIZGV
         vPiN8ZZpN7jIw1emRihJ9x+ApGWfMrCSZglLGZFVyXMuynSM7l+jypqb7a4qJYlDAKdy
         QHiQ==
X-Gm-Message-State: APjAAAVK4dSeBaQFitT9RYpWihT5a6T0lc5Kw3E+twfQXR3Sp1VV0QXK
        MEn2quSaGoKrrxMP5BVgROE=
X-Google-Smtp-Source: APXvYqwTDdBB2PKxiF9e+p0nBf8dmbH19cGo+XrbTZWX5B5GqOzfxLeHHadUfJGmHPvFqMRK68jDQg==
X-Received: by 2002:a0c:8e87:: with SMTP id x7mr30918379qvb.112.1574178908174;
        Tue, 19 Nov 2019 07:55:08 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id b6sm9269449qtp.5.2019.11.19.07.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:55:07 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci: Fix grammar in warning message
Date:   Tue, 19 Nov 2019 12:55:03 -0300
Message-Id: <20191119155503.21421-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The correct form is "did not become", so fix it accordingly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 09cdbe86d9f9..3140fe2e5dba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2213,7 +2213,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		if (!(ctrl & SDHCI_CTRL_VDD_180))
 			return 0;
 
-		pr_warn("%s: 3.3V regulator output did not became stable\n",
+		pr_warn("%s: 3.3V regulator output did not become stable\n",
 			mmc_hostname(mmc));
 
 		return -EAGAIN;
@@ -2245,7 +2245,7 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		if (ctrl & SDHCI_CTRL_VDD_180)
 			return 0;
 
-		pr_warn("%s: 1.8V regulator output did not became stable\n",
+		pr_warn("%s: 1.8V regulator output did not become stable\n",
 			mmc_hostname(mmc));
 
 		return -EAGAIN;
-- 
2.17.1

