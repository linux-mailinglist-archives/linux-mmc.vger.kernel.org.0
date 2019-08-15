Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2688E888
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2019 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHOJrl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 05:47:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:33367 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfHOJrl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Aug 2019 05:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 02:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="181830894"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2019 02:47:38 -0700
Subject: Re: [PATCH v2 1/3] mmc: add Coldfire esdhc support
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     Christoph Hellwig <hch@infradead.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20190616204823.32758-1-angelo@sysam.it>
 <20190617065807.GA17948@infradead.org> <20190619222236.GA18383@jerusalem>
 <a5427af4-079e-7e0a-487e-389969809cb5@intel.com>
 <20190706112028.GC6763@jerusalem>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b1bb4233-4568-8978-5a7e-70d954d7ad39@intel.com>
Date:   Thu, 15 Aug 2019 12:46:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190706112028.GC6763@jerusalem>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/07/19 2:20 PM, Angelo Dureghello wrote:
> Hi Adrian,
> 
> On Tue, Jul 02, 2019 at 12:10:54PM +0300, Adrian Hunter wrote:
>> On 20/06/19 1:22 AM, Angelo Dureghello wrote:
>>> Hi Christoph,
>>>
>>> On Sun, Jun 16, 2019 at 11:58:07PM -0700, Christoph Hellwig wrote:
>>>> On Sun, Jun 16, 2019 at 10:48:21PM +0200, Angelo Dureghello wrote:
>>>>> This driver has been developed as a separate module starting
>>>>> from the similar sdhci-esdhc-fls.c.
>>>>> Separation has been mainly driven from change in endianness.
>>>>
>>>> Can't we have a way to define the endianess at build or even runtime?
>>>> We have plenty of that elsewhere in the kernel.
>>>
>>> well, the base sdhci layer wants to access byte-size fields of the
>>> esdhc controller registers.
>>> But this same Freescale esdhc controller may be found in 2
>>> flavors, big-endian or little-endian organized.
>>> So in this driver i am actually correcting byte-addresses to
>>> access the wanted byte-field in the big-endian hw controller.
>>>
>>> So this is a bit different from a be-le endian swap of a
>>> long or a short that the kernel is organized to do..
>>
>> Did you consider just using different sdhci_ops so that you could support
>> different sdhci I/O accessors?
> 
> Initially i tried to modify the IMX/Vybrid (arm) driver. But was stopped from
> several points, trying to remember now, 
> 
> - the I/O accessors was a const struct, but this of course is not a big 
>   issue,
> - here and there bitfields and positions of the ColdFire controller
>   registers, compared to the arm versions, are different, so controller hw
>   is not exactly the same,
> - on ColdFire controller and some behaviors and errata are different,
> - dma endiannes not hw-configurable,
> - ColdFire has max clock limitations, a bit different clock init.
> 
> Finally, since there is already a common library (shdci.c) i decided to go
> as a separate driver, instead of filling the driver of "if (coldfire)" also 
> mainly for the following reasons:
> 
> 1) separated ColdFire driver has a quite small amount of code, simple to
> understand.
> 2) having drivers used by multiple architectures, it add risks, each time
> i perform a change, i can test it only on ColdFire, and can break
> the driver for the other architectures (i see this not rarely happening for
> multiple-arch used drivers).
> 
> So let me know if the way chosen can be ok. Otherwise i will roll back 
> trying to modify the iMX/Vybrid driver, likely adding a lot of "if (coldfire)"
> complicating it quite a lot.

"if (coldfire)" is not very nice, and there doesn't seem to be that much
common code, so let's stick with a separate driver, but please change the
commit message in consideration of this discussion.
