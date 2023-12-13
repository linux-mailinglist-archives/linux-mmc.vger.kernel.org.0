Return-Path: <linux-mmc+bounces-470-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE88121FE
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Dec 2023 23:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D791C2147F
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Dec 2023 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6283AE0;
	Wed, 13 Dec 2023 22:44:48 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CA2125;
	Wed, 13 Dec 2023 14:42:26 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9e2a5e8faso14820b6e.1;
        Wed, 13 Dec 2023 14:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507345; x=1703112145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maOKTDIEk53dJJsg1tE4bXh8KPN9eThMiSDLUEOZOEA=;
        b=sPBosREDFh+EzpNqt4rwcnANR3ZWb37qA9SRxfuU+L56wn65oVlyEkWD4Xtq7wXFry
         FXj2T39CKsZXwaQ03U133OsNKKjGNj1r81AHUrd9X165mZwymlJwXErYCI2JqZUbZMLZ
         4XdQrEUWNEhu0rCTlsyCPMLCb/4rTjN7MVc5uGoPtRI8Jag9TifQ3xpNpd524WFRLUV8
         mYDP9Nf+yiHpHdT8fucB/Fyt2akjcUPGqupEhb+Lm+2Ln4NCTQha9ABE5B32aN56ljK9
         ptdNlwxr/XrMS5zlJ6HqjMWXaYALvm8SLZeV1159f6c+s7hsOkrxh7sV4V4SXtbjNL4u
         rzpA==
X-Gm-Message-State: AOJu0YylyJ0PkXHgHMp7vfIOndJ7pWZnWpvtPiuoaozZPi0jW0yjH1pE
	OrCLlMhUAfngLw05Se0XMw==
X-Google-Smtp-Source: AGHT+IFhc2TiPyyyiqXGpdf2XNgz6JFD40p7uUQKwPCLtCujLO8EITVcRyPX6PPwx9fDVVg8STBkCg==
X-Received: by 2002:a05:6808:3020:b0:3b9:e287:580a with SMTP id ay32-20020a056808302000b003b9e287580amr3894637oib.27.1702507345520;
        Wed, 13 Dec 2023 14:42:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l22-20020a544516000000b003ba254def36sm489744oil.44.2023.12.13.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:24 -0800 (PST)
Received: (nullmailer pid 2191859 invoked by uid 1000);
	Wed, 13 Dec 2023 22:42:23 -0000
From: Rob Herring <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo
Date: Wed, 13 Dec 2023 16:42:19 -0600
Message-ID: <20231213224219.2191721-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct property name is 'reg' not 'regs'.

Fixes: ae5c0585dfc2 ("dt-bindings: mmc: Convert sdhci-pxa to json-schema")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index 09455f9fa8de..4869ddef36fd 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -18,7 +18,7 @@ allOf:
             const: marvell,armada-380-sdhci
     then:
       properties:
-        regs:
+        reg:
           minItems: 3
         reg-names:
           minItems: 3
@@ -26,7 +26,7 @@ allOf:
         - reg-names
     else:
       properties:
-        regs:
+        reg:
           maxItems: 1
         reg-names:
           maxItems: 1
-- 
2.43.0


