Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB6AB165
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 05:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392189AbfIFDwq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 23:52:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40806 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfIFDwp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 23:52:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so2431011pll.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 20:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LB2crZ9I7ACv+30hmydmVm4238zRkVsO0qfLPmJY+cQ=;
        b=Q6r3Zj1gkoYJYVCwVD7Ne22kO6WvhtvqoYb0qSFwbj0Z4t/1ksnlrK+2TSj7GogfgN
         9MjOcX/yrli6OOolR+lfiTyGybj89BJes1otScVH84LTGyLhLtSPkSzKegomEwgVq1Mu
         Lu58hmoAF12uR2+sj80m2DleX7sSG7KkIeAmUyMU7NI59uPfy/FJwm6ntJgEdCRwAiuq
         mOBrZOhtDgxMlNseys4zhQCCYiauX6ScycKmA7jd4W2f6YdgN8xRn5PYeCKd2CKDRGoZ
         vB+X+X81JpoPMOXkHzc47we11Fn3qkFpbQm9ATZUxBit7NAHjzKEoRV4AZYPeeGmQDu7
         FOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LB2crZ9I7ACv+30hmydmVm4238zRkVsO0qfLPmJY+cQ=;
        b=FCyhW6Znn81HRHvZoIwwtd6TlRiqRk6mm+2ZqdYNnmwa6AmOfZtP7wExC/sJjjDPj+
         E55WH70j/zX6xyVunBUAvTpLv/Y0++BR3soZ+skIPzHgHPwvqORArPvn6QtFo/Y3bMRp
         lbOAQhEc4rCASGDOa5E9k9AYRBMmkCRcrmaOG3tFTZqbTxGE1iYTUG4gSKOkvchAtb7o
         Q5luVpZvmseU4JEceNlDDuJ/gwHlyzc1TCrBXf6W1+w5pIEjdVMsjy6uB5AhKhjJW+wA
         PCHaGke646wEhd0YG8kg3HUXeiZmTT9BiQBXCgrG+XG7nmQp2X3tICsNWqdOEKpZRyAX
         mguQ==
X-Gm-Message-State: APjAAAVmcVxl6davP1dMBa/GHGb4sYbxdmrxCKauh4Fz9jrqo5uduApe
        co75ejBcHZ5uzEF9a8l7Wz8h3Q==
X-Google-Smtp-Source: APXvYqyZhuFml13vejSs7GuSuQn6KPEc7ybKp7Vn8IM52ZMYg3WP3pXHu5ByeFjDg3xE6g+iIoRUOQ==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr7136794pls.26.1567741965356;
        Thu, 05 Sep 2019 20:52:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: host: cqhci: Move the struct cqhci_slot into header file
Date:   Fri,  6 Sep 2019 11:51:59 +0800
Message-Id: <e57e2c75a48a8e2d3f9df54cd43c08c7e5f1cc64.1567740135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The struct cqhci_slot will be used by virtual command queue introducing
by following patches, thus move it to the header file.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/cqhci.c |   10 ----------
 drivers/mmc/host/cqhci.h |   11 ++++++++++-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index f7bdae5..57ff1cc 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -21,16 +21,6 @@
 #define DCMD_SLOT 31
 #define NUM_SLOTS 32
 
-struct cqhci_slot {
-	struct mmc_request *mrq;
-	unsigned int flags;
-#define CQHCI_EXTERNAL_TIMEOUT	BIT(0)
-#define CQHCI_COMPLETED		BIT(1)
-#define CQHCI_HOST_CRC		BIT(2)
-#define CQHCI_HOST_TIMEOUT	BIT(3)
-#define CQHCI_HOST_OTHER	BIT(4)
-};
-
 static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
 {
 	return cq_host->desc_base + (tag * cq_host->slot_sz);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index def76e9..7b07bf24f 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -141,7 +141,16 @@
 struct cqhci_host_ops;
 struct mmc_host;
 struct mmc_request;
-struct cqhci_slot;
+
+struct cqhci_slot {
+	struct mmc_request *mrq;
+	unsigned int flags;
+#define CQHCI_EXTERNAL_TIMEOUT	BIT(0)
+#define CQHCI_COMPLETED		BIT(1)
+#define CQHCI_HOST_CRC		BIT(2)
+#define CQHCI_HOST_TIMEOUT	BIT(3)
+#define CQHCI_HOST_OTHER	BIT(4)
+};
 
 struct cqhci_host {
 	const struct cqhci_host_ops *ops;
-- 
1.7.9.5

