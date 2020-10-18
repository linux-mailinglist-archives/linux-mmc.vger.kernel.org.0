Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2471B291CAA
	for <lists+linux-mmc@lfdr.de>; Sun, 18 Oct 2020 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgJRTj3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 18 Oct 2020 15:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730868AbgJRTYk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 18 Oct 2020 15:24:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34872222E7;
        Sun, 18 Oct 2020 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049079;
        bh=JQh2fpdPo7hQptUNAeVejo7y6ygRohzYnpAbQwiUe4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXAxbecg9W8bB32oHqLWxXKRT2t6wxn6oFhzZky8EAJQw2dctRu9Nc0Qw7MwfA2YL
         oTWFhYpsMEW1pGJLRpzen5YmtRyWeqRZ0jrNNqOsn8B0bMrpCSRC4jQ0pzzNd007Sm
         v9xGtsMgRWSmTQw91npEkr3qmkdPF5AdqIcwvyeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/56] mmc: sdio: Check for CISTPL_VERS_1 buffer size
Date:   Sun, 18 Oct 2020 15:23:38 -0400
Message-Id: <20201018192417.4055228-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192417.4055228-1-sashal@kernel.org>
References: <20201018192417.4055228-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 8ebe2607965d3e2dc02029e8c7dd35fbe508ffd0 ]

Before parsing CISTPL_VERS_1 structure check that its size is at least two
bytes to prevent buffer overflow.

Signed-off-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20200727133837.19086-2-pali@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sdio_cis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index f8c372839d244..2ca5cd79018b4 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -30,6 +30,9 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
+	if (size < 2)
+		return 0;
+
 	/* Find all null-terminated (including zero length) strings in
 	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
-- 
2.25.1

