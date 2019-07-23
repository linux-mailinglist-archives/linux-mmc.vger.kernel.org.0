Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6771777
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfGWLuu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 07:50:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41995 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730670AbfGWLuu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 07:50:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so19306066pgb.9;
        Tue, 23 Jul 2019 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBge7YjElO6QELDaAyXNwqPgMlSt8RrUe6yJAAvRsBQ=;
        b=Fnk4GPD9ipYpd5G/f19UTtdckAVmhl7eF3OHln9LtlUnXrUu2/jxGWUjLAzQmExSpG
         bcaurTnk/OtFq6bRq6UZ0ucc0zkcabTy0TyiWsNYf/FcmFFVmtUbtqp6ouigLf6PgoDF
         JjpBRJ2d+DfY3vZK1lR5qtbDF/O6PKEFzdWwHBfD56I35umqUTJzxcK42rMI1xyM2JFd
         m1WnXSDikxe2CIf+XxAslD+CI4JuD4sjpWKP0B31Vh0Qfm03/542BbVjEZeDzJiWGs5v
         sZLA+XUet1HAFuaipHqKnXpgRUuMoVT+oJz1spVvVs48ItLX7r+JqM4zEcaBG6sb25PQ
         cYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBge7YjElO6QELDaAyXNwqPgMlSt8RrUe6yJAAvRsBQ=;
        b=mnCexmY9QOxI1QOAse1BPLh4rmsjTiRohpkgGJhXJlBS6Ts3LpoHeEA28YJ5FITE33
         wwIk/iovlfnjnG+/XjjiNWFeJ2PSydrtBg8V1vEr/Uso3au4s3g6fBhE9/BylkuhwA7l
         BgD6OuDhtVetX1eEyS4P0z+EIqLt74qIqJ70fgL3aokBMaVmHY/2gkLCEykYs3rNoYHY
         K2Ss63ZEY3jJqnGotYVEdhxbvvLsBE8ZZJwuvCuxtg2pvf4BTHIYRtwuZFRaI+1AemTx
         oeOIBCOmr6m2j5FUavbv1Ed8E6vdipYJiPsf6Mdg+XyTeZJZIeRpKhEnzHJAf5ijBCHq
         Nymw==
X-Gm-Message-State: APjAAAW96t0yU5NMoleNIVX1w4eJvh4ZYZE4XqXi7cVooY2ISYndZjdE
        1I1hWjwJy6IEz3ghiZ7fS6E=
X-Google-Smtp-Source: APXvYqxYPpC+o8AAs6hL4yB8tUpEShKyZC5ohzxed8z8J49wrfr9XdIv7D0FoxCDD/sjmYDFuZMMfQ==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr5260749pfu.241.1563882649787;
        Tue, 23 Jul 2019 04:50:49 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id k6sm51991430pfi.12.2019.07.23.04.50.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:50:49 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] memstick: r592: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 19:50:44 +0800
Message-Id: <20190723115044.18591-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/memstick/host/r592.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 2932f421b3ea..dd3a1f3dcc19 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -847,8 +847,7 @@ static void r592_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int r592_suspend(struct device *core_dev)
 {
-	struct pci_dev *pdev = to_pci_dev(core_dev);
-	struct r592_device *dev = pci_get_drvdata(pdev);
+	struct r592_device *dev = dev_get_drvdata(core_dev);
 
 	r592_clear_interrupts(dev);
 	memstick_suspend_host(dev->host);
@@ -858,8 +857,7 @@ static int r592_suspend(struct device *core_dev)
 
 static int r592_resume(struct device *core_dev)
 {
-	struct pci_dev *pdev = to_pci_dev(core_dev);
-	struct r592_device *dev = pci_get_drvdata(pdev);
+	struct r592_device *dev = dev_get_drvdata(core_dev);
 
 	r592_clear_interrupts(dev);
 	r592_enable_device(dev, false);
-- 
2.20.1

