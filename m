Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F350A9E7
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Apr 2022 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392306AbiDUU2R (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Apr 2022 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiDUU2Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 16:28:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C21FCFD
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 13:25:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q3so6251896plg.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UEySV0DzK7I3Ur0LWxDI/vgnosJG6pJ56bIbPZMY9gQ=;
        b=HOkSQYpqvME1oE3C2IiUkZ51aNe8k3MUEsrK+jepBWwioR5nIjNh8BclZ0zx5q8xVs
         mkpaqV/+bdSVkqpU8GPemInL/rV1vajkfOslG1xo9vM/SP5001Tax+OvpMcaGHKy8N6A
         gqyBwvuqrQbSYGBzHPyDBAPbzu7lVVb7jZCpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEySV0DzK7I3Ur0LWxDI/vgnosJG6pJ56bIbPZMY9gQ=;
        b=0sVe92D359AJAwwwNKEWDBzoy2Hsglq+KaUbwVm/7bUqVubs8WVwbUrZhgahRQSvpO
         m1+rYwy0NcfN06eOLOuOjp++0p4tvFlJ7FpAohGVBekptHpBZ0b2N1ecDL2Bj5nZS8e8
         OrZPp7FSMmaJd7Z/eh30HdJuxopo3qXSRTCfUt1bX1xI9QI+lAGgGWV6BLbd7sPY7oUj
         B42cQ5xf342f+QVmb0BXgtxrmz0Ev1XpwLlYVBl+9BpxhtA1X6KeHeTAxOyvP/NwazLT
         e9pCBcaqGgKJ+Y/Y0Cf8qMNyRoSLzrT7+ERzyLTXoPBa3rYGbHQOrSiuDV9ajJn0EYjI
         mgCw==
X-Gm-Message-State: AOAM531YRB53PfPk/cWrmFUei34gR/kPrLaeEltlrY9Fd7wMXIM19qMZ
        IBWCWTmbIB21l/JyJ31QnWONzg==
X-Google-Smtp-Source: ABdhPJz7Ubc59E9HMMX6D9g97BLJYRK26lvIUBBQKnmU48NoqdR2Jv2jwAvBDap9HMew2Zo3SGwWeQ==
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id bj6-20020a170902850600b001548692a7acmr1013146plb.10.1650572724719;
        Thu, 21 Apr 2022 13:25:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm26252370pfi.86.2022.04.21.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:25:23 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:25:21 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexeymin@postmarketos.org
Subject: Re: [PATCH v3] mmc: core: Set HS clock speed before sending HS CMD13
Message-ID: <YmG9sdJ8RoKH4gUS@google.com>
References: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <CAPDyKFpQGR3ughi+6rCLUiK07Jxd5y20oK9HBjYiO-+TE8-o=Q@mail.gmail.com>
 <11962455.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11962455.O9o76ZdvQC@g550jk>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Luca,

On Thu, Apr 21, 2022 at 08:46:42PM +0200, Luca Weiss wrote:
> On Mittwoch, 6. April 2022 16:55:40 CEST Ulf Hansson wrote:
> > To get this thoroughly tested, I have applied it to my next branch, for now.
> > 
> > If it turns out that there are no regressions being reported, I think
> > we should move the patch to the fixes branch (to get it included for
> > v5.18) and then also tag it for stable. So, I will get back to this in
> > a couple of weeks.
> 
> Unfortunately this patch breaks internal storage on qcom-msm8974-fairphone-fp2

That is indeed unfortunate :( So we should definitely not pick it to
fixes/stable, at least not yet. And if we can't come to a solution soon,
maybe revert it entirely, or at least drop the HS200 portions of the
change. (The systems that inspired this change are OK at HS400ES, FWIW,
so the HS200 changes are just a bonus.)

> With this patch (included in linux-next-20220421) it fails to initialize:
> 
> [    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using 
> ADMA 64-bit
> [    1.925220] mmc0: mmc_select_hs200 failed, error -110
> [    1.925285] mmc0: error -110 whilst initialising MMC card
> 
> After reverting this patch, it works fine again.
> 
> [    1.908835] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using 
> ADMA 64-bit
> [    1.964700] mmc0: new HS200 MMC card at address 0001
> [    1.965388] mmcblk0: mmc0:0001 BWBC3R 29.1 GiB 
> [    1.975106]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 
> p16 p17 p18 p19 p20
> [    1.982545] mmcblk0boot0: mmc0:0001 BWBC3R 4.00 MiB 
> [    1.988247] mmcblk0boot1: mmc0:0001 BWBC3R 4.00 MiB 
> [    1.993287] mmcblk0rpmb: mmc0:0001 BWBC3R 4.00 MiB, chardev (242:0)

As a bit of a (semi-educated) shot in the dark: can you try the appended
patch? That's what my patch v1 did, but I changed it due to review
comments. (Either way worked for my systems.) After re-reading the
HS200-specific portions of the spec (JESD84-B51 page 45 / 6.6.2.2), it's
possible setting all the way to 200 MHz this early was a bit
overagressive, and we should be keeping a max of 52 MHz at this point.

Thanks for testing and reporting.

Brian

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1491,7 +1491,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		old_timing = host->ios.timing;
 		old_clock = host->ios.clock;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-		mmc_set_bus_speed(card);
+		mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
 
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
