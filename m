Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0796F8E
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2019 04:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfHUCkg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 22:40:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHUCkg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 22:40:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so419963pgp.4
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iJCb2jYcjAZrWMcIGd74mhhKeBUwaoco72itfmXHkXU=;
        b=uLmzYvt+8q5lCGFEJf+cc/YIDJS/0OUOkILXlnIdRn/MSLRth0wC/axZCeDNGc6QeW
         sQ/0xQwWvPuiUO3+28Jt+Xp/uY9xQAVH6+wkF5fxSeV7IVEY8qgYf7W6vSDKBngbpFM5
         1yXKxa+tuI/TlVQvY/dFse4A0txEUhQ1KLXNQXOsstZbNxNWm6fJwbiHlyn8HVoShL3x
         B5RYJ/E0j+QR3aDpPiSB9o8T/KX0n07axHeG/mRD9ie0FKyy+Tcbj8Z6FlNHmtGlV8oo
         zv62CpiQvXLVAHQcFSCOV36ilQ86GvipwJasv7OeGg6lNvoMYU1wH76S605qtFscdgh2
         SW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iJCb2jYcjAZrWMcIGd74mhhKeBUwaoco72itfmXHkXU=;
        b=fzOlFsI7SCPagB4Pa1Uhe6xSTsLdYd36mpq9hCs8FTc8jzlBPafhZqM6ZuFtG5M4yf
         lv67HbQ+16dFPjIkH72GSSNt+RruB06YaYQy+AuQqPeHz877OqP4Beckrn37kUZV2LiM
         AlorbRaIeqVfu8pwMB2yZYQt2q+3kqT4NiDkXE7+A3M1NooaS9MBvZIwyi2h8vMwyZcH
         EYILHNAbdOaJgGywhBA1erVvWMnKbQgiNCS8uJGezctiOyi1r+AcDlhThtO6dfy2h0h2
         DCDxQghEGnVoUpTfsO+42iuQ+kJGiABwxwleHu7sojK4G3/XCK1lEHJ1cc4o9ePj+9/f
         bs/g==
X-Gm-Message-State: APjAAAWuSCtg7UrOVpGWYJLlh8ni/cyrjmDXGs9WlgiGJcUDT+AOlcBs
        8mmKH2KtQPakfDTPzMG8j+CrbKJm4Q==
X-Google-Smtp-Source: APXvYqzzM6VVCdeDhLfClbl67RJU+kMvUC92BBd3zncGW+nNyta244Glp50GWPHm6oVlBwvlY04uXA==
X-Received: by 2002:a17:90a:a105:: with SMTP id s5mr3047784pjp.51.1566355235323;
        Tue, 20 Aug 2019 19:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/7] Add SD/MMC driver for Actions Semi S900 SoC
Date:   Wed, 21 Aug 2019 08:10:07 +0530
Message-Id: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This patchset adds SD/MMC driver for Actions Semi S900 SoC from Owl
family SoCs. There are 4 SD/MMC controller present in this SoC but
only 2 are enabled currently for Bubblegum96 board to access uSD and
onboard eMMC. SDIO support for this driver is not currently implemented.

Note: Currently, driver uses 2 completion mechanisms for maintaining
the coherency between SDC and DMA interrupts and I know that it is not
efficient. Hence, I'd like to hear any suggestions for reimplementing
the logic if anyone has.

With this driver, this patchset also fixes one clk driver issue and enables
the Actions Semi platform in ARM64 defconfig.

Thanks,
Mani

Changes in v2:

* Converted the devicetree bindings to YAML
* Misc changes to bubblegum devicetree as per the review from Andreas
* Dropped the read/write wrappers and renamed all functions to use owl-
  prefix as per the review from Ulf
* Renamed clk_val_best to owl_clk_val_best and added Reviewed-by tag
  from Stephen

Manivannan Sadhasivam (7):
  clk: actions: Fix factor clk struct member access
  dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
  arm64: dts: actions: Add MMC controller support for S900
  arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
  mmc: Add Actions Semi Owl SoCs SD/MMC driver
  MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
  arm64: configs: Enable Actions Semi platform in defconfig

 .../devicetree/bindings/mmc/owl-mmc.yaml      |  62 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/actions/s900-bubblegum-96.dts    |  60 ++
 arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/actions/owl-factor.c              |   7 +-
 drivers/mmc/host/Kconfig                      |   8 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
 9 files changed, 878 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 create mode 100644 drivers/mmc/host/owl-mmc.c

-- 
2.17.1

