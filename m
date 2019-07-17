Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389DD6BC97
	for <lists+linux-mmc@lfdr.de>; Wed, 17 Jul 2019 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGQMvN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 17 Jul 2019 08:51:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfGQMvN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jul 2019 08:51:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HCkl7e004020;
        Wed, 17 Jul 2019 14:51:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=r/r7+emvc3EL+8PdZlaaAutTMo2pHkQmZvRrWLEzIBM=;
 b=wq6CRz4/87netkL3RTiaYXgWHxSnsOim2y00WpornR1pW7JmN4L9dNNuUTqEyRP/O0ll
 k674BVpwsoptuA2R+GriG9OXfGMR5pypfqFYdD9KDTpbgcJZeoZrBbJ6aWY/Ir+YNU7B
 wkDPfXF7C4Gfhv+/reOrdxN0+HJ61e7K7ALwOa6VuspyXquzIFEaaUad5+NiYel8y69G
 3E+zJo+sCGpL4wrRDGW96jCs7JeIsY8olvUIIszKRK6rFyd4wwiL9wg7hsduSHmdyZ9R
 4b34eGTyQPl2JIk9OQk3DHgfXaDQDQvA+//PIihKnWICx81UroIfVJOPmMOd9sIHcksG 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s1uked-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 17 Jul 2019 14:51:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD6763A;
        Wed, 17 Jul 2019 12:50:54 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B26651BD;
        Wed, 17 Jul 2019 12:50:54 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 17 Jul
 2019 14:50:54 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 17 Jul
 2019 14:50:54 +0200
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20190715164217.27297-1-ulf.hansson@linaro.org>
 <8b54d001-0c85-08d5-41f7-23a91522a5ce@st.com>
 <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <88dbabb8-a73e-e112-0fe3-33a831bb24ae@st.com>
Date:   Wed, 17 Jul 2019 14:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp+5e6s3_RtQeoaMZhzkDw0A0aage3kYOejJSjsxwJ8Tw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_05:,,
 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf, JN

IMHO you can't split my initial patch in two,
this piece of code is needed (function: mmci_irq)

-		status &= readl(host->base + MMCIMASK0);
+		status &= readl(host->base + MMCIMASK0) |
+			host->variant->busy_detect_flag;

Regards,
Ludo

On 7/17/19 2:36 PM, Ulf Hansson wrote:
> On Wed, 17 Jul 2019 at 12:16, Jean Nicolas GRAUX
> <jean-nicolas.graux@st.com> wrote:
>>
>> Hello Ulf, all,
>>
>> For testing purpose, I cherry-picked your patch on top of a 4.19.30 basis.
>> (I apologize as it's a bit old. I miss time to do a rebase on current
>> linux-next right now.)
> 
> No worries about the old kernel, for this change, I think it should be
> suufient good as base.
> 
>>
>> Unfortunately, I got a kernel crash applying it :(
> 
> Huh.
> 
> Is it crashing because it fails to mount the rootfs on the SD/MMC card?
> 
>>
>> As you may know, ST sta1295/sta1385 SoC embeds the same pl08x variant
>> than one in U8500.
>> So It looks like double-checking again mmci status to make sure busy
>> flag is still set
>> just before proceeding for busy end is required in our case.
> 
> Yeah, actually I have a u8500 on my desk now, so I will also test the
> patch to see what goes on. Didn't have the time to do it earlier.
> 
> My guess is that, at the point when we received the IRQ for a command
> that has been sent, and then reading the MMCISTATUS register in
> mmci_irq(), the card has not yet started to signal busy on DAT1 and
> hence the busy status bit isn't set yet. This leads to that we will
> never enable the busy end mask, but just completing the request
> directly.
> 
> Anyway, let me check and see if I can confirm it.
> 
>>
>> Regards.
>> Jean-Nicolas.
> 
> Thanks a lot for helping out testing and reporting the problem!
> 
> [...]
> 
> Kind regards
> Uffe
> 
