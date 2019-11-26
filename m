Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC85109E7A
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZNFn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Nov 2019 08:05:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:9537 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfKZNFn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Nov 2019 08:05:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 05:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="217158364"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 05:05:40 -0800
Subject: Re: [PATCH 14/14] mmc: cqhci: clear pending interrupt and halt
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
References: <1573816835-26884-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b7ed8bf9-305d-f106-3c28-446a0cda176d@intel.com>
Date:   Tue, 26 Nov 2019 15:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573816835-26884-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/19 1:20 PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
> as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
> the 1st linux configure power/clock for the 2nd Linux.
> 
> When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
> to destroy the 2nd linux, then restart the 1st linux, we met SDHCI dump
> as following, after we clear the pending interrupt and halt CQCTL, issue
> gone.
> 
> [ 1.334594] mmc2: Got command interrupt 0x00000001 even though no command operation was in progress.
> [ 1.334595] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 1.334599] mmc2: sdhci: Sys addr: 0xa05dcc00 | Version: 0x00000002
> [ 1.340819] lib80211: common routines for IEEE802.11 drivers
> [ 1.345538] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000000
> [ 1.345541] mmc2: sdhci: Argument: 0x00018000 | Trn mode: 0x00000033
> [ 1.345543] mmc2: sdhci: Present: 0x01f88008 | Host ctl: 0x00000031
> [ 1.345547] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
> [ 1.357903] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x0000003f
> [ 1.357905] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00000000
> [ 1.357908] mmc2: sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
> [ 1.357911] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
> [ 1.370268] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
> [ 1.370270] mmc2: sdhci: Cmd: 0x00000d1a | Max curr: 0x00ffffff
> [ 1.370273] mmc2: sdhci: Resp[0]: 0x00000b00 | Resp[1]: 0xffffffff
> [ 1.370276] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
> [ 1.382132] mmc2: sdhci: Host ctl2: 0x00000000
> [ 1.382135] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0xa2040208
> 
> [ 2.060932] mmc2: Unexpected interrupt 0x00004000.
> [ 2.065538] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 2.071720] mmc2: sdhci: Sys addr: 0x00000000 | Version: 0x00000002
> [ 2.077902] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000001
> [ 2.084083] mmc2: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [ 2.090264] mmc2: sdhci: Present: 0x01f88009 | Host ctl: 0x00000011
> [ 2.096446] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
> [ 2.102627] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x000010ff
> [ 2.108809] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00004000
> [ 2.114990] mmc2: sdhci: Int enab: 0x007f1003 | Sig enab: 0x007f1003
> [ 2.121171] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
> [ 2.127353] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
> [ 2.133534] mmc2: sdhci: Cmd: 0x0000371a | Max curr: 0x00ffffff
> [ 2.139715] mmc2: sdhci: Resp[0]: 0x00000900 | Resp[1]: 0xffffffff
> [ 2.145896] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
> [ 2.152077] mmc2: sdhci: Host ctl2: 0x00000000
> [ 2.156342] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++

Subject should start "mmc: sdhci-esdhc-imx:" not "mmc: cqhci:" because
sdhci-esdhc-imx is being changed.

>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 83b4156b2cf4..7cd5046f33ce 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1483,6 +1483,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	struct cqhci_host *cq_host;
>  	int err;
>  	struct pltfm_imx_data *imx_data;
> +	u32 status;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata,
>  				sizeof(*imx_data));
> @@ -1590,6 +1591,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		err = cqhci_init(cq_host, host->mmc, false);
>  		if (err)
>  			goto disable_ahb_clk;
> +

Could use a comment here explaining why this is needed.

> +		status = cqhci_readl(cq_host, CQHCI_IS);
> +		cqhci_writel(cq_host, status, CQHCI_IS);
> +		cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
>  	}
>  
>  	if (of_id)
> 

