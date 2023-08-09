Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D603C7767B1
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Aug 2023 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjHIS4D (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Aug 2023 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHIS4D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 14:56:03 -0400
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 11:56:02 PDT
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C6E51;
        Wed,  9 Aug 2023 11:56:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0459DFB08;
        Wed,  9 Aug 2023 20:50:30 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wj_B-az9m8JC; Wed,  9 Aug 2023 20:50:27 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v1 0/5] Device tree and config updates for the Librem 5 devkit
Date:   Wed,  9 Aug 2023 20:50:09 +0200
Message-Id: <cover.1691606520.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The device tree updates ensure the A53 don't get powered off and fix a
DT warning. This isn't testable with the arm64 default config unless we
enable the rsi wifi modules too so do this as well.

While at that include two binding file updates.

This is against next-20230809 that include David's option,gtm601
conversion.

Guido Günther (5):
  dt-bindings: sound: gtm601: Add description
  dt-bindings: mmc: Fix reference to pwr-seq-simple
  arm64: dts: imx8mq-librem5-devkit: Mark buck2 as always on
  arm64: dts: imx8mq-librem5-devkit: Drop power-supply
  arm64: defconfig: Enable Redpine 91X wlan driver

 .../devicetree/bindings/mmc/mmc-controller.yaml    |  2 +-
 .../devicetree/bindings/sound/option,gtm601.yaml   |  6 ++++--
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   | 14 +++++---------
 arch/arm64/configs/defconfig                       |  1 +
 4 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.40.1

