Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA318022
	for <lists+linux-mmc@lfdr.de>; Wed,  8 May 2019 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbfEHS6w (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 May 2019 14:58:52 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55094 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfEHS6w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 May 2019 14:58:52 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so5853905ite.4
        for <linux-mmc@vger.kernel.org>; Wed, 08 May 2019 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCnKzFh31Wwdd/AAB7X7ETO7DdW6MandrOh0VZJ40fU=;
        b=UMMYOu+TnCjvr7HpeDDUI8FWf3PYnKoHJGjPK3jODFB+8b2ASl1DuqRjenDN7dx3RY
         QF0ppPzNy6FZATtnRi/tuPAbB8M/lT1RncpOIvxkm/uu+rw0ghML3PAEMgxArDsviqJZ
         oNCCi3HCfSSdDHdis+Uq0DNGqP1RA35laMarc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCnKzFh31Wwdd/AAB7X7ETO7DdW6MandrOh0VZJ40fU=;
        b=JENFDIx9647h/QKcKwJ8DGcHpKINacyF62ySYO6ag9WXlFuOQvAQAhQwQQa3jTosDY
         Bhd4gMnecjvBsqxso/mY0QbIujqCV+/vH3ou6pW5aApu5FoHh+iIWJBxAikh711O20da
         IpqvyzJAMWQA2IYs1Fm3qALx0JTOHWR3yV2Y7IXsqArih6W52RUnZh4Fh4rQs9FwyFjF
         lrtsxun8R2InhvPh3X8HDCyzwNZYhwd0K5Wz+4gW1AJHtW4vVVXlrNWWYwE9MY8XfGXg
         TplyRsty5ATIHtl4fzrE4a+XA9Nxwl8S/JeIgdoBlWyK6ipyvVf3OMpzEiSjRyV1gsBw
         epKw==
X-Gm-Message-State: APjAAAU5wgNAh7XGb6CIObokKm4qXpb1uTo1MWk1Xc3TxS9RX3VHE9Qg
        GiXcHbLvyDY2BWnyYyVu+UQMxanMtTdt1g==
X-Google-Smtp-Source: APXvYqzVPxdkQ3y/Gw15wAAWsmqtydkegL/enWf5bZh6pk/nfAm65reK5m7rkDY8Cj3NDr2unbR/mQ==
X-Received: by 2002:a24:d88b:: with SMTP id b133mr4596740itg.40.1557341931453;
        Wed, 08 May 2019 11:58:51 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id y190sm1427494itc.4.2019.05.08.11.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:58:51 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: v4.14: Kill the request if the queuedata has been removed
Date:   Wed,  8 May 2019 12:58:33 -0600
Message-Id: <20190508185833.187068-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508185833.187068-1-rrangel@chromium.org>
References: <20190508185833.187068-1-rrangel@chromium.org>
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
This commit applies to v4.14.116.

This doesn't apply to 5.1 since mmc has been migrated to blk-mq.

 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4bf1a9c6440b..28c9646a4de9 100644
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

