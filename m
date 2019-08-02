Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1B7F8F3
	for <lists+linux-mmc@lfdr.de>; Fri,  2 Aug 2019 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbfHBNXa (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 2 Aug 2019 09:23:30 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:40856 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393975AbfHBNX3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2019 09:23:29 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x72DNQWq028417
        for <linux-mmc@vger.kernel.org>; Fri, 2 Aug 2019 14:23:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=paLPEw1mlwm4egB9J3lPe7PUQfAwf8T7gHKjC9LPjEw=;
 b=Cai7tNAXYFgJgdIEK3Wb3xnGPXJipv5sEHrEurRnd1ozcPhsHxfprMwg8RVZqpxPuJB4
 XxDigj3EmFJzmSvDwlXYj7VwLtFJHUPuj/BXW4nK7mYixjIL1WllK9RXCqs5PT4zmN3d
 Mr4LEJ1pyCbG6pFtERBDTYl6HIhZPbYbqzdDKdAUw0D4kFlBuyVhPBelvpgRzMY556l/
 yuFbgq9O2vMcUBrdGgQYm/Nm/g6j3m3gi9AEYeiDqibwr6rjA1w0Dr7utW+ZF3NhF42f
 AGGxnLLfOldDnd+RLhxkY9tQd8u0lb34FMre2uyO2PgptEy+IyUQ+bkBKSBp7Rciwuej 3Q== 
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        by mx08-00252a01.pphosted.com with ESMTP id 2u0b3gbbfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 14:23:26 +0100
Received: by mail-wm1-f72.google.com with SMTP id t76so18160355wmt.9
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2019 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paLPEw1mlwm4egB9J3lPe7PUQfAwf8T7gHKjC9LPjEw=;
        b=abV7oYAjogRh1a5ct8dauikMrU/LJGzlqHSEIZwLrOW37FWv5A8rjSohJz69zyE9q6
         M2jZtQFTd7YYLY9HAssF64SU02QbK5h156f6aGELoxtsUEJ57qwEkiMV2QqFarGS/jjs
         HHYn4xUFK6Rtf+aDZUqYHULKB+Ya8btdPALzbpiehJhfSmPUoOB1iOV5lghajDaGZ7KR
         UrOfscT9zCGL5bo6/ElWAXVYS/7AUKnASp3RNlwE+LJb0JPLEDEYjD+GiUgxdbmUpcCe
         znTaB4j3Exr6U2EMUnJL52lHho445rdOdO8VAwpr5sHe5uGRuBScBN7pgJHeUeA6CbaM
         eCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paLPEw1mlwm4egB9J3lPe7PUQfAwf8T7gHKjC9LPjEw=;
        b=bBLCdtbk20eHSUyCpukoeDsTHhZxg46z88ATb4MVfRAreZlZqps/4fOMg6pmdMd8K3
         wb+jPorwg9xnHaihU/5+JrMC9Uk4Lmwxw2FrDOUR4E+Nyee8Tr1SKmaADUrBok8xlTDh
         MbSwgTgCiweYT8ply6PMEXuaVT4F1LvBiXA65epm0CuQZ8/wYhS/+ekOXdbpQpdBjoxJ
         QXEwFIBL8nstULn5xUNiJBxGibJt4moo1Udd8saItoSSU1xTfVNFmJxwcr7CHaBqs8Gb
         7nB6QgQ66o+jUoczScXabfwTG8kl8qac7SAMo/+YB6NLFq78PYq5bV4d7aEwkkOgQTUM
         2vqg==
X-Gm-Message-State: APjAAAWDPTUTs3oT60zNn56qSPY4AuhzhAgYSibVOi2bQ2ysLGVyX7IK
        62hoN/07vTtuDZZSknQWu19trDGSxQSxVrf9QaBDtYLa8yZsg2Mynhe5UPa3lQys96cR09278Fj
        ZMKO15ElpnYGa12Seqral
X-Received: by 2002:adf:f68b:: with SMTP id v11mr79442637wrp.116.1564752204947;
        Fri, 02 Aug 2019 06:23:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymsSLwz4s39tAmJp0xk04YMql9+QZKhYa0UJWTcKYLPIWKjpsA9s5iFED5TJoiO4hvZOpZzA==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr79442626wrp.116.1564752204663;
        Fri, 02 Aug 2019 06:23:24 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:e0dc:854d:a530:264f? ([2a00:1098:3142:14:e0dc:854d:a530:264f])
        by smtp.gmail.com with ESMTPSA id i13sm68813901wrr.73.2019.08.02.06.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:23:24 -0700 (PDT)
Subject: Re: Possible bug in sdhci_set_power_reg
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <75156391-9ca7-2140-9db6-6c3e65d1f278@raspberrypi.org>
 <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <54d45628-14f4-514b-f5cb-18bf4f7baf63@raspberrypi.org>
Date:   Fri, 2 Aug 2019 14:23:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqbZYR1apZQY9NbHb1d9LdeHMchHjmMKnPzzRZqosh-Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-02_06:2019-07-31,2019-08-02 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe,

On 02/08/2019 14:15, Ulf Hansson wrote:
> On Tue, 30 Jul 2019 at 15:17, Phil Elwell <phil@raspberrypi.org> wrote:
>>
>> Hi MMC team,
>>
>> I've spent some time trying to add a regulator to control power to an SD card
>> (vmmc-supply) on an SDHCI-equipped system. After a few false starts and red herrings
>> I found that powering up the regulator during the boot process was effectively disabling
>> the SDHCI controller. Note that this was despite having regulator-boot-on set in the
>> device tree.
>>
>> The problem seems to be in sdhci_set_power_reg:
>>
>>         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>
>>         if (mode != MMC_POWER_OFF)
>>                 sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>>         else
>>                 sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>>
>> This looks plausible for the MMC_POWER_OFF case, but setting the SDHCI_POWER_CONTROL
>> register to SDHCI_POWER_ON (0x01) has the side effect of settings the SD Bus Voltage
>> Select bits to 0b000 (a reserved value).
>>
>> sdhci_set_power_noreg() includes logic to calculate the correct values for the voltage
>> select bits, so I found that (in my limited test cases) replacing the if/else above
>> with a chain call to sdhci_set_power_noreg() was sufficient to get everything working.
>>
>> Can anyone tell me what I've been doing wrong, or suggest a better "fix"?
> 
> There are other sdhci variants having the similar needs, hence we have
> the flexibility available via using the optional ->set_power()
> callback.
> 
> Have a look at sdhci_arasan_set_power(), for example.

I don't understand. Can you explain what writing 0x0001 to the SDHCI_POWER_CONTROL register
is supposed to do according to the specification? And why is the Arasan SDHCI implementation
not the default?

Thanks,

Phil
