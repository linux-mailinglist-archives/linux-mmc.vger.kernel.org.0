Return-Path: <linux-mmc+bounces-4816-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E889D7C03
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Nov 2024 08:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B339B21A3B
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Nov 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D21143722;
	Mon, 25 Nov 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYBQeD2l"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF92119;
	Mon, 25 Nov 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520157; cv=none; b=Imgsk1TmFJQ1JEsQrmYBHfQAIDiz2J14zCYR6tc8OoSGuNQt8SiVcGC7gzDkHrETl8q5bc0a8bqTHcErQsuOD2iLPRTRbPYh6SeH5R/NSW0Q03M9YhrLz24I5tI1FFg6xWvqa0h6PJ/0Byt1pyqEn4i2y08MSpyxcnvHIZ6hbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520157; c=relaxed/simple;
	bh=lIaPAEe/5xyZbTdWkmRj4VZ5612+TEcRS6FQjnJseEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7V+my0fKGA9RnW3/wyv9tUduDW8OyA4QUz5nEs6D6yh5WlkVMm/bBA/cBWfS/b3Be3hEOCWAsGWAiOLFfO6pwdgLeiXO1fXyn+I2BNI5I2lTSDqFDgtZl15JV8Bur166mP5PKpbt2oJZ6babbBiCFe4hnzIfcYyMjxqmdMpWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYBQeD2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24433C4CECE;
	Mon, 25 Nov 2024 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732520157;
	bh=lIaPAEe/5xyZbTdWkmRj4VZ5612+TEcRS6FQjnJseEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FYBQeD2lyXCXlnVftx83jDZWSdgyZqUHTVvRuBTTDy3ezqkjuenzhlo7RjQlIUYga
	 rWnPEYdupRjS1RF7gQd3sot/WdPfTGREwux7kvSPTzgqdoqWnLsDBZ/11zNISIg622
	 2DdI/4lXHpOF75qE1mJipbudWC/4XDO2iklhURZzXa/4UFumF0X1+hDcJ3tGo/rWj5
	 bxp53OREGZo16QyFvy2D0qPufDY+fxZrAQT/B5oKGYzeue4K/Btk56h2zf+OEvJVOD
	 LRfhcUUqpk/O/150+4T5RcfMh19EQRriO+A6WwUKHoVGYCYqHRzlOFCc6F6I2cR/SU
	 fAaN5E+j/aXsQ==
Message-ID: <97a6c471-b146-4625-a3fa-93ee29be4c37@kernel.org>
Date: Mon, 25 Nov 2024 08:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhupesh.sharma@linaro.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
References: <20241122065101.1918470-1-quic_yuanjiey@quicinc.com>
 <20241122065101.1918470-2-quic_yuanjiey@quicinc.com>
 <f9b01690-8940-4f8b-b142-6c2ec4db3e83@kernel.org>
 <Z0BDYiVaLQXaMsle@cse-cd02-lnx.ap.qualcomm.com>
 <ccbc6324-0dcb-405a-901a-12dc33a8130c@kernel.org>
 <Z0Pe0B9LsjpRHkkS@cse-cd02-lnx.ap.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z0Pe0B9LsjpRHkkS@cse-cd02-lnx.ap.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 03:20, Yuanjie Yang wrote:
> On Fri, Nov 22, 2024 at 01:35:28PM +0100, Krzysztof Kozlowski wrote:
>> On 22/11/2024 09:40, Yuanjie Yang wrote:
>>> On Fri, Nov 22, 2024 at 08:04:31AM +0100, Krzysztof Kozlowski wrote:
>>>> On 22/11/2024 07:51, Yuanjie Yang wrote:
>>>>> Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
>>>>>
>>>>> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
>>>>>  1 file changed, 198 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>>>>> index 590beb37f441..37c6ab217c96 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>>>>> @@ -399,6 +399,65 @@ qfprom: efuse@780000 {
>>>>>  			#size-cells = <1>;
>>>>>  		};
>>>>>  
>>>>> +		sdhc_1: mmc@7c4000 {
>>>>> +			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
>>>>> +			reg = <0x0 0x007c4000 0x0 0x1000>,
>>>>> +			      <0x0 0x007c5000 0x0 0x1000>;
>>>>> +			reg-names = "hc",
>>>>> +				    "cqhci";
>>>>> +
>>>>> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +			interrupt-names = "hc_irq",
>>>>> +					  "pwr_irq";
>>>>> +
>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>>>>> +				 <&rpmhcc RPMH_CXO_CLK>,
>>>>> +				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
>>>>> +			clock-names = "iface",
>>>>> +				      "core",
>>>>> +				      "xo",
>>>>> +				      "ice";
>>>>> +
>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>> +
>>>>> +			power-domains = <&rpmhpd RPMHPD_CX>;
>>>>> +			operating-points-v2 = <&sdhc1_opp_table>;
>>>>> +			iommus = <&apps_smmu 0x02c0 0x0>;
>>>>> +			interconnects = <&aggre1_noc MASTER_SDCC_1 QCOM_ICC_TAG_ALWAYS
>>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>>>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>>>>> +					 &config_noc SLAVE_SDCC_1 QCOM_ICC_TAG_ALWAYS>;
>>>>> +			interconnect-names = "sdhc-ddr",
>>>>> +					     "cpu-sdhc";
>>>>> +
>>>>> +			bus-width = <8>;
>>>>> +			qcom,dll-config = <0x000f642c>;
>>>>> +			qcom,ddr-config = <0x80040868>;
>>>>> +			supports-cqe;
>>>>> +			dma-coherent;
>>>>> +			mmc-ddr-1_8v;
>>>>> +			mmc-hs200-1_8v;
>>>>> +			mmc-hs400-1_8v;
>>>>> +			mmc-hs400-enhanced-strobe;
>>>>
>>>> These are properties of memory, not SoC. If the node is disabled, means
>>>> memory is not attached to the SoC, right?
>>>>
>>>>> +			status = "disabled";
>>> Thanks, I think qcom,dll-config and qcom,ddr-config are properties of Soc,
>>> they are memory configurations that need to be written to the ioaddr.
>>> And mmc-ddr-1_8v,mmc-hs200-1_8v,mmc-hs400-1_8v are bus speed config,
>>> they indicate the bus speed at which the host contoller can operate.
>>> If the node is disabled, which means Soc don't support these properties.
>> No, that is not the meaning of node is disabled. When node is disabled,
>> it means board does not have attached memory.
>>
>> Move the memory related properties  to the board.
> 
> Thanks, Ok I understand, I will move the memory related
> properties(qcom,dll-config and qcom,ddr-config) to the
> board dts in next version.

What? Why are you talking about these properties? My comment was not
under these!

Best regards,
Krzysztof

