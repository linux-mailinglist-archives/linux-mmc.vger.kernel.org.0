Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC843A1C2
	for <lists+linux-mmc@lfdr.de>; Sat,  8 Jun 2019 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfFHTyi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 8 Jun 2019 15:54:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41183 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfFHTyi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2019 15:54:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so2898132pgg.8
        for <linux-mmc@vger.kernel.org>; Sat, 08 Jun 2019 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7z7G2uIs0k+svTX+jtZAzZRGJWQLvmM8i7xrZdjKEXo=;
        b=CcJVLs2BWQiGNei2MbtI6uiXWAb/JLA3+6p0R5uSVtGdgJCJSv6yBAMuVVe2LKu7DH
         l8XD5lo+nX6Zp9FSjvnoirPJj3PqQ/uQLGiLqOQDi+pkGFDKwHLf+gmhd/LdE0G3uhrZ
         wD7nPtsQWQn9SrOei/XUq/JRIZcZ9IQ9L7BVNycYvo5T1H4bWY/UCuF6GAqag1LkXIwA
         u7op+FLgpMulPzwHOKMdwW0xiGNuxLft8zAh4E235mgYFprMl4try5pTiEvU2XOMdT62
         XkvugA+tPg7D9SOJP8gqUJF+dr3kDnguAYW3MT2FNgYhzav+X/7lv4015xN+nLneo+4t
         LMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7z7G2uIs0k+svTX+jtZAzZRGJWQLvmM8i7xrZdjKEXo=;
        b=ZFywhGTYsau3ssqbpXFu79bNrHn0PtsJdGOtk4fSWTyhtwx0L68NSzzyFGTxVEUuWO
         Sv0QOuGMFOZWGQYyxKhkeigtlKGehG/eX+6vuvEfLsfXHkQ7WYijHtyKxD090XbROtC0
         /wI+LW0kO1N6izRjx+n3H8RJP8kc35ekpcs8X3ImSiDBsREgQXMNKbtHmRcz5eAWth2r
         XHPGGcaAgtBUdgtapi/5REbYK4EaJfsYOnSe4cny8zvvNLy1GT+dW4miBNKC2BBnwm7J
         ofuPpp+HU9HzpNlnCul+0Jc2yViR1Zf71Nyf6bj3iDXW7VN18PTln4pPLRZoFyX1xqer
         zSNA==
X-Gm-Message-State: APjAAAXhpZX0aN8XjK7Kkr0uDAmc+8OuB445i6zrDdKPXA7WWqGyBeXl
        PIwtrr06eJX5oeDqAW1hVZHJ
X-Google-Smtp-Source: APXvYqzGq9Wlppe/fkGUI+bPzYy4jai5cTMOZ+AdImb8blZYRY64w3WjFSlIocF4HQh4o4FeAhE03Q==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr8601057pgi.84.1560023677661;
        Sat, 08 Jun 2019 12:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:54:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Sun,  9 Jun 2019 01:23:17 +0530
Message-Id: <20190608195317.6336-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
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
index 4d583514258c..e0b5f4f8c9ff 100644
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

