Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3432AE119
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfIIWe3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:34:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35450 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfIIWe3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:34:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id b11so9955034vsq.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uKn57lFOcZJRC0waWtjBCYVHQrktLOwjpylqAIocBE=;
        b=hT7S2S3A5LRDDsAHmdxFXDuEqQuO8/hNDC6KOuDOvVekoEombOVU8xLQeyM47bKn1O
         rNW9mVx9vCfFumzrMoUNac6RM4UoMUPMMMhvICFRVk8gMI7yg1AB5eRnB5d3uO53034N
         tjqfLDf+VRf8bA0Y9TNXW35HiKT38bz1QOhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uKn57lFOcZJRC0waWtjBCYVHQrktLOwjpylqAIocBE=;
        b=GjAz0+QDA/CGqvLsKUhZTTSWpznzqaIuhHi3yIVFohuXVSmOVU9DZ9rFVt/3kL432Q
         1ibHulv//0hhn+f24U4OUlFgj9Yu2plGxe6VhmEgTtL2ihbWEciM3z4x9uK5kjUNL5fU
         4KLAUP1LrMdMxmEgQU3zN1GzW1WuYsZFeNOL7P+1JsIhgow/SHoLGFiJcHZpajGIf3cw
         hcb2szNhDzDMlpgQHYNj2WWvyTA1ueZnqD3/tlPSdvXHbUE7Z9Qk7zGj00K3iXMu+qPG
         XnfLNxa/hC07PtVD26poWOLKld7NgdhmkyqIIecMbLaoiUflm4vYBLwsEXnjrZhbQwfd
         uRUA==
X-Gm-Message-State: APjAAAVGstUOscZlf+TrtiIUI9Yy65CnBUYuAosyrKuoKI/JoQ9z7ktb
        S5u9Rqt0W8MTMdL/GOxJ3qVBaqRnSL8=
X-Google-Smtp-Source: APXvYqx/sZy21L5op2yzCIc4OZmaPl/VdKRa0jI9x9fpoaRxgdpuPgjLTIgdKqx+n2rJBUvqqsUdiw==
X-Received: by 2002:a67:ed90:: with SMTP id d16mr8302743vsp.167.1568068467944;
        Mon, 09 Sep 2019 15:34:27 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 11sm3018629uas.17.2019.09.09.15.34.27
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:27 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id j5so3117918vkn.6
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:27 -0700 (PDT)
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr1414955vkb.4.1568068466575;
 Mon, 09 Sep 2019 15:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-9-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-9-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:34:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+eqnMX9TuyBhi7r_qjG39P9dtHHO9=PvKOvRKuoOvKw@mail.gmail.com>
Message-ID: <CAD=FV=U+eqnMX9TuyBhi7r_qjG39P9dtHHO9=PvKOvRKuoOvKw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
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
> System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> behaviour. Some problems have been taken care of so far, but more issues
> remains.
>
> For example, calling the ->ack_sdio_irq() callback to let host drivers
> re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> which may not be the case during system suspend/resume. This may lead to
> that a host driver re-signals the same SDIO IRQ over and over again,
> causing a storm of IRQs and gives a ping-pong effect towards the
> sdio_irq_work().
>
> Moreover, calling the ->enable_sdio_irq() callback at system resume to
> re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> count for some host drivers to become in-balanced. This then leads to the
> host to remain runtime resumed, no matter if it's needed or not.
>
> To fix these problems, let's check if process_sdio_pending_irqs() actually
> consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> ->ack_sdio_irq() callback.
>
> Additionally, there should be no need to re-enable SDIO IRQs as the host
> driver already knows if they were enabled at system suspend, thus also
> whether it needs to re-enable them at system resume. For this reason, drop
> the call to ->enable_sdio_irq() during system resume.
>
> In regards to these changes there is yet another issue, which is when there
> is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> has been system suspended. Currently these IRQs are just thrown away, while
> we should at least make sure to try to consume them when the SDIO card has
> been system resumed. Fix this by queueing a sdio_irq_work() after we system
> resumed the SDIO card.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Queue a sdio_irq_work() rather using sdio_signal_irq().
>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
