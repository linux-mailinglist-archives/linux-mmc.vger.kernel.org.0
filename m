Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532167E53C9
	for <lists+linux-mmc@lfdr.de>; Wed,  8 Nov 2023 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjKHKoa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 8 Nov 2023 05:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbjKHKoN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2023 05:44:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B521FCF
        for <linux-mmc@vger.kernel.org>; Wed,  8 Nov 2023 02:44:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso83214481fa.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Nov 2023 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440246; x=1700045046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrZs4emLFc9OjGPQr8NhVrDcx8agcy43Q5wHxC/jdF8=;
        b=EOetgq+EAIJ05W+ev4Wve0IkHGcFdIgWzLuewJbfEdOGqJjFEFe8kcgNE0SuvRUuaQ
         dO/nz8qBrD/EzIaTI59GRsQJdwxl5RvMzWrWOpHF4Z78GkC6qPhNXbCvl/D/YVY7Y3IC
         8Eibq8xaXG7jcEEz5Ry2H13xyrJC8IjBaxTxbS6+0oS7l15n8Xp92jSMOrmktjluwXRp
         o/oRde/0wfDPvjSaVmFeDqrxIlb5wtt8SWBJ55/7nDv8DF7YwxXhvuPvo8ItTGdaWPxJ
         NvJGHqUqwz8unWRDPSNe+2tT6fONv1FsSyN5tVyOnoh13ULf8z1LNIjCObfDuAliGtSI
         P8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440246; x=1700045046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrZs4emLFc9OjGPQr8NhVrDcx8agcy43Q5wHxC/jdF8=;
        b=A6quAGYMNgeIZrJ271YGji1AndzzxAznxpKj1BJkSF7vo0dQ+SXWtkgykyvNwaNLPv
         V2eNlmB02Q7TYcBuxotpfPtI9FrUMy065ufyCe/tC6FX/dcUHg5IhQW/U3dp1k7nJvV3
         5NZwiuxse82SW+DuzXDHKKNp0NgasWezlwl/f1TO+uWCFNtCc5vfu6X7zaF2CvcmE/7g
         JjqY/aRHKp55MaRAPcaf3i+AafLQ89szVW7qUvluOmkJLk3X/0vH9xe1iI1H1FKmAw3c
         8QjuyLzWINLwYriaW3H+0s2Y2JJUVM+B018S+CWhqqt81yqY20GqVc5Dp2CAmLkeeV7F
         wZEA==
X-Gm-Message-State: AOJu0YxqPbO0obEpASOOgD9gqGkAsLfLkq5n7kKzCzm2Bk6yD4FN5amw
        UBMOQJvI4+u3+T/a4MV/9vtQkA==
X-Google-Smtp-Source: AGHT+IGa+2sMFPnXDCg+/Kp94WpmPGqJxAqZSoI9EBPYbrrl77NmQH95hc0MBEym2E6Wk3ngRYzA3Q==
X-Received: by 2002:a05:651c:19ab:b0:2b6:fa3f:9230 with SMTP id bx43-20020a05651c19ab00b002b6fa3f9230mr1578553ljb.46.1699440246534;
        Wed, 08 Nov 2023 02:44:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/17] dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles for existing SoC
Date:   Wed,  8 Nov 2023 11:43:29 +0100
Message-Id: <20231108104343.24192-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 .../bindings/i2c/samsung,s3c2410-i2c.yaml     | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
index b204e35e4f8d..1303502cf265 100644
--- a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
@@ -11,14 +11,20 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - samsung,s3c2410-i2c
-      - samsung,s3c2440-i2c
-        # For s3c2440-like I2C used inside HDMIPHY block found on several SoCs:
-      - samsung,s3c2440-hdmiphy-i2c
-        # For s3c2440-like I2C used as a host to SATA PHY controller on an
-        # internal bus:
-      - samsung,exynos5-sata-phy-i2c
+    oneOf:
+      - enum:
+          - samsung,s3c2410-i2c
+          - samsung,s3c2440-i2c
+            # For s3c2440-like I2C used inside HDMIPHY block found on several SoCs:
+          - samsung,s3c2440-hdmiphy-i2c
+            # For s3c2440-like I2C used as a host to SATA PHY controller on an
+            # internal bus:
+          - samsung,exynos5-sata-phy-i2c
+      - items:
+          - enum:
+              - samsung,exynos7885-i2c
+              - samsung,exynos850-i2c
+          - const: samsung,s3c2440-i2c
 
   '#address-cells':
     const: 1
-- 
2.34.1

