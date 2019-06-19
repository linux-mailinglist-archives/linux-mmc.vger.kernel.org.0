Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7024BC1D
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Jun 2019 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSO4b (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 19 Jun 2019 10:56:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39485 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSO4b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2019 10:56:31 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so32861779iod.6
        for <linux-mmc@vger.kernel.org>; Wed, 19 Jun 2019 07:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ST8NyS5lS7ZO35UtngAcwLs8pyVYyzQpclBMnNE1AtU=;
        b=oQk5ORjkHDH2WTrhcjyI1+DM1tW1B1e/pOPe9Vr8p6GJ5k/APaiM5chTNvC3BRFz/2
         oYsp6Mvi8RI2ZwhdR76oBhs4PNjSN8a4DRbezEr9ql7rDtagFvsIflsDantNB/3fIH2u
         tM+1P1G9u9FBnpBhEsDkCWZjk95RHx3NdzrD3rQRLEUvHsXOU8XsK1zwPAQm/AGGzkiG
         S1j1iOTuyvGwu+Mhd3Ytu3qH9Lq93/XUhK8hM8OKDyvZelLKtyzfdz0sSS7MINXqqzr5
         BCtxs32cPWZyJmBBSmZt6KDUAPttplZ7vphqm1elhUUfIZeINQNzBaEQHW8XHWCRgfwT
         BTrA==
X-Gm-Message-State: APjAAAVw8E83AeCOfqLYMCE2pGChFOBrYkYaQuEPYd6ZGRPs/jg2wQc9
        9ZDiJtgy7b6S2Bkf8GxOwGz1eg==
X-Google-Smtp-Source: APXvYqwUKdWZua2InEY/mHBUFIiPdRoM85uj6Eutp9Jo/m4ldx//+Eb8q4tByILJaDYRYyuTdyefZw==
X-Received: by 2002:a02:b016:: with SMTP id p22mr48724859jah.121.1560956190592;
        Wed, 19 Jun 2019 07:56:30 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id f4sm17491877iok.56.2019.06.19.07.56.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 07:56:29 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:56:25 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190619145625.GA50985@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 11, 2019 at 01:30:55PM +0300, Adrian Hunter wrote:
> Does the following work?
> 
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0cd5f2ce98df..f672171246b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -341,8 +341,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> +	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +
>  	sdhci_init(host, 0);
>  	sdhci_enable_card_detection(host);
> +
> +	/*
> +	 * A change to the card detect bits indicates a change in present state,
> +	 * refer sdhci_set_card_detection(). A card detect interrupt might have
> +	 * been missed while the host controller was being reset, so trigger a
> +	 * rescan to check.
> +	 */
> +	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
> +		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>  
>  static void __sdhci_led_activate(struct sdhci_host *host)

Your patch looks good. I tried it out and got over 57k insertion/removal
iterations. Do you want me to send out your patch, or do you want to do
it?

Just to recap, the patch you proposed + the AMD SDHCI specific patch fix
the problem.

Thanks!
