Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7973121
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXOJA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 10:09:00 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43766 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXOJA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 10:09:00 -0400
Received: by mail-vk1-f196.google.com with SMTP id b200so9392786vkf.10
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNyKSw1b0BFH7hEBuSw7mVMVxq7kJcdNkxyS+Cg9xks=;
        b=vdCnmLQCv+4BvDXwhMgI6Ezf0AWqLvQCi/K3hs6ht/mhZhj+xdcSEFByJ3lXJ3Dcsb
         8EKOOv/TNekiq9c3b0qWQJHeU+FaR0kOWqx/kACuNFBJMqrqA2jkKmjJHTo0bivU/dZt
         AZyfKI7NsourdpaRrA7HXeCCH2hYx0Cfex+5BgQRHGfHHrkhlB+B5ZKIkUy6xn3yS7i1
         G2/GQf3mj4/4FVpS+fb9cYCFYA8hT01ifLqSHnrGdbrIB58fEOJXEyFVA7KQTvbmfdDd
         IdJdB9fS0ZoGeYasxWgjgqwgmapdB/Vzb2kBJFTOuXfSUnFHA4E+ezXmXhWJKcGIiH6y
         wBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNyKSw1b0BFH7hEBuSw7mVMVxq7kJcdNkxyS+Cg9xks=;
        b=omx9j+pjyMq4yR2O3e9og8fHarApc0GQvyVoPeklxh7bnpAvI/grPlYkaNOALrCU3N
         pvqI7m9FutBc9tPqhG0zXpJR0B277Yyn3cYsy1iDRHBlLzvWlcK5TAAbxuNWtLylYEiu
         dwRdVVLvd5/0CN647Ddlzt6NFYi3MVzSb+J6K3Suj12sLt4bIJsTgRN/yAc+zLfRs+bJ
         aHiIycxCTdA3WnHti8HW1WMwq4+x4vUdoXNadItbGWvG+KEkbhLUkaOb+OKNEyT9hcw5
         J/t1kvAKBXWUESCp0KtZxI4zQTgJRndgYQZXu75J5OiKZGbuKxQr3MAe9JpVZYgZoEoF
         rOig==
X-Gm-Message-State: APjAAAVnrkisCChmd2am5gDtbbgQmNGzn5pFZ0oLPmkWK+S35tjlU7Bb
        SYtYjBO2q1dOHINkNrCrox5LPmx+v+ut99xYJ4TKsQ==
X-Google-Smtp-Source: APXvYqyBfk3A+DBmRnUUMwpnWBfD1DwKsmcBdqRA0G1REeo/kgh1iwrZk/v6EipnNbTYHcYk7ZE6K39Cn6yKh0Dqxec=
X-Received: by 2002:a1f:9f06:: with SMTP id i6mr32052907vke.52.1563977339258;
 Wed, 24 Jul 2019 07:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190723115044.18591-1-hslester96@gmail.com>
In-Reply-To: <20190723115044.18591-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 16:08:23 +0200
Message-ID: <CAPDyKFpThB0Ktyp5a=ZrLST=VvztbGEvdHr1HHzouOa23+nN0w@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 13:50, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/host/r592.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 2932f421b3ea..dd3a1f3dcc19 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -847,8 +847,7 @@ static void r592_remove(struct pci_dev *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int r592_suspend(struct device *core_dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(core_dev);
> -       struct r592_device *dev = pci_get_drvdata(pdev);
> +       struct r592_device *dev = dev_get_drvdata(core_dev);
>
>         r592_clear_interrupts(dev);
>         memstick_suspend_host(dev->host);
> @@ -858,8 +857,7 @@ static int r592_suspend(struct device *core_dev)
>
>  static int r592_resume(struct device *core_dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(core_dev);
> -       struct r592_device *dev = pci_get_drvdata(pdev);
> +       struct r592_device *dev = dev_get_drvdata(core_dev);
>
>         r592_clear_interrupts(dev);
>         r592_enable_device(dev, false);
> --
> 2.20.1
>
