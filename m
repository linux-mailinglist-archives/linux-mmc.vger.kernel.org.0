Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E496FE7
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHUC5b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:57:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39295 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfHUC5b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:57:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so492230pln.6
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kTpWa1DIkfpJvRELBVr27cwiqR/tR9AaU9awO2MhQyc=;
        b=Bx/FYls7hvU12xUnK9D44oXA2TbC9SSL5DdUH6Iw1+OJSmnQVYyvJljQg+8PNXLbH9
         HZP4dGbtSMUmcWbHaa7MaUu4w3TLvcZW5rFCnls4nLhAFJslZDEUiGT+wIRnKkDDDaYg
         pau0XSRlGkX2YztDlmWlhjiNy0ccBy0rG3n21M4wJDxqws9Xmw98NixJtW8l7moGGnzb
         xEd9GuUTCrBIe5qhtlNcwYt60jMECW3EPtonYnYNpwVR0LV4EQCMMRNSg09oBjwJh2/V
         NwiSuaDf6Ky7D6UcFh8bU4v1kiz/beSPRzNAVXvrGlBe2ZkWty0/H/s9ES9hC8Q07cKY
         2V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kTpWa1DIkfpJvRELBVr27cwiqR/tR9AaU9awO2MhQyc=;
        b=M0pqvCRQTpArXlYRnUMzwihYvqsv5zt7KjuCpPbcYMe8+EdNXZgHJT8mbyr4Rc48DA
         UhBVDUpUF/cOOdkDCUFsEFJlJuebyUJY6yH7oVSh79E6DoV3dbfFi47rsBiFXdX1eImW
         vaqcXvkXlXqICrqVlL6qoGUzWy62w+LaZezrlRcqhsJmug/2HYOkBp0fpAVaKoOnq28U
         Dk/66RKm5qEDIe5WwGiS0nZKLfYEx3yhNrB6pYYqkl2lzfvhNM1leKV5ou7qhZMgvY4A
         JmeCtuhx3zeNjmDmKZ7UqGPlQNJIluZkIyhEfBqcoIFRO5xUOqcsUwDZMwkDPnaZ8gnH
         ZFgw==
X-Gm-Message-State: APjAAAVrbAQ2ryyuR+ED8z3MAdbLdSbU+jMnFzrt562W6v7tZfcJhmPd
        8v08fBdgVRtztKf38TC/Xp69
X-Google-Smtp-Source: APXvYqzCYAHgUzWM5dAbKNZL5kxfN/EKhDekTXkWvc05Dn2pTYNnf9p4ZucvDiRW7wRjry35NYiMew==
X-Received: by 2002:a17:902:e30f:: with SMTP id cg15mr31950918plb.46.1566356250180;
        Tue, 20 Aug 2019 19:57:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:57:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
Date:   Wed, 21 Aug 2019 08:26:28 +0530
Message-Id: <20190821025629.15470-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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
index c31e6492b601..d13138330b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,6 +1375,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1383,6 +1384,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

