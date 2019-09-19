Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE62B72EF
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfISF7J (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 01:59:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36137 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISF7H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 01:59:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so1552070pfr.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Sep 2019 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dgIbwimAQkKlSbgSJtp+/dbeJWRHJe81c9/KX+VIXkA=;
        b=Mx/H2l9leg+629kRjV3+tiwLwEZ6F/KyzkTl6eX6RY6pupN7Xff6M+EMKN3/umfHHv
         HmSV3r/hM3awiSBfYWeH90K1//aKCBjTFLn/gPz3lxOaDgNLBzpUK7wrxNcfXYErKz8g
         nsTJ0SR/Q/V4XtK45n45CopPBtRiqMp2T1I8kzCNJGshf/cpYzRdMy/eAkFwQ/z1C+W2
         1c5sezQKa7URE96MzFNDmVYH0xmRkV2wR+X+qwfHRkjdcZsILECVvf+Y26Kgw5UN3bEE
         Q8uN0RDphMiawxn+MfbqqNbCI4Qd5qRYk+AbiMWqRFzZoIRNffJosT82jbm6SqEb/lVW
         Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dgIbwimAQkKlSbgSJtp+/dbeJWRHJe81c9/KX+VIXkA=;
        b=GZSJv1P52QePyCpzwpHdIQvGtSJDJKl5+VCBcsMiaSUDLN7DN+LotoPoDJwYNGqh17
         D052Q+t1UJI5qK+w2f7ohBdbR8ERb2PRGrk39FjqmLtmvb2ypjBat6ERnAABE+Egnwp2
         27lq23lwRWOZyNu+QBUdsxqFu8rybUjJm+QDq8Us6K3IRRdt75AMvrVwfmRLEX/lYPen
         IiEamSZu/qkKUHZTQfmMCUoiVrdC9C2JJLIrIP7ocnUVgpf89sj0C7cHdiGNe9V4p5lw
         6nu7agORzthkzD0A12to65FlXAQo3ATXruqwhQt0VPPeVNKRi/53f2UEoUC/Q5cgLLSm
         ag0A==
X-Gm-Message-State: APjAAAUZ5AwOYj+StOKHPfnRaqsXBuw2+Okl92kZNBcBPpiJ04s312+L
        iLH8ty7ieIlR0aB8WUeeTTuWsw==
X-Google-Smtp-Source: APXvYqxU2SNk/ft+XHxPveItevSjUrywmPGWEbwcAe5zoy/dD14xqkRCRTvVutRSRRzgDKhfZ0fp7w==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr7711967pgt.30.1568872745170;
        Wed, 18 Sep 2019 22:59:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c127sm9666027pfb.5.2019.09.18.22.59.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 22:59:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add MMC software queue support
Date:   Thu, 19 Sep 2019 13:58:44 +0800
Message-Id: <cover.1568864712.git.baolin.wang@linaro.org>
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
based on command queue engine's interfaces, and set the queue depth as 2,
that means we do not need wait for previous request is completed and can
queue 2 requests in flight. It is enough to let the irq handler always
trigger the next request without a context switch and then ask the blk_mq
layer for the next one to get queued, as well as avoiding a long latency.

Moreover we can expand the MMC software queue interface to support
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

1. Without MMC software queue
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

2. With MMC software queue
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

Form above data, we can see the MMC software queue can help to improve the
performance obviously.

Any comments are welcome. Thanks a lot.

Changes from v2:
 - Remove reference to 'struct cqhci_host' and 'struct cqhci_slot',
 instead adding 'struct sqhci_host', which is only used by software queue.

Changes from v1:
 - Add request_done ops for sdhci_ops.
 - Replace virtual command queue with software queue for functions and
 variables.
 - Rename the software queue file and add sqhci.h header file.

Baolin Wang (3):
  mmc: Add MMC software queue support
  mmc: host: sdhci: Add request_done ops for struct sdhci_ops
  mmc: host: sdhci-sprd: Add software queue support

 drivers/mmc/core/block.c      |   61 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/sdhci-sprd.c |   26 ++++
 drivers/mmc/host/sdhci.c      |   12 +-
 drivers/mmc/host/sdhci.h      |    2 +
 drivers/mmc/host/sqhci.c      |  344 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sqhci.h      |   53 +++++++
 include/linux/mmc/host.h      |    3 +
 11 files changed, 537 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mmc/host/sqhci.c
 create mode 100644 drivers/mmc/host/sqhci.h

-- 
1.7.9.5

