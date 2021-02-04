Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09F630F3AB
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Feb 2021 14:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhBDNIN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 4 Feb 2021 08:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhBDNII (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2021 08:08:08 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E215C0613D6;
        Thu,  4 Feb 2021 05:07:28 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DWf3J5MzLz1s46W;
        Thu,  4 Feb 2021 14:07:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DWf3G5DpDz1t6pd;
        Thu,  4 Feb 2021 14:07:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rMuKl75E9QlS; Thu,  4 Feb 2021 14:07:20 +0100 (CET)
X-Auth-Info: D0bG0TMQNvtHsjyTpMg0Mv2GMX5Ec5sREluid0wh+VU=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  4 Feb 2021 14:07:20 +0100 (CET)
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Yann GAUTIER <yann.gautier@foss.st.com>, ulf.hansson@linaro.org
Cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        ludovic.barre@foss.st.com, per.forlin@linaro.org,
        huyue2@yulong.com, wsa+renesas@sang-engineering.com,
        vbadigan@codeaurora.org, adrian.hunter@intel.com,
        p.zabel@pengutronix.de, swboyd@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com>
 <0ac77e8d-9400-abc8-f963-943e9cba94db@denx.de>
 <9fbd2fca-e4f5-d28f-74de-d9906cc232bf@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <50d92d9a-b42e-b313-a0c7-ff0848a3c673@denx.de>
Date:   Thu, 4 Feb 2021 14:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9fbd2fca-e4f5-d28f-74de-d9906cc232bf@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/4/21 1:54 PM, Yann GAUTIER wrote:
> On 2/4/21 1:26 PM, Marek Vasut wrote:
>> On 2/4/21 1:05 PM, yann.gautier@foss.st.com wrote:
>>> From: Yann Gautier <yann.gautier@foss.st.com>
>>>
>>> To properly manage commands awaiting R1B responses, the capability
>>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
>>> manage busy detection.
>>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
>>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
>>>
>> Shouldn't this have Fixes: tag ?
> 
> Hi Marek,
> 
> There is no unique patch that brought the issue, but a combination of 
> several things:
> - The series that brought the MMC_CAP_NEED_RSP_BUSY flag [1]
> - The series that enabled MMC_ERASE for all hosts [2] (removal of 
> MMC_CAP_ERASE)
> 
> But you're right, this patch may go on v5.8.x kernel and newer versions.

I think there will be quite some interest in 5.10.y LTS on the MP1 from 
the various industrial/embedded users, so it would be nice to have that 
5.10.y well maintained with necessary backports / fixes :)
