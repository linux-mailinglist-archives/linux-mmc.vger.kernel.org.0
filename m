Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E636A621
	for <lists+linux-mmc@lfdr.de>; Sun, 25 Apr 2021 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhDYJnP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 25 Apr 2021 05:43:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:54214 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJnO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Apr 2021 05:43:14 -0400
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5877CAB645;
        Sun, 25 Apr 2021 17:42:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3565T140663333058304S1619343740259115_;
        Sun, 25 Apr 2021 17:42:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f407789d117d356caba42a584908fd2e>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 29
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        cl@rock-chips.com, wim@linux-watchdog.org, linux@roeck-us.net,
        jamie@jamieiles.com, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: i2c: i2c-rk3x: add description for rk3568
Date:   Sun, 25 Apr 2021 17:42:10 +0800
Message-Id: <20210425094216.25724-2-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210425094216.25724-1-cl@rock-chips.com>
References: <20210425094216.25724-1-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

add "rockchip,rk3568-i2c", "rockchip,rk3399-i2c" for i2c nodes on
a rk3568 platform to i2c-rk3x.yaml.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 7f254d79558c..5339dd4fc370 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -36,6 +36,7 @@ properties:
               - rockchip,px30-i2c
               - rockchip,rk3308-i2c
               - rockchip,rk3328-i2c
+              - rockchip,rk3568-i2c
           - const: rockchip,rk3399-i2c
 
   reg:
-- 
2.17.1



