Return-Path: <linux-mmc+bounces-7749-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B660DB2475A
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Aug 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FB368752F
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Aug 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA42F531D;
	Wed, 13 Aug 2025 10:33:17 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FC2C1786
	for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081197; cv=none; b=hKRfurF7457XetxGGxa0oXk0OMyP9np6Ofywn2KLjdguvuWDJDaqa9og01lNRtqUA9wsDy15IIX639Wx/FVClTXv8gMClHgFrPFQPQyIGIpsAWSYYQB57oK87UJ8U/qDZZr5nU9fDokrx5oFGDnHm6k0WhDJCZpw5pdder+XdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081197; c=relaxed/simple;
	bh=WYmhFm6I7R5zNcYTJGatsoUIU/2CEqRTlAwa43oBz/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fiO7Cxs+0qqSlw48JFZxlgRNynkt71Wm2m9ScoVYM4c5l2wksRX08x58L03+dbORr6oJswlpmQ0vbT2scinSwixRJQ1H35EaZxuHZnPNPWK3pqofWvdSC3f+mCuNWrRMsnHIzNgN35C/kRHQlxw0BLfE9mEaxLj/NaHxsCLY1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1um8nA-0005st-BR; Wed, 13 Aug 2025 12:33:12 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1um8n9-0004gg-0L;
	Wed, 13 Aug 2025 12:33:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1um8n9-00FzLp-07;
	Wed, 13 Aug 2025 12:33:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v7 0/4] mmc: handle undervoltage events and prevent eMMC corruption
Date: Wed, 13 Aug 2025 12:33:06 +0200
Message-Id: <20250813103309.3810728-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

changes v7:
- Remove all usage of the redundant undervoltage_notify_registered flag
- Register undervoltage notifier in mmc_add_card() after setting card as
  present, for all supported cards.
- Unregister undervoltage notifier in mmc_remove_card() based on card presence
- Remove all unnecessary EXPORT_SYMBOL_GPL for functions only used within MMC
  core.
- Move all host claiming and releasing responsibility for undervoltage events
  into the bus_ops callback;
- add comment for host->undervoltage
- Squash undervoltage suspend preparation and handler into one patch.
- Use mmc_card_removed() in shutdown path instead of host->undervoltage.
- Remove redundant card presence check in undervoltage handler.
changes v6:
- Rewrite commit message to be more technical per reviewer feedback.
- Address race conditions by using __mmc_stop_host() instead of only
  claiming the host in the undervoltage handler.
- Move notifier registration from mmc_regulator_get_supply() to the end of
  a successful card initialization in mmc_attach_mmc(), ensuring it only
  runs for capable cards.
- Centralize notifier unregistration in mmc_remove_card() to correctly
  handle all card removal and error paths.
- Add 'undervoltage_notify_registered' flag to struct mmc_host to
  reliably track the notifier state.
- Consolidate multiple notifier callbacks into a single, generic handler.
- Remove premature notifier support for vqmmc and vqmmc2 regulators.
- Move INIT_WORK() for the undervoltage workqueue to mmc_alloc_host().
changes v5:
- Rebased on top of mmc/next after introduction of enum mmc_poweroff_type
- Replaced boolean undervoltage parameter with MMC_POWEROFF_UNDERVOLTAGE
- Dropped unused __mmc_resume() helper
- Updated commit messages accordingly
changes v4:
- drop HPI and SDHCI related patches

This patch set introduces a framework for handling undervoltage events
in the MMC subsystem. The goal is to improve system reliability by
ensuring graceful handling of power fluctuations that could otherwise
lead to metadata corruption, potentially rendering the eMMC chip
unusable or causing significant data loss.

## Problem Statement

Power fluctuations and sudden losses can leave eMMC devices in an
undefined state, leading to severe consequences. The worst case can
result in metadata corruption, making the entire storage inaccessible.
While some eMMC devices promise to handle such situations internally,
experience shows that some chip variants are still affected. This has
led vendors to take a more protective approach, implementing external
undervoltage handling as a precautionary measure to avoid costly field
failures and returns.

The existence of the "Power Off Notification" feature in the eMMC
standard itself serves as indirect evidence that this is a real-world
issue.  While some projects have already faced the consequences of
ignoring this problem (often at significant cost), specific cases cannot
be disclosed due to NDAs.

## Challenges and Implementation Approach

1. **Raising awareness of the problem**: While vendors have used
   proprietary solutions for years, a unified approach is needed upstream.
   This patch set is a first step in making that happen.

2. **Finding an acceptable implementation path**: There are multiple
   ways to handle undervoltage - either in the kernel or in user space,
   through a global shutdown mechanism, or using the regulator framework.
   This patch set takes the kernel-based approach but does not prevent
   future extensions, such as allowing user-space handoff once available.

3. **Preparing for vendor adoption and testing**: By providing a
   structured solution upstream, this patch set lowers the barrier for
   vendors to standardize their undervoltage handling instead of relying on
   fragmented, out-of-tree implementations.

## Current Limitations

This patch set is an initial step and does not yet cover all possible
design restrictions or edge cases. Future improvements may include
better coordination with user space and enhancements based on broader
testing.

## Testing Details

The implementation was tested on an iMX8MP-based system. The board had
approximately 100ms of available power hold-up time. The Power Off
Notification was sent ~4ms after the board was detached from the power
supply, allowing sufficient time for the eMMC to handle the event
properly.  Tests were conducted under both idle conditions and active
read/write operations.

Oleksij Rempel (2):
  mmc: core: Add infrastructure for undervoltage handling
  mmc: core: add undervoltage handler for MMC/eMMC devices

 drivers/mmc/core/bus.c       | 12 ++++++
 drivers/mmc/core/core.c      | 25 ++++++++++++
 drivers/mmc/core/core.h      |  2 +
 drivers/mmc/core/host.c      |  2 +
 drivers/mmc/core/mmc.c       | 71 +++++++++++++++++++++++++++++++--
 drivers/mmc/core/regulator.c | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 14 +++++++
 7 files changed, 200 insertions(+), 3 deletions(-)

--
2.39.5


