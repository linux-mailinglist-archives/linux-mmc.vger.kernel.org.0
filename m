Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88284375459
	for <lists+linux-mmc@lfdr.de>; Thu,  6 May 2021 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhEFNFZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 6 May 2021 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhEFNFY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 09:05:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEFC061763
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 06:04:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y9so6945211ljn.6
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLhu4a2qeeKN1ThghHVgWBhHswj+unmP67cSTUVDirw=;
        b=JXcpFGSsXkuwB65R3OnXVCm0UFidSXxrn6blltm71bquZl9btHIMhI9GAQYYzSaLeI
         xgea5q7+rY4XwJmcP9mtlaCMnDA83ceyMo6JrHum1coXn3p37qE9U56lv5OIqSsaxbi9
         DU/ImjVgNR4X2YxaJiMt51dcjYeUDG4lVvJpsdksMADuvyLmNPbpWleWToY0IdzwE6tF
         MtfY64u//1KbZ12PZwct/ury/h9OOWaVaJh5L/AZhg+xeYJBhxqg/0QoovcSTRxEQtcn
         ZlK49trxBeYvOAUG2zFOe1Wx9qLNB8my0Haj49rwJqN/h3Vu7yrELBe6J5tmjUeRg8tg
         6rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLhu4a2qeeKN1ThghHVgWBhHswj+unmP67cSTUVDirw=;
        b=a2nq0Z68CZQTW0MQqq1kf6nfftQj/Pn7ApHVj0bTUCU27P0PpTyGak9SIA5Et6U+dg
         rSfo2SgMNuEDvKqaa2KKjeUNfVNJ9e0sfvGA/gfQrmqqeyqbB1kL2/mwJADtR+22K1fn
         sEmV9mT/g+SiYC16BSk5YO6ksoXlTYP42ayqyPHXGXXuLOaixyN56+6OKQp7NVJLCPWA
         oFV07kYi1VaFLogwR+jY7ekrcC1o/KVzA4rbTq+V8UJK+J2TXUpJv/lvaLuxzg4qFZu3
         qJ2zgRKPto+DYm8P9tS419qvwGkXpW1jVpd/TfrT+cYzAGtOOH9fJxAG/gJh11YIGkuK
         fVdQ==
X-Gm-Message-State: AOAM532P/78W+fpdTUU5vgzbi9LHE+F2/JwOPC/RXrYpk1Yjk7PabnDV
        lIxePA6/+3b/UN2DsH03ItBaiDjWWI/Rn0Kku2E2gQ==
X-Google-Smtp-Source: ABdhPJwyHJtAXrS4OXMtzTzkXb2QMw08W7FLMIWBQGmGPNPCLKn10DtCdbNkaX4ss2LpI4zkSHvC3xbWLsqrLSX844Y=
X-Received: by 2002:a2e:a369:: with SMTP id i9mr3212788ljn.273.1620306263997;
 Thu, 06 May 2021 06:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-10-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-10-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:04:12 +0200
Message-ID: <CACRpkdb_qqJJ2aXb+bCxzm1yoeAy0qeUitCVByFNKinAa4zGhw@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: core: Read the SD function extension registers
 for power management
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In SD spec v4.x the SD function extension registers were introduced. A
> specific function register were added to let the card announce support for
> optional features in regards to power management. The features that were
> added are "Power Off Notification", "Power Down Mode" and "Power
> Sustenance".
>
> As a first step, let's read and parse this register for power management
> during the SD card initialization and store the information about the
> supported features in the struct mmc_card. In this way, we prepare for
> subsequent changes to implement the complete support for the new features.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks to me like it will work just fine.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
