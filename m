Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08148B1AF5
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfIMJlQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 05:41:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40802 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbfIMJlQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 05:41:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so26412823ljw.7
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x+Ss15MNzRVyX67MkdlgMEH//XbsQfFeOYqwwe3OaKg=;
        b=p/zm/sxhH+yLyUYDxLlnKOtmXMLDat12pljG16ezcFFV2KVT9H7TvPLYzzcEKGU2iB
         Z+dzvPI+7dE3RFBNzp/y7eGYsldxMGXYmuG7IYacFQKsCM1ylejcxJGHxx2OTzbFfnkT
         BqdQwuGj5/CbTerzQCU6qZvWQBILgMVtCpoDN5XSDon6/bxtY6T7VRbAB7JtI/0NrYI6
         Vn9J6utyHjJKTYBt7OlZ0x9CPXDc2P7gu27ihhbaJMBJ1/ZbbFN1neura7JTS7w8z6YL
         xggY00OLA/9jd0FpdjdpHR0JQJKZMFvVHzv3V7+rfkBuzAfIqSHeHFnQvC5xN7izRC4g
         jBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x+Ss15MNzRVyX67MkdlgMEH//XbsQfFeOYqwwe3OaKg=;
        b=dNld6hAOak2Wm7DKfonVtxqWaTMBZUe8my0j5CB2kKDSqjquDyl95xZDUPyM5Zv1k2
         H9kdBudef515FaFgkXEpUJtLuVtQFao/BV+lTOyqx0rNy3c5BATs+IZZtV/4QTE068sJ
         8ahMEk0k0KxfgPprTDovL0SNJ4kq62g9Gjn7nYEMBzRTt3pKdJAzU7UmotGti4V+k6Jc
         8q+amfW4Ez4VExNC/p0d8R48TL/iSxLo2DMQIkqinWN8LcOQYJZNsGMDbk/WugIz1h82
         HqsBETIjJwaSRlt7yEVaMUm9k5asddaJTuvdHl3CPIjrRK7u6HtFR/6CFu+Y4v1kBy2S
         Hr9Q==
X-Gm-Message-State: APjAAAVd6bUcfhkfpa9P1mY91d57fcuZ1GFZvhg+2YfjSxf9qRqJhsso
        k2zqEd4LS/zwAMTE6SRL+ioLom01xdI=
X-Google-Smtp-Source: APXvYqzJYGbaNDMizQgqIGnU19xD8dzBy4o+0P+OIYwEEFFswZEvh81y8WZHPl493WfWx8/7DXCddw==
X-Received: by 2002:a2e:8e8c:: with SMTP id z12mr28888323ljk.204.1568367672562;
        Fri, 13 Sep 2019 02:41:12 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t29sm116607lfb.85.2019.09.13.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 02:41:11 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/3] mmc: tmio: Fixup runtime PM management during probe
Date:   Fri, 13 Sep 2019 11:41:09 +0200
Message-Id: <20190913094109.21192-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The tmio_mmc_host_probe() calls pm_runtime_set_active() to update the
runtime PM status of the device, as to make it reflect the current status
of the HW. This works fine for most cases, but unfortunate not for all.
Especially, there is a generic problem when the device has a genpd attached
and that genpd have the ->start|stop() callbacks assigned.

More precisely, if the driver calls pm_runtime_set_active() during
->probe(), genpd does not get to invoke the ->start() callback for it,
which means the HW isn't really fully powered on. Furthermore, in the next
phase, when the device becomes runtime suspended, genpd will invoke the
->stop() callback for it, potentially leading to usage count imbalance
problems, depending on what's implemented behind the callbacks of course.

To fix this problem, convert to call pm_runtime_get_sync() from
tmio_mmc_host_probe() rather than pm_runtime_set_active(). Additionally, to
avoid bumping usage counters and unnecessary re-initializing the HW the
first time the tmio driver's ->runtime_resume() callback is called,
introduce a state flag to keeping track of this.

Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c5ba13fae399..2f0b092d6dcc 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -163,6 +163,7 @@ struct tmio_mmc_host {
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
+	bool			runtime_synced;
 	bool			sdio_irq_enabled;
 
 	/* Mandatory callback */
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 8b299c1f0069..32f9679ec42e 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1248,20 +1248,22 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto remove_host;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
 remove_host:
+	pm_runtime_put_noidle(&pdev->dev);
 	tmio_mmc_host_remove(_host);
 	return ret;
 }
@@ -1330,6 +1332,11 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
+	if (!host->runtime_synced) {
+		host->runtime_synced = true;
+		return 0;
+	}
+
 	tmio_mmc_clk_enable(host);
 	tmio_mmc_hw_reset(host->mmc);
 
-- 
2.17.1

