Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3A3496AC
	for <lists+linux-mmc@lfdr.de>; Thu, 25 Mar 2021 17:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhCYQUt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Mar 2021 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCYQUT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Mar 2021 12:20:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C93C061760
        for <linux-mmc@vger.kernel.org>; Thu, 25 Mar 2021 09:20:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z1so2851070ybf.6
        for <linux-mmc@vger.kernel.org>; Thu, 25 Mar 2021 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOuKmIQ20L11UPWLO5kGS488XZNnGHyBfsTGAiMlJ00=;
        b=BcAU+OB9uKAgG1mFbnckboc98myqWiCKQAi9N++VHHqxShBZT0Wr29Z2btbS1v+V7W
         05VgmjXppB2By/tSjPVV8J7TVtN2dzn194gyWjJCRdNLDYz8izU2TSx3zBXDSwve4UvZ
         aMix5bmuD7bIs/cH/STPd3gQ5FQCctVTMinFSezavQTVORb+Cz5Y6Eaj+SfffM8BY58z
         4XjIaYy3DoOi4nok6yMdGldn4vpfN2i8SgEg1kRk3IMLSpXFaIAVJpi0yUzROgnTVVWy
         bfbtVTtkLDI1QqsFvBSrRRS9vm3psHvWqhTF5qC7nfSSYZ7mYLHjvM0WdqYAGZVvROfU
         DpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOuKmIQ20L11UPWLO5kGS488XZNnGHyBfsTGAiMlJ00=;
        b=tUcNE/U5OMh20pMErcABZ56mCW6BKOw9PW00qqhFK1o2bJdS6FQ0rDVb+iHRAeG7mY
         DzXyW4c19TvqKjDIznJ2nFsSdhNoJ+D7P9wp8kM7gq4Fm0DkJDwkSS5XXyiRwYnxPZl6
         zosDhL75k0kKSp0jvoGzhN9S6SxUd/04XUSReoUIxpf63gh796IrKpVt/16bzVtysAJM
         IYyVuujw0l5LqsTCWhvmM94ggyAW1u2OibswN9OyLUn0txykdoL3pcEo9q8sPHAgeSZ5
         oCtNcuXYogo9cVj8ubvbp7m2AddcNx5f8ojZftxG8A58BqJWPPpQUXEccUOjvTtUO5FN
         nFEA==
X-Gm-Message-State: AOAM533zl6EGXQe1xv6mDy7HkewBAPU9ArvgA4IW3UR7Wmmo4jeT94FJ
        xvj9zhes07sSjlJ+URWBJGL4I5xrpGcQxdz7T77aBA==
X-Google-Smtp-Source: ABdhPJyNkfTlzFw0oaZmJisGggR5uQ4R0412RTuJp2lStNkv6U/jRbMcTGtGz5SquKyOR4UKKYFOAKmGYyNCBJ+rdd4=
X-Received: by 2002:a25:3741:: with SMTP id e62mr12327870yba.343.1616689218020;
 Thu, 25 Mar 2021 09:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <161648289959.3012082.11356063123403968180@swboyd.mtv.corp.google.com>
 <363c5b7d9baca5a010552137f80a1cf4@codeaurora.org> <161660145349.3012082.16210818967187877873@swboyd.mtv.corp.google.com>
 <161660331135.3012082.15196616622122288364@swboyd.mtv.corp.google.com> <781df94a-b916-76eb-10c9-e95ba789f0b7@codeaurora.org>
In-Reply-To: <781df94a-b916-76eb-10c9-e95ba789f0b7@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 25 Mar 2021 09:20:06 -0700
Message-ID: <CAD=FV=URGPTCgXdj910tbJK-ydnE2eB21DGzhZQRqHKAt9vhSw@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 8:37 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 3/24/2021 9:58 PM, Stephen Boyd wrote:
> > Quoting Stephen Boyd (2021-03-24 08:57:33)
> >> Quoting sbhanu@codeaurora.org (2021-03-24 08:23:55)
> >>> On 2021-03-23 12:31, Stephen Boyd wrote:
> >>>> Quoting Shaik Sajida Bhanu (2021-03-20 11:17:00)
> >>>>> +
> >>>>> +                       bus-width = <8>;
> >>>>> +                       non-removable;
> >>>>> +                       supports-cqe;
> >>>>> +                       no-sd;
> >>>>> +                       no-sdio;
> >>>>> +
> >>>>> +                       max-frequency = <192000000>;
> >>>> Is this necessary?
> >>> yes, to avoid lower speed modes running with high clock rates.
> >> Is it part of the DT binding? I don't see any mention of it.
> > Nevermind, found it in mmc-controller.yaml. But I think this is to work
> > around some problem with the clk driver picking lower speeds than
> > requested? That has been fixed on the clk driver side (see commit like
> > 148ddaa89d4a "clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1
> > clk") so ideally this property can be omitted.
> This is a good have dt node.
>
> This will align clock requests between mmc core layer and sdhci-msm
> platform driver. Say, for HS200/HS400 modes of eMMC, mmc-core layer
> tries to set clock at 200Mhz, whereas sdhci-msm expects 192Mhz for
> these modes. So we have to rely on clock driver floor/ceil values.
> By having this property, mmc-core layer itself request for 192Mhz.
>
> Same is for SD card SDR104 mode, core layer expects clock at 208Mhz
> whereas sdhci-msm can max operate only at 202Mhz. By having this
> property, core layer requests only for 202Mhz for SDR104 mode.
>
> BTW, this helps only for max possible speed modes.
> In case of lower-speed modes (for DDR52) we still need to rely on clock
> floor rounding.

Just let the clock driver figure it out and remove this from the
devicetree, please. As you said, the clock driver needs to understand
how to round rates anyway for the non-maximum requests. Putting the
information here just duplicates the data.

-Doug
