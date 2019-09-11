Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707D4AF6D2
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Sep 2019 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfIKHUz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Sep 2019 03:20:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46858 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKHUz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2019 03:20:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so13073335pfg.13;
        Wed, 11 Sep 2019 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTSA2KWTYkZ5jUmaKr2hzgikiMEn5EUiQArjTO/JJ7k=;
        b=tciV8VlCLtN80qdrFlxoq0Hj7+jQCySauyTC32p1hbaxewc7oqOIkv9XUJ0QCImn55
         EWuBZcnav+dglkKAZ78akhkvjvLsmyq661EHhly8f3pfqUpbX5vEcAiRLrSaTpXB3enw
         KIZfi6RyBd7dctmjOW7Z0846G5JJT2aRqhNaDGoIhpS4HhdwI1K/YE8C4EnyBdo0zen9
         7q9vS4Fhkl7bZqn/Ns8f7sXDS+6PT6i6xzmTj8OoPBOsJzZfnSoy0vMNTGi+eBfDb9is
         FqpLA2GLlRt2NxLtq1FJFfx10o6vJUkoV05+Kv8bo6Gjy1xslt1fLGKeKBD/Q7+EGFfl
         EKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTSA2KWTYkZ5jUmaKr2hzgikiMEn5EUiQArjTO/JJ7k=;
        b=Fjr9IRdPPtNhqef3Y7+rXm27iGcmbX8SOz1W9WHM5jQVcEzlwYszgi25EVLXoVa8zz
         /nTNxmSmUAfEDdOjCZeOBR/2YBEObNJawAuIZOeyC2J2qxjeyljiQPhXjsb0mE6nX42P
         qlVeR9tdyerSZ6eZS8uLOy3mHeTt6u2+iLzSG7evdigq/q5DpNQTcU/D/nNLz5rbJ32D
         z3tV/zQWEfVIUsJaX00Kz2NkluD3hNWPKHBivbuIZKHLHedvy0lJdCLtkwltfa48Mt3K
         vJCrKUyuzFhXsKKSLh/qQYEGJQmrGvfqDPhS7ZOftpTo/qpl4Kw9C9GJinn6ogLY1YjY
         eFuQ==
X-Gm-Message-State: APjAAAULWDIyBkKnM3qc3u9poXCxsROqeEe3yRU7kHolDJYToubqzZkk
        a7ZlHYHsUq3DNZstmwNQXjM=
X-Google-Smtp-Source: APXvYqxzIpSwifRQceVeyApomRHKjKYVK/yebwOMK0KKstiSHdYeHkR5b5GyY/6CRVi4PJUZn/J8eA==
X-Received: by 2002:a62:170b:: with SMTP id 11mr21111130pfx.243.1568186454587;
        Wed, 11 Sep 2019 00:20:54 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id m9sm3577364pjf.11.2019.09.11.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:20:53 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V9 0/5] Add Genesys Logic GL975x support
Date:   Wed, 11 Sep 2019 15:21:09 +0800
Message-Id: <cover.1568184581.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The patches modify internal clock setup to match SD Host Controller
Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755
chipsets.

v9:
 - refine gli_set_9750_rx_inv()
 - modify comments in sdhci_gli_voltage_switch()

v8:
 refine codes in sdhci-gli-pci.c
 - remove duplicate assignment 
 - remove redundant delay
 - use '!!'(not not) logical operator to refine the true/false condition
 - check end condition after outter loop
 - add comments for delay 5ms in sdhci_gli_voltage_switch()
 - merge two logical conditions to one line

v7:
 - remove condition define CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c
 - making the accessors(MMC_SDHCI_IO_ACCESSORS) always available when selecting
   MMC_SDHCI_PCI in Kconfig

V6:
 - export sdhci_abot_tuning() function symbol
 - use C-style comments
 - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
 - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
 - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
 - remove .hw_reset 
 - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

V5:
 - add "change timeout of loop .." to a patch
 - fix typo "verndor" to "vendor"

V4:
 - change name from sdhci_gli_reset to sdhci_gl9750_reset
 - fix sdhci_reset to sdhci_gl9750_reset in sdhci_gl9750_ops
 - fix sdhci_gli_reset to sdhci_reset in sdhci_gl9755_ops
 
V3:
 - change usleep_range to udelay
 - add Genesys Logic PCI Vendor ID to a patch
 - separate the Genesys Logic specific part to a patch

V2:
 - change udelay to usleep_range

Ben Chuang (5):
  mmc: sdhci: Change timeout of loop for checking internal clock stable
  mmc: sdhci: Add PLL Enable support to internal clock setup
  PCI: Add Genesys Logic, Inc. Vendor ID
  mmc: sdhci: Export sdhci_abort_tuning function symbol
  mmc: host: sdhci-pci: Add Genesys Logic GL975x support

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 353 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci.c          |  30 ++-
 drivers/mmc/host/sdhci.h          |   2 +
 include/linux/pci_ids.h           |   2 +
 8 files changed, 393 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c

-- 
2.23.0

