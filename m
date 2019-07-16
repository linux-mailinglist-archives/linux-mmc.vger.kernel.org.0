Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A876AD00
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfGPQmo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 12:42:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42406 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfGPQmo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 12:42:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so9372893pff.9
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFrcYB/60blHV4ScsnDSvK5cMMWLsotfbMwia5Gcc8k=;
        b=DyI11kWox6JsLKIlcyqdfrru7WLeAjEZfzWOOlYwSwRvRrrtxNQXcagDcScn3b/zkJ
         6qeb5qOMbH0HpGabX1URiV16BzvdQtfnKnWBsSiNLegrfq6WivZAh203sdQN0iTrUsH2
         I3kIxfLxmMyZYPNx7SdrAVkXTHsw5DE1NM4Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFrcYB/60blHV4ScsnDSvK5cMMWLsotfbMwia5Gcc8k=;
        b=i1V9G04tpgUfN9hsKl+qMUkVnPf4XINZ9/mmtu/mGRTz9qVSe7fyxRh9Lkyhg67KM6
         LOAvcchND196+NcmYTiOjfpnjqJ2gCpUQYygQFB6SMpz1nf8YDP07+IKqm14sxwi1Ktm
         E5LB2YzgjLc9ZrJAtj1vxgCHSblRNsUWDNoBqfwSfrNFFtAkwYAkLwizIc78FDCfDRpo
         XXQxQcfOxBPOHZu/zpRw+Fhhr0GkkL1KRq04vwDnWgE4nBONHGINuDr7YKfuCmTjCe/B
         opdHp8AjmjvFVP+/UPRD1goXKAclgfk7t/btiCcIpvSBvQOimgdvtzOhF5vrqNUD0oF8
         Y1Ew==
X-Gm-Message-State: APjAAAVL7Rhpd9uhGYgMowI+mI4WkPTVCt8pUal9rQE6/krteL0b7cJ3
        sX/FzPdG/vmea7p+Uc4L3Pc+Dw==
X-Google-Smtp-Source: APXvYqyotogvaupNvsmdlWCgKksQmr27uYysrL39mM8+jMRkbsXyPl5BHWP6AbsslubGKoB/gfDKKA==
X-Received: by 2002:a63:db45:: with SMTP id x5mr23385800pgi.293.1563295363884;
        Tue, 16 Jul 2019 09:42:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r1sm25456468pfq.100.2019.07.16.09.42.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:42:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        linux-mmc@vger.kernel.org, davem@davemloft.net,
        Xinming Hu <huxinming820@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/2] mmc: core: Fix Marvell WiFi reset by adding SDIO API to replug card
Date:   Tue, 16 Jul 2019 09:42:07 -0700
Message-Id: <20190716164209.62320-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As talked about in the thread at:

http://lkml.kernel.org/r/CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com

...when the Marvell WiFi card tries to reset itself it kills
Bluetooth.  It was observed that we could re-init the card properly by
unbinding / rebinding the host controller.  It was also observed that
in the downstream Chrome OS codebase the solution used was
mmc_remove_host() / mmc_add_host(), which is similar to the solution
in this series.

So far I've only done testing of this series using the reset test
source that can be simulated via sysfs.  Specifically I ran this test:

for i in $(seq 1000); do
  echo "LOOP $i --------"
  echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset

  while true; do
    if ! ping -w15 -c1 "${GW}" >/dev/null 2>&1; then
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

I ran this several times and got several hundred iterations each
before a failure.  When I saw failures:

* Once I saw a "Fail BT"; manually resetting the card again fixed it.
  I didn't give it time to see if it would have detected this
  automatically.
* Once I saw the ping fail because (for some reason) my device only
  got an IPv6 address from my router and the IPv4 ping failed.  I
  changed my script to use 'ping6' to see if that would help.
* Once I saw the ping fail because the higher level network stack
  ("shill" in my case) seemed to crash.  A few minutes later the
  system recovered itself automatically.  https://crbug.com/984593 if
  you want more details.
* Sometimes while I was testing I saw "Fail WiFi 1" indicating a
  transitory failure.  Usually this was an association failure, but in
  one case I saw the device do "Firmware wakeup failed" after I
  triggered the reset.  This caused the driver to trigger a re-reset
  of itself which eventually recovered things.  This was good because
  it was an actual test of the normal reset flow (not the one
  triggered via sysfs).


Douglas Anderson (2):
  mmc: core: Add sdio_trigger_replug() API
  mwifiex: Make use of the new sdio_trigger_replug() API to reset

 drivers/mmc/core/core.c                     | 28 +++++++++++++++++++--
 drivers/mmc/core/sdio_io.c                  | 20 +++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.c | 14 +++--------
 include/linux/mmc/host.h                    | 15 ++++++++++-
 include/linux/mmc/sdio_func.h               |  2 ++
 5 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

