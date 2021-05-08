Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3183376E5D
	for <lists+linux-mmc@lfdr.de>; Sat,  8 May 2021 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhEHCFd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 May 2021 22:05:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18792 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 22:05:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FcVtS4gN8zCqwT;
        Sat,  8 May 2021 10:01:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 10:03:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>,
        Chris Ball <chris@printf.net>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mmc: usdhi6rol0: fix error return code in usdhi6_probe()
Date:   Sat, 8 May 2021 10:03:21 +0800
Message-ID: <20210508020321.1677-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: 75fa9ea6e3c0 ("mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mmc/host/usdhi6rol0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 615f3d008af1..b9b79b1089a0 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1801,6 +1801,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 
 	version = usdhi6_read(host, USDHI6_VERSION);
 	if ((version & 0xfff) != 0xa0d) {
+		ret = -EPERM;
 		dev_err(dev, "Version not recognized %x\n", version);
 		goto e_clk_off;
 	}
-- 
2.25.1


