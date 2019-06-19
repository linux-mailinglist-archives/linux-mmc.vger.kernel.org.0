Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EC4AEF4
	for <lists+linux-mmc@lfdr.de>; Wed, 19 Jun 2019 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFSASD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 20:18:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34420 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSASD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 20:18:03 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so3925620iot.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahQopYhdhRSibvobb60gYtWRaOOXSFvhlvKBetrMJIQ=;
        b=bPUt6J2RQNeTBWy5o8une+ywojOMMjhpDQ+GtAcvKZpB21mUrjmScuAxxYl/Ou+GCA
         UOwp5v30S43fcuRwM3CdH6VrY6rQzVDgAnP1xnSY60gVo/UpLbOa7erRfUMp/R8DPEBV
         rJavHQd6yb7YmPuF5sUwhPXXOIx5BE4Uw6QLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahQopYhdhRSibvobb60gYtWRaOOXSFvhlvKBetrMJIQ=;
        b=JJ4FLOWu/rIYV7IujlZCJtG/1+qk8AbOShqReiJYdqMkGXMD9tlURGT67g1nUggjlt
         uMjTWJENyQsd9/8xTVtWwcOH73Cc0LYA7+pFaHEH6lkuNR73eqqMtFYuaO7H26+zlTFv
         3+f0CYehEtCrK7mx1B3CiTlcJVOlVyCc7D3ll2I/w/iKh8PMOlARxD8PY1dRKLjAGg7e
         j5h2Mg00sQqzXXKWsIWUtHoLcnkGShRRwes4K4B+yx/5S3veAZKNdyx9dLzq9f6uTJy+
         6KzRivCa7Bk0QP06Cik0JUneAtImyrFTQ7urSmFxnqAkNrOk/8PRu3n53KxFNUk5rDM2
         ldvg==
X-Gm-Message-State: APjAAAX3GX60kd3C1S+GLQfCkPMsls/Hy9wh/UKEDJUKzTtB/Dad9duL
        77lKHV5HXNoYHbDFs7aTCvkb8IDTAVQ=
X-Google-Smtp-Source: APXvYqwFjuMS0lFftrbjdU8WA+ljmtvHEtK2d8UYMxW4h641914+jcZY1PEjbPA7Qkq5wNh6t7dCIA==
X-Received: by 2002:a05:6602:220a:: with SMTP id n10mr7223094ion.205.1560903481866;
        Tue, 18 Jun 2019 17:18:01 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id c1sm12730902ioc.43.2019.06.18.17.18.00
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i10so33939114iol.13
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr9682548iop.58.1560903480285;
 Tue, 18 Jun 2019 17:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-2-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Jun 2019 17:17:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJ20aabd9bRL0LhvP7rC7MOUhiRhvktnCQ81fe2hHKxw@mail.gmail.com>
Message-ID: <CAD=FV=UJ20aabd9bRL0LhvP7rC7MOUhiRhvktnCQ81fe2hHKxw@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: sdio: Turn sdio_run_irqs() into static
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> All external users of sdio_run_irqs() have converted into using the
> preferred sdio_signal_irq() interface, thus not calling the function
> directly any more. Avoid further new users of it, by turning it into
> static.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
