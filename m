Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7B96FAF
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfHUClW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:41:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38943 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfHUClW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:41:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so386998pfn.6
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=rLyhcFrheG3o5Qx36QQ7u9F9uz6BwEvvGRbEFwHczuyYBmBtSTcgoqnF/CpXUVKaUF
         oFPWCqQ4uFTZ86OpbY1QLizgo72Qacqp4vAUUu7JOSh9ify6x0ZJRRcGFapCIP/AO0AY
         Vsihv62MIoIyy5uSqLpZHyHqaFFEda8zb2G3FIV2Xw2fzJVGD4eHfhtIzlc8H5QFlt3Z
         yJPO05K75raZr5sErAAPhuaYP0ioHGau7+VtaimX4l5tiBEnWy+Csd8f3CTSrP4/MhkT
         idghhLoGl7DRYN6wJeVfO/IDfPyE5E0FeAGuQWaQCvsY75FGgAwSsXCcq3xbt5ivgjXM
         B4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=BRdQ7c/flirWYAOXX+nFPyyaK0coCr6/rtlGh+52X+ERs1AixiJjY4Ky2zZbqH1NTC
         cf4ZVGhsujSJ+9cOppULnxxfVurj3aJZ2ZQ9ypo3GJrFdjR2yyJWGWWu/5mQI/xUhkLa
         4TUkMCQ0FOa0x1l/CLp/WEJklWUwTLKPkicCYrvV69+tx8Mo7R2b/ya905lR7QMADkND
         z8KW1VJoSng6wIU5ILa8G0OAnZpNn3Pe3DI3Am0jsQfI1DvTywVGt3Wcj29C7H2bWE9J
         7zoNvMQo3WnBD5aFecxRRXtAcV15+bwAcotfb+NhigLSW/KSsy0s6QG7Cjo/KfyScZU/
         ldaQ==
X-Gm-Message-State: APjAAAVXIFnA5bXsNHU5+E1UKEkxvXB7RaGpbiEalxFDIdvyxsvqTj+O
        sqKBcOKfl1PjriwPZFf0bYoZ
X-Google-Smtp-Source: APXvYqwmigcKaPRf+OIOd50oOxOjUzfx0doqmb3OFqSsh3CLhHvbUYDNLJUbQly1qsFB7EvMt3oOsw==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr26894682pgf.353.1566355281516;
        Tue, 20 Aug 2019 19:41:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:41:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Wed, 21 Aug 2019 08:10:14 +0530
Message-Id: <20190821024014.14070-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
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

