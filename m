Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B71B03D2
	for <lists+linux-mmc@lfdr.de>; Mon, 20 Apr 2020 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDTIE4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 Apr 2020 04:04:56 -0400
Received: from mail.nic.cz ([217.31.204.67]:42802 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgDTIEt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:49 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id DEB03140E7B;
        Mon, 20 Apr 2020 10:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587369885; bh=C+nd6WwPejsTEe2nk+2tSDaddFim/E6HKFWM7ee3e94=;
        h=From:To:Date;
        b=LvdTCkb1ktVrq0v/JoSwwKasnh2DmXJ3cRvpWidxLqTN/E6XLcOdUOLo8Z6Bv72aG
         Kqdyyji8xR3Rn7iK09Eyisz+CJ+jv/+J+wxDr/AA64DbqfnWznrXikSwc8YVZDBpis
         HAlGbU9tOoRT1rUhDqR73EKA6VxN7mpZIAS4jt1I=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] mmc: sdhci-xenon: fix annoying 1.8V regulator warning
Date:   Mon, 20 Apr 2020 10:04:44 +0200
Message-Id: <20200420080444.25242-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For some reason the Host Control2 register of the Xenon SDHCI controller
sometimes reports the bit representing 1.8V signaling as 0 when read
after it was written as 1. Subsequent read reports 1.

This causes the sdhci_start_signal_voltage_switch function to report
  1.8V regulator output did not become stable

When CONFIG_PM is enabled, the host is suspended and resumend many
times, and in each resume the switch to 1.8V is called, and so the
kernel log reports this message annoyingly often.

Do an empty read of the Host Control2 register in Xenon's
.voltage_switch method to circumvent this.

This patch fixes this particular problem on Turris MOX.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V...")
Cc: Zhoujie Wu <zjwu@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Konstantin Porotchkin <kostap@marvell.com>
Cc: Tomasz Maciej Nowak <tmn505@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mmc/host/sdhci-xenon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 1dea1ba66f7b..4703cd540c7f 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -235,6 +235,16 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 {
 	/* Wait for 5ms after set 1.8V signal enable bit */
 	usleep_range(5000, 5500);
+
+	/*
+	 * For some reason the controller's Host Control2 register reports
+	 * the bit representing 1.8V signaling as 0 when read after it was
+	 * written as 1. Subsequent read reports 1.
+	 *
+	 * Since this may cause some issues, do an empty read of the Host
+	 * Control2 register here to circumvent this.
+	 */
+	sdhci_readw(host, SDHCI_HOST_CONTROL2);
 }
 
 static const struct sdhci_ops sdhci_xenon_ops = {
-- 
2.24.1

