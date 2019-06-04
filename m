Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5934186
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFDIPX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:15:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFDIPV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:15:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so12189996pfm.13
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=Rk1RfYD3O1B47PXjsboBmdlUBgc8lREPnmsvxmlZ4K8tbkh9XtlFbnik9hg4P56Aue
         vqCyok4QonGQdHkxZSSuuFS6jhSm/NPbnnsrHIUNGu0BDi0lEwrpQqGPtV9+JT6czANw
         n6jjOqhPttUEOa8TtLKAQ9Eak8U0r9YB6rMRVZz+D4bWe6j738SSpVm3TR3OKtR/ICwX
         FtnPJSEFPw9flefbuW7WCJ+xLAqJTcCte3FVf3L/rqnX2mYXrYhElN0tb0xYCnYU//c2
         z1JGQfgT7b6nq/Z1fc3StiLbNMErzmcJ2zLaSjcx8Rswz5rPxDpQl1VFS2Oqjd5LnE6A
         4nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=QMEcizJj+JCMhB/T0+9yWJA7d3RKJKrWlAac0URcL4UFWMDX8eOuUOpOqxZuPGAvBt
         MWla1WzEgFaGnJHGo3bxcsIq7hwGty0Sulg/44XytK6xlqfnLw+D4sAYyzkbDIXA+qkG
         Mep9XKX7iLvNH1nU6Tvcfo0zyyIjTTwUwTRr31e4YWAbo6i2PzRT+e79j1WEbuhTkdzs
         tENHfux/5jaxg1+1VVwl10o8yepr9LvIIj937afmP/HnmkITfmUwJNA+w+OvvVz7t4jG
         /P3WLUQ0s3k8BgV7heRJk7lFT/NnnBRq4a9QuUcnMybLay4kViE/xfl5NQKaqPzHjZw6
         8gpQ==
X-Gm-Message-State: APjAAAUSYll85uIGEkW5Ps1PnVII5IDhZRvfAQi8sqBap4LQ6Ney//bZ
        TDdx2msIQK7OXr+bK7xqIoo8Bw==
X-Google-Smtp-Source: APXvYqw8S604f3AEfkc8EEZ0C+3dntoJhFVMgGRVMpVEZsSDNYKOAKmWI7L5sK+Tqxo8qYOOAAGJzg==
X-Received: by 2002:a63:70f:: with SMTP id 15mr17140238pgh.432.1559636120682;
        Tue, 04 Jun 2019 01:15:20 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 7/9] dt-bindings: mmc: sprd: Add PHY DLL delay documentation
Date:   Tue,  4 Jun 2019 16:14:27 +0800
Message-Id: <6caaa6afd1b69fc491c36c665a954becb50d616b.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Introduce some PHY DLL delays properties to help to sample the PHY clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index a285c77..e675397 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -20,6 +20,23 @@ Optional properties:
 - assigned-clocks: the same with "sdio" clock
 - assigned-clock-parents: the default parent of "sdio" clock
 
+PHY DLL delays are used to delay the data valid window, and align the window
+to sampling clock. PHY DLL delays can be configured by following properties,
+and each property contains 4 cells which are used to configure the clock data
+write line delay value, clock read command line delay value, clock read data
+positive edge delay value and clock read data negative edge delay value.
+Each cell's delay value unit is cycle of the PHY clock.
+
+- sprd,phy-delay-legacy: Delay value for legacy timing.
+- sprd,phy-delay-sd-highspeed: Delay value for SD high-speed timing.
+- sprd,phy-delay-sd-uhs-sdr50: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-sd-uhs-sdr104: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-mmc-highspeed: Delay value for MMC high-speed timing.
+- sprd,phy-delay-mmc-ddr52: Delay value for MMC DDR52 timing.
+- sprd,phy-delay-mmc-hs200: Delay value for MMC HS200 timing.
+- sprd,phy-delay-mmc-hs400: Delay value for MMC HS400 timing.
+- sprd,phy-delay-mmc-hs400es: Delay value for MMC HS400 enhanced strobe timing.
+
 Examples:
 
 sdio0: sdio@20600000 {
@@ -33,6 +50,7 @@ sdio0: sdio@20600000 {
 	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
+	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
1.7.9.5

