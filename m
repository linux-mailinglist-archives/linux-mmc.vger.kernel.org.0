Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC7599DAC
	for <lists+linux-mmc@lfdr.de>; Fri, 19 Aug 2022 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbiHSOjO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 19 Aug 2022 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349581AbiHSOjK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 10:39:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35606D9E6
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 07:39:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l1so5868071lfk.8
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KFMtFtZySA4bvpQNARX7HTQqtQoy7c9hAyHo75MNDrc=;
        b=tFKOpJghYdQzwgphRpBrhjwGCF3+e81YHAqmbInJ7EwZjj7nGg2QBi7wWaHfE10E9n
         lGxFxV7YIENSDpredOvjEX526Sdq8W7XNSxMpBMQ5LQNTwgmrud5W6Yry0CTygfODRy6
         8MskW7KBtv/LIHCB6kp9k7mkYtbUxWk/4/BChWRG9nTbi5ULmikcrJvKAQr2eQhjske4
         LN1PnWjpPyOSLGjvkvA4V5jN1WcEJh+CneSHUzuwUc3JHNpR6mMbYz9ya2D6Ev5H5uk+
         xP6VH/MIUShEFbskMRYkOkr0d9UYuShmAjQCLRsfyf7N/JeoE0RuC/JoJJGUbqrmEKpu
         l7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KFMtFtZySA4bvpQNARX7HTQqtQoy7c9hAyHo75MNDrc=;
        b=wW1+uRdAUwvM6enbe6ZF7d3GSyo/GafXQKeTkrtFBaeWaJrZLDXg/GZkGanIenYk4b
         2VqHQuFAcoEfJlwIf7qtl+nuC8DTw/YpJTlG58r3Yy6sSSrga3P+yVSkRe1fYLT4nQ98
         UUpS7Bx2zqcK+PMdKfLLc5vNkKKkN2DCYw6hYT+Don2Q7cYZ5sT/kco2gU2p/yM2WSZm
         cbU+ZF8Lf8M9vR56e+6yO7ThMCozjHm/nOlI3VAShApqa0I6urtiEhXKiVEl2XBSWhLG
         Szr1cLN8O46uo/eZ1ZDknuPj9BrIBFLXZV5Gb6nF5atSD9CD+qA6JhcK9w9FzkuBv9nH
         QIsQ==
X-Gm-Message-State: ACgBeo2xwuHsF4FBmu7FU8zjHNLQa4vsDKrPwj1Bn+LpmxkBK7Ca7vNN
        +KAJ+bRn1oIsC8XcmNl/xdtghg==
X-Google-Smtp-Source: AA6agR4Q1EbYcr4V84vNs+4a4X0At1d5fXgXRHjAm9c4PQOGI0y1GqQpYfoot5t3al3m32CAs6CvCw==
X-Received: by 2002:a05:6512:280e:b0:48b:132:c420 with SMTP id cf14-20020a056512280e00b0048b0132c420mr2459974lfb.542.1660919946889;
        Fri, 19 Aug 2022 07:39:06 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u7-20020a2e8447000000b002618fbebbbcsm639836ljh.47.2022.08.19.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:39:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.0-rc2
Date:   Fri, 19 Aug 2022 16:39:05 +0200
Message-Id: <20220819143905.8090-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.0-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc1

for you to fetch changes up to a0753ef66c34c1739580219dca664eda648164b7:

  mmc: sdhci-of-dwcmshc: Re-enable support for the BlueField-3 SoC (2022-08-15 19:31:04 +0200)

----------------------------------------------------------------
MMC host:
 - meson-gx: Fix error handling in ->probe()
 - mtk-sd: Fix a command problem when using cqe off/disable
 - pxamci: Fix error handling in ->probe()
 - sdhci-of-dwcmshc: Fix broken support for the BlueField-3 variant

----------------------------------------------------------------
Christophe JAILLET (3):
      mmc: pxamci: Fix an error handling path in pxamci_probe()
      mmc: pxamci: Fix another error handling path in pxamci_probe()
      mmc: meson-gx: Fix an error handling path in meson_mmc_probe()

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: Re-enable support for the BlueField-3 SoC

Wenbin Mei (1):
      mmc: mtk-sd: Clear interrupts when cqe off/disable

 drivers/mmc/host/meson-gx-mmc.c     |  6 ++++--
 drivers/mmc/host/mtk-sd.c           |  6 ++++++
 drivers/mmc/host/pxamci.c           |  4 ++--
 drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++++++++--
 4 files changed, 26 insertions(+), 6 deletions(-)
