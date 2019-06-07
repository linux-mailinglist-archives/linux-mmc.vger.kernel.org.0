Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AB3880E
	for <lists+linux-mmc@lfdr.de>; Fri,  7 Jun 2019 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfFGKjQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 7 Jun 2019 06:39:16 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44118 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfFGKjQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2019 06:39:16 -0400
Received: by mail-lj1-f182.google.com with SMTP id k18so1271670ljc.11
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jun 2019 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ufgg86kQKWKmK+WFixqatapUs0G96Q5E9DutnoyVCl0=;
        b=a+liCGMou39XsFuyMFoXxs0fhI2TulhehewrXPgrym1Z9ww7d9X8rSp2vWmuiyhexX
         FvrRPlop0SI5R0rnKZ5HUsyh/mQZzPEkF8gaKI+9C1HXFvV2XipJ1b5nAz+IX9pbcwjX
         6dNZKupmCz+enYiIx2UjRACnxgsKyzxQVapcapLDWlClKWossntTgsipBA10UAPQqRyb
         fI5aOEfD+69PdT0dMyaZLWeuhuiilVPIrbPSndHPRnaRC80CDAGGGplZF2L6KjgEnhfz
         2x2YiPGWSHxYvxeHR28rsuA7L1X9OjdQZxvxkHhw8SUDeiYrDw/1L2sJm48Fpdk8VSMy
         0Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ufgg86kQKWKmK+WFixqatapUs0G96Q5E9DutnoyVCl0=;
        b=YR3a5U2y6RyO0Vq+Rw3DuopD0RAzhHzg87FckiLmfImL78mRdQkqVyNX0BQh4TUL8m
         61jveEL/LWm6uYse2lKT4KSkRTVwG09IfxNPMnNAmQV7Nm5iUPTlppwxNJM3FqU8r4yS
         wZ7zOKwI3EP5De2PAP4McE4tKr1INRw8YFkU0ftwJfFHxKPwWFz8qv1fc1zXrkOnyi7H
         E4BKlQSny1cpxe7cUbOaCTEo7QcpWqmRZawfCC1z3atTTVSutUSP6iV+F7diIAAMWlRU
         DulSG76/Vcf+upTJuErPjQo0TxYLTWUUMp+chwl6yplUK6PcyF3pzSF7quUXP08eCxyH
         1/ag==
X-Gm-Message-State: APjAAAWMVq0cEUK66gmGdtuiwE5aCTn9M6Ykr5FFajTISQ75w5FGiBeN
        62XOe/IItMAvrrwbqmOD+P0IiA==
X-Google-Smtp-Source: APXvYqxyYC6K60y/Nisr80rQsX2lNaVdM5Wfw2ZH50jKBIkUKybN8Iyi7OR05ngCGGROqMVaGOIiOw==
X-Received: by 2002:a2e:3314:: with SMTP id d20mr14336735ljc.122.1559903953918;
        Fri, 07 Jun 2019 03:39:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n10sm345448lfe.24.2019.06.07.03.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 03:39:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK fixes for v5.2-rc4
Date:   Fri,  7 Jun 2019 12:39:11 +0200
Message-Id: <20190607103911.4623-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC and MEMSTICK fixes intended for v5.2-rc4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc2

for you to fetch changes up to 7397993145872c74871ab2aa7fa26a427144088a:

  mmc: sdhci_am654: Fix SLOTTYPE write (2019-06-03 15:18:25 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix SDIO IRQ thread deadlock
 - sdhci-tegra: Fix a warning message
 - sdhci_am654: Fix SLOTTYPE write
 - meson-gx: Fix IRQ ack
 - tmio: Fix SCC error handling to avoid false positive CRC error

MEMSTICK core:
 - mspro_block: Fix returning a correct error code

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix SDIO IRQ thread deadlock

Dan Carpenter (2):
      memstick: mspro_block: Fix an error code in mspro_block_issue_req()
      mmc: tegra: Fix a warning message

Faiz Abbas (1):
      mmc: sdhci_am654: Fix SLOTTYPE write

Jerome Brunet (1):
      mmc: meson-gx: fix irq ack

Takeshi Saito (1):
      mmc: tmio: fix SCC error handling to avoid false positive CRC error

 drivers/memstick/core/mspro_block.c | 13 ++++++-------
 drivers/mmc/host/meson-gx-mmc.c     |  6 +++---
 drivers/mmc/host/sdhci-tegra.c      |  2 +-
 drivers/mmc/host/sdhci.c            | 24 +++++++++++++-----------
 drivers/mmc/host/sdhci_am654.c      |  2 +-
 drivers/mmc/host/tmio_mmc_core.c    |  3 ++-
 6 files changed, 26 insertions(+), 24 deletions(-)
