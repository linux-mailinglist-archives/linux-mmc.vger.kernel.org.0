Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F44E923
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Apr 2019 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfD2Rcz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Apr 2019 13:32:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35245 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfD2Rcx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2019 13:32:53 -0400
Received: by mail-io1-f66.google.com with SMTP id r18so9731617ioh.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2019 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63aD6WO7A1p5vw0l0eCm3B6MhF/Ss3f21asqmxXDYpI=;
        b=odaReNKromheyA8ntOKaPo0HdjrpEPvLJSnhQ4bBCPuUplOwb5tvW7hj9rVnG+8I1+
         511DP7QERvd/ergmKSXbuSLxQ9serPcbPXRzUPYorCfgHZ/nYH8zIPpDr+gFhGwoNnk8
         wT4z5cxmA4pgtaomRcrEXrHoa1OcUrFFqHN3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63aD6WO7A1p5vw0l0eCm3B6MhF/Ss3f21asqmxXDYpI=;
        b=Xb5FZNIzg9c9RuELFaWkkon3bk6wQoaEuxMiGZ+QhIqcslC3HG5oydx3SpWzP/LFAY
         FCluXlF0PjAfOR8tnwjHLxKFgnhgdzKExFVSt+fg+a9NUmdvQdilmToV/Gc8FxKVsnwg
         uaDm9fl/86+KTVmSc81ReOOeOrf0+QUDK/pEg3ZB7PamDhsoTyVvcNqzAkm7tMwyG3CC
         UZuI0NRm+Uc2/yC1K14zrShnzSCh+xN3MJiL0tb0JHs3WSpEkgOyU85dSQffxfJNPIUU
         PoN1Cbt9xG//wyrPPHhktyMz/AU/mPB1pSS+iJbPG/bo+oDvmH3RWLK9thtEhEuoiZlL
         9rAA==
X-Gm-Message-State: APjAAAWzgYtXbBA3CZsX4LtT/q87OunbaQ6C+SrnmLblEkrp11rmWkNY
        5sKqxshLQg9Puv3ph+UYVMRq0Mr+jYSuqg==
X-Google-Smtp-Source: APXvYqxUg7iRGY3aXoZbjAXcrFjnbr6ZgUrIoeZ/sQjaSyaPcs5dFxcRM+bTnzwciQ/pwBtFE3OGPA==
X-Received: by 2002:a6b:cf0f:: with SMTP id o15mr35513809ioa.5.1556559172442;
        Mon, 29 Apr 2019 10:32:52 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id 62sm64920itx.41.2019.04.29.10.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:32:49 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3] mmc: core: Verify SD bus width
Date:   Mon, 29 Apr 2019 11:32:39 -0600
Message-Id: <20190429173239.51305-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SD Physical Layer Spec says the following: Since the SD Memory Card
shall support at least the two bus modes 1-bit or 4-bit width, then any SD
Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").

This change verifies the card has specified a bus width.

AMD SDHC Device 7806 can get into a bad state after a card disconnect
where anything transferred via the DATA lines will always result in a
zero filled buffer. Currently the driver will continue without error if
the HC is in this condition. A block device will be created, but reading
from it will result in a zero buffer. This makes it seem like the SD
device has been erased, when in actuality the data is never getting
copied from the DATA lines to the data buffer.

SCR is the first command in the SD initialization sequence that uses the
DATA lines. By checking that the response was invalid, we can abort
mounting the card.

Acked-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
Here is the testing I did:

Good Trace: https://paste.fedoraproject.org/paste/oVEI5b0IzHD23Yo7CDZgEg
[   30.103686] mmc0: new high speed SDHC card at address 0001
[   30.105262] mmcblk0: mmc0:0001 00000 7.41 GiB
[   30.108258]  mmcblk0: p1
[   31.947250] mmc0: card 0001 removed

Bad Trace (before patch): https://paste.fedoraproject.org/paste/jBWfpFBM8gdEmGOzxij~hw

Bad Trace (after patch): https://paste.fedoraproject.org/paste/8gB8MLYOKEUZEgHXmQ0W1Q
[   33.810760] mmc0: invalid bus width
[   33.810782] mmc0: error -22 whilst initialising SD card
[   34.068818] mmc0: invalid bus width
[   34.068839] mmc0: error -22 whilst initialising SD card
[   34.329521] mmc0: invalid bus width
[   34.329543] mmc0: error -22 whilst initialising SD card
[   34.592061] mmc0: invalid bus width
[   34.592084] mmc0: error -22 whilst initialising SD card

In the traces you can see sd_scr is different

Changes in v3:
- Rebased on mmc/next

Changes in v2:
- Made the bus width check stricter. It now requires the value to match
  the spec.

 drivers/mmc/core/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..d3d32f9a2cb1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -221,6 +221,14 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+
+	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
+	if (!(scr->bus_widths & SD_SCR_BUS_WIDTH_1) ||
+	    !(scr->bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.21.0.593.g511ec345e18-goog

