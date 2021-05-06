Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08937544C
	for <lists+linux-mmc@lfdr.de>; Thu,  6 May 2021 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhEFNCN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 6 May 2021 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhEFNCN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 09:02:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6611C061763
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 06:01:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u20so6888295lja.13
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=QGh/DMr3YWyJIdVxRuhgHcwYIwiGHeFKTvJnh/dtmauMQqI1wHd5Evea76xe9greed
         XtlHlw0rF6mL92DCBVZeB2+U7xlO0HJJZqamj5hTGEMkci98EHlifnwnNF0IiKcVuXgf
         cBmN3x8SvgbS7DWu+3Vun+cEPE6P/0YkUqjtLY6Se4NZ9vXx+dAfER56e+NsAzxJFHpl
         Wy/VupXQjfBonvEZeg3XnOwVi/P0sWXhuzY+txk2/wjJOva2ppjDV86zKuVu95wVUgBL
         lZL3AKRPWncJSitolznnmAbmQV7ZDE5fPfQfBgaxygmNRphn0k0jk7jGCdSoqvhkWfQy
         ZC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=VBp+5/dq5ovChZujsgjiyxsDLLVBVScpU6Do04r6yPDE9DidVJz3WgV2lbXB4V0uMW
         wCBqHoL9zk9xwn9iDBEBcFHnfX1aN7St50g+noVG/kI8Ie9SlhMpV8Z1U8FwJf0bFKFI
         UxHmT24UJN+5AnfjcWBVgGHu4lSwaE+7tNOw8Dw3pFRJRcokn9hUleiU5QmXnmvXxp+8
         oSbcZcZX9HpVw7PkXn+TJiCiyspCrs55tWYK9nmveGtIdDHKWmjdVD0RAmL5R9tUz1ey
         ql8hheK1Uz/UwfkXDMhGwYpqMkLPIg8Qp+wXYxe41XDYg7aLF2+YvlCbm191yDedkFBq
         C0oA==
X-Gm-Message-State: AOAM531hdx37CIEnBqFaXQ2pvgJzYXm7Nj9yfrhyyLDSeuAR2ZMRSM2u
        yhWphEP6gpTiszWuwtXVddVwDuEzeeSYjNFFgGyctg==
X-Google-Smtp-Source: ABdhPJxumvyre7G9VDri6pSA5PmkdD26UhUC2qL62jApVicOYFEU8vPDiZEavFOFM6F7HT1ITASFFaIz9QjawzPlJys=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr3177134lji.438.1620306071975;
 Thu, 06 May 2021 06:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-9-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-9-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:01:01 +0200
Message-ID: <CACRpkda9fWzeqLvSX4-fr1hcP7KqWrRQGSFvCM2STYNM_FkL9Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of
 CMD48/49 and CMD58/59
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

> In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
> optional features. To let the card announce whether it supports the
> commands, the SCR register has been extended with corresponding support
> bits. Let's parse and store this information for later use.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
