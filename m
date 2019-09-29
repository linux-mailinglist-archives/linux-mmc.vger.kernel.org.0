Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6441C1926
	for <lists+linux-mmc@lfdr.de>; Sun, 29 Sep 2019 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfI2TiQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 29 Sep 2019 15:38:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42966 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbfI2TiO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Sep 2019 15:38:14 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so32200942iod.9
        for <linux-mmc@vger.kernel.org>; Sun, 29 Sep 2019 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HJs5lRgf3tWHfQJhbCzAN9td4AS5tfgc0z8T2htrVm4=;
        b=OC5BF8ZmhM5FS6BTUc3coyjBMVx4qdwCY5AzqfT8q4DSR8io0qM7ZAEciQnghaES2r
         BA7QACHT9073KIhqJOlG8aGgJOx/HqSZOM6lDlKGjC65cJDETTJ4zQMFXMGjiq/U1ro8
         uJb2SLC0xTi8FBmrd9xyiwZlhahoa1mcvn+88cZYIvXo2wpq1rupHqQoB53yq5tR954n
         aUaWVphqtK0dw1Obxf8OMARn1BZTK0WHL4T/OtHdxq/oN3QBuegYNzpLvW0Qh394Udob
         3gC3Wl33rL+fjJtCwVXAWyHzMOXy3cIWR1V6oIg5ybYzvWPOSfjaEAeS4x4pRDPBe3LB
         TLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HJs5lRgf3tWHfQJhbCzAN9td4AS5tfgc0z8T2htrVm4=;
        b=Vwz0XzoE4GH1rOUa/OvesnYX6+LU84jWREMBo6WTTNO2Yl3Kcy6gfvPK2z67JAsuzW
         WrixdUHSL2kRSxidnFJC3gilTF7x+y42WvbpicYdIlq92yjHjwslcQMrQznOKPuaPlP0
         pdCsVXfSyq3Bq1vb2iZ5O6Omy+rhDcJ+XePzh+o1cHTOkUDa0kwA2V8X2jp4txqg94xw
         VCFQ6MArl883cMQjYOtiEonbQwrEac6HpXTDt/tsrmMFC2ZqFnM/YX2I6/30H++WtDVu
         FZBB85MycMGbDi/c/u4Uoe/yUck7rx1c3CYvUa8E7FaUtya7iO9FxMPFz91b4IIM1Afl
         3KVA==
X-Gm-Message-State: APjAAAX69qeulmk5JGG4psWMcDkGe5xrl6nuP3q/GY3+tzqHLKr0H2CW
        tmw5k8BDO7WlNMPUVFpJJ0msxw==
X-Google-Smtp-Source: APXvYqw3UGh26EnCWFTXEsMNLeyRzvu/c9haRoCJdkAIRnJfwyInGPACKBNsjRKxKcZwG5Q7UYIMIA==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr17190780jac.26.1569785892398;
        Sun, 29 Sep 2019 12:38:12 -0700 (PDT)
Received: from uffe-XPS-13-9360.hil-laqcaes.snd.wayport.net ([12.199.141.194])
        by smtp.gmail.com with ESMTPSA id g8sm4449497ioc.0.2019.09.29.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 12:38:11 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.4 take 2
Date:   Sun, 29 Sep 2019 21:38:10 +0200
Message-Id: <20190929193810.2551-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple more updates/fixes for MMC fixes intended for v5.4.
No worries if this doesn't get included in rc1.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3c6a6910a81eae3566bb5fef6ea0f624382595e6:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2019-09-23 09:31:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-2

for you to fetch changes up to e51df6ce668a8f75ce27f83ce0f60103c568c375:

  mmc: host: sdhci-pci: Add Genesys Logic GL975x support (2019-09-27 20:48:20 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Add Genesys Logic GL975x support
 - sdhci-tegra: Recover loss in throughput for DMA
 - sdhci-of-esdhc: Fix DMA bug

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Let drivers define their DMA mask

Ben Chuang (1):
      mmc: host: sdhci-pci: Add Genesys Logic GL975x support

Nicolin Chen (1):
      mmc: tegra: Implement ->set_dma_mask()

Russell King (2):
      mmc: sdhci: improve ADMA error reporting
      mmc: sdhci-of-esdhc: set DMA snooping based on DMA coherence

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-of-esdhc.c |   7 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 352 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci-tegra.c    |  48 +++---
 drivers/mmc/host/sdhci.c          |  27 +--
 drivers/mmc/host/sdhci.h          |   1 +
 9 files changed, 410 insertions(+), 35 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c
