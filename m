Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76C09C727
	for <lists+linux-mmc@lfdr.de>; Mon, 26 Aug 2019 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfHZCPx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 25 Aug 2019 22:15:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33525 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbfHZCPx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Aug 2019 22:15:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C673621F18;
        Sun, 25 Aug 2019 22:15:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 25 Aug 2019 22:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=5HH0SDUDjRUO/CjnMqxbLxtd9W
        vPtHdd1vX8IagkIVU=; b=fQj6puKz2T8eR411RhHtM0GGLu7IKaPpkIZcw5LLEy
        djuvXoAnCMjVSALDV6vxlPeDNsxB6UOcQiuFfezoN12Mos5C2yDhCiwkstD4tI6g
        ctDs5n6mvhc7u9KmHxWyKt0vlSmRio22Mmz5w/2FBYPxCMsXmrBexTbhsgKFIa7c
        QiX0hhb6tDoZLDAhZ8s6pc9mDLbi8PHe1IG51ErssC9JGhDcdSf3QYjaMNtb6jY8
        mDYyfETSusbESJw6gTYRr3x6PmwvSfzWWMpj2gSTIP5uZzvviDj/2idQ87vP6o2V
        echX0LOopFfC1dPQ5YHlr7rcKi7srI08N6DTsOZx6GpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5HH0SDUDjRUO/CjnM
        qxbLxtd9WvPtHdd1vX8IagkIVU=; b=N4Jrnv7NNhn1eGNqUYS3qwdxiypPeW/6j
        rSIAdhu9HgDrfmjq0mwJJZ7M0EzfY6cvzHJvYVomrUnJQFxA/1PRRaJMtYIkOKjv
        T3oaFzbF6kyMsDdqKQHICCzpn3iaSrTrTYcgWC8nFzZt+N6u2HT5wUtGiGk1NQHP
        b3xv2vHtO3amFPLXBG7Ns1bPKcvAEgcTPLyJZhDlxsAuyX314FxbOfTcpDi/23k1
        XU6+8hflfJzztEsBvYyAnrMYjj1ETxrXqM9q8cBlq9Q2J2LiGYe89nUc1fpxVNLK
        55OnG/kjco8SjmQ5rKLfV1qSa8+D60/dfUj1zvGWmMWlPxefu69HA==
X-ME-Sender: <xms:10BjXQGSpxfbAIpcIv70Rp73osgLgwxN3j51fLtu_XALTZVjFrIcjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghdpohiilhgrsg
    hsrdhorhhgnecukfhppedvtdefrdehjedrvdduhedrudejkeenucfrrghrrghmpehmrghi
    lhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:10BjXdkFl7e-VF5gE6JjtHG3ZC7-VDrfzqQd7gV1i9cvzy5Fmv7R6w>
    <xmx:10BjXVJgRS60gm0H1Ym9yue7ySzyFC-QVRALFQ-QyYuLrWCtJ2Ztqw>
    <xmx:10BjXWa4qv6pxmPO0zo4HSZcYcQGFhIBsjzPnvbqjsAHtffjx232iw>
    <xmx:2EBjXbNjGDuQGIz_Mc6dzbexqDPS-0-yUKkfvgRPIX6dE683ZlV97Q>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C828D6005D;
        Sun, 25 Aug 2019 22:15:47 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
Date:   Mon, 26 Aug 2019 11:46:19 +0930
Message-Id: <20190826021620.11915-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The example node in the binding uses the AST2500 compatible string for
the SD controller with a 64kiB ranges property, but the SD controller is
allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
the example to correctly reflect the hardware in the AST2500, however it
should be noted that the MMIO region is reduced to 64kiB in the AST2600
where a second SD controller block has been introduced into the address
space.

Also add the IBM copyright header that I left out of the initial patch.

Suggested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
Hi Ulf, this is the follow-up fix as discussed here:

http://patchwork.ozlabs.org/patch/1143090/

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 570f8c72662b..200de9396036 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2019 IBM Corp.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
@@ -84,7 +85,7 @@ examples:
             reg = <0x1e740000 0x100>;
             #address-cells = <1>;
             #size-cells = <1>;
-            ranges = <0 0x1e740000 0x10000>;
+            ranges = <0 0x1e740000 0x20000>;
             clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
 
             sdhci0: sdhci@100 {
-- 
2.20.1

