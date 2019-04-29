Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B452E0C4
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfD2Kpg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 06:45:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44468 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfD2Kpf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 06:45:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so5564474vsd.11
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrWyAdy2TVzxFRDk8v9J6xtJJiMI+7T59fsv/7DwBTc=;
        b=kn3KGTG/7TDCcRl9xzVIg6H2ttncroaQ/UoHUU8sPjMlFly28J+wUc2Fxpd/JtiN07
         LxCbCXA1dJcXpdUlDfH6yJWUCHiHmSdbH7e94/jzVXWTAvwJfEeyK++7aBQBvAde4SVJ
         n6/ffjpJyVm9Zy1v2Eb0xDVbv6jmqJM3NIYzSvRaVUAMLnsCZzfESzh1aYGSkm+glTSn
         fOxkqMLq3RStmWoQ6mGAGBoysIzAVhLsxCTwitxMlLfOpo0SYEuAW/c7N/w0ZfA5AZxD
         XH+k92rvUI2A+4P66CU9t/1WWd9P3xgNPcrOUDB2m4+zDTJ8aZdG93l7H+PWmtbBwVGP
         NDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrWyAdy2TVzxFRDk8v9J6xtJJiMI+7T59fsv/7DwBTc=;
        b=mOFhavXtiFNvIRr4kA11YKQOJi9wCrUke6jiLdclO7h7TwgbO5qNtMdRNKc9lGb6Pd
         woPeFuFoKDVIbr1GPE3YSp2HUaahYEsWX3H2+vqv+deTxJtu9qqh8P+6FPMrskSOdYkf
         M00yY5PhvXJaaotqJd1epKJBl+FXclFk2GlQeqBeO55vNGG42d1WAxSikZJOp0MvxVnx
         Cg/POZl19tZ/nPunZ2O24QDnz2K1W/eIsv7tQk/sa3xcRvZpimSNYMn8WQet0KDqlzrv
         6+he2lcQYTD7a7SU9S5xTvrnO/QokgtL8DWi0AVgC44kU/erxMxYpE0I1kLbPJzjMrI+
         MW8A==
X-Gm-Message-State: APjAAAW+T6ybbcn476dGFHLM0iZDD3grjScW8D7xm6SSeLPHVvMbMV+Z
        l9liBu4vGQr3ptyrYTE/bTY7YfPABxRUL1HiQ1854w==
X-Google-Smtp-Source: APXvYqzCF6xzEu2YJZblkuaHFW5fkXagcR0s/+o/AB0FpdTLP8UO07EB2JYup+xn7/1r7+KkpE3mB2NvuKaWr1PpqUQ=
X-Received: by 2002:a67:e83:: with SMTP id 125mr20023211vso.35.1556534735104;
 Mon, 29 Apr 2019 03:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190425020332.45980-1-yuehaibing@huawei.com>
In-Reply-To: <20190425020332.45980-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:59 +0200
Message-ID: <CAPDyKFqEoaNKqz-7RQwaHsWP7L=7rYcwo4=tfhbafZ+NXu3e=Q@mail.gmail.com>
Subject: Re: [PATCH -next] memstick: tifm: remove set but not used variable 'data'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alex Dubov <oakad@yahoo.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Apr 2019 at 03:53, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/memstick/host/tifm_ms.c: In function 'tifm_ms_issue_cmd':
> drivers/memstick/host/tifm_ms.c:259:17: warning:
>  variable 'data' set but not used [-Wunused-but-set-variable]
>
> It's not used any more since commit 92b22d935fed ("tifm: fix the
> MemoryStick host fifo handling code")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/tifm_ms.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index 1bbb2ead9556..6b13ac56eb27 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -256,7 +256,6 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
>  static int tifm_ms_issue_cmd(struct tifm_ms *host)
>  {
>         struct tifm_dev *sock = host->dev;
> -       unsigned char *data;
>         unsigned int data_len, cmd, sys_param;
>
>         host->cmd_flags = 0;
> @@ -265,8 +264,6 @@ static int tifm_ms_issue_cmd(struct tifm_ms *host)
>         host->io_word = 0;
>         host->cmd_flags = 0;
>
> -       data = host->req->data;
> -
>         host->use_dma = !no_dma;
>
>         if (host->req->long_data) {
>
>
>
