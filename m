Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A98A6B38
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfICOWi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 10:22:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfICOWh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 10:22:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so10061873ljg.6
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5QBbUbIGIGd6IsxRdoAWwzoHYpPt8QRqVo3tuh083M=;
        b=RP7NBDNto85o8qwpd+eBtArA8GsDbwZzo/N21c5w/x6H5zZ5ZPvBKOgT5AKNZjn4UQ
         VtlHjUycq/Sjk7L+8sIg5gVnv9YNWJl5mP61BIRnivL/jWz1tFolfQUSHRItCk0FfYBB
         tTbntNmCtOIEAtIBHrJLVQcmfKNvs03l4FAeYhME9rQZYWB2FEJ58cmnmtC30es9NDRV
         VCHMolZ3jrdPU57/NxfzMw6I7vpgpIjQyMAfJrwOxX9/5dccWgMqFFjuDxfa0iGilerx
         7mr+AforWPw4ExJA6GKojspQDjLzq8ixKdjDidfmy3xZkXBIoaTRRLSfwlfYKC72AKzE
         OAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5QBbUbIGIGd6IsxRdoAWwzoHYpPt8QRqVo3tuh083M=;
        b=Xg5KLU10QQ96/Rxz+YUlNH/c7JmfEcdbFqWOhbBEM7fGpfBCccRi9xjKFiYWdzYkh5
         WOiebhUh4fpy93r4F/sdinqhwfPEOSm3vldpzWttvKl/NHLydr4jlZoHQ+lrjL/mXSel
         NEHNYM6wiF2QWNh3BQ/SSBx6jjsr+TFXfwx9/GaVZBbpdcbg92fcbX3kyraTLDM5qX2N
         nEf7nCI1egAQzkjt5XkqII7BWFpaT4hy5fjt0U3sz7Yc1NxZ/fnYKoIv1mkuagjXifox
         gAzK9jDKcIn6cLB3P3mAC8eaq1IQhXfTmdzYJk56UjbA2c+pXOgR4D4QNTTo+TvczlES
         Yj5A==
X-Gm-Message-State: APjAAAX6azhJPKGaX/Ve1D9U95qI6TAHWb8CS7jXHpwFkeREISZqZ8tL
        K3nABOX2kimy3IRDfArJB56mO5H1PVk=
X-Google-Smtp-Source: APXvYqyYZS0LZ/x/v3d6oArjV2CxJmO4miYGU2bMEsj46wakq+VgwT1upJ9K3Ttnb344DmtcvFVNBQ==
X-Received: by 2002:a2e:99d7:: with SMTP id l23mr1996664ljj.86.1567520554912;
        Tue, 03 Sep 2019 07:22:34 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO IRQs is enabled
Date:   Tue,  3 Sep 2019 16:21:57 +0200
Message-Id: <20190903142207.5825-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To avoid each host driver supporting SDIO IRQs, from keeping track
internally about if SDIO IRQs has been enabled, let's introduce a common
helper function, sdio_irq_enabled().

The function returns true if SDIO IRQs are enabled, via using the
information about the number of claimed irqs. This is safe, even without
any locks, as long as the helper function is called only from
runtime/system suspend callbacks of the host driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..0c0a565c7ff1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
 void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
 
+/*
+ * May be called from host driver's system/runtime suspend/resume callbacks,
+ * to know if SDIO IRQs has been enabled.
+*/
+static inline bool sdio_irq_enabled(struct mmc_host *host)
+{
+	return host->sdio_irqs > 0;
+}
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
2.17.1

