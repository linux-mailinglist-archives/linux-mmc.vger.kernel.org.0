Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE8518EE3
	for <lists+linux-mmc@lfdr.de>; Thu,  9 May 2019 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIRYg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 May 2019 13:24:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46151 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEIRYf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 May 2019 13:24:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so1529198pgb.13
        for <linux-mmc@vger.kernel.org>; Thu, 09 May 2019 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O7p7NTvVuCz3Gx9e1JJz1oyAzlFcn1IdSFVX36X3QfA=;
        b=B7L2LlJN021oT4mU4t8DmWuWOHn9EHEhxgaMb30YkPy61+GfoLji1wxe6NTpWb5pLw
         qpma7dhni1viZxz+Aw7AHXQLazmpPZnq5boazM+nfeZrdOc5yH+MjngOd1Fit+aPZmKG
         Jwk/vIl26z4LUxRtoUM6auka6TlvyMavdVLOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7p7NTvVuCz3Gx9e1JJz1oyAzlFcn1IdSFVX36X3QfA=;
        b=XfL+39Xe2Wp9UohRxpfIZoMAece6BKNFobavW5+qVJSoJZIoisY/vmKz0nwkqQ3Yt4
         xl2ux+qwP/HS7QELrVxK5gr/yQGRvxljjQPoAH/1L4aGULjfjyznxsqCU3ZfF2ytGoXg
         nfeQ54kiWdqS9ttKhYV8/DI7LfGR3qf+PecW0LV1x18xb8u3RYNCl7hk+XXiLfGlai7T
         1WY/S1r9lXaZ26EsM6QZZbqTWjFToCiL0hyiUO+frFU/uGkeOVdR+41/PyIbQAaaflGQ
         CcjdSL+75lZwzzXhCgS9bcmj8wgX3w4mAOeOmkm605QFESve1sVdM4vi7xGbY+Zj+yKz
         5pcg==
X-Gm-Message-State: APjAAAVC5U9axnhQ8k2eoGsIr3Z+nkFPndmAb6AvNwzDyGwsw5NoRgzB
        wD756ashL2VfgUwM3eKHwJxCEw==
X-Google-Smtp-Source: APXvYqxCYbzrMzhW5xZiImCpKDe6+G2qK6l5xaDKLeoFmS7L6yU4j623I/gTKX5S9B6AvIdcLsVn5g==
X-Received: by 2002:a63:1820:: with SMTP id y32mr7065621pgl.287.1557422674957;
        Thu, 09 May 2019 10:24:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m8sm3989699pgn.59.2019.05.09.10.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:24:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date:   Thu,  9 May 2019 10:24:25 -0700
Message-Id: <20190509172427.17835-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes data hold timing issues for various sdhci-iproc
ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
in quirks.

Changes from v2:
 - Added info to commit message as to stable tag selection decision
   as per Adrian Hunter

Changes from v1:
 - Change fixes tag to Cc: stable@vger.kernel.org to specify version
   to backport to

Trac Hoang (2):
  mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
    problem
  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

