Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB54DC361
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Mar 2022 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiCQJze (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Mar 2022 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiCQJzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 05:55:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB71D8331
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 02:54:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s25so8047265lfs.10
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCXxdzzj3V/3A0xK6d4iA6VZnIpM+mGxT4b3DUddSIM=;
        b=gQMhSOZGINgOThSGbrVP1SXG4DlfVxlpXhEtrHKkicc+XcaOvHh3RZzASQrfZt6GoK
         StqG3fLdr1owf98ZdDrodllY4N8hAsoXkCPr/8iaGp2GMiKNXh6U53Ia7DNetICyKjD1
         EzigLAg9gzwCwvPUDkBtfBbMqeLo4EGw8FsvNQtOB0gufOHUdDWz4q7wxLReXAEIS4dM
         tApHLTywRCcrsFq65dKcDaqVRgRacdmcIgmEg1WZtpYKzOAs2DVJ1vzRju1o0ME4rtPt
         2pI9sOXbqUcMUrPOa7qH615qWpImjYQUSyW707wBBl7T3gpYKiL8JS1dlWC+DdT8x5dq
         MgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCXxdzzj3V/3A0xK6d4iA6VZnIpM+mGxT4b3DUddSIM=;
        b=VfDfBTKCqrnu2SGSXcATBkQ6TxZ7LjyK1NqhGByD9K9kO3oon3jrHa8j7kGW8kabpg
         uX6lhcPOeryoF5tDrl5PcsxOGikW7Q4LaaCZxrMhYD+Ih8VcJyBRRA3Hmxd2Nk49qrfw
         LqRgNh4xvFKyTl2oVC3qwVClIqWiXxEwswBrPie3/BaIXntC92rrXyYtXyvx2XrjyaBW
         lNWp8q7SSYUE5B1vdAUjosyZL31Owd9qoJAULMUl24dwxd+Y894QxhjQrXcxPnxTYhpU
         u7fjU0P8hNfmLTHvj+NHtety1KU4o+LHNFz1sXnYc8HHR0glL069Vig05oP/UZf9OFOL
         l61w==
X-Gm-Message-State: AOAM533stS6s6kS5kk1Jpqz46+uf/w6pB1w4m85NJFFFOIRvKpTeymYJ
        P3eJGqd6lePjpkJCdm3OmFu3LwVz9EliEB3eS9+GrQ==
X-Google-Smtp-Source: ABdhPJzmzAKjKa58G6f1RWjMSzVqbGXrJJ78vbXzRMt2UZAF5ITJfl8DNQ+zIhJIvQACrQNepr2VJCCGmuzjJ2MrqgM=
X-Received: by 2002:a05:6512:12c4:b0:448:6d12:4434 with SMTP id
 p4-20020a05651212c400b004486d124434mr2254387lfg.71.1647510854848; Thu, 17 Mar
 2022 02:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com> <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
 <CAPDyKFoQfr3W45vWY4SnTeBG7=z3J749=WBGNtEgujvXAqAn0Q@mail.gmail.com> <3ef33014-be77-3a97-d49e-84b62d09ba00@gmail.com>
In-Reply-To: <3ef33014-be77-3a97-d49e-84b62d09ba00@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 10:53:38 +0100
Message-ID: <CAPDyKFq+81v4N5-R_Fka871uuZQEeQ3D1haG4b4to7Tg5H2oeg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
To:     Brian Norris <briannorris@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Mar 2022 at 22:57, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 15.03.2022 13:27, Ulf Hansson wrote:
> > + Heiner
> >
> > On Tue, 15 Mar 2022 at 00:11, Brian Norris <briannorris@chromium.org> wrote:
> >>
> >> On Mon, Mar 14, 2022 at 6:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 10.3.2022 22.56, Brian Norris wrote:
> >>>> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> >>>> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> >>>> some eMMC don't respond to SEND_STATUS commands very reliably if they're
> >>>> still running at a low initial frequency. As mentioned in that commit,
> >>>> JESD84-B51 P49 suggests a sequence in which the host:
> >>>> 1. sets HS_TIMING
> >>>> 2. bumps the clock ("<= 52 MHz")
> >>>> 3. sends further commands
> >>>>
> >>>> It doesn't exactly require that we don't use a lower-than-52MHz
> >>>> frequency, but in practice, these eMMC don't like it.
> >>>>
> >>>> Anyway, the aforementioned commit got that right for HS400ES, but the
> >>>> refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
> >>>> switching to HS mode for mmc") messed that back up again, by reordering
> >>>> step 2 after step 3.
> >>>
> >>> That description might not be accurate.
> >>
> >> I've been struggling to track where things were working, where things
> >> were broken, and what/why Shawn's original fix was, precisely. So you
> >> may be correct in many ways :) Thanks for looking.
> >>
> >>> It looks like 4f25580fb84d did not have the intended effect because
> >>> CMD13 was already being sent by mmc_select_hs(), still before increasing
> >>> the frequency.  53e60650f74e just kept that behaviour.
> >>
> >> You may be partially right, or fully right. But anyway, I think I have
> >> some additional explanation, now that you've pointed that out: that
> >> behavior changed a bit in this commit:
> >>
> >> 08573eaf1a70 mmc: mmc: do not use CMD13 to get status after speed mode switch
> >>
> >> While that patch was merged in July 2016 and Shawn submitted his v1
> >> fix in September, there's a very good chance that a lot of his work
> >> was actually done via backports, and even if not, he may not have been
> >> testing precisely the latest -next kernel when submitting. So his fix
> >> may have worked out for _some_ near-upstream kernel he was testing in
> >> 2016, you may be correct that it didn't really work in the state it
> >> was committed to git history.
> >>
> >> This may also further explain why my attempts at bisection were rather
> >> fruitless (notwithstanding the difficulties in getting RK3399 running
> >> on that old of a kernel).
> >>
> >> Anyway, I'll see if I can improve the messaging if/when a v2 comes around.
> >>
> >>>> --- a/drivers/mmc/core/mmc.c
> >>>> +++ b/drivers/mmc/core/mmc.c
> >> ...
> >>>> @@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
> >>>>               old_timing = host->ios.timing;
> >>>>               mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >>>>
> >>>> +             /*
> >>>> +              * Bump to HS frequency. Some cards don't handle SEND_STATUS
> >>>> +              * reliably at the initial frequency.
> >>>> +              */
> >>>> +             mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> >>>
> >>> Is card->ext_csd.hs_max_dtr better than card->ext_csd.hs200_max_dtr here?
> >>
> >> I believe either worked in practice. I ended up choosing hs_max_dtr
> >> because it's lower and presumably safer. But frankly, I don't know
> >> what the Right thing to do is here, since the spec just talks about
> >> "<=", and yet f_init (which is also "<=") does not work. I think it
> >> might be like Ulf was guessing way back in the first place [1], and
> >> the key is that there is *some* increase (i.e., not using f_init).
> >>
> >> So assuming either works, would you prefer hs200_max_dtr here, since
> >> that does seem like the appropriate final rate?
> >
> > I think that makes most sense, as we are switching to that rate anyway
> > just a few cycles later in mmc_select_timing(), when it calls
> > mmc_set_bus_speed().
> >
> > That said, I have recently queued a patch that improves the
> > speed-mode-selection-fallback, when switching to HS200 mode fails [2].
> > We need to make sure this part still works as expected. I have looped
> > in Heiner who has been in the loop around this change, hopefully he
> > can help with further testing or so. Maybe $subject patch (or a new
> > version of it) can even make HS200 to work on Heiner's platform!?
> >
> >>
> >> Brian
> >>
> >> [1] https://lore.kernel.org/all/CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com/
> >> Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
> >> selecting hs400es
> >
> > Kind regards
> > Uffe
> >
> > [2]
> > https://patchwork.kernel.org/project/linux-mmc/patch/20220303164522.129583-1-ulf.hansson@linaro.org/
>
> In my specific case this patch makes no difference. My test system is a
> dirt-cheap Amlogic SoC based Android TV box. My best guess is that maybe due
> to chip shortage the vendor omitted some regulator, making the eMMC card
> refuse the switch to HS200.
> Therefore my test result doesn't speak against the proposed patch.

Thanks Heiner for confirming!

Brian, I expect you to send an updated/rebased patch that we can test
and review.

Kind regards
Uffe
