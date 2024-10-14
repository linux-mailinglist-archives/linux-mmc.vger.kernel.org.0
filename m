Return-Path: <linux-mmc+bounces-4356-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFBE99C2E0
	for <lists+linux-mmc@lfdr.de>; Mon, 14 Oct 2024 10:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129821C2172E
	for <lists+linux-mmc@lfdr.de>; Mon, 14 Oct 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72E14B950;
	Mon, 14 Oct 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW90NVU1"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE514D70E
	for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893989; cv=none; b=SL1fCUu3rHck8d83+XYKuFl/XQwlHQOGUcffsKBrLE5nlKTSq2mKz0pB/rKaL7SaogY83zO05cC28LGh7bzcY1s9DdvMoeAlrKFC/jFe5lk49qkofhURvWm20naH3NA45MjzGVi94Mdf9gkpouqgZI6wyrd8v96f4+zU7STRNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893989; c=relaxed/simple;
	bh=xw2OJqLmdlgJRjPuT1t2HIpou/PjV8ECKTZV4nucn+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+oh2CyYB/Nv4xl7261uub+yRCUqAo40CQeLCUl+fuIgbQ7nD0CX8bmoxhCc+FKAip9MSV9GPQI6Glv5MdaGYERAOR5fSxJlIC6bs5rxPwBQ0vw5q3iY+v2jUNpoLvnkpJBVBkvPng2K9fIddrL9tM4zHogcKrI6e+rPkgSUTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW90NVU1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1738832f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728893985; x=1729498785; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gd7tvUIcHEudi4VdsXpEME5L1feZKH1BO8QhpI19d4E=;
        b=XW90NVU113DNxSLTRfqmJmB6dxyheWqLF18Adhu6dhY2vZ8GiMnjVE2xvnirbl2rR6
         u5CJo050vy1Iu2dHichFcRXdmzL9JSq84pleqQbe6kFD6Jx2xXl3OW4bpIlQOvuJn2KQ
         3ng7NrYT44g8th4FX0dc5XWQDYDEB1FJm9CmFNYHrQ/A57XDVzXhWIVgjufdpX+Q9s8x
         Hr9K7yOJ406OASwqod4to2nmRj2JubF/r6V+sU2c4HrZ5djRuF0SdYGhXnGGgMzlqlj7
         6QrmmhbotplgcmC4q3JkBFz2IsGMuRW2rTTFXxAEf2G4Z68BACS6mLdBXZnkUHeEiGBN
         PflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893985; x=1729498785;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd7tvUIcHEudi4VdsXpEME5L1feZKH1BO8QhpI19d4E=;
        b=rp5hw22hmViHNCbAfXl0sUgKApEi1YMQV37D4es1gtQGIjvQTjHhfQDYRQk9g7xN3l
         QdRR/XkdY08sjJajyY5jPraD/KjtyXR70t/oBM1S2HWqyZ5cm7zw70qKIJxFG3Xdbg9h
         DCcG59cuV3wLICinORER06nzObOb3KKTyF7YwtrcgrdpaGUpiaeps0ed9MRxRp1UwZdp
         JhhatnH8CsBNeZEJNLXMdvssUg8roLw1vETJuCIyLB7V+575TwokPSXNkkecLkBUZzf0
         +crdz0QRrADyZ4TnYnrvymrU+GEFgvSUPm/2MH6CMitHmnnpbmGiLshX/kBRsWyIc71i
         QcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDZOS0tR9WFc0N5Ft2NwTldL/xWiCcvekb/4vCBHuyOYUIrTJGbYZLaRg5t0BEApUu2r42HTBPjXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ943Pl0RN+dLRSkODhRHZchGJIo4mwVrhoVfKXcMrPQVC9wl1
	f6Pabp7R0g54OdiHsE5O/2vKDy9vFbX2byNOExijrjp9ET9quAPut6Pu3OttOZ4mQtwf4ojM+iO
	W
X-Google-Smtp-Source: AGHT+IH4cArkWsKeyXZB3oSCRl0gYezdgDkmRYtkaXPxR2pQRhP3G9Apq/L2qoUjMlXXxgceMU2Auw==
X-Received: by 2002:a5d:4d42:0:b0:37d:4ebe:1650 with SMTP id ffacd0b85a97d-37d5529b1bdmr7968921f8f.46.1728893984762;
        Mon, 14 Oct 2024 01:19:44 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd04asm10715752f8f.27.2024.10.14.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:19:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: x1e80100: Describe SDCs and
 enable support on QCP
Date: Mon, 14 Oct 2024 11:19:23 +0300
Message-Id: <20241014-x1e80100-qcp-sdhc-v2-0-868e70a825e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvUDGcC/22NzQqDMBCEX0X23C3Z1PrTU9+jeAjJqgvFaFLEI
 nn3pkJvvc03MN/sEDkIR7gVOwReJYqfMuhTAXY008AoLjNopUtSqsaNuFE54WJnjG60SFdbU+W
 Ma8sK8m4O3Mt2OB9d5lHiy4f3cbHSt/3Zmj+2lVCh67kvbasNX+j+lMkEf/ZhgC6l9AFu8seVs
 wAAAA==
X-Change-ID: 20241007-x1e80100-qcp-sdhc-15c716dad946
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=xw2OJqLmdlgJRjPuT1t2HIpou/PjV8ECKTZV4nucn+E=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnDNQSVxW3GAqb2HK0TImCJ/FSZyyGW5UhZPdv0
 hcBQpfTOKOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwzUEgAKCRAbX0TJAJUV
 VnJjD/9KApqkwLPUPyneOzHvHnQTKp9VwcboL7A6+Mjc0WJdtTmo0RBJCwd57mNcFqTjhwhfHut
 g8OuTWQDyd0xgcgO6ZtonF92ENs2Z4OtTwEjLlyfyQIYceIisINNun9pv5TJNiQh+bGoL4bcN/m
 EZzu9huH/xEA2QfS5DRzsiKBoRw8zuAN20UlFyJATafaDAAZ/81bKZ2G4AYwhFSNKjDqkR4N0Rk
 Rg0zztsqzSlD7fmspxZ8eOablpi5IBWHwYLvkhv5EtbtyVW3dD6eoixvKIyi/Ru0EPVkl5X3CDm
 W9HgdO9gvC1119gU0hmWCWRYFNiseq62S7RhowTPHy6ssIJoWN5C1NUS1BAxfjqATyS4908mGB3
 TILZgvaw8pq3184BzTypVPYVfv3rSTGrB7M2UJFldL1YiTLPmq3aZNqfxpOTzrBS4yEXUmuHriY
 gR6aSS8Ytb/gDnX2SNWp3+nY/U9viy0FXFvFDDOIRKB7lY0tt78IfAUsATxnBBMuTSQCNrJ1aLc
 KDevVCGK48AdF4kxt9RgbQXr+RK0V6uZ8kSU8QMmrp3loo6aZaRD0h32dh3PZo1NxwHSop4hGea
 Xyu/VyeMXs7iBl4nyV+uY8PHdMEE5IREbFRwdr+fCOXvAGZzLQhPLXUXcWM+UPBSLnRSVVacEgE
 9XoeeUd1tP0Blww==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X1E80100 has two SDHC controllers (called SDC2 and SDC4).
Describe both of them and enable the SDC2 on QCP. This brings
SD card support for the microSD port on QCP.

The SDC4 is described but there is no device outthere yet that makes
use of it, AFAIK.

Didn't include the SDC4 pins yet because there are some bindings
errors that need to be addressed, and since there is no HW that
actually uses it, we can describe them at a later stage.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- rebased on next-20241011
- dropped the bindings schema update patch
- dropped the sdhci-caps-mask properties from both
  controllers as SDR104/SDR50 are actually supported
- Link to v1: https://lore.kernel.org/r/20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org

---
Abel Vesa (3):
      arm64: dts: qcom: x1e80100: Describe the SDHC controllers
      arm64: dts: qcom: x1e80100: Describe TLMM pins for SDC2
      arm64: dts: qcom: x1e80100-qcp: Enable SD card support

 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |  20 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 142 ++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241007-x1e80100-qcp-sdhc-15c716dad946

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


