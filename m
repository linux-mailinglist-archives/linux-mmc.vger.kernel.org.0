Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561431BC64
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfEMR4G (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 13:56:06 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39663 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfEMR4F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 13:56:05 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so430818itf.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svhcT8pZvlSPciWupxVEM8LrwN7z1JxmCsWJw2h9m9Q=;
        b=L6Sp30Ee6iOEZ20HswmHjqW+pc5tYPr/+pxzmXrK35gVCoHlkEW3X4csBatj/wttGg
         7rKLgXzkt3AlIz9ePO/+0Xr4N9AAYo+HeWcqr+tT1mdmEHkquxg3di5jwPtyaXd7o+n8
         /DZIWp+oXyM0EXcZOS9nhDL+5SGW+CM96vjVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svhcT8pZvlSPciWupxVEM8LrwN7z1JxmCsWJw2h9m9Q=;
        b=brl3+N/y5dyOZrJqnplr5yePxBzz0RHxoTjTJ1rb/VJVCvREdZTzSVSbyZY9n2h+TF
         Kz/bmYVVxu6amPEnZna35lXknEP2ilUE6Bv3evid6PdkBeEqrUxHWcT4JT+BvzdQOMc2
         ysNI2FZRQCSPvT+mupG/jSlOKXGPe9N+5G06daWMVKxwiVI5KTYhK7tpJC+SqS9D/QKs
         TDrKCoF8XtvTfUOn9LGyfzJRN89k7ed5qXrsFtoP6TCQza26gqypeFRQFcDbkShbZx7z
         Z5kdkDSo1/uwe2OH/OEBTfVdokpY3korsZgpwLoYrYikiunwB0ao25DY5ouXHs/E4yUW
         oHQg==
X-Gm-Message-State: APjAAAVAqGnA4Btkm2gfQ1JJbBpsgeXqrRtZyU+LbU4nn50cd3ReVY4S
        R3m7tj4GelEUKMf50YWKAdIj5g==
X-Google-Smtp-Source: APXvYqwlPT1j1z5u8J5ER885Ue1WqrIsSXOdmMWeu4Di3/W6jE76/mBB2+HjoV7zKSwUDk0NPgKpwg==
X-Received: by 2002:a24:5448:: with SMTP id t69mr335958ita.128.1557770165169;
        Mon, 13 May 2019 10:56:05 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id 129sm5318785iow.32.2019.05.13.10.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:56:04 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [stable/4.14.y PATCH 0/3] mmc: Fix a potential resource leak when shutting down request queue.
Date:   Mon, 13 May 2019 11:55:18 -0600
Message-Id: <20190513175521.84955-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
potential resource leak when shutting down the request queue.

Once this patch is applied, there is a potential for a null pointer dereference.
That's what the second patch fixes.

The third patch is just an optimization to stop processing earlier.

See https://patchwork.kernel.org/patch/10925469/ for the initial motivation.

This commit applies to v4.14.116. It is already included in 4.19. 4.19 doesn't
suffer from the null pointer dereference because later commits migrate the mmc
stack to blk-mq.

I tested this patch set by randomly connecting/disconnecting the SD
card. I got over 189650 itarations without a problem.

Thanks,
Raul


Adrian Hunter (1):
  mmc: block: Simplify cleaning up the queue

Raul E Rangel (2):
  mmc: Fix null pointer dereference in mmc_init_request
  mmc: Kill the request if the queuedata has been removed

 drivers/mmc/core/block.c | 17 ++++++++++++-----
 drivers/mmc/core/queue.c | 14 +++++++++++---
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

