Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628E322ED9B
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Jul 2020 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgG0Nix (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 Jul 2020 09:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgG0Niw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FDE2083B;
        Mon, 27 Jul 2020 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595857132;
        bh=Ssg0hCBrvkZt0mvlkHHrwrXugMvgz9amGvox14jD/BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fN3XHpEfRVx6LuFdGe/ak/aG3TWBPUg0XKdiLt8ylMgyZeGVGDthxUiDhTP/m0rd
         /bbDZls/paaH32rcoVHd8L8y+R9KRuL5jcQxTOAABScIeTEwk/SD6uAIDJTXznkrFE
         fsX9pWpPoR27zrmkjFdOXYGJf+k4Mez7pQFHX7Ws=
Received: by pali.im (Postfix)
        id 8AD5EC89; Mon, 27 Jul 2020 15:38:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: sdio: Check for CISTPL_VERS_1 buffer size
Date:   Mon, 27 Jul 2020 15:38:34 +0200
Message-Id: <20200727133837.19086-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
References: <20200727133837.19086-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Before parsing CISTPL_VERS_1 structure check that its size is at least two
bytes to prevent buffer overflow.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/core/sdio_cis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index e0655278c5c3..3efaa9534a77 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -24,10 +24,13 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 			 const unsigned char *buf, unsigned size)
 {
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
+	if (size < 2)
+		return 0;
+
 	/* Find all null-terminated (including zero length) strings in
 	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
 	size -= 2;
 
-- 
2.20.1

