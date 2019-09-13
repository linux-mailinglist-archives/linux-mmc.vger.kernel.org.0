Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C73B1CB8
	for <lists+linux-mmc@lfdr.de>; Fri, 13 Sep 2019 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfIML53 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 13 Sep 2019 07:57:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45052 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIML52 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2019 07:57:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id u14so26796739ljj.11
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2019 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ROgbE+3raduhHlfWCJNflMmrX0r350QDpKoqnEeP7DY=;
        b=GlvuQisF98mojrnxV4d6NKXMH5YNvoaB29RjaJpKK86BVgVVCgQz+RpcLtvkCGp+V9
         XSV4T65A0yi17oXRJ+2AoOQ9bAnsix120JXuWsgOg/k3zHhS4Vei/KLDQsi88RJq9Rt7
         99jENXpT/yWguA4Yzu+fP1XuIlGbRlJKM7AaUXJYcePb2gEnqereSov+DKexgcnYFPLW
         HisimDJsyc6EdT0KoafCPSF5tCNob9OBrJ8vEI6uwLk+WizLkYLJfnEFxcPlrNR6QOug
         yxxow4pgMKrbFlH+RtVOrxv1/h/xd92fWRbze1q4GgeWgImXjXIrZTjzmLRjRyQf5F3V
         VjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ROgbE+3raduhHlfWCJNflMmrX0r350QDpKoqnEeP7DY=;
        b=kxn+qngVKOsm6vmE1Vs8xhgu3DwSyHXfRjgbQo8Zaz0mW3U39VWYuORccTrwcHi8//
         iZYGkRWKLd8Ioaa1nDrIO7O4UzaQvMQ3VXfvST20Iv7qV5nodxuL31eZItloCm719PbN
         QB23ivDVRzMKTQWEwFsxdDsCDVT12Vkm4VI1prEUz/6z9IBa1rOzHtzz4kLld4F//sTV
         dDBUtrs6ND7jX8bM8THFwyKri5iuIjgsBKrwbjZ6vIUV0ZkXGVNHp8ryrwbT74p7LNYC
         JPeerb1c6TeuUpwVv7wfoOwYp18u6Z4buctJdxDYTqsXD7JjVReStftMd9Wjgu5JRzYh
         6vrA==
X-Gm-Message-State: APjAAAWNRRIAXCh5W5pOh/wFkLzIfqDoBtKzdSIBDyBSWMKeFD72UWLg
        rUmRdxb6gmtzT6vKflF707rb3w==
X-Google-Smtp-Source: APXvYqziVf1W94/u3XEgGnEwoA8qZRGTRovME6sYwuX4BNWHICQdnulK4e7OLxTeWA1icF2lGA/VFA==
X-Received: by 2002:a2e:984e:: with SMTP id e14mr3826328ljj.167.1568375846679;
        Fri, 13 Sep 2019 04:57:26 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q26sm6890649lfd.53.2019.09.13.04.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 04:57:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc9
Date:   Fri, 13 Sep 2019 13:57:24 +0200
Message-Id: <20190913115724.22341-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc8

for you to fetch changes up to 87b5d602a1cc76169b8d81ec2c74c8d95d9350dc:

  mmc: tmio: Fixup runtime PM management during remove (2019-09-13 13:49:09 +0200)

----------------------------------------------------------------
MMC host:
 - tmio: Fixup runtime PM management during probe and remove
 - sdhci-pci-o2micro: Fix eMMC initialization for an AMD SoC
 - bcm2835: Prevent lockups when terminating work

----------------------------------------------------------------
Daniel Drake (1):
      Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller"

Stefan Wahren (1):
      Revert "mmc: bcm2835: Terminate timeout work synchronously"

Ulf Hansson (3):
      Revert "mmc: tmio: move runtime PM enablement to the driver implementations"
      mmc: tmio: Fixup runtime PM management during probe
      mmc: tmio: Fixup runtime PM management during remove

 drivers/mmc/host/bcm2835.c           |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  6 ------
 drivers/mmc/host/sdhci-pci-o2micro.c |  2 +-
 drivers/mmc/host/tmio_mmc.c          |  5 -----
 drivers/mmc/host/tmio_mmc.h          |  1 +
 drivers/mmc/host/tmio_mmc_core.c     | 27 ++++++++++++++-------------
 drivers/mmc/host/uniphier-sd.c       |  3 ---
 7 files changed, 17 insertions(+), 29 deletions(-)
