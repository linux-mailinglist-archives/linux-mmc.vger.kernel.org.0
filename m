Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AE96FEC
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHUC5h (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:57:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35298 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHUC5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:57:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so503387plb.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=uK44JlaR1k3uAS4AX3pTDEr/vTzJzlJG3h0cfLeudtdjt2eTHBjAcnUQl+nX8E2LhN
         qCLGyyMqNg23YESt9V6DoY3pHFBGGmRlYuDnqyYX+iShevZAV/Dn4G6IDT9lBXJAHj3m
         9nBp91YmOaxbaS1aW6IK2JuDZchAGjlCHl478vqdoYAm9UMDunVKLDVy/V3v899zP9Qi
         pvMu4EarvlbOHOzVJgP1hSfPL7LSJGBbhSmY1nMwmX9s3cTwlV+fc+8tAmc+OP4bZ1lz
         lyQ0oP9/J9EAAVm8Ir1EoxS8w8tmPI2dkAjFZC8t9BGt/ILxUKrdiBnGWy4sib1utZNq
         BqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=OcWneA6Kdhlk6OuJjYTXMTdmZD88QZaSL8n8ciVQIX6VYMmJBoNQV53ebxFZLThnq3
         5sy2GBGS3bsVqE+OCBU9RQ9FUSf3yqPHv9ZQv959giMdwEuUnnbuJL/nOGo0+AQpH4St
         3JX1p8ji2OQSFgiRu4wKFUBcO63mR7Skjv66yn1EhCdUvh1aWzXpN7Ea6dHiGBnK5X5D
         9Xmyr+wBt9kZsIOnq7XPpFlJ8cTr3wXWIoXESoCH1vZ4+yf7a3Gxlw3uAbZLMYNL/PRa
         4EuG8gwMqIsRr7MysC+WlgG8mha6t3dfa97a3VEeu0vs3IZW7UeHwZo7YMwM4rsfHb9B
         Kujg==
X-Gm-Message-State: APjAAAVrnmz7TR51cQseIidnawxJomCZkScwbo3PGk6H7V8rEsa2pwGv
        DVrQ5PFCnYoh6g0Hm7ConLMc
X-Google-Smtp-Source: APXvYqxWX41fVvpAy5mDzcBY4knA0x++pNqIAFAUMif6+qT59dLNFyls0cGJowbkdKkvLw/bLqAyCw==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr25772303pls.165.1566356255979;
        Tue, 20 Aug 2019 19:57:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:57:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Wed, 21 Aug 2019 08:26:29 +0530
Message-Id: <20190821025629.15470-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

