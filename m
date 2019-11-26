Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20A109F70
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 14:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKZNoX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 08:44:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:59658 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfKZNoX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 08:44:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 05:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217164544"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 05:44:20 -0800
Subject: Re: [PATCH 13/14] mmc: sdhci-esdhc-imx: handle 'auto-cmd23-broken'
 from devicetree
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816712-26841-1-git-send-email-haibo.chen@nxp.com>
 <1573816712-26841-4-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <901f6f1c-b5a8-c5e2-cd22-140c2818bcde@intel.com>
Date:   Tue, 26 Nov 2019 15:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816712-26841-4-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/19 1:18 PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq->sbc
> when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD23 for
> RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, the
> RPMB write operation will return general fail.
> 
> According to the sdhci logic, SDMA mode will disable the ACMD23, and only in
> ADMA mode, it will chose to use ACMD23 if the host support. But according to
> debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
> the ACMD23 feature completely. These SoCs only use the 16 bit block count of
> the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
> means it will ignore the upper 16 bit of the CMD23's argument. This will block
> the reliable write operation in RPMB, because RPMB reliable write need to set
> the bit31 of the CMD23's argument. This is the hardware limitation. Due to
> imx6sl use SDMA, so for imx6qpdl/imx6sx/imx7d, it need to broke the ACMD23 for
> eMMC, SD card do not has this limitation, because SD card do not support reliable
> write.
> 
> For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, it
> change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADMA mode.
> 
> This patch handle 'fsl,auto-cmd23-broken' from devicetree.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 80a148f8009e..83b4156b2cf4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1374,6 +1374,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (of_find_property(np, "no-1-8-v", NULL))
>  		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  
> +	if (of_find_property(np, "fsl,auto-cmd23-broken", NULL))
> +		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;

I guess it could be "sdhci,auto-cmd23-broken" and you could put it in
sdhci_get_property() and use that.

> +
>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>  		boarddata->delay_line = 0;
>  
> 

