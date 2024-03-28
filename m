Return-Path: <linux-mmc+bounces-1344-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF0874ED0
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Mar 2024 13:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455DC1F23611
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Mar 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188512A155;
	Thu,  7 Mar 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GuWVP1v/"
X-Original-To: linux-mmc@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27ED26AE9;
	Thu,  7 Mar 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814071; cv=none; b=aRQURRVZVGgfERLf9tJz6yQDYLOmikXQQByRH0QwnLITLZ3zp3t5JwKE1/cQ3666FJZP5AI7zS+uOj6eot/XTjfGzeEujLAz9zOHdUElVtxyuFKYP8USqhNBTk4oksgePS71ZakFP4stKzvIploiza1xwJXaEpWzdYbBKuvmBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814071; c=relaxed/simple;
	bh=ZUdP1AgvK/ta7Suaq0TI3JpieomFqdensBYqgLDhtN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMVvyXalcaYLXg2K0iNAuJGoCcJ9LzMIYfS9Chot3JIuRGTB8Lm+5JPOT14GG5vNMsEZ0r7xfeGsiLP2GXIV6BTORKulyqeMSPUUkJFhDAiC4T6Y/qmQymPwO9rQTFPDv2EAxPbYYkT2YBHje10wtEF0xF/9p3GtZZxeMpq5288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GuWVP1v/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709814068;
	bh=ZUdP1AgvK/ta7Suaq0TI3JpieomFqdensBYqgLDhtN0=;
	h=From:To:Cc:Subject:Date:From;
	b=GuWVP1v/OyQ174xMmfVzK2JnK26ievNLFdD3akzGqUj8vVcrRmkIzKyeD1+6QjnWf
	 pwriETzTASvBnpsCNPK6lwFxuz96d5ouONcJdtzcbwFzJPMJx6VFj0UjC375fY0FOk
	 6f4uEnZ/xbeDXiDgmFDOId+LdIITP+Sw35XbboBqdht41P0BmW4vNxfkAijlmQAtpk
	 RIVZJk6u/88ZoZVzJR/SIXRgtlFTbc2puEdkSHYZ4W5Wqr7l7JFPY8lFeDQr4cJAcs
	 +af9BhouhGFML8w0/C4gzxQxH4x1vMYi6ooIVZu4Om8L4ikbfK3J5bF+hEf0XlP4D+
	 V1nFrJiBGMrNA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F43737820DA;
	Thu,  7 Mar 2024 12:21:05 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Yang Xiwen <forbidden405@outlook.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: remove unneeded assignment
Date: Thu,  7 Mar 2024 17:21:29 +0500
Message-Id: <20240307122129.2359553-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The err is being set to 0 and replaced every time after this
assignment. Remove this assignment as it is extraneous.

Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index 989ae8dda7228..96af693e3e37c 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -133,7 +133,6 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
 			goto tuning_out;
 
 		prev_err = err;
-		err = 0;
 	}
 
 tuning_out:
-- 
2.39.2


