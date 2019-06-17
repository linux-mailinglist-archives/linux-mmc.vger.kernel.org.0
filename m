Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2166480EE
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfFQLfl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:35:41 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36669 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfFQLfk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:35:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so5883541vsp.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oarxy7p2A8M3e32Cd3ZGKiQh3eZMCQGravoCB5ouj68=;
        b=JnWxiIKJnHT6irJrl0SZV7N86mxeB7Jog5bebll+L/jQV3DuM2fXmD5S85vgPJAYI4
         xp+XPND9LYJ24EcwVkhr5CbRgW2AQ83dPZ5s3Qxr8RIwzSsgy/pJpKTu3JSn4w9wXSQh
         zRkHooSvQLAR1gJgYp4uv6e2+fZ6pb16OOdtveCojyGEJ4S6PF1d14oFNEY9wgy+XVsI
         lAF6/UPGt1H8OdgAcCw/BPfa60GC1X4Anw7X9uXrHcPasGBWUuBkaFCgCaYGBQ3/XIAB
         1Z+XkOSQ9252AzTMwiKYPnTo1JVJveshNtwKTiFEnNlEmN+PxsOVxotew2kAaQtc1/y3
         FKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oarxy7p2A8M3e32Cd3ZGKiQh3eZMCQGravoCB5ouj68=;
        b=M6MIcOzTlEWi1ERNCirB3MENqksjXqw+vXGqkfTDsXP7gTo4TqQCy6fi0oPjhPITj+
         Jq40oG7KEwquMB8sCHTZzvU6gFujclwychHEUx9KCwuUNs3GnDRrbvFXd0tYLXe1pwcf
         PlT9VX11FyukfwGVoQ4jV9RKSkhTydiaNqF/G7yp1WQat6I4/7yHExtLwGguMLH8tj15
         fuTczYwistTDzHgiu2jteFbUBVev91j/MkYMOLL6PfNAQcV3LqynZl8+9/NbEEcr9m6/
         kTURevw+9TuFO/svJeLMj0DaBtFlt+IiODOkStmC+NbQX+4BkZFhgghEX92XLBTCmK27
         JVjw==
X-Gm-Message-State: APjAAAUY7yuM3JBZV/WxwfnekI5E/SBmtRG9AtaL1zbeuNJ6Xi/rU3DC
        P/BKRt2fk8a1i+SCsmRFnncUCAZgkmgFmfuD1iLEmg==
X-Google-Smtp-Source: APXvYqwcHEVwhj3FTseMM1MQYfqpoVrbYJpW+a7vzqtz0JpcbL/XOQHVC14jXXzahRuLm4BZ4JoZKMxnEhMY0YILz0A=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr60218560vsp.35.1560771339760;
 Mon, 17 Jun 2019 04:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190604060914.10886-1-faiz_abbas@ti.com>
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:03 +0200
Message-ID: <CAPDyKFqt9N+Hn-VhEr0ANv3zXLGyjCDEDiBgEx8FpLFBBzT0EA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add Support for MMC in J721E
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 08:09, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches add driver support for MMC SDHCI interfaces on
> TI's J721E devices. The 8 bit and 4 bit instances have phys which are
> different from the am65x interfaces as well as different from each
> other which leads to 3 different compatibles and a bunch of flags for
> indicating the differences.
>
> Depends on Nishanth's initial J721E patches here:
> https://lore.kernel.org/patchwork/cover/1077382/
>
> Also depends on my fixes for AM65x driver here:
> https://lore.kernel.org/patchwork/cover/1079924/
>
> Tested with: j721e-evm and am65x-evm.
>
> DT patches will be added in a separate series.
>
> Faiz Abbas (4):
>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>     controllers on TI's J721E devices.
>   mmc: sdhci_am654: Add Support for 8 bit IP on J721E
>   mmc: sdhci_am654: Add Support for 4 bit IP on J721E
>   arm64: defconfig: Add config for MMC on AM65x and J721E devices
>
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |   9 +-
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/mmc/host/sdhci_am654.c                | 257 +++++++++++++-----
>  3 files changed, 204 insertions(+), 63 deletions(-)
>
> --
> 2.19.2
>

Patch 1->3 applied for next, patch is for arm-soc, thanks!

Kind regards
Uffe
