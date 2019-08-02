Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E7FC3E
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfHBO3x (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 10:29:53 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:14434 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfHBO3x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 10:29:53 -0400
X-Greylist: delayed 1341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 10:29:50 EDT
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x72E3ord025718
        for <linux-mmc@vger.kernel.org>; Fri, 2 Aug 2019 15:07:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=iFSu/3xhsREO+opeaxzoNT99K5JOgKJJMEXiiqM/TCo=;
 b=X2uCLjfv5AZ7aFnl3M5B4o1urFXPCUjYjemQlDz2erS3dy6VW42R5cpEkBuctqs0tL1y
 E5QwWLNIqBQZCqL5oD14UjFzimCGL4rUs7FhDuuh3vzZiMCzXgPrRKumLsUbWh8CcAQm
 d1Uu1WpL3nzqST3NLzHPBsGo4uNuoI8NEl5gBuwpKt8K2Kqpk+bjt2f4r1S5Mlyg/kyG
 1ymgiViIpl7ndCrFVhIK5uzwFvDiCYb+SVr6GPrQ8QtTSKkPAgyv81YbvZevMkKihSoh
 ddn0H0a0QMleNLbC7jnxUpL22ACPnheTby6Rw4RI/G0K2wLeo+1JWAQtGZ3488a1TP++ +w== 
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        by mx07-00252a01.pphosted.com with ESMTP id 2u0c12k1et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 15:07:28 +0100
Received: by mail-wm1-f72.google.com with SMTP id f189so18212991wme.5
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iFSu/3xhsREO+opeaxzoNT99K5JOgKJJMEXiiqM/TCo=;
        b=WdD5Z3du814+xRLnIsidgBhGGKejk9h5Y4w9vM4YN2C9l9tbp/7d3+H5ouFLO3rZxc
         ojr6vmR9ZBnRPSlX6I1jo25Nuz9tMNbczPOu3mkY5TSML5RnOjxfh7/dBzjQaZbckINl
         pHtU8BQBOZ1h3uVDldq28asuaTiF747Qg5mRGHBJNCaam547MpJ5Z6RvxKkVu+jXVMts
         c7pSnf4zHDMlqJb3Gr3dSGdPjO6V7QPwb5ldVaOWB6L3p4RDxoeniJd3KTgdgtIwY3Yg
         lXFF1UhV7cJ1mguRhEWh8lzrFQ8pcjjzEebns0PDLmo+L+BuLjma4B+VAY4V1yaKPvwG
         L0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFSu/3xhsREO+opeaxzoNT99K5JOgKJJMEXiiqM/TCo=;
        b=B6iCi8gyW0Dg8hCHSHB+jz7oQ5f/iuSblCq6gBrS0iO4VdG3cpruBxhCdy6vMnA0rH
         Tuli+7yP2+rHUfCDGOCVyzGHjo19fujLOOXSmapYWXGZx0oyI3flGY1sQAYtFuPUITA3
         qSJaCF4GP35bSy1kA+8ocP8xUchGXmEAE0DLHSeEhJkzb+SSWQQbZqorCiHolTYJg+DR
         Q4xWqJhm+lcsP7EfAa/mz9KXUnwUF/+u3G5r6Q6deNbg7leo2Grr/2P6nHkFvBN2tP8e
         yBrwKGoKZcO/ADezmQ3BqRkG2GGOgs2860MV0xLEz4cz8I0CRJ0FwSExVZcozPMGCeGf
         PMzA==
X-Gm-Message-State: APjAAAUDuT2YfptcTyT5pS0bEyY2MzZkPTrLpOGgDcwB/AtTWlUcPn71
        E+l6l3Jupz3qkO9KF8HkC3KswtfzzPdlnusoOFeCZIAHC/S5Vr1UYTOYxmdKmPrQpCgjHFpPj+w
        AYppXUuBEvFWdiGxrIu+L
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr4722673wme.29.1564754847232;
        Fri, 02 Aug 2019 07:07:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzt8z1T4ItbBKrJd0OPJEF0NkwZcXdavtOELys9g11vFaV8sepLza65efqhA9j/NMU1KR1qQ==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr4722658wme.29.1564754846952;
        Fri, 02 Aug 2019 07:07:26 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:e0dc:854d:a530:264f? ([2a00:1098:3142:14:e0dc:854d:a530:264f])
        by smtp.gmail.com with ESMTPSA id o3sm63034868wrs.59.2019.08.02.07.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:07:26 -0700 (PDT)
Subject: Re: Possible bug in sdhci_set_power_reg
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
 <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com>
 <54d45628-14f4-514b-f5cb-18bf4f7baf63@raspberrypi.org>
 <CAPDyKFpKAaeLtppQAv5O1CW2FcF5Pa=-k+PEr4ppO-Mc6RN3-w@mail.gmail.com>
 <517ff814-07ce-bda5-ac13-d10fae195c25@intel.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <a914e8d6-c9d1-dc20-546d-cfe0b5eda175@raspberrypi.org>
Date:   Fri, 2 Aug 2019 15:07:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <517ff814-07ce-bda5-ac13-d10fae195c25@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-02_06:2019-07-31,2019-08-02 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 02/08/2019 14:48, Adrian Hunter wrote:
> On 2/08/19 4:28 PM, Ulf Hansson wrote:
>> + Adrian
>>
>> On Fri, 2 Aug 2019 at 15:23, Phil Elwell <phil@raspberrypi.org> wrote:
>>>
>>> Hi Uffe,
>>>
>>> On 02/08/2019 14:15, Ulf Hansson wrote:
>>>> On Tue, 30 Jul 2019 at 15:17, Phil Elwell <phil@raspberrypi.org> wrote:
>>>>>
>>>>> Hi MMC team,
>>>>>
>>>>> I've spent some time trying to add a regulator to control power to an SD card
>>>>> (vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
>>>>> I found that powering up the regulator during the boot process was effectively disabling
>>>>> the SDHCI controller. Note that this was despite having regulator-boot-on set in the
>>>>> device tree.
>>>>>
>>>>> The problem seems to be in sdhci_set_power_reg:
>>>>>
>>>>>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>>>>
>>>>>         if (mode != MMC_POWER_OFF)
>>>>>                 sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>>>>>         else
>>>>>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>>>>
>>>>> This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
>>>>> register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
>>>>> Select bits to 0b000 (a reserved value).
>>>>>
>>>>> sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
>>>>> select bits, so I found that (in my limited test cases) replacing the if/else above
>>>>> with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.
>>>>>
>>>>> Can anyone tell me what I've been doing wrong, or suggest a better "fix"?
>>>>
>>>> There are other sdhci variants having the similar needs, hence we have
>>>> the flexibility available via using the optional ->set_power()
>>>> callback.
>>>>
>>>> Have a look at sdhci_arasan_set_power(), for example.
>>>
>>> I don't understand. Can you explain what writing 0x0001 to the SDHCI_POWER_CONTROL register
>>> is supposed to do according to the specification? And why is the Arasan SDHCI implementation
>>> not the default?
>>
>> Good question, but unfortunate I don't know the SDHCI spec in that
>> great detail. And in the end, it has turned out that variants seems to
>> differs in regards to this register.
>>
>> I looped in Adrian, to see if he has some comments.
> 
> Different hardware works differently.
> 
> People have already fought, won and lost over how the power
> should be set with regulators, so now we have ->set_power()
> so everyone can do what they want.  Please use that.

Understood. I don't want to reopen a religious war (much).

Phil
