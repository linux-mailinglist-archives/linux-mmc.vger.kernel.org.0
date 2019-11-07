Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E37F235E
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Nov 2019 01:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfKGAjK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Nov 2019 19:39:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42430 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfKGAjK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2019 19:39:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so465406otk.9;
        Wed, 06 Nov 2019 16:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+/HJxTvSCyoqhymvzvwCfhGsto5bnJFMBEXf55oU0g=;
        b=K5VMsvzFXZw3llCAPttG7LMh0RYvA9uO/lHwYpexnh75Q3gBG5NwhyH8ex9Ekwxc1O
         /+HZJm98OWZDEhKZfJzbxlTuLQiK7fSLvH4+hsxeM/u9DqQg5+bY+MXiDrLT33qIdVBi
         i/OKMABGluO+kfAUJVxe0XwtnPec67Wq/tBct6KUVp0X27BLwU9GtOc7e3Tu2AHLIoA2
         jztWF8N+MAVSpB60o9BFNlP3QQb9UZylSCvaNf+0L4NUylApXaypKnw0nbggA0Nx2Cq/
         TYJNXYaQVNBr87zcLM/0RuaeYi4Haf5xtmZsHxmRI62cLzgoErecuiwc05env5UfSP9G
         faeQ==
X-Gm-Message-State: APjAAAXOsZ5uQkXsiR7gGcPEfyXNFEQ4uVKh8EmnBdZ9IQ0iuTBIPpwq
        Wcuoza6gCMCyMdZpA9lvYg==
X-Google-Smtp-Source: APXvYqx3kcit6yKTxQqdYPFidJcqRKe6j40BSePHIBgl4Ua3SYXRmKvqCgIbr9Lwwd4KmiWwvLiJEg==
X-Received: by 2002:a9d:5c0e:: with SMTP id o14mr432330otk.361.1573087148994;
        Wed, 06 Nov 2019 16:39:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 63sm198561oty.58.2019.11.06.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:39:08 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:39:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Message-ID: <20191107003907.GA22634@bogus>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
 <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 05, 2019 at 09:32:13AM +0100, Eugeniu Rosca wrote:
> Hi Wolfram,
> 
> On Tue, Nov 05, 2019 at 07:22:23AM +0100, Wolfram Sang wrote:
> > Hi Eugeniu,
> > 
> > thanks for this work!
> 
> Thanks for the prompt response. Very much appreciated.
> 
> > 
> > > A certain eMMC manufacturer provided below requirement:
> > >  ---snip---
> > >  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
> > >  ---snip---
> > 
> > I see.
> > 
> > > The existing "fixed-emmc-driver-type" property [1] is the closest one
> > > to implement the above, but it falls short due to being unable to define
> > > two values to differentiate between HS200 and HS400 (both modes may be
> > > supported by the same non-removable MMC device).
> > > 
> > > To allow users to set a preferred HS200/HS400 "drive strength", provide
> > > two more bindings inspired from [1]:
> > >  - fixed-emmc-driver-type-hs200
> > >  - fixed-emmc-driver-type-hs400
> > 
> > Main question before looking at the code: Can't we just extend the
> > existing binding with an optional second parameter?

I was thinking the same thing...

> 
> That's a great question/proposal, but before pushing the v2 right away,
> I would like to first share some thoughts.
> 
> >         minItems: 1
> >         maxItems: 2
> > 
> > I tend to favour this approach...
> 
> The first question which pops up in my mind is related to the meaning
> of each item. The option which I envision based on your proposal is:
> 
>   * minItems: 1
>   * maxItems: 2
>   * Item[0]: Presumably equivalent to the current
>     "fixed-emmc-driver-type", i.e. the strength value applied in both
>     HS200 and HS400 modes.
>   * Item[1] (optional): Presumably equivalent to
>     "fixed-emmc-driver-type-hs400" proposed in this series. If this
>     element is provided, the first one should likely change its role
>     and become an equivalent of "fixed-emmc-driver-type-hs200" from
>     this series.
>   + Pro: Full backward compatibility. No need to touch the existing
>     users of "fixed-emmc-driver-type".
>   - Con: Not sure we have such DT bindings which dynamically change
>     their semantics based on the usage pattern.
>   - Con: Can't easily achieve the same flexibility as accomplished in
>     this series. For example, current implementation allows users to
>     define each of the three parameters (i.e. HSx00-agnostic drive
>     strength, HS200 and HS400 specific drive strengths) individually,
>     as well as in all possible combinations. This might be needed if,
>     in certain HSx00 mode, users still need to rely on the
>     RAW/unmodified drive strength. I am unsure if/how this can be
>     achieved with an array OF property with a constant or variable
>     number of elements (I try to sketch one solution below).
> 
> One option to achieve a similar degree of flexibility by using an array
> OF property (instead of several u32 properties) would be to agree on a
> convention based on magic values, i.e. below DT one-liner could be an
> example of providing solely the "fixed-emmc-driver-type-hs200" value
> (based on the agreement that 0xFF values are discarded by the driver):
> 
>     fixed-emmc-driver-type = <0xFF 0x1 0xFF>;

I don't understand why you have 3 values instead of 2.

I would just use -1 if you want to ignore an entry. If that's the common 
case, then I'd stick with what you originally proposed. If rare, then I 
think an array is the better route.

Rob
