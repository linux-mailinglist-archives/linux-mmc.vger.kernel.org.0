Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B61AE116
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfIIWeJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:34:09 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33047 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388553AbfIIWeH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:34:07 -0400
Received: by mail-ua1-f68.google.com with SMTP id g11so4908551uak.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyzZ7zehYhgdgW33H/RHHfH+ojER9btCEjhF4ZBw3xo=;
        b=Huvo2HD+Q6gGEUDmrk3hkHjLQMYrB+mDOOFw05wBWVYVgrnDpZyuCm1o6jZVpXUcjO
         94Fqu3QxrMZW0bWR4hTe2yFWxdgv/3CtTrIb+t/6uJnKoVTXytY/q4hZLJekXd2MpUpP
         owDDEleKbJRLcfA5ilYS7xr7ebYjy0mzIoZNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyzZ7zehYhgdgW33H/RHHfH+ojER9btCEjhF4ZBw3xo=;
        b=mTYmasvqX2bL6+rFkP76orLuHO0HMoW9Ci7p1zbZfzdyCSqWkuR43Jcva87wZ7tECi
         AtMRwpgypwpljQCwt4iDZ/0F/pCVkdFToQt5Oln32O70oFynQRIccnzPqoXNMS8aeuDP
         mQNb1/COZieetox4Aj0nOjStJ40o7j6x8AGkBXX/6Y3XiIJxq6HeqMagP2Js6Tb4+T/U
         FiuuhMrs0TO445CkrXe4zBXJR2OqUa9LfWv6rgLsSFtRZDTWbDiMfXkgg3rKx7beAxLA
         5iSCOwZzxVCbQmrBJ9uwQ13epGlTpmY4blbQwGRuLl3z+cOabbDpXHfWZjdV8Prcvqn1
         1LMQ==
X-Gm-Message-State: APjAAAWKnLExlG+5PrQGOfkOT4OZsBivFLlG/1heqndHqV1Hew5neOBr
        p4CDD5kait4PTRw0BNF6GDs5hnI7aVA=
X-Google-Smtp-Source: APXvYqwZkheDkE3tg1LGYdYUhrd1FUXYxfkZB5YYPZrmbYWIVZoaMyNskxUSd1bX59eMaDl5sU/uBg==
X-Received: by 2002:ab0:7097:: with SMTP id m23mr12270296ual.89.1568068445869;
        Mon, 09 Sep 2019 15:34:05 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id t10sm3863125uaj.14.2019.09.09.15.34.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:04 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id u18so4908745uap.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:34:04 -0700 (PDT)
X-Received: by 2002:ab0:2088:: with SMTP id r8mr12584681uak.90.1568068443932;
 Mon, 09 Sep 2019 15:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-6-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-6-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:33:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XixFRMaKV8z84aBSwZirfoFmy9PcXGaD4aPuyu0BQy-A@mail.gmail.com>
Message-ID: <CAD=FV=XixFRMaKV8z84aBSwZirfoFmy9PcXGaD4aPuyu0BQy-A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
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
> The sdio_irq_pending flag is used to let host drivers indicate that it has
> signaled an IRQ. If that is the case and we only have a single SDIO func
> that have claimed an SDIO IRQ, our assumption is that we can avoid reading
> the SDIO_CCCR_INTx register and just call the SDIO func irq handler
> immediately. This makes sense, but the flag is set/cleared in a somewhat
> messy order, let's fix that up according to below.
>
> First, the flag is currently set in sdio_run_irqs(), which is executed as a
> work that was scheduled from sdio_signal_irq(). To make it more implicit
> that the host have signaled an IRQ, let's instead immediately set the flag
> in sdio_signal_irq(). This also makes the behavior consistent with host
> drivers that uses the legacy, mmc_signal_sdio_irq() API. This have no
> functional impact, because we don't expect host drivers to call
> sdio_signal_irq() until after the work (sdio_run_irqs()) have been executed
> anyways.
>
> Second, currently we never clears the flag when using the sdio_run_irqs()
> work, but only when using the sdio_irq_thread(). Let make the behavior

s/Let/Let's


> consistent, by moving the flag to be cleared inside the common
> process_sdio_pending_irqs() function. Additionally, tweak the behavior of
> the flag slightly, by avoiding to clear it unless we processed the SDIO
> IRQ. The purpose with this at this point, is to keep the information about
> whether there have been an SDIO IRQ signaled by the host, so at system
> resume we can decide to process it without reading the SDIO_CCCR_INTx
> register.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Re-wrote changelog.
>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
