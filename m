Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFF18021
	for <lists+linux-mmc@lfdr.de>; Wed,  8 May 2019 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfEHS6r (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 May 2019 14:58:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39882 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEHS6r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 May 2019 14:58:47 -0400
Received: by mail-io1-f66.google.com with SMTP id m7so15707233ioa.6
        for <linux-mmc@vger.kernel.org>; Wed, 08 May 2019 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF14R4zf4pQm0I/kkaQ+/wocL24kxY2m0EQexJPCs6o=;
        b=gGhG1bu38PrUTGMHoUSTMIBEYGgGKHf9Sxwse9RZG6QmbyldWNlvWWEC59XkWHil9C
         ChPuZAfx/DzTK8dTR3gWZXkrDMLxpMtkfdrcR9xhTs+K12U3lCQz/ITwcLBRGp6Ae4WP
         x2fwzVgpa2IhCGd+wcmKPzpqcRvWWPZvRH3o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF14R4zf4pQm0I/kkaQ+/wocL24kxY2m0EQexJPCs6o=;
        b=JnHAfn4pA5Wp/uvt3i3FHy+fHyh6NW7ZnfvH3ggVBOKiSb8oMv5STsPldJrqO3+N20
         B7FkL2qKOV8CPTf4AKhZMb7w+BMIxrkmtoKZNDLl1Z74cPBDMJBTDpJCL1cx+Z5V3AYp
         9g6cWrMFa4FWhMwNVqA3CJ00CrV7KpgU3lG1FX4XrOFF0OV4WNwoJO1uc6STZhAJyNLG
         VG/YyEzFtwIx+bKI8SdsDODsdaekLUkiEZJetZ8M7WgGQ5vn+VIgdNl1z6kNNBFaDQS6
         N15ZM0tzw3asU66/WMgB0D4lZIwGQ78MmgYigezy1GyiZaLwmGFf85aa7s+qR7hF6aV0
         6h5g==
X-Gm-Message-State: APjAAAUDAWaJIgFh8BXklg7FlEcWkr7tzJ3mDIxHaSRDpIfnELmOrJbm
        fjTm+FYuL0WGK1Nxsr7wx+z+/d2lboKxyQ==
X-Google-Smtp-Source: APXvYqxO2btrTlLVnH069K8Kpa8EUeNIqs+oruyy3jyxQPN+2HckJ3hY2rXoBN0jI2qnhS1dybg0KA==
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr19614559iot.192.1557341926472;
        Wed, 08 May 2019 11:58:46 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id s4sm5192190ioc.76.2019.05.08.11.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:58:45 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in mmc_init_request
Date:   Wed,  8 May 2019 12:58:32 -0600
Message-Id: <20190508185833.187068-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It is possible for queuedata to be cleared in mmc_cleanup_queue before
the request has been started. This will result in dereferencing a null
pointer.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
potential resource leak when shutting down the request queue. Once this
patch is applied, there is a potential for a null pointer dereference.
That's what this patch fixes. The next patch is just an optimization to
stop processing earlier.

See https://patchwork.kernel.org/patch/10925469/ for the initial
motivation.

This commit applies to v4.14.116.

This doesn't apply to 5.1 since mmc has been migrated to blk-mq.

Thanks,
Raul

 drivers/mmc/core/queue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 0a4e77a5ba33..4bf1a9c6440b 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -159,8 +159,14 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 	struct mmc_queue *mq = q->queuedata;
-	struct mmc_card *card = mq->card;
-	struct mmc_host *host = card->host;
+	struct mmc_card *card;
+	struct mmc_host *host;
+
+	if (!mq)
+		return -ENODEV;
+
+	card = mq->card;
+	host = card->host;
 
 	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
 	if (!mq_rq->sg)
-- 
2.21.0.1020.gf2820cf01a-goog

