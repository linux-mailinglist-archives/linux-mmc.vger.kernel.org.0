Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE79FA03
	for <lists+linux-mmc@lfdr.de>; Wed, 28 Aug 2019 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfH1FxT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 28 Aug 2019 01:53:19 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41235 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfH1FxT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2019 01:53:19 -0400
Received: by mail-qk1-f170.google.com with SMTP id g17so1390944qkk.8
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDFgnUsxEEnHyK6dQZKkqF9vItp7e+wnBAvYrxj2bWg=;
        b=b6iycyTS4IEo0H0yNH6Pmgv3HaVCwz/NNSv9JHH5dVkDhnHp6mxY3sGj4KQD/Thz1l
         w7sL8IbboAEBVsQjHHSOsVbizk4/BIUYy6qZ44JiAyR8KPe7fJ1WEpvDO6L/i40hbxjo
         IM3+yism3Py4uH2ETwSFN5JetSrf/I+wj7ieFaSFUuOCECLZrPWRn5iNlUS8BIWEXtDR
         p5sdaXD1BnDyDAiSk0KPnpv2Ih3ORsGHxQ7O/Rv6g8N9jhNjp1aNxUOlGwvo9W1ooIH6
         May+uQvDO5GQI9UfUoVUpNxcYNDREn3HknEGudQnLDQ0iPBgBWw5XCOMmODxJ1j/aRQE
         QTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDFgnUsxEEnHyK6dQZKkqF9vItp7e+wnBAvYrxj2bWg=;
        b=ft+Gz/jN2dMEvZEjgzxk34HIS4d7vt6pqHJiwSBSAJ3lk+cE32XvRgYSlJSQy5bI65
         JG9I2dn3AH71AYsU9r+wLgmvgmPqjv5Vk7r3oq770PxgfmDJYzSep+Z9CMDv9eMriFWC
         fkvmy+PWDMqQCW9neGPUgN2ADMQmqETHe6G8coxMGrZjqok1xpqMxp9BVNXiHF7y+/m4
         kRe+xWGwfMf5AKx94Cq/O17LMuSfD34H1/XtwnT+bltqRjyacCtXH9+PVe+2GlSUprFR
         4CE22+OILcE2Iw8j3TUzLHi4wFL9VgNl2/zcJfFQzOk55fzmOM7j9pHLw2A0WNoIfj3x
         /zKw==
X-Gm-Message-State: APjAAAWRRpEVLUHnTF5vDnhjxejPQ4YUfQuPiaO9VLgV+HakDzcOCL3R
        esuXMF5rkmO2KghFUIwh1ZAxDUpH5v30mvcfE0+wEzN8hirNMg==
X-Google-Smtp-Source: APXvYqzTdegixtTszylepIKF6MvYoVpDvhrax0GwKJTpinSIReVRmDwR5NFdGoU8VkfnUuqrfx3AfXko1TJ2u7sADf0=
X-Received: by 2002:a37:7347:: with SMTP id o68mr1171635qkc.145.1566971598627;
 Tue, 27 Aug 2019 22:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR16MB34791BACDB5A036DBF14E8C3E5A00@CH2PR16MB3479.namprd16.prod.outlook.com>
In-Reply-To: <CH2PR16MB34791BACDB5A036DBF14E8C3E5A00@CH2PR16MB3479.namprd16.prod.outlook.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 28 Aug 2019 13:53:07 +0800
Message-ID: <CAD8Lp45FriB3ReFpcm1ynQRZwL+snZzPx5ZgyPGvDJ-wQx9j-A@mail.gmail.com>
Subject: Re: sdhci-pci-o2micro no longer detects eMMC device
To:     "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 27, 2019 at 6:17 PM Ernest Zhang(WH)
<ernest.zhang@bayhubtech.com> wrote:
>         Can you tell me the value of PCI configuration register 0x308 bit4 is 0 or 1?

That bit is 0.
Full dump: https://gist.github.com/dsd/e1f48fc5a6526030770b77f3e72196e9

>         And can you enable module sdhci, sdhci_pci and mmc_core dynamic printk output and send the full eMMC initialization log to me?

Full boot log with the added debug messages:
https://gist.github.com/dsd/0aec7674b12e2ae8d0be7b399068ae52

Thanks for the fast respose.

Daniel
