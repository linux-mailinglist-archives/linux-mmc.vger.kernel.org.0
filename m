Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDC7DE9C
	for <lists+linux-mmc@lfdr.de>; Thu,  1 Aug 2019 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfHAPQb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 1 Aug 2019 11:16:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39658 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfHAPQa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2019 11:16:30 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so145175709ioh.6
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2019 08:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A28GjhCVZJSUYeBqZVPzs9S8KLlBjDL+7h1oJI1m5Zc=;
        b=YDStaIin+x1zsmLPi04vXHLS9mgMXc8MW3LYOfygTTyDtWFGFHi+knILp81NZ3NI8q
         HM66RxDEFReHz53rHNa9tFPsp53m4bPLhhma0jVeN2BgYuTI09cqkAPcbpzzEB/nJR7Z
         y0c/T23/l02DSptM4yQHlCCt7ymD5BqMlm0zXJTk8ucBYIWkHpXrcLj2tL95k2NkKpXU
         ozAK4NagBF9Vv/P3TaXwdaunES9vQI6Ys3Wh9KR4XtZA8f5TRnSLIyRvkE3mBgzvxqCV
         j682Eqy4MDeQVhhElRgVe96a2k/EL6WvJ1b1x9vzjsFD8tJXhATJ4v+uUZvt41qZY+Pm
         AauQ==
X-Gm-Message-State: APjAAAU5BY+S6+//Wet88GyYWPAYjJe7Nd+1tuqezFEX2jFcDQ637CbN
        TSXT3zkF1H/1A2sgD14G/KPhWA==
X-Google-Smtp-Source: APXvYqwTmTw8q3S7+wmnzW7nURycARh98zNdnxgSBMexZJS7aGzgjb/DA1XsBfQf+Ksr20eqb+nL8w==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr3543162iom.235.1564672589576;
        Thu, 01 Aug 2019 08:16:29 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id j1sm64548891iop.14.2019.08.01.08.16.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:16:28 -0700 (PDT)
Date:   Thu, 1 Aug 2019 09:16:24 -0600
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
Message-ID: <20190801151624.GA155392@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619145625.GA50985@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 19, 2019 at 08:56:25AM -0600, Raul Rangel wrote:
> Your patch looks good. I tried it out and got over 57k insertion/removal
> iterations. Do you want me to send out your patch, or do you want to do
> it?
> 
> Just to recap, the patch you proposed + the AMD SDHCI specific patch fix
> the problem.
> 

Just pinging the thread again to see what you would prefer. I can send
the patch with you in the Signed-off. Or if you would prefer to not
update the sdhci driver at all, I can add the logic into the AMD
specific patch.

I would like to get this in so it lands by 5.4.

Thanks,
Raul
