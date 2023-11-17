Return-Path: <linux-mmc+bounces-138-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC47EF1E1
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Nov 2023 12:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EE8B209D3
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Nov 2023 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507612FE2D;
	Fri, 17 Nov 2023 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfAyo4rG"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997D2126;
	Fri, 17 Nov 2023 03:32:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1875461b3a.3;
        Fri, 17 Nov 2023 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220779; x=1700825579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MEzikBOSI0IzLimKwIxezna9qhfNLGyuWYtUgFehms=;
        b=HfAyo4rGyUqKvsQlUQuijZuEmC3BqHVaYyCaiQRK34fs9HgEInocMuStgMn5mOfPOI
         FVSGPjoT4rMsDxQQzWOOX1UcHrOvfDpg+TPEBBZPrKOjqHBXsyHc/2SYGi9NmoS3jdoW
         66MQjfwflxaFJJ1nSgraBsOU9ldw+8CiV+D9TOWLunHktHNrHhXpB2SmSXibQo4YoKTA
         O7uBIWNezO3KO/ddYGYWdOgHU3I9+pYp8c5nkhwxh92FmK7wuYPyhozmrSGIAr1NrCow
         XHAS+AzgqIUCI2JhN4ytlKY8zqTC6Er9cHY1VH7MZyzZwxDXMYgXbSfdApenKUgBSRBF
         4iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220779; x=1700825579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MEzikBOSI0IzLimKwIxezna9qhfNLGyuWYtUgFehms=;
        b=ThlWim20AFE7t8SJrDGPDJsuQSwBFph8ZETR8uslrzv7QXzgvI5OCDF2FV1uUOlT5Y
         53s9CqgRSVd6mUHkvKW7Kw0tDwGryRIjXaOYJcOFPmjFjRwmS2JlLb1jsZgytdAloYgQ
         i+6e7pU2n6KsYpRrTWd5OOGend64PRDIUeEOu7gHq2bPAhgzUoShSjBnHejsaIMMwanV
         RRAFs47XA9td8WIMVW51V0pP/ADDuKWjggOE5LOLcaxE6fTFJ4R32eD0HbAdNu2yb1vZ
         V8MsaVW+coh0o9J29ITDFko7TMouf8vIhMt/7TJ1/NTFmJpTINiwEJ9bqWKDltzOBgpx
         wIog==
X-Gm-Message-State: AOJu0Yw5LrP/aHZsDu1ShazCO6hS8V6/hEY5/ZXPWd/qV60M+VtqNzTW
	bouv9XPF198tL1ZUizuBV+emYUjYWcI=
X-Google-Smtp-Source: AGHT+IGl/H1cI0nH5eGsCwqDxMHB3g+pw0qZYXEqOsnUAUxnP175hFqOAP4TvWDGPniv0sMew8Np4w==
X-Received: by 2002:a05:6a20:9144:b0:16b:e46e:1246 with SMTP id x4-20020a056a20914400b0016be46e1246mr22488201pzc.30.1700220778716;
        Fri, 17 Nov 2023 03:32:58 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:58 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V13 19/21] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Fri, 17 Nov 2023 19:31:47 +0800
Message-Id: <20231117113149.9069-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 45ff0bfedf3c..e187176b79d7 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -407,6 +407,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1085942d47a9..fb10a26dc251 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1


