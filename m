Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47904AE117
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfIIWeW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:34:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36277 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfIIWeW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:34:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id v19so4787776vsv.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Qp29xzD8VvJiLxwfvacqSffZ0ENSm28PrjV0lzFoM=;
        b=Uf8+ffjXXmM2NbLvr4C9kbLqYl6no1tOg1R0W5/8jQvZmMtKAL9gZmXrcKn+WUfsGG
         xSC+CCOMfTRj3Ib76ParYaXGiCIcG5CSqey5aRt4HDJKBrnI3FBE+QafrOTVgUZZpfx7
         53DTzNdr0sq6u+04sJtZYmJWFJZ1h3j24/hhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Qp29xzD8VvJiLxwfvacqSffZ0ENSm28PrjV0lzFoM=;
        b=VzxZHU99V64C5Oh0ylXLV/cwKOs2JhnbFVQLySU0VZSMZfLCjwoHNs5Ke5XiZD7Rfp
         wpXD2bx75cOdn7/gGZdilz8iuTLRog/b7uX/5BQVNRdW2kHbupnkhR7iMFx+H+/ZcOYJ
         6sRy2/UBff1homBagC+PkIrZCmX3GIsrX7X4bmwRUMBmKQYgPXQLaLhi0wX6txBkkVdg
         8TyI4s0vyRLIaX4TrlRKyyMtGHAtAkpN3XCD5f4ipu9wNXR1KBhD5Zdp11xjbW7krM7b
         zByO8DUJyftzs5qTGGtmsRydiY3vfhNcdGw8TwmcoPIUPJs0x3bc+HumQ+jUIg9jnc59
         KCgg==
X-Gm-Message-State: APjAAAUXBvZDtkFuXrXuuX1NsHR6QdK/ud8Www/p8IQu+rAUKBHQf5CA
        w3J10uNklezgHuWTVU0xkC3OTk4yRsI=
X-Google-Smtp-Source: APXvYqz26K0Q4hiPvvWI1hL6HyF8X8oaiNhrWUNeejOZyA3FK/csaMg0QgXcixmleqdmDhn2xECs/g==
X-Received: by 2002:a67:e8d6:: with SMTP id y22mr2528489vsn.49.1568068461139;
        Mon, 09 Sep 2019 15:34:21 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id c5sm16485486vke.47.2019.09.09.15.34.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:20 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id w195so9905622vsw.11
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:19 -0700 (PDT)
X-Received: by 2002:a67:2981:: with SMTP id p123mr2608309vsp.121.1568068459597;
 Mon, 09 Sep 2019 15:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-7-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-7-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:34:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UM5_FzEuS5AfvA94_gKw5aog2VKDtZrnRiA_gAz+bq+A@mail.gmail.com>
Message-ID: <CAD=FV=UM5_FzEuS5AfvA94_gKw5aog2VKDtZrnRiA_gAz+bq+A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
>
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
