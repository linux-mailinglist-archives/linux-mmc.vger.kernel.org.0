Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F712B1ABD
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Nov 2020 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKMMFG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Nov 2020 07:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKML3d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2020 06:29:33 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA17C0613D1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2020 03:29:05 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so10205941ljo.11
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2020 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDegh8tRLZdZUaOxApIDHKwtV2S/hfTSpd/mCcBDwW4=;
        b=t1yUwGoLWVYLzwXirBRjAFli99u0/JjI5HW88vpBo44ajQgw8rGXBa3Rym6FUrLWEs
         Gad2D6WOvtoCyC8L6bzfwXJ+9PR+aqk20wiJu6+YFOmURknmSHMY2aC/QwmMw1Tz93eX
         Sk+BYNMjddf5nD7NJgIUmS0vsd/CORMj2xYqV6/1YCGC5inZKYKpQwzXsbam0HlYCw/a
         d4Z9evWyY0aCXHwrKuh+kBJah4Kj0FYBvww3GvorpzKW+jjAj62VbD/5h4vet4DM9grj
         GPWFzS+JecEG+vfWCTacdPYojPhMOkSQltXLS8Ww8XU7z6sPbREMvQ/kPWtATvzgt38N
         urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDegh8tRLZdZUaOxApIDHKwtV2S/hfTSpd/mCcBDwW4=;
        b=l6LtY0StmkCqMsf3MAohFRZtGs5/Z60Y4FDmEemHjDkSSIcASKI7jOayeHD9CVbr3Z
         8laVO5MguZzx06Ky7hP3f9UvjbtQUyrejlsC1HBc5FX+tOjir3bXPrfFCaqJoEBijmB3
         wSng0LrETDjvaK8421ZnYMwGTIEcwhD6JVBpMYW+UeD7KGvcpLD8dVpChfcq9XUdThwI
         UjT26/Mp6XvJVHrHPBKX3A+/hzcADkdZeWG50gNdNIv8rGpJuzsC4TqrSHxXJZ+Bf6ZG
         +RLRFg50R3OHtDLA/10yyAi4WI3Ek64C1K1GtF0hOXMGAxoWMg0Gc6zFoHtNPi5hYcSa
         Xuug==
X-Gm-Message-State: AOAM5332FvTzDf2qyIoO7KTNbOhaWPx6QZu0ulj2WJut9bY1oX9ig7o7
        n0WKBcF5eWgfCFX5B7NUm9UtGA==
X-Google-Smtp-Source: ABdhPJz8u1vcpX+I/3oC0Ia+nllHrxbYvLOw7/xfaciFUsCmH/A+YktO/CLU3soY3+P+HZ3W+Vyiqw==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr850242ljo.36.1605266943945;
        Fri, 13 Nov 2020 03:29:03 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id q4sm1609517ljh.38.2020.11.13.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 03:29:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.10-rc4
Date:   Fri, 13 Nov 2020 12:29:01 +0100
Message-Id: <20201113112901.292826-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.10-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc3

for you to fetch changes up to 03d80e042a8e3248163a38f74b43809f8079d652:

  Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD cards" (2020-11-10 13:58:01 +0100)

----------------------------------------------------------------
MMC host:
 - tmio: Fixup support for reset
 - sdhci-of-esdhc: Extend erratum for pulse width to more broken HWs
 - renesas_sdhi: Fix re-binding of drivers

----------------------------------------------------------------
Wolfram Sang (3):
      mmc: tmio: when resetting, reset DMA controller, too
      mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF
      Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD cards"

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: Handle pulse width detection erratum for more SoCs

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi_core: Add missing tmio_mmc_host_free() at remove

 drivers/mmc/host/renesas_sdhi_core.c | 14 +-------------
 drivers/mmc/host/sdhci-of-esdhc.c    |  2 ++
 drivers/mmc/host/tmio_mmc_core.c     |  7 +++++--
 3 files changed, 8 insertions(+), 15 deletions(-)
