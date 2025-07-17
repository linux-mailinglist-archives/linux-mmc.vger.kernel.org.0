Return-Path: <linux-mmc+bounces-7534-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB3B08CD7
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Jul 2025 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2148F3B0AEC
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Jul 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAF2BE025;
	Thu, 17 Jul 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TE25JG2V"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246223371B
	for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755221; cv=none; b=WvusNUIHOGglL9qGGgzcBWsFAS4ad5NIiOu605zQcOfUktl4AWY5C9+tp6fyxxEgkSm3jzP5vrBb9Yi6EKMS40+HjwftJgvlqI1oPnIfnDBl3YNwaG1hvMrkGlrifO2ZU4nhoBfntfLBsrFSrNEr+ROQWGs6syIosNWYZI0TsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755221; c=relaxed/simple;
	bh=k1AU9RHb0Kl7CzIBQsz15cpKEvQJw6GvReja3qw8EDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6Hw8fm61wLypLdcYYxEuRMQUuUcIG2ZIAFgb1U1HbWot3KTgguxgdXbOZh7A8FP9gx0dj7DM965he2E2R1WuD/jPq9wcaqRc7EVs9JAuAEigpXf4dfnv2BSKIiqR0C79+Do4DkTWQPbUQMJNcwHBGxtzb0VJSFhYOLP7L7QBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TE25JG2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCB5PB015626
	for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 12:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IbmcROfOzVtWLlLwTUK701q3d6gz5yN28T/mfJ33MIw=; b=TE25JG2VN6qQdbFI
	+EPMUOzIJpT9ZbN4ZIkZATeVvy4GwUPV5dCscItU/HZvCgO6zt8HQRfg2IkbcAT+
	/bRkQgCwvhtEQkpUQScqWrWuB+LunPUpfuPEa9/YyBRJ5RWfX3dru0yV6Ck8UISD
	QAoil+qyBsfyp0uBtBYRio7QFWo2/NrN7YMfHYntO4dGtjiBDS77+iZmAJKB8y6e
	YY5aSsLonYn4nSw5GocPrVGB5jgSgad6gzeOGzIhTJX9yDqeuCq7Bma8SyfEsfks
	Qfhx/IiDic3dsw1TEgmCJWQ8dpS53t20P6vudUZXZ9KFyP8FslENwvzt4Q2JV/IZ
	SmDm4g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dytjk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 12:26:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fac0b29789so3473216d6.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jul 2025 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755218; x=1753360018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbmcROfOzVtWLlLwTUK701q3d6gz5yN28T/mfJ33MIw=;
        b=GWKGBpxvz8DipGy5yReHw7gTJCus+Ezeg5QaqHTU5LX8CuBONulNYO9JzagWBlhiLq
         0J28fc8wWVI/Xbd4Wr5cgOOm5wiT+ycMjHnAa0L61ZazBj95pobCv0ZJMW4jXoKPi4av
         Pzr6CS2DoEDFffoRiRubqRb0ohm+rpvT5DYP6lRRrSKNTtg4950xNUhHPbxCNEIhwKh3
         UaXOaGufugvgyGZLBhbyPPUm8GdAmQzpJOzmIklwVxPy8H/E6fxnfE5rhYpDEBx2u96e
         2tAg1K/z/e2RvA0jDIeH+nkeq31vlcPZMBZE+beARDwtPMNsvDxGSWLiwuwSxp5tJerb
         ZBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1xnTRYGd4AA1tE+ZiQUGSN14R7SC+iRaa671UALXES9vuTU2BySpu6AWEHOpdWAADKWfxNjUJ7Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNCVxNOssm/j4+3hoI8C3jI2QgTulOJHrstAt0aLNCcpTMyUf
	yERiCgs5uNklAODmrrKduQludHcbaP5dq5aKRbJ0FrY8HuWDvmOVwnIWFjYmVxQG3vNyAa1zxqf
	T/MWo98MCEbxPp+GMchvbRCs4isHfg1XmYhQKmGpGKdyjYhRxsWF8wwdiB3mdzz4=
X-Gm-Gg: ASbGncumbezmRPghteXQ7jj9TgGs1Ksvb5FLXFizfdOezd2dbTLLDoh9/TQLXQT8ofN
	6XLJ+qs7OGY5DYqKB3Zfo9rJD16UQyJ1Slp1tgsIM95JKi0C8Bu9FrQmHtzCjF4Cd+3wxL7V0jH
	UZE8HQ6zZe8td0vZmnUje8uRQLcboNaI3v7KisZK3UPFzcg1192akCCZdUMYur+3LYHREPqxrHl
	ccy8X+qB4eBCTZhXv0W8y5DIDYu21Aob+CMKUfGP+bIqwy6Q7WfyB2vs+TbYCitI1SGId6EnzKk
	ViUymW0BqygrEC9Var42gdvuDDCbVk6GbKcU1HvZeJOVJmSVqn53XhnUM/NwBVJMs5tjZTiy6P1
	x5L1fHKOH2yxvHRzd0i1L
X-Received: by 2002:a05:620a:4093:b0:7e3:302a:3e9d with SMTP id af79cd13be357-7e342ad54e7mr401314085a.7.1752755217792;
        Thu, 17 Jul 2025 05:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWMwBx+PyOHxTxgnaS5xzRvQae4iwC7dd8Cj0Sms6zoxQGp+IkrMAc/iJ+gLrK8J7XJbyIqA==
X-Received: by 2002:a05:620a:4093:b0:7e3:302a:3e9d with SMTP id af79cd13be357-7e342ad54e7mr401311985a.7.1752755217290;
        Thu, 17 Jul 2025 05:26:57 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee8d9fsm1336084466b.46.2025.07.17.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:26:56 -0700 (PDT)
Message-ID: <d25c3f81-38c3-4559-a1e6-7b586c817d57@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 14:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Zlxs4K-ygQVs8PQWGxK38l1KApumT2R8
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6878ec13 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8 a=6H0WHjuAAAAA:8
 a=iHGpd6SFZaqAm2lpoLIA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwOSBTYWx0ZWRfX95iWVSbgLuc9
 gWSTuhV2FhuUVjEm3U/rFzugtES4h8Rxt010gmGRB7AFiq/B3VX++V8Ulx5dVdJkYr8X53KnEXD
 EiHYdYebCeU2wcpXNeaf12VxcC185lPgSEK+/nBLAXre1Xxfxo0WlLpUYtIxNK/JIG3w8AOjqRN
 1+eMeTOYuY1reti0mZTxczRukB/NPD4yL3vkvaP663PKU9Y6mh3BMuA9dzrP6PdQ9knnp7rTkHS
 2imF5pEFmpFNRF1y58NqeYBI7mfQ6eZQZkUUQvEfsprirCbbHtKATDTo15jERD4YyneHtWie4ED
 EAu2mHgnttCnuYd1cnhIW5K5gpmHoW8YcILxZLeDk0/W7bQDz1caYqKZlJ6eGwbR/cbBNJRDoDh
 SZW8vPPrBH9j5goaOnbauu2FlxEZuTUWhE9gbKTIFYXKvh7O4IbD6iJbJq2x2jXqr5kusfqc
X-Proofpoint-GUID: Zlxs4K-ygQVs8PQWGxK38l1KApumT2R8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170109

On 7/17/25 10:29 AM, Luca Weiss wrote:
> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>> Add a devicetree description for the Milos SoC, which is for example
>>> Snapdragon 7s Gen 3 (SM7635).
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---

[...]

>>
>> [...]
>>
>>> +		cpu-map {
>>> +			cluster0 {
>>> +				core0 {
>>> +					cpu = <&cpu0>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu1>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu2>;
>>> +				};
>>> +
>>> +				core3 {
>>> +					cpu = <&cpu3>;
>>> +				};
>>> +			};
>>> +
>>> +			cluster1 {
>>> +				core0 {
>>> +					cpu = <&cpu4>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu5>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu6>;
>>> +				};
>>> +			};
>>> +
>>> +			cluster2 {
>>> +				core0 {
>>> +					cpu = <&cpu7>;
>>> +				};
>>> +			};
>>> +		};
>>
>> I'm getting mixed information about the core topology.. 
>>
>> What does dmesg say wrt this line?
>>
>> CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n
> 
> [    0.003570] CPU1: Booted secondary processor 0x0000000100 [0x410fd801]
> [    0.004738] CPU2: Booted secondary processor 0x0000000200 [0x410fd801]
> [    0.005783] CPU3: Booted secondary processor 0x0000000300 [0x410fd801]
> [    0.007206] CPU4: Booted secondary processor 0x0000000400 [0x410fd811]
> [    0.008206] CPU5: Booted secondary processor 0x0000000500 [0x410fd811]
> [    0.009073] CPU6: Booted secondary processor 0x0000000600 [0x410fd811]
> [    0.010406] CPU7: Booted secondary processor 0x0000000700 [0x410fd811]

Okay, so the cache topology that I can make out of docs matches your dt..

As for the CPU map, we tended to simply throw all cores that are in
the same "DSU cluster" [1] together, represented as a single CPU cluster.
This is not what other vendors do though, it seems. And downstream has
the same silver/gold/prime split as you did above.

Looking at some docs, it seems like the prime core shares the cache
bridge with the gold cluster so I'm not sure how separate it really is.

There was a time when the MIDR_EL1 register would be more helpful, but
according to [2], it would mean that each core is in its own cluster..
For reference exynos2200.dtsi seems to have the very same MPIDRs (though
with cores that are a little older). One would expect the small cores
that share the L2 to be within the same cluster [3].

All in all, I don't know what to tell you for sure..

[1] https://developer.arm.com/documentation/100453/0401/Technical-overview/Components?lang=en
[2] https://developer.arm.com/documentation/102517/0004/AArch64-registers/AArch64-Identification-registers-summary/MPIDR-EL1--Multiprocessor-Affinity-Register?lang=en
[3] https://developer.arm.com/documentation/102517/0004/The-Cortex-A520--core/Cortex-A520--core-configuration-options?lang=en

[...]

>> Does access control disallow accessing these on your prod-fused
>> device?
> 
> Hm, taking another look, this property should probably be moved to
> device dts.
> 
> Downstream has this in volcano.dtsi but volcano6i.dtsi (QCM6690?) and
> volcano6ip.dtsi (QCS6690?) have a /delete-property/ for this, because
> they have PCIe available.
> 
> I don't think this has anything to do with secure boot fuses, but I
> don't think I have tried enabling these clocks on my SB-off prototype.

I wouldn't be so sure about sb-off being necessarily a difference, but
I wouldn't object to a smoke test either ;)

[...]

>>> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
>>
>> pdc 26
> 
> You mean replace <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH> with
> <&pdc 26 IRQ_TYPE_LEVEL_HIGH> (plus interrupts-extended)?

Yes

> I assume you got this from internal docs, but just to mention,
> volcano-thermal.dtsi contains GIC_SPI 506 (+ 507 for tsens1).

Right, I found it in the docs (but we most likely want the device to
wake up from sleep and try to power off if it's too hot/cold)

Konrad

