Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A0467945
	for <lists+linux-mmc@lfdr.de>; Fri,  3 Dec 2021 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381417AbhLCOTx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 3 Dec 2021 09:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhLCOTx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 09:19:53 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1DC06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 06:16:28 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z8so6405961ljz.9
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 06:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5oluSR32B6fjR0r/SJahzoL31RZ33cb97P8GDL1GpE=;
        b=m9o2irbDdAEpElTSFPKlFsT6gsAquZsM84h9ZxskSHKYESv+CWrW11vE+F9TlPwlak
         ZjHSVoSB+Q9/RhzT01G2PuYrPyJCma0VDRRFGlpycav5i4yy43smEr/ciaOudiIIzOuh
         G1PfWFSMMzC+LDiSEevBnamlyC91iFN0v8nkEltGEzkQQclxY60Y6yprKlSwmhzl04r3
         7bfKvlfcKSjtkTF0SmaBUtJhfhQ0sGPPJd18MIpIJ5FibSbJBM2r9o+yvpVdWi1Rt8/V
         x1kqy0TSLzEFOmaVlT865844irHeFu4+GUaBfz4icCf6T1U/3pJ7noJVrWjMb0lHkcoo
         EwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5oluSR32B6fjR0r/SJahzoL31RZ33cb97P8GDL1GpE=;
        b=xT9gREdxAdf0nSnR0J8n/cfwo4HLsz9c+WzpKop3VozOfgQeCOmofK2c0Bha/2Ix6F
         UhR8wd3RRLCcHKSdTqdOesxgPssarNEnGCWQEgwe+1+C0YJh1VBGRpUJBvkuXeEo+sJf
         Xn64WJXTSoXxt3DaqAlv0GvIM5N6tj8qc9D9N5DjuRO+biBdGbJw2ELgC7p/VHutuLP1
         u06HKPr44Ny2MT50pHrieVSWf9dDfWLQkoiM9fZstb6BFQQ+S9RCOwGvYzPUl+7pO5a1
         zh8SfnUwG5zRWt4qR3zsX0NrJX3HStmasWXOpG3RgkKBZLFygdUi7snet3+v6KuVMuyj
         Vv2w==
X-Gm-Message-State: AOAM531PkybYQAUJAzMVDtYMkiGXszHWVZYUPzgoUoBEtBO0h4VrhE7T
        pMNgVmx2x8T1reUED6oYPJNkDILTdlHeFw==
X-Google-Smtp-Source: ABdhPJxp/Siie6/LsC2bSZMtJBcoU8ILP/UXNldtrJs+021fMH2py8ECRE3DC4ISsO1U591TGECoeA==
X-Received: by 2002:a2e:b171:: with SMTP id a17mr18040296ljm.56.1638540985896;
        Fri, 03 Dec 2021 06:16:25 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id l5sm416300ljh.66.2021.12.03.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 06:16:24 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] mmc: core: Disable card detect during shutdown
Date:   Fri,  3 Dec 2021 15:15:54 +0100
Message-Id: <20211203141555.105351-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It's seems prone to problems by allowing card detect and its corresponding
mmc_rescan() work to run, during platform shutdown. For example, we may end
up turning off the power while initializing a card, which potentially could
damage it.

To avoid this scenario, let's add ->shutdown_pre() callback for the mmc host
class device and then turn of the card detect from there.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 ++++++-
 drivers/mmc/core/core.h | 1 +
 drivers/mmc/core/host.c | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 240c5af793dc..368f10405e13 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2264,7 +2264,7 @@ void mmc_start_host(struct mmc_host *host)
 	_mmc_detect_change(host, 0, false);
 }
 
-void mmc_stop_host(struct mmc_host *host)
+void __mmc_stop_host(struct mmc_host *host)
 {
 	if (host->slot.cd_irq >= 0) {
 		mmc_gpio_set_cd_wake(host, false);
@@ -2273,6 +2273,11 @@ void mmc_stop_host(struct mmc_host *host)
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
+}
+
+void mmc_stop_host(struct mmc_host *host)
+{
+	__mmc_stop_host(host);
 
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 7931a4f0137d..f5f3f623ea49 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -70,6 +70,7 @@ static inline void mmc_delay(unsigned int ms)
 
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
+void __mmc_stop_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
 void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d4683b1d263f..cf140f4ec864 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -80,9 +80,18 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
 
+static int mmc_host_classdev_shutdown(struct device *dev)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	__mmc_stop_host(host);
+	return 0;
+}
+
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
+	.shutdown_pre	= mmc_host_classdev_shutdown,
 	.pm		= MMC_HOST_CLASS_DEV_PM_OPS,
 };
 
-- 
2.25.1

