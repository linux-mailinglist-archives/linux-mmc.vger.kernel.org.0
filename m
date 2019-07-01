Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21C816D96
	for <lists+linux-mmc@lfdr.de>; Wed,  8 May 2019 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEGWqp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 May 2019 18:46:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34049 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWqo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 May 2019 18:46:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so5308240eda.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 May 2019 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2SBXkPPsS90MxklCe6MIGlkttGdHW3kI9AU6dDeoWq0=;
        b=c8YCsFOL5XUurB/wLU01FUTlJ+LmbsoTAONIDSv6Ve2y9sfQIO00JcBoneTawrU37S
         ZxHXBrqZPJHAB7Y9fHXTTthRpBiTxbWYVk+FE08Jp0WYjYvYKAl5oBOeeH4MtBg/3L0C
         h0QAqHEOXzezLEUlvcU8JoSmAFNwDCBsNmcWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2SBXkPPsS90MxklCe6MIGlkttGdHW3kI9AU6dDeoWq0=;
        b=RsIBu4hVBxYym6f4UG/f9GSAHoHminyrVTHUG1GSMPnXCOfuuYEXHEmkbQpFemhxMY
         Sh4fhvYdedxh8ChsIF924FzR3LG3/orlg9DYd7cVNsaujmBEpsVKyVnHuY0Q0AwJH3Bp
         bVuflIGPxhrDtVJ8gK3Ec0qDdVnkgDjFUGgACYxZEa6a+NdAv6IgdPIr9da8Wm8JxKVH
         Za0TkEdxNwEsdgqkeINwrGSX+d2gvGPYR4RsH7C9QDcYWnm/ZFZlA1Uf6swNiRdCtF26
         PdcNcf4FnHRXw9IjuxeG4uqHOXei9E527WBshrjn5Y63WyPQCH/2CxMTvP3hcg/pb/yG
         3Dcg==
X-Gm-Message-State: APjAAAUjfvdvVc3tyFvLF6GPlhUBGYE1h5nsYg/tBKz2I5H1xEONcyKM
        kdgDSz11+zzgSXJ4n/5yim3xMA==
X-Google-Smtp-Source: APXvYqyXCGYgKhd7HiuSIvjEImJkx/UgMafy843ubjLvtfYY0p7CumAUjx/69TyceblENiM727jj+g==
X-Received: by 2002:a50:c201:: with SMTP id n1mr35712206edf.244.1557269202927;
        Tue, 07 May 2019 15:46:42 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s53sm4603529edb.20.2019.05.07.15.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:46:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data
 hold time problem
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
 <20190506170115.10840-3-scott.branden@broadcom.com>
 <673b3d25-0256-9cd7-c89a-673546e69f3a@intel.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <293b4f12-c74f-35fe-80d7-fdb25405e499@broadcom.com>
Date:   Tue, 7 May 2019 15:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <673b3d25-0256-9cd7-c89a-673546e69f3a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 2019-05-06 11:31 p.m., Adrian Hunter wrote:
> On 6/05/19 8:01 PM, Scott Branden wrote:
>> From: Trac Hoang <trac.hoang@broadcom.com>
>>
>> The iproc host eMMC/SD controller hold time does not meet the
>> specification in the HS50 mode.  This problem can be mitigated
>> by disabling the HISPD bit; thus forcing the controller output
>> data to be driven on the falling clock edges rather than the
>> rising clock edges.
>>
>> Fixes: f5f968f2371c ("mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read")
> Is this fixes tag correct, because it doesn't seem related.  Maybe explain
> that in the commit message.

I chose this tag to assist stable kernel maintainers so that the change 
does not produce merge conflicts backporting to older kernel versions.

In reality, the timing bug existed since the driver was first introduced 
but there is no need for this driver to be supported in kernel versions 
that old.

Do you want me to add such to the commit message?

>
>> Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/mmc/host/sdhci-iproc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> index 9d4071c41c94..2feb4ef32035 100644
>> --- a/drivers/mmc/host/sdhci-iproc.c
>> +++ b/drivers/mmc/host/sdhci-iproc.c
>> @@ -220,7 +220,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
>>   
>>   static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>>   	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
>> +		  SDHCI_QUIRK_NO_HISPD_BIT,
>>   	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
>>   	.ops = &sdhci_iproc_ops,
>>   };
>>
