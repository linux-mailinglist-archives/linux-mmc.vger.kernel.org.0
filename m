Return-Path: <linux-mmc+bounces-1279-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4325C871C89
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Mar 2024 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7457A1C2309E
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Mar 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11758206;
	Tue,  5 Mar 2024 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fQeUxQhG"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE995811A
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636194; cv=none; b=pqrytunwK1AAW339EVx4+zYWI4csHtDWiVSYkfxA12Wm4LjO0cka9CKlMp6KvVq5/nLF8hgLoCTWdC36x9GTPx3pVHexlTBw0tmTzHLMjNMO3Kd7+y2zCFHJVdsHYplydGgS95RJ+oLOpfMUTrSmJV+1C4xU0ttSUo/MkAGche0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636194; c=relaxed/simple;
	bh=QXDl9xM9tqxHgFDPTmCT4hBXojuNai8u3sev/Ridsgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqJaduHi8xiLxkPb+TP3OZcZ66FwxEOuREOtIrS9XO5n/yxLvF+iGIQ88pOnZL6yKn5RUxxBghUXJFnZQM0nAR2qjCvPE7bhzMKNQREKxgPQEHE/CYfX+kiRBi1P6YWy++EJdejLWQ61S4Tz/mcGA2Ym6Skd8Xw2xNqkuKmk0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fQeUxQhG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=9vtX0y6MGSwbev
	WbXEHzzpxjbAsk2wCJm/2gzbK8mwg=; b=fQeUxQhGMveW+vzM5FDxaBVyvV+HmP
	TDV/ytKReSPdpHIu2PYIkkhABleQVpyvymOOIgMGWnL7XlGubvT0O4YjBNelijWl
	guxOeSXzCvoMyuAGNsWOcljK9ULcg6XArW2lI4GI2I20XIPyJiWcEiRb9//XP9nH
	5+RPT2VdtWnIUiXPctJB9ZCaR8xI3CJa6j3317U1Wy4OlCUAMcf+sbpVExBdtFKq
	hA6K6DlWBweJRyB2229hq/jP2PjIwDJWCU8vL9bxfTFv2kH4C6XB0kEYPck8OAy7
	9R/oiYWAUwEIci9/LXMJ48QrNq32r9uj/BEGfwfW/xHuX5hjKAQgThlg==
Received: (qmail 3848119 invoked from network); 5 Mar 2024 11:56:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Mar 2024 11:56:30 +0100
X-UD-Smtp-Session: l3s3148p1@19vMsecS0pIgAwDPXyskAOYD60938Lkb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: tmio: comment the ERR_PTR usage in this driver
Date: Tue,  5 Mar 2024 11:56:24 +0100
Message-ID: <20240305105623.3379-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not super obvious why the driver sometimes uses an ERR_PTR for the
current mrq. Explain why in comments.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index c253d176db69..93e912afd3ae 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -972,6 +972,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		return;
 	}
 
+	/* Disallow new mrqs and work handlers to run */
 	host->mrq = ERR_PTR(-EBUSY);
 
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1006,8 +1007,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			"%s.%d: IOS interrupted: clk %u, mode %u",
 			current->comm, task_pid_nr(current),
 			ios->clock, ios->power_mode);
-	host->mrq = NULL;
 
+	/* Ready for new mrqs */
+	host->mrq = NULL;
 	host->clk_cache = ios->clock;
 
 	mutex_unlock(&host->ios_lock);
-- 
2.43.0


