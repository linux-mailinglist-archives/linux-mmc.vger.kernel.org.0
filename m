Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F83B93C
	for <lists+linux-mmc@lfdr.de>; Mon, 10 Jun 2019 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbfFJQST (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 10 Jun 2019 12:18:19 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39688 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389693AbfFJQST (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2019 12:18:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so3255019uan.6
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2019 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6g1amzGWWTQeL8UKEkhr7i0NSGU3hAL+N1/E/jI22oU=;
        b=HW2FcNkw1AyM5mPhc3BzCW7VqIn+zDEUsDp9c7wLJbnEl5Un7a0jKcvgDhCuVGJvGo
         Fnug+8k4fWm7ZtvyifH/b/IQcP6/Iy2gfvgzPn8J/lHw6SsKYNxdDCmUnV/Ho9cq35dH
         jfGEVMX7X8lKSt13GoNfNuhTkuur75bRrtI/VAvkbdVwhVHIBLIN+7BkTht9ZnVzZVXR
         qwECBLoyf5X9do7m9ExCrWzlHtJVNureBX8Y5fCqV/rMZDdO+1zJmR4GASXeA/nRkFje
         hqLVlcEv7+JuP5noiUFATLX4IaDQhJd8kke/VnDOw2mPm7tsgA4EdmheT7sfoquowH9O
         SfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6g1amzGWWTQeL8UKEkhr7i0NSGU3hAL+N1/E/jI22oU=;
        b=muDXUHAhZEYepoytJiUclsYqeEYMi7MJS8x+DhcQpgriuajcao8VSordmNPDPmuV+j
         qDv/oZmMRRPoJsE0XaI0FuRJyD2hwuIL0kMnHnKpAFWz1XxV6BRKJ084NpTq8TFOOWud
         DYXmvD7l87Ihle6AjJVAeWJnySEVom7Z8XXqYa9OzhhipMJCwSVEwu1YNDQ8qO2KXtRG
         /xU7K3fO2rwthIlXC4+nErPVn5q1zRivAvulIBaojsL+7MaeK35Xn5fM05P7SzcEfCe2
         pQ7tXz5i5fhkdlCXjsuyGMAOr1Z7IaY+BOl70CRn7i1uemfd3s9o5vm+PDzqilkjwet5
         RMCQ==
X-Gm-Message-State: APjAAAWg/OpYPIsfvmk53lJ9pG/q1ewZKkISnQyJuxiBCpgIST3Hw3Lc
        UaTl54RmO93S6khjkcYdIBEJyuYxzzsWjCEjSqLXXQ==
X-Google-Smtp-Source: APXvYqxzift3FGWOoRmlryYDkKUogOyNP3CyhjdC9W22whl+Ilq7gSYSG/OUBCNzJMIhFO+RYFyExhE6ozK950Cek+4=
X-Received: by 2002:ab0:2705:: with SMTP id s5mr5731944uao.104.1560183498453;
 Mon, 10 Jun 2019 09:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190606113537.8869-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190606113537.8869-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 18:17:42 +0200
Message-ID: <CAPDyKFr_LG5+kGnNstO7Q4rOy7hNJBDdqFmhDD5q2gMHCwxddA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: sdhi: improve HS400 quirk handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 6 Jun 2019 at 13:35, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> There are some more SoCs which cannot handle HS400. Add them and clean up the
> quirk handling a bit. So, patch 1 is suitable for stable, the rest isn't.
>
> Note that I don't have that HW, so I am relying on the provided information.
>
> Changes since v1 (thanks Geert and Fabrizio!):
>         * use '[012]' to specify the range instead of single entries
>         * add RZ/G2M to the list
>
> Wolfram Sang (3):
>   mmc: sdhi: disallow HS400 for M3-W ES1.2, RZ/G2M, and V3H
>   mmc: sdhi: improve quirk descriptions
>   mmc: sdhi: remove unneeded initialization
>
>  drivers/mmc/host/renesas_sdhi_core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>

Applied patch 1 for fixes and by adding a stable tag, the rest is
applied for next, thanks!

Kind regards
Uffe
