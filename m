Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8C8674A
	for <lists+linux-mmc@lfdr.de>; Thu,  8 Aug 2019 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfHHQmp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 12:42:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43863 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfHHQmo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 12:42:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so20750480otp.10
        for <linux-mmc@vger.kernel.org>; Thu, 08 Aug 2019 09:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0RerVaK+RfWl7f5w05muo3aZmEmhRBxNWB/GcQlwjNc=;
        b=EAV4j+H9UpEIyg7dUQomEJ8frRN9oCiHNDd+KTAy9wTvb+AzsZSjOD11p/EPzvN972
         eQwg4UJcLsbfV8ib+4rCGnG2KZE2yXvwWs3N0YuiwR/QotpPn/P06xXrqtbO+gtJKY0p
         rwOOkd8UFrUaf+EW8HXuWzaAmQTb0szrHiGGx7FN3LSvqChB4mmimGWrZEs35oAGG4/8
         cNpCuFdk11Z5vxDle1rVwZr50yuFuoFo0bVQK324ek4hnNr/bxgNEUY7ccWG/nV7ZekI
         n8Gk4sHdFu8FhhXHRkz3b6uZUcYmQeZe8FmYgASLga2SqHScz8b7Kfd+LDRswrc49AVr
         sDjw==
X-Gm-Message-State: APjAAAWyk6N1GQVYov/CSD9NdHKz9YIfwqR2e1juCLIuOk7a6OwXuS4Y
        NfhRHTkQp8JW1xHfhHmjVKqH1g==
X-Google-Smtp-Source: APXvYqwNm+JMvUchL8ENwcPkg8caHsOjZ2EP6tGKtQmFFNOzwhIfC4eTwW7565vc0l/aNSd0iANYJw==
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr16653814ioj.105.1565282562826;
        Thu, 08 Aug 2019 09:42:42 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id w23sm80475158ioa.51.2019.08.08.09.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 09:42:41 -0700 (PDT)
Date:   Thu, 8 Aug 2019 10:42:37 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
Subject: Re: [PATCH V5 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Message-ID: <20190808164237.GA250824@google.com>
References: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 07, 2019 at 09:10:10PM +0000, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	usleep_range(5000, 6000);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
> +		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
> +			mmc_hostname(host->mmc));
> +	}
> +
> +	/* Detect 1 s */
> +	timeout = ktime_add_ms(ktime_get(), 1000);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (!(scratch32 & O2_DLL_LOCK_STATUS))
> +			return 0;
> +
> +		if (timedout)
> +			return 1;
> +	}
> +}

It would be better to use readx_poll_timeout instead of open coding the
same logic.

static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host) {
	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
}

static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host) {
	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 100, 6000);
}
