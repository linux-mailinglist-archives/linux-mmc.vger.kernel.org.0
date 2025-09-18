Return-Path: <linux-mmc+bounces-8343-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD4B41D79
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Sep 2025 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE37B3D68
	for <lists+linux-mmc@lfdr.de>; Wed,  3 Sep 2025 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162D2FC873;
	Wed,  3 Sep 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8ElKYNQ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F92FC87B
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900094; cv=none; b=bVc8pKgynQVLRgDSREWUiw9uhkxEHUVp4pYAOO1iI6ui+8vsx3O008iNj9eFqqxHPIE57JgTxojU+mFx8klGUun4QUdoqiHIrkw+Jd+h+TI7LJ5UwPvGdqYUnPA9xGgQxTLSNS6cpqN8eDhY1T0JFUaK6T9nOGbTNN4mbjrC2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900094; c=relaxed/simple;
	bh=d/8KcN+OgREoal5l5Y/MZyinEyOohKBfCQCl2h9LqwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOvGr0+Yx0m7n7MgjKNKwnKbqi7lY5QCSk/SV1PuRCTcrtscdIcrBTQN1iia8lzZl8nLUvGhiuCSrq0ToYBOvsa/nFD463g+1hYRcswgfOdtWZxbYL4OQmsOBbfEXyDJ7tmjDGTSDgqODJwtojcgE0EMyd9FenXeXsJjK4ISTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8ElKYNQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF1Ma021118
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=; b=H8ElKYNQ4w1OS2SY
	cRjRfLQNXhGZiIT++U+Rj2qGBb9E5/ulQqhy5WBiIY5iWF8F2hmUhcM/rQHVeDe+
	nWssRucKJypAwezIhYKTmmLcFQeo+Jzp56nfQ3f9oEtJxmf/hEms6ceLHyisDpXz
	XhNy4DskGSvOW0IPoYnaHeyKPE57rh60we20aMtvXgOWAqk9dTRWbF3yuGgFMy+S
	heyLA6NhhVQWvCO5lh+/k/8ikAohrif4vmQdw6yg2B13FWQMF5iar7lLMg+6Kszo
	4PmJH1h9C1ENdaBnFtrF4fO/aFRHR63bdEFg3j1Rc7EMAUBRumL0O05t1ngteZnb
	tzWYYA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk939v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:48:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso6349681b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900092; x=1757504892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=;
        b=ROgnIcSv9JPQBl3/LT8TGq6SxrEcgFQOGjNb17wI0RymehtVXciBIYtA31CIxnRyHb
         5VxcSG0M67r0NZLh77E7Bajw5WFFaCLQGEY6g4JLfACvgxgT3mADof7njmIpWjAsI4ly
         MXd8XF3aRv0mvh6LE3+JOm2dN/VyMnHM0oerPpzsLBnCKtcSQRbbS2A9qIph8SuNogMI
         KrLgbVNexbai1dDaTFVtrK6ll1ReEanUd+LJigJ/veI5jyKcOwke5GohKmPMZVn7Pgy3
         aYYBSY9xTWaX1Z0vs84Wz9cgd7TE3Qp6oIsTgzFbI8WckGoqK4CbFi/TeaGylPkup5cf
         Ofpg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Hr66gha4UiXI36WnITs/9SXQhDd67fENspzy4QdiYhTczpQv0k6S+Clt/0r90kqD1kd1XcBKzm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBZLEC7yK276u11wh057nfdREbVj9Rk051FfHcjllJtgEPF7vf
	NgeO9EIral0r5d16C5N7ldY0K2653GglMVfXeNHON6r6UJc4AoSGo9exPgwwjmIKNFz79r1M3X6
	yHgvIB9cStgPZOYqkIKEWU4fSuIb4rkw5rAuHjIAXAnCgn3n6xreNW1wD/92aE8rRbSydJEU=
X-Gm-Gg: ASbGncva1o1jvBxBUWFUomX8iBoo5ix2eFRwiQTztLrYMd0Ulclp/YvCpQswIH1eCB5
	UaDl9gqoDxOWlsqO6TVWonlakUr91FQ0G3b/OxmWiygVi1RM0gsEKB9D4dx2g5qmqsLLwspEhDD
	cYmpiDva3cQ/WH5phB8JhlpKNwqVjF7eYm3P2Gaw4uFXcNkwztFD9JMHJQ3F7e5ZRHRCbK+N+mU
	Fke12RCt9vtsjLuLZArwwB19+kjYAajMY0gNdyCZOyVwCPi3nNYL75l8YbguMleN9TmdMfemgz2
	WCYN5Tf4s5xzoaxQQL6cwsgHAi+JOx/+MUc+WcBrGtyzPtqOeyIAWW31Tlj3t35CpgZG
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770140637.49.1756900091728;
        Wed, 03 Sep 2025 04:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELpa4Dqb/ri4sikbh2/35FUCgGSrLzAq9vhNEPG8ilfsdeKswwyiLmoPL40YnRVxfbYYh9wQ==
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770107637.49.1756900091220;
        Wed, 03 Sep 2025 04:48:11 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:10 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:09 +0530
Subject: [PATCH v2 08/13] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-8-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Lwi6TRjPF04O/1B4XCSUMzPV5zfW+xGiP2gdnJ+he1c=;
 b=iKATISuLMw0sB5ZAmFurgIKPxiRrhFzj4GxgOd1LLCa9pPqVxB+oD4RcAcuMndX8Z2sJ5j93b
 Iu5LRYW2UY3CjLniV4Y7XKG505xiJsX6jBly/7LCNpWVf5DXAO362en
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: TV2oUGFxC4YOCbXkbfPPYLD-0P8b7oxY
X-Proofpoint-ORIG-GUID: TV2oUGFxC4YOCbXkbfPPYLD-0P8b7oxY
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b82afc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX4UEFcXhTc1rn
 JfI3jhj5vaJ0aDr0QEw3HC1l8zUC7qBfUxVCpMXvTV5ax8TpCStfuaYxkavUK4r/e4gTU2zGCj5
 drTEByEmKdHnmECo0Ki/ZIz0Bz2JvZF2wqYF1LbTGg1PI0yNvlyCVyWUg0fySl3hn5nelQYcCAA
 zQmOxaPeh74iYlwnsYHjj3ZBeiBPUif2MlYaoA1kJhEmzJnoDWHG7DnwXWxH3X71t6BCUOuH3Au
 EAtQnVFiiDB1HZV9rTKAiGSeo6hD7za7n2IxvYU9/DTxRt3u+OQ2hijxfDKYNylJe9JoWiu/Z/9
 kfcFp9ngTmI5KQhrq3W4T2Uo9rjXnmGMSRBUus05LrCLlUx7bgVQPCSJlSTTlVEFWBsmedzritk
 KogwJwO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index eb7682fa4057..d85686d55994 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


