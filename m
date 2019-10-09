Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95ED0AB0
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfJIJNO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:13:14 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44259 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIJNK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2019 05:13:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id w195so1011160vsw.11
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2019 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=za9fk/xyK0FxrtT/I1V53jGYA+lfqH+7lVc/V3WNJlk=;
        b=hZn88+vpHZoMfFLxZ+39oHKvW66KT2WPdnuHIxqtW5DSihehgX3AOtIoSqwZzsTze6
         aYoyfq1mQriEzujnfPeVHU159nbM2zsSZZDD7KPhxViOD2a2TYxvRFFwFilxmxOyM5SX
         Aun8EdTEhx/1m1PvnXXr3cITgJK5QPaJ8AIPwKD+fGrmVP5PqGgBFukNQkNBVHWGclth
         v0nbSt8IT80wN7fqEo3gGj3hCBQqry0Ga5FdwZbtyfilPLzbyWwM6DCIfAnSyXLJV1n0
         lSZgEmGSR7XRrxkp5lZLjCDhGTFsCT6APddb6gIDcVFtc2LIaZ01v8CHiMGRvfibR4+R
         8h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za9fk/xyK0FxrtT/I1V53jGYA+lfqH+7lVc/V3WNJlk=;
        b=Veftniz9vmLDMdSfwJIFKAB5QT2Ru2TVWimr+oQXusTI3zRIEefQ9swNxn/MN0YGnb
         nGpSY5HGkPpEhJA4zmi1o5B/PtWRQLt+ANhWTe29AbxRLaJZXER1ro8OKRj9czopJQAM
         NFKWeFqaEXxYzvsQKNXBamtS31Ma7QSx3xqyqHQrh7TJQ7P3/FE/WCamjackT0MU8jYF
         Z/7/d24Rd1r8FOUkUovEcdx8HdIcGgH6uk6Vfss4bo0OZ/qz/5ZZ+9hb8OPWvCyc/ftA
         dd5jFhjaDUB9ugLTKToTU+DLxmNTZmzU4t2cWu7vZbt7CEH1K9vffrOQqB57elm2CCx+
         YhNA==
X-Gm-Message-State: APjAAAXBFrzChUtOLf5q7Bf6lpdZ7nZHZLIyqG7IEuF8KCZPwV2fnwcA
        WQd5dEapjHNk/jcDeN9+Ut6rTpYTWG37qj3UNUzNmQ==
X-Google-Smtp-Source: APXvYqwucjkOmh4hjJCRGk3+DwDB+6UbAbQEcAMHoFPN+PD4DGjDriLM+mXKLxkAVPSMrxV7ZwVIMnPBLKZM7UFTJsE=
X-Received: by 2002:a67:cf05:: with SMTP id y5mr1235261vsl.34.1570612389903;
 Wed, 09 Oct 2019 02:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191005112101.14410-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20191005112101.14410-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:33 +0200
Message-ID: <CAPDyKFp6=6JsMSg7PV6zEohw16FeQ07G_VWSM1qFxmqswfrqFw@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Will Deacon <will@kernel.org>,
        gustavo.pimentel@synopsys.com,
        Colin King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Denis Efremov <efremov@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 5 Oct 2019 at 13:21, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If 'jmb38x_ms_count_slots()' returns 0, we must undo the previous
> 'pci_request_regions()' call.
>
> Goto 'err_out_int' to fix it.
>
> Fixes: 60fdd931d577 ("memstick: add support for JMicron jmb38x MemoryStick host controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index c4a477643977..0a9c5ddf2f59 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -941,7 +941,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
>         if (!cnt) {
>                 rc = -ENODEV;
>                 pci_dev_busy = 1;
> -               goto err_out;
> +               goto err_out_int;
>         }
>
>         jm = kzalloc(sizeof(struct jmb38x_ms)
> --
> 2.20.1
>
