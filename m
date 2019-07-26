Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5922475EAD
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 07:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZF5a (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 26 Jul 2019 01:57:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:39876 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZF5a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Jul 2019 01:57:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 22:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; 
   d="scan'208";a="254223291"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2019 22:57:26 -0700
Subject: Re: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
To:     Andrew Jeffery <andrew@aj.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ryan Chen <ryanchen.aspeed@gmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
 <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
 <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
Date:   Fri, 26 Jul 2019 08:56:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/07/19 3:52 AM, Andrew Jeffery wrote:
> On Thu, 25 Jul 2019, at 22:49, Adrian Hunter wrote:
>> On 12/07/19 6:32 AM, Andrew Jeffery wrote:
>>> +static int aspeed_sdhci_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>> +	struct aspeed_sdhci *dev;
>>> +	struct sdhci_host *host;
>>> +	struct resource *res;
>>> +	int slot;
>>> +	int ret;
>>> +
>>> +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
>>> +	if (IS_ERR(host))
>>> +		return PTR_ERR(host);
>>> +
>>> +	pltfm_host = sdhci_priv(host);
>>> +	dev = sdhci_pltfm_priv(pltfm_host);
>>> +	dev->parent = dev_get_drvdata(pdev->dev.parent);
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	slot = aspeed_sdhci_calculate_slot(dev, res);
>>> +	if (slot < 0)
>>> +		return slot;
>>> +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
>>> +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
>>
>> That implies that you only support 2 slots which begs the question why
>> you don't validate slot.
> 
> I'm not sure what you mean here, but I'll dig into it.

I just meant, if you only support 2 slots:

	if (slot > 1)
		return -EINVAL;
