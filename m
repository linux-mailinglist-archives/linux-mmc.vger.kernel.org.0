Return-Path: <linux-mmc+bounces-342-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACFB8052CC
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Dec 2023 12:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179C61C20DE8
	for <lists+linux-mmc@lfdr.de>; Tue,  5 Dec 2023 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B86979B;
	Tue,  5 Dec 2023 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mab/ITuX"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1FD26AC;
	Tue,  5 Dec 2023 03:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701775617; x=1733311617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWPD/eGzPxDr4/kQ5lviw+9wKyBmE2JGu/aOr799fyU=;
  b=mab/ITuXuETG4xRc/stKaz2hS7DHlTFDYX6qglo4wP64EF8LZaxxeGW5
   eoIF71egxVsMI50KQqObnM5BXCcper0UQAVHGeVLmqGOusuaTg5fYQZEW
   ZUFO8AyACfALGnabts5t3PsdMMEl6XZ7ELg5D3QZqQTtGxffwuBpEirzU
   dVnPf6sX/cQIBFEe+bslLhrgB7TMiVvux+TLg8aWfLHWyZh0DVJ7B0ghL
   wdReVcGkkzltuwjZbzA3ukbXQhaZmnuGFpQrvKqxdqlQ3jE/DV2JONXuP
   Ae8Y3WD7o9CDakakRJPcjefzGTGe9S8CAOy+C5pOXWgznfcxVwFsgXnOz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="943605"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="943605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018194403"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018194403"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:26:51 -0800
Message-ID: <8e7b6ac2-9d92-4f37-97c4-ae295f7cdbd4@intel.com>
Date: Tue, 5 Dec 2023 13:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Content-Language: en-US
To: =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "doug@schmorgal.com" <doug@schmorgal.com>,
 "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
 "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
 "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
 <655c5964-0917-4021-b254-7917b368b05f@intel.com>
 <7b4b7219c2b6430b9c320c8d9ac1cc8b@realtek.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7b4b7219c2b6430b9c320c8d9ac1cc8b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/23 11:19, Jyan Chou [周芷安] wrote:
>>> +
>>> +static irqreturn_t dw_mci_cqe_interrupt(int irq, void *dev_id) {
>>> +     struct dw_mci *host = dev_id;
>>> +     struct mmc_host *mmc = host->slot->mmc;
>>> +     struct cqhci_host *cq_host = NULL;
>>> +     int cmd_error = 0, data_error = 0;
>>> +
>>> +     if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE))
>>> +             cq_host = mmc->cqe_private;
>>> +
>>> +     dw_mci_get_int(host);
>>> +
>>> +     if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
>>> +             if (!mmc->cqe_on && !cq_host->activated)
>>
>> Shouldn't really look at internals like mmc->cqe_on or cq_host->activated.
>> There are the cqhci_host_ops ->enable() and ->disable() callbacks to keep track
>> of whether cqhci is expecting interrupts.
> 
> Does this means we need to use cqhci_host_ops ->enable() and ->disable() callbacks
> instead of mmc->cqe_on && !cq_host->activated? Thanks.

Yes.  ->enable() is always called before cqhci operation and ->disable()
before non-cqhci operation, so they can be used to determine if an interrupt
is for cqhci.


