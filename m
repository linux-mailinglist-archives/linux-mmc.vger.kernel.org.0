Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050BA151738
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Feb 2020 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgBDIzM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Feb 2020 03:55:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34097 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDIzL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so17723785ljc.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a7A+8EuI5CL4qmrNQ0e164pG8EiEQp/zBKjR7+3Tt3k=;
        b=xwBTVJugDpgLIqbNn7+t71r9h8/eqPT77/WoaGkit1MM1tgcfvoCRsbUbjwLZFIVoV
         HyWubAHxwlm8jAMjd4CGbCBHzOiZfjTR2pX98ZMkP3o2ts2ORvCVJB9atDfQQ2p1giXZ
         xBpKX+EA5xD0YgLkHPX6eRFPcCX8l/B3UHyFL/b5aiSA65s02amy1fQbAag7xHiOQb6m
         uuyi29nMqbiip/ZDFJ7HepK1R/uy219FJ5G5ej8HMUwZ3WW6BTMufJrUKq0Z2QOD6HM8
         Mnjt2semfJ0VyY1NyoKrjzIEpBIzpKVEg13stQh0lKATi9fwAMvW0cNAKm0uyn4zLgX3
         gNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a7A+8EuI5CL4qmrNQ0e164pG8EiEQp/zBKjR7+3Tt3k=;
        b=I5Hji6RwZOZWw9iE1hm3bdj39NwWiibDkTr1J5pVtTkzJpo3egR/9G+Cx2HkeEbwno
         WFCE5yQ+M7Af6ds35C6gaSP7neusTsKgHLoSrUy5TA7MWY/ds9kKcp6rvn9ky/5EPc2q
         NIGuNLEv9arLF4sq96i/deg2Q/5Ju4q+9h5sY+d+XQkMfAdHLTXygQhioIPCdfz3hChV
         /bh9iTTwbylmIRkorRzDOysWyDqY3h0ddV1xhQ9+VD5kf3en78gEtkP2Pfb5dhs0ik2j
         4vsjOHI0EHeWe+iIjAB0wnQYOUhqGvDhXjm/iAZhv9Pv9BD2jLIw62RmUzYRxzNGvD9i
         sMgQ==
X-Gm-Message-State: APjAAAVnABDFxzXfM5ecyttxTiaFoSCc3q+PyDhUaaaEZIXba5TvKFrt
        9udBSzRlCQsu27/0K1NLaRhufcj60Cc=
X-Google-Smtp-Source: APXvYqzHIRvaxK/AtXGkNR+2KxETLtsvk6DqS3y7G647+OpwPxuHp/s0NRS32/TREbKx/SFYsMcSfA==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr17091485ljj.156.1580806509559;
        Tue, 04 Feb 2020 00:55:09 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:08 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 02/12] mmc: core: Drop unused define
Date:   Tue,  4 Feb 2020 09:54:39 +0100
Message-Id: <20200204085449.32585-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The last user of MMC_OPS_TIMEOUT_MS was recently removed, however the
define stayed around. Let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 446a37cc2a86..35df97fe9cdc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -19,7 +19,6 @@
 #include "host.h"
 #include "mmc_ops.h"
 
-#define MMC_OPS_TIMEOUT_MS		(10 * 60 * 1000) /* 10min*/
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
 
-- 
2.17.1

