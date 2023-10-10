Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661017BF93A
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Oct 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJJLIm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 10 Oct 2023 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJJLIl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 07:08:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A256AF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 04:08:39 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7b3d33663so13165707b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696936118; x=1697540918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yoUO++5OHOnxZZDqfJI5HF1MKHhl2PMBrF0tTuSB4/4=;
        b=MHPxFBcN7qQDHUQdfya3S86qXFkKvWMsr7m/FbSb3RKLXFAlDkzHvwnCYaZZn8VI4P
         Xv+hWDFyj0a82VCSbv5iJstfxrPbRha5v/5XxHdDdtYgEIxlmtSnp+K1u8Bm3/BmRyxg
         +mnWR+EHOTkcd0DWuwrDeLnyOp7lVrcKg9FHTFZN0LWmYmGBGsXeAkP2/3j9wCWTg+VN
         badiwrwy1knd59qqBKk0a1xdl9hDhgeG3tCJ70I3ooaE39F8TtsWSy/Pl5sfQdk2cWkn
         xsTcgDxIgJqobNa3ig/qVQfOryXUOAuMPkilPjxWM6c2a935ZfIY1wi2Pm47Sd0DIots
         Krzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936118; x=1697540918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoUO++5OHOnxZZDqfJI5HF1MKHhl2PMBrF0tTuSB4/4=;
        b=sfAzv3MRyFhyBu+775ClfOxgck1FDUMAMIkCvMsQPghNfe7jQme1cYGsUWHkVH1HD9
         jYiRfmfqnsSL+9G8kAP21NkuzkAE0m11+TgKA0Rb1h4utQxyesjGhqmnUiCPw2Kh18PE
         B9k3zIVrSv5Gg1G0+E2pDYNR9ALKPyvoTc/d6lsksBNmsb/EMROk9xdg4mEoTyLX/yEl
         dnSjv1lq2kJkUuNhGIGAZTb2VmLQKplfdA2C6Tj+aLMGarZpeb+35kmv6G8txcr3RCba
         ZRfgris6qSq7YcUmQ5TNXNSD/CHGF2iptyf+Ldl8bt3XiQ+/tqPBqxXPA3KH+vF3h2ew
         nWZA==
X-Gm-Message-State: AOJu0YzyIifMJG1eAlIWl4/s2O9W+Qpmskne6qieQZZRmF2ubrt40ybq
        owLhqRUXn31QaIrygn0ovCzsaehFeANcqRSDqwFZQw==
X-Google-Smtp-Source: AGHT+IFS6BO5fWCDG/MfxYZsNz7Fo1VAl1C0Q+SDMzQiQ95SB74PljJKm4ddTS8OMhgnIrGAIZB8FEzXACrEQToOicE=
X-Received: by 2002:a25:b190:0:b0:d1b:c879:5e6f with SMTP id
 h16-20020a25b190000000b00d1bc8795e6fmr17033724ybj.23.1696936118573; Tue, 10
 Oct 2023 04:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com> <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
 <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com> <CAPDyKFqidGZ242P-9xnxokSCeGxk8uziqR=AteWt=iQFz5fA9g@mail.gmail.com>
 <81bf38cd-b6a4-4a6f-a51d-bc916e3b8f96@intel.com> <CAPDyKFoc0phsXuX5W0PqFu2En57Lc9D-+MTGxAYtJhPpHcVZ2g@mail.gmail.com>
 <d76a9fff-5536-4e3e-b1c3-234de427d031@intel.com>
In-Reply-To: <d76a9fff-5536-4e3e-b1c3-234de427d031@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 13:08:02 +0200
Message-ID: <CAPDyKFqsu6-9U7qQRTB7oDubj5WAp+UQVzLitLytUdamDZQW6w@mail.gmail.com>
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Victor Shih <victorshihgli@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Oct 2023 at 12:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 4/10/23 11:35, Ulf Hansson wrote:
> > On Tue, 3 Oct 2023 at 17:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 3/10/23 15:22, Ulf Hansson wrote:
> >>> On Tue, 3 Oct 2023 at 13:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 3/10/23 13:30, Ulf Hansson wrote:
> >>>>> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
> >>>>>>
> >>>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>>>
> >>>>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >>>>>>
> >>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Updates in V8:
> >>>>>>  - Adjust the position of matching brackets.
> >>>>>>
> >>>>>> Updates in V6:
> >>>>>>  - Remove unnecessary functions and simplify code.
> >>>>>>
> >>>>>> ---
> >>>>>>
> >>>>>>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
> >>>>>>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
> >>>>>>  2 files changed, 47 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> >>>>>> index e339821d3504..dfc80a7f1bad 100644
> >>>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>>>>> @@ -10,7 +10,9 @@
> >>>>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>>   */
> >>>>>>
> >>>>>> +#include <linux/delay.h>
> >>>>>>  #include <linux/module.h>
> >>>>>> +#include <linux/iopoll.h>
> >>>>>>
> >>>>>>  #include "sdhci.h"
> >>>>>>  #include "sdhci-uhs2.h"
> >>>>>> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>>>>>  }
> >>>>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>>>>>
> >>>>>> +/*****************************************************************************\
> >>>>>> + *                                                                           *
> >>>>>> + * Low level functions                                                       *
> >>>>>> + *                                                                           *
> >>>>>> +\*****************************************************************************/
> >>>>>> +
> >>>>>> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> >>>>>> +{
> >>>>>> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
> >>>>>
> >>>>> The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
> >>>>> should be using mmc->ios.timings, which already indicates whether we
> >>>>> are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
> >>>>> this.
> >>>>>
> >>>>> That said, I think we should drop the sdhci_uhs2_mode() function
> >>>>> altogether and instead use mmc_card_uhs2(), which means we should move
> >>>>> it to include/linux/mmc/host.h, so it becomes available for host
> >>>>> drivers.
> >>>>>
> >>>>
> >>>> UHS2 mode starts at UHS2 initialization and ends either when UHS2
> >>>> initialization fails, or the card is removed.
> >>>>
> >>>> So it includes re-initialization and reset when the transfer mode
> >>>> currently transitions through MMC_TIMING_LEGACY.
> >>>>
> >>>> So mmc_card_uhs2() won't work correctly for the host callbacks
> >>>> unless something is done about that.
> >>>
> >>> Right, thanks for clarifying!
> >>>
> >>> In that case I wonder if we couldn't change the way we update the
> >>> ->ios.timing for UHS2. It seems silly to have two (similar) ways to
> >>> indicate that we have moved to UHS2.
> >>
> >> Perhaps something like below:
> >>
> >> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> >> index aacefdd6bc9e..e39d63d46041 100644
> >> --- a/drivers/mmc/core/sd_uhs2.c
> >> +++ b/drivers/mmc/core/sd_uhs2.c
> >> @@ -70,7 +70,8 @@ static int sd_uhs2_power_off(struct mmc_host *host)
> >>
> >>         host->ios.vdd = 0;
> >>         host->ios.clock = 0;
> >> -       host->ios.timing = MMC_TIMING_LEGACY;
> >> +       /* Must set UHS2 timing to identify UHS2 mode */
> >> +       host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
> >>         host->ios.power_mode = MMC_POWER_OFF;
> >>         if (host->flags & MMC_UHS2_SD_TRAN)
> >>                 host->flags &= ~MMC_UHS2_SD_TRAN;
> >> @@ -1095,7 +1096,8 @@ static void sd_uhs2_detect(struct mmc_host *host)
> >>                 mmc_claim_host(host);
> >>                 mmc_detach_bus(host);
> >>                 sd_uhs2_power_off(host);
> >> -               host->flags &= ~MMC_UHS2_SUPPORT;
> >> +               /* Remove UHS2 timing to indicate the end of UHS2 mode */
> >> +               host->ios.timing = MMC_TIMING_LEGACY;
> >>                 mmc_release_host(host);
> >>         }
> >>  }
> >> @@ -1338,7 +1340,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
> >>  err:
> >>         mmc_detach_bus(host);
> >>         sd_uhs2_power_off(host);
> >> -       host->flags &= ~MMC_UHS2_SUPPORT;
> >> +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
> >> +       host->ios.timing = MMC_TIMING_LEGACY;
> >>         return err;
> >>  }
> >
> > I wouldn't mind changing to the above. But, maybe an even better
> > option is to use the ->timing variable in the struct sdhci_host, as
> > it's there already to keep track of the current/previous timing state.
> > Would that work too?
>
> The host does not really have enough information.

Okay, let's go with the approach you suggested above/below then!

>
> >
> >>
> >> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> >> index 517c497112f4..d1f3318b7d3a 100644
> >> --- a/drivers/mmc/host/sdhci-uhs2.c
> >> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >> @@ -267,10 +267,11 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>
> >>         /* UHS2 timing. Note, UHS2 timing is disabled when powering off */
> >>         ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >> -       if (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> >> -           ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> >> -           ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> >> -           ios->timing == MMC_TIMING_UHS2_SPEED_B_HD)
> >> +       if (ios->power_mode != MMC_POWER_OFF &&
> >> +           (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> >> +            ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> >> +            ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> >> +            ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
> >>                 ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> >>         else
> >>                 ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> >>
> >>

Kind regards
Uffe
