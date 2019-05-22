Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC62681E
	for <lists+linux-mmc@lfdr.de>; Wed, 22 May 2019 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfEVQWW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 22 May 2019 12:22:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1967 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfEVQWV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 May 2019 12:22:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce577390000>; Wed, 22 May 2019 09:22:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 09:22:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 09:22:20 -0700
Received: from [10.2.170.210] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 16:22:19 +0000
Subject: Re: [PATCH] mmc: tegra: Fix a warning message
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190515093512.GD3409@mwanda>
 <CAPDyKFpm9dB55aCUQkDHgyfcJdniNG9jCbdQ4ezYgQ=L8Rxfhw@mail.gmail.com>
 <20190522133709.GP30938@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <f8b4cc7c-6f12-21df-e76c-59699ff647b0@nvidia.com>
Date:   Wed, 22 May 2019 09:22:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522133709.GP30938@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558542137; bh=ZsC4IEtqXi/ZnetadpRadeyjRQPUySYWX9WQm/c9Zmk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=dCdc4EgVErMIs5/eTARulpqisVqeNKoibL2OjKtm8gENe+Hqc6W9ZQRoNEQNbsX9r
         +jiq78rvboYp6Yibk4j4W/YF/15Q/fCJx+b9Q+xASFTq+844LpBPMSjs5S618V+avp
         kd33pK9tEZhhe99nbOykvqpypk9fmZsbI+UU1iAmYRZbNRZI0cFGxeGuWToJkAKXpF
         E9LKuHB0C/yTAKjfZ86l2tWNHXF0UaJdi5BhY+cTN3Ie8r6Gd+oMxRNdl+n1Tz+5c1
         D/2lkmP+RhPkJqlzxp+P1HvfCCnJ/K3x+ZvnHj8kvt7nn6Sh7gGsPx4V6EOq/bxwMo
         h6vNyb3T3dGGw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/22/19 6:37 AM, Thierry Reding wrote:
> On Wed, May 15, 2019 at 01:46:40PM +0200, Ulf Hansson wrote:
>> On Wed, 15 May 2019 at 11:35, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>> The WARN_ON() macro takes a condition, not a warning message.  I've
>>> changed this to use WARN(1, "msg...
>>>
>>> Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>   drivers/mmc/host/sdhci-tegra.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>>> index f608417ae967..10d7aaf68bab 100644
>>> --- a/drivers/mmc/host/sdhci-tegra.c
>>> +++ b/drivers/mmc/host/sdhci-tegra.c
>>> @@ -865,7 +865,7 @@ static void tegra_sdhci_tap_correction(struct sdhci_host *host, u8 thd_up,
>>>          }
>>>
>>>          if (!first_fail) {
>>> -               WARN_ON("no edge detected, continue with hw tuned delay.\n");
>>> +               WARN(1, "no edge detected, continue with hw tuned delay.\n");
>> Not sure why this is a WARN*() in the first place.
>>
>> Seems like a dev_warn() or possibly a dev_warn_once() should be used instead.
> I think this was on purpose in order to increase the likelihood of this
> getting reported. Sowjanya knows the details much better, but I think
> this is supposed to be very rare and really a problem with the tap
> settings in device tree, which is something that we want to know and
> fix.
>
> Let's see if Sowjanya can shed some light on this.
>
> Thierry
>
This warn can happen when no edge is detected and hw tuning results include

all passing taps which is very unlikely. So, I believe WARN(1, msg) 
should be good to use.

Sowjanya

>>>          } else if (first_pass) {
>>>                  /* set tap location at fixed tap relative to the first edge */
>>>                  edge1 = first_fail_tap + (first_pass_tap - first_fail_tap) / 2;
>>> --
>>> 2.20.1
>>>
>> Kind regards
>> Uffe
