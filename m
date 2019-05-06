Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEF1522E
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEFRBg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 13:01:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38899 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfEFRBg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 13:01:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so6755859pgl.5
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zm81FW3KcENXa+XgLOmWMC1Drv2h8huE0OlhIp7SLHw=;
        b=RdGeecv84dfagcFaBy4oZ8KX4YElvSCjgZ4wewEOn11JljodjvXlkDUiIVZwXtqxJ8
         SGycem6z7VwK/vXBklKJf0c5MRxBr4efE+k1J9U3I6eaHpraVQFRuTJFGElKI9V/elBe
         II6qQdUp0itHcwyvDHxXEp5ZOlY9zDetY/CDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zm81FW3KcENXa+XgLOmWMC1Drv2h8huE0OlhIp7SLHw=;
        b=qN69QOTwM5gNKs9j0bXsyqS25u6zKWKBiOYMlnA9/Lzp/s8uH0J7IYvykiezzEDB3Q
         MYJlcOC728nmsowMIJ0WlNumnnsxI0a/T8O9H7/ik30U65kCLgivqu38B5KfpyBe0+MJ
         U+Whq8Qv6WysBnmXSWVzB4QzvojBF3oQVaFKlPwBMpBkZam1C7i0Zo0zmwmfb/RVIE0T
         M9nzggX9gqPN9gxI+GwN6b86gpayzJs6Y1qJYWSXBPS/vNWGkXAf3S9obG/+gDKAeK/P
         tZTji6OQ4Xth22G8rNLXoBpyH5P1OWeWwo0CjdK0/LKAjq396HRy94n9W9vgY2fEkb0R
         zp/Q==
X-Gm-Message-State: APjAAAXqRN3hCclH1uiOa9u5oyWOWQtsZBXmFdOaJ/XhdQ7DxqtYMcri
        40cORgih2IDoxedCS1LbU8k+NQ==
X-Google-Smtp-Source: APXvYqwvaQXC+Zr1EWpDHk8e2qxSkU9qk1E9SvIbRABldfphC9oNl/iAN5jE6MiK12SrGhU7LRMB3A==
X-Received: by 2002:a63:a18:: with SMTP id 24mr32875692pgk.332.1557162094885;
        Mon, 06 May 2019 10:01:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
Date:   Mon,  6 May 2019 10:01:14 -0700
Message-Id: <20190506170115.10840-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506170115.10840-1-scott.branden@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Trac Hoang <trac.hoang@broadcom.com>

The iproc host eMMC/SD controller hold time does not meet the
specification in the HS50 mode. This problem can be mitigated
by disabling the HISPD bit; thus forcing the controller output
data to be driven on the falling clock edges rather than the
rising clock edges.

This change applies only to the Cygnus platform.

Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte register accesses")
Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 9d12c06c7fd6..9d4071c41c94 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -196,7 +196,8 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
-- 
2.17.1

