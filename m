Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CD38E1B9
	for <lists+linux-mmc@lfdr.de>; Mon, 24 May 2021 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhEXHeo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 May 2021 03:34:44 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:38581 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhEXHen (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 03:34:43 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14O7KFQR005012;
        Mon, 24 May 2021 15:20:15 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from slee-VirtualBox.localdomain (192.168.100.253) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 May 2021 15:33:09 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Date:   Mon, 24 May 2021 15:32:52 +0800
Message-ID: <20210524073308.9328-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14O7KFQR005012
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

AST2600-A2 EVB has the reference design for enabling SD bus
power and toggling SD bus signal voltage between 3.3v and 1.8v by
GPIO regulators.
This patch series adds sdhci node and gpio regulators in a new dts file
for AST2600-A2 EVB.
The description of the reference design of AST2600-A2 EVB is added
in the new dts file.

This patch also include a helper for updating AST2600 sdhci capability
registers.

Changes from v4:
* Move sdhci node and gpio regulator from aspeed-ast2600-evb-a2.dts
  to aspeed-ast2600-evb.dts. Now aspeed-ast2600-evb.dts only supports
  A2(or newer) evbs.
* Remove aspeed-ast2600-evb-a2.dts since sdhci nodes were moved to
  aspeed-ast2600-evb.dts.
* Add aspeed-ast2600-evb-a1.dts for A1 and A0 evbs.

Changes from v3:
* Remove the example of gpio regulator from dt-bindings.
* Add sdhci node and gpio regulators to a new dts file.
* Move the comment of the reference design to the new
  dts file.
* Modify commit message of sdhci-of-aspeed.c.
* Fix coding style issues of sdhci-of-aspeed.c.
* Remove the implementation of eMMC resetc since it has no relevance to
  the goal that this patch series want to achieve and it may needs further
  discussion about the design of reset behavior.

Changes from v2:
* Move the comment of the reference design from dt-bindings to device tree.
* Add clk-phase binding for eMMC controller.
* Reimplement aspeed_sdc_set_slot_capability().
* Separate the implementation of eMMC reset to another patch file.
* Fix yaml document error per the report of dt_binding_check and
  dtbs_check.

Changes from v1:
* Add the device tree example for AST2600 A2 EVB in dt-bindings
  document
* Add timing-phase for eMMC controller.
* Remove power-gpio and power-switch-gpio from sdhci driver, they should
  be handled by regulator.
* Add a helper to update capability registers in the driver.
* Sync sdhci settings from device tree to SoC capability registers.
* Sync timing-phase from device tree to SoC Clock Phase Control
  register

Please help to review.

Regards,
Steven

Steven Lee (4):
  ARM: dts: aspeed: ast2600evb: Add sdhci node and gpio regulator for A2
    evb.
  ARM: dts: aspeed: ast2600evb: Add phase correction for emmc
    controller.
  ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0.
  mmc: sdhci-of-aspeed: Configure the SDHCIs as specified by the
    devicetree.

 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 15 ++++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts    | 87 ++++++++++++++++++++-
 drivers/mmc/host/sdhci-of-aspeed.c          | 48 ++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts

-- 
2.17.1

