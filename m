Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9E13D6B6
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Jan 2020 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgAPJVV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 16 Jan 2020 04:21:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35560 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbgAPJVV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 04:21:21 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G9CnvH019865;
        Thu, 16 Jan 2020 10:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=oXdqzOpECkceymNrXiBm0gzyy2jK6pABw4YC8ToVezU=;
 b=LMueDRVNZKKBRk7fSc5+0a3lqbIPoJPBRTNrEgkh4C1ln5yOoQPN+tqH2sPOEu2EGXX7
 lRHlD9VVCTqquV6qsTeLW3QbpLkk2UxWKBtLOtZ2L1iqzSFXSZvyLsRFVdujE7J08L5I
 tQdLg9dbTxjs8mWkym5Y3Nqo49WhML66pez9GPL0cqdNSuAcDBLqMV6La8GbLAtfI+/u
 aTgHKn+fe5ebXVHPS5+8jOPZNnkwQMVzuEhX8r/ruGCpD5DbAV6KLFigrnZo9gN+CMta
 20YLGfb5MbuGarnghgi6Uxqje3JdGYOU8rDJ8dU+cPokjeAKr3gPWWM43LnU2KxCHwXI yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7jpr5pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 10:21:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF267100034;
        Thu, 16 Jan 2020 10:20:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB8B62A900B;
        Thu, 16 Jan 2020 10:20:58 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jan
 2020 10:20:58 +0100
Subject: Re: [PATCH 5/9] dt-bindings: mmc: mmci: add delay block base register
 for sdmmc
To:     Rob Herring <robh@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
 <20200110134823.14882-6-ludovic.barre@st.com> <20200115145645.GA599@bogus>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <2ce63f11-8b0c-8261-63fa-cd19e874c537@st.com>
Date:   Thu, 16 Jan 2020 10:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200115145645.GA599@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_02:2020-01-16,2020-01-15 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob

Le 1/15/20 à 3:56 PM, Rob Herring a écrit :
> On Fri, Jan 10, 2020 at 02:48:19PM +0100, Ludovic Barre wrote:
>> To support the sdr104 mode, the sdmmc variant has a
>> hardware delay block to manage the clock phase when sampling
>> data received by the card.
>>
>> This patch adds a second base register (optional) for
>> sdmmc delay block.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>> index 6d3c626e017d..4ec921e4bf34 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>> @@ -28,6 +28,8 @@ specific for ux500 variant:
>>   - st,sig-pin-fbclk       : feedback clock signal pin used.
>>   
>>   specific for sdmmc variant:
>> +- reg			 : a second base register may be defined if a delay
>> +                           block is present and used for tuning.
> 
> Which compatibles have a 2nd reg entry?

In fact, mmci driver is ARM Amba driver (arm,primecell) and has only one
compatible "arm,pl18x".
The variants are identified by primecell-periphid property
(discovered at runtime with HW block register or defined by
device tree property "arm,primecell-periphid").

The defaults "arm,pl18x" variants have only one base register,
but the SDMMC need a second base register for these
delay block registers.

example of sdmmc node:
	sdmmc1: sdmmc@58005000 {
		compatible = "arm,pl18x", "arm,primecell";
		arm,primecell-periphid = <0x00253180>;
		reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
	};

what do you advise?

> 
>>   - st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
>>   - st,neg-edge            : data & command phase relation, generated on
>>                              sd clock falling edge.
>> -- 
>> 2.17.1
>>
