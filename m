Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C763A276F
	for <lists+linux-mmc@lfdr.de>; Thu, 10 Jun 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJIx2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 10 Jun 2021 04:53:28 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:42538 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJIx1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2021 04:53:27 -0400
Received: by mail-vs1-f53.google.com with SMTP id l25so1435692vsb.9
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2021 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0n9dDqvP+lODnMQ5qHqWheaeGBbbZs8YgGz8kfCeEwE=;
        b=JkDxdgQpwfa+eXaZCKAJkqqIgDJlXievjNrXMtpoIJp6+zIC1G25BQDrEvuVDpGRm0
         plRQJtPmIF08MTR5knKoO2iTXQX9rfFxoUYK1L+9CoJGzLBgyyBwx9A2KiEzcstXgM1O
         jdozPW1VC/HCG1J4vEN2akMEAhUCrSxjOBZKfqP+rAojYe3Z9JLddsVNkYmJ2gh1CnWH
         H2iBlL5JptW+Ca+jEt9McBKUWVHQ4zVe6tUMJOlycNhGzY+g7kxeNsy/9gds+usgQgKI
         3ZGc7l9fLcMiQgxSYGqeVPDXXHBBD17aSUmo81BIx5vk4U1jhPWmyNdlowhYaUs0ZTQz
         iiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0n9dDqvP+lODnMQ5qHqWheaeGBbbZs8YgGz8kfCeEwE=;
        b=aTiAViAvGgXvCVW57uN3sWsp40GUY0zsyh6sWWRT7OhewIa4ncCMlMvSTn+5Qngnqb
         OsexKyK1hwZlha8yxj05nZMt2XwFr0SZywUexBOS08epI8QyPjMURnxZaTXc9BBydpOv
         PQtcXviN1moCIZYQ0KTax/cPQXBgwCkMKfOn+3JA6TPGf+IKIVXldVsEfZR7CmNVKYwe
         j0WtROMyaJeHPW8Zgrd5k6BDg3oOLbcoHU+cDHdjZJMh1WxK7SHTBgL+7xDpcn46Es3c
         Pjp3ozKL4cjL6O9f5cKMekmnQWNVdTvbmhVNPYv4J51lfg+CmHrukenEk9uePhwr+vNu
         2JUA==
X-Gm-Message-State: AOAM531qeaeP5D/Y82iSXyKhYAUB9Zs4gie6ToFDjFGDS21yYFqzyyUL
        v9yYGxYp7RFKP8xhs5NwPrdIFMNtS1C8tyluilukJQ==
X-Google-Smtp-Source: ABdhPJzstZsJ7BuqoMSAVvMFwNv9YXy7kEZbmqM17vT0c7zJLt83fqECmPBoDLcuzViZxiKRyf+OKJntCcPl3ZSYZx0=
X-Received: by 2002:a67:19c2:: with SMTP id 185mr521314vsz.34.1623315031276;
 Thu, 10 Jun 2021 01:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com> <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
 <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com>
In-Reply-To: <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Jun 2021 10:49:55 +0200
Message-ID: <CAPDyKFqk23xg5R2k9GwQrnamwWYbMkmrbWYsHPF9VBQTAbvQHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Jun 2021 at 01:59, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/9/2021 2:22 AM, Ulf Hansson wrote:
> > On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >>
> >>
> >> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> >>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
> >>>>
> >>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> >>>> related SoC's. This includes adding a .shutdown callback to increase
> >>>> the power savings during S5.
> >>>
> >>> Please split this into two separate changes.
> >>>
> >>> May I also ask about the ->shutdown() callback and in relation to S5.
> >>> What makes the ->shutdown callback only being invoked for S5?
> >>
> >> It is not only called for S5 (entered via poweroff on a prompt) but also
> >> during kexec or reboot. The poweroff path is via:
> >>
> >> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
> >> .shutdown()
> >>
> >> For kexec or reboot we do not really care about power savings since we
> >> are about to load a new image anyway, however for S5/poweroff we do care
> >> about quiescing the eMMC controller in a way that its clocks and the
> >> eMMC device can be put into low power mode since we will stay in that
> >> mode for seconds/hours/days until someone presses a button on their
> >> remote (or other wake-up sources).
> >
> > Hmm, I am not sure I understand correctly. At shutdown we don't care
> > about wake-up sources from the kernel point of view, instead we treat
> > everything as if it will be powered off.
>
> The same .shutdown() path is used whether you kexec, reboot or poweroff,
> but for poweroff we do care about allowing specific wake-up sources
> configured as such to wake-up the system at a later time, like GPIOs,
> RTC, etc.

That's true, but using the ->shutdown() callbacks in this way would
certainly be a new use case.

Most subsystems/drivers don't care about power management in those
callbacks, but rather just about managing a graceful shutdown.

It sounds to me like you should have a look at the hibernation
path/callbacks instead - or perhaps even the system suspend
path/callback. Normally, that's where we care about power management.

I have looped in Rafael, to allow him to share his opinion on this.

>
> >
> > We put devices into low power state at system suspend and potentially
> > also during some of the hibernation phases.
> >
> > Graceful shutdown of the eMMC is also managed by the mmc core.
>
> AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
> SDHCI platform_driver still needs to do something in order to conserve
> power including disabling host->clk, otherwise we would not have done
> that for sdhci-brcmstb.c.

That's not entirely correct. When mmc_bus_shutdown() is called for the
struct device* that belongs to an eMMC card, two actions are taken.

*) We call mmc_blk_shutdown(), to suspend the block device queue from
receiving new I/O requests.
**) We call host->bus_ops->shutdown(), which is an eMMC specific
callback set to mmc_shutdown(). In this step, we do a graceful
shutdown/power-off of the eMMC card.

When it comes to controller specific resources, like clocks and PM
domains, for example, those may very well stay turned on. Do deal with
these, then yes, you would need to implement the ->shutdown()
callback. But as I said above, I am not sure it's the right thing to
do.

Kind regards
Uffe
