Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E838EAAD
	for <lists+linux-mmc@lfdr.de>; Thu, 15 Aug 2019 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfHOLuR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 15 Aug 2019 07:50:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:58978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOLuR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Aug 2019 07:50:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184601005"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:50:00 -0700
Subject: Re: [PATCH v1 4/4] mmc: sdhci-of-esdhc: add erratum A011334 support
 in ls1028a 1.0 SoC
To:     Yinbo Zhu <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Alison Wang <alison.wang@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>,
        Rajat Srivastava <rajat.srivastava@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
 <20190814072649.8237-4-yinbo.zhu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <eeaf2862-8f05-e813-917b-a8358e6d90ab@intel.com>
Date:   Thu, 15 Aug 2019 14:48:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814072649.8237-4-yinbo.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/08/19 10:26 AM, Yinbo Zhu wrote:
> This patch is to add erratum A011334 support in ls1028a 1.0 SoC
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index b16f7d440f78..eb2b290447fc 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1006,6 +1006,7 @@ static struct soc_device_attribute soc_incorrect_hostver[] = {
>  static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
>  	{ .family = "QorIQ LX2160A", .revision = "1.0", },
>  	{ .family = "QorIQ LX2160A", .revision = "2.0", },
> +	{ .family = "QorIQ LS1028A", .revision = "1.0", },
>  	{ },
>  };
>  
> 

