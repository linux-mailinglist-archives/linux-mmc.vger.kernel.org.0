Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B847CB7D8
	for <lists+linux-mmc@lfdr.de>; Fri,  4 Oct 2019 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfJDKEW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 06:04:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:26276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfJDKEW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Oct 2019 06:04:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 03:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="275997544"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2019 03:04:20 -0700
Subject: Re: [PATCH] mmc: sdhci-pci: Make function amd_sdhci_reset static
To:     zhengbin <zhengbin13@huawei.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
References: <1570182260-135818-1-git-send-email-zhengbin13@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4064d4ba-57df-7803-65e9-c97b13f6c596@intel.com>
Date:   Fri, 4 Oct 2019 13:02:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570182260-135818-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/10/19 12:44 PM, zhengbin wrote:
> Fix sparse warnings:
> 
> drivers/mmc/host/sdhci-pci-core.c:1599:6: warning: symbol 'amd_sdhci_reset' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 659878a..de50e1d 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1596,7 +1596,7 @@ static u32 sdhci_read_present_state(struct sdhci_host *host)
>  	return sdhci_readl(host, SDHCI_PRESENT_STATE);
>  }
> 
> -void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>  	struct pci_dev *pdev = slot->chip->pdev;
> --
> 2.7.4
> 
> 

