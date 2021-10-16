Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935F43036B
	for <lists+linux-mmc@lfdr.de>; Sat, 16 Oct 2021 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhJPPis (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 16 Oct 2021 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhJPPir (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Oct 2021 11:38:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1FC061570;
        Sat, 16 Oct 2021 08:36:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i24so54405169lfj.13;
        Sat, 16 Oct 2021 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iXmHQbdUUEj7iD9UdLGIRExPe2SbeX0x9hgeURTYmuQ=;
        b=gy+a/5BSaOUZjjMeREUgCptM2ybr7PF148YGvG+CqztuyGq8LBhigc7vHDIIyQZ4RR
         nCkxVRmxG6APD0+J/FGkfKxkl0tNsjzP7W5/HDgmaFfOHmvbOI3WCtMY70n8umX8yEJV
         FJGDPXjLDrI9pGt9cpA+/Wo5Ds2dyHODEA9wSoRG9q3PsnHlqMpubsdtzMh+a+j199o6
         sBrVM5rVaDlfadaBelsLV+JFBxj2s8A9ruw+Th0rjBkgDfinqABq4j1GP6WbYKhHhnWW
         e25hnD271Cbz3yMZERuOiAdnU4nILxFmsh9aOU6cSv/0XCWbnrMGgN49CuZqdBiLmYgo
         PhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iXmHQbdUUEj7iD9UdLGIRExPe2SbeX0x9hgeURTYmuQ=;
        b=77+wQh5JSBvSRipG4bflGBZadMuOCKuoPz4zRYjNOoM7i83MvqLsfzFxgYPTFYB2y5
         pEVKasO991N6S89jOoOhZ1zKa5cycPk4n7ZaQbjnBP5HCTgzkDHkToC4ndG8nMb4AMe5
         d5KSiVukiDXNPJ+J71wnoFelNHkmln40qArHEg0yZVc5H0L0OydIDbwJqU7lIH8C792I
         DKohOws2kGx5oq1wqohQdEvGzKSgpzMyYJTzNE2LkZogzrMHlyxLAuekJ79fVZ4R+gTt
         HOD2KjDopLVtWKsWdKTzwM+gvr+Q2s7esoUeDi0sNggCPwp92j0gjW2FLrcEDUVFh/sX
         9iVw==
X-Gm-Message-State: AOAM531yzIB82WTrmLXDn7gN8ShM1V5KzzFPf+UtrAbkMDKNMihZmVDy
        X7qs26TZ4lsOA+7HCF/tF+o=
X-Google-Smtp-Source: ABdhPJxtvgN0MWJt4cva3KTlHcgZzj89zboYkD6ihnqr+bNLevlFAbbJkDz7ATXU/w01SNAG8MS09Q==
X-Received: by 2002:a2e:a544:: with SMTP id e4mr15585258ljn.225.1634398597937;
        Sat, 16 Oct 2021 08:36:37 -0700 (PDT)
Received: from [192.168.2.145] (46-138-48-94.dynamic.spd-mgts.ru. [46.138.48.94])
        by smtp.googlemail.com with ESMTPSA id w26sm1021100ljh.18.2021.10.16.08.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 08:36:37 -0700 (PDT)
Subject: Re: [PATCH v13 11/35] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20210926224058.1252-1-digetx@gmail.com>
 <20210926224058.1252-12-digetx@gmail.com>
 <CAPDyKFobSsFOnmFc4BG353uYgECGD1U1U020oQwB7pX0mfCfvw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9bb95684-de30-697a-139c-1e3e54dade2a@gmail.com>
Date:   Sat, 16 Oct 2021 18:36:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFobSsFOnmFc4BG353uYgECGD1U1U020oQwB7pX0mfCfvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

01.10.2021 16:27, Ulf Hansson пишет:
> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Add OPP and SoC core voltage scaling support to the display controller
>> driver. This is required for enabling system-wide DVFS on pre-Tegra186
>> SoCs.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c | 74 ++++++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/tegra/dc.h |  2 ++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
>> index a29d64f87563..d4047a14e2b6 100644
>> --- a/drivers/gpu/drm/tegra/dc.c
>> +++ b/drivers/gpu/drm/tegra/dc.c
>> @@ -11,9 +11,12 @@
>>  #include <linux/interconnect.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_opp.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/reset.h>
>>
>> +#include <soc/tegra/common.h>
>>  #include <soc/tegra/pmc.h>
>>
>>  #include <drm/drm_atomic.h>
>> @@ -1762,6 +1765,47 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
>>         return 0;
>>  }
>>
>> +static void tegra_dc_update_voltage_state(struct tegra_dc *dc,
>> +                                         struct tegra_dc_state *state)
>> +{
>> +       unsigned long rate, pstate;
>> +       struct dev_pm_opp *opp;
>> +       int err;
>> +
>> +       if (!dc->has_opp_table)
>> +               return;
>> +
>> +       /* calculate actual pixel clock rate which depends on internal divider */
>> +       rate = DIV_ROUND_UP(clk_get_rate(dc->clk) * 2, state->div + 2);
>> +
>> +       /* find suitable OPP for the rate */
>> +       opp = dev_pm_opp_find_freq_ceil(dc->dev, &rate);
>> +
>> +       if (opp == ERR_PTR(-ERANGE))
>> +               opp = dev_pm_opp_find_freq_floor(dc->dev, &rate);
>> +
>> +       if (IS_ERR(opp)) {
>> +               dev_err(dc->dev, "failed to find OPP for %luHz: %pe\n",
>> +                       rate, opp);
>> +               return;
>> +       }
>> +
>> +       pstate = dev_pm_opp_get_required_pstate(opp, 0);
>> +       dev_pm_opp_put(opp);
>> +
>> +       /*
>> +        * The minimum core voltage depends on the pixel clock rate (which
>> +        * depends on internal clock divider of the CRTC) and not on the
>> +        * rate of the display controller clock. This is why we're not using
>> +        * dev_pm_opp_set_rate() API and instead controlling the power domain
>> +        * directly.
>> +        */
>> +       err = dev_pm_genpd_set_performance_state(dc->dev, pstate);
>> +       if (err)
>> +               dev_err(dc->dev, "failed to set power domain state to %lu: %d\n",
>> +                       pstate, err);
> 
> Yeah, the above code looks very similar to the code I pointed to in
> patch6. Perhaps we need to discuss with Viresh, whether it makes sense
> to fold in a patch adding an opp helper function after all, to avoid
> the open coding.
> 
> Viresh?

I'll keep it open-coded for now. This code is specific to Tegra because
normally ceil error shouldn't fall back to the floor, but for Tegra it's
expected to happen and it's a normal condition.
