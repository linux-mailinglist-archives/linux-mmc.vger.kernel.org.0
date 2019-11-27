Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A643710AD4F
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Nov 2019 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0KLk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Nov 2019 05:11:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:30460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfK0KLk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Nov 2019 05:11:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 02:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="383457143"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2019 02:11:37 -0800
Subject: Re: [PATCH 03/14] mmc: sdhci: correct the DMA setting for IOMMU
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1573816075-26390-1-git-send-email-haibo.chen@nxp.com>
 <1573816075-26390-3-git-send-email-haibo.chen@nxp.com>
 <620dc251-4411-1306-c9db-267a96a091d2@intel.com>
 <VI1PR04MB5040E0936672CBAA882A8AF390440@VI1PR04MB5040.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <97300bc9-a840-c73a-fa35-ad2f7faef76a@intel.com>
Date:   Wed, 27 Nov 2019 12:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5040E0936672CBAA882A8AF390440@VI1PR04MB5040.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/11/19 10:25 AM, BOUGH CHEN wrote:
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org <linux-mmc-owner@vger.kernel.org>
>> On Behalf Of Adrian Hunter
>> Sent: 2019年11月26日 19:46
>> To: BOUGH CHEN <haibo.chen@nxp.com>; ulf.hansson@linaro.org
>> Cc: linux-mmc@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH 03/14] mmc: sdhci: correct the DMA setting for IOMMU
>>
>> On 15/11/19 1:07 PM, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> The default max segment size of IOMMU is 64KB, which exceed the ADMA
>>> limitation if ADMA only support max to 65535, 64KB - 1Byte. IOMMU will
>>> optimize the segments it received, merge the little segment into one
>>> big segment. If we use the default IOMMU config, then ADMA will get
>>> some segments which it's size is 64KB. Then ADMA error will shows up.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>>> 1436cc9c5f82..3a8093de26c7 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3743,6 +3743,7 @@ static inline bool sdhci_can_64bit_dma(struct
>>> sdhci_host *host)  int sdhci_setup_host(struct sdhci_host *host)  {
>>>  	struct mmc_host *mmc;
>>> +	struct device *dev;
>>>  	u32 max_current_caps;
>>>  	unsigned int ocr_avail;
>>>  	unsigned int override_timeout_clk;
>>> @@ -3754,6 +3755,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>  		return -EINVAL;
>>>
>>>  	mmc = host->mmc;
>>> +	dev = mmc_dev(mmc);
>>>
>>>  	/*
>>>  	 * If there are external regulators, get them. Note this must be
>>> done @@ -4224,10 +4226,20 @@ int sdhci_setup_host(struct sdhci_host
>> *host)
>>>  	 * be larger than 64 KiB though.
>>>  	 */
>>>  	if (host->flags & SDHCI_USE_ADMA) {
>>> -		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
>>> +		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
>>>  			mmc->max_seg_size = 65535;
>>> -		else
>>> +
>>> +			/*
>>> +			 * send the ADMA limitation to IOMMU. In default,
>>> +			 * the max segment size of IOMMU is 64KB, this exceed
>>> +			 * the ADMA max segment limitation, which is 65535.
>>> +			 */
>>> +			dev->dma_parms = devm_kzalloc(dev,
>>> +					sizeof(*dev->dma_parms), GFP_KERNEL);
>>> +			dma_set_max_seg_size(dev, SZ_64K - 1);
>>
>> Doesn't mmc_setup_queue() already do this?
> 
> mmc_setup_queue do call the function dma_set_max_seg_size(), but it do not give value to dev->dma_parms.
> So in dma_set_max_seg_size(), it do nothing, just return -EIO. 
> Should I fix this in mmc_setup_queue()? 
> 
> 725 static inline int dma_set_max_seg_size(struct device *dev, unsigned int size)
> 726 {
> 727         if (dev->dma_parms) {
> 728                 dev->dma_parms->max_segment_size = size;
> 729                 return 0;
> 730         }
> 731         return -EIO;
> 732 } 

I don't know where is the best place to create dev->dma_parms.  Ask some DMA
people.

> 
>>
>>> +		} else {
>>>  			mmc->max_seg_size = 65536;
>>> +		}
>>>  	} else {
>>>  		mmc->max_seg_size = mmc->max_req_size;
>>>  	}
>>>
> 

