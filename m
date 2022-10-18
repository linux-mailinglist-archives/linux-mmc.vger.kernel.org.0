Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407E60313C
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Oct 2022 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJRRAE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Oct 2022 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRQ7v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 12:59:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BD56030
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 09:59:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so17972590pjg.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0l2HZlOZuWdOYo1ROWax2muHI31wxqlPHYjTm43zec=;
        b=PcuH5Qmpe7v1S++KPeobFTZuJ1OT0/3Mf1vuV/rdjGtACw7E4w3+aC1KCXZssWFge0
         Iu/XPMhvL7F3sJqOR9h/GULUOS/0uZqUKxnUNQDvMcW6zADq97FjU9tKTbOUREhVCPsY
         sjzU+3CIpByK647KAuTGK+9fz5B+ME/WdZ1E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0l2HZlOZuWdOYo1ROWax2muHI31wxqlPHYjTm43zec=;
        b=asyO1tqbiC4ugnUR0llcoqB2j8VrtritTwfGXSFNZF4XF7zDbBw8fZl/b8aOW/WoIm
         S66kIpEy7UGH6Um0eaBfdDCgugn/rxj2aojw4AuwxPpborH9eAx2unOq5SA1a9E0DNjW
         QiiHwkLGDpI8RN7XZP3gfwW7BqsOYecbI50U2ixIkmvonrtE+X2cKk8tqEEhUeEQOwBS
         6RZfSid7sDx4zs6Qd02++i8N3Zukxav1ZFy5dlM54NINosqncAOvJ5fPQqahbvh1UyeW
         3kpbzlXdrcOXeYnFS9EyOh7pBnsknYCHpuz+dq0Kyb4ejHZRwUArHOFi+3jr6MKNEdMF
         I+jA==
X-Gm-Message-State: ACrzQf2uH1PvbLme0xr3VbZyVPnPazc7+8hUQ6y8ZwLaDs0Nr94rtT5l
        vRbPqBYStzt7TTaU79oqfjDFQA==
X-Google-Smtp-Source: AMsMyM6Rlzv5RCnrpSOJBD3bV+5CLiPqwDe1Lc9YkBbLohQwy95ZHPsRszbYr/mpVmfAeOr1YrsZkQ==
X-Received: by 2002:a17:90a:c90c:b0:20a:7179:b14f with SMTP id v12-20020a17090ac90c00b0020a7179b14fmr4574348pjt.58.1666112388295;
        Tue, 18 Oct 2022 09:59:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:2ac3:f4e2:e908:c393])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b001782a6fbcacsm8888930pld.101.2022.10.18.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:59:47 -0700 (PDT)
Date:   Tue, 18 Oct 2022 09:59:44 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y07bgNd7KbLDttsq@google.com>
References: <20221018035724.2061127-1-briannorris@chromium.org>
 <20221017205610.1.I29f6a2189e84e35ad89c1833793dca9e36c64297@changeid>
 <e7816e4a-8558-0de0-e25f-d10abd0ef1c3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7816e4a-8558-0de0-e25f-d10abd0ef1c3@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, Oct 18, 2022 at 07:13:28PM +0300, Adrian Hunter wrote:
> On 18/10/22 06:57, Brian Norris wrote:
> > So like these other patches, deactivate CQHCI when resetting the
> > controller. Also, move around the DT/caps handling, because
> > sdhci_setup_host() performs resets before we've initialized CQHCI. This
> > is the pattern followed in other SDHCI/CQHCI drivers.
> 
> Did you consider just checking host->mmc->cqe_private like
> sdhci_cqhci_reset() ?

I did not, although I am doing so now.

My first thought is that this feels a bit too private. Is the host
driver supposed to be memorizing the details of the CQHCI layer?

But on the plus side, that would remove some contortions needed here
(and also in sdhci-brcmstb.c).

Here's another option I previously considered: teaching
cqhci_deactivate() to check cqe_private itself. That would have the same
benefits, while keeping the private details in cqhci-core.c. How do you
like that?

(Tiny downside: cqhci-core.c got its rename in v5.12, so backporting
this to -stable would get slightly more difficult.)

Brian
