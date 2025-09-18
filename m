Return-Path: <linux-mmc+bounces-8426-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A540B4574D
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Sep 2025 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633E117C51B
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Sep 2025 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CE34AB15;
	Fri,  5 Sep 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGexhjM5"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA5296BA6
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074186; cv=none; b=j0IaEltCBRawXu+8u4So3v0h+fLWSWAQ8K8hQbB9rEkahizweqZVMwu7Xpnm30vxSKzC5cdi1qYybwnrm5BIN8uszeQPY6lvhL5ycQRlswJNI8ATNDq0oYSPPwl2JD54FUBgqn96tsGnwB2Fm4MumnCqI0w1FOLULMbg6p8cwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074186; c=relaxed/simple;
	bh=YHBkz0h0Rvf+QBxHBQvEoOTPIUgICyaTi8a6q5BhBOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6qsaD7G1I3neKT3gF239Sk9RMf0QeT6mBOwpzD8PI+Ak7YPVzRoUCOe5IB72/toEkHPMFTJPYX8bXGpiXEJutSteaQtznOBUlSOwCyw+ISJMZM6H254byFw9SzsiNFtq2B+WZtbmhEhzgOHbZjmHocLF/eU+WOn05faGK/4CQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGexhjM5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857bgPo023899
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V7ghSLZ7heKhs650IbAjk8nclyw1JeB2lIG1BpFKJVs=; b=IGexhjM5a/NcGRFU
	RYU2LhDskGj2CGBjAOpoBE0WjJRvqGwcGd2HzwHJbT7lk/0b5e8IGJrStHqnXJJn
	Kj6KfdUhKsTXhjQPJh9XmCSMIMoA12C0IzKMBzYZOHgkqjxvCwVz+3v4U7rbH34J
	8JMl34fntONWURRhf8MNHMJamDzuyllkoZLkxqyO+VMTLasqm+ni005ReUrcXCen
	PA/V25XUuD3HXfZcgNK41y8SR611oZfu7dQfjk3L1S4e9j3gO7kypAWy7GuJI2hp
	izI+QLtxPgP1DHkK/TP3F0OKajz65ckUuGYaDNOQbTuB388QUE7FSdzwgm5G5JCV
	UX3hQw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ftwv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:09:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b307e1bef2so5827721cf.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074181; x=1757678981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7ghSLZ7heKhs650IbAjk8nclyw1JeB2lIG1BpFKJVs=;
        b=h1GXchHdUxtqKhTdK7SzkX1ETyIQ1qo3okaIA78IFYEX0yomAaIjwuhZEw6U3DTMfT
         09+y0jxJ2bmqjYNtArYiD5dvOdH2uKeeuO0AOndDPI6yoS+5tYtMYaJE1vwM6bZBpsd8
         83ypf0Yjm5VtTB9M7fbKi0tHYgRW0MUb++/6bOwE9xOFPlmHfEC1jpArCMA2K8Tv0h//
         PPazh//nKgYbAlZRudD/A/gRODF0KYVzlUC3Cy46nfDM9yAR+dnt5kiT7lczMEBjzJbl
         iIZ7uUjjlq3z9xRrpdFM9c8lIiWbhcI3cWdTqo108KYUEvCBaI8TsEcQ3N+aIjWje7HS
         DU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu2O5pzjzZazYK8Wxvoyd8Ck9z+pTFHOyywcEdUB/9QyO9TkKC4qZ4057j42Y8Y/jK1xOyrH5V/TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUa5Xw4oUSXi/vwpgl1CMvjeqhhcNfZ2z76u1Yssvi2/0Hf8zO
	AV05LSKWzGD4d2nyFsj4r7SgFJxY5jfRGub2g1txYmpPvKch/PSdhBnVLxMELu0Z25PyFNrYGY2
	dPWxbU0EHxwGerhHQM5n1gSa6D3ukaaPP4YNi8IzuUYbLeVVfpaXRFa7qqa5tqhc=
X-Gm-Gg: ASbGnct3CqboCPjdY81mLaAkjHDux80aUmbFIOPLKTJJT5iiSj8KJxcSwlyWOjuGkU7
	TTzSFgRx7MJh0ZeIreAa9AKizt34D9HbR6F50g56m3TGYfaDEK2Zm58iBMPRKTPnx9zc3vDr37U
	Jj3o1I3487zk+oCxlkeZ2KFapny/t0Cr+hGUB+3c939ydUTuhYghu/E8MCbOIlgxmZVh6gCO0J7
	ijcd/mna1dOLrxZWotlnbtWIDWyYIv/ykgpw6KSTrAieF75pRBW3+2s2Hy2ZrxThrxm4LaV/sHe
	WFbmqvi33X1yvzqhUUAzggjZuuIn3mnnUUh3qn4CdcozFzEmlc3WAYwugrPSwW1s5ryTtAjsfrC
	qd2pgDHYw5KWAFV5KhsCGJw==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60014621cf.2.1757074181555;
        Fri, 05 Sep 2025 05:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/PGqXh2InjZaarOb7O9uqOEso5Jemelf0KIpqlrqz5P8qaKxyNGfd6p3aVvjCmjCOCb3Hsw==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60014111cf.2.1757074180997;
        Fri, 05 Sep 2025 05:09:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040a410817sm1487836266b.101.2025.09.05.05.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:09:40 -0700 (PDT)
Message-ID: <9694f896-e1f8-427f-bdbf-225706338b7a@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] arm64: dts: qcom: lemans-evk: Enable SDHCI for
 SD Card
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-11-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-11-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX1jvL4pEDaWMj
 5Zv7TEC1At0tqhA4yGrxBs3evaXGJUwAQy98v8xefxqGmg6JZalYD2gvBODL2oCmdEV53+QaAOM
 H+x7OCJOa3Sv5RULJ81BKTDlMjWj27SdCSOyw3+p9yxrVRbS/8lruoyIkqCqIl6DK+vK4zcUENL
 CS65KwmVzu1TV+v0trVAWG/rK2u+yx5Dxzh+AgoB2CueI2QGb8wZBt9HMyqUf8Tg6cKBXpkXf/9
 FhciW0uAjEaaEpGygkr+A+caRMpmpkRS7XpzbXqn/DXWuxSDLNCWnBBMvV/vr+ym3CFiqPrBLXK
 FriR13X7qwPF7vSOVeWz2isUa4MJMJ77MgdwyNMh6FxOyuW5aNppdND6NgcTztAxgqzsYCORmmJ
 Y0JT6j6A
X-Proofpoint-ORIG-GUID: CkcpD2a6rmFC69AeB75tTOcNikef9EeV
X-Proofpoint-GUID: CkcpD2a6rmFC69AeB75tTOcNikef9EeV
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bad307 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3hZAb_iNorm4NPqi49MA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
> to support SD card for storage. Also add the corresponding regulators.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

