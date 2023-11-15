Return-Path: <linux-mmc+bounces-96-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27A7ED206
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 21:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A22E2815A9
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Nov 2023 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812873A8EC;
	Wed, 15 Nov 2023 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmbnGpTZ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B175BC;
	Wed, 15 Nov 2023 12:33:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d81864e3fso58256f8f.2;
        Wed, 15 Nov 2023 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700080394; x=1700685194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgFBYcGPQDYXf02NhQPzl84IFV9IxtNIfQLd6kXiIbY=;
        b=MmbnGpTZwAZzriduqTlOZxlb/2Sk1is2+eTW0eaqX84fo0aBfSyoLTP/LZqJbrq8vJ
         kECISRBKql+vWy5IvXcpuKufWhktwBGEDUwuXAcWO+KKCtP2UHAMbuOGg+fta51oDCH/
         /mZgcz7Wsr1xt1vZbXXb+q1E6okMufTIDkgE+ZyqOQ7oj+BLu371nrHmU7p+26xHXqQV
         6GIRDdOKx7tqUYVRZddJVqqBTrezF9OPPf0onQzL+3L50Css5DGn8sa2uqlE6EPg43mk
         p6GFE7Qy5jIOxqBaH1HeDsIjx85zep+vdjesoFfp5NBolcrB7Oo+lZ1zFydlpbqfKrhU
         9hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700080394; x=1700685194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgFBYcGPQDYXf02NhQPzl84IFV9IxtNIfQLd6kXiIbY=;
        b=Bu42WUtLlplX3pYZjpi/MAEzmOQSlpmsztWs/TSLU3wVkzA6Z/JtcitFK5mWtFNd5k
         5MGuxj01YPUMelC3M29iePvFA5N1PKm1893NF7X3ooJkqGre/7jGUSXLnWouAAvsS0Ju
         +Ayt9GK3/ZnSFIk3VKRUsL6bOqFPiXueZpH5HjlNIHzhdpUxiZjjb5HDbFS37vxwuHJj
         SQweFfmeCOPuHidBlIcjlmxm8rL3OQJs4v6UBeXcLGmBfifNiZ6HzXZzYjSW53EOyH2n
         DLQ43dfnX8oL+tsTGMwONv1gBtIpcOO0ik3vNhxqIvyT9uVBdraP3qg5JDs3vj+hf79m
         omoA==
X-Gm-Message-State: AOJu0YwT26PRCMeRHH/KkO1it4XjTsjBR3GnljEnxzTJUpYJPy2FEU4b
	qirJwf+M5OgeYxKornMdfJE=
X-Google-Smtp-Source: AGHT+IG1hfi8DyYysteHnCViB3gjDSvmpwMQXy/6EOBx/h2ueo5MLt7Exxa/60WsDrxxN5BaXCEWYQ==
X-Received: by 2002:a5d:4bc4:0:b0:32d:825d:f153 with SMTP id l4-20020a5d4bc4000000b0032d825df153mr9417652wrt.61.1700080394391;
        Wed, 15 Nov 2023 12:33:14 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id dk14-20020a0560000b4e00b0032f7fab0712sm11437978wrb.52.2023.11.15.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:33:13 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Date: Wed, 15 Nov 2023 20:32:54 +0000
Message-Id: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
RZ/Five SoC so to make this clear and to keep this file consistent, update
the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 7756a8687eaf..27cd985b1006 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -56,7 +56,7 @@ properties:
               - renesas,sdhi-r8a77980  # R-Car V3H
               - renesas,sdhi-r8a77990  # R-Car E3
               - renesas,sdhi-r8a77995  # R-Car D3
-              - renesas,sdhi-r9a07g043 # RZ/G2UL
+              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
               - renesas,sdhi-r9a09g011 # RZ/V2M
-- 
2.34.1


