Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38F17E47
	for <lists+linux-mmc@lfdr.de>; Wed,  8 May 2019 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfEHQlC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 May 2019 12:41:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36309 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfEHQlC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 May 2019 12:41:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id q185so16765866ywe.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 May 2019 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pK0d0RZmUxDAg2UlpJZk6eqKP4c8MBzekwXBlQJcaEA=;
        b=YS5aDbbBHo/ZpqucQo4JmlEVicPBsSMyK91OtXe2V8t5TpyOfWVVDZcWLMQ/dv72Jf
         v62QeBR8G9/vH2qg+fbIYKlXx5sgCxG23YYKxDnUkXd6o3YISBsF+FfsL2MJqAoy1Qzy
         wBj+YvrFo99bgAxJ4s7iDmnOj9bnYrxt2dH3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pK0d0RZmUxDAg2UlpJZk6eqKP4c8MBzekwXBlQJcaEA=;
        b=LFSL78TlZX4n+U6AZYNZDUHHxet970A3zpdDncEkVQpYL26meXN3qof0pSNlcCWvr/
         4hKq5yHLgE5RpEwf7il+whFQXPQaA+4OaGYA6c5j4JTyCqfw00Eq/5DAVtZTpAjHCFUN
         PI0K0eebDWGjtXs3qdbQPi330fj+sul5WDIOKcCSyy6vlVDGFZBrt+DLq4UIWS38+5Oy
         5CfoVSu1zMr/IfC6bQRkW+YeZfsp5S66RevDxozvEutSpU/YGcBL93lYLmafOXHrfXav
         rHIi6B5pVT/NFx9LxzDD6Hk3tWFfvVJLQfVVXDR7KHL5CQU3sMBElKzFdI1qo78XtG87
         pyVA==
X-Gm-Message-State: APjAAAUU7wLy5ldj6cDkkpayfa7jP1dsAt+uO+Yz22CHyb4LzyZTiEhb
        g+bcdRwk913/jK1/fdAiogsX1w==
X-Google-Smtp-Source: APXvYqz9ir/Gh8NUb1ycpQcDDVHcfdkyx6GifoD6MZrbq72G+zOHknduP6n8ZVhZZ9W94OE4VgRLcg==
X-Received: by 2002:a25:4941:: with SMTP id w62mr27324493yba.360.1557333661480;
        Wed, 08 May 2019 09:41:01 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u6sm4671081ywl.71.2019.05.08.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:41:00 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Wed,  8 May 2019 09:40:44 -0700
Message-Id: <20190508164044.22451-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508164044.22451-1-scott.branden@broadcom.com>
References: <20190508164044.22451-1-scott.branden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode.  This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d4071c41c94..2feb4ef32035 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops = &sdhci_iproc_ops,
 };
-- 
2.17.1

