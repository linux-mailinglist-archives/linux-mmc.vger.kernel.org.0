Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7363D5C
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Jul 2019 23:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGIV3v (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Jul 2019 17:29:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35610 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfGIV3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2019 17:29:51 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so200872ioo.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5QQKjGCkPUBJ3N6ztbQJBr6O1cRaWimyf2pTOCKgLk=;
        b=jll6IGtD/1yH8UUSpbpyax3paURWIk58RTSuww3ABCR6BfaRyNeTG43u7r3588IC3L
         EMWHTxrpndJ0BtZ0LGFdmb9xSKg6re5gZfe3TBkXxxtLKbVm8l6s2uHUfnbSgTzMLewA
         B5aEXmlRybYdU7QDBe23q61CUBVt1dVVFQcGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5QQKjGCkPUBJ3N6ztbQJBr6O1cRaWimyf2pTOCKgLk=;
        b=o3vfWES1Un9xezFWvnoIAE490TNQMhFMUI2q/LZDvat7iyYBVwaSIKLYb/MyQ7RBqg
         8/Pk5nzLD99JCvfsFnwkuG3wvfFyyEQbAvxUsY6GqfeLtOo5H3mc1THvXbLU3qVc/oE3
         CZetDZDFuc5EMe01L/kPSrUBRWJEM58ZROxjp+G271iYkoTCLLh46BHzRj+RxKvr+kbf
         9eR1bn7g8GgN80nRR0p4q92BM/uZ6DdysZcAGUtMKt09VA3gcnljQphg4nEnvOaI+Nk2
         hOMjRRNe96wGYk9o7fvoizIT7z1wIvZ99TvunJG2xdzHfBtdkaFVCODr5y08J4vMug6u
         RCBw==
X-Gm-Message-State: APjAAAXIXntSEvJP9kC7c1/PZ8QhnuGOLaYGNj5vhzxDMqdSRrOfeBOE
        I0O40saBx9ezyWW4BfbwTr848N+bnok=
X-Google-Smtp-Source: APXvYqwHE6Hji99pG/ou1Eutws62Z3vhB/upq7kj1GK1NPACsf7dxWuFk5e+I7h9zlVzgjcqwmG2cA==
X-Received: by 2002:a02:5b05:: with SMTP id g5mr29353155jab.114.1562707790352;
        Tue, 09 Jul 2019 14:29:50 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id p10sm28171189iob.54.2019.07.09.14.29.48
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:29:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id o9so190846iom.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:29:48 -0700 (PDT)
X-Received: by 2002:a02:ac03:: with SMTP id a3mr31371347jao.132.1562707787910;
 Tue, 09 Jul 2019 14:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-7-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-7-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:29:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X49wubSaqp8JQ6_KduE+SdnVh51MGQ1ELgZyZeL7W3Sw@mail.gmail.com>
Message-ID: <CAD=FV=X49wubSaqp8JQ6_KduE+SdnVh51MGQ1ELgZyZeL7W3Sw@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
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
> The "powered_resume" in-parameter to mmc_sdio_reinit_card() has now become
> redundant as all callers set it to 0. Therefore let's just drop it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
