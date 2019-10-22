Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61538DFD67
	for <lists+linux-mmc@lfdr.de>; Tue, 22 Oct 2019 08:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfJVF7j (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 22 Oct 2019 01:59:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43542 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbfJVF7j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2019 01:59:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so9934291pfo.10
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qT81uB/ocS0JC09e5EnN8Mow3YNePrrgiWMhFN4bWk4=;
        b=s+ZtWuqOk66aD/sb3vHSFe52/gMlA3ErOLNLsCvw4wDOtEFJfwEeurpHmvr9KsrLaF
         pJcVeEVlCPFnAzFrkOPDM+HDFzxThUqUmz0W6fJtC2hXKE1plklvf9DSJuXf5tTc17qP
         qJySZy4UYu8oRlZrbv7ZJU+tmd1tFHRpuSNL7M5WruI2ecAIz8gIWH7g9p05Ui+pnOvs
         Wy3AdiTfZVeM9kKlky10oC4pxhF0ctaTsg0A8bZjZo+bBItu6JMMyyY1i91rMSkbnW+g
         fQxM3FJA8BYIvMmSzFtzItSKppkuGF6gwdEPnWTglzro+6uDlHtr2DBZ7NfF2EtETL4C
         YBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qT81uB/ocS0JC09e5EnN8Mow3YNePrrgiWMhFN4bWk4=;
        b=I0bmNjTvnu2JP8fsv7tFs6YTc+g4H/MaKAY5fHG6dQqIYKDAdXMoR4QlcgHdsbKJsn
         9usjQpy58QOlcdXwNL6sb7D+3E6OrBHzrl95CuM4/X0pvavrzWGhfdJ4sLQfEePHElhU
         ObHyFEeHq7HqYRoloPNExtbOBOrw7BuhbpBRdPSotsJKUWzaMVfjA5zlX4ZRpWJbkPw5
         3ots0DjoNZclh8lEO2tm5eVdKsp9hVhuTNQvDpiRtP6YeDnUFt+tV/6FZTdN3lAZtsoE
         huoi0E7UKgnNKmHOWR2MP4BuDlx+bDRYaIQ6yaTVKdAH2OYojgBd85Hbi1RhecB4kmv4
         zbsQ==
X-Gm-Message-State: APjAAAXCHafsvYcec/sPI1VgPVfvDHgmvxTvlqQeakYvFHbaf657b221
        W6pRb3nTR8JTlge6NWJuSm1i8w==
X-Google-Smtp-Source: APXvYqwg8phOB1ZAA+tsjFMbL1hiuISRAzEj5q5+6mDTZByxsdEPlYpJFx7NQI5x4/lhw11eqRFLFQ==
X-Received: by 2002:a63:7b4b:: with SMTP id k11mr122814pgn.164.1571723976947;
        Mon, 21 Oct 2019 22:59:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g35sm16568061pgg.42.2019.10.21.22.59.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 22:59:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add MMC software queue support
Date:   Tue, 22 Oct 2019 13:58:54 +0800
Message-Id: <cover.1571722391.git.baolin.wang@linaro.org>
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

Thus this patch set will introduce the MMC software command queue support
based on command queue engine's interfaces, and set the queue depth as 32
to allow more requests can be be prepared, merged and inserted into IO
scheduler, but we only allow 2 requests in flight, that is enough to let
the irq handler always trigger the next request without a context switch,
as well as avoiding a long latency.

Moreover we can expand the MMC software queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=1G --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
Average speed: 59.66MiB/s

2) Random read:
Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
Average speed: 27.04MiB/s

3) Sequential write:
Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
Average speed: 69.68MiB/s

4) Random write:
Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
Average speed: 35.96MiB/s

2. With MMC software queue
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
Average speed: 60.68MiB/s

2) Random read:
Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
Average speed: 31.36MiB/s

3) Sequential write:
Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s
Average speed: 71.66MiB/s

4) Random write:
Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
Average speed: 68.76MiB/s

Form above data, we can see the MMC software queue can help to improve some
performance obviously for random read and write, though no obvious improvement
for sequential read and write.

Any comments are welcome. Thanks a lot.

Changes from v3:
 - Use host software queue instead of sqhci.
 - Fix random config building issue.
 - Change queue depth to 32, but still only allow 2 requests in flight.
 - Update the testing data.

Changes from v2:
 - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
 instead adding 'struct sqhci_host', which is only used by software queue.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (3):
  mmc: Add MMC host software queue support
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   33 +++-
 drivers/mmc/host/Kconfig      |    8 +
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/mmc_hsq.c    |  344 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h    |   30 ++++
 drivers/mmc/host/sdhci-sprd.c |   26 ++++
 drivers/mmc/host/sdhci.c      |   12 +-
 drivers/mmc/host/sdhci.h      |    2 +
 include/linux/mmc/host.h      |    3 +
 11 files changed, 521 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h

-- 
1.7.9.5

