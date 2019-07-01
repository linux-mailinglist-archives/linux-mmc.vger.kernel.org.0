Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9DB13927
	for <lists+linux-mmc@lfdr.de>; Sat,  4 May 2019 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEDKZv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 4 May 2019 06:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbfEDKZu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 4 May 2019 06:25:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1ADD9ACC4;
        Sat,  4 May 2019 10:25:49 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 20:24:56 +1000
Subject: [PATCH 1/4] mmc: mtk-sd: don't hard-code interrupt trigger type
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155696549653.8632.3279283591868841381.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When using devicetree for configuration, interrupt trigger type
should be described in the dts file, not hard-coded in the C code.

The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
and so cannot be used with the current code.

So replace IRQF_TRIGGER_LOW with IRQF_TRIGGER_NONE.

Also IRQF_ONESHOT is not needed - it is used for threaded interrupt
handlers, and this driver does not used a threaded interrupt handler.
So remove that setting.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/mtk-sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0798f0ba6d34..469d4a717175 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2240,7 +2240,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_init_hw(host);
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
-		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
+			       IRQF_TRIGGER_NONE, pdev->name, host);
 	if (ret)
 		goto release;
 


