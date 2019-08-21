Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F0096FA8
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfHUClP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:41:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34604 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUClP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:41:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so400797pfp.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOe0QY1KzUF5P+bCoUM0BJ5F01MAdy4sijBj6AsQWEY=;
        b=HWmyO/ZOIBs+A7zmQrIMqVgyxPQ2jB0Ddy0+rEqooIS+YxUle0+bJYmfSvbdeKYUX2
         0EmoZ95HMKoXzihfE59cWYZwRpKM9O3xOMZfsCGegfiFytsqkv6Xc5JccykPm9L3PRrk
         Up8koMo3E6TXR/qynopS8F42HgAN/sDyd2zFCFyoZVGuzp1O9a26qm6MlXTXfsiE7QAy
         hq1I8SJNFGSQes+82DZeGKlJHrnp0OS41f/RCV9JHQomXmBFHLimNj1BNCq0gLiaNgCw
         Xb4mIjU/7I8lyINue6igBtz/3bWVguWnPYITjEV2KwbOQ6Zn61NLBpnXGt8RiZmShFeX
         +fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZOe0QY1KzUF5P+bCoUM0BJ5F01MAdy4sijBj6AsQWEY=;
        b=d3PHmELZMW1jzcejyxtwrtk4+pdI6Zs9Krc8KiDlQQuo+6JYrB0i5QgV7s6gi425nH
         UQJASIl7ucH7zp2eLVscm7Z6w3MGcCvaik/xdaclzWiaL9LiogA8eN7bZ5ShZn1nCMJA
         SJW+zxceT0Lmq4jnSGwu5KsgTn9a7gMwhFM4to06u669qEAPF9MPGT2kVuFvdcYiODAQ
         j212COYwBn4OPmagFkLbtBtvne58ZEeAvSSKhpPdhMfZNI5jgFUSfAnzbedwFdkLnu61
         dPTeihz3gbDinIZ3pfDEnkmWqUTxd3qyqUy9iSdoxHeiKiimUSKgljMjjkuD0F2y+N6c
         FFLg==
X-Gm-Message-State: APjAAAVyDvzT9VHpq7GuQWqw+5y3mXVhhqgsb5lMSj2QFdY4c4pWW5/z
        N2kmH7Uv9E1M8jsVWtBy01dv
X-Google-Smtp-Source: APXvYqx8as53UWMctePrdUCwm/ptziUdDjmDttJKVhO0LjcJc5tCGhcTtg3y6wHbQE7foFo3/P5+Gg==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr26433918pgb.82.1566355274706;
        Tue, 20 Aug 2019 19:41:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:41:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
Date:   Wed, 21 Aug 2019 08:10:13 +0530
Message-Id: <20190821024014.14070-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
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
index c31e6492b601..247d5332f7b7 100644
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
+F:	Documentation/devicetree/bindings/mmc/owl-mmc.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

