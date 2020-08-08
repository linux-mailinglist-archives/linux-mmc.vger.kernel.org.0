Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712C423F76B
	for <lists+linux-mmc@lfdr.de>; Sat,  8 Aug 2020 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHHLp5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 8 Aug 2020 07:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgHHLp4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 8 Aug 2020 07:45:56 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478422075D;
        Sat,  8 Aug 2020 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596887156;
        bh=6kFHne20m1V7qMn7k4pkplDI+VLBD8yYV1sJ/P6jx5I=;
        h=From:To:Cc:Subject:Date:From;
        b=N5jPpNJuvnUciRWqhpFaW4RJ2dovP6P2cIIdx+dLTZOp7MZ23rP2Ysd3vkxbSrHxY
         sMcIz/Ifqb/2uxafs12EpZYM8Tei3qvwpp+ER9nKe7uIhpOUEj2TYpVNqBCA4g/nXq
         blTXq/LV0osyKmw/FRcJGj/Dyv4rg2+kKwCd8RoI=
From:   guoren@kernel.org
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] mmc: Kconfig: Add RISCV and CSKY for MMC_DW
Date:   Sat,  8 Aug 2020 11:45:02 +0000
Message-Id: <1596887102-9743-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Synopsys DesignWare MMC controller could be used in RISC-V and
C-SKY architectures.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 3b706af..119adab 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -777,7 +777,7 @@ config MMC_CAVIUM_THUNDERX
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
2.7.4

