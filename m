Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABAB3E08
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Sep 2019 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbfIPPq5 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Sep 2019 11:46:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfIPPq4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2019 11:46:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id m29so237717pgc.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2019 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=BfWwhPEGMjqhNnMmtn0lC4DzNN1IjQpfnqP/T++6lj+rV9L/5Bg0t/1kgQ5MOGeFAx
         xvUy28z95tNCGC9WQKuJJ5uoldqdK9xtCEx8RAzKXN6zirGepppIDIEHtIXHtmmmxffj
         ZIsLh5V4yQwFT9p5F3gIArlVndMNXi9LzjZucd23CMQ1n40vSGuqSb2eyvhzxq2bJMU+
         SdghuOWAi+Hcr2wqG0wBhIOSLvQ7Bd3zqaMcChDhPfJaJpTE5aSUcE/UjeMG5OhRs13D
         re7vcxUA/3C1ix8b6r8uh4RU3u3NCuHy6+jhrk3EW0f/3MDp1OpREjGICKmrz0IAEjHt
         4c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=gSYEqdy9by6h4dO95Ebav/E749X2VGJkM8YK5yd6ZJylPA9UmcsUMRM9DJPJ2DYBoX
         BiDiUlDNDDTocwjRKTzWDU4MCpXJk7LXPG/69W3LPtLx280FPN+FUspGevL1KIJrImgo
         W5E+fNXMiqSs3we7UVRwp2yUFksLGYpgihG2bv/w+PrrkfnPIeb/870otqECJa2WQ0pO
         vJmlAoOaun3mqa2MH6Nc5HUh1ux5J0acS0KojxuL+Huo6z/4kPo7tlDtB2kUzDo3pyQQ
         cvKy6zjKWQcI68hOOI9Fx89vnmmVDRp+zjh0SaNs04vWjQbW30LjKcBIMRzHLNfZO9jB
         RDRg==
X-Gm-Message-State: APjAAAVVqqbNC14WCezHuOfzsTZAi/Iu3pytzOW9Tn3S0KWC0rbkhrJC
        P82KXuqNsh8dlrQoCDxYzJ8L
X-Google-Smtp-Source: APXvYqyYx2ww8kVi2qoPwBEokJosm1TyyK6KqDfDlsvQfRrorAIUQCpG72R/TxSYvntUByBP1MkqIg==
X-Received: by 2002:a62:1e82:: with SMTP id e124mr16568271pfe.136.1568648815572;
        Mon, 16 Sep 2019 08:46:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Mon, 16 Sep 2019 21:15:46 +0530
Message-Id: <20190916154546.24982-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since the Actions Semi platform can now boot a distro, enable it in
ARM64 defconfig.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..8e27777d6687 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_AGILEX=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
-- 
2.17.1

