Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061C64CF3B
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2019 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFTNoX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 20 Jun 2019 09:44:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39359 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTNoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jun 2019 09:44:23 -0400
Received: by mail-vk1-f193.google.com with SMTP id o19so573343vkb.6
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p96jy0Q37G25+vp9fBBi4D52+67/LDOfa3YA/vvK0nQ=;
        b=Fvpo3fPVn86Oj4E+YvaQl8cPyYuhY74EG2gRxBzGmwQxo9dhUFfK46Wqbe1s5F1S7M
         RIlP2GrtASd4qeqv1PFUPUs+l/pAlAE3I1CLEi/CjvgjMA7U9vgMsNYv8ssajGLHZ68o
         KydVSn6PhK8V3C2MopVEsZ/2B7TF3V0taFOL6Z1mnCyzT56fLKwJD9s46GJ/HalkbgMP
         jwawGHaYAJ6UQphwTrTu4ulc8pMlKHOtg/Abl1egApahf41i41Jc0cl/AsePPhWHUavJ
         z1/FozbChnurp8WdOi/0pjZS/yDVLLky+I4f3s3PaXImG90fA70/swzetjAgmiQgP3ne
         qxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p96jy0Q37G25+vp9fBBi4D52+67/LDOfa3YA/vvK0nQ=;
        b=k/Wtfu0auedsdxZ21ZQGr/P7rnwflQpAuLx4mIfxut6R/IdQJSWo6SScLRPWn8lxBi
         +V1j3NQ3TXfbAB55Js37vDZOo3Xazl/2m4JEsNyFzMvCs958BxEnQrAmHDuczd7JqETt
         N5Ve+cDTJBE3qWhlFfEJ1VPOLXaPEzECkEXk57AwZ/0lxNqc/ObSbVMrJ9pRcqqrCuYX
         Q3YkLbtJ3WneQRzatqqlIRumo+wUcNbxHzaLm16jMwvMnn42ELYt4x4Uy31pE2iZwUpZ
         WuMTz+BkW23VIEL4K4p5QwdDlzqPqu5QsUVhi+r4f8/0aqt4hyro0CrNGT1627RpROjp
         QwRg==
X-Gm-Message-State: APjAAAXbVtpssQ1CRL/UDPoegyPCMqAiq+cuiWKqy+ogBViotYrHOmiW
        3qaXRZGmdfomaG7JLDl7JIm2KYnV9e2gSPSOenbeZ1aiWGU=
X-Google-Smtp-Source: APXvYqwSIhL9E76zJPhl/UAA1VO3H+r4eQibZ++IcDzst0vz2QD1+4n8+MVLYbn1HivyVsoTSu2qRNGefVdpg21EzyQ=
X-Received: by 2002:a1f:8744:: with SMTP id j65mr4380333vkd.17.1561038262381;
 Thu, 20 Jun 2019 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 15:43:45 +0200
Message-ID: <CAPDyKFqCyh7pZ3SFkxHZU+edBSHYx6V1LD-BdHBugmoSe+g2PQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc: sdio: Various fixes/improvements for SDIO PM
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
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

On Tue, 18 Jun 2019 at 17:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The power management support implemented via system suspend/resume and runtime
> suspend/resume for SDIO cards is rather messy, but also fragile.
>
> This series makes some improvement to this code. In particular the so called
> powered-on re-initialization of SDIO card is quite questionable, I suspect
> it may never really worked well. Therefore this series removes this code, which
> helps to prepare for additional improvements on top in a later series.
>
> So far the series has only been compile tested, so any help in testing on HW for
> regressions is greatly appreciated.
>
> Kind regards
> Uffe
>
> Ulf Hansson (7):
>   mmc: sdio: Turn sdio_run_irqs() into static
>   mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
>   mmc: sdio: Move comment about re-initialization to
>     mmc_sdio_reinit_card()
>   mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
>   mmc: sdio: Don't re-initialize powered-on removable SDIO cards at
>     resume
>   mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
>   mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()
>
>  drivers/mmc/core/sdio.c     | 92 +++++++++++++++----------------------
>  drivers/mmc/core/sdio_irq.c |  3 +-
>  include/linux/mmc/host.h    |  1 -
>  3 files changed, 38 insertions(+), 58 deletions(-)
>
> --
> 2.17.1
>

I decided to queue this up, to see what tests from linux-next and
kernelCI reports.

Still, that doesn't mean I am appreciating test done on HW. I can also
apply tested-by tags by amending patches after this point.

Kind regards
Uffe
