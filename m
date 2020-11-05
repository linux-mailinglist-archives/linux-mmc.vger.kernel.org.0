Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727912A7B40
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Nov 2020 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKEKGI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Nov 2020 05:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKEKGH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 05:06:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52511C061A4C
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 02:06:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so799971pfc.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 02:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGW1ILzr61LRI7Nn5j3Px4Z853itoyrKaaACPPuanD8=;
        b=AwkPgeKN8JxD5DofrhKKvVmK4cvSq6debaCUoSYPEqvE49cn04nt/Ohj9eefgHf9TL
         aIx6rKXj0///p0JGjzTLdfu2hmMAvQApkss/uH/gSZkh61VO6pZ2ylsM9Il/53KW7LGl
         IUDWHNviUCd6hnxXLRNUeX3Y6HNhSHtWwbsLSi36WRlNoTuyeXeVCGre4buS3NdKlXZ1
         C93L+wYAB2E1lwHrDLcQqvzcXv151CIyLt/YY5KfH9h0bSL8R2KSSrdlcms3OAEXEAQn
         s+1SmPefG0RRF/HzCmYyPjNZRXZ/yeV4tDx9EOD1LS9Yd2qnGpLlBgdhBvWMqnBFNCh+
         Memw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGW1ILzr61LRI7Nn5j3Px4Z853itoyrKaaACPPuanD8=;
        b=mLNkd2AUY4PJRO758EVGKE2+fSK8LVG7ReppsSwGF+sqAEY+owELl22vxET2NpoM3H
         OOLx6tyOK9LdLCubib08GHukixDlsJrIs+0vdU+8h/gTr0nodvXkyhvM4aiipYv9XdI6
         mk5s4fPryo8pEGRvnkzHO4U8lmekB7E0InO5lSaMtJRrjLhwoBTFSKhdJEse0Ez9TmOj
         C2EcLAaTY++q8vAxi+sNexnzFNrsnqbDVRnp2yyB1ARhGj1CrNaz/DcVeXKGO0/AXzNy
         WtdZ1dDNO1e/06gest9l6P4it3y50tCHfx5ehQ6YCMYljfZ9+/D76pSLVo102QqFArOK
         SpKg==
X-Gm-Message-State: AOAM532bJ1n6Bsk6an+l1y2p3g8ORcGdZsPckxDkHYDBNKJP21swzRON
        E01R5bQBI6Dqedh7pDOyITNh+A==
X-Google-Smtp-Source: ABdhPJx+19aSHb7auOFJLKtzrXZ1adaxUM3Bi1xOIxWA6Q/xzn6rrIYE3T8B5dM0UQjbWyOAIsn6/Q==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr1700784pjb.105.1604570766580;
        Thu, 05 Nov 2020 02:06:06 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s22sm1813783pfu.119.2020.11.05.02.06.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 02:06:05 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:36:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201105100603.skrirm7uke4s2xyl@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05-11-20, 10:45, Ulf Hansson wrote:
> + Viresh

Thanks Ulf. I found a bug in OPP core because you cc'd me here :)

> On Thu, 5 Nov 2020 at 00:44, Dmitry Osipenko <digetx@gmail.com> wrote:
> I need some more time to review this, but just a quick check found a
> few potential issues...
> 
> The "core-supply", that you specify as a regulator for each
> controller's device node, is not the way we describe power domains.

Maybe I misunderstood your comment here, but there are two ways of
scaling the voltage of a device depending on if it is a regulator (and
can be modeled as one in the kernel) or a power domain.

In case of Qcom earlier (when we added the performance-state stuff),
the eventual hardware was out of kernel's control and we didn't wanted
(allowed) to model it as a virtual regulator just to pass the votes to
the RPM. And so we did what we did.

But if the hardware (where the voltage is required to be changed) is
indeed a regulator and is modeled as one, then what Dmitry has done
looks okay. i.e. add a supply in the device's node and microvolt
property in the DT entries.

-- 
viresh
