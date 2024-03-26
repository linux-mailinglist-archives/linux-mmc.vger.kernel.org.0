Return-Path: <linux-mmc+bounces-1579-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F488BE38
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Mar 2024 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080861F26890
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Mar 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0D7641B;
	Tue, 26 Mar 2024 09:42:44 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C24F215
	for <linux-mmc@vger.kernel.org>; Tue, 26 Mar 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446164; cv=none; b=lMBeg89322vXwSIsJPFjQUjtjiokowRN41vrsGXj4z3LUFoVIINJeL6fXFTM+2kwviAWGsDOyzYPz38WE9hbZqLTto8DC8qq9bR/+XnQ69huyuqMjFULI9sUM1X91TLPb5xbQCGuKGdZvFbMm29rSCqLfN6QPfsletw9/u1bRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446164; c=relaxed/simple;
	bh=r58QDjO3upb8VbQsw09eAWnh3c+/UPkS1rzx70Z37mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc234cJMK+9ZVjpnmrJDr1YvEPuIw5iKZNa2BxWgZNvuxzHEGpbLhL7D0QHEBJdKnss7JWcnAztcjL6w9LDEF1BAv1wtK+28xwgFHh/lY93b3mt9KKt7p6u5wXq7PYMKVrMRVB5n93bxMpzgUU6SaAqtWcoh8S8T2bZjamu/oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=localhost)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <r.czerwinski@pengutronix.de>)
	id 1rp3KH-000583-PI; Tue, 26 Mar 2024 10:42:37 +0100
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: debugfs: add card entry for quirks
Date: Tue, 26 Mar 2024 10:42:14 +0100
Message-ID: <20240326094215.212930-2-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
References: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

This is useful to check if a quirk has been applied for the connected
mmc card.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/mmc/core/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 6dbab860e453..f10a4dcf1f95 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -389,6 +389,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 	card->debugfs_root = root;
 
 	debugfs_create_x32("state", 0400, root, &card->state);
+	debugfs_create_x32("quirks", 0400, root, &card->quirks);
 }
 
 void mmc_remove_card_debugfs(struct mmc_card *card)
-- 
2.44.0


