Return-Path: <linux-mmc+bounces-2517-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C590641F
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Jun 2024 08:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911E61F235CE
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Jun 2024 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB338136E38;
	Thu, 13 Jun 2024 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKzbtlhs"
X-Original-To: linux-mmc@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5B132133;
	Thu, 13 Jun 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260522; cv=none; b=jFh2w3PiGb6xpoMQldykhBIVqniu2A9YMm/3KbGpyJpFSFcTfyJMROoiaTN3bsC8m5AU9oCqOwVRvTukKUsTSudYsOKSAmLsjWar7FCfTePUOcuvkTaGI4OaFZnpMd173NzGHgV+xNl8IlPLPYLszNhwnUS3lwGIw+wY0k0pBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260522; c=relaxed/simple;
	bh=wDqi4jE6ey9mCMPc4VS0GW1B7gFNKdAy5tWUVtXQP0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE9IFgI+hruxk8vH094UDCl0Qc6dJm0ysllMFLHasgNXn9QB8/o/6oHMERFladsvwCWTQzpaKapfiLPww6Y8BJ0YmqOhqUO/6P6UmA7fctS4cr9imzmQjtufGAt7CQA2UISHaaNpW2NAQK0Y3v9uqdpPQVH2osNDwxc+pIeuwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKzbtlhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2295DC2BBFC;
	Thu, 13 Jun 2024 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718260521;
	bh=wDqi4jE6ey9mCMPc4VS0GW1B7gFNKdAy5tWUVtXQP0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mKzbtlhsrIO8X1BueC0jqDAqHSGi8+fHbKSTxyy/ocF3TA0kOWPIwAsErTlxr40ft
	 VbC6ozKSa3C+0Ns8aEPSz5uYdrEx0ydGbIOETVXEVLrCOfBx54i4mnsVq0X6tUR6NR
	 rMYLmnYN+S50c+SFb/TuWQWahXNwd+DYJuaiIkRf7UHpFi1b7t2go+dB2aQ7XgodCA
	 uRfKYdUkPvgJVPXAKNaPavdlhcjYg8BeP9ezmtCdqb2s+hs0wA73tQUk/ur1ojNhY6
	 glxzF4QxYUoQJbm2V+EshbfBvQHJJWrUq6WCuEFwD4XaHvUVFcbmaZW7mhbgbZmHcz
	 BsLitIRLy+YDg==
Message-ID: <019a6515-0df0-4075-9410-6fa32937643e@kernel.org>
Date: Thu, 13 Jun 2024 08:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: mmc-spi-slot: Change
 voltage-ranges to uint32-matrix
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
 <20240611-ls_waring_esdhc-v4-2-d0d8a5b3f3cb@nxp.com>
 <20240611202311.GB3003237-robh@kernel.org>
 <Zmmyfna+DoAcYzHp@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zmmyfna+DoAcYzHp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2024 16:36, Frank Li wrote:
> On Tue, Jun 11, 2024 at 02:23:11PM -0600, Rob Herring wrote:
>> On Tue, Jun 11, 2024 at 12:01:47PM -0400, Frank Li wrote:
>>> According to common mmc core, voltages-ranges should be matrix.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>
>>> ---
>>> Not sure why it impact other mmc yaml's voltage-ranges.
>>
>> It's a quirk of the tools. When decoding properties, the tools only know 
>> all possible types. Types are global, not per binding. Sometimes it can 
>> be figured out, but cases like this cannot be.
>>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 17 ++++++++++-------
>>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
>>> index 36acc40c7d181..05815b837219d 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
>>> @@ -27,17 +27,20 @@ properties:
>>>      maxItems: 1
>>>  
>>>    voltage-ranges:
>>> -    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>>      description: |
>>>        Two cells are required, first cell specifies minimum slot voltage (mV),
>>>        second cell specifies maximum slot voltage (mV).
>>>      items:
>>> -      - description: |
>>> -          value for minimum slot voltage in mV
>>> -        default: 3200
>>> -      - description: |
>>> -          value for maximum slot voltage in mV
>>> -        default: 3400
>>> +      items:
>>> +        - description: |
>>> +            value for minimum slot voltage in mV
>>> +          default: 3200
>>> +        - description: |
>>> +            value for maximum slot voltage in mV
>>> +          default: 3400
>>> +    minItems: 1
>>> +    maxItems: 8
>>
>> From what I remember, SPI mode doesn't support voltage changes. 
>> Switching to 1.8V came much later in the spec. So it should be 
>> 'maxItems: 1'. Or better yet, make the outer 'items' a list (of 1 
>> entry).
> 
> I don't understand "make the outer 'items' a list (of 1 entry)." Can guide
> me how to write it?

voltage-ranges:
  $ref: /schemas/types.yaml#/definitions/uint32-matrix
  items:
    - items:
        - descr:
        - descr:

Best regards,
Krzysztof


