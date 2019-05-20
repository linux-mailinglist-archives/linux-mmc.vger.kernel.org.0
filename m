Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDC23A38
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbfETOgy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 10:36:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfETOgx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 10:36:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so4143665wru.11
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xr+p9+oV/45aNpqnSTpfxQs3ZF3NmaIezU85bCSPol8=;
        b=Ch2584po8Kd0TeHViJj7L0nIvT3rohiPNenEsT1/KQd2Cq+nUFmot2P1/acoSMtXZt
         ZZ1v1fIWMXGtUUgXqUhOmKFs6G7uD/oHDoFEceeJUG4DBNaEiRlYDGKTcCHYjkTmsg3E
         3jOE30AxuUojQ9wQfdLPxEf6P1JWTxYq2uedN7nf/p2PbF9oDyekGNk+DjS3GVrXWm0z
         FM06h/C/Ykt0UErAijScXMAEDedzRUTsjPtLTYz0QpbUjEnPOqMdUNLkR614+CmS08vx
         17y4i+yPTUjuSk78DZ21Ewa6UhHfqgIM/izYdsJqmWhWccbbIK+6ccT8qLVYLZlhKGgV
         AMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xr+p9+oV/45aNpqnSTpfxQs3ZF3NmaIezU85bCSPol8=;
        b=ngDBNCUzEDhDEb7I7vSYkHFnVV9cK0/tGqUfzalE1W9nlSyi2iv/T1TawNwmyUxkzT
         6P5loEFc7E2qp5t1VaJhTL8Dm6GaFGS3jCvK0DSetY5jPby6fgIWHMsGvxn3ayw0dWAy
         geU0GLNAiK2b4tCzhuxbZz8JMeZ1misa29HUXw3D3bOmx1oww+v9H1L0sIk7dq7c2tEG
         MbX3K+Yf5dYqE8vPcnDXmEECurVMPRnoJmvYMo2NSV85Uby40sRCa5vQLNXkAx4/BTz2
         RgmEbInWkMSvac4CuoBaN9KgeWjo2R04rVEigUl5mqntP17SyhwQ4kyDxxTlNqD8zj37
         pygw==
X-Gm-Message-State: APjAAAX/R1eTRdf9yCbFEPODlN+PdRexy+J5oJizywp3aQPu1U9V+kON
        v6FQaVPv0LaExxOc8WFJxelsiQ==
X-Google-Smtp-Source: APXvYqzmmeDy34jQY80IKaTb1i3fodpM6cHRtDfLjCzQsNb17ZPb7mhlh0dJ7te7e7NWiXdVL2lH4Q==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr32363253wrv.229.1558363012289;
        Mon, 20 May 2019 07:36:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm20518729wrm.94.2019.05.20.07.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:36:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] mmc: meson-mx-sdio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:36:47 +0200
Message-Id: <20190520143647.2503-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143647.2503-1-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index b61de360f26f..b2a7288cdec8 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * meson-mx-sdio.c - Meson6, Meson8 and Meson8b SDIO/MMC Host Controller
  *
  * Copyright (C) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

