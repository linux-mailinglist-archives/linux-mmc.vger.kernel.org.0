Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8113A75D03
	for <lists+linux-mmc@lfdr.de>; Fri, 26 Jul 2019 04:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGZCc2 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 25 Jul 2019 22:32:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45243 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfGZCc2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2019 22:32:28 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so101630226ioc.12
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2019 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hjnTOfrkCf6Pxwx0opT1YXXWoy8CC0TFrAnbThtiaiM=;
        b=c0so6zXccYERZ2AsoYUNYSxEbUG1mPBQkOJX6qRfHDyFpVedfUzecJ+hW7rqFZAVVk
         infBitUHEGMjbS1IV4piWMQdNkZ5pGYntzVsasHx81uC44hGQQDHhKuviR5A/Ini17j2
         OZfqfC9ZyOvzjx9vkfgfBbUxndpcowUDZ3YvyGqz92B0OxksxXQ8IfMi4HCYBQQ6PWOd
         4LyfSNU/Vn7BAcFKt5B4ZBaSF+o6qf+rJ3jJ7P0QdvTGo/+cLWU6LB9I3MWsUukqyUaB
         u9ma+tQ1Q11jMeIkSKIAl9/ZFurRTe1cove4CIWKKT6QYUVRet2jk7t4nhGYs41RTB7P
         amfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hjnTOfrkCf6Pxwx0opT1YXXWoy8CC0TFrAnbThtiaiM=;
        b=V+iYISWViyCn6yz5JSqtamCCDh/XsR0TT/fyXCE6VYjgIaNfZyDvqpV+WUkXGEueb/
         zuOKr/UT+GH6l4KijUOa1S5jY5wifKHUXfrmmUMefIi5eqnIFTH/04+kQklnR9JVbWDJ
         1w4hFzsKcKYuhieeqMFJXaA6kwD2dJ1auMEmgOK9B38HyYyaHMucS5fTaUF4H4Bv65HE
         bxxcndd+g2d8fZXPMcm8z92DqEi6PUDxooGDzj3AMo6McPY7SLnOd2/eyabLFctxMgCR
         QJRwooTpTdDFfFr4yrfNhqeEZktuafcpij0m9AsetiSv4Vvf9X3lj+SMlOkcwDzLM8t8
         KL7g==
X-Gm-Message-State: APjAAAXI01RP9aXZescIuktGLG8MYvvYHftxTMtNoperxyiw9hPepj3N
        dmgB8XG2OhgVapJaAKIyGywkQl/4zyc=
X-Google-Smtp-Source: APXvYqw5HsIONQntgGXnLI+MQ5CakB+MV9sQyH7y2iV+wjGGNwqNLvgzfP4po0iHr5eVezF5dgS/kQ==
X-Received: by 2002:a6b:3102:: with SMTP id j2mr19227706ioa.5.1564108347309;
        Thu, 25 Jul 2019 19:32:27 -0700 (PDT)
Received: from pek-lpggp6.wrs.com ([60.247.85.82])
        by smtp.gmail.com with ESMTPSA id c81sm79643973iof.28.2019.07.25.19.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 19:32:26 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Jan Glauber <jglauber@cavium.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: cavium: Fix two calltraces when the
Date:   Fri, 26 Jul 2019 10:30:47 +0800
Message-Id: <20190726023049.27055-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes two calltraces when the CONFIG_DMA_API_DEBUG is
enabled. Build and boot test on a Marvell CN96XX-CRB board.

Kevin Hao (2):
  mmc: cavium: Set the correct dma max segment size for mmc_host
  mmc: cavium: Add the missing dma unmap when the dma has finished.

 drivers/mmc/host/cavium.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.14.4

