Return-Path: <linux-mmc+bounces-5186-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E4A13CCD
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Jan 2025 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191811616E7
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Jan 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7E22CBD4;
	Thu, 16 Jan 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klpmnC8R"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910D22B8D9
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038973; cv=none; b=k7w7YLpdaZFe+9oRO12GCxxoZVoXH+ByyMEHyIqhY0DYfiy7ig0Y4ewKpMVUbBOVrWLblLMrmYzuybdKOlLrOmGRhx0NOuB4nOg5w8fQLSufDSvbWqTVj+D/EPnWaSNTz5WAFbSQEmD7kEWiyyH5zB+MIaY5ctPwps0S2Qhk2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038973; c=relaxed/simple;
	bh=mMqcSmFFvw2TkkbHF0Z/tBSpa/sSu9tnGHtQ8tATY60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPR6UFi8uNwEy11E0VGUexYGZXFeoIPMdk0qmXSJlnfFuWkABHpF5CUTddnC3xzgx40nYwfGhKWzdsnfAb4BmMe6+lz23XzeMd4gevXySDnBnCB448QUFqMYiE2QuQKetLI3ppt8whqXEDzYFqeCS3+dQ4jz47bTQBJZMvMVc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=klpmnC8R; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e06af753so565286f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2025 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038969; x=1737643769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VDvVHb7Hz9aOiJJ+fFlf31oRvekJW72ufAgH10hVdw=;
        b=klpmnC8Rc29mih5tU+C64KE486W9gvyUUxMcSb97BRBkhino/vFeLzUI8xBK0L38PU
         rsDc0fEadxBOI8D7Lsi8p3zd7fGZ9LN7/zPnEXYFG80/3km/cFgrMoNWt4dcqTUoauLM
         fIt7I8wSz+iOMWpgpjGWqnBLUYpQ2gELlTV/rJaG9XNdx3hp8Zo1XHdK/E6RbcGimMsW
         fsNpZlE4YpPp89c8WycXOK7qeqeui/tGTxRT+5CqSwF6pnIcarc1gQ0+1Kg+OEJyQG2D
         WpbACsVqQz9XusnUwJDRTQAh1iqKXCKdhYvniLrFnLVD/ylonoTL90TX9hJJ4sbCZMte
         UWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038969; x=1737643769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VDvVHb7Hz9aOiJJ+fFlf31oRvekJW72ufAgH10hVdw=;
        b=aqspNT9EGXDku5nzSz05mP+YdLW5A4f8XgImoMHmZIGcF+oar5qxDxNA4KC3armXXS
         VUlhrpPOTuWGy654XcHgGOKJ/FpmLZi3nDJeVEH1PaFNy9oOZArPnuiDwFRhVI+DmWak
         y1Vr1pluffXazh8MLA5+lo4uxt4hg+b0vzWKktvfPXtGMb78zbRsuPDRxRh889D144JB
         Na/7tDAA8c7AGrvXPkvyPKDu9XZEgWs9JBKP2fNZlWy1QMedej8UyJv9KCDv/1s+VMU5
         pNazQ9tXGdbR5pzEV7oe4PM5LVguCroWRArcYLOX/Qv7aaUwT64Mpv18icaviZAF5E09
         6ypQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKHaS+sQusVxDJ1ADfCE+Jx3aVDTpRYx5fau+Abytwqy0I28NLe37ng8QqTu/a5gyt1YKroPLXx6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ae8A6h0InXLhVfx8YcFArvDJFohfRJbTcyTm1C6DoPb+7W14
	25kcbSurERfsUiqkW+hdBhPdIbwxk13m6JaY4BxnFTM5bxTteQUlpCEjbUfbU0o=
X-Gm-Gg: ASbGncucDbd/56oQfOEuNAZRJYgEluw1j8LGBctFnMA0W1z+Pr9pOlo9/gTqzc64eiP
	k0kC2b3SZtTEiyKhVpQukxQCp2XI0bEah5Y5tTshR1Ru+2IeC4410T2Rfijn13KUyArUemsuiZN
	4osJjgUZXkTwMH4d7U6DKNEdvLI2fB0LeyvPlWacZHe3NgUvAKJ6hH8hNBd/HcU/FBNEIotLM4A
	4jLX7Xt60Fii761GXL8mJsRjHIUbcx0l5vKVWWvUlOEOSIXo8fyeBysN8VSrsJchYS+evK1Datg
	dsAp4o5BgEXnP1Sa8gg6FBYsxe0QGztpqaQ8
X-Google-Smtp-Source: AGHT+IEYjm37I0xC5oyYW1bza4Imter6m0Ap3ye3A3KaXLIpUrnXkIdWfDmQraHXh7LXwIvTqWenkQ==
X-Received: by 2002:a05:6000:1862:b0:38a:41a3:218 with SMTP id ffacd0b85a97d-38a8733899emr28060936f8f.36.1737038968835;
        Thu, 16 Jan 2025 06:49:28 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm70310f8f.10.2025.01.16.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:49:28 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 16 Jan 2025 14:49:07 +0000
Subject: [PATCH 3/4] scsi: ufs: qcom: fix dev reference leaked through
 of_qcom_ice_get
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-qcom-ice-fix-dev-leak-v1-3-84d937683790@linaro.org>
References: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
In-Reply-To: <20250116-qcom-ice-fix-dev-leak-v1-0-84d937683790@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737038965; l=881;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=mMqcSmFFvw2TkkbHF0Z/tBSpa/sSu9tnGHtQ8tATY60=;
 b=ckw/p8Yr8OAqf94ouXfHUwYbbzLskOGYomyFslWm+iFcOpDzJC0mlpKDWKk8wbQ91TJMNb+5E
 nC9f+glXfEdCGF3iseCm7YkfK5PJU3TI7PKc9l6rqwoy5fHLepwJFWH
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 23b9f6efa047..a455a95f65fc 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -125,7 +125,7 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	int err;
 	int i;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;

-- 
2.48.0.rc2.279.g1de40edade-goog


