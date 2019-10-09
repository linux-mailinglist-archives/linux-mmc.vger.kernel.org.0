Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F90D0AA7
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfJIJM4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:12:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44017 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbfJIJM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2019 05:12:56 -0400
Received: by mail-ua1-f65.google.com with SMTP id k24so531504uag.10
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2019 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1GmngvaE0ei9mnU0CMOs2O9a2/80q1j0u6r2u5SeZc=;
        b=BccNwjKJUEGqADR82Dz9D/6hW+muC5tovZ4TZzhwUcNnNClOKsj/TwIl0wYjsBc6x/
         k1jtHRsZBJkB5XEBmk3c3UjCkpbbJEm71c44rBeHs/1RinFqBdS/F2PzyJWDllL97ZWq
         R36grS6Yw8KUikd970xY+zw1tW0efxzzxuwQj++jIOgnM40NPOcZT1j0GIHNir/gUb9D
         SsbIN4DTBuySQXcqwM56bQmkLUurSE8OGIOQjpx5TF3imZWJgl5h8U/i/wbheVJOR3uU
         XV1QEGFlVmSwqtsGm4UUlvuHWl+RqT5TEvnUXoXnM54OWXZ+iKW12DFa69CWmIskhgBS
         w/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1GmngvaE0ei9mnU0CMOs2O9a2/80q1j0u6r2u5SeZc=;
        b=Y2dqZEhF/pJA38mAaeA6sroeXBqTB1s4SuSI1RXNaqGJ8t2YEoluluGq3HT64Zawd/
         ccplL1bkCIRjZD0rWr/grMALMKtkUExf2aOEWeW53Xvut0L1ktDbS1MNBUUGhJAlNuAw
         6VNI6CP75U94cem6mdzCC9vu+BaYyBKrMakyemeVHGbo8Jl0xD5v6PZO4cj+hE8G2EBT
         DXuXIvB8Nbt/56/KjLz02Xlu3VqxsTImJCyASNhfP/Xj3a3EFnizkS7Z2kIxDLG0mF3l
         xjsKtObqHeh72Ph099yXG/uuwtXEVm0rkx/tt4hJExqVqBe8p2cibNHiSmaGW3gGIfb7
         aL8A==
X-Gm-Message-State: APjAAAUdEUejjTZn0XKK7cZ3NMjjbGuGAsc/A93VjhjP6wey2ZMdxL9s
        VO0nzjPeV87fgdCP1iVIKtEeK1DsYSqGrFk0jMhdlw==
X-Google-Smtp-Source: APXvYqzHUvKtG9TlAFWzdGLKFE3B3LLPRPS/NhDVFx+CEadl3quKcUNTlMODJCYW2p+AVM5OUZYunx3BcWwMwDCc9Ds=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr1234478uao.104.1570612375253;
 Wed, 09 Oct 2019 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:19 +0200
Message-ID: <CAPDyKFqDB_aOikZYSDEvQKF3PsD=AXq0PZJTj8AUAH0XaGj8Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Oct 2019 at 03:28, Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>
> Therefore, add a new compatible, to adapt the Intel's LGM
> SDXC PHY with arasan-sdhc controller to configure the PHY.
>
> Linux code base : V5.4-rc1
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM
>     SDXC
>   mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
>
> changes from v1:
>  -  commit message updated
>  -  Acked-by tag added
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
>  drivers/mmc/host/sdhci-of-arasan.c                     | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)

Applied for next, thanks!

Kind regards
Uffe
