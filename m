Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE9E4D8D
	for <lists+linux-mmc@lfdr.de>; Fri, 25 Oct 2019 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394918AbfJYOBC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 25 Oct 2019 10:01:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46729 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394872AbfJYOBC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Oct 2019 10:01:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so1829310lfc.13
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2019 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e7m0bUbtXBnv2hG0jP20Z7UVOAvXLu5pS/p16iFFTtw=;
        b=dTbh5kRFKAeUJ02fzEg55m56Or2mkpSYde3jDq4pzWcZwd6/SrI4odBoyFcvBrKJad
         MhcMpgr3O0oAZZi3DXy8C0rzsg1+6LGICBjQjKU9L00oBicm1Z89mTIIXksUId9S1nrk
         f0ixzXz/Y1sx/3389MQyaVOt7o0opef11dj2UdvvbBPYnplJrsC/0VDqJ6NTQNo3L0iu
         t7yKps03RIs8WKtfmgDnJx//L7LHMLWvUXeEMbDR3ZWw4zmUjuz8pdCI0eiPyMU/zoQq
         fgvKgJJAa95yE98rAMyuhS+Swp+ffMkPcZ3ANDoHaotRv6M0wyQfAxr7PL7oQu8sazyp
         QDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7m0bUbtXBnv2hG0jP20Z7UVOAvXLu5pS/p16iFFTtw=;
        b=SvTC8Ub3rtXsD5M7CL+/WYd2WkeKSCCRdKhuFzuLt3wFWBfMuO/HprtEZyF/vAe6Cz
         WsjM0t4h4gcSXOtX1HZAaUtLboT3K7hEK0Xbyn4Nb7OtaQxqPO1ZjUpC7vhwrgkwNfxf
         rjjbCRM+jNP/ILKZu71nbNbIteNNAoMKZsd5zMkjs2hr8q7Wik4UBHwkWqtIoBgQ3nGh
         8O5umUatRWPcfuNynPl2+EDGl07tffjASlmgtOnBkQhUP7T453HH2up7ljIr6Fw/20Ok
         p15KgyByckdtBra4Wn8Nxid1gH6OuIvEGHpo0V38fUDUtTo1zYwDxQbyeR8co/hr83F3
         QDCg==
X-Gm-Message-State: APjAAAWR8T3l5qy1f136FCcjQgCpHBmm3/vmDB9T8WelPmsoODLYn2Lh
        U9x6mOpjDFnzb1CSTt8jPwc5mg==
X-Google-Smtp-Source: APXvYqzUu4gv63DpUe1KdnUYahz+kl9nNDKPV19VnKiZ/1tr8k6IFuBIcP79aFsZaoepqv8RnWLI1Q==
X-Received: by 2002:ac2:5108:: with SMTP id q8mr2996751lfb.150.1572012059852;
        Fri, 25 Oct 2019 07:00:59 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm811970lji.62.2019.10.25.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:00:59 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc5
Date:   Fri, 25 Oct 2019 16:00:58 +0200
Message-Id: <20191025140058.10668-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.4-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc4

for you to fetch changes up to 2bb9f7566ba7ab3c2154964461e37b52cdc6b91b:

  mmc: mxs: fix flags passed to dmaengine_prep_slave_sg (2019-10-21 16:16:38 +0200)

----------------------------------------------------------------
MMC host:
 - mxs: Fix flags passed to dmaengine_prep_slave_sg
 - cqhci: Add a missing memory barrier
 - sdhci-omap: Fix tuning procedure for temperatures < -20C

----------------------------------------------------------------
Faiz Abbas (2):
      mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
      mmc: cqhci: Commit descriptors before setting the doorbell

Sascha Hauer (1):
      mmc: mxs: fix flags passed to dmaengine_prep_slave_sg

 drivers/mmc/host/cqhci.c      | 3 ++-
 drivers/mmc/host/mxs-mmc.c    | 7 ++++---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)
