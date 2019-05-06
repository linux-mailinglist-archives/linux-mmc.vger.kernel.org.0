Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB215229
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEFRBc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 13:01:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34635 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFRBc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 13:01:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so6761473pgt.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ceVsLMW4pfAgwTpw+rjemHyYbwaBaIjRgX4iRGavJHw=;
        b=IJoGSDvYrsZ99JwAf7C6iZ2JWVjNHgQibe0U3pb8+t/jqt6kk6G/+6PxzM9g7rboPM
         QGSnG11S94h9GKIwo7c0Sn1l4/8RnlREfgdA1GIu7Y2tYGNXrhTlJ5oPJlCzsQJXnQnk
         m5+54t8FOV9jzC0zJdF7MtqG6cLSntjJs40Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ceVsLMW4pfAgwTpw+rjemHyYbwaBaIjRgX4iRGavJHw=;
        b=tOQ2YyOsU7DOU6uUrbFbMY+8DAEe0LoY1/H4PbbXEbgm6SolrYeckqzARsfVqbkDEI
         WuZB3Xgj5Kp5UiT8sKS1o6FjXG/FrotnFo/WPYoN6dfz9rM1nixnm4DGra8SPRZFnZY2
         yYDJH/TgS6Ro6sBojZvIG0X+iRruXzpwrJ+TaU7TQaLkugI9awUzkxlLwHiw3ldXftWh
         2zg2qhqltJYcz3qe6qFHiMtWh2CGJoPjM66m3yJUNfxTeZJXYCiQ73Qu1l9mHkkGY9LF
         8APmrFz77s1Hn0L0Vl846Wcjz25WYmGf6utj6TNpe1LcLMZI1VqH6ss3LoKM/3nkcyJg
         QGEQ==
X-Gm-Message-State: APjAAAU8nFevlm/gB/1WkBdFQ/y34IgDgQHkvIXYY3LZtN+jz4zuwWNs
        NPiuhdJkiBvS/MACsQlNwKsk7Q==
X-Google-Smtp-Source: APXvYqw/1HqR1LsbVe6kB0/Yd+43VTyRK/c5VjhNsOI8oAj0vDaiRaaZ9GTE0t03D4ztVzojI9HfiQ==
X-Received: by 2002:aa7:9214:: with SMTP id 20mr34245323pfo.202.1557162091742;
        Mon, 06 May 2019 10:01:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l23sm4555644pgh.68.2019.05.06.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:01:30 -0700 (PDT)
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
Subject: [PATCH 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
Date:   Mon,  6 May 2019 10:01:13 -0700
Message-Id: <20190506170115.10840-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes data hold timing issues for various sdhci-iproc
ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
in quirks.

Trac Hoang (2):
  mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
    problem
  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

