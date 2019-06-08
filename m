Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE23A1BC
	for <lists+linux-mmc@lfdr.de>; Sat,  8 Jun 2019 21:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfFHTy3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 8 Jun 2019 15:54:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33046 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFHTy3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2019 15:54:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so2105837plq.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Jun 2019 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5WHqJ8Fzw0bLjHWu2ZZmuc6AhtNWBY/uQTUMnQbyWo=;
        b=Ba535L8wbJ45E6Pae8SeGkfTmpEH/+2lOqsn8SoeaY23GU040FksWz55StUbKM0SwV
         ZYPlfE8zGiwEh2Yl2FMO+gzvyRCJe7Yeg+iz0g5WEVGSS3lUXAt4r6qeYJRy3u0QSkcK
         uJhMAk+DAKXrdXWRz5pc74uVsKATw+tBQMP1yK1nHaYMZ6xOShY59p+JZgv6L3vOJTBi
         q3nToDBh9aZRzQ8RJ9zzTgatOE7MHaiECSTqHv7oxqo2yCyBMDWbbPQnLHoGZsztUjfY
         jlY9YvRb6AFmo2JOvaCbkt7YSh4xoNT3hK1ITerw+YcBvZvMOdMm10P3psGkZ1Hthzbq
         ykag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5WHqJ8Fzw0bLjHWu2ZZmuc6AhtNWBY/uQTUMnQbyWo=;
        b=DDf6zs3NFzkp2G3uJ0Uk3XkqJnBShdAraHgPBzfmvTXKriaPyWgosb/l+FHK5eq5ne
         xwFeZ+qmLKIPC6QuZIpCJ8kvmUp0FnE672l+O6HODY3DUB4LHUKsCW6xvSVGlXhkr3ch
         ZTHb+XEn2X+QjaNfg79czCXc20ahQYGnyQqoOYDYQVgCDUD2+GUzisl9YaUA5AN13mvK
         THbsANNthQLB4R1A+obQPf9KPe71fP+dG3nWbBM4eGnG2+FxI1r6fAZ/lQl3Mz4SUjCf
         Q0YZMnSjB1Dl01PtDTZczzFxhbHIjXENuvWXJGc014z1GsToV2/OXnY+382C4YrVnctE
         Xttg==
X-Gm-Message-State: APjAAAVn97YwWzAjeYemkTvnGthOqYUaRBWYNx3y1ntmFVVppguUWyXh
        9RwL5LGX/Ubl1S6susYVGb5Y
X-Google-Smtp-Source: APXvYqwTqdeZ5OauUqUnPMlacVgE3gDJQ/PQSBO0zbJlKGD1m8c/CAFA+tUjoxTqoIycJ324ulVhjA==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr58590534plb.231.1560023668462;
        Sat, 08 Jun 2019 12:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:54:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
Date:   Sun,  9 Jun 2019 01:23:16 +0530
Message-Id: <20190608195317.6336-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add MAINTAINERS entry for Actions Semi SD/MMC driver with its binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..11d6937c4688 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1336,6 +1336,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1344,6 +1345,7 @@ F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/mmc/owl-mmc.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

