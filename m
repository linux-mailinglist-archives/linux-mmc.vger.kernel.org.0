Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D89D39DD
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Oct 2019 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfJKHLb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 11 Oct 2019 03:11:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43517 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHLb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2019 03:11:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so6244753lfl.10
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2019 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W/IUaSbhHG4wv7nj6S/SBAPb0kMokkckyKlISAFdDyg=;
        b=mu/UZwsq6JR4fwUjD0AaS4t9e+7DJgs3F8kLt3gqzC4qvzmN8mIH1Kdl1476SAPJj3
         /IXDqHQnhJ5GTyVDoSdodwaWYXsOY7AaRs5acSou4bwkQABWUKLSlIrN1e26qu8RXPVn
         Oo6fJmvoN6ckGnxVuXluMoBR4BGBFt/NqwKwT/X5d58BxjY/vcW3E8klFGCxWWZu8B4f
         OWw+WfX7d8V9H41SZJQ7UfZbONZiHbmgIOLODV4fbZGKIaAkMyvCQiu77UgKKuKwK2OD
         B08xje+R76B3qRXEW8OhGOZbnnDKOAstrWpR6fwcIblE2AlncwFLWB25BUcOG/0O+acY
         frKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W/IUaSbhHG4wv7nj6S/SBAPb0kMokkckyKlISAFdDyg=;
        b=RjOWqz3kziaGRHkbjGYSWbtLyq5PjTsefAqFN7zRYod0IHd5NlVnnzv1Etntw1vw46
         mSdXB5q2bovfLZpik7vA2E3F0WUXSQy7Y43AEAfzqZUzuytCNkTXD8iWBqusKHBm+lsI
         ofmpbTjji7iBV50Desn1i42AJNm0Gt/As0uKGW+iNPsREaFBcoT7TIdjk+uGJOD77p8h
         worV8U7q4tfPc2ceguUSEiP5g6kDi8jFWKtb2lfka5onKi4YRv5h7e4ipD6a/CmvCCK2
         72QYFDGOxIyteX+fFcqzWRmkPwuFNt0PgZl3AB+qvOoOjMgzljQqIQ96b+EtVlu1kGJI
         vfwA==
X-Gm-Message-State: APjAAAVLvF13sraevpKGaL3LieYamoaGVZ3RF6UYqDZCGhmVnej3ovMK
        fg3M6KzrcHtaC02ZtteHkOzw+uAO7ks=
X-Google-Smtp-Source: APXvYqyCu5wpFqB25B07RmvOOPYLsj0+kPemE0riq7UNx55YJT+idjda0EcAYV4e0ctB3wgF/b0INQ==
X-Received: by 2002:a19:a40b:: with SMTP id q11mr7519779lfc.45.1570777888624;
        Fri, 11 Oct 2019 00:11:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id r6sm1834447ljr.77.2019.10.11.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:11:28 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date:   Fri, 11 Oct 2019 09:11:17 +0200
Message-Id: <20191011071117.15294-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
scanning only once for non-removable cards. Therefore, it's also not
possible that we can have bus attached, when we are scanning non-removable
cards. For this reason, let' drop the check for mmc_card_is_removable() as
it's redundant.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..6f8342702c73 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/*
-	 * if there is a _removable_ card registered, check whether it is
-	 * still present
-	 */
-	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
+	/* Verify a registered card to be functional, else remove it. */
+	if (host->bus_ops && !host->bus_dead)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
-- 
2.17.1

