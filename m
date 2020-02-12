Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8745915AAEA
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Feb 2020 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBLOZD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Feb 2020 09:25:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgBLOZD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 09:25:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CEMfgI007316;
        Wed, 12 Feb 2020 15:24:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Ul5U4JnsKdNmEi3zgXkmqolNfELjrXXBFtdayobnqWQ=;
 b=0DrV3avGcuue7DYCgPNTBGMYgnQUHNksrhDWaq4Rm2BbrN5wWPIeMtHHftpm5MEdNtug
 N2XTMX/EEevDvo8KhVi3VQCyEhIhLgdT18lAd/Itic9+t6WsE3qwko7hFqb5Veefdebp
 FqbR6zLn8QCCca6+ZnmqBkg148cg2mVEojQqCj0gCfFB/SPRWFcjyZfnV6QF9nJtOsxy
 oNw6rAk6CIYaLkLlpgjmCQEOwk4S4FERN0Y6INbl9XqQihuv8dkHOWyR8dVuV/POS3/F
 7JERYiTGHUCixEXROtE8uKQLIxwr3IYyIb5OhZRV5I0ibJ0UHNTTXt+0AJe0XEKE6V6+ cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ud9xtf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 15:24:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 868F0100038;
        Wed, 12 Feb 2020 15:24:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 73B7A2B5877;
        Wed, 12 Feb 2020 15:24:39 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 15:24:38 +0100
Subject: Re: [PATCH 01/12] mmc: core: Throttle polling rate for CMD6
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <20200204085449.32585-2-ulf.hansson@linaro.org>
 <7d6dc452-6ede-94d5-6bd6-fe1d5f4d28da@st.com>
 <CAPDyKFoUe-9HAz1SaCXGUss=GT5JuOVZpZYLmbUFi6Ee34O92g@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <788f33c1-6051-0adf-42da-6f98e69d71c5@st.com>
Date:   Wed, 12 Feb 2020 15:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoUe-9HAz1SaCXGUss=GT5JuOVZpZYLmbUFi6Ee34O92g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_07:2020-02-11,2020-02-12 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Le 2/12/20 à 3:18 PM, Ulf Hansson a écrit :
> On Wed, 12 Feb 2020 at 14:51, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> hi Ulf
>>
>> Le 2/4/20 à 9:54 AM, Ulf Hansson a écrit :
>>> In mmc_poll_for_busy() we loop continuously, either by sending a CMD13 or
>>> by invoking the ->card_busy() host ops, as to detect when the card stops
>>> signaling busy. This behaviour is problematic as it may cause CPU hogging,
>>> especially when the busy signal time reaches beyond a few ms.
>>>
>>> Let's fix the issue by adding a throttling mechanism, that inserts a
>>> usleep_range() in between the polling attempts. The sleep range starts at
>>> 16-32us, but increases for each loop by a factor of 2, up until the range
>>
>> Just to align comment and code: in the code the first usleep range start
>> at 32-64us.
> 
> Yeah, good point, thanks. I was trying different values, but forgot to
> update the commit message. :-)

I tested series on mmci, sdmmc variant with/out MMC_CAP_WAIT_WHILE_BUSY
and it seems OK

yes, I reviewing the other patch of series but for this patch is OK.

Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

> 
> Other than that, does the change look good to you?
> 
> [...]
> 
> Kind regards
> Uffe
> 
