Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51311561D
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Dec 2019 18:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFRIi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Dec 2019 12:08:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34685 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFRIi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 12:08:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so5837548lfc.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2019 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1ZcHKxjvTnD8f3+qXHmLK/liysdFzY/2mwIKJWbEjE=;
        b=snB1J2mQrwDed9vQ6dC7Zl+t4YtzNd5l9Upj8oNjM6oJzNZYShdR5A2u7Uf4d8piVe
         ICKb0Yw5W99EiVzQ6JxolBAAv1ZPe7hCDC7pQYW4KjGuEfSlL8bp7pUsC37B00rIlTfz
         HRvvLDnAw8oqf37WZX0j+ulFexLFRnbWCXupnlPlKm5JFbhu/ugKngduVGfCDHwE0VtF
         rY5GuY8KP8kVhaq0TTGMlQUkWNle6c8OVZmEwIODywqHXAiXl8CU11Xc+iyaKTj5WFwI
         gm+o+p2oZTRWv9o3FLXyXYWx1ArZhK65Z7JSAE0khVc89dbxrgxf/0mTmz9Zwnm4Mf1D
         YYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1ZcHKxjvTnD8f3+qXHmLK/liysdFzY/2mwIKJWbEjE=;
        b=N2F+SGttnL8m/+x7nxsf+K+b9Br0iNIT6nN3+50cdedh/zuEg74LJoJbG+pUHn6+50
         JT9AVwKuTiRsa1OAmpZiNI9EQztZ7RtCKbmQAkLjDSR96Mca9V8VumyjoYBoMrYnCzZY
         CElqb8Weu7vgUIHNsanZUsalfkl2Syfv4+uZGBQWqh5K67AnMntZDCcSpi+0+2dwxWg9
         xpw7maF05e2DZGeHMH1P94dVz4Y9ecbH011W/9OrVN4mRsmdVb3vKAGRCuPObCL0C4oj
         bO3BZRfNCFsuZD0+OLIJPQ9sWGiwT75PnFCaNTd1u1lzJrOilD4ZOO+BYZo/k2NrX462
         OTaQ==
X-Gm-Message-State: APjAAAX17iisbkXCXYhtnsSqXzDgkvALZCutqaW0Iq94yVNk0MlDjbkU
        5G8awFsAnaaLDEzhAVTFk7R73w==
X-Google-Smtp-Source: APXvYqz68RutBNs8ELGrRiZRQRVsDFRU3p8tRW4dh1jrbOiSBjEa5lEhO3eZJ3iaO+K/4017KdQj6g==
X-Received: by 2002:ac2:4c31:: with SMTP id u17mr8586630lfq.57.1575652116371;
        Fri, 06 Dec 2019 09:08:36 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z9sm6905283ljm.40.2019.12.06.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:08:35 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 7/9] mmc: atmel-mci: Convert to pinctrl_select_default_state()
Date:   Fri,  6 Dec 2019 18:08:19 +0100
Message-Id: <20191206170821.29711-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206170821.29711-1-ulf.hansson@linaro.org>
References: <20191206170821.29711-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Let's move away from using pinctrl_pm_select_default_state() as it's
scheduled for removal and use pinctrl_select_default_state() instead.

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 6f065bb5c55a..aeaaa5314924 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2645,7 +2645,7 @@ static int atmci_runtime_resume(struct device *dev)
 {
 	struct atmel_mci *host = dev_get_drvdata(dev);
 
-	pinctrl_pm_select_default_state(dev);
+	pinctrl_select_default_state(dev);
 
 	return clk_prepare_enable(host->mck);
 }
-- 
2.17.1

