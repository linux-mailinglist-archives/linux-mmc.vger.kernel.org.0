Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2943C8B
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Jun 2019 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfFMPgT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 13 Jun 2019 11:36:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:31768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfFMKT7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Jun 2019 06:19:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 03:19:58 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2019 03:19:56 -0700
Subject: Re: [EXT] Re: [PATCH] enable acpi support in esdhc driver
To:     Udit Kumar <udit.kumar@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Jimmy Zhao <jimmy.zhao@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
References: <1559538333-362-1-git-send-email-udit.kumar@nxp.com>
 <95e552d9-2fe7-e153-60dc-cc77aac3452e@intel.com>
 <VI1PR04MB4640CC09CBBD43A09711AF1291EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <18b5251a-877f-dc0b-dc3c-0d4082a3ad47@intel.com>
Date:   Thu, 13 Jun 2019 13:18:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4640CC09CBBD43A09711AF1291EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>>> +     if (np) {
>>> +             clk = of_clk_get(np, 0);
>>> +             if (!IS_ERR(clk)) {
>>> +                     /*
>>> +                      * esdhc->peripheral_clock would be assigned a value
>>> +                      * which is eSDHC base clock when use periperal clock.
>>> +                      * For ls1046a, the clock value got by common clk API is
>>> +                      * peripheral clock while the eSDHC base clock is 1/2
>>> +                      * peripheral clock.
>>> +                      */
>>> +                     if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
>>> +                             esdhc->peripheral_clock = clk_get_rate(clk) / 2;
>>> +                     else
>>> +                             esdhc->peripheral_clock = clk_get_rate(clk);
>>> +                     clk_put(clk);
>>> +             }
>>> +     } else {
>>> +             device_property_read_u32(&pdev->dev, "clock-frequency",
>>> +
>>> + &esdhc->peripheral_clock);
>>>       }
>>
>> Not sure the "if (np) {}" really serves a purpose since of_clk_get(() will return an
>> error in that case anyway.
> 
> Looks this is something, I need to rework, in internal review I got the feedback 
> There are two clocks one esdhc->peripheral_clock and another is pltfm_host->clock. 
> As ACPI does not have clock frame work like of DT. 
> Therefore I have here 2 option 
> 1) expose a sort of new driver with CLK in acpi tables and have reference here like ^SB0.CLK 
> 2) use fixed clock 
> Please suggest if you have some preference in either of 

I am not aware of any ACPI options, but you should ask on the ACPI mailing
list and the APCI maintainers.
