Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3575E1BC5D
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEMR4L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 13:56:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbfEMR4K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 13:56:10 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so478538ith.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPaL2VEX/hSzV1Wc4p9/qEgeMAItoGsdR21BQw+ZGgc=;
        b=ARYpG6dN7VA7JmzpN7iB8t24Q93Bs6/DdHTBoAsd+5raGiTu7FqD+BYziUnlJ4Rp+Y
         wCr/Yh+DJEHs+d9DKa3pvhCyovheuxA3h8Rki86q2vUhH9XapHiWstb7lKO5mGzAs4zQ
         Y4RKB4BdHnyuR7Hhlae2ru23Jqhqd2tvCguB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPaL2VEX/hSzV1Wc4p9/qEgeMAItoGsdR21BQw+ZGgc=;
        b=iRLPCjwwrPTSFaP9t6kpAL3ztJuZCbQSqjOu2XONBAD9yZPjWcUY83OTHeLdZbagep
         Lz1VRnj3A6VBmNXUoxv1sZkPtQGUlNorS2QKCFTwx1wLJE2wDojz4rVT1V3UmknsMJ1x
         hzDPH+Vjf0yXbEyczeodVyePaYxBfsCz7ymBmVcMdj4P8C5raJ9hn48tSKpnuqognqRJ
         Qq43lyaHBjls1QELWQbXV7Q87xg/f3w1Ck7ZF+1A01P2KVGaNBU4qnAW1+ZO6zIG/x3H
         qU2QNgHURwQCQ4NfSpewiZRVSy+V69iXnA+431zVaMZLpylALEUxpqUV9CqrMzs7ajHt
         YUnw==
X-Gm-Message-State: APjAAAU2riBChEh638jYTKwkT/TjC9CpcqhejZtr29PjRZxBIA6k4hpj
        ZiLWZvg4UJMp7V++eIl3+U8jCw==
X-Google-Smtp-Source: APXvYqwH4/GTy25BEvta0lp/d2+77OUftVtWL1TgrCCI35CS1y+6wKWgOoyZX4rEHnEhXACB7JjPRA==
X-Received: by 2002:a05:660c:2ce:: with SMTP id j14mr336633itd.70.1557770169403;
        Mon, 13 May 2019 10:56:09 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id i203sm113538iti.7.2019.05.13.10.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:56:09 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [stable/4.14.y PATCH 3/3] mmc: Kill the request if the queuedata has been removed
Date:   Mon, 13 May 2019 11:55:21 -0600
Message-Id: <20190513175521.84955-4-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190513175521.84955-1-rrangel@chromium.org>
References: <20190513175521.84955-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

No reason to even try processing the request if the queue is shutting
down.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index bd7d521d5ad9d..e7ac7163fafa4 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -30,7 +30,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue *mq = q->queuedata;
 
-	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
+	if (!mq || mmc_card_removed(mq->card) || mmc_access_rpmb(mq))
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
-- 
2.21.0.1020.gf2820cf01a-goog

