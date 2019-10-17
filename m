Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97674DAEDC
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437320AbfJQN54 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 09:57:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35018 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437305AbfJQN54 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 09:57:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so1988134lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2019 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MPvIgeYyS5sEH2/sdzpYI6YJY72ljFxd5CJtu+IHloQ=;
        b=YMFYY9SOWuw2gCta52O4XJLM08tWAp/9Z2kzoqZLJ/YQ4cX4Spn3oy410avVSqTrMw
         YK4NEVG/uPHsWOYvvrIrZsGN8ISXf+SYEgDbnsuqF/OKiXcI9qHA//el6AZ5DQ7LZCPN
         6DHX9qWhxCEQ6AoBBEMZ4UpjJythPE92PTmADKDtOXqquPiaK6gZzB04gh85tAQvMkmv
         0Eqj7k/oRwQbZA+ViQQPtLonzcIJnULli0n+vAesSX9gPVzipWVx3MaQvnmkesxm9lbP
         L5KssgY0CPwSdejFzqUvC4yyQro28W3uvW45/UZoVG/cku3ZXxv33Zci8NlZMvT+qBMO
         h4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MPvIgeYyS5sEH2/sdzpYI6YJY72ljFxd5CJtu+IHloQ=;
        b=giuoIy6fCRN5IxUIs/nrKM+/489UJCVvq2DWc9MZ4MER86uYDitrVtSutGyNMd6syL
         25gZdDez2ymfHTLGDTs8THkuT8TvZ2vGumN/suSXVAoxV2S/R1r1Ytu5+1flRIGmkquK
         wrx4o7aTVoEwZT4RVmhYiHvCJ08jLQ3XyOW3nX0DlL0iwSwf7S5SSUFAfOWM1HDggBE8
         eJBkYHrNdv4UPIAAXXSlJDPfSqr9Rty8WzgrxfUBzKWkXpbqqfUCjURLBAQyu0HXev/k
         IPrA7YAFval9TOS8TCc3l/U3Q0t8zRPr0TQvhqW6tFL0RVYEcIgNl3sL1GOYxjYRDm8k
         nw2g==
X-Gm-Message-State: APjAAAXYHTI0wCS1cVDljbJxozfGS15XHV1oFciogcSDKSDOOSofdD6/
        CiSs7CUVQV/bONEyh6jU83JAc0yWfKg=
X-Google-Smtp-Source: APXvYqzgFfNbRiS1dqPAYHp+u5VFayansAF4dMt2TlvUi3kylGKp6MkSIK6/8d+dmnSpQfZGH71o1w==
X-Received: by 2002:a19:8c05:: with SMTP id o5mr2459368lfd.53.1571320673697;
        Thu, 17 Oct 2019 06:57:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm975088lji.62.2019.10.17.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:57:52 -0700 (PDT)
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
Subject: [PATCH 0/2] mmc: core: Fixup HW reset for SDIO cards
Date:   Thu, 17 Oct 2019 15:57:37 +0200
Message-Id: <20191017135739.1315-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following two patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO.

Note that, the code has only compile tested, so any test on HW is greatly
appreciated.

Kind regards
Uffe


Ulf Hansson (2):
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c | 10 +++-------
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sdio.c | 11 +++++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.17.1

