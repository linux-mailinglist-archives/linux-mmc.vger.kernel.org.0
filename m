Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE124C91D
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Aug 2020 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHUAYg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Aug 2020 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHUAYf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Aug 2020 20:24:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F357C061385
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2020 17:24:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a13so1545827vso.12
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2020 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoAPkEBYmaAIeDj9u6a/t+uZROJQ/iwEEZfJhamo64s=;
        b=JqXFZxUaR/8edlUJGUO52Awch269UfrFWNvGMK93mUQOAETx/sKo1/K+IKzZlbPPtD
         FC/yyhxo6uamcC86ikY+GhWAxl94o5iyrh5gjd+wyoJ1XvkEU6IC31LGvsGdpHUoOwyk
         AtSEo/NfokfaIWnbailAuvhfcA62QkSvHEBw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoAPkEBYmaAIeDj9u6a/t+uZROJQ/iwEEZfJhamo64s=;
        b=D/YMYRo8LSs3ehhTC2G33HhN6sPzZxvBOW77ct3EYrzOMrdBC2N/JAmuhlU97ZuHIw
         nP+LAfHNHPLoyg4gDeCUJfeASC1sYf9oeGmkW7cq0Opw/ZdZbEqUX2pt9s8m+Pskf2d9
         Xi5FIb+UbroghkQqq5I2EgOLkIRXaxaM5qyaOdjQtCh9bAY1kbDjpvHUR+ptubQo6A93
         JEfwl40lFRnIYgRJqSomH3/I1rO9Hbx5y9EDJjW05F8g3/OXRgND9/N34F4T9I5BfIcd
         Tr6YKIiO7zEn2vrM4m7BfA4XwgGGTwK2/Tohws4/BaKoNIbfwOmRq9u+VX+SLx2mHTDD
         uhHQ==
X-Gm-Message-State: AOAM530vv/WOEIjcQOZmnYT/9GfznJkEtXbHJgOzNHpIKLMofMKVf6qM
        FxfbDe9EeRzBV+Wq0AtuWBIhdAHhhd+HwHg4yXqaIw==
X-Google-Smtp-Source: ABdhPJx/yetjbX/WSG35PdaTz5v2waeZIWjLe8s9fIBDzpDbJM8KU73V2Tv8PSUGfRhPQCUybR6SXd+XY7xll5u83vw=
X-Received: by 2002:a67:f787:: with SMTP id j7mr343336vso.79.1597969473610;
 Thu, 20 Aug 2020 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200819125832.v2.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
In-Reply-To: <20200819125832.v2.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Aug 2020 08:24:22 +0800
Message-ID: <CANMq1KC3BC4bbh9YF1r3nfOAJgQp4mVZJ11_77cwFJY9fGK-Dg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     adrian.hunter@intel.com, Akshu.Agrawal@amd.com, chris.wang@amd.com,
        Nehal-bakulchandra.Shah@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 20, 2020 at 3:00 AM Raul E Rangel <rrangel@chromium.org> wrote:
>
> The AMD eMMC Controller can only use the tuned clock while in HS200 and
> HS400 mode. If we switch to a different mode, we need to disable the
> tuned clock. If we have previously performed tuning and switch back to
> HS200 or HS400, we can re-enable the tuned clock.
>
> Previously the tuned clock was not getting disabled when switching to
> DDR52 which is part of the HS400 tuning sequence.
>
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Changes in v2:
> - Added static to amd_sdhci_execute_tuning
>
>  drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 10 deletions(-)
[snip]
> +               /* DLL is only required for HS400 */
> +               if (host->timing == MMC_TIMING_MMC_HS400 &&
> +                   !amd_host->dll_enabled) {
> +                       trace_printk("%s: Enabling DLL\n", __func__);

Please do not use trace_printk in production code [1,2], it is only
meant for debug use. Consider using dev_dbg.

[1] https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3158
[2] https://elixir.bootlin.com/linux/v5.8/source/include/linux/kernel.h#L766

> +                       sdhci_acpi_amd_hs400_dll(host);
> +                       amd_host->dll_enabled = true;
> +               }
>         }
