Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65660876DA
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Aug 2019 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406209AbfHIKBz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 9 Aug 2019 06:01:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405785AbfHIKBz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2019 06:01:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so37335953ljn.4
        for <linux-mmc@vger.kernel.org>; Fri, 09 Aug 2019 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pg4XtA+SLXLzi6cetxivjFuoLtXdpkbDdVYr7VT2SpY=;
        b=OV0ixlMxJ78+G+mzjCxfvoi/QFApRzxYxo73BN4Iw2aGxmZi9pEm9P9Z0Iqy/Ylc0K
         QicaYcnvM3WdyQeczJ1la+M5adWB6HcOG3TBjwvKCBlO1waiz0NvmDQp+3dkNaXH6CQ4
         tPApB0dE81dc5dJzui/jEjmbbrmAKH7BFY4164pN/y6CqvOWGgNID1AUUp3LInxs4I2u
         +4V21lAxOih31dPzG0gxHHak55IsasO8gM16Nq11AN5JaVVHgibpTV/xcMzw2DErL8Ls
         FNG+/mgTYViQgQjH4fUr2slfMl/XZ4R5WdaSbKmvC/6Hml0HqfPa5rzfdCVQu5n3L0zK
         h2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pg4XtA+SLXLzi6cetxivjFuoLtXdpkbDdVYr7VT2SpY=;
        b=tl9tUegFn2evY3ECVdp0hqmlUhBc8ddXT7fmWZLMvBchTv3BYAD9aM6RO6pEfQTOt4
         DVwRfEpTDZGFTfg+nu9h6VBTC4wtitFw6wccc7T/h69OC5N3BM3n2W25YlTLR8ILlLU8
         4AFqVfb5V60V8/w4Q7l6J1ayEoS5RZtz4dkIgtECGYKBJ6msnH5oZTHrYkqpGJp7fzej
         0uGBkT+mqf97AbRebAn67QBOYx38j76PqcGYiybMW9S4J24AnG9vNdxhzcPMpXL95Brr
         NPgimC2OZdz12cbB9qzzyvEPjHL1PIkgGBot2d32c8LEk/1JCkoZZ9+32nhO/8AK738x
         Z/wQ==
X-Gm-Message-State: APjAAAXt/pv/qQk9hewRvflANuy5ni/lhA+vpdzxFdy0WKCDUpPpzLM/
        OxuHT611dzytF/U3pDb1bwyERA==
X-Google-Smtp-Source: APXvYqwo9Be0wGp47XSaXElvSTAeHX/Cqr/OrCwxyl6LPCE3+XV76iOxjrsetOV6TOEC5eQTioYcdA==
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr10780346lja.208.1565344913095;
        Fri, 09 Aug 2019 03:01:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id i123sm2654114lfi.72.2019.08.09.03.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:01:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc4
Date:   Fri,  9 Aug 2019 12:01:49 +0200
Message-Id: <20190809100149.7027-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3

for you to fetch changes up to b803974a86039913d5280add083d730b2b9ed8ec:

  mmc: cavium: Add the missing dma unmap when the dma has finished. (2019-08-06 18:59:14 +0200)

----------------------------------------------------------------
MMC host:
 - cavium: Fix DMA support
 - sdhci-sprd: Fix soft reset when runtime resuming

----------------------------------------------------------------
Baolin Wang (1):
      mmc: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming

Kevin Hao (2):
      mmc: cavium: Set the correct dma max segment size for mmc_host
      mmc: cavium: Add the missing dma unmap when the dma has finished.

 drivers/mmc/host/cavium.c          | 4 +++-
 drivers/mmc/host/sdhci-acpi.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-at91.c   | 2 +-
 drivers/mmc/host/sdhci-pci-core.c  | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-sprd.c      | 2 +-
 drivers/mmc/host/sdhci-xenon.c     | 2 +-
 drivers/mmc/host/sdhci.c           | 4 ++--
 drivers/mmc/host/sdhci.h           | 2 +-
 11 files changed, 15 insertions(+), 13 deletions(-)
