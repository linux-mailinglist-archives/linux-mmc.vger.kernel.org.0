Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BFB42A5E
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439949AbfFLPIj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 11:08:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37852 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439947AbfFLPIj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2019 11:08:39 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so13234482iok.4
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jun 2019 08:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4gvFWYtLkStySYeJfjihrXgSdbJ0qlhnGb7+tRwORE=;
        b=mirQb1WEf+WTbLdbG5tYilELnChxG1+MMgrGciy2FtfQpE4w6L+NOCntjOIpnnxpaU
         DIRWwS2+tSrimP16wZE8guFxoLbbO+HTkMiE7+fiRBv0YOXWJ/BVb7qBwKjTbebamvHq
         3u/dayoRl8DGw3vRtGYb7nUonj3LDrHJukYikBkejP1uhGgGpDeBN78njhOcyo3CW+nE
         bm5MTHyW/5t/ECob/sLMqN6VjDbBs8M4ofAYYgKVeMZwahFxCftj4n2PIkXvAt6dZQf4
         ARQUlnyo8YudVTPBhys6Q4E6lOjh4ODuj1/sRMJwwMgDO/QxCM6fo+d+dIeXkXGakJDo
         if/g==
X-Gm-Message-State: APjAAAU1HTwXZ3tGTCdIwFcBrbvHFZqxPGogKfSuM5Ib7DSW0VFqk25f
        X239NdFLQsyOo6v9/L+RbO/cSA==
X-Google-Smtp-Source: APXvYqxK1hRQsgALi0VHul0lTs5bK+ur4L3afqWtrN6Wlx3LUGoNVKanGehF3d+4VuDJOvL7K4QEqw==
X-Received: by 2002:a6b:38c3:: with SMTP id f186mr8698281ioa.187.1560352118211;
        Wed, 12 Jun 2019 08:08:38 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id j1sm4147iop.14.2019.06.12.08.08.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 08:08:37 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:08:32 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, ernest.zhang@bayhubtech.com,
        djkurtz@chromium.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
Message-ID: <20190612150832.GB27989@google.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <20190610185354.35310-2-rrangel@chromium.org>
 <d4939761-317c-ee78-b1e5-c2cdd86a12b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4939761-317c-ee78-b1e5-c2cdd86a12b4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 12, 2019 at 04:09:47PM +0300, Adrian Hunter wrote:
> On 10/06/19 9:53 PM, Raul E Rangel wrote:
> > The O2 controller supports 8-bit EMMC access. mmc_select_bus_width()
> > will be used to determine if the MMC supports 8-bit or 4-bit access.
> 
> The problem is that the bit indicates a host controller capability, not how
> many data lines there actually are on the board.  Will this break something
> that does not have 8 lines?

So I asked the controller vendor about that:
> The capability shows the host controller can support 1,4,and 8 bit bus
> data transfer but it also depends on if HW can support it. Driver or FW
> should implement the bus testing procedure that is defined in A.6.3.a
> in JESD84-B51 spec to decide the real bus width that is supported in HW.

This seems to be what `mmc_select_bus_width()` is doing.

I don't actually have any 4-bit hardware to test with though.

Thanks for the review!
