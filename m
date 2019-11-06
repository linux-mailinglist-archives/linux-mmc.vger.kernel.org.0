Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F460F149D
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Nov 2019 12:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfKFLHw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Nov 2019 06:07:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40219 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFLHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2019 06:07:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so19035196ljg.7
        for <linux-mmc@vger.kernel.org>; Wed, 06 Nov 2019 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdaR/A6qMHiim50O03q+OAKJlWT9Z0gP8U4qJnk9Mh0=;
        b=jWd8Bov1oIr4KrrJy1fYL+2da7qX0u5wOHzbHaO0hLtS4HcwHCs+YZVpc+LDwH3eM9
         uGXJrlYbH0JFcLiTtslqAYhAh4cvqGJHzixNoVrF/I85OVEPGtGEbnBxoHtFMuGKPiU/
         5ioP0VVF4tgtjIFkyr8l9VG4GifdJTWugKgMftcY82wOmVAwpvi5g+SqcK4WwGXnNz0Q
         LmRQ6/XkQo3j5qDzG2ZBWoRhDRalrvcu6Ruch8G1wqENajFl86T0BhZGKJDHdAnxzf0e
         8qeQy/vbmSFFQ6R/2BQiV/cmLmQ7E17d3Ku6fzWxeaAOKsDhYAZ3+cZBcPgvM2OKVaqr
         RDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdaR/A6qMHiim50O03q+OAKJlWT9Z0gP8U4qJnk9Mh0=;
        b=gfwbxOdZKYhQhoOQs0jyW9lhiqy7UHIgIFlCkVICqPhuJe1JLDtSsO6/Isw/+F7wZg
         B14knTC09Sx9EugU1OHy4da3XZO2NtIj8H9VSFtcsh01L1BtipVYaeemUV3B8HozQ2Iq
         gslwTZoGr+v8DkLIhO3wxa/ZTL9WEeHdPpXhxVulS5AckJUL0LG5rWjZdBmfmBV7gjIy
         dhz3RloIQT24vXAZtcJvG4iCWXtpBNRxyj3Aoy3xFjYRjTk3AXP/ZMCMsUpoGGAaQXZt
         1XZim3ejwzoWwG2RAde30tqjvEVwJTu7nSGcDLMmpq81ERHTy4mlNSboSstSceAMa85U
         yGaA==
X-Gm-Message-State: APjAAAX7NHEH/y1f2sA9ZV+iP4wMtc5IGDZ3laX/zRSsXyVRMN+iKIky
        bcl8RyjvgSYsZIivPANWJiJ08xNuF/EyIFTfOzkgNA==
X-Google-Smtp-Source: APXvYqzyiaX/Yy0nyFGdygzKLrBMvmRtjeygWbYpBI2eNgmQmcKuSQcSQ/wJOc2AHlSrhxM2nsC2r/jdY3/1OnW0NfM=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr1497622lji.77.1573038470593;
 Wed, 06 Nov 2019 03:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Nov 2019 12:07:38 +0100
Message-ID: <CACRpkdbO6df3OKn4wnz9LMjf4i94jQPs9n_Cdzv7boWMZDCovA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Eugeniu,

thanks for your patch!

On Tue, Nov 5, 2019 at 6:50 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> A certain eMMC manufacturer provided below requirement:
>  ---snip---
>  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
>  ---snip---
>
> The existing "fixed-emmc-driver-type" property [1] is the closest one
> to implement the above, but it falls short due to being unable to define
> two values to differentiate between HS200 and HS400 (both modes may be
> supported by the same non-removable MMC device).
>
> To allow users to set a preferred HS200/HS400 "drive strength", provide
> two more bindings inspired from [1]:
>  - fixed-emmc-driver-type-hs200
>  - fixed-emmc-driver-type-hs400

I am sorry that I do not quite understand but as pin control maintainer I
am of course triggered by the talk about selecting "drive strength".

In my book this means that the pad driver on the chip, driving the
line low/high with push-pull (totempole output, usually) is connecting
more driver stages, usually just shunting in more totempoles.
(Ref https://en.wikipedia.org/wiki/Push%E2%80%93pull_output)

If say one totempole gives 2mA drive strength then 4 totempoles
gives 8mA drive strength.

Are we on the same page here that this is what physically happens?

Usually selection of drive strength is done with the pin control
framework, so this would need to be backed by code (not in this
patch set) that select pin control states that reconfigure the
SoC pad drivers to use the requested strength.

Alternatively, the (e)MMC block would implement this control
directly, but I doubt it.

Please clarify which hardware is eventually going to provide the
drive strength alteration, because I just don't see it in the patch
set. Is the assumption that the (e)MMC hardware will do this
autonomously or something? That may be a pecularity to the hardware
you're using in that case.

I find the fixed-emmc-driver-type-* assignment a but puzzling
to be honest, isnt' the driver device tree already specifying
what the hardware can do with all of these:

mmc-ddr-1_2v
mmc-ddr-1_8v
mmc-ddr-3_3v
mmc-hs200-1_2v
mmc-hs200-1_8v
mmc-hs400-1_2v
mmc-hs400-1_8v
mmc-hs400-enhanced-strobe

If the host is already specifying mmc-hs200-* or
mmc-hs400-* then certainly it should be implied that the
host supports hs200 and hs400 and there is no need for
the fixed-emmc-driver-type-hs* properties.

The code detects when to use each mode and that is when
you can insert the code to switch drive strengths, whether using
the pin control framework or something else.

So to me it seems these DT properties are just introduced to
hammer down a certain usecase instead of letting the code with the
help of DT speed capabilities flags determine what speed is to be used
and select the appropriate drive strength.

Yours,
Linus Walleij
