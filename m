Return-Path: <linux-mmc+bounces-7237-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49959AE7D20
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Jun 2025 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51863A053D
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Jun 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A172EFDBE;
	Wed, 25 Jun 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LvydARHx"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA32DECB8
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843402; cv=none; b=ug+wfBceKO6NdKAoVy5r2i+Kkq7VZZHlOkwmUrg7D6A7Wagr9WPDfkwWoYfA7WubWPwdaKmvfsvrL8wEuEv8PD0juJC7NhfUK7N6HvH9AzlfjjX09a8OEtuU/IlrboKlVjSdDQNxEhbWqVzjSdYdOSeTexfEUlZiUiOZs8ZksaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843402; c=relaxed/simple;
	bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ3z8+LjXzlfV2+rgFHV9y/Bkv+qo55zGHPkX2nh307c6LC2ybPohSnNT5L909MO/pt+dHCCW9cwKJQIPx3/aiZhn8qYpIDxFXxHN6u4QN5jcV8JoFX3aC08v95FOQD5kCeNlwzic2TMGhPC5sf1XhKOqON/bGDWoGoxfBYiMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LvydARHx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adfb562266cso270202166b.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843395; x=1751448195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=LvydARHxuzFxtCfYscyeGvnu/FsA34ENHBLug4havR/GAfJjtcgjud1oswyXYJEGy/
         18UVrovKSP7pci7iUFXIBsoy7o297dX//je7PPKjyGig3UQLEiXTAKzM94dvClfXnKf/
         eNAK9I6SOsIKRVnDXQ2qByOHUGY7tkhoEw2QBjIj8xH7u2y+T4vAelk4B0bTp3ZQTYGR
         oUNxVEexRMVH20ICaBFC/TsJ1eEMZzFU72nIXwPnYstPl7+aqLvx1Lyanu3MU8gY/acD
         8h2Ili+bwlMoAQjEDVMcnB2H4J5nnsyfbvXTIMnWk4VISDwG3x7W+Cv2qKPetmsCXpu1
         8Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843395; x=1751448195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=rzJVLAX5vQ1sXo2v6A55cEZLIlKgpMZ2ow57ndTH5SknRousjqGdRGV2rgV9WYhNO4
         1eq+hvG3fT5b3DjZ3XQL//SmLPHOJzSFNX6Z8tUcE/Ng/aEZubKEe4MNsPFrd/iShVWu
         rLR8hGRdS49eIE8SQDtiw4NLYp2HCrs+j3LEHHXYnqtQXdJ0bvgHnzDrObaw08A44mI8
         rFuldj/5phbeqPH+33zD68epuyGphxxcDCee+jw+W5+rEmvsgg3oDJekgBSkSdlLGfop
         X11A/9+EuHArHRoUm7eLnqTZNU4o58nfmyJwnmj+uzo9ChCg3XWxLVaBiGMtaTVXnTxr
         40gg==
X-Forwarded-Encrypted: i=1; AJvYcCU87FLOAaIrXvHMVeNXOa1JEOEGnfyW6dcfGzoCqJPVVIULZRCuIU4tGJJL+O/cvmAT5z/T6Or8M50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPqqZab97ukW/SsCPq+m/acEAFqNkUERAwJujS5DYuIYD5JNH
	Z+s00ItzSW/1wvSrl6aShGHHjXT+kIw9i3MUFV1p45o6GZmPfdmo/b3eRGjZw86uckI=
X-Gm-Gg: ASbGncsp6fvkmCLHFR3Yb4VbIHyLhYTAvRDAG/ZyGkRZzv/i5cusVAGOscmCayX2+GP
	9/EOU7gyfes1lIbur9m9AHgujbKdhuPvf4ZlgLqPWP95l6eUz0dWIhZm/pyEuO8MdJI4HloCDmH
	8xD13Ln6NqNiQcyK8pSdbPb44xJcVtqqQrnoeEwXwJpRLGTXtrZ7jagZEAvN6jj/oDx8LQbDNWa
	mQVVR20vKvAvKYcdkmKjyweCOwTgXMH33VxBMLSD0GSlw07SBIBCsM0BGFXnJOfNbam1r7kiR4+
	+wueLQYdT5MUFPM6INvI/rrSGlAHFZ3J7L6i9ZPzj2Rq56XndBxGUaIEsvPULDt+0VpTFQTTzcY
	CBautOIxk3606L5ZvxXymO28aSV0x4QHq
X-Google-Smtp-Source: AGHT+IH5Ea6Oe8g4N7kGjKPuq2Ehn1sdorRYiGI7t0sOOA/sE5jzxQrPTZnHeS3tOTzbYiDpRieahA==
X-Received: by 2002:a17:907:6d0b:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae0c539bd16mr168789366b.19.1750843395300;
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:02 +0200
Subject: [PATCH 07/14] dt-bindings: soc: qcom,aoss-qmp: document the SM7635
 Always-On Subsystem side channel
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-7-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=902;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
 b=NfoI5zbKRHbMeTR2sEabxYna1BsVoqMJWG6yk0k36XGqnYtuT0/2sUxemlmo/hi6+elMefc19
 3axPadbKyacADeOKyW5Iv0bjZ9mnmTelUfPVfAa3dsIc/MTy+uREFd/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Always-On Subsystem side channel on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 41fbbe059d80cebb214317df8ae15b86573546bc..24f7536ffc5ab7489d252359f3061c8619f1eee5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,sdx75-aoss-qmp
           - qcom,sdm845-aoss-qmp
           - qcom,sm6350-aoss-qmp
+          - qcom,sm7635-aoss-qmp
           - qcom,sm8150-aoss-qmp
           - qcom,sm8250-aoss-qmp
           - qcom,sm8350-aoss-qmp

-- 
2.50.0


