Return-Path: <linux-mmc+bounces-7465-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98BB02F5B
	for <lists+linux-mmc@lfdr.de>; Sun, 13 Jul 2025 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013BF4A0219
	for <lists+linux-mmc@lfdr.de>; Sun, 13 Jul 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D61EF36E;
	Sun, 13 Jul 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fVzT5wL9"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247531E834B
	for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393967; cv=none; b=pTpDr3lR6aJfB6rzv1G9e8x0dwIh7vC0az8sGWqsE2spayG21ZGP/mwnc7GocfgTeXZGy+SaXe+wtPF1yfiiGgt5QXj1lZfYhPnm/3Q5fY70XPrBmSHVDxVL2FM7XSvOp8zMa/82McPviriXNoEiJ9yzj1B8AUJtFv2qcUi+y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393967; c=relaxed/simple;
	bh=VI60lC4ZmfORZyuxHBRWFEsQsFQCradJNwP6TkMJAbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFfZ8G55bAGF5ADVBp9fTdVHP4xkXB6KnD62uxjj1aWhYNQeenVWltl9YpP3xgekC+cCB7T5fWm9gu2QHrYAkJzd+T0vglnVqnkIGbcekmPa+uRzFClMP02h7l7e4mWTilUw7jENPuZm1tuJrzmLneRj/x8Wu1EefsKHEBnQ7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fVzT5wL9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1757750f8f.2
        for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393963; x=1752998763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te4MJTBpVgJuhtRjxJH2s+xCNlwZ781R0MdiUCdRknI=;
        b=fVzT5wL9nacXW/zSdVnPdDbwPO56ZOrrEUVOpNbIAb1f7W1u2/y2rWwm8bEANvkoxp
         ozKpvIlwiIZ3WDVOOaZftzntoOQcYVO+BxYocNbPHLzFNo87Z7baIwvuLutQ29cq1CdI
         xZE/PnHpaqHl4HJZyY99lA4aO46wIJyRAvO5X7okujkVvV7TeZOGZsn2irG1Bkr7jJ2I
         FwvM+PpZiuHXcZ7rv/XYmi/2aI0xd5ekluMPu+EUSKl6sM+3E7+LpRJ9YM9MG914dduD
         0P3QH25ryNPcyxK7NyZOOQq0mWLywPEMIG0CwEYP4SgPSe6VKzQ0gc6TghnP61zNSw6Z
         zWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393963; x=1752998763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te4MJTBpVgJuhtRjxJH2s+xCNlwZ781R0MdiUCdRknI=;
        b=kxd6iYzRKjo5kR9TkmZeKWfKddEi/m3UzocCYRE352nF3CeDn3y1QfNAKBxoBBP6NH
         kvadjLRHz3YuevXYs3tmjp+WBsvjcVavMYgVDFoJeoNTJzCwGB/JN4gjUpjk7BmQLsxm
         /yaZnQbNlAPejFD2waulU6xhdYu8ittn+guMjWuv4RX6M6oO4qxOj8IdnQhStglpnq8G
         hJZdVBKoTgcpZxEEIUxjU+YJ6LWP2NjtrA8aqas1Tbc2ZnECatW3EGNngZ+NmLXLOMEK
         Tgw3bNjW0kuvDnlFGlBDCHs7T8/tK9euWqmXFU85FpGgjrbM6FKJbvZWmQ0K7N13l5gv
         XzPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1G6A4Zy0xenHS+YDHPoPf7+D98TsrO8BAnbTtM5F2waSS0KAe+yd62KRDTX39XsROpIoKHsV4wH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRZnm/fOhh6WGDmhmX3bST9Rq99csmKxjDi/gySehPDRU425A
	m98fq+xRm4yPicYpyI6FdwCH2I14jOWMduAsHA0Fc5IyJs/vwIcYSxAPP0YAUIQV9Jo=
X-Gm-Gg: ASbGncsqV9su0mOXz2LobY1ffxr6FVEuUnkr1CXuk3Z87MwlJ+0WvKxW5lNMgq8QyD5
	kqW2U6v1QrEzVnAYKPmsMdzx41c/2G4pTQ22tKEsqz4hsO6gCpR+S/XaSgiacJN1SfgeLBh42jr
	BYH43iia5z1Xo0xvlMuMskSTS5mTFfcKMSpD6yNtGzcm5KPo8KcXUTDPn3OoHZg/Izoxtqko7EM
	j6nJeiin23HAh9G7gbyJh4fn0uryEjpcibPcomV8Tv45euPT/hZA22mI5o4p8fucrcVXJibNK3b
	fxvg/m8rxQewSNUZ5sE+6kHtk9b4B+7+SkvBpO7sGVYDltNnlCxV3VSKICZAIC8DZHXwcaSlhi/
	p+3a8KVWiPb2UJJy9d2U1PMPKiIRJ09qFcaWGp9bOeeE2rgw=
X-Google-Smtp-Source: AGHT+IG58Q0+c/JdRpYP9OwThz11aodR+FjCZWHpjNmU/o1HqomzxkC9Hl2w1xFzYfqgnbsp0pIfUg==
X-Received: by 2002:a5d:5f41:0:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3b5f181bf12mr8730107f8f.0.1752393963493;
        Sun, 13 Jul 2025 01:06:03 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:23 +0200
Subject: [PATCH v2 01/15] dt-bindings: arm-smmu: document the support on
 Milos
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-1-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1456;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=VI60lC4ZmfORZyuxHBRWFEsQsFQCradJNwP6TkMJAbg=;
 b=ysFcsREoBvX5mgay6H6zBC7kn964wfsE1peB4S1deXzOSQgOF/awLFfvR6VFGhwUAq6oh+c+L
 jGE9XkkTsEYCtwhnmfdvMrCBbHaWxNcEmIJjlZVGZSlmOWt5qi/15fU
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add compatible for smmu representing support on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..66d5a5ff78fa5dbb86db72db754c23b8cc8f188a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
@@ -88,6 +89,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
@@ -534,6 +536,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500

-- 
2.50.1


