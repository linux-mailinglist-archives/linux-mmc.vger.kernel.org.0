Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3CF8596
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Nov 2019 01:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKLAv1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 11 Nov 2019 19:51:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:32860 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLAv1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2019 19:51:27 -0500
Received: by mail-il1-f194.google.com with SMTP id m5so13956870ilq.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fqCSy9rwXM+rp0J01BNk/6lUOMoJGghUMwnadvjbXU=;
        b=fRk1IvsmiSzlXUg2hL2f1J++6G1E9Sn5WwnERiVBs3tkLjHROWL+ov0leW6sOrPiyQ
         D2AEM68fYTwVBOIulX1dCYm7jQ4ITSKFCGJO79kkEL0BRXjRnAo/h1RNdbEN9F+4SHA1
         83lT7dqVbbT4BU3ARTb5gL5WFOlFQNENVAmJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fqCSy9rwXM+rp0J01BNk/6lUOMoJGghUMwnadvjbXU=;
        b=YzuNFkT024rtZ5JloSHCDk5na5Ie2m94sbB7uUVOU/JWfVEXbomBP2ynDF6GoLTWo9
         F73I0+1YdO7NcQY7pxHQoCaGAXWVlgNfF0Di3EbIgV+St/Yg1K5GNMgDu7Rd0hvTBmek
         udHBBD+yVh/1/gepq4n+SvT2RB/tdencsRR3JDWeojc62KYzE4eSLC599Wkc/GTK2wBQ
         FIfcSQCYItU3TcHBTXqJ1Imf0DIJ0RpCasPYE23sKhew4+nbna9knws46XMGt5IFQHFD
         GlBoqNmznlC7NmRfwhCZAjbyR5a2+xeyDk6yumgDSBrk66rQTAhlTrrLplf3wnX3WdBa
         8nDw==
X-Gm-Message-State: APjAAAU34mmXHc8TL/g6tKiCP8I3dbOrwDM8NeqxE2xU7i1WQaAO+gCe
        m07QGWbS9C3OmEusjISHOd1qwItq5g4=
X-Google-Smtp-Source: APXvYqx1AeFTbiHG733EEfqfrXSQygmFAJfZqbP3iwdUFQz5T6me7xpiHCekaL9rqvjqb0YJb93AkQ==
X-Received: by 2002:a92:d58e:: with SMTP id a14mr31368006iln.4.1573519885645;
        Mon, 11 Nov 2019 16:51:25 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id n28sm2256782ili.70.2019.11.11.16.51.24
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 16:51:24 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id i13so15441092ioj.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2019 16:51:24 -0800 (PST)
X-Received: by 2002:a5d:9059:: with SMTP id v25mr22934437ioq.58.1573519883624;
 Mon, 11 Nov 2019 16:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
In-Reply-To: <20191109103046.26445-1-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Nov 2019 16:51:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
Message-ID: <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Add adaptations to the mwifiex driver.
>         - Keep existing syncronous reset behaviour if the SDIO card has a single
>         func driver.
>
> It has turned out that it's not a good idea to try to power cycle and to
> re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> because there may be multiple SDIO funcs attached to the same SDIO card and
> some of the others that didn't execute the call to mmc_hw_reset(), may then
> simply experience an undefined behaviour.
>
> The following patches in this series attempts to address this problem, by
> reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> mwifiex driver to these changes.
>
> Note that, I don't have the HW at hand so the the code has only compile tested.
> Test on HW is greatly appreciated!
>
> Ulf Hansson (3):
>   mwifiex: Re-work support for SDIO HW reset
>   mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
>   mmc: core: Re-work HW reset for SDIO cards
>
>  drivers/mmc/core/core.c                     | 12 +++-----
>  drivers/mmc/core/core.h                     |  2 ++
>  drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
>  drivers/mmc/core/sdio_bus.c                 |  9 +++++-
>  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
>  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
>  include/linux/mmc/card.h                    |  1 +
>  8 files changed, 70 insertions(+), 22 deletions(-)

I put this on rk3288-veyron-jerry atop v5.4-rc7 and I could run my
test case for a while, AKA I got over 50 cycles of:

---

for i in $(seq 1000); do
  echo "LOOP $i --------"
  echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset

  while true; do
    if ! ping6 -w15 -c1 "${GW}" >/dev/null 2>&1; then
      fail=$(( fail + 1 ))
      echo "Fail WiFi ${fail}"
      if [[ ${fail} == 3 ]]; then
        exit 1
      fi
    else
      fail=0
      break
    fi
  done

  hciconfig hci0 down
  sleep 1
  if ! hciconfig hci0 up; then
    echo "Fail BT"
    exit 1
  fi

done

---

NOTE: with no patches I couldn't even get my test case to pass w/out
the BT bits and I swear that used to work before.  ...but I didn't
debug since the end result (with full card hotplug) is happy-working
for me.  I'll still use it as further argument that (IMO) full unplug
/ plug of the card is better it uses more standard code paths and is
less likely to break.  ;-)

Tested-by: Douglas Anderson <dianders@chromium.org>
