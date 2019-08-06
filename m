Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841DC83047
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Aug 2019 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfHFLIh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 6 Aug 2019 07:08:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:32559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFLIh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Aug 2019 07:08:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 04:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="349394291"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2019 04:08:34 -0700
Subject: Re: [PATCH V4 1/2] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
References: <1564767547-4515-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <34425078-f5fa-5f7d-1a80-c27346bb87d9@intel.com>
Date:   Tue, 6 Aug 2019 14:07:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564767547-4515-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/08/19 8:39 PM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> 
> Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
> ---
> change in V4:
>  1. add a bug fix in V3
> 
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
> 
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548..186a33d 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -51,7 +51,7 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_DISABLE	BIT(4)
>  
> -#define O2_PLL_WDT_CONTROL1	0x1CC
> +#define O2_PLL_DLL_WDT_CONTROL1	0x1CC

Please also change the other places that O2_PLL_WDT_CONTROL1 appears, so
that the code compiles.

>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> 

