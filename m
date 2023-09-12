Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD279C5CE
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Sep 2023 06:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjILE4e (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Sep 2023 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjILEz5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 00:55:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCFC272C
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13437277a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Sep 2023 21:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494400; x=1695099200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77jF+OWBR9+e47mhz5qs7kNUWKx/GE4woAG28Z0ww20=;
        b=FEOwAUIk3jWrpk3zbo+CMdDO3J1lqd2U2OPHGJRo5vC02TKdBThw/tLnCLBjkbC9Ow
         b9aIVP+zZ9hRICmldS5Dt+tN2hC5USF6CGXDXfip4b9x7tMBuh6j4SgpJ2JHGZ2EK/Vo
         +LytFL0y4FE2Re30iksQw4L/UmharLR9g1vuP1HHpCSU91gf1w9jHtvkTW2BpsCFvHQR
         iHZBn25cDJvPu8SAG55YqDljfj+BJ2eylk8Y7aNI089s+RZ/56GNmuNgDsIdVdFBLvb2
         tKQFrubcnrsYltFSAqSp6qWIm8vJ8Up5/1KUHe4zsUtseqSCrZRyrV8IP7hQe57Irlzx
         p3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494400; x=1695099200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77jF+OWBR9+e47mhz5qs7kNUWKx/GE4woAG28Z0ww20=;
        b=dA43CqFdB07sjSrYw3n7TPCq+7uW+2SmS/nsxQ/4p0cZErUtOLeIuMjcskKlzbKIhf
         XLy7P66RW7nPvpUZqMkvhm7oX08aNmCWolwt0Jrvu9ZeEsnlJI+6uXX/6EvCJ8OEsY/t
         gKVlTyw3KBVCWUbNd7GqICGkbbbCMj9liRSLsSwsGf/pnXYwnaTBrVJDANIhKilkHrH8
         vMSeXKenaXMtG6ChcqwoWyBOXV0AnFM1LlXC5/Hfym6Yky3zp1/t/vmhKtNjfwmW8cK+
         CO6LebvTXpfe/lVSm7uXpSyFalIA8b11ynufV9C+v5hO8gIk/MVJIDsmGeftdfdIUGVB
         BF2Q==
X-Gm-Message-State: AOJu0Yx6RU36EKnbHqMJXov4tVjBZewdsMGeSrilR0ZbWnWpF9U5EnCP
        NdfmQ6vK8zLmr2HWBKx12rm2iA==
X-Google-Smtp-Source: AGHT+IE0ifdvbd75rJDD9P6HGTE2f9h6ECArFAkdiwvYXowG/D3vkQ8PH++VjV4wnSSo70EpGkh7tA==
X-Received: by 2002:a05:6402:3492:b0:522:c226:34ea with SMTP id v18-20020a056402349200b00522c22634eamr1931293edc.7.1694494400074;
        Mon, 11 Sep 2023 21:53:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:19 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 31/37] dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support
Date:   Tue, 12 Sep 2023 07:51:51 +0300
Message-Id: <20230912045157.177966-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document support for the SD Card/MMC interface on the Renesas
RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 7756a8687eaf..94e228787630 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,sdhi-r9a07g043 # RZ/G2UL
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
+              - renesas,sdhi-r9a08g045 # RZ/G3S
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
       - items:
@@ -122,6 +123,7 @@ allOf:
               - renesas,sdhi-r9a07g043
               - renesas,sdhi-r9a07g044
               - renesas,sdhi-r9a07g054
+              - renesas,sdhi-r9a08g045
               - renesas,sdhi-r9a09g011
     then:
       properties:
-- 
2.39.2

