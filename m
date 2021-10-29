Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E61440052
	for <lists+linux-mmc@lfdr.de>; Fri, 29 Oct 2021 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhJ2Qbh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 29 Oct 2021 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJ2Qbg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 12:31:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A15C061570;
        Fri, 29 Oct 2021 09:29:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h11so17807987ljk.1;
        Fri, 29 Oct 2021 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C/nh1wSPg2qxieXH4r9qgq/nYihsX9fQ0PQvzCv1u8k=;
        b=QY7EJfShfyck1TNZ/R2aaluwJPz15sC5RiT0pKVl1JBZVtBQSxxtlPJ1sxLt3NSauJ
         CS3k6WGYEDy8OAAylkhJsCngz89Un3dxHovP4No3itSutHrrDyZUd72WZaq/i5tHjp33
         lELVUGAvVDfpR+gOelx4tk66n3mxSuPyepdsDgYLhjJ942Xk7Ojaj0+h/HPUgrqIm0PJ
         oYBdL5ErZ1oNHi3Kn4P4PHdWPZBdxADBaeRANLbbWXlgxWOpPqB08jsO0BNBX7Sw3/FW
         /qECNqXLz41564ZEAm3eAFY8BNN+76YGZTkvpTl5C2EJMJUFNomDIzfOzG30Tp71fxVV
         wlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C/nh1wSPg2qxieXH4r9qgq/nYihsX9fQ0PQvzCv1u8k=;
        b=ihHquU2vRH0RqXpJBwoQmn4u86X9SkO264iDrWNPsApfMeelJzNtWCIwQ0hn5ZBOxb
         vHGrfkM3Z61uAbf8pujixB2aaEDskxG5yKr3lr1dNU70mCx3KNoEAJhMY780EDfG+dwi
         8TOqQvzLp8H+XMLBGI+yFypHRZ9Ib0cW1Aj8EcHd+ZG//5V4v90TphBlCPRYBBO/shPL
         06L5X/UnaCq0dv83PhCX2mglM6muCZagBn6Iyw31wZE7ZkN8pLQ4kvaddukoEm+u3OHK
         wj+JjriW0jKUtN/WzF5iJt/2JXeAwn3icpqmp0wXi2wmhZQ03Hb6srHzhXA+ux1AI53U
         V3KQ==
X-Gm-Message-State: AOAM530Yty0IQoT7uXdABMbDVy6qlx02eUo8Z1AwaFQTNzMCo6r/0w0/
        bTvnh/fTJ3Ey1akHAB4kOqQ=
X-Google-Smtp-Source: ABdhPJyZDHoy7QReMDTuh43voSzqtG9TmWKveT2FDJagZ7MTM03XORP0SaqpQynyngPjXYo2byU+CQ==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr12833961ljm.440.1635524946194;
        Fri, 29 Oct 2021 09:29:06 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id 9sm433066lfq.44.2021.10.29.09.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 09:29:05 -0700 (PDT)
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20211025224032.21012-1-digetx@gmail.com>
 <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
 <CAJZ5v0i9OtA1nDiv8UXuF3ASdENFYJFV7+nMWm6Pcu=kw8k1aQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4dc8a6bd-4072-ccbf-513b-221d286bd6d5@gmail.com>
Date:   Fri, 29 Oct 2021 19:29:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i9OtA1nDiv8UXuF3ASdENFYJFV7+nMWm6Pcu=kw8k1aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

29.10.2021 18:56, Rafael J. Wysocki пишет:
> On Fri, Oct 29, 2021 at 5:20 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 26.10.2021 01:40, Dmitry Osipenko пишет:
>>> +     ret = devm_pm_runtime_enable(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = pm_runtime_resume_and_get(&pdev->dev);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>>       /* Set maximum frequency of the IP */
>>> -     ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
>>> +     ret = dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
>>>       if (ret < 0) {
>>>               dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>>       /*
>>> @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>>>       if (IS_ERR(pwm->rst)) {
>>>               ret = PTR_ERR(pwm->rst);
>>>               dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>>       reset_control_deassert(pwm->rst);
>>> @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>>>       if (ret < 0) {
>>>               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>>>               reset_control_assert(pwm->rst);
>>> -             return ret;
>>> +             goto put_pm;
>>>       }
>>>
>>> +     pm_runtime_put(&pdev->dev);
>>> +
>>>       return 0;
>>> +put_pm:
>>> +     pm_runtime_put_sync_suspend(&pdev->dev);
>>> +     return ret;
>>>  }
>>>
>>>  static int tegra_pwm_remove(struct platform_device *pdev)
>>> @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_device *pdev)
>>>
>>>       reset_control_assert(pc->rst);
>>>
>>> +     pm_runtime_force_suspend(&pdev->dev);
>>
>> I just noticed that RPM core doesn't reset RPM-enable count of a device
>> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
>> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
>> disabled twice on driver's removal, and thus, RPM will never be enabled
>> again.
>>
>> I'll fix it for PWM and other drivers in this series, in v15.
> 
> Well, for the record, IMV using pm_runtime_force_suspend() is
> generally a questionable idea.
> 

Please clarify why it's a questionable idea.
