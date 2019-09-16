Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3639FB3DE9
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Sep 2019 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbfIPPqT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Sep 2019 11:46:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34944 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfIPPqT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2019 11:46:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so72615plp.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2019 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A4sU7UOqqLDDD2RT3o3Y/vMwQW6JnCqfyCA4YeqCaoI=;
        b=IKvxlx+nu16eSsm9sL3A0k2aBI/C2r1rf9Yqhm/YfngGL8GNi2G8ltF+JPoKuYITmp
         vi8iMMiBXxItKSE3SjVowtWhTsQPzemF1+I4gAkg+yXKiaMymxzivYM1Ydm0esiqOMKo
         16loTJNenDz//rlIfBkCLd/BMUUdQcuJ4R8sCFuZ5y/mdNH1qSFoGXdgjh2CJcjoApXA
         DR88nhw1vYmi4+AICxXge47mAfJ0gYakuefwxcwhZfCF4duNZB6pJ7tNTnSHcsB7fmzL
         JoO0qvrD3wcL03dRDDNPUtmBr3J+MWWavDyPENpFGjWtjdaSDI53JzErfSAFzKlMBVEF
         aQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A4sU7UOqqLDDD2RT3o3Y/vMwQW6JnCqfyCA4YeqCaoI=;
        b=GJTQ54xw7zj6BGKPvtmM6qtU0F4sq9XFZU3jlBZcwHPrLxXIcfCJkd4L2qDicnk3rh
         yQqPbd5BUnzGJEbqd0SPfxh+GxTDkoIpXKiMcdfoDOB5nc6ZDYlcIJJjJrAk9j57AzEC
         TNQFOGmyIj+i2CoeOd7EN1TyJKJEKzLn2pOma/0UYREhu7RcnszaT+xa7OuECg7lJWsq
         ijvUGuM7UQk7PTT5hc5Z/8LDZp+747+C7KM54hlJngS0MVjlseaD+DXj+TWSolWy944/
         cTZev7TftlDqcrVqbKD5IHnU5+vg/nbZz3xnuVQkBz0RtRdKFhJwdSMfRnYvlfBM6Kf2
         2ocg==
X-Gm-Message-State: APjAAAXpsaMbqHS6q1GoOA9BtWcMg+tH9sTYO/UjUeV2RuY8v6FJzkXt
        A2z9Si/TbZi+923fZJEhIs9j
X-Google-Smtp-Source: APXvYqxk5VLgwP3lklFM2rG/C+bvxjlT6Hptimo7FwML/QOQvdmeKrrB7LDz5ASrq59+SjzqZJfjqA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr445925plb.43.1568648777356;
        Mon, 16 Sep 2019 08:46:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/7] Add SD/MMC driver for Actions Semi S900 SoC
Date:   Mon, 16 Sep 2019 21:15:39 +0530
Message-Id: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
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

Changes in v4:

* Incorporated review comments from Rob on dt binding

Changes in v3:

* Incorporated a review comment from Andreas on board dts patch
* Modified the MAINTAINERS entry for devicetree YAML binding

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

 .../devicetree/bindings/mmc/owl-mmc.yaml      |  59 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/actions/s900-bubblegum-96.dts    |  62 ++
 arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/actions/owl-factor.c              |   7 +-
 drivers/mmc/host/Kconfig                      |   8 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
 9 files changed, 877 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 create mode 100644 drivers/mmc/host/owl-mmc.c

-- 
2.17.1

