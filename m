Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D149AFD80
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfIKNPJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 09:15:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34930 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKNPJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 09:15:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so11527637pgv.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Sep 2019 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IYDEgSPFjLDdl06FdD0mska3UeVnMuFPlikdbTqLEfM=;
        b=J1a9/MrhnWPIbUboK3cTgk4A0tTd9DLQObD6dYFIakNwJKr2+u3gkFlDUCe0XKce9D
         pZv9fXqKXZMYYVNfzRbj7Os02QlKqaIuYgH7Tj0c6hEoVSPW3hbHqpkpnSgQ6WEXyb1O
         yvrng83hWy1kfk1yYA/DLexdjHP0zAsUxlkD3ED+tcxcgJA/uOY9PCnlxfMyjUivBG1h
         2Q/P6lAfT5Vk+1NfOLW9bRGEBcu0S9PPSLFxQYovvAhR9ZfHE5lonybtEjgkQSxcKpsg
         w1vp3uFe5lfuJjA80CMor5ePiv2Y2WTo1/FaqhhT1KtpvQsr+5CMJBGwB7arYsVYqmDT
         KVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IYDEgSPFjLDdl06FdD0mska3UeVnMuFPlikdbTqLEfM=;
        b=fBH6BNL/QkZAxCuCZB1C74EbnFczSLJTxRyEtmDg1U1VpEw9gEFBU7VqXkwL1aiLNJ
         4Zayvtr4+6Yv18vrRUjUKJWq12+apU52+/MlTUEO7GdoNi+pbRC4RgUs84YSXPuzU4Sa
         ftf6a4jcOPee1Vw+BoOxuRdVmxQKrRNafqVUf052FawLDsDJW+1fs0dwvyyq3EOd4vr8
         i1bJBdD8azWmfl0JyWrlTcD1DitPARBZW7fdVcTk6CcPrtU/Y2phgAKzY1E59kzkEcS3
         ErBfRggsKq5hr4Qg4YjM7xU9cvdtGHvs7gcP/kyG8Cp49bRvz8Y7wKkrcCk8ChngznZU
         g2yg==
X-Gm-Message-State: APjAAAWPmCaY8L7jTqHTpgQTI8agcLcPYPU33/0oqkO8b2WRQ7dx48YW
        8YiN8tEuyCL3/9DNHUX/CQv0ww==
X-Google-Smtp-Source: APXvYqw2qxF4aItLm2cOKVKCuUlHw2cFWiRODNKosJ8OSFSExNiQMVi49VYbhUeQmYlaXx6Xm7Mlxw==
X-Received: by 2002:a17:90a:bb86:: with SMTP id v6mr5257821pjr.84.1568207708381;
        Wed, 11 Sep 2019 06:15:08 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm6420120pgr.43.2019.09.11.06.15.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 06:15:07 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] mmc: host: cqhci: Move the struct cqhci_slot into header file
Date:   Wed, 11 Sep 2019 21:14:40 +0800
Message-Id: <e02fdcf8b06756678d4ed09a22073dfcd2c39205.1568206300.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The struct cqhci_slot will be used by MMC software queue introducing by
following patches, thus move it to the header file.

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

