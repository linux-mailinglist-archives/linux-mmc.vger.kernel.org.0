Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF917D9C59
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Oct 2023 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbjJ0O4u (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Oct 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346165AbjJ0O4t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 10:56:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8710E
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 07:56:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40842752c6eso16978635e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698418605; x=1699023405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFZ9tlDYmNkTDzHSnUcNQZmapFp1qjPQ8MasZ+dtR5g=;
        b=LeaA+sDKeqqQ9L8Sd5PjWduQ02MdK2+g1q/wghqcXHeqYhbYPaCir938S7waRvq+Zd
         Sf2Cb/MAydYI/6UvpEB0Qk6M7XLm/YZqP9v6ZGEJJaVtBcp3An+tVVdxEoWvMNqVTXr7
         Zaavqu6NGkL8bCQLfz5cPjyDdIkqXz5UqHNMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418605; x=1699023405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFZ9tlDYmNkTDzHSnUcNQZmapFp1qjPQ8MasZ+dtR5g=;
        b=TFXoOEk7vbOihc397p9b9sBudfypSi4yIhipJZoooTNzOIClmCu2igGdqmnxnz7346
         gqfX21I0938R2/uNSj8v21PqWnot6v2pUcyNKIGWnrO7lVYeJETSbU9xTxUlVeac8kyo
         MFyG0RAjVzE2Fw7cchokvvFCtIx5DtQvW0nAc+6GBEQPFjLhW/rQN8hTPrIvGoZiyRcL
         vHlCxJIfCEWQuTuAJmT3FwWh2zbzD3jdwdHaT1oQigJYztZti/FwFF9ITegszQEb0Hpv
         GPD5c+WU8sdJNi4CogDn52T95dom/QZ4BPkA7Vy6FCzgVpZ8VPyWOT2aAoAx2QxRN74q
         whtg==
X-Gm-Message-State: AOJu0YxjRIui4McC0TqLI7isL4N8ZNNfJYqPnFE+wWi4YK3ygi6eKcth
        qCigGcm1CfpPScNvpxaEa3BcAw==
X-Google-Smtp-Source: AGHT+IHB/J/KBIgQueuiVnQKEC1azrG2rpiLl2NQwAgv0PVWoRrHP7uFRhNFwVMPCD9YOslkIbx7yQ==
X-Received: by 2002:a05:600c:354c:b0:406:84b2:67f with SMTP id i12-20020a05600c354c00b0040684b2067fmr2564908wmq.20.1698418604913;
        Fri, 27 Oct 2023 07:56:44 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1815368wmq.14.2023.10.27.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:56:43 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH 2/2] mmc: sdhci-pci: Enable the clear stale TC quirk on JSL
Date:   Fri, 27 Oct 2023 14:56:10 +0000
Message-ID: <20231027145623.2258723-3-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231027145623.2258723-1-korneld@chromium.org>
References: <20231027145623.2258723-1-korneld@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch applies the CQHCI_QUIRK_CLEAR_STALE_TC to MMC controller on
Jasper Lake platform.
When run in CQ mode, the controller on Jasper Lake sets a stale task
completion event after CQE recovery is done.

Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7c14feb5db77..a7e637f5cb4f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -960,6 +960,12 @@ static int glk_emmc_add_host(struct sdhci_pci_slot *slot)
 
 	cq_host->mmio = host->ioaddr + 0x200;
 	cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
+	/*
+	 * The controller on Jasper Lake signals a stale task completion
+	 * event after CQE recovery.
+	 */
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC)
+		cq_host->quirks |= CQHCI_QUIRK_CLEAR_STALE_TC;
 	cq_host->ops = &glk_cqhci_ops;
 
 	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
-- 
2.42.0.820.g83a721a137-goog

