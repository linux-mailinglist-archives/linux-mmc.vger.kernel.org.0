Return-Path: <linux-mmc+bounces-599-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036AC825137
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 10:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FB61F21E0A
	for <lists+linux-mmc@lfdr.de>; Fri,  5 Jan 2024 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B724B4D;
	Fri,  5 Jan 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="os72KPp3"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A924B48
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jan 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so16793251fa.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2024 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704448317; x=1705053117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izsGUyQXMG/NnxMCJxiUuvXnyxes7bnjdWRoga0i3bU=;
        b=os72KPp32jpBjgi8/0kfK/y4OJP8KEPu1ZoH2j2fdCcwdndciCOFqqN2KC4CDNIjcE
         aDU5gWahx75lQ/V9FrXOFhFRDwcLZ3yLJYHPACXSH7ZnbjdDAngqxddd1nre15iXhZdY
         fUp8emO/FEaQCpXqpYp+CWn0If9iOUiSs5jdn3vOXK8i/ZG16qd6w60cvS+ipg/7LEJY
         WL04iT/mT9aDO+xzPE559L8VW/LhAfOwH/c7njHB9F9EGn73tXKvkk4BnkOBLBujnCVv
         c3g5RsoWp5m/ycBhfaWu8SYzXhytikx3Rtbi0UBqLyZ8kLkJNHg3v1FqeLuAxIDa4JF7
         94tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448317; x=1705053117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izsGUyQXMG/NnxMCJxiUuvXnyxes7bnjdWRoga0i3bU=;
        b=prXzHfoB69IiyNhRNk6Cs3kkBjQRM9JMBisaj6KWm/FnAB3NPEueBQZS+sOuKOSZqF
         uKv3EIIsyFWFvOZnJ79vhdQbPd3mc/vacAPStNMXwg7Lxuoe9dHLIBwwwiwC6oZ19cM7
         9plENOt/Uji0MeKs7P1sotRs4ERukBPXzbHJK/m81qnsKbeA1IZq/fYqOVeEk2BiOWES
         Rapfa48pRIG0Onk2RZXKF7zTiDaeTMFjmoGBZ4NLv/laNqB8nvBTCzzHPxuHtmgx6btB
         kEmmT3qYHll4ngh/WsYOIh6oVt2fOiYHBu/9A81kHGY7kgqugoVbYPigf7tatLCuUSc0
         EeiA==
X-Gm-Message-State: AOJu0Yyfp7KWbi51d/rVQyKWuLGL8ekbRgpMm71VZ57nyOxNXXFbfPQQ
	e48g2wyVz51Zwd7BO1g/nAnaqj8Q2muGqA==
X-Google-Smtp-Source: AGHT+IFXW7kpjxw8MPfUS55tkhlWETu0Ev+A8PuzwCw/174XPrtLey/D0IV/HvEa3SpZOxxTsnIeog==
X-Received: by 2002:a2e:87c7:0:b0:2cc:6af7:880e with SMTP id v7-20020a2e87c7000000b002cc6af7880emr473365ljj.160.1704448316945;
        Fri, 05 Jan 2024 01:51:56 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 7-20020a05651c12c700b002cce6095241sm263006lje.62.2024.01.05.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:51:56 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.7-rc9
Date: Fri,  5 Jan 2024 10:51:55 +0100
Message-Id: <20240105095155.141473-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.7-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc4

for you to fetch changes up to 8abf77c88929b6d20fa4f9928b18d6448d64e293:

  mmc: sdhci-sprd: Fix eMMC init failure after hw reset (2024-01-03 11:24:03 +0100)

----------------------------------------------------------------
MMC core:
 - Fix path when releasing the host by canceling the delayed work
 - Fix pause retune on all RPMB partitions

MMC host:
 - meson-mx-sdhc: Fix HW hang during card initialization
 - sdhci-sprd: Fix eMMC init failure after HW reset

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue

 drivers/mmc/core/block.c             |  7 ++++---
 drivers/mmc/core/host.c              |  1 +
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++++---------------------
 drivers/mmc/host/sdhci-sprd.c        | 10 +++++++---
 4 files changed, 17 insertions(+), 27 deletions(-)

