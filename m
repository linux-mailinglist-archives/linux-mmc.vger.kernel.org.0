Return-Path: <linux-mmc+bounces-56-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF617EAE4B
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Nov 2023 11:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72B6B20974
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Nov 2023 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A518E0B;
	Tue, 14 Nov 2023 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DP1Ifjzy"
X-Original-To: linux-mmc@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF816406
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 10:47:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB0186;
	Tue, 14 Nov 2023 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699958825; x=1731494825;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F6ST2CZU5lQlX8QXKrdKxRtSIOrwexjLiZAG8hQ68iU=;
  b=DP1IfjzyurPMSYjBahoYKKChAY2fveY1xgHryjDWX++X7zqrp1AyXERu
   MEs16AU8JW0HXqogKh7pzpkyQxdQxkIkSfKmiNpnP/VQHhTUjzJsZcT/S
   AFobzaOZwO3PwxTVwm3uYvDQCrkvEhAFTFMAOPjcQObCF0M2BhGbFqtmZ
   fzezU5Ixu6mGyCB2JUSk6wahfKvC5H9lXm6UlT0B0wuVPXORaFwHE3gzw
   vAcLhgJuH4PMLmH6wLTwqbJXx+VH+xAlvGZu9Lwg+cOPlMnjy6ADzDwTy
   LOWjUbeeGhaAoPVBcySmjLCyY73Uda4znbMKnz6K8ANTE2KvOiUkbac/0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="457125448"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="457125448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12398950"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 02:47:02 -0800
Message-ID: <fc758174-e286-48f7-bec9-64e4f22bce2f@intel.com>
Date: Tue, 14 Nov 2023 12:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
Content-Language: en-US
To: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Sven van Ashbrook <svenva@google.com>,
 Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 stable@vger.kernel.org
References: <20231109111934.4172565-1-korneld@chromium.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231109111934.4172565-1-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/23 13:19, Kornel Dulęba wrote:
> To address IO performance commit f9e5b33934ce
> ("mmc: host: Improve I/O read/write performance for GL9763E")
> limited LPM negotiation to runtime suspend state.
> The problem is that it only flips the switch in the runtime PM
> resume/suspend logic.
> 
> Disable LPM negotiation in gl9763e_add_host.
> This helps in two ways:
> 1. It was found that the LPM switch stays in the same position after
>    warm reboot. Having it set in init helps with consistency.
> 2. Disabling LPM during the first runtime resume leaves us susceptible
>    to the performance issue in the time window between boot and the
>    first runtime suspend.
> 
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d83261e857a5..ce91d1e63a8e 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -220,6 +220,9 @@
>  
>  #define GLI_MAX_TUNING_LOOP 40
>  
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
> +					      bool enable);

Kernel-style is to move the whole function to prevent the need
for forward declaration.

> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -1281,6 +1284,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  	if (ret)
>  		goto cleanup;
>  
> +	/* Disable LPM negotiation to avoid entering L1 state. */
> +	gl9763e_set_low_power_negotiation(slot, false);
> +
>  	return 0;
>  
>  cleanup:
> @@ -1323,7 +1329,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>  
> -#ifdef CONFIG_PM
>  static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> @@ -1349,6 +1354,7 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>  
> +#ifdef CONFIG_PM
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>  	struct sdhci_pci_slot *slot = chip->slots[0];


