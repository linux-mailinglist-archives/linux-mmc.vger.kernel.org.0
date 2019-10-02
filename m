Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72DFC4A46
	for <lists+linux-mmc@lfdr.de>; Wed,  2 Oct 2019 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJBJLx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 2 Oct 2019 05:11:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45675 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJBJLw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2019 05:11:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so12112421lff.12
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2019 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=snm/Nrqs5QlS5PiXAWfvh6paeZp4yNlu1hsumZL0i1o=;
        b=M/2NAixWfPaMv3ZQW8Iwvj3sYZDoLYGfcGEUPMvVVvRTO0GZtIAGlDedHIPNizgtIs
         /PLzYWTMsIkba6wIwEff4EucUGUk8nrIsz6BPQM3MbVfUA9LRQ+07VcP/QoWSp+XTN+K
         JIccWCDorvAIj8F3AMn9ahODS2anPU/p9rqnJr/uzBkaGYdCwIQdsI1kz6bLqe8kUdrj
         lE1kW7iIdsH7hTOiCe2dQKT4LufypcTvTrZYYOiDTGM6/D1FWO9PNg1ooBveodsGmmK5
         8prq4eTWC19Vtg8J1G/aI/3slaof/k2pbJ/5Ol+djQc6jbctJ3JvALeC02h/qNrFaCHo
         A4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snm/Nrqs5QlS5PiXAWfvh6paeZp4yNlu1hsumZL0i1o=;
        b=r7EQ9+AzXsvMEkGVmer5Ghe7Y32byjEQgwkKAsTMMvsSsE+xABL90XzBgrutXxw9Dw
         4x+1G7AgqwzLeiW+Z+/qA53TsNtO2U00CZAMib+04zMsv6HToRkcDekL6i639kjYIaES
         q8u2Mt3AZVCmS/4MueGl9nmSyq+W+r0V1N8TMLMVJClffVDfXTXu2HWhS2UyHIDOdFUX
         jVbFT9WtFpOqvReX9ai5nOm54mOpBhSEgrrvBj/r+gARnwioIa7tN0+NpHtoide7kStA
         VdrByOSUXSm4zNWOoznxDiIr/LnQmzexIEoSKzPamVOR0aI7FuozwcTdDoOIoj7RrTcR
         NhCg==
X-Gm-Message-State: APjAAAXKZmJcBHWXqObJMDsnLeWbzf/XdzkXer2ePOJQo4vC+zbgRSDD
        1O6cZmKr7bdCL5b3MO698njOlQ==
X-Google-Smtp-Source: APXvYqxhVv3O71kzK8dErCIIZ8yCZStE0Zsvx1RSL5mpco8IJyDXSeXrRGypv1WRJKcw21Z5DvsCWw==
X-Received: by 2002:a05:6512:210:: with SMTP id a16mr1605247lfo.42.1570007509119;
        Wed, 02 Oct 2019 02:11:49 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:445f:5d29:e99c:20bb:1ee3:467? ([2a00:1fa0:445f:5d29:e99c:20bb:1ee3:467])
        by smtp.gmail.com with ESMTPSA id k8sm5693214ljg.9.2019.10.02.02.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 02:11:48 -0700 (PDT)
Subject: Re: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count
 interrupts
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001180703.910-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bc48041c-df06-8108-9c45-3dfb1d527678@cogentembedded.com>
Date:   Wed, 2 Oct 2019 12:11:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001180703.910-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01.10.2019 21:07, Geert Uytterhoeven wrote:

> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing

   s/the//?

> of scary messages like:
> 
>      renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found
> 
> Fix this by using the platform_irq_count() helper to avoid touching
> non-existent interrupts.
> 
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.
> ---
>   drivers/mmc/host/renesas_sdhi_core.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d4ada5cca2d14f6a..122f429602d825bd 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
[...]
> @@ -825,24 +825,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>   		host->hs400_complete = renesas_sdhi_hs400_complete;
>   	}
>   
> -	i = 0;
> -	while (1) {
> +	/* There must be at least one IRQ source */
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 1) {
> +		ret = num_irqs;
> +		goto eirq;

    This will return 0 with failed probe if 'num_irqs' is 0, I don't think you 
want this...

[...]

MBR, Sergei
