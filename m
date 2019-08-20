Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5E95DA3
	for <lists+linux-mmc@lfdr.de>; Tue, 20 Aug 2019 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfHTLmj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 20 Aug 2019 07:42:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbfHTLmj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2019 07:42:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so12044402wrq.9
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2019 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+GZ1Q8wGszaDJfXP/7WdFfec4zmxqrhJ7sXPQ3JXVc=;
        b=myP0tEWCcj4WIwVBmBEPYhmiTBc2h/+TkK5yZGnGPrP79tjlcGCUpxZgQmiFInQtVZ
         0dPXFO0eChSxesals8JI4NsImwy1SiAHwr+dVatad46Gqg6HfHSz6dzBlqdUr/2PcBJ4
         msp+CuAnsLaXRNi4C1mZFDvDA+nYTHIsbqqgsMPMBO1PIZEFRdR3Wx8T8zwkjUZh6uY6
         Vit3+AAm/isRXSrBWUYbN1i/59iy0NAiIEQr+8UIHh9mr3d8nN2vtFGSfcclN8Se8DVh
         MF61VViLWJR2B1CfV6I6Ua1aRorwGN2I5lJjPzPNFyH+Scaq5iG/IOxAJjE5BLAasf1c
         VGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+GZ1Q8wGszaDJfXP/7WdFfec4zmxqrhJ7sXPQ3JXVc=;
        b=VRd+9JYeNUvUskdEDumdQk3orxMfRxXeCYi+xCdlgq+t6FpFmgx/Hqk5nDQQXx+Nt5
         kxEPGwtzjJyQK1KtJXNTXrF59Scdgq3uucfMS73iqlgBziFCuF0MQGAEGZGfbfktDhHF
         /nX/C6UZEnU/lNWCvUh/HzjXWyWfWgVyZkPQNpL+i26Si+Kc6V/mJrDOVfYorojmOUTF
         5cTlew4ppmNcZMvxYrYoqbcHFQCrY02CudNlOSOP8VC/Wbx+FYMK4JEBvJKFBwoCOpey
         FHTdeY3fK3DpXqlGqzOKRBC4wh14lemB5ygukVkYHXykREJTUL2gKP8umbERadXFQ0z9
         8JNg==
X-Gm-Message-State: APjAAAWkjEBdzEdvnYlQIRthfusI/Y9dLAlFzvYdvJW5na53RSPuxQoI
        dzTFT/mJnq8LtLo4uRWPYtu62hbhogE=
X-Google-Smtp-Source: APXvYqwl4e1joPEvf26h8M/cAnvnBYou678iBv2PyuW9tNQu/qWNAaVIusJRkdNdKPG6adQZH1FWkg==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr33395859wrx.180.1566301357536;
        Tue, 20 Aug 2019 04:42:37 -0700 (PDT)
Received: from xeri-steel.it.int.avast.com ([2001:67c:284:64:5646:bb87:150a:dd53])
        by smtp.gmail.com with ESMTPSA id c21sm12156494wml.48.2019.08.20.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 04:42:36 -0700 (PDT)
From:   ja.kaisrlik@gmail.com
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, Jan Kaisrlik <ja.kaisrlik@gmail.com>
Subject: [PATCH] Revert "mmc: core: do not retry CMD6 in __mmc_switch()"
Date:   Tue, 20 Aug 2019 13:42:29 +0200
Message-Id: <20190820114229.11948-1-ja.kaisrlik@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jan Kaisrlik <ja.kaisrlik@gmail.com>

This reverts commit 3a0681c7448b174e5dcfd19e9079cdd281c35f1a.

Turns out the patch breaks initialization of Toshiba THGBMNG5.
[    1.648951] mmc0: mmc_select_hs200 failed, error -84
[    1.648988] mmc0: error -84 whilst initialising MMC card

Signed-off-by: Jan Kaisrlik <ja.kaisrlik@gmail.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 74e4364bc9fb..09113b9ad679 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -564,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (index == EXT_CSD_SANITIZE_START)
 		cmd.sanitize_busy = true;
 
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		goto out;
 
-- 
2.20.1

