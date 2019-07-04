Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9184C5EFE2
	for <lists+linux-mmc@lfdr.de>; Thu,  4 Jul 2019 02:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGDACC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 3 Jul 2019 20:02:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45130 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfGDACC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jul 2019 20:02:02 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so1359634ioc.12
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jul 2019 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zH3X6JE9Lvcb3kkvwLyHUBkz1auAJZg71HgpMBV6MGY=;
        b=YMIECA8byoXwYad2HgOR1CK1AJNL3oE1pSuVoWMNqf0rPCIE8x4sqONuvq/RfuyLxi
         LsIQ+wTez9bF8mJWYdaLZEsL7y4zjo+SFW3T75Ez06pEEd+0PqVtE7n52WZAMPDpgfgt
         ycNIchy9o1IWVcJNAq3uKjZldsk7cfQATnKLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH3X6JE9Lvcb3kkvwLyHUBkz1auAJZg71HgpMBV6MGY=;
        b=B2Y/lJ7zD8NnfWaKO+xpgty1Sr3sToc19jTw5/jyfcNVZ3AZD/UVEoILp0UAk/actB
         bbj2OXE42bMWDHQZbJz4vKf2fHEvTQKIUIPiPTbtyV8Y1A42uhPvZJ2lrH0NQBSVWl96
         gAF/7WweBhdXpKWpzUL3Cib75NagH7RAb3F9wQv5Fm4125EL5htyo5Ia7j3xaK5Z+Pk/
         frR7QLtPSHRAB55z1OPLgc9bhzaFo4gqFimp7Epz/qZ22U58qszGuUDAqlqWNhpf1Q+E
         L6iEqQcBQeZ0maIe2YEaLB+xrhisnE717NyOZIXwN3xdks4KE+3wbnQiOgLmWpl41SO5
         wiUQ==
X-Gm-Message-State: APjAAAXLnksimjZmiRmDszFSlCMhoPVL8E1hE41jTk4B/8josA8+MrgN
        Bga9PBo3VK6xC/C00Vk4SVk7wbqtU90=
X-Google-Smtp-Source: APXvYqy9niDXxNj40EN+z+X5gLhSq4O7MH01K5HTgOueS5l5TZv1cTwfvBOqfzRFEBm0c3dnCu7PHg==
X-Received: by 2002:a5d:9282:: with SMTP id s2mr6827324iom.36.1562198521344;
        Wed, 03 Jul 2019 17:02:01 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id v10sm2269876iob.43.2019.07.03.17.01.59
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 17:01:59 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id h6so9123215ioh.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jul 2019 17:01:59 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr10331741iot.141.1562198518744;
 Wed, 03 Jul 2019 17:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-5-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-5-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Jul 2019 17:01:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
Message-ID: <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
Subject: Re: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume
 and HW reset
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
> To use the so called powered-on re-initialization of an SDIO card, the
> power to the card must obviously have stayed on. If not, the initialization
> will simply fail.
>
> In the runtime suspend case, the card is always powered off. Hence, let's
> drop the support for powered-on re-initialization during runtime resume, as
> it doesn't make sense.
>
> Moreover, during a HW reset, the point is to cut the power to the card and
> then do fresh re-initialization. Therefore drop the support for powered-on
> re-initialization during HW reset.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

This has been on my list of things to test for a while but I never
quite got to it...

...and then, today, I spent time bisecting why the "reset"
functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
is broken:

cd /sys/kernel/debug/mwifiex/mlan0
echo 1 > reset

I finally bisected the problem and tracked it down to commit
ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
are enabled"), which embarrassingly has my Tested-by on it.  I guess I
never tested the Marvell reset call.  :-/

I dug a little and found that when the Marvell code did its reset we
ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
found that specifically it was the call to mmc_signal_sdio_irq() in
mmc_sdio_power_restore() that was making the call.  The call stack
shown for the "enb=0" call:

[<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
(mmc_sdio_power_restore+0x98/0xc0)
[<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
(mmc_sdio_reset+0x2c/0x30)
[<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
[<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
(mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
[<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
(process_one_work+0x290/0x4b4)

I picked your patch here (which gets rid of the call to
mmc_signal_sdio_irq()) and magically the problem went away because
there is no more call to mmc_signal_sdio_irq().

I personally don't have lots of history about the whole
"powered_resume" code path.  I checked and mmc_card_keep_power() was 0
in my test case of getting called from hw_reset, so the rest of this
patch doesn't affect me at all.  This surprised me a little since I
saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
it was only set for the duration of suspend and then cleared by the
core.  ;-)

I will also say that I don't have any test case or knowledge of how
SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
cards are currently not allowed to runtime suspend anyway.  ;-)


So I guess the result of all that long-winded reply is that for on
rk3288-veyron-jerry:

Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
SDIO IRQs are enabled")
Tested-by: Douglas Anderson <dianders@chromium.org>


One last note is that, though Marvell WiFi works after a reset after
this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
guess next week it'll be another bisect...

[1] https://crbug.com/981113



-Doug
