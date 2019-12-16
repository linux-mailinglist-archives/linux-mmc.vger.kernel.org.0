Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F356C11FFA9
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Dec 2019 09:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLPI0b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Dec 2019 03:26:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47390 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLPI0a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 03:26:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG8QH4V073483;
        Mon, 16 Dec 2019 02:26:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576484777;
        bh=5LJD3BaNdpDqu2z7AYf9ZaOq2CWCjaTXL7atRrYN3cI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DZLHVKXk810t3N8MZMb6HMv/0QUDWc3z+uzXBFx1qkTJhJQvSd8lwSwCsCUCUF6/s
         cjwWCcNqn8Wl4pO5J6xRDORlm7LITd/VID4WHjwZYKu38umhAb5yuIIcxu/nLyHubP
         OQJPupJvI/ZnjFbJhQddN8Cv6k5RwRrM938RHHUA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG8QGYo039352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 02:26:16 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 02:26:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 02:26:16 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG8QCt3052187;
        Mon, 16 Dec 2019 02:26:13 -0600
Subject: Re: [PATCH v3 2/7] mmc: sdhci: add support for using external DMA
 devices
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <zhang.chunyan@linaro.org>,
        <tony@atomide.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-3-faiz_abbas@ti.com>
 <92fd22bf-3024-928d-ebf5-e7382988a36b@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <fdf1334a-39bc-9247-9934-df6e1562f4b8@ti.com>
Date:   Mon, 16 Dec 2019 13:57:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <92fd22bf-3024-928d-ebf5-e7382988a36b@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 12/12/19 6:25 pm, Adrian Hunter wrote:
> On 10/12/19 11:51 am, Faiz Abbas wrote:
>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>
>> Some standard SD host controllers can support both external dma
>> controllers as well as ADMA/SDMA in which the SD host controller
>> acts as DMA master. TI's omap controller is the case as an example.
>>
>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>> the host controller but does not have any support for external DMA
>> controllers implemented using dmaengine, meaning that custom code is
>> needed for any systems that use an external DMA controller with SDHCI.
>>
>> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
>> 1. Map scatterlists before dmaengine_prep_slave_sg()
>> 2. Use dma_async() functions inside of the send_command() path and call
>> terminate_sync() in non-atomic context in case of an error.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
...
>>  {
>> @@ -1379,12 +1562,19 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>  	}
>>  
>>  	host->cmd = cmd;
>> +	host->data_timeout = 0;
>>  	if (sdhci_data_line_cmd(cmd)) {
>>  		WARN_ON(host->data_cmd);
>>  		host->data_cmd = cmd;
>> +		sdhci_set_timeout(host, cmd);
>>  	}
>>  
>> -	sdhci_prepare_data(host, cmd);
>> +	if (cmd->data) {
>> +		if (host->use_external_dma)
>> +			sdhci_external_dma_prepare_data(host, cmd);
>> +		else
>> +			sdhci_prepare_data(host, cmd);
>> +	}
> 
> Please make the 3 changes above and the corresponding changes
> sdhci_prepare_data into a separate patch i.e.

Ok. And I agree with all your style change requests above this. Will fix
in v4.

>> @@ -2652,6 +2845,18 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>  	if (host->flags & SDHCI_REQ_USE_DMA) {
>>  		struct mmc_data *data = mrq->data;
>>  
>> +		spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +		/* Terminate and synchronize dma in case of an error */
>> +		if (data && (mrq->cmd->error || data->error) &&
>> +		    host->use_external_dma) {
>> +			struct dma_chan *chan = sdhci_external_dma_channel(host,
>> +									  data);
>> +			dmaengine_terminate_sync(chan);
>> +		}
>> +
>> +		spin_lock_irqsave(&host->lock, flags);
>> +
> 
> Need to take the mrq out of mrqs_done[] to ensure it is not processed again,
> and put it back again to be consistent with the remaining code. Also put
> host->use_external_dma as the first condition i.e.
> 
> 		if (host->use_external_dma && data &&
> 		    (mrq->cmd->error || data->error)) {
> 			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
> 
> 			host->mrqs_done[i] = NULL;
> 			spin_unlock_irqrestore(&host->lock, flags);
> 			dmaengine_terminate_sync(chan);
> 			spin_lock_irqsave(&host->lock, flags);
> 			sdhci_set_mrq_done(host, mrq);
> 		}
> 
> where sdhci_set_mrq_done() is factored out from __sdhci_finish_mrq() i.e.
> 
> static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
> {
> 	int i;
> 
> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> 		if (host->mrqs_done[i] == mrq) {
> 			WARN_ON(1);
> 			return;
> 		}
> 	}
> 
> 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> 		if (!host->mrqs_done[i]) {
> 			host->mrqs_done[i] = mrq;
> 			break;
> 		}
> 	}
> 
> 	WARN_ON(i >= SDHCI_MAX_MRQS);
> }
> 
> sdhci_set_mrq_done() can be made in the refactoring patch.
Haven't we already done the sdhci_set_mrq_done() part in
__sdhci_finish_mrq()?

We are picking up an already "done" mrq, looking at whether it had any
error and then sychronizing with external dma. Or at least that is my
understanding.

> 
>>  		if (data && data->host_cookie == COOKIE_MAPPED) {
>>  			if (host->bounce_buffer) {
>>  				/*
>> @@ -3758,12 +3963,28 @@ int sdhci_setup_host(struct sdhci_host *host)
>>  		       mmc_hostname(mmc), host->version);
>>  	}
>>  
>> -	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> +	if (host->use_external_dma) {
>> +		ret = sdhci_external_dma_init(host);
>> +		if (ret == -EPROBE_DEFER)
>> +			goto unreg;
>> +
>> +		/*
>> +		 * Fall back to use the DMA/PIO integrated in standard SDHCI
>> +		 * instead of external DMA devices.
>> +		 */
>> +		if (ret)
>> +			sdhci_switch_external_dma(host, false);
>> +	}
>> +
>> +	if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
>>  		host->flags |= SDHCI_USE_SDMA;
>> -	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
>> +	} else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
>>  		DBG("Controller doesn't have SDMA capability\n");
>> -	else
>> +	} else if (host->use_external_dma) {
>> +		/* Using dma-names to detect external dma capability */
> 
> What is this change for?  Do you expect for SDHCI_USE_SDMA and
> SDHCI_USE_ADMA flags to be clear?

Yes. Today the code enables SDMA by default (in the else part below
this). I want it to not enable SDMA in the external dma case.

Thanks,
Faiz
