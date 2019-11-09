Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55390F5E70
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Nov 2019 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfKIKa7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 9 Nov 2019 05:30:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33759 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfKIKa6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Nov 2019 05:30:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so5990814lfc.0
        for <linux-mmc@vger.kernel.org>; Sat, 09 Nov 2019 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=giXQo2xxDTnIsnD5g+rmFtpQvGPhSmjYXWzjIJmpNQE=;
        b=HxXCyAb4ByowVJPfX56XTHtLM4YkZP0pqMlRGsNsQCZAGPgSKUXyu4veTJEvTNMOxR
         TD5EDlvVqDv3D5roDQ2NH4ZP59nV+XH/UlwZ2ttMdp2zxz5o+X5vDTUbG+Iizg2HdHEF
         tLK5yzRpiBLmTkxvomQPh9mmYfh/VyHwBqC0RFWse5NSQLNPNPdqcChHhxrFY16EaAPg
         jaKvW7S+Ydy+sj5ro1juHSrT7IgQuCg2e19arZWp8viP1yRa3hXdlZNDIIoIklKagOP9
         KFp+515CpIbGpXSf4aslSGHi9didLOO5v1lWd2Es2+LWGEIVlQe5etuIy45UNdp0e+wd
         g/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=giXQo2xxDTnIsnD5g+rmFtpQvGPhSmjYXWzjIJmpNQE=;
        b=f9xXtJM/hVjPSFswS+tcApd8X0tudsawJc9SX5Xj8BgYBH2rM5YOF0Ud3DzVBI/p4l
         vkcElw4IvJ3NxM3K6uY96U5QnqaDz+O5iz3d/EPzwcO/biRyz3sOUhcvaRMnZzmtZ/jO
         yq0hqMqT+hyyk6lc7uAkjJJJBujAU7Qhg+JxMXGa/O9ho7X7pNGEmnzzZWUy2obdGwcN
         F58vTWl8qQJD753kX6gJ/vV+VPOyMWlQ8CKnoPOzqTT+id8BwJ3nWJH8rb+e8HTV4ao1
         H5vPo/g26hrH8O8hPkMkKbB2nol65ssM1rNKs0YB4IdNFW7Tk/s/6q3/dBs6kaa4WwaK
         i17w==
X-Gm-Message-State: APjAAAW9ThCNqUZhn6XDShtZs6Dte2fUF90g8BUMgT1vKSYbUY/kSYOO
        gMOXViCDJJAnGHMoiFog8XSwg3tbLPg=
X-Google-Smtp-Source: APXvYqyX/UqZ3rhY81QQSQcYGqC1oNmY3h3hWkpLY9DIINrq+fNE8trFZ1avM4N5eH0qDYLmgowhIQ==
X-Received: by 2002:a19:848a:: with SMTP id g132mr1272484lfd.62.1573295456040;
        Sat, 09 Nov 2019 02:30:56 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z3sm343927lji.36.2019.11.09.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 02:30:54 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
Date:   Sat,  9 Nov 2019 11:30:43 +0100
Message-Id: <20191109103046.26445-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Changes in v2:
	- Add adaptations to the mwifiex driver.
	- Keep existing syncronous reset behaviour if the SDIO card has a single
	func driver.

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
mwifiex driver to these changes.

Note that, I don't have the HW at hand so the the code has only compile tested.
Test on HW is greatly appreciated!

Ulf Hansson (3):
  mwifiex: Re-work support for SDIO HW reset
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c                     | 12 +++-----
 drivers/mmc/core/core.h                     |  2 ++
 drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
 drivers/mmc/core/sdio_bus.c                 |  9 +++++-
 drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 include/linux/mmc/card.h                    |  1 +
 8 files changed, 70 insertions(+), 22 deletions(-)

-- 
2.17.1

