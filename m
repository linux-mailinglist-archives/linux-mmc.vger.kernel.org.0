Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A384E066
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Jun 2019 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFUGNG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 Jun 2019 02:13:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43293 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFUGM5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jun 2019 02:12:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so3010898pfg.10
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sTCdN8+J6KLa7sEKH0EdC3HRf3eZR2ST2OSFrpSj98Q=;
        b=hRj5ECnn+gxAxOedpghqwfXjTbai4FfzLUa9qcX00huzqhbDDBkKgalm3JGfPzF4sm
         18yXQSv2ukoeVpjOkv7Db2DZDB28Ddz1Jkn3Q6od/ez8JwBgtOtfOj9X7ShDnaOcEZdA
         KM1UOo97Eo5hwjvpmIQCLUrL2E1wytzb1SD4kV+ffY2IRcgG4TT9FyI62cGLmutOceIj
         ipEH0GNu8YZ1aIGoR2Ku1j9iYaZQ84JO+TrBmMZYGD6Dx85JTEmWEO4lX7M6hvVTfA5N
         dvfPJJ8svG6P159BVUNq3Xzv6MU6BxsEK4BoUVBA9CNKMzhFQvWUVgCUhAsWngA5gedR
         Lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sTCdN8+J6KLa7sEKH0EdC3HRf3eZR2ST2OSFrpSj98Q=;
        b=CbSPtjG1+D8gdFrVW4a6AoOSK2GB+MuuDR3tjIl2KUbh4LCTeKkZzECMBjh/DdsTrf
         sCjZtNvm9QeiYiQuD8I0EUwvjeuujn2Ag2NDZykOePt1jrKW2Dr2v9ZvFF1btO5632W+
         6iJD+WjF8VJCOjyKA4hoVl/lcRw9sn0q2245R8MJ5lzzonU+cYUNy80xY7MLT36x/pGY
         HRNHXpZoVjb35xxACsdJlXsvmvyc8hW9N268NvIBlVMAgSqS/ba6W9lRnO2P0X3EUTd5
         oCoxGDhQsD24q7QBGESrR6BEm08AgkFUN4Li9tIEywrHG1ZBc5OWojIH04/ytVmy4YZd
         Emyg==
X-Gm-Message-State: APjAAAU4DRDK1Zf+yOl10exNqKtFQSwoh+8HoScDNPxNrz9gtYCnlalp
        Ulf0vyMSI5Z9El1dXub/RxN/Yw==
X-Google-Smtp-Source: APXvYqxmGH0nMNJrwTfUuJHvrMIseiYEj2N0NeglRuKFRKi0jUIO0oJYd4+5NHEBufpTMCTrFHeIQQ==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr4358452pjv.48.1561097576891;
        Thu, 20 Jun 2019 23:12:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: mmc: sprd: Add pinctrl support
Date:   Fri, 21 Jun 2019 14:12:32 +0800
Message-Id: <73f6c1291e4c15da6be53a6dd4602622e142fefb.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When changing SD card voltage signal for Spreadtrum SD host controller,
it also need to switch related pin's state. Thus add pinctrl properties'
description in documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index e675397..eb7eb1b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -19,6 +19,9 @@ Required properties:
 Optional properties:
 - assigned-clocks: the same with "sdio" clock
 - assigned-clock-parents: the default parent of "sdio" clock
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin control
+- pinctrl-1: should contain uhs mode pin control
 
 PHY DLL delays are used to delay the data valid window, and align the window
 to sampling clock. PHY DLL delays can be configured by following properties,
@@ -50,6 +53,10 @@ sdio0: sdio@20600000 {
 	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+
 	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
 	bus-width = <8>;
 	non-removable;
-- 
1.7.9.5

