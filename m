Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E433423A30
	for <lists+linux-mmc@lfdr.de>; Mon, 20 May 2019 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfETOgw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 May 2019 10:36:52 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33958 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfETOgv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2019 10:36:51 -0400
Received: by mail-wr1-f51.google.com with SMTP id f8so8501694wrt.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2019 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFRzHXcbH/njSoGGo1Gbge1+dcPHXnbF0eN6VmDGfKk=;
        b=cGIxTaAv7Xxcx+gwpdz+0E36ZfBnEKC49CjmBmWKp1oag2/nul4LIkhXLIDtC28CKS
         s7+A37RJlbOJLnGk4r2rvohjxHlAqHzgliP1t36VSosNA8knV3qKQtCm7cg9QKSDXjYW
         /vK5jjh3nyiv/thu4IOsnIFKIfwXwo6kPct7PmhrhZ4QVo/LTxwDkmQXwpEJC6o+gj8R
         z9b8CjojJPGxCb1T6epaj/IkfT6df3W9XGi4gxlWoK34sk9Y/EqSbvOPRrE9kdYtRhr/
         FlXHQsDAbi+detoTyngqRN+xLcznwSjKiDT2LsULYZMpHr8LXeLMXXmsgQ/GQfPiqd+T
         v6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFRzHXcbH/njSoGGo1Gbge1+dcPHXnbF0eN6VmDGfKk=;
        b=r8F8Eee9AuKNd9dzwthZ1jC4gMzbY6bccQmasxQOG/+qP4KV4D+QzXhjzR/eRcbmmd
         rkgYQdmoSj/a+Ajx8mKXIXAokM7LDHhi7Rlgay1ngQo1luDtUP+NbhUavL3pGxqMJRko
         vLC3RTS8ax4C0bHDIbxzOwq9QvcvjoGJG6jDRWBXQ4Ki0AVP0oufd8o/CC2sByj571mb
         z+MBzcHHEDO108dyc/1Y71w2rPSrZlKeCo/HITNZdtFuUr1RCzKzPnmMuoAArOQXaoDD
         BT+uRhj8xsk2vSEdE8B4kNHIY9OKBhvMwQd+UhtjJv/tXH2x89PnE9+C8O6G8IolFpK7
         5Wvg==
X-Gm-Message-State: APjAAAVzJZumW93T6ETQReDOc0WjslDNHe+/Af3ti/NHzySLoOsIdH9G
        h1T/AfAsYmJYjoAY3+nEkodGdQ==
X-Google-Smtp-Source: APXvYqzIAdN8iLbDHuNeo3JWIWO1opaYbet7cj7r+qxT8zkkAZ5YaL/XT5xl6XMxfrwKdAM+J/6Krw==
X-Received: by 2002:adf:f548:: with SMTP id j8mr11400171wrp.171.1558363009994;
        Mon, 20 May 2019 07:36:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm20518729wrm.94.2019.05.20.07.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:36:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:36:45 +0200
Message-Id: <20190520143647.2503-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic MMC drivers.

Neil Armstrong (2):
  mmc: meson-gx-mmc: update with SPDX Licence identifier
  mmc: meson-mx-sdio: update with SPDX Licence identifier

 drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
 drivers/mmc/host/meson-mx-sdio.c |  6 +-----
 2 files changed, 2 insertions(+), 19 deletions(-)

-- 
2.21.0

