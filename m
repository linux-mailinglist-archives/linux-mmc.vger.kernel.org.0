Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291F9C11D7
	for <lists+linux-mmc@lfdr.de>; Sat, 28 Sep 2019 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfI1Sun (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 28 Sep 2019 14:50:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34997 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfI1Sum (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Sep 2019 14:50:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so6620810wrt.2
        for <linux-mmc@vger.kernel.org>; Sat, 28 Sep 2019 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TulEG5PLhY2aVNki5vcfpKGXNZTyPAijTH/d4NuYlvU=;
        b=RaG6Hq0Xx8d56rDP7iIY8j1Tdo5AmQrvx50oOyCUECAVL30vqgo8BOCPZEA03Iil6D
         EPi8qRg8mTuIU4izdDQzmskxvCWBoX8Lk/S7ysGugulb+YOywdQsU9gpbzzp7M85uOKH
         F6JLKHiPYl5yI9MsbwTAcu1/wxzebndbUAsD4Ecg1NERhwL+dsfkwMaZI2IEIJVC1Eol
         Rl/SbZzQzHHTo8hoBwHc9UiokiLM7mjc377fz4ZFO0Fdaqp3bowiWL9vv7k6Vdj75SaK
         1fcmwxcIkR3du9cKdpgzfnKT8j+WVdVGwZsS/JIY/1pl86Kr/ORXnpgpS3KEewwTbvMu
         +RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TulEG5PLhY2aVNki5vcfpKGXNZTyPAijTH/d4NuYlvU=;
        b=E8xaGu4uiSbgb5EEUjeTxeF053X95uTXrQ/j0ARYm3pQthVHgFzffHrvhMfHAb6xtW
         KFYcR+nM3wXQ3xYWcQXj6Y2f25Bci0wvaLDgIaaCg616CPrBn0xxjBs3nNY92RGlYcGG
         cjJTfO3A8XfGenMFJHHEpj4IXOZJGJrjIu/KtKJlYmCi54ls9/4klvN6BhcY845yVGuT
         w2BxlDoe1Tu8IPrT7TGY6mM1PFkeJIZiAfM3KVjPloHvodR94E8fh1WsMH7RdK0VOMhq
         Nn4N6YX5/1afy3dbR4D1074saFSARfDJqqOoS2re/dFvhsL0wRyIrBmxOxarjtKIjFon
         psJw==
X-Gm-Message-State: APjAAAW7oTgwD5h2S+mNmYvaM+yT68+MQi1paWqsshjqQp4KCfULJVES
        s2J/NmUPg2Ynn6qjSNU2V4so+yvu3ZI=
X-Google-Smtp-Source: APXvYqz0DjP/K3pCNXYforcYkSWcMzP/LGv1iq4pSaOwrJBK9/YgtWx1wsT/GLkz93UhdivpibHtHw==
X-Received: by 2002:adf:ec91:: with SMTP id z17mr7820509wrn.346.1569696640266;
        Sat, 28 Sep 2019 11:50:40 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-785-122.w83-197.abo.wanadoo.fr. [83.197.112.122])
        by smtp.gmail.com with ESMTPSA id i1sm21717934wmb.19.2019.09.28.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 11:50:39 -0700 (PDT)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] mmc_cmds.c: fix build with gcc 4.9
Date:   Sat, 28 Sep 2019 20:51:07 +0200
Message-Id: <20190928185107.21125-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix following error with gcc 4.9:

mmc_cmds.c:1918:9: error: missing braces around initializer [-Werror=missing-braces]
  struct rpmb_frame frame_status = {0};

Fixes:
 - http://autobuild.buildroot.org/results/bf3b6f9f6ef39b99842b3c92495b7bf359c68158

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 mmc_cmds.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..6b09f26 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1915,7 +1915,9 @@ static int do_rpmb_op(int fd,
 	u_int16_t rpmb_type;
 	struct mmc_ioc_multi_cmd *mioc;
 	struct mmc_ioc_cmd *ioc;
-	struct rpmb_frame frame_status = {0};
+	struct rpmb_frame frame_status;
+
+	memset(&frame_status, 0, sizeof(frame_status));
 
 	if (!frame_in || !frame_out || !out_cnt)
 		return -EINVAL;
-- 
2.23.0

