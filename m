Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278AB12ABE6
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Dec 2019 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfLZLak (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Dec 2019 06:30:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39457 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Dec 2019 06:30:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so12735052pga.6;
        Thu, 26 Dec 2019 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xVqi8Ezys5+ClGRWeNPQQAyLRAEWdLu+8HS/B+Hm9+Q=;
        b=LflpGWB5vc4u6FB1Bd9G1fD/SLmfp5kINLHFXcCNYRFo92iQka3mrY2hY11WkZHfUx
         rBd2fpB/kcdqwSYlLsCY3AEJ+nHuycIAlveIkJYZ5g8SRxQ4BKcYZKjbYKuC6lY5+gEt
         4Bt80MyDbMLKn7X9tm3TsbwGuTKwIYIcvq9z5gmS7klL0Y+vVVFXGc2qXykXJ56Vd4vG
         nB7ROeG6CunoT7u5apypiJbTNeZMrvla+ESpxr3YjLUVjN4Ra4YkTlMXFesu+tJ9zeCd
         8ojW4n51RmCf4IlnPOMnSGP+n8nGEl2v2bprxpDgQR73T3yFRLLWM4pH2bQMHLGkXoBQ
         htFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xVqi8Ezys5+ClGRWeNPQQAyLRAEWdLu+8HS/B+Hm9+Q=;
        b=mwv9i/dZu71MECX0XX9w7Lw+0t8+SEb3Cxi63C0+7QuLI9Sqboxfoz5Kz//ZZ19QaS
         8bLq+7689k1/PPRym7vk7TCq0iFNtyhWuJDzXdSg+x0qSTJzz2ViIbDnvr3QUPgLTB9e
         4F7ENhRTeyusbPm8QpZ9y8hdiFQ+luNJrB/MdzmqLiO8Yc1fgrM2R0ZBnMs+ZMXthk9m
         yNQvI+xSwbpCSURMi2XRbv3meUiV6uawamcxsVgxQkwMm7KBdClInzduZA9ncfniC5vQ
         pIvpcSc+kJBdA+Qs+LN6n0/y/2VUoyo0B0bF8ZnusVpimxhhkkZd09v77i+tSKpM2Ggd
         ALHQ==
X-Gm-Message-State: APjAAAWuvOpqFQdUiTpF9zocsp7102T70LlKaPNUnEWLDvtZTlCgbEBd
        uR7RIpjlGfuFwlr/a26UMZjVSor9wKg=
X-Google-Smtp-Source: APXvYqy0H3wjobzhB6cVtGzXNu93r/8f1SYHLBq23t32tCHR+cr/LnG6SUc19ESWOOZRkOHeHK7aow==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr9393482pgj.102.1577359839245;
        Thu, 26 Dec 2019 03:30:39 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y6sm33743287pgc.10.2019.12.26.03.30.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Dec 2019 03:30:38 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Introduce the request_atomic() for the host
Date:   Thu, 26 Dec 2019 19:29:18 +0800
Message-Id: <cover.1577358666.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set introduces a new request_atomic() interface for the
MMC host controller, which is used to submit a request to host in
the atomic context, such as in the irq hard handler, to reduce the
request latency.

This patch set is based on mmc/next_host_sq branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=next_host_sq

Any comments are welcome. Thanks.

Baolin Wang (3):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci-sprd: Implement the request_atomic() API
  mmc: host: hsq: Support request_atomic() API

 drivers/mmc/host/mmc_hsq.c    |    5 ++++-
 drivers/mmc/host/sdhci-sprd.c |   28 ++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c      |   27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h      |    1 +
 include/linux/mmc/host.h      |    3 +++
 5 files changed, 53 insertions(+), 11 deletions(-)

-- 
1.7.9.5

