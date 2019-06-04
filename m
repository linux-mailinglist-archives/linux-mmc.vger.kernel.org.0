Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8526D34576
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfFDLdY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 07:33:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40259 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFDLdY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 07:33:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so12513854pfn.7
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EUprF+8/pHWVdRSsm+gYg6Nl/I7GuQYxpR2PKTuS704=;
        b=cX5NyM5ycgQOuk4IAmaDphsDa6H1d8CV7lcsQ4WAlb3RMe7FRqEdFwUIy/zUw8PT8H
         Haqw45ol2rk0FawObSUduoqdJamkzKEihgKpPg8h/L/kNvLP5+HNu60rp64HSLBJfQpF
         3HigbEfhYLItfyDMYlI5C8j8tpV6TYxxSik3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EUprF+8/pHWVdRSsm+gYg6Nl/I7GuQYxpR2PKTuS704=;
        b=iOzRezygjDEBbb9KN3rdBc3Guyqc8zqoVB75Fa10VYr0ziV+9haUyLiUyxSQ2/kQzW
         O6vXkmATPq7Uej5/pLJsLXnEAr+RsGZCJEsyGFusr1w2Yf/YeGK44NnqzumsSbdhniRk
         h07rIM6B9o5yTqyzdVlZ51lwAZg2+9z6XFKzx/utvHMITa5mKWsKHAtTTDHtA2l8ub9+
         SdhddrBPYhvOGWjynL8EJ9ZA6bK6rfmFquyGY7odSYrChVwKvqPZu9LJf5Z4IErEe8ZA
         HtmSxmWa+Ey61pcXBtBSMFpddH2y+J6CE4WC2z5oFJS7WnEdt7osrgLKNx1QY124FHC0
         XyEQ==
X-Gm-Message-State: APjAAAVks5sgYN63qSLDyo4lYBFh0ecebXiCxw3q0n2OazEo45W9PImc
        RT/sTGZq4QGgy2qfOPLhxAyg1w==
X-Google-Smtp-Source: APXvYqxvTH3i5lfqNDE1vh1a5Z/iOkSgOFTEfkO87DUgwW2C+aCSxKKDsoC0hUv5/Gdl7rHPksKKEw==
X-Received: by 2002:a62:ea04:: with SMTP id t4mr36483301pfh.47.1559648003307;
        Tue, 04 Jun 2019 04:33:23 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id u4sm17314721pfu.26.2019.06.04.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 04:33:22 -0700 (PDT)
Subject: Re: Issue with Broadcom wireless in 5.2rc1 (was Re: [PATCH] mmc:
 sdhci: queue work after sdhci_defer_done())
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Brian Masney <masneyb@onstation.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>, ulf.hansson@linaro.org,
        faiz_abbas@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
References: <20190524111053.12228-1-masneyb@onstation.org>
 <70782901-a9ac-5647-1abe-89c86a44a01b@intel.com>
 <20190524154958.GB16322@basecamp> <20190526122136.GA26456@basecamp>
 <e8c049ce-07e1-8b34-678d-41b3d6d41983@broadcom.com>
 <20190526195819.GA29665@basecamp> <20190527093711.GA853@basecamp>
 <ead7f268-b730-3541-31f7-4499556efec0@intel.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <af4d6703-8506-dad7-c2ed-13fa8b2e390d@broadcom.com>
Date:   Tue, 4 Jun 2019 13:33:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ead7f268-b730-3541-31f7-4499556efec0@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/27/2019 2:08 PM, Adrian Hunter wrote:
> On 27/05/19 12:37 PM, Brian Masney wrote:
>> On Sun, May 26, 2019 at 03:58:19PM -0400, Brian Masney wrote:
>>> I attached a patch that shows how I was able to determine what had
>>> already claimed the host.
>> On Mon, May 27, 2019 at 10:48:24AM +0300, Adrian Hunter wrote:
>>> This is because SDHCI is using the IRQ thread to process the SDIO card
>>> interrupt (sdio_run_irqs()).  When the card driver tries to use the card, it
>>> causes interrupts which deadlocks since c07a48c26519 ("mmc: sdhci: Remove
>>> finish_tasklet") has moved the tasklet processing to the IRQ thread.
>>>
>>> I would expect to be able to use the IRQ thread to complete requests, and it
>>> is desirable to do so because it is lower latency.
>>>
>>> Probably, SDHCI should use sdio_signal_irq() which queues a work item, and
>>> is what other drivers are doing.
>>>
>>> I will investigate some more and send a patch.
> 
> Please try the patch below:

Finally got time to update my kernel to 5.2-rc2. This patch indeed 
resolves the issue.

Thanks,
Arend
