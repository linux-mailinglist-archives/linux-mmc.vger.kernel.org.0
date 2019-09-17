Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C87B4A11
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfIQJJR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 05:09:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35763 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQJJR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 05:09:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so1991687lji.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2019 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqR6fz18v1v6o9dV/amwWZ0UvT5Pbraa10pfG1hgHBs=;
        b=dz8P1GHagBa5s+SRn6/J86IRYLX9+8crfswpitjnxRwLT1rTw8F03QCK7REavcJxTY
         PBNfhaaGmrpBlTdpCEdos7vrC5E+K62FlDSogp6mTmLPRGi70PiEDxtnPOhAcTeOAk9G
         rbj5Btpga5uYzPz4ZkqHq98+siS/Hr4oi7Um+2DOytSFm8SZnPmb5HdlOKWGKdLGcm+L
         bS1bEwrz4GODCjX6uGmK8afvaDvCeJApsOxSP+7NidNzjjqDFvus2d2g4akeS2UG9jg9
         ygoLXo4a+qCwKqY1abl6Xx44KAt9QJS9Fv03duk2Tr8J2AVXDBdZsoz+ckMw9dY0UQ4C
         de4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqR6fz18v1v6o9dV/amwWZ0UvT5Pbraa10pfG1hgHBs=;
        b=iOOSuHx8os1IAbW5sjz5PBOzanzoyNRwrWnad0Z1snS/sZtbuk+000RNl4dwiINaPC
         3uQ6qarwA9zx/zRcqvVkrkGL1pQjJW5PqXiuAz+Pwy4ECL9oZFIHUoP3WlPRSdkQeu2l
         KpN3lZ33Al2l9RCvDDxAWSYzuyBO1nlPvjbkriKtZ5JymxoQk4oGrZBt9qgS54a4yMBV
         Gjaxc0MQignSQsB5su55Rjmi41PmSWLWTc3bRceQKRzp3hkerAeYo7FlEdQPR1qDsHmz
         LuIMG2wsR9M7KElcqD8EH0NtXOtEMTDk7EBq7DniV8jEmG95zCbfBXMHoYRub4A7/+BH
         5YmQ==
X-Gm-Message-State: APjAAAUvq9XakPvlGUEBvASOt0+mwZexDUzhmYGSEM3XL4BrWBeYENN9
        CRk9G/CGdG/dZJAmTSzRy9Zi1A==
X-Google-Smtp-Source: APXvYqwxsA+u5UMUASj/lKslybOQL+s8doJN6HpBMNFtc+9S43mIitRm1GQ0OmykkxA4qBQKOz4q2Q==
X-Received: by 2002:a2e:808d:: with SMTP id i13mr1237180ljg.73.1568711354658;
        Tue, 17 Sep 2019 02:09:14 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id u8sm365468lfb.36.2019.09.17.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 02:09:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.4
Date:   Tue, 17 Sep 2019 11:09:12 +0200
Message-Id: <20190917090912.6758-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 87b5d602a1cc76169b8d81ec2c74c8d95d9350dc:

  mmc: tmio: Fixup runtime PM management during remove (2019-09-13 13:49:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4

for you to fetch changes up to b46119796721301e410a357b91195eed46980ea6:

  Merge branch 'fixes' into next (2019-09-13 13:57:37 +0200)

----------------------------------------------------------------
MMC core:
 - Fixup processing of SDIO IRQs during system suspend/resume
 - Add helper function to indicate if SDIO IRQs is enabled

MMC host:
 - bcm2835: Take SWIOTLB memory size limitation into account
 - dw_mmc: Improve SDIO IRQs support
 - mtk-sd: Various improvements
 - mtk-sd: Improve SDIO IRQs support
 - sdhci-iproc: Add support for emmc2 of the BCM2711
 - sdhci-of-arasan: Add Support for Intel LGM eMMC
 - sdhci-of-aspeed: Add support for the ASPEED SD controller
 - sdhci-of-esdhc: Deal with erratum A011334 support in ls1028a 1.0 SoC
 - sdhci-pci: Prepare to add support of Genesys Logic GL975x
 - sdhci-pci: Add another Id for Intel CML
 - sdhci-pci-o2micro: Fix O2 Host data read/write DLL Lock phase shift issue
 - sunxi: Add support for H5 compatibles

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Add another Id for Intel CML

Al Cooper (1):
      mmc: sdhci: Fix incorrect switch to HS mode

Andrew Jeffery (7):
      dt-bindings: mmc: sdhci-of-aspeed: Document Aspeed SD controller
      mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller
      dt-bindings: mmc: sdhci-of-aspeed: Update example ranges property
      mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
      mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
      mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK
      mmc: sdhci-of-aspeed: Depend on CONFIG_OF_ADDRESS

Andy Shevchenko (1):
      mmc: mmc_spi: Convert to use for_each_sg()

Anson Huang (1):
      mmc: mxs: use devm_platform_ioremap_resource() to simplify code

Ben Chuang (4):
      mmc: sdhci: Change timeout of loop for checking internal clock stable
      mmc: sdhci: Add PLL Enable support to internal clock setup
      PCI: Add Genesys Logic, Inc. Vendor ID
      mmc: sdhci: Export sdhci_abort_tuning function symbol

Chaotian Jing (2):
      mmc: mediatek: fix controller busy when plug out SD
      mmc: mediatek: support 24bits segment size

Chuhong Yuan (2):
      mmc: sdhci-pci: Use dev_get_drvdata
      memstick: r592: Use dev_get_drvdata

Colin Ian King (2):
      mmc: dw_mmc: hi3798cv200: make array degrees static const, makes object smaller
      ms_block: fix spelling mistake "randomally" -> "randomly"

Gustavo A. R. Silva (3):
      mmc: atmel-mci: Mark expected switch fall-throughs
      mmc: sdhci-s3c: Mark expected switch fall-through
      mmc: sdhci-cadence: use struct_size() helper

Jisheng Zhang (1):
      mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to simplify code

Lars Persson (1):
      mmc: usdhi6rol0: Add maintainers

Masahiro Yamada (3):
      mmc: sdhci: constify references of parameters to __sdhci_read_caps()
      mmc: sdhci-cadence: override spec version
      mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses

Matthias Kaehlcke (1):
      mmc: core: Move code to get pending SDIO IRQs to a function

Maxime Ripard (2):
      dt-bindings: mmc: sunxi: reorder MMC compatibles
      dt-bindings: mmc: sunxi: Add H5 compatibles

Paul Cercueil (2):
      mmc: jz4740: Code cleanup
      mmc: jz4740: Drop dependency on arch header

Ramuthevar Vadivel Murugan (1):
      dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM eMMC

Ramuthevar Vadivel Muruganx (1):
      mmc: sdhci-of-arasan: Add Support for Intel LGM eMMC

Shirley Her (SC) (3):
      mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL register name
      mmc: sdhci-pci-o2micro: Move functions in preparation to fix DLL lock phase shift issue
      mmc: sdhci-pci-o2micro: Fix O2 Host data read/write DLL Lock phase shift issue

Stefan Wahren (3):
      dt-bindings: mmc: sdhci-iproc: Add brcm,bcm2711-emmc2
      mmc: sdhci-iproc: Add support for emmc2 of the BCM2711
      mmc: bcm2835: Take SWIOTLB memory size limitation into account

Stephen Boyd (1):
      mmc: Remove dev_err() usage after platform_get_irq()

Tamás Szűcs (1):
      mmc: sdhi: fill in actual_clock

Ulf Hansson (13):
      mmc: mmci: Clarify comments and some code for busy detection
      Merge branch 'fixes' into next
      mmc: core: Add helper function to indicate if SDIO IRQs is enabled
      mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
      mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
      mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
      mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
      mmc: core: WARN if SDIO IRQs are enabled for non-powered card in suspend
      mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
      mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
      mmc: sdhci: Drop redundant code for SDIO IRQs
      mmc: sdhci: Convert to use sdio_irq_claimed()
      Merge branch 'fixes' into next

Wei Yongjun (1):
      mmc: sdhci-of-aspeed: Fix return value check in aspeed_sdc_probe()

Yinbo Zhu (1):
      mmc: sdhci-of-esdhc: add erratum A011334 support in ls1028a 1.0 SoC

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi_sys_dmac: Remove all R-Car Gen3 SoCs

yong mao (1):
      mmc: mediatek: enable SDIO IRQ low level trigger function

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |  14 +-
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  17 +
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 106 +++++++
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |   4 +-
 MAINTAINERS                                        |   1 +
 drivers/memstick/core/ms_block.c                   |   2 +-
 drivers/memstick/host/r592.c                       |   6 +-
 drivers/mmc/core/sdio.c                            |   4 +-
 drivers/mmc/core/sdio_irq.c                        |  57 ++--
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |   4 +
 drivers/mmc/host/bcm2835.c                         |   3 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   4 +
 drivers/mmc/host/jz4740_mmc.c                      |  19 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   1 -
 drivers/mmc/host/mmc_spi.c                         |   2 +-
 drivers/mmc/host/mmci.c                            |  69 +++--
 drivers/mmc/host/mtk-sd.c                          |  29 +-
 drivers/mmc/host/mxcmmc.c                          |   4 +-
 drivers/mmc/host/mxs-mmc.c                         |   4 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  13 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  36 ---
 drivers/mmc/host/s3cmci.c                          |   1 -
 drivers/mmc/host/sdhci-cadence.c                   |   7 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  34 +-
 drivers/mmc/host/sdhci-iproc.c                     |   9 +
 drivers/mmc/host/sdhci-msm.c                       |   2 -
 drivers/mmc/host/sdhci-of-arasan.c                 |  15 +
 drivers/mmc/host/sdhci-of-aspeed.c                 | 342 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c                  |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  |  13 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               | 311 +++++++++++++------
 drivers/mmc/host/sdhci-pci.h                       |   1 +
 drivers/mmc/host/sdhci-pltfm.c                     |   5 +-
 drivers/mmc/host/sdhci-s3c.c                       |   5 +-
 drivers/mmc/host/sdhci.c                           |  76 +++--
 drivers/mmc/host/sdhci.h                           |  12 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   4 +-
 drivers/mmc/host/uniphier-sd.c                     |   4 +-
 include/linux/mmc/host.h                           |  10 +
 include/linux/pci_ids.h                            |   2 +
 43 files changed, 958 insertions(+), 310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c
