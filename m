Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3AEAB163
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392177AbfIFDwl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 23:52:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38541 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfIFDwl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 23:52:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so2682041pgo.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2019 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qCgqKjYV/ykBBNtF/kBQMkf0USvwkXzoDwAmbizekWY=;
        b=RAmPrs68cn+hLe8nUZSnXgqPLaMYpsTBpNHfgjrHCPV30r8RxiLMrOav8Ey+Acdjou
         r9s1Ua/hl0bEq4xJsv1adw+D4D5rj8CRc7ItJPJ8PM9ArI8TOyDWcz8WoEQgpQLkGSjA
         bEtuT/2ysMGo+1LF8aqQ82l84J4qr7RZHsqxyNqOI+YCxkwZ2Gob0zo9SLLjG0pnBHRE
         YObTUrUVRKrLZlkMGFxy1VuoIy+ZJGnD1mih5FaDWEt8GuRWdXFhb22HqQ5QClT2uVg2
         bPI2Zmoems/YQTs4jGGihDwr6zeJSr7kWvNlrW6m+gMiSuV7vFF70q9TiZrQTiCotgBU
         i8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qCgqKjYV/ykBBNtF/kBQMkf0USvwkXzoDwAmbizekWY=;
        b=U2qwD7fcWCSTztl5vIn4EpwoSaXt3R3roQXVdL8q+vPw69uVVbL+dndU76AFpyKdmU
         sl8tXlp8R2eOr/AWl6iyxf+3sMrNqWsK4qwrjobYkcF2I/jbBktQ8z/MH9vo3a7nmP7u
         Vn35lqTldXxeXcFChqtUnolAA6OKGjQ/iffo9tS+CZ+qVUNlon++PP8SRq+tl95KNf3s
         Qfz5vwt6Ygr+2QMi9Ug/nZ0ZObSeTmXLKODz7VzLJX3L4UWcBqXxed8rUCj6I3KQgick
         3Aaz6F/VZfhT16ds3P2p7yFXeOi9uUaEuzbzSME1VSek/Lri0S9MtDP/oZpqoxlgtIXj
         Is7w==
X-Gm-Message-State: APjAAAUAGRZbZ7IdNwAho9SfFRNTtq3tv/VIj/Wksp+ReT3pUetYcIkQ
        yPARVSCfkp8wIPPi2PjKc57ALA==
X-Google-Smtp-Source: APXvYqwUcQBMYbSf9bfcASLVOcXBu22We0wWM1dXWNmWDumoReA9NP+rMDwTlToGeIMLRyrZn/yXgg==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr6204814pgp.368.1567741960616;
        Thu, 05 Sep 2019 20:52:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add MMC virtual command queue support
Date:   Fri,  6 Sep 2019 11:51:58 +0800
Message-Id: <cover.1567740135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead, especially for high I/O per second rates, to affect the IO
performance.

Thus this patch set will introduce the virtual command queue support,
and set the queue depth as 2, that means we do not need wait for previous
request is completed and can queue 2 requests in flight. It is enough to
let the irq handler always trigger the next request without a context
switch and then ask the blk_mq layer for the next one to get queued,
as well as avoiding a long latency.

Moreover we can expand the virtual command queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without virtual command queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
Average speed: 28.7MiB/s

2) Random read:
Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
Average speed: 14.3MiB/s

3) Sequential write:
Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
Average speed: 24.7MiB/s

4) Random write:
Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
Average speed: 19.2MiB/s

2. With virtual command queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
Average speed: 43.6MiB/s

2) Random read:
Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
Average speed: 30.6MiB/s

3) Sequential write:
Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
Average speed: 44.7MiB/s

4) Random write:
Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
Average speed: 43.6MiB/s

Form above data, we can see the virtual command queue can help to improve the
performance obviously.

Any comments are welcome. Thanks a lot.

Baolin Wang (4):
  mmc: host: cqhci: Move the struct cqhci_slot into header file
  mmc: Add virtual command queue support
  mmc: host: sdhci-sprd: Add virtual command queue support
  mmc: host: sdhci: Add virtual command queue support

 drivers/mmc/core/block.c      |   62 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci-virt.c |  346 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.c      |   10 --
 drivers/mmc/host/cqhci.h      |   45 +++++-
 drivers/mmc/host/sdhci-sprd.c |   16 ++
 drivers/mmc/host/sdhci.c      |    7 +-
 include/linux/mmc/host.h      |    1 +
 11 files changed, 512 insertions(+), 23 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci-virt.c

-- 
1.7.9.5

