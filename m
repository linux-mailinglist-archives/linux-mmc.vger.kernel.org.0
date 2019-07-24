Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027A772F83
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGXNHI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 09:07:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:15133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfGXNHH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Jul 2019 09:07:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="345096288"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2019 06:07:05 -0700
Subject: Re: [PATCH] mmc: sdhci-pci: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190723124707.24782-1-hslester96@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1438432c-97b4-6a98-e62b-b492f627d060@intel.com>
Date:   Wed, 24 Jul 2019 16:05:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723124707.24782-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/07/19 3:47 PM, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4041878eb0f3..d10aceed5bb7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1759,8 +1759,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  #ifdef CONFIG_PM_SLEEP
>  static int sdhci_pci_suspend(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>  
>  	if (!chip)
>  		return 0;
> @@ -1773,8 +1772,7 @@ static int sdhci_pci_suspend(struct device *dev)
>  
>  static int sdhci_pci_resume(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>  
>  	if (!chip)
>  		return 0;
> @@ -1789,8 +1787,7 @@ static int sdhci_pci_resume(struct device *dev)
>  #ifdef CONFIG_PM
>  static int sdhci_pci_runtime_suspend(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>  
>  	if (!chip)
>  		return 0;
> @@ -1803,8 +1800,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
>  
>  static int sdhci_pci_runtime_resume(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>  
>  	if (!chip)
>  		return 0;
> 

